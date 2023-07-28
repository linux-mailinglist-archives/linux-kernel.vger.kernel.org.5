Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81852767289
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjG1Q5D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jul 2023 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjG1Q4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:56:39 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD3A1BD6;
        Fri, 28 Jul 2023 09:56:36 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a3719334a2so490789b6e.1;
        Fri, 28 Jul 2023 09:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563396; x=1691168196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK0nlxFOPny5MRVZ60ocVnbOyaH0si+VBfDBp2E9avY=;
        b=VQjkE+T901qmtJ4zRPpI/BqwBY1ljqg19MuEx7yoEfWGJSRwp07Prr3C42HwB3MBtW
         oOSzIArZfgZPCtiBq4yrAUlPI589AmtumuElGCC3whYGgacd3gLkIkjO2DF6n6xNaog/
         hTsJSkG5Uw+EmKkVUcOVwoTRyXneVP1r0w0fd9eYDpW/fta40tXgPUdGCvIkUOKZEGW3
         HGegIww2m6WF8HGsx4F7kCRQTxaENgz4QZgvZvhwPHtU0Q+BpG07tUQzbkuyVXYALy4+
         cO90mfhMZ3NSuDXEKm9tz6+e1aXFOXPZ0ZBG0b9qHCSwy6fsty+o+HzEmSNdiSkoCp+2
         PFXA==
X-Gm-Message-State: ABy/qLYXiZmxKHdv6uHFV4cwDodeA0GryonmGD9cANyqqHUv9Hb6ejiP
        NMPI7t2931xj+tSzR4wvoGonl/2ZE67qrAGUnTDfSPSL6t8=
X-Google-Smtp-Source: APBJJlG57dOBvc4Ip3PdGuHZ4i0YeaKwlMHetv6dbgr4kyJokWdVpUVfP0NTU8Y53EA0YQXdkbGc92hXZwI3ND8ab7g=
X-Received: by 2002:a05:6808:d4b:b0:3a3:a8d1:1aa2 with SMTP id
 w11-20020a0568080d4b00b003a3a8d11aa2mr3590351oik.4.1690563395723; Fri, 28 Jul
 2023 09:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.902892871@infradead.org>
In-Reply-To: <20230728145808.902892871@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Jul 2023 18:56:24 +0200
Message-ID: <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> With cpuidle having added a TICK bucket, TEO will account all TICK and
> longer idles there. This means we can now make an informed decision
> about stopping the tick. If the sum of 'hit+intercepts' of all states
> below the TICK bucket is more than 50%, it is most likely we'll not
> reach the tick this time around either, so stopping the tick doesn't
> make sense.
>
> If we don't stop the tick, don't bother calling
> tick_nohz_get_sleep_length() and assume duration is no longer than a
> tick (could be improved to still look at the current pending time and
> timers).
>
> Since we have this extra state, remove the state_count based early
> decisions.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/cpuidle/governors/teo.c |   97 ++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 63 deletions(-)
>
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -139,6 +139,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/topology.h>
>  #include <linux/tick.h>
> +#include "../cpuidle.h"
>
>  /*
>   * The number of bits to shift the CPU's capacity by in order to determine
> @@ -197,7 +198,6 @@ struct teo_cpu {
>         int next_recent_idx;
>         int recent_idx[NR_RECENT];
>         unsigned long util_threshold;
> -       bool utilized;
>  };
>
>  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> @@ -276,11 +276,11 @@ static void teo_update(struct cpuidle_dr
>
>                 cpu_data->total += bin->hits + bin->intercepts;
>
> -               if (target_residency_ns <= cpu_data->sleep_length_ns) {
> +               if (target_residency_ns <= cpu_data->sleep_length_ns)
>                         idx_timer = i;
> -                       if (target_residency_ns <= measured_ns)
> -                               idx_duration = i;
> -               }
> +
> +               if (target_residency_ns <= measured_ns)
> +                       idx_duration = i;

I'm not quite sure what happens here.

>         }
>
>         i = cpu_data->next_recent_idx++;
> @@ -362,11 +362,12 @@ static int teo_select(struct cpuidle_dri
>         unsigned int recent_sum = 0;
>         unsigned int idx_hit_sum = 0;
>         unsigned int hit_sum = 0;
> +       unsigned int tick_sum = 0;
>         int constraint_idx = 0;
>         int idx0 = 0, idx = -1;
>         bool alt_intercepts, alt_recent;
>         ktime_t delta_tick;
> -       s64 duration_ns;
> +       s64 duration_ns = TICK_NSEC;
>         int i;
>
>         if (dev->last_state_idx >= 0) {
> @@ -376,36 +377,26 @@ static int teo_select(struct cpuidle_dri
>
>         cpu_data->time_span_ns = local_clock();
>
> -       duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> -       cpu_data->sleep_length_ns = duration_ns;
> +       /* Should we stop the tick? */

Who's we?  I'd prefer something like "Should the tick be stopped?"
here (analogously below).

> +       for (i = 1; i < drv->state_count; i++) {
> +               struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> +               struct cpuidle_state *s = &drv->states[i];
>
> -       /* Check if there is any choice in the first place. */
> -       if (drv->state_count < 2) {
> -               idx = 0;
> -               goto end;
> -       }
> -       if (!dev->states_usage[0].disable) {
> -               idx = 0;
> -               if (drv->states[1].target_residency_ns > duration_ns)
> -                       goto end;
> -       }
> +               tick_sum += prev_bin->intercepts;
> +               tick_sum += prev_bin->hits;
>
> -       cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> -       /*
> -        * If the CPU is being utilized over the threshold and there are only 2
> -        * states to choose from, the metrics need not be considered, so choose
> -        * the shallowest non-polling state and exit.
> -        */
> -       if (drv->state_count < 3 && cpu_data->utilized) {
> -               for (i = 0; i < drv->state_count; ++i) {
> -                       if (!dev->states_usage[i].disable &&
> -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> -                               idx = i;
> -                               goto end;
> -                       }
> -               }
> +               if (s->target_residency_ns >= SHORT_TICK_NSEC)
> +                       break;
>         }
>
> +       if (2*tick_sum > cpu_data->total)
> +               *stop_tick = false;

This means "if over 50% of all the events fall into the buckets below
the tick period length, don't stop the tick".  Fair enough, but this
covers long-term only and what about the most recent events?  I think
that they need to be taken into account here too.

> +
> +       /* If we do stop the tick, ask for the next timer. */
> +       if (*stop_tick)
> +               duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> +       cpu_data->sleep_length_ns = duration_ns;

If the decision is made to retain the tick and the time to the closest
tick event is very small, it would be better to refine the state
selection so as to avoid returning a state with the target residency
above that time (which essentially is wasting energy).  That's what
delta_tick above is for, but now tick_nohz_get_sleep_length() is never
called when the tick is not going to be stopped.

Besides, if I'm not mistaken, setting sleep_length_ns to TICK_NSEC
every time the tick is not stopped will not really work on systems
where there are real idle states with target residencies beyond
TICK_NSEC.

> +
>         /*
>          * Find the deepest idle state whose target residency does not exceed
>          * the current sleep length and the deepest idle state not deeper than
> @@ -446,13 +437,13 @@ static int teo_select(struct cpuidle_dri
>                 idx_recent_sum = recent_sum;
>         }
>
> -       /* Avoid unnecessary overhead. */
> -       if (idx < 0) {
> -               idx = 0; /* No states enabled, must use 0. */
> -               goto end;
> -       } else if (idx == idx0) {
> -               goto end;
> -       }
> +       /* No states enabled, must use 0 */
> +       if (idx < 0)
> +               return 0;
> +
> +       /* No point looking for something shallower than the first enabled state */
> +       if (idx == idx0)
> +               return idx;
>
>         /*
>          * If the sum of the intercepts metric for all of the idle states
> @@ -541,29 +532,9 @@ static int teo_select(struct cpuidle_dri
>          * If the CPU is being utilized over the threshold, choose a shallower
>          * non-polling state to improve latency
>          */
> -       if (cpu_data->utilized)
> +       if (teo_cpu_is_utilized(dev->cpu, cpu_data))
>                 idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
>
> -end:
> -       /*
> -        * Don't stop the tick if the selected state is a polling one or if the
> -        * expected idle duration is shorter than the tick period length.
> -        */
> -       if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -           duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
> -               *stop_tick = false;
> -
> -               /*
> -                * The tick is not going to be stopped, so if the target
> -                * residency of the state to be returned is not within the time
> -                * till the closest timer including the tick, try to correct
> -                * that.
> -                */
> -               if (idx > idx0 &&
> -                   drv->states[idx].target_residency_ns > delta_tick)
> -                       idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
> -       }
> -
>         return idx;
>  }

Overall, I think that the problem with calling
tick_nohz_get_sleep_length() is limited to the cases when the CPU is
almost fully loaded, so the overall amount of idle time on it is tiny.
I would rather use a special pah for those cases and I would register
all of the wakeups as "intercepts" in those cases.
