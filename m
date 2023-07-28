Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D727670B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjG1PhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjG1PhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:37:10 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B24B5;
        Fri, 28 Jul 2023 08:37:07 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bb086bd510so181552a34.1;
        Fri, 28 Jul 2023 08:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558627; x=1691163427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ0Z9ESIsyUW9gVEIrTvSkIVgy0wAqNp4Ppv7aOMRhQ=;
        b=jB0+ZishA92/tK601hLFuXIxRGoRurL7p/kCPbyTHKs86w//RgXHdciI7gUhNCa0w6
         Mmnrhr9FgCyBl7sp7UxhZ91H+tMdOC7y7/qZktceM3gnIzdskTPFlG8DfuSlyT1BjM/1
         Pz3lo/EnVh16Gc0IUgM32ozE62N9ERn16wJjR4rZtANTxKDPkXlw6SF89zTqeAW6c1B2
         65t+L9fKa0c4MespOhZGD1mRfDrgunLHwjb55cv5bW+9hcbxmlTpw3DmCd0K8od9HXmX
         WKxMMO5xk/T3TM9d57QPKp+nqUkU3u/Wvhi52ujhDshRpKbAdL5GX+19gry+X+1kRlYm
         h00g==
X-Gm-Message-State: ABy/qLbo6ASC59jUs0ns655t2pDuKykUtte1U5Q5MLAMEEoRBKLuNofB
        xQ39r8TFdQ+A/UgDJftqPSEPakpTYWCcSgoSILShC3tM
X-Google-Smtp-Source: APBJJlFqjThyaz3tDJsCKI5rmy5O1v05lXluOQPh8HdSG0FSrGSUD9hwajfY7LFHI9Nbk+NavHB0ij0G7Rs38FV/4Xc=
X-Received: by 2002:a05:6870:f682:b0:1b7:5e47:5b75 with SMTP id
 el2-20020a056870f68200b001b75e475b75mr3070027oab.4.1690558626842; Fri, 28 Jul
 2023 08:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.835742568@infradead.org>
In-Reply-To: <20230728145808.835742568@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 17:36:55 +0200
Message-ID: <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
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

On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> In order to facilitate governors that track history in idle-state
> buckets (TEO) making a useful decision about NOHZ, make sure we have a
> bucket that counts tick-and-longer.
>
> In order to be inclusive of the tick itself -- after all, if we do not
> disable NOHZ we'll sleep for a full tick, the actual boundary should
> be just short of a full tick.
>
> IOW, when registering the idle-states, add one that is always
> disabled, just to have a bucket.

This extra bucket can be created in the governor itself, can't it?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/cpuidle.h |    2 +
>  drivers/cpuidle/driver.c  |   48 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/cpuidle.h   |    2 -
>  3 files changed, 50 insertions(+), 2 deletions(-)
>
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -72,4 +72,6 @@ static inline void cpuidle_coupled_unreg
>  }
>  #endif
>
> +#define SHORT_TICK_NSEC (TICK_NSEC - TICK_NSEC/32)
> +
>  #endif /* __DRIVER_CPUIDLE_H */
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -147,13 +147,37 @@ static void cpuidle_setup_broadcast_time
>                 tick_broadcast_disable();
>  }
>
> +static int tick_enter(struct cpuidle_device *dev,
> +                     struct cpuidle_driver *drv,
> +                     int index)
> +{
> +       return -ENODEV;
> +}
> +
> +static void __cpuidle_state_init_tick(struct cpuidle_state *s)
> +{
> +       strcpy(s->name, "TICK");
> +       strcpy(s->desc, "(no-op)");
> +
> +       s->target_residency_ns = SHORT_TICK_NSEC;
> +       s->target_residency = div_u64(SHORT_TICK_NSEC, NSEC_PER_USEC);
> +
> +       s->exit_latency_ns = 0;
> +       s->exit_latency = 0;
> +
> +       s->flags |= CPUIDLE_FLAG_UNUSABLE;
> +
> +       s->enter = tick_enter;
> +       s->enter_s2idle = tick_enter;
> +}
> +
>  /**
>   * __cpuidle_driver_init - initialize the driver's internal data
>   * @drv: a valid pointer to a struct cpuidle_driver
>   */
>  static void __cpuidle_driver_init(struct cpuidle_driver *drv)
>  {
> -       int i;
> +       int tick = 0, i;
>
>         /*
>          * Use all possible CPUs as the default, because if the kernel boots
> @@ -163,6 +187,9 @@ static void __cpuidle_driver_init(struct
>         if (!drv->cpumask)
>                 drv->cpumask = (struct cpumask *)cpu_possible_mask;
>
> +       if (WARN_ON_ONCE(drv->state_count >= CPUIDLE_STATE_MAX-2))
> +               tick = 1;
> +
>         for (i = 0; i < drv->state_count; i++) {
>                 struct cpuidle_state *s = &drv->states[i];
>
> @@ -192,6 +219,25 @@ static void __cpuidle_driver_init(struct
>                         s->exit_latency_ns =  0;
>                 else
>                         s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
> +
> +               if (!tick && s->target_residency_ns >= SHORT_TICK_NSEC) {
> +                       tick = 1;
> +
> +                       if (s->target_residency_ns == SHORT_TICK_NSEC)
> +                               continue;
> +
> +                       memmove(&drv->states[i+1], &drv->states[i],
> +                               sizeof(struct cpuidle_state) * (CPUIDLE_STATE_MAX - i - 1));
> +                       __cpuidle_state_init_tick(s);
> +                       drv->state_count++;
> +                       i++;
> +               }
> +       }
> +
> +       if (!tick) {
> +               struct cpuidle_state *s = &drv->states[i];
> +               __cpuidle_state_init_tick(s);
> +               drv->state_count++;
>         }
>  }
>
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -16,7 +16,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/context_tracking.h>
>
> -#define CPUIDLE_STATE_MAX      10
> +#define CPUIDLE_STATE_MAX      16
>  #define CPUIDLE_NAME_LEN       16
>  #define CPUIDLE_DESC_LEN       32
>
>
>
