Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA5805C14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442303AbjLEPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346014AbjLEPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:00:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AFEA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:00:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F56CC433C8;
        Tue,  5 Dec 2023 15:00:49 +0000 (UTC)
Date:   Tue, 5 Dec 2023 10:01:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Message-ID: <20231205100114.0bd3c4a2@gandalf.local.home>
In-Reply-To: <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
        <87wmu2ywrk.ffs@tglx>
        <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 17:01:21 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
> > Paul!
> > 
> > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:  
> > > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:  
> > >> Right now, the use of cond_resched() is basically a whack-a-mole game where
> > >> we need to whack all the mole loops with the cond_resched() hammer. As
> > >> Thomas said, this is backwards. It makes more sense to just not preempt in
> > >> areas that can cause pain (like holding a mutex or in an RCU critical
> > >> section), but still have the general kernel be fully preemptable.  
> > >
> > > Which is quite true, but that whack-a-mole game can be ended without
> > > getting rid of build-time selection of the preemption model.  Also,
> > > that whack-a-mole game can be ended without eliminating all calls to
> > > cond_resched().  
> > 
> > Which calls to cond_resched() should not be eliminated?  
> 
> The ones which, if eliminated, will result in excessive latencies.
> 
> This question is going to take some time to answer.  One type of potential
> issue is where the cond_resched() precedes something like mutex_lock(),
> where that mutex_lock() takes the fast path and preemption follows
> shortly thereafter.  It would clearly have been better to have preempted
> before acquisition.

Note that the new preemption model is a new paradigm and we need to start
thinking a bit differently if we go to it.

One thing I would like to look into with the new work is to have holding a
mutex ignore the NEED_RESCHED_LAZY (similar to what is done with spinlock
converted to mutex in the RT kernel). That way you are less likely to be
preempted while holding a mutex.

> 
> Another is the aforementioned situations where removing the cond_resched()
> increases latency.  Yes, capping the preemption latency is a wonderful
> thing, and the people I chatted with are all for that, but it is only
> natural that there would be a corresponding level of concern about the
> cases where removing the cond_resched() calls increases latency.

With the "capped preemption" I'm not sure that would still be the case.
cond_resched() currently only preempts if NEED_RESCHED is set. That means
the system had to already be in a situation that a schedule needs to
happen. There's lots of places in the kernel that run for over a tick
without any cond_resched(). The cond_resched() is usually added for
locations that show tremendous latency (where either a watchdog triggered,
or showed up in some analysis that had a latency that was much greater than
a tick).

The point is, if/when we switch to the new preemption model, we would need
to re-evaluate if any cond_resched() is needed. Yes, testing needs to be
done to prevent regressions. But the reasons I see cond_resched() being
added today, should no longer exist with this new model.

> 
> There might be others as well.  These are the possibilities that have
> come up thus far.
> 
> > They all suck and keeping some of them is just counterproductive as
> > again people will sprinkle them all over the place for the very wrong
> > reasons.  
> 
> Yes, but do they suck enough and are they counterproductive enough to
> be useful and necessary?  ;-)

They are only useful and necessary because of the way we handle preemption
today. With the new preemption model, they are all likely to be useless and
unnecessary ;-)

> 
> > > Additionally, if the end goal is to be fully preemptible as in
> > > eventually eliminating lazy preemption, you have a lot more
> > > convincing to do.  
> > 
> > That's absolutely not the case. Even RT uses the lazy mode to prevent
> > overeager preemption for non RT tasks.  
> 
> OK, that is very good to hear.

But the paradigm is changing. The kernel will be fully preemptible, it just
won't be preempting often. That is, if the CPU is running kernel code for
too long, and the scheduler tick wants a reschedule, the kernel has one
more tick to get back to user space before it will become fully
preemptible. That is, we force a "cond_resched()".

> 
> > The whole point of the exercise is to keep the kernel always fully
> > preemptible, but only enforce the immediate preemption at the next
> > possible preemption point when necessary.
> > 
> > The decision when it is necessary is made by the scheduler and not
> > delegated to the whim of cond/might_resched() placement.  
> 
> I am not arguing that the developer placing a given cond_resched()
> always knows best, but you have some work to do to convince me that the
> scheduler always knows best.

The cond_resched() already expects the scheduler to know best. It doesn't
resched unless NEED_RESCHED is set and that's determined by the scheduler.
If the code knows best, then it should just call schedule() and be done
with it.

> 
> > That is serving both worlds best IMO:
> > 
> >   1) LAZY preemption prevents the negative side effects of overeager
> >      preemption, aka. lock contention and pointless context switching.
> > 
> >      The whole thing behaves like a NONE kernel unless there are
> >      real-time tasks or a task did not comply to the lazy request within
> >      a given time.  
> 
> Almost, give or take the potential issues called out above for the
> possible downsides of removing all of the cond_resched() invocations.

I still don't believe there are any issues "called out above", as I called
out those called outs.

> 
> >   2) It does not prevent the scheduler from making decisions to preempt
> >      at the next possible preemption point in order to get some
> >      important computation on the CPU.
> > 
> >      A NONE kernel sucks vs. any sporadic [real-time] task. Just run
> >      NONE and watch the latencies. The latencies are determined by the
> >      interrupted context, the placement of the cond_resched() call and
> >      the length of the loop which is running.
> > 
> >      People have complained about that and the only way out for them is
> >      to switch to VOLUNTARY or FULL preemption and thereby paying the
> >      price for overeager preemption.
> > 
> >      A price which you don't want to pay for good reasons but at the
> >      same time you care about latencies in some aspects and the only
> >      answer you have for that is cond_resched() or similar which is not
> >      an answer at all.  
> 
> All good points, but none of them are in conflict with the possibility
> of leaving some cond_resched() calls behind if they ar needed.

The conflict is with the new paradigm (I love that word! It's so "buzzy").
As I mentioned above, cond_resched() is usually added when a problem was
seen. I really believe that those problems would never had been seen if
the new paradigm had already been in place.

> 
> >   3) Looking at the initial problem Ankur was trying to solve there is
> >      absolutely no acceptable solution to solve that unless you think
> >      that the semantically invers 'allow_preempt()/disallow_preempt()'
> >      is anywhere near acceptable.  
> 
> I am not arguing for allow_preempt()/disallow_preempt(), so for that
> argument, you need to find someone else to argue with.  ;-)

Anyway, there's still a long path before cond_resched() can be removed. It
was a mistake by Ankur to add those removals this early (and he has
acknowledged that mistake).

First we need to get the new preemption modeled implemented. When it is, it
can be just a config option at first. Then when that config option is set,
you can enable the NONE, VOLUNTARY or FULL preemption modes, even switch
between them at run time as they are just a way to tell the scheduler when
to set NEED_RESCHED_LAZY vs NEED_RSECHED.

At that moment, when that config is set, the cond_resched() can turn into a
nop. This will allow for testing to make sure there are no regressions in
latency, even with the NONE mode enabled.

The real test is implementing the code and seeing how it affects things in
the real world. Us arguing about it isn't going to get anywhere. I just
don't want blind NACK. A NACK to a removal of a cond_resched() needs to
show that there was a real regression with that removal.

-- Steve
