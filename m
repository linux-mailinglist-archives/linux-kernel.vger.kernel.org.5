Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C2375AEFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGTNAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGTNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:00:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8161269A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:00:39 -0700 (PDT)
Date:   Thu, 20 Jul 2023 15:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689858038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nusw9jg0we31NCClupilhXQ04h8H2SKrWfbhWg8vE2w=;
        b=vqiuDGjeaHoN8wiDBM/fghBXFBNYWPYIaK1t8iB/DtUlC3pLOALp6YEXqCT7tfG8d9SIeE
        473u8jzjBv1AEDM5Lk98h+0m8MPvFxE1lYPY/hlxbDb0ky3LgmZeX3O/OFlfsq9os8dbC0
        0RjbwfCrVfg3pB1QEjtKZO2dgzeH09bFmY8/hfqPFIa97Ermv/2rt4/IgEsfxjK1UhxNTU
        GVV1K2lPVo2ue2ik9dy8pQZ1mAQGBHLVGY5JVXwlm6XG51YBs7y0VoJ0aJtjHX+V+f83eC
        bsX+LnOm+xlMi4Hk/pdERnJ+q4r2DsOJ8SA60m9mUDQjZ4zwdSmXnGUddbPtjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689858038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nusw9jg0we31NCClupilhXQ04h8H2SKrWfbhWg8vE2w=;
        b=3cmQGps2Z24GA1U0Xck3vOPkQ0iYRD9kJMxLkIeL31gOACoJIhwwkvNmUXw9cgUBPnQON0
        Dtu6A9noOKKE07Cw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
In-Reply-To: <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
Message-ID: <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de> <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, 20 Jul 2023, Vincent Guittot wrote:

> On Thu, 20 Jul 2023 at 08:51, Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
> >
> > Hi,
> >
> > during tests of the timer pull model, Gautham observed regressions under
> > load. With the timer pull model in place, going idle is more expensive. My
> > naive assumption, that a system which is fully loaded will not go idle was
> > simply wrong. Under a fully loaded system (top shows ~1% idle), some CPUs
> > go idle and stop the tick for several us and come back to work and this
> > heavily repeats.
> >
> > Peter and tglx helped me to track it down to find the reason: The governor
> > which decides if the tick will be stopped only looks at the next timer but
> > does not take into account how busy the system is. Here Peter pointed to
> > the scheduler avg_idle value.
> >
> > Beside the existing avg_idle, I introduced really_avg_idle which is not
> > limited to twice max_idle_balance_cost but also updated in
> > ttwu_do_activate() when avg_idle is updated.
> >
> > With tracing, I was able to see that in the fully loaded case, 75%-80% of
> > the idle periods have been shorter than the really_avg_idle value. (trace
> > printk of really_avg_idle values directly at the begin of
> > tick_nohz_next_event(); enabling sched_wakeup tracepoint; take the delta
> > between the timestamps of the first and the latter as idle time).
> >
> > A generalized approach to prevent going idle, when the system is loaded,
> > would be to add a check how busy the system is to tick_nohz_next_event().
> 
> Would it be better to let the cpuidle governor decide whether to stop
> or not the tick instead ?
> With your change, tick_nohz_next_event() becomes an random value which
> might return something else than the real next event
> 
> you might me interested by this:
> https://lore.kernel.org/all/20230105145159.1089531-1-kajetan.puchalski@arm.com/
> 
> They use cpu utilization to stay in shallow c-states some of which
> don't stop the tick. Maybe you extend this to make sure to not stop
> the tick for high load

I had also a look at teo. It makes things better but does not solve the
underlying problem that I see here - please correct me if I missed
something or if I'm simply wrong:

Yes, the governors have to decide in the end, whether it makes sense to
stop the tick or not. For this decision, the governors require information
about the current state of the core and how long nothing has to be done
propably. At the moment the governors therefore call
tick_nohz_get_sleep_length(). This checks first whether the tick can be
stopped. Then it takes into account whether rcu, irq_work, arch_work needs
the CPU or a timer softirq is pending. If non of this is true, then the
timers are checked. So tick_nohz_get_sleep_length() isn't only based on
timers already.

The information about the sleep length of the scheduler perspective is
completely missing in the current existing check for the probable sleep
length.

Sure, teo takes scheduler utilization into account directly in the
governor. But for me it is not comprehensible, why the CPU utilization
check is done after asking for the possible sleep length where timers are
taken into account. If the CPU is busy anyway, the information generated by
tick_nohz_next_event() is irrelevant. And when the CPU is not busy, then it
makes sense to ask for the sleep length also from a timer perspective.

When this CPU utilization check is implemented directly inside the
governor, every governor has to implement it on it's own. So wouldn't it
make sense to implement a "how utilized is the CPU out of a scheduler
perspective" in one place and use this as the first check in
tick_nohz_get_sleep_length()/tick_nohz_next_event()?

> >
> > In my PoC (find it at the end) it's simply checked whether the
> > really_avg_idle value is smaller than TICK_NSEC. It's not possible to use
> > the existing avg_idle value as it is always smaller than TICK_NSEC on 250HZ
> > systems. But there regressions occur under load and the standard deviation
> > of the test results were in the same range as the regression (between 5 and
> > 10%).
> >
> > So I wanted to understand the avg_idle values and examined the distribution
> > with different load scenarios. There my next naive assumption was, that
> > under load mainly short values will be seen. This is true, when the system
> > is halfway loaded (top shows ~50% idle). But when the system is fully
> > loaded, the avg_idle values are no longer 'focused' on small values.
> 
> avg_idle is broken for what you want to do. It is updated only when
> you leave an idle state which means that it stays stuck to the old avg
> idle time when your system is fully busy
>

As I said, I'm not familiar with scheduler internals. If avg_idle is not
the right thing, there might be another possibility to generate the
information about a possible sleep length out of the already existing
scheduler data.

Thanks,

	Anna-Maria

