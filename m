Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A887D4FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjJXMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjJXMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:40:19 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C749B;
        Tue, 24 Oct 2023 05:40:16 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ca471cf3aso4179720276.2;
        Tue, 24 Oct 2023 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698151215; x=1698756015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcX/hzD8Y49+eJmQWvIVcsdqZ9oYpriIwYpFUDDsetQ=;
        b=J9sxkL+OBITSat+TBJnLa5JCL0OhZRvyrJgu/ujpp0g93UPZdM501yDifn8/NHdNAb
         ZscD0aXs2MNa5E6FxqKP5DmlehhaBOj05kFBW2TV01FXYYwvo+ALBV6lDfQe+NWm4ZhG
         SZY1ivcCou+XV0/ulmtcWfjZArZPw8bp7zHHxevUFRtgA2JNNnd5nhqwywbwRxBcDzGf
         UjCIIS16iGjNGQeMgewXlcbpO+cAbTjld2U9+plszx6B5GheychQZO7VfLMUs/HpZL5R
         5aaTncmbeKnTcoAhkZHp9K+2s3g4oqeD/RCu+0za56M1sYsHSxodEgmY7QysSJYB/dGN
         TD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698151215; x=1698756015;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcX/hzD8Y49+eJmQWvIVcsdqZ9oYpriIwYpFUDDsetQ=;
        b=Dc0qJdC3LEgOpC3RN6ENdKwqS+9aIkH8mEDzBidPiwza84pqHXnuFcOEohyvm5Qrn9
         G1s/mAXdYXFJYaASP0kcTGBM7QcgV2HBKzP2H1y/9VVBez7i0Cm0lbeMVSkBPYJp1Hlh
         KBkibNJQdazlWm9ESH/OWAEfLxFPTyBenqfpJFndIZXT3rRJz6RkxVC7XbZFZf6ScDja
         0pwotU31bJN6d4xAX4HwweLS45Qxwp2Y56KsRLvDiyJwtjdPjmqW3/O6+aGaYDxW/e9A
         RxY+AHp8MKybE90hKrVSBePcUy1UJcuEHvHi/fk8GWiAbw2BWBORDduXCOokt+pHI9/X
         ZZFg==
X-Gm-Message-State: AOJu0Ywk8eUAAEOn5ijcaB8t413RyxgnSrLLv9L1aXFfly60dwX+PlT5
        cZJEgaGgGAN8apFTF5ZMSgtic0B6oalpYz0Txw==
X-Google-Smtp-Source: AGHT+IET+uxJlGG5mYbUi3JeAKjIz21/jFr8kdJKn9wJU2XBeEh08Yqbn4/31c/YsVUEGKvmAZfW3jfOq7DkulfUQUM=
X-Received: by 2002:a25:8703:0:b0:d9a:eed7:d034 with SMTP id
 a3-20020a258703000000b00d9aeed7d034mr11327640ybl.8.1698151215094; Tue, 24 Oct
 2023 05:40:15 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 24 Oct 2023 14:40:04 +0200
Message-ID: <CACkBjsY2q1_fUohD7hRmKGqv1MV=eP2f6XK8kjkYNw7BaiF8iQ@mail.gmail.com>
Subject: bpf: shift-out-of-bounds in tnum_rshift()
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following program can trigger a shift-out-of-bounds in
tnum_rshift(), called by scalar32_min_max_rsh():

0: (bc) w0 = w1
1: (bf) r2 = r0
2: (18) r3 = 0xd
4: (bc) w4 = w0
5: (bf) r5 = r0
6: (bf) r7 = r3
7: (bf) r8 = r4
8: (2f) r8 *= r5
9: (cf) r5 s>>= r5
10: (a6) if w8 < 0xfffffffb goto pc+10
11: (1f) r7 -= r5
12: (71) r6 = *(u8 *)(r1 +17)
13: (5f) r3 &= r8
14: (74) w2 >>= 30
15: (1f) r7 -= r5
16: (5d) if r8 != r6 goto pc+4
17: (c7) r8 s>>= 5
18: (cf) r0 s>>= r0
19: (7f) r0 >>= r0
20: (7c) w5 >>= w8         # shift-out-bounds here
21: exit

After load:
================================================================================
UBSAN: shift-out-of-bounds in kernel/bpf/tnum.c:44:9
shift exponent 255 is too large for 64-bit type 'long long unsigned int'
CPU: 2 PID: 8574 Comm: bpf-test Not tainted
6.6.0-rc5-01400-g7c2f6c9fb91f-dirty #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8e/0xb0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x15a/0x2f0 lib/ubsan.c:387
 tnum_rshift.cold+0x17/0x32 kernel/bpf/tnum.c:44
 scalar32_min_max_rsh kernel/bpf/verifier.c:12999 [inline]
 adjust_scalar_min_max_vals kernel/bpf/verifier.c:13224 [inline]
 adjust_reg_min_max_vals+0x1936/0x5d50 kernel/bpf/verifier.c:13338
 do_check kernel/bpf/verifier.c:16890 [inline]
 do_check_common+0x2f64/0xbb80 kernel/bpf/verifier.c:19563
 do_check_main kernel/bpf/verifier.c:19626 [inline]
 bpf_check+0x65cf/0xa9e0 kernel/bpf/verifier.c:20263
 bpf_prog_load+0x110e/0x1b20 kernel/bpf/syscall.c:2717
 __sys_bpf+0xfcf/0x4380 kernel/bpf/syscall.c:5365
 __do_sys_bpf kernel/bpf/syscall.c:5469 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5467 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5467
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x5610511e23cd
Code: 24 80 00 00 00 48 0f 42 d0 48 89 94 24 68 0c 00 00 b8 41 01 00
00 bf 05 00 00 00 ba 90 00 00 00 48 8d b44
RSP: 002b:00007f5357fc7820 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000095 RCX: 00005610511e23cd
RDX: 0000000000000090 RSI: 00007f5357fc8410 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007f5357fca458 R09: 00007f5350005520
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002b
R13: 0000000d00000000 R14: 000000000000002b R15: 000000000000002b
 </TASK>

If remove insn #20, the verifier gives:
 -------- Verifier Log --------
 func#0 @0
 0: R1=ctx(off=0,imm=0) R10=fp0
 0: (bc) w0 = w1                       ;
R0_w=scalar(smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
R1=ctx(off=0,
 imm=0)
 1: (bf) r2 = r0                       ;
R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
0xffffffff))
 R2_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
 2: (18) r3 = 0xd                      ; R3_w=13
 4: (bc) w4 = w0                       ;
R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
0xffffffff))
 R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
 5: (bf) r5 = r0                       ;
R0_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
0xffffffff))
 R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
 6: (bf) r7 = r3                       ; R3_w=13 R7_w=13
 7: (bf) r8 = r4                       ;
R4_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
0xffffffff))
 R8_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0; 0xffffffff))
 8: (2f) r8 *= r5                      ;
R5_w=scalar(id=1,smin=0,smax=umax=4294967295,var_off=(0x0;
0xffffffff))
 R8_w=scalar()
 9: (cf) r5 s>>= r5                    ; R5_w=scalar()
 10: (a6) if w8 < 0xfffffffb goto pc+9         ;
R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,
 umin32=4294967291,var_off=(0xfffffff8; 0xffffffff00000007))
 11: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
 12: (71) r6 = *(u8 *)(r1 +17)         ; R1=ctx(off=0,imm=0)
R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,
 var_off=(0x0; 0xff))
 13: (5f) r3 &= r8                     ;
R3_w=scalar(smin=umin=smin32=umin32=8,smax=umax=smax32=umax32=13,var_off=(0x8;
 0x5)) R8_w=scalar(smin=-9223372032559808520,umin=4294967288,smin32=-5,smax32=-1,umin32=4294967291,var_off=(0xffff)
 14: (74) w2 >>= 30                    ;
R2_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=3,var_off=(0x0;
0x3))
 15: (1f) r7 -= r5                     ; R5_w=scalar() R7_w=scalar()
 16: (5d) if r8 != r6 goto pc+3        ;
R6_w=scalar(smin=umin=umin32=4294967288,smax=umax=umax32=255,smin32=-8,smax32=-1,
 var_off=(0xfffffff8; 0x7))
R8_w=scalar(smin=umin=4294967288,smax=umax=255,smin32=-5,smax32=-1,umin32=4294967291)
 17: (c7) r8 s>>= 5                    ; R8_w=134217727
 18: (cf) r0 s>>= r0                   ; R0_w=scalar()
 19: (7f) r0 >>= r0                    ; R0=scalar()
 20: (95) exit

 from 16 to 20: safe

 from 10 to 20: safe
 processed 22 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1
-------- End of Verifier Log --------

In adjust_scalar_min_max_vals(), src_reg.umax_value is 7, thus pass
the check here:
         if (umax_val >= insn_bitness) {
             /* Shifts greater than 31 or 63 are undefined.
              * This includes shifts by a negative number.
              */
             mark_reg_unknown(env, regs, insn->dst_reg);
             break;
         }

However in scalar32_min_max_rsh(), both src_reg->u32_min_value and
src_reg->u32_max_value is 134217727, causing tnum_rsh() shit by 255.

Should we check if(src_reg->u32_max_value < insn_bitness) before calling
scalar32_min_max_rsh(), rather than only checking umax_val? Or, is it
because issues somewhere else, incorrectly setting u32_min_value to
34217727

Best
Hao Sun
