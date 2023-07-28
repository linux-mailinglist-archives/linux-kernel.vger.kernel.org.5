Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DDC76784A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbjG1WBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjG1WBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:01:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9199A2D5F;
        Fri, 28 Jul 2023 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xAH+c1piOJB40XU/MsQCVTQGpkyYY3lEGRLDIKN6cZQ=; b=F6zfeU7WSv2XJ20J7YUQDAYhY/
        aavnAWiiu8VCq+vJN5XyRKPck4yf2CANLpeDWbjCQ4t/AWWjKH5XNVXkH/zW4/TNQH+/Pombo5Aio
        N0ljJ0LDA4TAClqNi7Mf6STG2/43+YwvAa9bUsg/RI6Km223spzW1J9ft6j8wfIVFTM7gAcpjXtfK
        hpKhIBWTRz8XU0Y4YGq/LnM1DaTN3EvkHKOm0NlrC8yLovo4a3yZ9+/p60xR7QIv+RTnFje4UI0wl
        FAASTAgUCPTYgGLsBTa+gNHIYbBsos7HMWBVCANOBDQpCTBST87cyrqmIuc8mXmsezVUz8poLwtka
        mF+ohA9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPVWH-008zgV-OL; Fri, 28 Jul 2023 22:01:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48B59300346;
        Sat, 29 Jul 2023 00:01:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39C5D2C8FF2BD; Sat, 29 Jul 2023 00:01:09 +0200 (CEST)
Date:   Sat, 29 Jul 2023 00:01:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 2/3] cpuidle,teo: Improve NOHZ management
Message-ID: <20230728220109.GA3934165@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.902892871@infradead.org>
 <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hi25zZ_SRnSk0r=7q=UFh1dsrWEao6225KZVWp3-ivDQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:56:24PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > @@ -276,11 +276,11 @@ static void teo_update(struct cpuidle_dr
> >
> >                 cpu_data->total += bin->hits + bin->intercepts;
> >
> > -               if (target_residency_ns <= cpu_data->sleep_length_ns) {
> > +               if (target_residency_ns <= cpu_data->sleep_length_ns)
> >                         idx_timer = i;
> > -                       if (target_residency_ns <= measured_ns)
> > -                               idx_duration = i;
> > -               }
> > +
> > +               if (target_residency_ns <= measured_ns)
> > +                       idx_duration = i;
> 
> I'm not quite sure what happens here.

Oh, I couldn't convince myself that measured_ns <= sleep_length_ns. If
measured was longer we still want the higher index.

But yeah, I forgots I had that hunk in.

> >         }
> >
> >         i = cpu_data->next_recent_idx++;
> > @@ -362,11 +362,12 @@ static int teo_select(struct cpuidle_dri
> >         unsigned int recent_sum = 0;
> >         unsigned int idx_hit_sum = 0;
> >         unsigned int hit_sum = 0;
> > +       unsigned int tick_sum = 0;
> >         int constraint_idx = 0;
> >         int idx0 = 0, idx = -1;
> >         bool alt_intercepts, alt_recent;
> >         ktime_t delta_tick;
> > -       s64 duration_ns;
> > +       s64 duration_ns = TICK_NSEC;
> >         int i;
> >
> >         if (dev->last_state_idx >= 0) {
> > @@ -376,36 +377,26 @@ static int teo_select(struct cpuidle_dri
> >
> >         cpu_data->time_span_ns = local_clock();
> >
> > -       duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> > -       cpu_data->sleep_length_ns = duration_ns;
> > +       /* Should we stop the tick? */
> 
> Who's we?  I'd prefer something like "Should the tick be stopped?"
> here (analogously below).

Sure.

> > +       for (i = 1; i < drv->state_count; i++) {
> > +               struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
> > +               struct cpuidle_state *s = &drv->states[i];
> >
> > -       /* Check if there is any choice in the first place. */
> > -       if (drv->state_count < 2) {
> > -               idx = 0;
> > -               goto end;
> > -       }
> > -       if (!dev->states_usage[0].disable) {
> > -               idx = 0;
> > -               if (drv->states[1].target_residency_ns > duration_ns)
> > -                       goto end;
> > -       }
> > +               tick_sum += prev_bin->intercepts;
> > +               tick_sum += prev_bin->hits;
> >
> > -       cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> > -       /*
> > -        * If the CPU is being utilized over the threshold and there are only 2
> > -        * states to choose from, the metrics need not be considered, so choose
> > -        * the shallowest non-polling state and exit.
> > -        */
> > -       if (drv->state_count < 3 && cpu_data->utilized) {
> > -               for (i = 0; i < drv->state_count; ++i) {
> > -                       if (!dev->states_usage[i].disable &&
> > -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> > -                               idx = i;
> > -                               goto end;
> > -                       }
> > -               }
> > +               if (s->target_residency_ns >= SHORT_TICK_NSEC)
> > +                       break;
> >         }
> >
> > +       if (2*tick_sum > cpu_data->total)
> > +               *stop_tick = false;
> 
> This means "if over 50% of all the events fall into the buckets below
> the tick period length, don't stop the tick".  Fair enough, but this
> covers long-term only and what about the most recent events?  I think
> that they need to be taken into account here too.

From looking at a few traces this 'long' term is around 8-10 samples.
Which I figured was quick enough.

Note that DECAY_SHIFT is 3, while the pulse is 10 bits, so 3-4 cycles
will drain most of the history when there's a distinct phase shift.

That said; I did look at the recent thing and those seem geared towards
the intercepts, while I think hits+intercepts makes more sense here.
Given it adjusted quickly enough I didn't put more time in it.

> > +
> > +       /* If we do stop the tick, ask for the next timer. */
> > +       if (*stop_tick)
> > +               duration_ns = tick_nohz_get_sleep_length(&delta_tick);
> > +       cpu_data->sleep_length_ns = duration_ns;
> 
> If the decision is made to retain the tick and the time to the closest
> tick event is very small, it would be better to refine the state
> selection so as to avoid returning a state with the target residency
> above that time (which essentially is wasting energy).  That's what
> delta_tick above is for, but now tick_nohz_get_sleep_length() is never
> called when the tick is not going to be stopped.

Right, so I did ponder using something like
ktime_sub(tick_nohz_get_next_hrtimer(), now) instead of TICK_NSEC to get
a more accurate measure, but I didn't do so yet.

> Besides, if I'm not mistaken, setting sleep_length_ns to TICK_NSEC
> every time the tick is not stopped will not really work on systems
> where there are real idle states with target residencies beyond
> TICK_NSEC.

It does work; you really don't want to select such a state if the tick
is still active -- you'll never get your residency. Such a state should
really only be used when the tick is off.

> > +
> >         /*
> >          * Find the deepest idle state whose target residency does not exceed
> >          * the current sleep length and the deepest idle state not deeper than
> > @@ -446,13 +437,13 @@ static int teo_select(struct cpuidle_dri
> >                 idx_recent_sum = recent_sum;
> >         }
> >
> > -       /* Avoid unnecessary overhead. */
> > -       if (idx < 0) {
> > -               idx = 0; /* No states enabled, must use 0. */
> > -               goto end;
> > -       } else if (idx == idx0) {
> > -               goto end;
> > -       }
> > +       /* No states enabled, must use 0 */
> > +       if (idx < 0)
> > +               return 0;
> > +
> > +       /* No point looking for something shallower than the first enabled state */
> > +       if (idx == idx0)
> > +               return idx;
> >
> >         /*
> >          * If the sum of the intercepts metric for all of the idle states
> > @@ -541,29 +532,9 @@ static int teo_select(struct cpuidle_dri
> >          * If the CPU is being utilized over the threshold, choose a shallower
> >          * non-polling state to improve latency
> >          */
> > -       if (cpu_data->utilized)
> > +       if (teo_cpu_is_utilized(dev->cpu, cpu_data))
> >                 idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> >
> > -end:
> > -       /*
> > -        * Don't stop the tick if the selected state is a polling one or if the
> > -        * expected idle duration is shorter than the tick period length.
> > -        */
> > -       if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> > -           duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
> > -               *stop_tick = false;
> > -
> > -               /*
> > -                * The tick is not going to be stopped, so if the target
> > -                * residency of the state to be returned is not within the time
> > -                * till the closest timer including the tick, try to correct
> > -                * that.
> > -                */
> > -               if (idx > idx0 &&
> > -                   drv->states[idx].target_residency_ns > delta_tick)
> > -                       idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
> > -       }
> > -
> >         return idx;
> >  }
> 
> Overall, I think that the problem with calling
> tick_nohz_get_sleep_length() is limited to the cases when the CPU is
> almost fully loaded, so the overall amount of idle time on it is tiny.
> I would rather use a special pah for those cases and I would register
> all of the wakeups as "intercepts" in those cases.

I'm not sure what you're proposing. If we track the tick+ bucket -- as
we must in order to say anything useful about it, then we can decide the
tick state before (as I do here) calling sleep_length().

The timer-pull rework from Anna-Maria unfortunately makes the
tick_nohz_get_sleep_length() thing excessively expensive and it really
doesn't make sense to call it when we retain the tick.

It's all a bit of a chicken-egg situation, cpuidle wants to know when
the next timer is, but telling when that is, wants to know if the tick
stays. We need to break that somehow -- I propose by not calling it when
we know we'll keep the tick.
