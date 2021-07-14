;TP-BUG-A
;2716:2K-EPROM
;0000-07FF: TPBUG(2K)
;0800-0FFF: PROM1(2K)
;1000-17FF: PROM2(2K)
;1800-1FFF: UNUSED
;2000-27FF: RAM(2K)
;2800-2FFF: RAM(2K)
;3000-37FF: UNUSED-EXT(2K)
;3800-3FFF: UNUSED-EXT(2K)

;Address:0000-07FF(2047)
;EntryPoint:0000

;0000-00F3: RESTR
;00F4-0122: DISUP
;0128-0591: CCS1-CCS12
;0592-05B5: DISUPR
;05B6-060B: DECKY
;060C-07A4: SAVER URI
;07A6-07FF: SEGPT


;------------------RESTR------------
entry_point:
                di
                xor     a
                ld      hl, 2FDDh
                jp      loc_89

int_8:                                  
                ld      (2FD9h), sp
                push    af
                nop
                jr      loc_13
int_10:
		        jp 2fc4h

loc_13:                                 
                call    sub_60C
                jr      loc_1B
int_18:
		        jp 2fc7h

loc_1B:                                 
                ;ld      a, (ix+0FEh)
                ld      a, (ix-2)
                jr      loc_23
int_20:
		        jp 2fcah 
loc_23:                                 
                or      a
                jr      nz, loc_33
                jr      loc_2B
int_28:
		        jp 2fcdh 

loc_2B:                                 
                ;dec     (ix+0FFh)
                dec     (ix-1)
                jr      loc_33
int_30:
		        jp 2fd0h 

loc_33:                                                          
                ;dec     (ix+0FEh)
                dec     (ix-2)
                jr      loc_3B

int_38:         jp 2fd3h 

loc_3B:                                 
                                        
                call    sub_672
                jr      z, PostInit_A4

loc_40:                                 
                ld      a, (ix+2)
                cp      0CFh 
                jr      z, loc_4E
                ld      l, (ix+1)
                ld      h, (ix+0)
                ld      (hl), a

loc_4E:                                 
                call    sub_67C
                jr      nz, loc_40

loc_53:                                 
                ld      ix, 2FF7h
                ld      hl, (2fd9h)
                ld      c, 3
                jr      loc_62

loc_5E:                                 
                inc     ix
                inc     ix

loc_62:                                 
                dec     hl
                ld      a, (hl)
                jr      loc_81
                ld      (2fd9h), sp
                push    af
                call    sub_60C
                ld      a, (2ff4h)
                or      a
                jp      z, loc_3B
                xor     a
                ld      (2ff4h), a
                call    sub_672
                jr      z, loc_53
                jp      loc_14B

loc_81:                                 
                call    sub_63C
                dec     c
                jr      nz, loc_5E
                jr      loc_C9

loc_89:                                 
                ld      (hl), a
                inc     hl
                ld      (hl), a
                ld      a, 0CFh
                ld      (2fd3h), a
                ld      hl, 2FB8h
                ld      (2fd9h), hl
                ld      sp, 2FA0h
                jr      loc_9D
                rst     8

loc_9D:                                 
                ld      a, 3
                out     (86h), a
                call    sub_684

PostInit_A4:                                                                         
                ld      a, 11h

loc_A6:                                 
                ld      (2fffh), a

loc_A9:                                 
                                        
                ld      hl, 2FEFh
                xor     a
                ld      b, 8

loc_AF:                                 
                ld      (hl), a
                inc     hl
                djnz    loc_AF
                ld      (2fdbh), hl
                ld      a, (2fffh)
                ld      (hl), a
                ld      a, 10h
                ld      b, 6

loc_BE:                                 
                inc     hl
                ld      (hl), a
                djnz    loc_BE
                in      a, (90h)
                bit     5, a
                jp      z, 800h	;Call PROM PROGRAM

loc_C9:                                                                        
                call    sub_592

loc_CC:                                 
                call    ScanKeys_5B6
                jr      nz, loc_C9
                call    sub_5F9
                ld      a, b
                cp      10h
                jr      nc, loc_10B
                ld      hl, (2fdbh)
                ld      (hl), b
                ld      a, l
                cp      0F8h 
                ld      hl, 2FF5h
                jr      z, loc_FC
                cp      0FAh
                ld      hl, 2FF6h
                jr      z, loc_FC
                cp      0FEh 
                jr      z, loc_FF
                jr      loc_F6
loc_F2: 
                rst     38h
loc_F3:
                rst     38h
;------------------RESTR------------
;------------------DISUP------------
;00F4H:
                jr      loc_C9

loc_F6:                                 
                                        
                ld      hl, (2fdbh)
                inc     hl
                jr      loc_106

loc_FC:                                 
                                        
                inc     (hl)
                jr      loc_F6

loc_FF:                                 
                call    sub_2E7
                ld      hl, (2fdbh)
                dec     hl

loc_106:                                
                ld      (2fdbh), hl
                jr      loc_C9

loc_10B:                                
                sub     10h
                add     a, a
                ld      c, a
                ld      b, 0
                ld      a, (2fffh)
                bit     0, a
                ld      hl, 562h
                jr      nz, loc_11E
                ld      hl, 57Ah

loc_11E:                               
                add     hl, bc
                ld      e, (hl)
                inc     hl
                jr      loc_125
;------------------DISUP------------
;------------------CCS1-CCS12-------
                jr      loc_CC

loc_125:                                
                ld      d, (hl)
                ex      de, hl
                jp      (hl)
;---------------------------------------
;EXEC-KEY:
                ld      a, (2ff2h)
                or      a
                jr      nz, ProcessMon_1A3
                xor     a
                out     (8Ch), a
                ld      a, (2ff6h)
                or      a
                jr      z, loc_144
                call    UR2

loc_13A:                                
                ld      ix, (2fd9h)
                ;ld      (ix+0FEh), l
                ;ld      (ix+0FFh), h
                ld      (ix-2), l
                ld      (ix-1), h

loc_144:                                
                call    sub_672
                jr      nz, loc_179
                jr      loc_161

loc_14B:                                
                ld      ix, 2FDFh

loc_14F:                                
                ld      h, (ix+0)
                ld      l, (ix+1)
                ld      a, (hl)
                ld      c, 0CFh 
                ld      (hl), c
                ld      (ix+2), a
                call    sub_67C
                jr      nz, loc_14F

loc_161:                                
                ld      a, 4
                out     (8Ch), a
                ld      a, 45h 
                out     (86h), a
                ld      a, 1
                out     (86h), a
                jr      loc_186
;-------------------------------
;MON Key:
                ld      a, (2ff2h)
                or      a
                jr      nz, ProcessMon_1A3
                xor     a
                ld      (2fdeh), a

loc_179:                                
                ld      a, 1
                ld      (2ff4h), a
                ld      a, 7
                out     (86h), a
                ld      a, 0Bh
                out     (86h), a
loc_186:                                
                pop     iy
                pop     ix
                pop     hl
                pop     de
                pop     bc
                pop     af
                ex      af, af'
                exx
                pop     af
                ld      i, a
                pop     hl
                pop     de
                pop     bc
                ld      a, (2fddh)
                or      a
                jp      nz, loc_1A0
                pop     af
                di
                ret

loc_1A0:                                
                pop     af
                ei
                ret
;----------MON-END------------

ProcessMon_1A3:                                
                                        
                jp      PostInit_A4
;-----------------------------
                ld      a, 12h
                jp      loc_A6
                ld      a, (2ff3h)
                or      a
                jp      nz, loc_411
                call    UR2
                ld      a, (2ff1h)
                or      a
                jr      nz, loc_202

loc_1BB:                                
                                        
                inc     hl
                inc     hl

loc_1BD:                                
                dec     hl
                ld      a, (2ff2h)
                bit     0, a
                jr      nz, loc_1EF
                bit     3, a
                jr      z, ProcessMon_1A3
                jr      loc_1DC

loc_1CB:                                
                set     3, a
                ld      (2ff2h), a
                ld      a, (ix+4)
                call    sub_380
                or      (ix+5)
                ld      (2feeh), a

loc_1DC:                                
                ld      a, (2feeh)
                cp      (hl)
                ld      a, (2ff2h)
                jr      z, loc_1EB
                bit     2, a
                jr      nz, loc_1EF
                jr      loc_1BB

loc_1EB:                               
                bit     1, a
                jr      z, loc_1BB

loc_1EF:                                
                ld      a, h
                call    sub_63C
                inc     ix
                inc     ix
                ld      a, l
                call    sub_63C
                inc     ix
                inc     ix
                ld      a, (hl)
                jr      loc_20E

loc_202:                                
                ld      c, h
                inc     c
                ld      a, c
                call    sub_63C
                ld      ix, 2FFBh
                in      a, (c)

loc_20E:                                
                call    sub_63C
                jr      loc_279
                call    UR2
                jr      loc_1BD
                ld      a, 1
                ld      (2ff0h), a
                ld      hl, 7E5h
                call    sub_389
                ld      a, 12h
                ld      (ix+1), a
                jr      loc_23A
                ld      a, 1
                ld      (2fefh), a
                ld      hl, 7D5h
                call    sub_389
                ld      a, e
                cp      6
                jr      c, loc_240

loc_23A:                                
                ld      a, (hl)
                call    sub_282
                jr      loc_273

loc_240:                                
                cp      3
                jr      z, loc_26D
                cp      2
                jr      z, loc_25B
                ld      a, (hl)
                ld      ix, 2FFBh
                ld      (2fdbh), ix
                call    sub_63C
                inc     hl
                ld      a, (hl)
                call    sub_27C
                jr      loc_279

loc_25B:                                
                ld      a, (2fd9h+1)
                call    sub_27C
                ld      a, (2fd9h)
                call    sub_282
                ld      (2fdbh), ix
                jr      loc_279

loc_26D:                                
                ld      a, (2fddh)
                call    sub_282

loc_273:                                
                ld      hl, 2FFDh
                ld      (2fdbh), hl

loc_279:                                
                                        
                jp      loc_C9

sub_27C:                                
                                        
                ld      ix, 2FF9h
                jr      loc_286


sub_282:                                
                                        
                ld      ix, 2FFBh

loc_286:                                
                call    sub_63C
                ret


                ld      a, (2ff6h)
                or      a
                jr      z, loc_279
                ld      (2ff2h), a
                call    UR2
                ld      a, (hl)

loc_297:                                
                call    sub_282
                inc     ix
                inc     ix
                ld      (2fdbh), ix
                jr      loc_279
                ld      a, (2ff6h)
                or      a
                jr      z, loc_2C7
                call    UR2
                call    sub_672
                jr      z, loc_2BD
                ld      a, b
                cp      5
                jp      z, PostInit_A4

loc_2B8:                                
                call    sub_67C
                jr      nz, loc_2B8

loc_2BD:                                
                ld      a, (2fdeh)
                inc     a
                ld      (ix+0), h
                ld      (ix+1), l

loc_2C7:                                
                ld      (2fdeh), a

loc_2CA:                                
                jp      loc_C9
                ld      a, (2ff5h)
                cp      1
                jr      nz, loc_2CA
                ld      (2ff1h), a
                ld      a, 10h
                ld      (2ff9h), a
                ld      (2ffah), a
                call    UR2
                ld      c, h
                in      a, (c)
                jr      loc_297

sub_2E7:                               

                ld      ix, 2FF7h
                ld      a, (2ff1h)
                or      a
                jr      nz, loc_315
                ld      a, (2fefh)
                or      a
                jr      nz, loc_326
                ld      a, (2ff0h)
                or      a
                jr      nz, loc_36E
                ld      a, (2ff2h)
                or      a
                jr      z, loc_36A
                call    UR2
                ld      a, (ix+6)
                call    sub_380
                or      (ix+7)
                ld      (hl), a
                ld      a, (hl)

loc_311:                                
                                        
                call    sub_282
                ret

loc_315:                                
                call    UR2
                ld      a, (ix+6)
                call    sub_380
                or      (ix+7)
                ld      c, h
                out     (c), a
                jr      loc_311

loc_326:                                
                ld      hl, 7D5h
                call    sub_389
                ld      a, e
                cp      6
                jr      c, loc_33D
                ld      a, (ix+6)
                call    sub_380
                or      (ix+7)
                ld      (hl), a
                jr      loc_311

loc_33D:                                
                cp      3
                jr      z, loc_360
                cp      2
                jr      z, loc_36A
                ld      a, (ix+4)
                call    sub_380
                or      (ix+5)
                inc     hl
                ld      (hl), a
                call    sub_27C
                ld      a, (ix+4)
                call    sub_380
                or      (ix+5)
                dec     hl
                ld      (hl), a
                jr      loc_311

loc_360:                                
                ld      a, (2ffeh)
                ld      (2fddh), a
                ld      (2ffch), a
                ret

loc_36A:                               
                                        
                pop     hl
                jp      loc_A9

loc_36E:                                
                ld      hl, 7E5h
                call    sub_389
                ld      a, (ix+6)
                call    sub_380
                or      (ix+7)
                ld      (hl), a
                jr      loc_311

sub_380:                                
                                        
                sla     a
                sla     a
                sla     a
                sla     a
                ret
sub_389:                                
                                        
                ld      ix, 2FF7h
                ld      e, (ix+0)
                ld      b, 0
                ld      d, b
                add     hl, de
                ld      c, (hl)
                ld      a, c
                cp      19h
                jr      z, loc_36A
                ld      hl, (2fd9h)
                or      a
                sbc     hl, bc
                ret

                call    UR2
                push    hl
                ld      hl, 2EFFh
                pop     de
                push    de
                push    hl
                xor     a
                sbc     hl, de
                push    hl
                pop     bc
                pop     de
                push    de
                pop     hl
                dec     hl
                lddr
                pop     hl
                ld      (hl), a
                inc     hl
                jp      loc_1EF
                ld      a, 1
                ld      (2ff3h), a
                call    UR2
                push    hl
                pop     bc
                push    hl
                ld      hl, 2000h
                ld      de, 1000h

loc_3CD:                                
                ld      a, 25h
                out     (86h), a
                ld      a, 0CBh
                out     (86h), a
                ld      a, 80h
                out     (8Ch), a
                ldi
                ld      a, 0
                out     (8Ch), a
                ld      a, 3
                out     (86h), a
                jp      pe, loc_3CD
                pop     bc
                ld      hl, 2000h
                ld      de, 1000h


loc_3ED:                                
                ld      a, (de)
                cpi
                jr      nz, loc_3F8
                jp      po, loc_A9
                inc     de
                jr      loc_3ED

loc_3F8:                                
                push    af
                push    bc
                push    de
                exx
                pop     de
                pop     bc
                ld      a, d
                ld      ix, 2FF7h
                call    sub_63C
                ld      a, e
                call    sub_27C
                pop     af
                call    sub_282
                jp      loc_C9


loc_411:                                
                exx
                inc     de
                jr      loc_3ED
                im      2
                ld      hl, 0FFFh
                ld      b, 20h

loc_41C:                                
                                        
                dec     l
                jr      nz, loc_41C
                dec     h
                jr      nz, loc_41C
                djnz    loc_41C

loc_424:                                
                call    sub_758
                sub     3Ah
                jr      nz, loc_424
                ld      c, a
                call    sub_6DB
                ld      b, a
                call    sub_6DB
                ld      d, a
                call    sub_6DB
                ld      e, a
                call    sub_6DB
                dec     a
                push    af
                jr      z, loc_446

loc_43F:                                
                call    sub_6DB
                ld      (de), a
                inc     de
                djnz    loc_43F

loc_446:                                
                call    sub_6DB
                xor     a
                add     a, c
                jr      z, loc_45D
                ld      a, d
                ld      ix, 2FF7h
                call    sub_63C
                ld      a, e
                call    sub_27C
                pop     af
                jp      loc_C9

loc_45D:                                
                pop     af
                jr      nz, loc_424
                jp      loc_A9
                ld      a, 4
                jp      loc_46A
                ld      a, 2

loc_46A:                                
                push    af
                ld      a, 11h
                ld      (2fffh), a
                call    UR2
                pop     af
                jp      loc_1CB
                im      2
                ld      a, 1
                ld      (2feeh), a
                ld      bc, 7FAh
                ld      a, b
                ld      i, a
                ld      a, c
                out     (84h), a
                ld      a, 85h
                out     (85h), a
                ld      a, 1Ah
                out     (85h), a
                ld      a, (2fc0h)
                ld      d, a
                ld      a, (2fc1h)
                ld      e, a
                ld      a, (2fc2h)
                ld      h, a
                ld      a, (2fc3h)
                ld      l, a
                xor     a
                sbc     hl, de
                inc     hl
                push    hl
                ld      hl, 2E00h
                ld      b, 3
                ei

loc_4AA:                                
                halt
                dec     l
                jr      nz, loc_4AA
                dec     h
                jr      nz, loc_4AA
                djnz    loc_4AA

loc_4B3:                                
                ld      a, 3Ah
                call    sub_6F7
                xor     a
                ld      bc, 10h
                pop     hl
                sbc     hl, bc
                jr      nc, loc_4CA
                add     hl, bc
                add     a, l
                ld      b, a
                ld      l, 0
                jr      z, loc_504
                jr      loc_4CB

loc_4CA:                                
                ld      b, c

loc_4CB:                                
                push    hl
                ld      c, 0
                ld      a, b
                call    sub_6D5
                ld      a, (2fc0h)
                ld      h, a
                call    sub_6D5
                ld      a, (2fc1h)
                ld      l, a
                call    sub_6D5
                xor     a
                call    sub_6D5

loc_4E4:                                
                ld      a, (hl)
                call    sub_6D5
                inc     hl
                djnz    loc_4E4
                sub     a
                sub     c
                call    sub_6D5
                ld      a, 0Dh
                call    sub_6D5
                ld      a, 0Ah
                call    sub_6D5
                ld      a, h
                ld      (2fc0h), a
                ld      a, l
                ld      (2fc1h), a
                jr      loc_4B3

loc_504:                                
                ld      b, 3

loc_506:                                
                xor     a
                ld      c, a
                call    sub_6D5
                djnz    loc_506
                ld      a, 1
                call    sub_6D5
                sub     a
                sub     c
                call    sub_6D5
                ld      hl, 0FFFFh
                ei
                halt

loc_51C:                                
                dec     l
                jr      nz, loc_51C
                dec     h
                jr      nz, loc_51C
                di
                ld      a, 3
                out     (85h), a
                jp      loc_A9
                ld      hl, 530h

loc_52D:                                
                jp      loc_13A
                push    ix
                pop     bc
                push    iy
                pop     hl
                inc     hl
                push    hl
                pop     de
                inc     de
                ld      a, c
                sub     e
                ld      e, a
                ld      (hl), a
                ld      a, b
                sbc     a, d
                ld      ix, 2FF7h
                call    sub_63C
                ld      a, e
                call    sub_282
                jp      loc_C9
                ld      hl, (2fbeh)
                jr      loc_52D
                ld      hl, (2fbch)
                jr      loc_52D
                ld      hl, (2fbah)
                jr      loc_52D
                ld      hl, (2fb8h)
                jr      loc_52D
                jr      z, loc_565
                ld      l, a

loc_565:                                
                ld      bc, 1A3h
                and     (hl)
                ld      bc, 1ABh
                inc     de
                ld      (bc), a
                ld      hl, (8A02h)
                ld      (bc), a
                and     h
                ld      (bc), a
                call    0A102h
                inc     bc
                cp      h
                inc     bc
                ld      h, e
                inc     b
                ld      l, b
                inc     b
                and     e
                ld      bc, 1A6h
                dec     d
                inc     b
                ld      (hl), a
                inc     b
                jr      loc_58A
                db 2Ah, 5

loc_58A:                                
                ld      c, (hl)
                dec     b
                ld      d, e
                dec     b
                ld      e, b
                dec     b
                ld      e, l
                dec     b
;------------------CCS1-CCS12-------
;------------------DISUPR-----------
sub_592:                                
                ld      de, 7A6h
                ld      hl, 2FF7h
                ld      b, 20h

loc_59A:                                
                push    de
                ld      a, (hl)
                add     a, e
                ld      e, a
                jr      nc, loc_5A1
                inc     d

loc_5A1:                                
                ld      a, (de)
                out     (88h), a
                ld      a, b
                out     (8Ch), a
                ld      e, 7Dh

loc_5A9:                                
                dec     e
                jr      nz, loc_5A9
                pop     de
                bit     0, b
                ret     nz
                inc     hl
                srl     b
                jr      loc_59A
                di
;------------------DISUPR-----------
;------------------DECKY------------
;5B6-60B: DECKEY
ScanKeys_5B6:                                
                ld      a, 7Fh
                out     (88h), a
                ld      a, 3Fh  
                out     (8Ch), a
                in      a, (90h)
                and     1Fh
                cp      1Fh
                jr      z, loc_5DE
                call    sub_64F
                ld      c, 8Ch
                ld      b, 1

KeyDown1_5CD:                                
                out     (c), b
                in      a, (90h)
                and     1Fh
                cp      1Fh
                jr      nz, KeyDown2_5E0
                sla     b
                ld      a, 40h
                cp      b
                jr      nz, KeyDown1_5CD

loc_5DE:                                
                or      a
                ret

KeyDown2_5E0:                                
                ld      c, 0

KeyDown3_5E2:                                
                dec     c
                srl     b
                jr      nz, KeyDown3_5E2
                sla     c
                sla     c
                sla     c
                sla     c
                add     a, c
                ld      hl, 7B9h	;KEYTABLE

KeyDown4_5F3:                                
                cp      (hl)
                ret     z
                inc     hl
                inc     b
                jr      KeyDown4_5F3

sub_5F9:                                

                push    af

loc_5FA:                                
                in      a, (90h)
                and     1Fh
                cp      1Fh
                jr      nz, loc_5FA
                jr      loc_607
                jp      loc_3ED

loc_607:                                
                call    sub_64F
                pop     af
                ret
;------------------DECKY------------
;------------------SAVER-URI--------
sub_60C:                                
                                        
                pop     af
                push    bc
                push    af
                pop     bc
                ld      a, 3
                out     (86h), a
                ld      a, i
                di
                push    de
                push    hl
                push    af
                ex      af, af'
                exx
                push    af
                push    bc
                push    de
                push    hl
                push    ix
                push    iy
                ld      ix, (2fd9h)
                inc     ix
                inc     ix
                ld      (2fd9h), ix
                ;ld      a, (ix+0F4h)
                ld      a, (ix-12)
                and     4
                ld      (2fddh), a
                exx
                push    bc
                exx
                ret


sub_63C:                                
                ld      b, a
                and     0Fh
                ld      (ix+1), a
                ld      a, b
                srl     a
                srl     a
                srl     a
                srl     a
                ld      (ix+0), a
                ret

sub_64F:                                
                ld      hl, 0AFFh

loc_652:                                
                dec     l
                jr      nz, loc_652
                dec     h
                jr      nz, loc_652
                ret

UR2:                                
                ld      ix, 2FF7h
                ld      a, (ix+0)
                call    sub_380
                or      (ix+1)
                ld      h, a
                ld      a, (ix+2)
                call    sub_380
                or      (ix+3)
                ld      l, a
                ret

sub_672:                                
                ld      ix, 2FDFh
                ld      a, (2fdeh)
                or      a
                ld      b, a
                ret

sub_67C:                                
                inc     ix
                inc     ix
                inc     ix
                dec     b
                ret

sub_684:                                
                ld      hl, 6AAh  ;ref 06AA: 10H 10H 10H 10H 10H 10H 8 0 1
                ld      de, 2FF7h
                ld      a, 1
                ld      (de), a
                ld      b, 9

loc_68F:                                
                push    bc
                push    de
                ld      bc, 9
                ldir
                dec     de
                ld      (de), a
                ld      b, 20h

loc_69A:                                
                push    bc
                call    sub_592
                pop     bc
                djnz    loc_69A
                pop     de
                ld      a, (de)
                ld      hl, 2FF8h
                pop     bc
                djnz    loc_68F
                ret
;-----------------------------------------
loc_6AA:
                db  10h, 10h, 10h, 10h, 10h, 10h
                db  8, 0, 1 ;Display 801?

sub_6B3:                                
                sub     30h
                cp      0Ah
                ret     m
                sub     7
                ret


sub_6BB:                               
                and     0Fh
                add     a, 90h
                daa
                adc     a, 40h
                daa
                ret

loc_6C4:                                
                exx
                push    af
                rrca
                rrca
                rrca
                rrca
                call    sub_6F4
                pop     af
                and     0Fh
                call    sub_6F4
                exx
                ret

sub_6D5:                                

                push    af
                add     a, c
                ld      c, a
                pop     af
                jr      loc_6C4

sub_6DB:                               
                push    bc
                call    sub_758
                call    sub_6B3
                rlca
                rlca
                rlca
                rlca
                ld      c, a
                call    sub_758
                call    sub_6B3
                or      c
                pop     bc
                push    af
                add     a, c
                ld      c, a
                pop     af
                ret

sub_6F4:                                
                call    sub_6BB

sub_6F7:                                
                ei
                ld      d, a
                ld      a, 10h
                ld      l, 0Ah
                rl      d

loc_6FF:                                
                cp      1
                jr      nz, loc_6FF
                ld      b, a
                ld      a, 0
                ld      (2feeh), a
                ld      a, b

loc_70A:                                
                halt
                scf
                rr      d
                dec     l
                jr      nz, loc_718
                ld      a, 1
                ld      (2feeh), a
                di
                ret

loc_718:                                
                cp      1
                jr      nz, loc_718
                bit     0, d
                jr      nz, loc_729
                ld      b, a
                ld      a, 0
                ld      (2feeh), a
                ld      a, b
                jr      loc_70A

loc_729:                                
                ld      b, a
                ld      a, 1
                ld      (2feeh), a
                ld      a, b
                jr      loc_70A
; ------------------------------------------------

                dec     a
                jr      nz, loc_755
                ld      ix, 2FEEh
                bit     0, (ix+0)
                jr      nz, loc_74B
                ld      a, 85h
                out     (85h), a
                ld      a, 34h
                out     (85h), a
                ld      a, 8
                jr      loc_755

loc_74B:                                
                ld      a, 85h 
                out     (85h), a
                ld      a, 1Ah
                out     (85h), a
                ld      a, 10h

loc_755:                                
                ei
                reti


sub_758:                                
                ld      hl, 7FEh
                ld      a, h
                ld      i, a
                ld      a, l
                out     (84h), a

loc_761:                                
                ld      b, 8
                ei
                xor     a
                ld      h, 0

loc_767:                               
                in      a, (90h)
                bit     7, a
                jr      nz, loc_767
                ld      a, 0A5h
                out     (87h), a
                ld      a, 0Dh
                out     (87h), a
                ld      a, 0A5h
                out     (87h), a
                ld      a, 1Ah
                out     (87h), a
                halt
                bit     7, a
                jr      nz, loc_796

loc_782:                                
                halt
                and     80h
                or      h
                ld      h, a
                djnz    loc_7A1
                bit     7, a
                jr      z, loc_796
                di
                ld      a, 3
                out     (87h), a
                ld      a, h
                and     7Fh
                ret

loc_796:                               
                ld      a, 3
                out     (87h), a
                jr      loc_761
                in      a, (90h)
                ei
                reti

loc_7A1:                                
                rrc     h
                jr      loc_782

                db  3Fh ;CCF
;------------------SAVER-URI--------
;------------------SEGPT------------
;07A6H:
;SEG_7:                
                db  40h ;'0'
                db  79h ;'1'
                db  24h ;'2'
                db  30h ;'3'
                db  19h ;'4'
                db  12h ;'5'
                db  02h ;'6'
                db  78h ;'7'
                db  00h ;'8'
                db  18h ;'9'
                db  08h ;'A'
                db  03h ;'B'
                db  46h ;'C'
                db  21h ;'D'
                db  06h ;'E'
                db  0Eh ;'F'
                db  7Fh ;' '
                db 0Ch 
                db 5Fh 
                
;KEYTBL:07B9H
                db 0FFh ;0
                db 0EFh ;1
                db 0F7h ;2
                db 0FBh ;3
                db 0DFh ;4
                db 0E7h ;5
                db 0EBh ;6
                db 0CFh ;7
                db 0D7h ;8
                db 0DBh ;9
                db 0DDh ;A
                db 0EDh ;B
                db 0FDh ;C
                db 0Dh ;D
                db 0Bh ;E
                db 07h ;F
                db 0Eh ;EXEC
                db 0FEh;STEP
                db 0EEh;MON
                db 0DEh;MON'
                db 0CDh
                db 0CBh
                db 0C7h
                db 0BFh
                db 0BDh
                db 0BBh, 0B7h, 0AFh, 19h
                db 02h, 02h
                db 0Ch, 16h, 18h, 0Bh, 9, 0Ah, 19h, 3, 5, 6, 7, 8, 4
                db 19h, 19h, 19h, 19h, 19h, 19h, 19h
                db 13h, 14h, 19h, 0Dh, 0Fh, 10h, 11h, 12h, 0Eh
                db 19h, 19h, 19h
                db 0D6h, 2Fh, 32h, 7, 3, 8, 9Ch, 7
;------------------SEGPT------------
; ===========================================================================
;RAM:2000                         ; Segment type: Regular
;RAM:2000                                         segment RAM
;RAM:2000                                         org 2000h

;RAM:2FB8 ?? ??                   word_2FB8:      ds 2                    
;RAM:2FBA ?? ??                   word_2FBA:      ds 2                    
;RAM:2FBC ?? ??                   word_2fBC:      ds 2                    
;RAM:2FBE ?? ??                   word_2FBE:      ds 2                    
;RAM:2FC0 ??                      byte_2FC0:      ds 1                    
;RAM:2FC1 ??                      byte_2FC1:      ds 1                    
;RAM:2FC2 ??                      byte_2FC2:      ds 1                    
;RAM:2FC3 ??                      byte_2FC3:      ds 1                    
;RAM:2FD3 ??                      byte_2FD3:      ds 1                    
;RAM:2FD9 ?? ??                   word_2FD9:      ds 2                    
;RAM:2FDB ?? ??                   word_2FDB:      ds 2                    
;RAM:2FDD ??                      byte_2FDD:      ds 1                    
;RAM:2FDE ??                      byte_2FDE:      ds 1                    
;RAM:2FEE ??                      byte_2FEE:      ds 1                    
;RAM:2FEF ??                      byte_2FEF:      ds 1                   
;RAM:2FF0 ??                      byte_2FF0:      ds 1                    
;RAM:2FF1 ??                      byte_2FF1:      ds 1                    
;RAM:2FF2 ??                      byte_2FF2:      ds 1                    
;RAM:2FF3 ??                      byte_2FF3:      ds 1                    
;RAM:2FF4 ??                      byte_2FF4:      ds 1                   
;RAM:2FF5 ??                      byte_2FF5:      ds 1                    
;RAM:2FF6 ??                      byte_2FF6:      ds 1                    
;RAM:2FF9 ??                      byte_2FF9:      ds 1                    
;RAM:2FFA ??                      byte_2FFA:      ds 1                    
;RAM:2FFC ??                      byte_2FFC:      ds 1                    
;RAM:2FFE ??                      byte_2FFE:      ds 1                    
;RAM:2FFF ??                      byte_2FFF:      ds 1                   

