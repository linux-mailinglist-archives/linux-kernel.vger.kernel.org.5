Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C44779633
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjHKRfW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjHKRfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:35:20 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68930D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:35:15 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-563393b63dbso400909eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775315; x=1692380115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyrjd5PwgCetSiY9qfuPU69Xrj0DfnNhkc+eHpHg0hI=;
        b=E13KW+4spJOpscRAMgdnd4G/cmshknGuydXiezx42OO0ORWOl8UfXvkiDwq4dxdYDM
         fviJfQXqLYvcKpxInCtHpdFLRuRACrH8CAD53ZMTsur+JqcZ/y071pTf4V2o8OdWQ54I
         hNxk0k1kBFw7L0PZlYN8s39U4dff5yQacf8NTtW8LHtZT2rlH/Eyb84szM7PaeaB5022
         5/k2wvN7jA5bkXn51gB8ax9FdUn4UYTZQfYaEdQs+tAiyMzsChOhdWxK9uQTPONirjlL
         OIZQhEFnQGZdA5Txc0UkkftKZlOi/SMISzVgxrKP9j1X88S2MHPbkUDQzzvhzO2Y4vPr
         v/bA==
X-Gm-Message-State: AOJu0YyiI+QznJbnQPcY+ax77s/EHLOfxGuePu23OHXhTI/SyxE7mflE
        MfZlBt7u+4DmP443f5f2vzI7PjeBh55dPxdIuik=
X-Google-Smtp-Source: AGHT+IFNo2Fl3mTLYHyh+Dkb585Fxzo2y8ONsrXM1UF21KTAohtN+yUSHktEwdiM/H4VkCkUoYOKwhM4KoI8FTvZBZ8=
X-Received: by 2002:a05:6820:1c07:b0:56c:484a:923d with SMTP id
 cl7-20020a0568201c0700b0056c484a923dmr1774998oob.1.1691775315083; Fri, 11 Aug
 2023 10:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-3-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-3-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:35:03 +0200
Message-ID: <CAJZ5v0gFUZPdo_Gj_AzSE6EV6XbS6vWoXi2pcnTSzs5AEJLbGQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] cpuidle: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 7:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> intel_idle_irq() re-enables IRQs very early. As a result, an interrupt
> may fire before mwait() is eventually called. If such an interrupt queues
> a timer, it may go unnoticed until mwait returns and the idle loop
> handles the tick re-evaluation. And monitoring TIF_NEED_RESCHED doesn't
> help because a local timer enqueue doesn't set that flag.
>
> The issue is mitigated by the fact that this idle handler is only invoked
> for shallow C-states when, presumably, the next tick is supposed to be
> close enough. There may still be rare cases though when the next tick
> is far away and the selected C-state is shallow, resulting in a timer
> getting ignored for a while.
>
> Fix this with using sti_mwait() whose IRQ-reenablement only triggers
> upon calling mwait(), dealing with the race while keeping the interrupt
> latency within acceptable bounds.
>
> Fixes: c227233ad64c (intel_idle: enable interrupts before C1 on Xeons)
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/include/asm/mwait.h | 11 +++++++++--
>  drivers/idle/intel_idle.c    | 19 +++++++------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 341ee4f1d91e..920426d691ce 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -124,8 +124,15 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>                 }
>
>                 __monitor((void *)&current_thread_info()->flags, 0, 0);
> -               if (!need_resched())
> -                       __mwait(eax, ecx);
> +
> +               if (!need_resched()) {
> +                       if (ecx & 1) {
> +                               __mwait(eax, ecx);
> +                       } else {
> +                               __sti_mwait(eax, ecx);
> +                               raw_local_irq_disable();
> +                       }
> +               }
>         }
>         current_clr_polling();
>  }
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 256c2d42e350..d676d32741da 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -131,11 +131,12 @@ static unsigned int mwait_substates __initdata;
>  #define MWAIT2flg(eax) ((eax & 0xFF) << 24)
>
>  static __always_inline int __intel_idle(struct cpuidle_device *dev,
> -                                       struct cpuidle_driver *drv, int index)
> +                                       struct cpuidle_driver *drv,
> +                                       int index, bool irqoff)
>  {
>         struct cpuidle_state *state = &drv->states[index];
>         unsigned long eax = flg2MWAIT(state->flags);
> -       unsigned long ecx = 1; /* break on interrupt flag */
> +       unsigned long ecx = 1*irqoff; /* break on interrupt flag */
>
>         mwait_idle_with_hints(eax, ecx);
>
> @@ -159,19 +160,13 @@ static __always_inline int __intel_idle(struct cpuidle_device *dev,
>  static __cpuidle int intel_idle(struct cpuidle_device *dev,
>                                 struct cpuidle_driver *drv, int index)
>  {
> -       return __intel_idle(dev, drv, index);
> +       return __intel_idle(dev, drv, index, true);
>  }
>
>  static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>                                     struct cpuidle_driver *drv, int index)
>  {
> -       int ret;
> -
> -       raw_local_irq_enable();
> -       ret = __intel_idle(dev, drv, index);
> -       raw_local_irq_disable();
> -
> -       return ret;
> +       return __intel_idle(dev, drv, index, false);
>  }
>
>  static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
> @@ -184,7 +179,7 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
>         if (smt_active)
>                 native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
>
> -       ret = __intel_idle(dev, drv, index);
> +       ret = __intel_idle(dev, drv, index, true);
>
>         if (smt_active)
>                 native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
> @@ -196,7 +191,7 @@ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
>                                        struct cpuidle_driver *drv, int index)
>  {
>         fpu_idle_fpregs();
> -       return __intel_idle(dev, drv, index);
> +       return __intel_idle(dev, drv, index, true);
>  }
>
>  /**
> --
> 2.34.1
>
