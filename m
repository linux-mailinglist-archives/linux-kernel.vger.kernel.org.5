Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20357F2DD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjKUM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjKUM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:57:13 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E96D4D;
        Tue, 21 Nov 2023 04:57:09 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da041ffef81so5495043276.0;
        Tue, 21 Nov 2023 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700571428; x=1701176228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KaNbwqPl61g5/VVIpWWsVaeAPw/KN3S1vGwln5onZww=;
        b=Rhi2T9V2Cys87iWNYNZK+K8ZZdgZ9bwbqG1rVsk/iyK21JY0RifkrQS6G028pcWMC9
         EHZ2tQCLp67268d1p+reoQp50STTAV4G/pppOk4OUdTsqfqRmnIe0cU4QwcrVVLQ8SrL
         k+cmsj5Bn0Wb1zompdVJCfw268T6Usy2UMVbiUdwhxdgUC+ym+ITGDzL8RpKveQ4BB2l
         YO4/ebdR75yMUO0fYHn9h6zLeJdZj02qnpxvRTclKooFWy4RnA+QevIyEVfph2YQSsfg
         Xm/+rXNrgF1Aw72YST+fK8eG6D3fPWY2PaP8zerZKLYkO35Gm2gevMCh8ASQR8vDqTSq
         brHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571428; x=1701176228;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaNbwqPl61g5/VVIpWWsVaeAPw/KN3S1vGwln5onZww=;
        b=KBm1/zyeJb+Co36jY6IttTp58BcwXgTq6k+0gqdQEpmVZ5T2/Mj1xAErFVuXWiPHVI
         IgXm9loF7IWUTrhzZKDk7cH2IBPA1FQm8rNucz262FXhzyCzJTzwHJD39SjCe5lBrGey
         +ktz4Ae+2f40vQAwmvgS0KU9d6HoNqp7xxBOvjhm6GjUUZHJTVgzzheurso6jZ3mr4HC
         sol35t0hYgmeo7sjJknyZ/vnNP3kuhJCtoDGWJfRj3BhTUHfVOmwOroMtnEpUk5l6KaA
         3+c27kUG3B0/dHQXRlDo+JeIiAOVqyWsf0gx8SlkvToBQXCo92qILtljg2EZvhDsuIia
         bYHw==
X-Gm-Message-State: AOJu0Yzo7Ph6yyqy9eWX2fmiY2EjM7pCZ8g8lnnEKuOTXYr/mBZ4/WgI
        HM3BR6s/5slzsb3slaQ4EuReIVC7qc7nysjp9g==
X-Google-Smtp-Source: AGHT+IGfNhwTGxo8LYoNckdS9ICyemegXlAyksTPkCTGbXBAMuzZ1k/cgzsDU0l85YGFcTycAYm1kykUN6dbqykhXHc=
X-Received: by 2002:a25:a565:0:b0:da0:c49a:5fe4 with SMTP id
 h92-20020a25a565000000b00da0c49a5fe4mr10432141ybi.24.1700571428454; Tue, 21
 Nov 2023 04:57:08 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 21 Nov 2023 13:56:57 +0100
Message-ID: <CACkBjsZ-M=1Yj2PQZM7JN4=9rnDLP36fVO35o9fuAvAMKe=9Nw@mail.gmail.com>
Subject: [Bug Report] bpf: reg invariant voilation after JSET
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following program (reduced) breaks reg invariant:

C Repro: https://pastebin.com/raw/FmM9q9D4

-------- Verifier Log --------
func#0 @0
0: R1=ctx() R10=fp0
0: (18) r8 = 0x3d                     ; R8_w=61
2: (85) call bpf_ktime_get_ns#5       ; R0_w=scalar()
3: (ce) if w8 s< w0 goto pc+1         ; R0_w=scalar(smax32=61) R8_w=61
4: (95) exit

from 3 to 5: R0_w=scalar(smin=0x800000000000003e,smax=0x7fffffff7fffffff,umin=smin32=umin32=62,umax=0xffffffff7fffffff,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff)) R8_w=61 R10=fp0
5: R0_w=scalar(smin=0x800000000000003e,smax=0x7fffffff7fffffff,umin=smin32=umin32=62,umax=0xffffffff7fffffff,umax32=0x7fffffff,var_off=(0x0;
0xffffffff7fffffff)) R8_w=61 R10=fp0
5: (45) if r0 & 0xfffffff7 goto pc+2
REG INVARIANTS VIOLATION (false_reg1): range bounds violation
u64=[0x3e, 0x8] s64=[0x3e, 0x8] u32=[0x3e, 0x8] s32=[0x3e, 0x8]
var_off=(0x0, 0x8)
5: R0_w=scalar(var_off=(0x0; 0x8))
6: (dd) if r0 s<= r8 goto pc+1
REG INVARIANTS VIOLATION (false_reg1): range bounds violation
u64=[0x0, 0x8] s64=[0x3e, 0x8] u32=[0x0, 0x8] s32=[0x0, 0x8]
var_off=(0x0, 0x8)
6: R0_w=scalar(var_off=(0x0; 0x8)) R8_w=61
7: (bc) w1 = w0                       ; R0=scalar(var_off=(0x0; 0x8))
R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=8,var_off=(0x0; 0x8))
8: (95) exit

from 6 to 8: safe

from 5 to 8: safe
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1

The tnum after #5 is correct, but the ranges are incorrect, which seems a bug in
reg_bounds_sync().  Thoughts?

Best
Hao Sun
