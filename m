Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78027D7855
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjJYXCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:02:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E3A116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:02:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507c5249d55so331777e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1698274923; x=1698879723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbr8iJME5urol0U1nO3DOVDoIlMdwbtF6gaeh8We4Fo=;
        b=GDpBPsRfuuFC9E1vECeet1s0P0wQ2gxx1FwHxq31/51D2+kv+/+tF5+3W6hD8O+eN2
         LnADN5A4L0COxHZIddryvVZJKjtkdjO+oxHDWgdIEBpA9Ks9RZXWN+S8NkhK3/KD1Qy5
         JsCTX1VK/FJVN/fHFT0IsHFXfJI/CYVPd1eJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698274923; x=1698879723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbr8iJME5urol0U1nO3DOVDoIlMdwbtF6gaeh8We4Fo=;
        b=SppnHVExD2R9Vfbs+NQZoSUgqQqXiTJu4PEcbYVJI7XFRFeIFPWsPfUKaRP+wOC8lZ
         NksUl8ETx6FyBJntsN952p25U+f1mXNPq9oZgJvV/Y+jRbnF8vy/lhXI5C7wawTBsVlT
         msudGZphAj3yRrlaGBFoFbeQa9UbU/G6sWM2lF/nV1XYU4MDY+1vH7u79E4U9Unn/B0g
         wxCjpj9ls2/cGNym3nb1DyG5XRKwg4sO9Ls7XBHJVyUaH/LKQEAoXtVmiMHGiRAfcw6r
         5I/Z5wDZmY1nEqOOQpr+w8a3wLMSZRS0HeTNv4LQm9CbvsiI9e1WEBdNlr9BG6fifENp
         jNoA==
X-Gm-Message-State: AOJu0YxD1yuYS4iKRH1w6tsuqnJS+0419dHFtq7f9RenY/dVvkUvx4sz
        O81Cjp9e8vnSMP1mgOTwgccpq8cP8fb+FmVWgj/n
X-Google-Smtp-Source: AGHT+IGglrTa3+Ra8gRLa675pZ81FNyUHTdA2oTwPNQHhgAkt0L2QnRNa1mg7AxXt7UAl3gaaTOQWFp7rBml+eSN4zA=
X-Received: by 2002:a05:6512:1382:b0:500:adbd:43e9 with SMTP id
 fc2-20020a056512138200b00500adbd43e9mr14618582lfb.15.1698274922209; Wed, 25
 Oct 2023 16:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 25 Oct 2023 16:01:50 -0700
Message-ID: <CAOnJCUKH0muFHWujXEqJtb4Uv6Kfh5DeJeR2qg9vj7Kc5w43dw@mail.gmail.com>
Subject: Re: [RFC 00/12] riscv: Introduce Pseudo NMI
To:     Xu Lu <luxu.kernel@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, dengliang.1214@bytedance.com,
        liyu.yukiteru@bytedance.com, sunjiadong.lff@bytedance.com,
        xieyongji@bytedance.com, lihangjing@bytedance.com,
        chaiwen.cc@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 1:29=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Sorry to resend this patch series as I forgot to Cc the open list before.
> Below is formal content.
>
> The existing RISC-V kernel lacks an NMI mechanism as there is still no
> ratified resumable NMI extension in RISC-V community, which can not
> satisfy some scenarios like high precision perf sampling. There is an
> incoming hardware extension called Smrnmi which supports resumable NMI
> by providing new control registers to save status when NMI happens.
> However, it is still a draft and requires privilege level switches for
> kernel to utilize it as NMIs are automatically trapped into machine mode.
>
> This patch series introduces a software pseudo NMI mechanism in RISC-V.
> The existing RISC-V kernel disables interrupts via per cpu control
> register CSR_STATUS, the SIE bit of which controls the enablement of all
> interrupts of whole cpu. When SIE bit is clear, no interrupt is enabled.
> This patch series implements NMI by switching interrupt disable way to
> another per cpu control register CSR_IE. This register controls the
> enablement of each separate interrupt. Each bit of CSR_IE corresponds
> to a single major interrupt and a clear bit means disablement of
> corresponding interrupt.
>
> To implement pseudo NMI, we switch to CSR_IE masking when disabling
> irqs. When interrupts are disabled, all bits of CSR_IE corresponding to
> normal interrupts are cleared while bits corresponding to NMIs are still
> kept as ones. The SIE bit of CSR_STATUS is now untouched and always kept
> as one.
>
> We measured performacne of Pseudo NMI patches based on v6.6-rc4 on SiFive
> FU740 Soc with hackbench as our benchmark. The result shows 1.90%
> performance degradation.
>
>   "hackbench 200 process 1000" (average over 10 runs)
>   +-----------+----------+------------+
>   |           | v6.6-rc4 | Pseudo NMI |
>   +-----------+----------+------------+
>   |   time    | 251.646s |  256.416s  |
>   +-----------+----------+------------+
>
> The overhead mainly comes from two parts:
>
>   1. Saving and restoring CSR_IE register during kernel entry/return.
>   This part introduces about 0.57% performance overhead.
>
>   2. The extra instructions introduced by 'irqs_enabled_ie'. It is a
>   special value representing normal CSR_IE when irqs are enabled. It is
>   implemented via ALTERNATIVE to adapt to platforms without PMU. This
>   part introduces about 1.32% performance overhead.
>

We had an evaluation of this approach earlier this year and concluded
with the similar findings.
The pseudo NMI is only useful for profiling use case which doesn't
happen all the time in the system
Adding the cost to the hotpath and sacrificing performance for
everything for something for performance profiling
is not desirable at all.

That's why, an SBI extension Supervisor Software Events (SSE) is under
development.
https://lists.riscv.org/g/tech-prs/message/515

Instead of selective disabling of interrupts, SSE takes an orthogonal
approach where M-mode would invoke a special trap
handler. That special handler will invoke the driver specific handler
which would be registered by the driver (i.e. perf driver)
This covers both firmware first RAS and perf use cases.

The above version of the specification is a bit out-of-date and the
revised version will be sent soon.
Clement(cc'd) has also done a PoC of SSE and perf driver using the SSE
framework. This resulted in actual saving
in performance for RAS/perf without sacrificing the normal performance.

Clement is planning to send the series soon with more details.

> Limits:
>
>   CSR_IE is now used for disabling irqs and any other code should
>   not touch this register to avoid corrupting irq status, which means
>   we do not support masking a single interrupt now.
>
>   We have tried to fix this by introducing a per cpu variable to save
>   CSR_IE value when disabling irqs. Then all operatations on CSR_IE
>   will be redirected to this variable and CSR_IE's value will be
>   restored from this variable when enabling irqs. Obviously this method
>   introduces extra memory accesses in hot code path.
>



> TODO:
>
>   1. The adaption to hypervisor extension is ongoing.
>
>   2. The adaption to advanced interrupt architecture is ongoing.
>
> This version of Pseudo NMI is rebased on v6.6-rc7.
>
> Thanks in advance for comments.
>
> Xu Lu (12):
>   riscv: Introduce CONFIG_RISCV_PSEUDO_NMI
>   riscv: Make CSR_IE register part of context
>   riscv: Switch to CSR_IE masking when disabling irqs
>   riscv: Switch back to CSR_STATUS masking when going idle
>   riscv: kvm: Switch back to CSR_STATUS masking when entering guest
>   riscv: Allow requesting irq as pseudo NMI
>   riscv: Handle pseudo NMI in arch irq handler
>   riscv: Enable NMIs during irqs disabled context
>   riscv: Enable NMIs during exceptions
>   riscv: Enable NMIs during interrupt handling
>   riscv: Request pmu overflow interrupt as NMI
>   riscv: Enable CONFIG_RISCV_PSEUDO_NMI in default
>
>  arch/riscv/Kconfig                 | 10 ++++
>  arch/riscv/include/asm/csr.h       | 17 ++++++
>  arch/riscv/include/asm/irqflags.h  | 91 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/processor.h |  4 ++
>  arch/riscv/include/asm/ptrace.h    |  7 +++
>  arch/riscv/include/asm/switch_to.h |  7 +++
>  arch/riscv/kernel/asm-offsets.c    |  3 +
>  arch/riscv/kernel/entry.S          | 18 ++++++
>  arch/riscv/kernel/head.S           | 10 ++++
>  arch/riscv/kernel/irq.c            | 17 ++++++
>  arch/riscv/kernel/process.c        |  6 ++
>  arch/riscv/kernel/suspend_entry.S  |  1 +
>  arch/riscv/kernel/traps.c          | 54 ++++++++++++++----
>  arch/riscv/kvm/vcpu.c              | 18 ++++--
>  drivers/clocksource/timer-clint.c  |  4 ++
>  drivers/clocksource/timer-riscv.c  |  4 ++
>  drivers/irqchip/irq-riscv-intc.c   | 66 ++++++++++++++++++++++
>  drivers/perf/riscv_pmu_sbi.c       | 21 ++++++-
>  18 files changed, 340 insertions(+), 18 deletions(-)
>
> --
> 2.20.1
>


--
Regards,
Atish
