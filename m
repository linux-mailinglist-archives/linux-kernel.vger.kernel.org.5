Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A875D7692E8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGaKSN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 Jul 2023 06:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjGaKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:17:44 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943C210D5;
        Mon, 31 Jul 2023 03:17:39 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1bc05bece1dso263006fac.1;
        Mon, 31 Jul 2023 03:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690798659; x=1691403459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6me9Nq3UaxaYmwk5MbUQ5w4ehPNBaXMEyeLZFVYoxGI=;
        b=QNKCa+WWFZNsRGoOzJc3RfV4EZEK181E4eg3YZS3njGXVS3OQEqky2BUikpyV4XXSl
         VQkKHJ5UyvwoDlr8BfCFvt3tr5O7OQW9Wz6mp42TY4pJ0FOMG8CjjOiuvFBPoGXEeCJ5
         3uldIuJqlL8T+86kViKx1nO/eLQ0ySNGROvDNHPtwXbhokYVTPl3ZDHPin8DCVEBctx+
         bKhAvcVIxAsynqzeZ7xXpYWKa7++HOPJOujd33f3q6TfP6ZClExNUtfdcT997fc+QSm8
         eAM//5cmSMi9EAD9d221aEMk4wQ+QvO8MrTMx2EXPc15ORQlLZ8BKUzQXfIWUw8hEmcE
         DBzg==
X-Gm-Message-State: ABy/qLYDx9ddVBKX22w9z+4a7tPQ+aIWlRqqbzzpfieYrtpjNsB1dVFX
        JljSVA3GiCs6ON/ub73DZhlRPkiNR4RQwEQ9GmuZrKgd00M=
X-Google-Smtp-Source: APBJJlE1QDUfBuTkrmDFx1h1EWanC2FmaP/eZ8TAyujJ9ArDFhpXffWBUHMHg+n6f5+DhAZmCtLUNgGNYPU2OrjKySM=
X-Received: by 2002:a05:6870:f70e:b0:1b4:4941:3096 with SMTP id
 ej14-20020a056870f70e00b001b449413096mr5138122oab.5.1690798658696; Mon, 31
 Jul 2023 03:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230728145515.990749537@infradead.org> <20230728145808.902892871@infradead.org>
 <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com> <20230728220109.GA3934165@hirez.programming.kicks-ass.net>
In-Reply-To: <20230728220109.GA3934165@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Jul 2023 12:17:27 +0200
Message-ID: <CAJZ5v0ir_VsvBi4KKhpcjQnVsTK-EXZJjNsk=Jp84HLvaspChw@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, anna-maria@linutronix.de,
        tglx@linutronix.de, frederic@kernel.org, gautham.shenoy@amd.com,
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

On Sat, Jul 29, 2023 at 12:01 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 28, 2023 at 06:56:24PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > @@ -276,11 +276,11 @@ static void teo_update(struct cpuidle_dr
> > >
> > >                 cpu_data->total += bin->hits + bin->intercepts;
> > >
> > > -               if (target_residency_ns <= cpu_data->sleep_length_ns) {
> > > +               if (target_residency_ns <= cpu_data->sleep_length_ns)
> > >                         idx_timer = i;
> > > -                       if (target_residency_ns <= measured_ns)
> > > -                               idx_duration = i;
> > > -               }
> > > +
> > > +               if (target_residency_ns <= measured_ns)
> > > +                       idx_duration = i;
> >
> > I'm not quite sure what happens here.
>
> Oh, I couldn't convince myself that measured_ns <= sleep_length_ns. If
> measured was longer we still want the higher index.
>
> But yeah, I forgots I had that hunk in.
>
> > >         }
> > >
> > >         i = cpu_data->next_recent_idx++;
> > > @@ -362,11 +362,12 @@ static int teo_select(struct cpuidle_dri
> > >         unsigned int recent_sum = 0;
> > >         unsigned int idx_hit_sum = 0;
> > >         unsigned int hit_sum = 0;
> > > +       unsigned int tick_sum = 0;
> > >         int constraint_idx = 0;
> > >         int idx0 = 0, idx = -1;
> > >         bool alt_intercepts, alt_recent;
> > >         ktime_t delta_tick;
> > > -       s64 duration_ns;
> > > +       s64 duration_ns = TICK_NSEC;
> > >         int i;
> > >
> > >         if (dev->last_state_idx >= 0) {
> > > @@ -376,36 +377,26 @@ static int teo_select(struct cpuidle_dri
> > >
> > >         cpu_data->time_span_ns = local_clock();
> > >
> > > -       duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> > > -       cpu_data->sleep_length_ns = duration_ns;
> > > +       /* Should we stop the tick? */
> >
> > Who's we?  I'd prefer something like "Should the tick be stopped?"
> > here (analogously below).
>
> Sure.
>
> > > +       for (i = 1; i < drv->state_count; i++) {
> > > +               struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> > > +               struct cpuidle_state *s = &drv->states[i];
> > >
> > > -       /* Check if there is any choice in the first place. */
> > > -       if (drv->state_count < 2) {
> > > -               idx = 0;
> > > -               goto end;
> > > -       }
> > > -       if (!dev->states_usage[0].disable) {
> > > -               idx = 0;
> > > -               if (drv->states[1].target_residency_ns > duration_ns)
> > > -                       goto end;
> > > -       }
> > > +               tick_sum += prev_bin->intercepts;
> > > +               tick_sum += prev_bin->hits;
> > >
> > > -       cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> > > -       /*
> > > -        * If the CPU is being utilized over the threshold and there are only 2
> > > -        * states to choose from, the metrics need not be considered, so choose
> > > -        * the shallowest non-polling state and exit.
> > > -        */
> > > -       if (drv->state_count < 3 && cpu_data->utilized) {
> > > -               for (i = 0; i < drv->state_count; ++i) {
> > > -                       if (!dev->states_usage[i].disable &&
> > > -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> > > -                               idx = i;
> > > -                               goto end;
> > > -                       }
> > > -               }
> > > +               if (s->target_residency_ns >= SHORT_TICK_NSEC)
> > > +                       break;
> > >         }
> > >
> > > +       if (2*tick_sum > cpu_data->total)
> > > +               *stop_tick = false;
> >
> > This means "if over 50% of all the events fall into the buckets below
> > the tick period length, don't stop the tick".  Fair enough, but this
> > covers long-term only and what about the most recent events?  I think
> > that they need to be taken into account here too.
>
> From looking at a few traces this 'long' term is around 8-10 samples.
> Which I figured was quick enough.
>
> Note that DECAY_SHIFT is 3, while the pulse is 10 bits, so 3-4 cycles
> will drain most of the history when there's a distinct phase shift.
>
> That said; I did look at the recent thing and those seem geared towards
> the intercepts, while I think hits+intercepts makes more sense here.
> Given it adjusted quickly enough I didn't put more time in it.
>
> > > +
> > > +       /* If we do stop the tick, ask for the next timer. */
> > > +       if (*stop_tick)
> > > +               duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> > > +       cpu_data->sleep_length_ns = duration_ns;
> >
> > If the decision is made to retain the tick and the time to the closest
> > tick event is very small, it would be better to refine the state
> > selection so as to avoid returning a state with the target residency
> > above that time (which essentially is wasting energy).  That's what
> > delta_tick above is for, but now tick_nohz_get_sleep_length() is never
> > called when the tick is not going to be stopped.
>
> Right, so I did ponder using something like
> ktime_sub(tick_nohz_get_next_hrtimer(), now) instead of TICK_NSEC to get
> a more accurate measure, but I didn't do so yet.
>
> > Besides, if I'm not mistaken, setting sleep_length_ns to TICK_NSEC
> > every time the tick is not stopped will not really work on systems
> > where there are real idle states with target residencies beyond
> > TICK_NSEC.
>
> It does work; you really don't want to select such a state if the tick
> is still active -- you'll never get your residency. Such a state should
> really only be used when the tick is off.
>
> > > +
> > >         /*
> > >          * Find the deepest idle state whose target residency does not exceed
> > >          * the current sleep length and the deepest idle state not deeper than
> > > @@ -446,13 +437,13 @@ static int teo_select(struct cpuidle_dri
> > >                 idx_recent_sum = recent_sum;
> > >         }
> > >
> > > -       /* Avoid unnecessary overhead. */
> > > -       if (idx < 0) {
> > > -               idx = 0; /* No states enabled, must use 0. */
> > > -               goto end;
> > > -       } else if (idx == idx0) {
> > > -               goto end;
> > > -       }
> > > +       /* No states enabled, must use 0 */
> > > +       if (idx < 0)
> > > +               return 0;
> > > +
> > > +       /* No point looking for something shallower than the first enabled state */
> > > +       if (idx == idx0)
> > > +               return idx;
> > >
> > >         /*
> > >          * If the sum of the intercepts metric for all of the idle states
> > > @@ -541,29 +532,9 @@ static int teo_select(struct cpuidle_dri
> > >          * If the CPU is being utilized over the threshold, choose a shallower
> > >          * non-polling state to improve latency
> > >          */
> > > -       if (cpu_data->utilized)
> > > +       if (teo_cpu_is_utilized(dev->cpu, cpu_data))
> > >                 idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> > >
> > > -end:
> > > -       /*
> > > -        * Don't stop the tick if the selected state is a polling one or if the
> > > -        * expected idle duration is shorter than the tick period length.
> > > -        */
> > > -       if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > > -           duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
> > > -               *stop_tick = false;
> > > -
> > > -               /*
> > > -                * The tick is not going to be stopped, so if the target
> > > -                * residency of the state to be returned is not within the time
> > > -                * till the closest timer including the tick, try to correct
> > > -                * that.
> > > -                */
> > > -               if (idx > idx0 &&
> > > -                   drv->states[idx].target_residency_ns > delta_tick)
> > > -                       idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
> > > -       }
> > > -
> > >         return idx;
> > >  }
> >
> > Overall, I think that the problem with calling
> > tick_nohz_get_sleep_length() is limited to the cases when the CPU is
> > almost fully loaded, so the overall amount of idle time on it is tiny.
> > I would rather use a special pah for those cases and I would register
> > all of the wakeups as "intercepts" in those cases.
>
> I'm not sure what you're proposing.

Something really simple like:

1. Check sched_cpu_util() (which is done by teo anyway).
2. If that is around 90% of the maximum CPU capacity, select the first
non-polling idle state and be done (don't stop the tick as my other
replay earlier today).

In 2, tick_nohz_get_sleep_length() need not be checked, because the
idle state selection doesn't depend on it, and sleep_length_ns can be
set to KTIME_MAX (or indeed anything greater than TICK_NSEC), because
if the CPU is woken up by the tick, teo_reflect() will take care of
this and otherwise the wakeup should be recorded as an "intercept".

> If we track the tick+ bucket -- as
> we must in order to say anything useful about it, then we can decide the
> tick state before (as I do here) calling sleep_length().
>
> The timer-pull rework from Anna-Maria unfortunately makes the
> tick_nohz_get_sleep_length() thing excessively expensive and it really
> doesn't make sense to call it when we retain the tick.
>
> It's all a bit of a chicken-egg situation, cpuidle wants to know when
> the next timer is, but telling when that is, wants to know if the tick
> stays. We need to break that somehow -- I propose by not calling it when
> we know we'll keep the tick.

By selecting a state whose target residency will not be met, we lose
on both energy and performance, so doing this really should be
avoided, unless the state is really shallow in which case there may be
no time for making this consideration.
