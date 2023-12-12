Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52480ED5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjLLNWl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjLLNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:22:22 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C294D44;
        Tue, 12 Dec 2023 05:22:04 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-590a21e977aso136746eaf.1;
        Tue, 12 Dec 2023 05:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387323; x=1702992123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJRNMY2mgce2G8fTxJIV4o/oS0aPFFROU79dw6RrvHE=;
        b=w4kKejQqsbQqCfHaH6UlJfGR8O73mznAvQM/xwu28SJkbVQWpnMHQ96U9j0dHaB10s
         eLW0XuhgNdarK3NDSCcxFekoza3DiIoSayvrBfVnzRhRIW62JrP1bxEVxLFl4lDdbewT
         mPBv8kT2mHTHwWCTjzrcJ1IfZMgZNOTeO758/65jAoxKbrQRwaI3OEKLe8Zux5m1sOYD
         nXOjsJ9PWzwPe5z2V4perJlyLpjdIxLq8qk6iS0mACUzFwGuUzgyrUogFj3wnj9ZvFks
         RONoAXVsB0fUJ8WNBKirDrYC6Anufl4D48LTNJsoAPk5IS4Qob9XT95u9Fv4l7HM2rld
         byaw==
X-Gm-Message-State: AOJu0YxreywMS7UcYScpW+QlgoiqnDpLeQw8zZjPwmn8UgmJ42pVXOif
        lszq1CNSdxAkmVk+YcSkOBx0miWZfUQd3h0rdfA=
X-Google-Smtp-Source: AGHT+IHhWlmsDDYMljaU6EnzphIooMeofMwaBh9MQx8vPKpJW24QQo1ZQ2fpdwO1qzYJULB0XVeBTMlYLeOZ8/6VS90=
X-Received: by 2002:a4a:da02:0:b0:590:8a57:8012 with SMTP id
 e2-20020a4ada02000000b005908a578012mr10340186oou.0.1702387323330; Tue, 12 Dec
 2023 05:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-7-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-7-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:21:52 +0100
Message-ID: <CAJZ5v0gUp9DrzSnSdDYq36YGqKGTc3-fu1PN74WSC8-6fj3rKw@mail.gmail.com>
Subject: Re: [PATCH 6/7] cpuidle: Handle TIF_NR_POLLING on behalf of
 CPUIDLE_FLAG_POLLING_HARD states
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:32 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> The current handling of TIF_NR_POLLING is a bit of a maze:
>
> 1) A common brief part in the generic idle loop sets TIF_NR_POLLING
>   while cpuidle selects an appropriate state and the tick is evaluated
>   and then stopped. Summary: One pair of set/clear
>
> 2) The state cpuidle is then called with TIF_NR_POLLING cleared but if
>   the state polls on need_resched() (software or hardware), it sets
>   again TIF_NR_POLLING and clears it when it completes. Summary: another
>   pair of set/clear
>
> 3) goto 1)
>
> However those costly atomic operations, fully ordered RmW for some of
> them, could be avoided if the cpuidle core knew in advance if the target
> state polls on need_resched(). If so, TIF_NR_POLLING could simply be
> set once before entering the idle loop and cleared once after idle loop
> exit.
>
> Start dealing with that with handling TIF_NR_POLLING on behalf of
> CPUIDLE_FLAG_POLLING_HARD states.
>
> [fweisbec: _ Handle broadcast properly
>            _ Ignore mwait_idle() as it can be used by default_idle_call()]
>
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/include/asm/mwait.h |  3 +--
>  drivers/cpuidle/cpuidle.c    | 22 +++++++++++++++++++-
>  include/linux/sched/idle.h   |  7 ++++++-
>  kernel/sched/idle.c          | 40 +++++++++++++-----------------------
>  4 files changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 920426d691ce..3634d00e5c37 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -116,7 +116,7 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
>   */
>  static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
>  {
> -       if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
> +       if (static_cpu_has_bug(X86_BUG_MONITOR) || !need_resched()) {
>                 if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
>                         mb();
>                         clflush((void *)&current_thread_info()->flags);
> @@ -134,7 +134,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
>                         }
>                 }
>         }
> -       current_clr_polling();
>  }
>
>  /*
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 737a026ef58a..49078cc83f4a 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -213,10 +213,10 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>                                  int index)
>  {
>         int entered_state;
> -
>         struct cpuidle_state *target_state = &drv->states[index];
>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>         ktime_t time_start, time_end;
> +       bool polling;
>
>         instrumentation_begin();
>
> @@ -236,6 +236,23 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>                 broadcast = false;
>         }
>
> +       polling = target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
> +
> +       /*
> +        * If the target state doesn't poll on need_resched(), this is
> +        * the last check after which further TIF_NEED_RESCHED remote setting
> +        * will involve an IPI.
> +        */
> +       if (!polling && current_clr_polling_and_test()) {
> +               if (broadcast)
> +                       tick_broadcast_exit();
> +               dev->last_residency_ns = 0;
> +               local_irq_enable();
> +               instrumentation_end();
> +               return -EBUSY;
> +       }
> +
> +
>         if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>                 leave_mm(dev->cpu);
>
> @@ -335,6 +352,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>                 dev->states_usage[index].rejected++;
>         }
>
> +       if (!polling)
> +               __current_set_polling();
> +
>         instrumentation_end();
>
>         return entered_state;
> diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
> index 478084f9105e..50c13531f5d8 100644
> --- a/include/linux/sched/idle.h
> +++ b/include/linux/sched/idle.h
> @@ -68,6 +68,8 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
>
>  static __always_inline bool __must_check current_clr_polling_and_test(void)
>  {
> +       bool ret;
> +
>         __current_clr_polling();
>
>         /*
> @@ -76,7 +78,10 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
>          */
>         smp_mb__after_atomic();
>
> -       return unlikely(tif_need_resched());
> +       ret = unlikely(tif_need_resched());
> +       if (ret)
> +               __current_set_polling();
> +       return ret;
>  }
>
>  #else
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 565f8374ddbb..4e554b4e3781 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -94,11 +94,12 @@ void __cpuidle default_idle_call(void)
>                 stop_critical_timings();
>
>                 ct_cpuidle_enter();
> -               arch_cpu_idle();
> +               arch_cpu_idle(); // XXX assumes !polling
>                 ct_cpuidle_exit();
>
>                 start_critical_timings();
>                 trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +               __current_set_polling();
>         }
>         local_irq_enable();
>         instrumentation_end();
> @@ -107,31 +108,14 @@ void __cpuidle default_idle_call(void)
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
>                                struct cpuidle_device *dev)
>  {
> +       int ret;
> +
>         if (current_clr_polling_and_test())
>                 return -EBUSY;
>
> -       return cpuidle_enter_s2idle(drv, dev);
> -}
> -
> -static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> -                     int next_state)

Since you are removing call_cpuidle(), you may as well remove
call_cpuidle_s2idle() which only has one caller anyway.

> -{
> -       /*
> -        * The idle task must be scheduled, it is pointless to go to idle, just
> -        * update no idle residency and return.
> -        */
> -       if (current_clr_polling_and_test()) {
> -               dev->last_residency_ns = 0;
> -               local_irq_enable();
> -               return -EBUSY;
> -       }
> -
> -       /*
> -        * Enter the idle state previously returned by the governor decision.
> -        * This function will block until an interrupt occurs and will take
> -        * care of re-enabling the local interrupts
> -        */
> -       return cpuidle_enter(drv, dev, next_state);
> +       ret = cpuidle_enter_s2idle(drv, dev);
> +       __current_set_polling();
> +       return ret;
>  }
>
>  /**
> @@ -198,7 +182,7 @@ static void cpuidle_idle_call(void)
>                 tick_nohz_idle_stop_tick();
>
>                 next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> -               call_cpuidle(drv, dev, next_state);
> +               cpuidle_enter(drv, dev, next_state);
>         } else {
>                 bool stop_tick = true;
>
> @@ -212,7 +196,12 @@ static void cpuidle_idle_call(void)
>                 else
>                         tick_nohz_idle_retain_tick();
>
> -               entered_state = call_cpuidle(drv, dev, next_state);
> +               /*
> +                * Enter the idle state previously returned by the governor decision.
> +                * This function will block until an interrupt occurs and will take
> +                * care of re-enabling the local interrupts.
> +                */
> +               entered_state = cpuidle_enter(drv, dev, next_state);
>                 /*
>                  * Give the governor an opportunity to reflect on the outcome
>                  */
> @@ -220,7 +209,6 @@ static void cpuidle_idle_call(void)
>         }
>
>  exit_idle:
> -       __current_set_polling();
>
>         /*
>          * It is up to the idle functions to reenable local interrupts
> --
> 2.42.1
>
