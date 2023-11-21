Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A157F31F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjKUPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjKUPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:08:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C1A9A;
        Tue, 21 Nov 2023 07:08:11 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da37522a363so5315856276.0;
        Tue, 21 Nov 2023 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700579290; x=1701184090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5kXeUZxl0n8jZUXvoDWX0N3dXRmZvV6vzKsfNwrock=;
        b=T4/z8z57Xz4Bz4NtppxLVST+zvh7A6C4CASn0qNtj5aqlE8bWW6JiFS3nqPNkSc1rP
         WFxxCVoWhYUi+eX42Ntq3SaYNHTO3uGwPIqIY62j5DhQ0XDMU1U1OV/TZ7aSk9QUmdeA
         8wBmqCHp8GDvanDD3rAcZciPj/iUD4/UplMXFgRf0lj+gqSM9HGucIeG7++Ivcn6Egx+
         ME72gaaFnuh+p2KS0NtYUrJF5+KVK0O8uCNA7AHBzVTO7cLJsco+DXfYo1E6sA/1BAZo
         0/s7ezWYCBZKTfc6Ryr6I6aDd7MZlBKEsrhJV4JBOCj7/nSyhBJ/nDG2aosjnG1tkQtS
         hNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579290; x=1701184090;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5kXeUZxl0n8jZUXvoDWX0N3dXRmZvV6vzKsfNwrock=;
        b=K32L4dSuA1PoH+jNAUFH/ECnGOV3agF8eKA9m5EQBKT1j7Mp+05x5aaamzye64X2sZ
         Nbqx0ZPDAFkB8bzfy1DG+kfEVWylmLF6hHHqBvqIhZmr/uo4QNDBX2YWEHM4S/T/q0zN
         yVRQDKiP/t+W9OZ3ZprT/klp7m5WDeqtBWkWIOkgATdd9SU644PJxwf4JRiNEE12yKI2
         TUiFzhv8zlqxFZvDPsfH2FtJdakDo0V2fw2dbauvoT725pZqkofqai4VGbCPK1myxYDy
         8fi+vHI1bnv8q9U5rJ1StWoiJZIvzmxAmAGc2+9jMqQlubr83cRN1K11dSuz2hPhEcEK
         DiJg==
X-Gm-Message-State: AOJu0YyoHpck2+O458YjErJf6afcqYQuRbx510z0XtmSnhR8HDeDWSTU
        sVgFqoGnADiIT5tc8jlHoxBMSWMizYbK9xuARQ==
X-Google-Smtp-Source: AGHT+IEmENhX7kKPX20b34IoiBD9PEriJ+16Q1elwbSjgqsLD1BDATvXkEnfa2wCx/3nsnoEAFr5IraZyWQfS+hpJhs=
X-Received: by 2002:a25:888b:0:b0:d9a:5666:7ab5 with SMTP id
 d11-20020a25888b000000b00d9a56667ab5mr10077485ybl.10.1700579290491; Tue, 21
 Nov 2023 07:08:10 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 21 Nov 2023 16:07:58 +0100
Message-ID: <CACkBjsaecr+VjmfOHzaMbiei5G3WMDjvjp4kZVE79Bn8ib1-Rg@mail.gmail.com>
Subject: [Bug Report] bpf: reg invariant voilation after JSLE
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following program (reduced) breaks reg invariant:

C Repro: https://pastebin.com/raw/SRQJYx91

-------- Verifier Log --------
func#0 @0
0: R1=ctx() R10=fp0
0: (b7) r0 = -2                       ; R0_w=-2
1: (37) r0 /= 1                       ; R0_w=scalar()
2: (bf) r8 = r0                       ; R0_w=scalar(id=1) R8_w=scalar(id=1)
3: (56) if w8 != 0xfffffffe goto pc+4         ;
R8_w=scalar(id=1,smin=0x80000000fffffffe,smax=0x7ffffffffffffffe,umin=umin32=0xfffffffe,umax=0xfffffffffffffffe,smin32=-2,smax32=-2,umax32=0xfffffffe,var_off=(0xfffffffe;
0xffffffff00000000))
4: (65) if r8 s> 0xd goto pc+3        ;
R8_w=scalar(id=1,smin=0x80000000fffffffe,smax=13,umin=umin32=0xfffffffe,umax=0xfffffffffffffffe,smin32=-2,smax32=-2,umax32=0xfffffffe,var_off=(0xfffffffe;
0xffffffff00000000))
5: (b7) r4 = 2                        ; R4_w=2
6: (dd) if r8 s<= r4 goto pc+1
REG INVARIANTS VIOLATION (false_reg1): range bounds violation
u64=[0xfffffffe, 0xd] s64=[0xfffffffe, 0xd] u32=[0xfffffffe, 0xd]
s32=[0x3, 0xfffffffe] var_off=(0xfffffffe, 0x0)
6: R4_w=2 R8_w=0xfffffffe
7: (cc) w8 s>>= w0                    ; R0=0xfffffffe R8=scalar()
8: (77) r0 >>= 32                     ; R0_w=0
9: (57) r0 &= 1                       ; R0_w=0
10: (95) exit

from 6 to 8: safe

from 4 to 8: safe

from 3 to 8: safe
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1


Besides, the verifier enforces the return value of some prog types to
be zero, the bug may lead to programs with arbitrary values loaded.

Best
Hao Sun
