Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBF77E4C64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjKGXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjKGXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:02:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF65D7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:01:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3139C433C8;
        Tue,  7 Nov 2023 23:01:51 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:01:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231107180153.4a02d2ba@gandalf.local.home>
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:56:46 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Hi,

Hi Ankur,

Thanks for doing this!

> 
> We have two models of preemption: voluntary and full (and RT which is
> a fuller form of full preemption.) In this series -- which is based
> on Thomas' PoC (see [1]), we try to unify the two by letting the
> scheduler enforce policy for the voluntary preemption models as well.

I would say there's "NONE" which is really just a "voluntary" but with
fewer preemption points ;-) But still should be mentioned, otherwise people
may get confused.

> 
> (Note that this is about preemption when executing in the kernel.
> Userspace is always preemptible.)
> 


> Design
> ==
> 
> As Thomas outlines in [1], to unify the preemption models we
> want to: always have the preempt_count enabled and allow the scheduler
> to drive preemption policy based on the model in effect.
> 
> Policies:
> 
> - preemption=none: run to completion
> - preemption=voluntary: run to completion, unless a task of higher
>   sched-class awaits
> - preemption=full: optimized for low-latency. Preempt whenever a higher
>   priority task awaits.
> 
> To do this add a new flag, TIF_NEED_RESCHED_LAZY which allows the
> scheduler to mark that a reschedule is needed, but is deferred until
> the task finishes executing in the kernel -- voluntary preemption
> as it were.
> 
> The TIF_NEED_RESCHED flag is evaluated at all three of the preemption
> points. TIF_NEED_RESCHED_LAZY only needs to be evaluated at ret-to-user.
> 
>          ret-to-user    ret-to-kernel    preempt_count()
> none           Y              N                N
> voluntary      Y              Y                Y
> full           Y              Y                Y

Wait. The above is for when RESCHED_LAZY is to preempt, right?

Then, shouldn't voluntary be:

 voluntary      Y              N                N

For LAZY, but 

 voluntary      Y              Y                Y

For NEED_RESCHED (without lazy)

That is, the only difference between voluntary and none (as you describe
above) is that when an RT task wakes up, on voluntary, it sets NEED_RESCHED,
but on none, it still sets NEED_RESCHED_LAZY?

> 
> 
> There's just one remaining issue: now that explicit preemption points are
> gone, processes that spread a long time in the kernel have no way to give
> up the CPU.

I wonder if this needs to be solved by with a user space knob, to trigger
the time that "NEED_RESCHED" will force a schedule?

> 
> For full preemption, that is a non-issue as we always use TIF_NEED_RESCHED.
> 
> For none/voluntary preemption, we handle that by upgrading to TIF_NEED_RESCHED
> if a task marked TIF_NEED_RESCHED_LAZY hasn't preempted away by the next tick.
> (This would cause preemption either at ret-to-kernel, or if the task is in
> a non-preemptible section, when it exits that section.)
> 
> Arguably this provides for much more consistent maximum latency (~2 tick
> lengths + length of non-preemptible section) as compared to the old model
> where the maximum latency depended on the dynamic distribution of
> cond_resched() points.

Again, why I think we probably want to set a knob  for users to adjust
this. Default, it will be set to "tick" but if not, then we need to add
another timer to trigger before then. And this would only be available with
HRTIMERS of course ;-)

> 
> (As a bonus it handles code that is preemptible but cannot call
> cond_resched() completely trivially: ex. long running Xen hypercalls, or
> this series which started this discussion:
>  https://lore.kernel.org/all/20230830184958.2333078-8-ankur.a.arora@oracle.com/)
> 
> 
> Status
> ==
> 
> What works:
>  - The system seems to keep ticking over with the normal scheduling
> policies (SCHED_OTHER). The support for the realtime policies is somewhat
> more half baked.)
>  - The basic performance numbers seem pretty close to 6.6-rc7 baseline
> 
> What's broken:
>  - ARCH_NO_PREEMPT (See patch-45 "preempt: ARCH_NO_PREEMPT only preempts
>    lazily")
>  - Non-x86 architectures. It's trivial to support other archs (only need
>    to add TIF_NEED_RESCHED_LAZY) but wanted to hold off until I got some
>    comments on the series.
>    (From some testing on arm64, didn't find any surprises.)


>  - livepatch: livepatch depends on using _cond_resched() to provide
>    low-latency patching. That is obviously difficult with cond_resched()
>    gone. We could get a similar effect by using a static_key in
>    preempt_enable() but at least with inline locks, that might be end
>    up bloating the kernel quite a bit.

Maybe if we have that timer, livepatch could set it to be temporarily
shorter?

>  - Documentation/ and comments mention cond_resched()

>  - ftrace support for need-resched-lazy is incomplete

Shouldn't be a problem.

> 
> What needs more discussion:
>  - Should cond_resched_lock() etc be scheduling out for TIF_NEED_RESCHED
>    only or both TIF_NEED_RESCHED_LAZY as well? (See patch 35 "thread_info:
>    change to tif_need_resched(resched_t)")

I would say NEED_RESCHED only, then it would match the description of the
different models above.

>  - Tracking whether a task in userspace or in the kernel (See patch-40
>    "context_tracking: add ct_state_cpu()")
>  - The right model for preempt=voluntary. (See patch 44 "sched: voluntary
>    preemption")
> 
> 
> Performance
> ==
> 


>   * optimal-load (-j 1024)
> 
>            6.6-rc7                                    +series
>         
> 
>   wall        139.2 +-       0.3             wall       138.8  +-
> 0.2 utime     11161.0 +-    3360.4             utime    11061.2  +-
> 3244.9 stime      1357.6 +-     199.3             stime     1366.6  +-
>  216.3 %cpu       9108.8 +-    2431.4             %cpu      9081.0  +-
> 2351.1 csw     2078599   +- 2013320.0             csw    1970610    +-
> 1969030.0
> 
> 
>   For both of these the wallclock, utime, stime etc are pretty much
>   identical. The one interesting difference is that the number of
>   context switches are fewer. This intuitively makes sense given that
>   we reschedule threads lazily rather than rescheduling if we encounter
>   a cond_resched() and there's a thread wanting to be scheduled.
> 
>   The max-load numbers (not posted here) also behave similarly.

It would be interesting to run any "latency sensitive" benchmarks.

I wounder how cyclictest would work under each model with and without this
patch?

-- Steve
