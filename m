Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1E805EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbjLETik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLETii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:38:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ED0188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 11:38:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B06BC433C8;
        Tue,  5 Dec 2023 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701805123;
        bh=QYY2sRMsdgFy9y2bOASOpdSBw0ICd1FgHT9FMN+VX5E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=STv+u8LuSFvHUxHuc6SmugrIq8eoDg5SMYHTcehtIrZhDVdFsaTV4OWviuHOVaRS1
         x69bPn29h+vCQYEb53y22nSyv5WkLAp5PnrF2WWkwLu5TKF9MB0LNh654xSXGNndIJ
         1Nsc1w5nsEkIpv0gnDM29604rHrtOCXSJs7HSpbYYWxODJOUJpKNIJ2GQPeFIgiyRS
         RQZiWemr3+Iam3ePePZPTdNYxRp7kGQZrZqx6IfzFoqVM5ziHcSEZzgcnUwm9n6lEx
         BE1bsHIVaAlC+zL4TyXvVEszBEHYDDhk4pjkb/FDkdze1+G6ddXgfO1HiyvszIfi6O
         34kK3qiFoLGZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 074FCCE0C53; Tue,  5 Dec 2023 11:38:43 -0800 (PST)
Date:   Tue, 5 Dec 2023 11:38:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205100114.0bd3c4a2@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:01:14AM -0500, Steven Rostedt wrote:
> On Mon, 4 Dec 2023 17:01:21 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Tue, Nov 28, 2023 at 11:53:19AM +0100, Thomas Gleixner wrote:
> > > Paul!
> > > 
> > > On Tue, Nov 21 2023 at 07:19, Paul E. McKenney wrote:  
> > > > On Tue, Nov 21, 2023 at 10:00:59AM -0500, Steven Rostedt wrote:  
> > > >> Right now, the use of cond_resched() is basically a whack-a-mole game where
> > > >> we need to whack all the mole loops with the cond_resched() hammer. As
> > > >> Thomas said, this is backwards. It makes more sense to just not preempt in
> > > >> areas that can cause pain (like holding a mutex or in an RCU critical
> > > >> section), but still have the general kernel be fully preemptable.  
> > > >
> > > > Which is quite true, but that whack-a-mole game can be ended without
> > > > getting rid of build-time selection of the preemption model.  Also,
> > > > that whack-a-mole game can be ended without eliminating all calls to
> > > > cond_resched().  
> > > 
> > > Which calls to cond_resched() should not be eliminated?  
> > 
> > The ones which, if eliminated, will result in excessive latencies.
> > 
> > This question is going to take some time to answer.  One type of potential
> > issue is where the cond_resched() precedes something like mutex_lock(),
> > where that mutex_lock() takes the fast path and preemption follows
> > shortly thereafter.  It would clearly have been better to have preempted
> > before acquisition.
> 
> Note that the new preemption model is a new paradigm and we need to start
> thinking a bit differently if we go to it.

We can of course think differently, but existing hardware and software
will probably be a bit more stubborn.

> One thing I would like to look into with the new work is to have holding a
> mutex ignore the NEED_RESCHED_LAZY (similar to what is done with spinlock
> converted to mutex in the RT kernel). That way you are less likely to be
> preempted while holding a mutex.

I like the concept, but those with mutex_lock() of rarely-held mutexes
in their fastpaths might have workloads that have a contrary opinion.

> > Another is the aforementioned situations where removing the cond_resched()
> > increases latency.  Yes, capping the preemption latency is a wonderful
> > thing, and the people I chatted with are all for that, but it is only
> > natural that there would be a corresponding level of concern about the
> > cases where removing the cond_resched() calls increases latency.
> 
> With the "capped preemption" I'm not sure that would still be the case.
> cond_resched() currently only preempts if NEED_RESCHED is set. That means
> the system had to already be in a situation that a schedule needs to
> happen. There's lots of places in the kernel that run for over a tick
> without any cond_resched(). The cond_resched() is usually added for
> locations that show tremendous latency (where either a watchdog triggered,
> or showed up in some analysis that had a latency that was much greater than
> a tick).

For non-real-time workloads, the average case is important, not just the
worst case.  In the new lazily preemptible mode of thought, a preemption
by a non-real-time task will wait a tick.  Earlier, it would have waited
for the next cond_resched().  Which, in the average case, might have
arrived much sooner than one tick.

> The point is, if/when we switch to the new preemption model, we would need
> to re-evaluate if any cond_resched() is needed. Yes, testing needs to be
> done to prevent regressions. But the reasons I see cond_resched() being
> added today, should no longer exist with this new model.

This I agree with.  Also, with the new paradigm and new mode of thought
in place, it should be safe to drop any cond_resched() that is in a loop
that consumes more than a tick of CPU time per iteration.

> > There might be others as well.  These are the possibilities that have
> > come up thus far.
> > 
> > > They all suck and keeping some of them is just counterproductive as
> > > again people will sprinkle them all over the place for the very wrong
> > > reasons.  
> > 
> > Yes, but do they suck enough and are they counterproductive enough to
> > be useful and necessary?  ;-)
> 
> They are only useful and necessary because of the way we handle preemption
> today. With the new preemption model, they are all likely to be useless and
> unnecessary ;-)

The "all likely" needs some demonstration.  I agree that a great many
of them would be useless and unnecessary.  Maybe even the vast majority.
But that is different than "all".  ;-)

> > > > Additionally, if the end goal is to be fully preemptible as in
> > > > eventually eliminating lazy preemption, you have a lot more
> > > > convincing to do.  
> > > 
> > > That's absolutely not the case. Even RT uses the lazy mode to prevent
> > > overeager preemption for non RT tasks.  
> > 
> > OK, that is very good to hear.
> 
> But the paradigm is changing. The kernel will be fully preemptible, it just
> won't be preempting often. That is, if the CPU is running kernel code for
> too long, and the scheduler tick wants a reschedule, the kernel has one
> more tick to get back to user space before it will become fully
> preemptible. That is, we force a "cond_resched()".

And as stated quite a few times previously in this and earlier threads,
yes, removing the need to drop cond_resched() into longer-than-average
loops is a very good thing.

> > > The whole point of the exercise is to keep the kernel always fully
> > > preemptible, but only enforce the immediate preemption at the next
> > > possible preemption point when necessary.
> > > 
> > > The decision when it is necessary is made by the scheduler and not
> > > delegated to the whim of cond/might_resched() placement.  
> > 
> > I am not arguing that the developer placing a given cond_resched()
> > always knows best, but you have some work to do to convince me that the
> > scheduler always knows best.
> 
> The cond_resched() already expects the scheduler to know best. It doesn't
> resched unless NEED_RESCHED is set and that's determined by the scheduler.
> If the code knows best, then it should just call schedule() and be done
> with it.

A distinction without a difference.  After all, if the scheduler really
knew best, it would be able to intuit the cond_resched() without that
cond_resched() actually being there.  Which is arguably the whole point
of this patch series, aside from mutexes, the possibility of extending
what are now short preemption times, and who knows what all else.

> > > That is serving both worlds best IMO:
> > > 
> > >   1) LAZY preemption prevents the negative side effects of overeager
> > >      preemption, aka. lock contention and pointless context switching.
> > > 
> > >      The whole thing behaves like a NONE kernel unless there are
> > >      real-time tasks or a task did not comply to the lazy request within
> > >      a given time.  
> > 
> > Almost, give or take the potential issues called out above for the
> > possible downsides of removing all of the cond_resched() invocations.
> 
> I still don't believe there are any issues "called out above", as I called
> out those called outs.

Well, you did write some words, if that is what you meant.  ;-)

> > >   2) It does not prevent the scheduler from making decisions to preempt
> > >      at the next possible preemption point in order to get some
> > >      important computation on the CPU.
> > > 
> > >      A NONE kernel sucks vs. any sporadic [real-time] task. Just run
> > >      NONE and watch the latencies. The latencies are determined by the
> > >      interrupted context, the placement of the cond_resched() call and
> > >      the length of the loop which is running.
> > > 
> > >      People have complained about that and the only way out for them is
> > >      to switch to VOLUNTARY or FULL preemption and thereby paying the
> > >      price for overeager preemption.
> > > 
> > >      A price which you don't want to pay for good reasons but at the
> > >      same time you care about latencies in some aspects and the only
> > >      answer you have for that is cond_resched() or similar which is not
> > >      an answer at all.  
> > 
> > All good points, but none of them are in conflict with the possibility
> > of leaving some cond_resched() calls behind if they ar needed.
> 
> The conflict is with the new paradigm (I love that word! It's so "buzzy").
> As I mentioned above, cond_resched() is usually added when a problem was
> seen. I really believe that those problems would never had been seen if
> the new paradigm had already been in place.

Indeed, that sort of wording does quite the opposite of raising my
confidence levels.  ;-)

You know, the ancient Romans would have had no problem dealing with the
dot-com boom, cryptocurrency, some of the shadier areas of artificial
intelligence and machine learning, and who knows what all else.  As the
Romans used to say, "Beware of geeks bearing grifts."

> > >   3) Looking at the initial problem Ankur was trying to solve there is
> > >      absolutely no acceptable solution to solve that unless you think
> > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
> > >      is anywhere near acceptable.  
> > 
> > I am not arguing for allow_preempt()/disallow_preempt(), so for that
> > argument, you need to find someone else to argue with.  ;-)
> 
> Anyway, there's still a long path before cond_resched() can be removed. It
> was a mistake by Ankur to add those removals this early (and he has
> acknowledged that mistake).

OK, that I can live with.  But that seems to be a bit different of a
take than that of some earlier emails in this thread.  ;-)

> First we need to get the new preemption modeled implemented. When it is, it
> can be just a config option at first. Then when that config option is set,
> you can enable the NONE, VOLUNTARY or FULL preemption modes, even switch
> between them at run time as they are just a way to tell the scheduler when
> to set NEED_RESCHED_LAZY vs NEED_RSECHED.

Assuming CONFIG_PREEMPT_RCU=y, agreed.  With CONFIG_PREEMPT_RCU=n,
the runtime switching needs to be limited to NONE and VOLUNTARY.
Which is fine.

> At that moment, when that config is set, the cond_resched() can turn into a
> nop. This will allow for testing to make sure there are no regressions in
> latency, even with the NONE mode enabled.

And once it appears to be reasonably stable (in concept as well as
implementation), heavy testing should get underway.

> The real test is implementing the code and seeing how it affects things in
> the real world. Us arguing about it isn't going to get anywhere.

Indeed, the opinion of the objective universe always wins.  It all too
often takes longer than necessary for the people arguing with each other
to realize this, but such is life.

>                                                                  I just
> don't want blind NACK. A NACK to a removal of a cond_resched() needs to
> show that there was a real regression with that removal.

Fair enough, although a single commit bulk removing a large number of
cond_resched() calls will likely get a bulk NAK.

							Thanx, Paul
