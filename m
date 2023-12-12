Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36E80ED8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjLLN2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 08:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346522AbjLLN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:27:47 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63525D65;
        Tue, 12 Dec 2023 05:27:50 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-590a21e977aso137318eaf.1;
        Tue, 12 Dec 2023 05:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387669; x=1702992469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt6fdI/cbCPQ7iqiyCD0Kz5AK/2nJCArCn0TPONSklY=;
        b=Qo0NkIUFlrMGBjz0Qdi+mPsasQyRuM9MaAkIbAPXqqUj1CLNxXQVsUNcEoNoue/Vsx
         Dp1PJ6f6I5lztb1IP7pX6tS5ZBx3gBrBh36SyGzP1r0smdZrVoVwpJbpr7mHeQ1b9WAL
         Rv1tEzIfiEA9pjuAshYgoksRu5RcQzWOmYt9yMmuTRid/jVqBfBaIewDTAc9XTDWyFRg
         7z2cOVGXIZ5OeGmI/7I38uuKTjPOWD48ACKzdlU+XVPgYNyuraIcDLZyZo5Kp7S67FGc
         WLSEOaqxEBUYmTPXHYoUS5o4+A/+UsCQdzWIPXZQbhiqgr8eZuZsdp2pCz+Zy4SMwgl0
         6H1A==
X-Gm-Message-State: AOJu0YzV4elXXxb/QhItI4Dqmdtg0s4SeZkm+N++cobYqpBDfJ231dtl
        KLzepdfDJHb10/VY6F4VckJbJgXYA1j/QqHBrrw=
X-Google-Smtp-Source: AGHT+IEMwrh+wmwyKoQDkoqdfpyeZge+VcdwSydHOS2utHB15/FENFpmZig3kvIyZrcafSowtaEmtOvUvN0E1gAnFGE=
X-Received: by 2002:a4a:c487:0:b0:58d:ddcb:db1a with SMTP id
 f7-20020a4ac487000000b0058dddcbdb1amr10131153ooq.1.1702387669582; Tue, 12 Dec
 2023 05:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20231124223226.24249-1-frederic@kernel.org> <20231124223226.24249-8-frederic@kernel.org>
In-Reply-To: <20231124223226.24249-8-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 14:27:38 +0100
Message-ID: <CAJZ5v0h4xic09rEOQSAnjA282mkrfA87Vo58a+Ag00x2BcVbQA@mail.gmail.com>
Subject: Re: [PATCH 7/7] cpuidle: Handle TIF_NR_POLLING on behalf of software
 polling idle states
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 11:33 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> Software polling idle states set again TIF_NR_POLLING and clear it upon
> exit. This involves error prone duplicated code and wasted cycles
> performing atomic operations, sometimes RmW fully ordered.
>
> To avoid this, benefit instead from the same generic TIF_NR_POLLING
> handling that is currently in use for hardware polling states.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 10 ----------
>  drivers/cpuidle/cpuidle-pseries.c | 11 -----------
>  drivers/cpuidle/cpuidle.c         |  4 ++--
>  drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
>  4 files changed, 14 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 675b8eb81ebd..b88bbf7ead41 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -71,8 +71,6 @@ static int snooze_loop(struct cpuidle_device *dev,
>  {
>         u64 snooze_exit_time;
>
> -       set_thread_flag(TIF_POLLING_NRFLAG);
> -
>         local_irq_enable();
>
>         snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
> @@ -81,21 +79,13 @@ static int snooze_loop(struct cpuidle_device *dev,
>         HMT_very_low();
>         while (!need_resched()) {
>                 if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
> -                       /*
> -                        * Task has not woken up but we are exiting the polling
> -                        * loop anyway. Require a barrier after polling is
> -                        * cleared to order subsequent test of need_resched().
> -                        */
> -                       clear_thread_flag(TIF_POLLING_NRFLAG);
>                         dev->poll_time_limit = true;
> -                       smp_mb();
>                         break;
>                 }
>         }
>
>         HMT_medium();
>         ppc64_runlatch_on();
> -       clear_thread_flag(TIF_POLLING_NRFLAG);
>
>         local_irq_disable();
>
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index 4e08c9a39172..0ae76512b740 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -39,8 +39,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  {
>         u64 snooze_exit_time;
>
> -       set_thread_flag(TIF_POLLING_NRFLAG);
> -
>         pseries_idle_prolog();
>         raw_local_irq_enable();
>         snooze_exit_time = get_tb() + snooze_timeout;
> @@ -50,21 +48,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>                 HMT_low();
>                 HMT_very_low();
>                 if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
> -                       /*
> -                        * Task has not woken up but we are exiting the polling
> -                        * loop anyway. Require a barrier after polling is
> -                        * cleared to order subsequent test of need_resched().
> -                        */
>                         dev->poll_time_limit = true;
> -                       clear_thread_flag(TIF_POLLING_NRFLAG);
> -                       smp_mb();
>                         break;
>                 }
>         }
>
>         HMT_medium();
> -       clear_thread_flag(TIF_POLLING_NRFLAG);
> -
>         raw_local_irq_disable();
>
>         pseries_idle_epilog();
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 49078cc83f4a..9eb811b5d8b6 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -236,8 +236,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>                 broadcast = false;
>         }
>
> -       polling = target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
> -
> +       polling = (target_state->flags & (CPUIDLE_FLAG_POLLING_SOFT |
> +                                         CPUIDLE_FLAG_POLLING_HARD));

The outer parens are not needed on the right-hand side, or apply !! to it.

>         /*
>          * If the target state doesn't poll on need_resched(), this is
>          * the last check after which further TIF_NEED_RESCHED remote setting
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index a2fe173de117..3bfa251b344a 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -13,35 +13,29 @@
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start;
> -
> -       time_start = local_clock_noinstr();
> +       u64 time_start = local_clock_noinstr();
> +       unsigned int loop_count = 0;
> +       u64 limit;
>
>         dev->poll_time_limit = false;
>
>         raw_local_irq_enable();
> -       if (!current_set_polling_and_test()) {
> -               unsigned int loop_count = 0;
> -               u64 limit;
>
> -               limit = cpuidle_poll_time(drv, dev);
> +       limit = cpuidle_poll_time(drv, dev);
>
> -               while (!need_resched()) {
> -                       cpu_relax();
> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -                               continue;
> +       while (!need_resched()) {
> +               cpu_relax();
> +               if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> +                       continue;
>
> -                       loop_count = 0;
> -                       if (local_clock_noinstr() - time_start > limit) {
> -                               dev->poll_time_limit = true;
> -                               break;
> -                       }
> +               loop_count = 0;
> +               if (local_clock_noinstr() - time_start > limit) {
> +                       dev->poll_time_limit = true;
> +                       break;
>                 }
>         }
>         raw_local_irq_disable();
>
> -       current_clr_polling();
> -
>         return index;
>  }
>
> --
