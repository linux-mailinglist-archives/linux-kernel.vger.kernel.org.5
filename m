Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656A0809AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 05:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573140AbjLHE2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 23:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHE2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 23:28:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CDD54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 20:28:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641E4C433C7;
        Fri,  8 Dec 2023 04:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702009703;
        bh=kbYgUaAmRfpCX6DBYROe04yKUvnNRPWUuTHHeRhxL+A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tAlnlo/xfm+eKtlakBwvWzzlzgdI1fAfOzGl9d6TDfcV4TRp445R8u2R07koxrVZd
         TQpqnL19RNR96YpB3jQyMdLcRdPvkIqxplhUCZGIDDiNzYS9EJeNYq8TPKz9faAfLM
         AzbL+2uYovcTpXrL6Xe81cuxfnIjBIl9ZJs36zgrVKj/Y9TQSxNSgnO1u3D5EvMTPm
         0optDuuOuU/zE6+sfivK3Uv5ha8reVGNZ3UM4AbNFG1CXywHzZnZ0rxVfzcqcBT5nU
         ga3GO3LUp/fGY79Eg1HhLM7Kb9XPc0jao4ZNNsnLJ5+s8vCpE4rGSOTSKWvl35k8rI
         Azo21ovtepSrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0164CE0C4D; Thu,  7 Dec 2023 20:28:22 -0800 (PST)
Date:   Thu, 7 Dec 2023 20:28:22 -0800
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
Message-ID: <89797f8c-bd1e-4b6f-8efd-44cd0b633523@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
 <87wmu2ywrk.ffs@tglx>
 <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
 <20231205100114.0bd3c4a2@gandalf.local.home>
 <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
 <20231205154518.70d042c3@gandalf.local.home>
 <842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop>
 <20231207084457.78ab7d31@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207084457.78ab7d31@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:44:57AM -0500, Steven Rostedt wrote:
> On Wed, 6 Dec 2023 20:34:11 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > I like the concept, but those with mutex_lock() of rarely-held mutexes
> > > > in their fastpaths might have workloads that have a contrary opinion.  
> > > 
> > > I don't understand your above statement. Maybe I wasn't clear with my
> > > statement? The above is more about PREEMPT_FULL, as it currently will
> > > preempt immediately. My above comment is that we can have an option for
> > > PREEMPT_FULL where if the scheduler decided to preempt even in a fast path,
> > > it would at least hold off until there's no mutex held. Who cares if it's a
> > > fast path when a task needs to give up the CPU for another task? What I
> > > worry about is scheduling out while holding a mutex which increases the
> > > chance of that mutex being contended upon. Which does have drastic impact
> > > on performance.  
> > 
> > As I understand the current mutex_lock() code, the fastpaths leave no
> > scheduler-visible clue that a mutex is in fact held.  If there is no
> > such clue, it is quite likely that those fastpaths will need to do some
> > additional clue-leaving work, increasing their overhead.  And while it
> > is always possible that this overhead will be down in the noise, if it
> > was too far down in the noise there would be no need for those fastpaths.
> > 
> > So it is possible (but by no means certain) that some workloads will end
> > up caring.
> 
> OK, that makes more sense, and I do agree with that statement. It would
> need to do something like spin locks do with preempt disable, but I agree,
> this would need to be done in a way not to cause performance regressions.

Whew!  ;-)

> > > > > > Another is the aforementioned situations where removing the cond_resched()
> > > > > > increases latency.  Yes, capping the preemption latency is a wonderful
> > > > > > thing, and the people I chatted with are all for that, but it is only
> > > > > > natural that there would be a corresponding level of concern about the
> > > > > > cases where removing the cond_resched() calls increases latency.    
> > > > > 
> > > > > With the "capped preemption" I'm not sure that would still be the case.
> > > > > cond_resched() currently only preempts if NEED_RESCHED is set. That means
> > > > > the system had to already be in a situation that a schedule needs to
> > > > > happen. There's lots of places in the kernel that run for over a tick
> > > > > without any cond_resched(). The cond_resched() is usually added for
> > > > > locations that show tremendous latency (where either a watchdog triggered,
> > > > > or showed up in some analysis that had a latency that was much greater than
> > > > > a tick).    
> > > > 
> > > > For non-real-time workloads, the average case is important, not just the
> > > > worst case.  In the new lazily preemptible mode of thought, a preemption
> > > > by a non-real-time task will wait a tick.  Earlier, it would have waited
> > > > for the next cond_resched().  Which, in the average case, might have
> > > > arrived much sooner than one tick.  
> > > 
> > > Or much later. It's random. And what's nice about this model, we can add
> > > more models than just "NONE", "VOLUNTARY", "FULL". We could have a way to
> > > say "this task needs to preempt immediately" and not just for RT tasks.
> > > 
> > > This allows the user to decide which task preempts more and which does not
> > > (defined by the scheduler), instead of some random cond_resched() that can
> > > also preempt a higher priority task that just finished its quota to run a
> > > low priority task causing latency for the higher priority task.
> > > 
> > > This is what I mean by "think differently".  
> > 
> > I did understand your meaning, and it is a source of some concern.  ;-)
> > 
> > When things become sufficiently stable, larger-scale tests will of course
> > be needed, not just different thought..
> 
> Fair enough.
> 
> > 
> > > > > The point is, if/when we switch to the new preemption model, we would need
> > > > > to re-evaluate if any cond_resched() is needed. Yes, testing needs to be
> > > > > done to prevent regressions. But the reasons I see cond_resched() being
> > > > > added today, should no longer exist with this new model.    
> > > > 
> > > > This I agree with.  Also, with the new paradigm and new mode of thought
> > > > in place, it should be safe to drop any cond_resched() that is in a loop
> > > > that consumes more than a tick of CPU time per iteration.  
> > > 
> > > Why does that matter? Is the loop not important? Why stop it from finishing
> > > for some random task that may not be important, and cond_resched() has no
> > > idea if it is or not.  
> > 
> > Because if it takes more than a tick to reach the next cond_resched(),
> > lazy preemption is likely to preempt before that cond_resched() is
> > reached.  Which suggests that such a cond_resched() would not be all
> > that valuable in the new thought paradigm.  Give or take potential issues
> > with exactly where the preemption happens.
> 
> I'm just saying there's lots of places that the above happens, which is why
> we are still scattering cond_resched() all over the place.

And I agree that greatly reducing (if not eliminating) such scattering
is a great benefit of lazy preemption.

> > > > > > There might be others as well.  These are the possibilities that have
> > > > > > come up thus far.
> > > > > >     
> > > > > > > They all suck and keeping some of them is just counterproductive as
> > > > > > > again people will sprinkle them all over the place for the very wrong
> > > > > > > reasons.      
> > > > > > 
> > > > > > Yes, but do they suck enough and are they counterproductive enough to
> > > > > > be useful and necessary?  ;-)    
> > > > > 
> > > > > They are only useful and necessary because of the way we handle preemption
> > > > > today. With the new preemption model, they are all likely to be useless and
> > > > > unnecessary ;-)    
> > > > 
> > > > The "all likely" needs some demonstration.  I agree that a great many
> > > > of them would be useless and unnecessary.  Maybe even the vast majority.
> > > > But that is different than "all".  ;-)  
> > > 
> > > I'm betting it is "all" ;-) But I also agree that this "needs some
> > > demonstration". We are not there yet, and likely will not be until the
> > > second half of next year. So we have plenty of time to speak rhetorically
> > > to each other!  
> > 
> > You know, we usually find time to engage in rhetorical conversation.  ;-)
> > 
> > > > > The conflict is with the new paradigm (I love that word! It's so "buzzy").
> > > > > As I mentioned above, cond_resched() is usually added when a problem was
> > > > > seen. I really believe that those problems would never had been seen if
> > > > > the new paradigm had already been in place.    
> > > > 
> > > > Indeed, that sort of wording does quite the opposite of raising my
> > > > confidence levels.  ;-)  
> > > 
> > > Yes, I admit the "manager speak" isn't something to brag about here. But I
> > > really do like that word. It's just fun to say (and spell)! Paradigm,
> > > paradigm, paradigm! It's that silent 'g'. Although, I wonder if we should
> > > be like gnu, and pronounce it when speaking about free software? Although,
> > > that makes the word sound worse. :-p  
> > 
> > Pair a' dime, pair a' quarter, pair a' fifty-cent pieces, whatever it takes!
> 
>  Pair a' two-bits : that's all it's worth
> 
> Or
> 
>  Pair a' two-cents : as it's my two cents that I'm giving.

I must confess that the occasional transliteration of paradigm to
pair-of-dimes has been a great sanity-preservation device over the
decades.  ;-)

> > > > You know, the ancient Romans would have had no problem dealing with the
> > > > dot-com boom, cryptocurrency, some of the shadier areas of artificial
> > > > intelligence and machine learning, and who knows what all else.  As the
> > > > Romans used to say, "Beware of geeks bearing grifts."
> > > >   
> > > > > > >   3) Looking at the initial problem Ankur was trying to solve there is
> > > > > > >      absolutely no acceptable solution to solve that unless you think
> > > > > > >      that the semantically invers 'allow_preempt()/disallow_preempt()'
> > > > > > >      is anywhere near acceptable.      
> > > > > > 
> > > > > > I am not arguing for allow_preempt()/disallow_preempt(), so for that
> > > > > > argument, you need to find someone else to argue with.  ;-)    
> > > > > 
> > > > > Anyway, there's still a long path before cond_resched() can be removed. It
> > > > > was a mistake by Ankur to add those removals this early (and he has
> > > > > acknowledged that mistake).    
> > > > 
> > > > OK, that I can live with.  But that seems to be a bit different of a
> > > > take than that of some earlier emails in this thread.  ;-)  
> > > 
> > > Well, we are also stating the final goal as well. I think there's some
> > > confusion to what's going to happen immediately and what's going to happen
> > > in the long run.  
> > 
> > If I didn't know better, I might suspect that in addition to the
> > confusion, there are a few differences of opinion.  ;-)
> 
> Confusion enhances differences of opinion.

That can happen, but then again confusion can also result in the
mere appearance of agreement.  ;-)

> > > > > First we need to get the new preemption modeled implemented. When it is, it
> > > > > can be just a config option at first. Then when that config option is set,
> > > > > you can enable the NONE, VOLUNTARY or FULL preemption modes, even switch
> > > > > between them at run time as they are just a way to tell the scheduler when
> > > > > to set NEED_RESCHED_LAZY vs NEED_RSECHED.    
> > > > 
> > > > Assuming CONFIG_PREEMPT_RCU=y, agreed.  With CONFIG_PREEMPT_RCU=n,
> > > > the runtime switching needs to be limited to NONE and VOLUNTARY.
> > > > Which is fine.  
> > > 
> > > But why? Because the run time switches of NONE and VOLUNTARY are no
> > > different than FULL.
> > > 
> > > Why I say that? Because:
> > > 
> > > For all modes, NEED_RESCHED_LAZY is set, the kernel has one tick to get out
> > > or NEED_RESCHED will be set (of course that one tick may be configurable).
> > > Once the NEED_RESCHED is set, then the kernel is converted to PREEMPT_FULL.
> > > 
> > > Even if the user sets the mode to "NONE", after the above scenario (one tick
> > > after NEED_RESCHED_LAZY is set) the kernel will be behaving no differently
> > > than PREEMPT_FULL.
> > > 
> > > So why make the difference between CONFIG_PREEMPT_RCU=n and limit to only
> > > NONE and VOLUNTARY. It must work with FULL or it will be broken for NONE
> > > and VOLUNTARY after one tick from NEED_RESCHED_LAZY being set.  
> > 
> > Because PREEMPT_FULL=y plus PREEMPT_RCU=n appears to be a useless
> > combination.  All of the gains from PREEMPT_FULL=y are more than lost
> > due to PREEMPT_RCU=n, especially when the kernel decides to do something
> > like walk a long task list under RCU protection.  We should not waste
> > people's time getting burned by this combination, nor should we waste
> > cycles testing it.
> 
> The issue I see here is that PREEMPT_RCU is not something that we can
> convert at run time, where the NONE, VOLUNTARY, FULL (and more to come) can
> be. And you have stated that PREEMPT_RCU adds some more overhead that
> people may not care about. But even though you say PREEMPT_RCU=n makes no
> sense with PREEMPT_FULL, it doesn't mean we should not allow it. Especially
> if we have to make sure that it still works (even NONE and VOLUNTARY turn
> to FULL after that one-tick).
> 
> Remember, what we are looking at is having:
> 
> N : NEED_RESCHED - schedule at next possible location
> L : NEED_RESCHED_LAZY - schedule when going into user space.
> 
> When to set what for a task needing to schedule?
> 
>  Model           SCHED_OTHER         RT/DL(or user specified)
>  -----           -----------         ------------------------
>  NONE                 L                         L
>  VOLUNTARY            L                         N
>  FULL                 N                         N
> 
> By saying FULL, you are saying that you want the SCHED_OTHER as well as
> RT/DL tasks to schedule as soon as possible and not wait to going into user
> space. This is still applicable even with PREEMPT_RCU=n
> 
> It may be that someone wants better latency for all tasks (like VOLUNTARY)
> but not the overhead that PREEMPT_RCU gives, and is OK with the added
> latency as a result.

Given the additional testing burden and given the likelihood that it won't
do what people want, let's find someone who really needs it (as opposed
to someone who merely wants it) before allowing it to be selected.
It is after all an easy check far from any fastpath to prevent the
combination of PREEMPT_RCU and PREEMPT_FULL.

							Thanx, Paul
