Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13612807FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjLGEeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLGEeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:34:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF187D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:34:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7855AC433C7;
        Thu,  7 Dec 2023 04:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701923652;
        bh=pwk0NVvM3OzErLnSqfGhNAC6MvdYkvcl/3vF7TAYcWc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YixjbXGmGZpAOokl0JNJqmNh0F4ACYA8lhjT4Jzn0/wkUCJY7ygPO7wIUi2gtOaXo
         RAgQe8LK8+5T2PVIfWzNHfgDXv2yv3SMu3/UvvOB8r0WA1SDPhQtc+j7FasPlBzWnw
         I9GVW83GqYqlNyBWj3PWbp4U1fIj4XgqF+FaqJiVXKpkLCfXPHSIBAvIsNZQLm73DK
         /hr1yNbkYblBnI2m+idaaMhiJ6S+3F77HKzLc28JQgOuJwtg82BpCLQtr+ucCP8DfM
         yMXs4AE4akYiJJLwJrmEan9FBV4t+t8ORjxuwViEnTfvLhpeB5wogSqgC+9LxNfFkT
         8aizF1pgS88sQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1557CE0E88; Wed,  6 Dec 2023 20:34:11 -0800 (PST)
Date:   Wed, 6 Dec 2023 20:34:11 -0800
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
Message-ID: <842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
 <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
 <20231205154518.70d042c3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205154518.70d042c3@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:45:18PM -0500, Steven Rostedt wrote:
> On Tue, 5 Dec 2023 11:38:42 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > 
> > > Note that the new preemption model is a new paradigm and we need to start
> > > thinking a bit differently if we go to it.  
> > 
> > We can of course think differently, but existing hardware and software
> > will probably be a bit more stubborn.
> 
> Not at all. I don't see how hardware plays a role here, but how software is
> designed does sometimes require thinking differently.

The hardware runs the software and so gets its say.  And I of course do
agree that changes in software sometimes require thinking differently,
but I can also personally attest to how much work it is and how long it
takes to induce changes in thinking.  ;-)

> > > One thing I would like to look into with the new work is to have holding a
> > > mutex ignore the NEED_RESCHED_LAZY (similar to what is done with spinlock
> > > converted to mutex in the RT kernel). That way you are less likely to be
> > > preempted while holding a mutex.  
> > 
> > I like the concept, but those with mutex_lock() of rarely-held mutexes
> > in their fastpaths might have workloads that have a contrary opinion.
> 
> I don't understand your above statement. Maybe I wasn't clear with my
> statement? The above is more about PREEMPT_FULL, as it currently will
> preempt immediately. My above comment is that we can have an option for
> PREEMPT_FULL where if the scheduler decided to preempt even in a fast path,
> it would at least hold off until there's no mutex held. Who cares if it's a
> fast path when a task needs to give up the CPU for another task? What I
> worry about is scheduling out while holding a mutex which increases the
> chance of that mutex being contended upon. Which does have drastic impact
> on performance.

As I understand the current mutex_lock() code, the fastpaths leave no
scheduler-visible clue that a mutex is in fact held.  If there is no
such clue, it is quite likely that those fastpaths will need to do some
additional clue-leaving work, increasing their overhead.  And while it
is always possible that this overhead will be down in the noise, if it
was too far down in the noise there would be no need for those fastpaths.

So it is possible (but by no means certain) that some workloads will end
up caring.

> > > > Another is the aforementioned situations where removing the cond_resched()
> > > > increases latency.  Yes, capping the preemption latency is a wonderful
> > > > thing, and the people I chatted with are all for that, but it is only
> > > > natural that there would be a corresponding level of concern about the
> > > > cases where removing the cond_resched() calls increases latency.  
> > > 
> > > With the "capped preemption" I'm not sure that would still be the case.
> > > cond_resched() currently only preempts if NEED_RESCHED is set. That means
> > > the system had to already be in a situation that a schedule needs to
> > > happen. There's lots of places in the kernel that run for over a tick
> > > without any cond_resched(). The cond_resched() is usually added for
> > > locations that show tremendous latency (where either a watchdog triggered,
> > > or showed up in some analysis that had a latency that was much greater than
> > > a tick).  
> > 
> > For non-real-time workloads, the average case is important, not just the
> > worst case.  In the new lazily preemptible mode of thought, a preemption
> > by a non-real-time task will wait a tick.  Earlier, it would have waited
> > for the next cond_resched().  Which, in the average case, might have
> > arrived much sooner than one tick.
> 
> Or much later. It's random. And what's nice about this model, we can add
> more models than just "NONE", "VOLUNTARY", "FULL". We could have a way to
> say "this task needs to preempt immediately" and not just for RT tasks.
> 
> This allows the user to decide which task preempts more and which does not
> (defined by the scheduler), instead of some random cond_resched() that can
> also preempt a higher priority task that just finished its quota to run a
> low priority task causing latency for the higher priority task.
> 
> This is what I mean by "think differently".

I did understand your meaning, and it is a source of some concern.  ;-)

When things become sufficiently stable, larger-scale tests will of course
be needed, not just different thought..

> > > The point is, if/when we switch to the new preemption model, we would need
> > > to re-evaluate if any cond_resched() is needed. Yes, testing needs to be
> > > done to prevent regressions. But the reasons I see cond_resched() being
> > > added today, should no longer exist with this new model.  
> > 
> > This I agree with.  Also, with the new paradigm and new mode of thought
> > in place, it should be safe to drop any cond_resched() that is in a loop
> > that consumes more than a tick of CPU time per iteration.
> 
> Why does that matter? Is the loop not important? Why stop it from finishing
> for some random task that may not be important, and cond_resched() has no
> idea if it is or not.

Because if it takes more than a tick to reach the next cond_resched(),
lazy preemption is likely to preempt before that cond_resched() is
reached.  Which suggests that such a cond_resched() would not be all
that valuable in the new thought paradigm.  Give or take potential issues
with exactly where the preemption happens.

> > > > There might be others as well.  These are the possibilities that have
> > > > come up thus far.
> > > >   
> > > > > They all suck and keeping some of them is just counterproductive as
> > > > > again people will sprinkle them all over the place for the very wrong
> > > > > reasons.    
> > > > 
> > > > Yes, but do they suck enough and are they counterproductive enough to
> > > > be useful and necessary?  ;-)  
> > > 
> > > They are only useful and necessary because of the way we handle preemption
> > > today. With the new preemption model, they are all likely to be useless and
> > > unnecessary ;-)  
> > 
> > The "all likely" needs some demonstration.  I agree that a great many
> > of them would be useless and unnecessary.  Maybe even the vast majority.
> > But that is different than "all".  ;-)
> 
> I'm betting it is "all" ;-) But I also agree that this "needs some
> demonstration". We are not there yet, and likely will not be until the
> second half of next year. So we have plenty of time to speak rhetorically
> to each other!

You know, we usually find time to engage in rhetorical conversation.  ;-)

> > > The conflict is with the new paradigm (I love that word! It's so "buzzy").
> > > As I mentioned above, cond_resched() is usually added when a problem was
> > > seen. I really believe that those problems would never had been seen if
> > > the new paradigm had already been in place.  
> > 
> > Indeed, that sort of wording does quite the opposite of raising my
> > confidence levels.  ;-)
> 
> Yes, I admit the "manager speak" isn't something to brag about here. But I
> really do like that word. It's just fun to say (and spell)! Paradigm,
> paradigm, paradigm! It's that silent 'g'. Although, I wonder if we should
> be like gnu, and pronounce it when speaking about free software? Although,
> that makes the word sound worse. :-p

Pair a' dime, pair a' quarter, pair a' fifty-cent pieces, whatever it takes!

> > You know, the ancient Romans would have had no problem dealing with the
> > dot-com boom, cryptocurrency, some of the shadier areas of artificial
> > intelligence and machine learning, and who knows what all else.  As the
> > Romans used to say, "Beware of geeks bearing grifts."
> > 
> > > > >   3) Looking at the initial problem Ankur was trying to solve there is
> > > > >      absolutely no acceptable solution to solve that unless you think
> > > > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
> > > > >      is anywhere near acceptable.    
> > > > 
> > > > I am not arguing for allow_preempt()/disallow_preempt(), so for that
> > > > argument, you need to find someone else to argue with.  ;-)  
> > > 
> > > Anyway, there's still a long path before cond_resched() can be removed. It
> > > was a mistake by Ankur to add those removals this early (and he has
> > > acknowledged that mistake).  
> > 
> > OK, that I can live with.  But that seems to be a bit different of a
> > take than that of some earlier emails in this thread.  ;-)
> 
> Well, we are also stating the final goal as well. I think there's some
> confusion to what's going to happen immediately and what's going to happen
> in the long run.

If I didn't know better, I might suspect that in addition to the
confusion, there are a few differences of opinion.  ;-)

> > > First we need to get the new preemption modeled implemented. When it is, it
> > > can be just a config option at first. Then when that config option is set,
> > > you can enable the NONE, VOLUNTARY or FULL preemption modes, even switch
> > > between them at run time as they are just a way to tell the scheduler when
> > > to set NEED_RESCHED_LAZY vs NEED_RSECHED.  
> > 
> > Assuming CONFIG_PREEMPT_RCU=y, agreed.  With CONFIG_PREEMPT_RCU=n,
> > the runtime switching needs to be limited to NONE and VOLUNTARY.
> > Which is fine.
> 
> But why? Because the run time switches of NONE and VOLUNTARY are no
> different than FULL.
> 
> Why I say that? Because:
> 
> For all modes, NEED_RESCHED_LAZY is set, the kernel has one tick to get out
> or NEED_RESCHED will be set (of course that one tick may be configurable).
> Once the NEED_RESCHED is set, then the kernel is converted to PREEMPT_FULL.
> 
> Even if the user sets the mode to "NONE", after the above scenario (one tick
> after NEED_RESCHED_LAZY is set) the kernel will be behaving no differently
> than PREEMPT_FULL.
> 
> So why make the difference between CONFIG_PREEMPT_RCU=n and limit to only
> NONE and VOLUNTARY. It must work with FULL or it will be broken for NONE
> and VOLUNTARY after one tick from NEED_RESCHED_LAZY being set.

Because PREEMPT_FULL=y plus PREEMPT_RCU=n appears to be a useless
combination.  All of the gains from PREEMPT_FULL=y are more than lost
due to PREEMPT_RCU=n, especially when the kernel decides to do something
like walk a long task list under RCU protection.  We should not waste
people's time getting burned by this combination, nor should we waste
cycles testing it.

> > > At that moment, when that config is set, the cond_resched() can turn into a
> > > nop. This will allow for testing to make sure there are no regressions in
> > > latency, even with the NONE mode enabled.  
> > 
> > And once it appears to be reasonably stable (in concept as well as
> > implementation), heavy testing should get underway.
> 
> Agreed.
> 
> > 
> > > The real test is implementing the code and seeing how it affects things in
> > > the real world. Us arguing about it isn't going to get anywhere.  
> > 
> > Indeed, the opinion of the objective universe always wins.  It all too
> > often takes longer than necessary for the people arguing with each other
> > to realize this, but such is life.
> > 
> > >                                                                  I just
> > > don't want blind NACK. A NACK to a removal of a cond_resched() needs to
> > > show that there was a real regression with that removal.  
> > 
> > Fair enough, although a single commit bulk removing a large number of
> > cond_resched() calls will likely get a bulk NAK.
> 
> We'll see. I now have a goal to hit!

;-) ;-) ;-)

							Thanx, Paul
