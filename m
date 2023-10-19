Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB97D024E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbjJSTNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjJSTNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:13:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD39612F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:13:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D90EC433C9;
        Thu, 19 Oct 2023 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697742812;
        bh=5F7c+DzCanWM1o7nYFlSHxiqjgCB/AjLW0NZA2IhjJY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=enwPwC3/4hZui2ZTsCDLnxyKtRklvlk24OSqeSoBlmtseWM0ceD8UcWuAwUDItyuM
         mY5xydQ9c/1223PuR5i0V68flNoiHamBcyPtsMBl920HJDR8UdotdodRWX1Xh2Sh6G
         puFnCMuHwO2ghC2f4tesX8kBXNX3Rza/Zfl8tJ2o881UgWYm4GrcxmaG+VFzFGW8bB
         1xrK6WVyQ1uzkbo/8WGmqHD3NFPPOEh/ZucwLvEKmjGCNVqDcAvGgH6TzhlsmuS2AO
         CeHGe65MY2sdNdMncFIB9wRxckR6h1xZ+v2vEuF3tOhSaf1haNndja1eYlWIJgxb1w
         QMNu/oxarrrQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD87ACE0D14; Thu, 19 Oct 2023 12:13:31 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:13:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <4c7d06b9-8f5b-43ff-a2d6-86f54116da52@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
 <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
 <8734y74g34.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734y74g34.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas!

On Thu, Oct 19, 2023 at 02:21:35AM +0200, Thomas Gleixner wrote:
> Paul!
> 
> On Wed, Oct 18 2023 at 10:19, Paul E. McKenney wrote:
> > On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
> >> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
> >> > Belatedly calling out some RCU issues.  Nothing fatal, just a
> >> > (surprisingly) few adjustments that will need to be made.  The key thing
> >> > to note is that from RCU's viewpoint, with this change, all kernels
> >> > are preemptible, though rcu_read_lock() readers remain
> >> > non-preemptible.
> >> 
> >> Why? Either I'm confused or you or both of us :)
> >
> > Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
> > as preempt_enable() in this approach?  I certainly hope so, as RCU
> > priority boosting would be a most unwelcome addition to many datacenter
> > workloads.
> 
> Sure, but that's an orthogonal problem, really.

Orthogonal, parallel, skew, whatever, it and its friends still need to
be addressed.

> >> With this approach the kernel is by definition fully preemptible, which
> >> means means rcu_read_lock() is preemptible too. That's pretty much the
> >> same situation as with PREEMPT_DYNAMIC.
> >
> > Please, just no!!!
> >
> > Please note that the current use of PREEMPT_DYNAMIC with preempt=none
> > avoids preempting RCU read-side critical sections.  This means that the
> > distro use of PREEMPT_DYNAMIC has most definitely *not* tested preemption
> > of RCU readers in environments expecting no preemption.
> 
> It does not _avoid_ it, it simply _prevents_ it by not preempting in
> preempt_enable() and on return from interrupt so whatever sets
> NEED_RESCHED has to wait for a voluntary invocation of schedule(),
> cond_resched() or return to user space.

A distinction without a difference.  ;-)

> But under the hood RCU is fully preemptible and the boosting logic is
> active, but it does not have an effect until one of those preemption
> points is reached, which makes the boosting moot.

And for many distros, this appears to be just fine, not that I personally
know of anyone running large numbers of systems in production with
kernels built with CONFIG_PREEMPT_DYNAMIC=y and booted with preempt=none.
And let's face it, if you want exactly the same binary to support both
modes, you are stuck with the fully-preemptible implementation of RCU.
But we should not make a virtue of such a distro's necessity.

And some of us are not afraid to build our own kernels, which allows
us to completely avoid the added code required to make RCU read-side
critical sections be preemptible.

> >> For throughput sake this fully preemptible kernel provides a mechanism
> >> to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
> >> NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.
> >> 
> >> That means the preemption points in preempt_enable() and return from
> >> interrupt to kernel will not see NEED_RESCHED and the tasks can run to
> >> completion either to the point where they call schedule() or when they
> >> return to user space. That's pretty much what PREEMPT_NONE does today.
> >> 
> >> The difference to NONE/VOLUNTARY is that the explicit cond_resched()
> >> points are not longer required because the scheduler can preempt the
> >> long running task by setting NEED_RESCHED instead.
> >> 
> >> That preemption might be suboptimal in some cases compared to
> >> cond_resched(), but from my initial experimentation that's not really an
> >> issue.
> >
> > I am not (repeat NOT) arguing for keeping cond_resched().  I am instead
> > arguing that the less-preemptible variants of the kernel should continue
> > to avoid preempting RCU read-side critical sections.
> 
> That's the whole point of the lazy mechanism:
> 
>    It avoids (repeat AVOIDS) preemption of any kernel code as much as it
>    can by _not_ setting NEED_RESCHED.
> 
>    The only difference is that it does not _prevent_ it like
>    preempt=none does. It will preempt when NEED_RESCHED is set.
> 
> Now the question is when will NEED_RESCHED be set?
> 
>    1) If the preempting task belongs to a scheduling class above
>       SCHED_OTHER
> 
>       This is a PoC implementation detail. The lazy mechanism can be
>       extended to any other scheduling class w/o a big effort.
> 
>       I deliberately did not do that because:
> 
>         A) I'm lazy
> 
>         B) More importantly I wanted to demonstrate that as long as
>            there are only SCHED_OTHER tasks involved there is no forced
>            (via NEED_RESCHED) preemption unless the to be preempted task
>            ignores the lazy resched request, which proves that
>            cond_resched() can be avoided.
> 
>            At the same time such a kernel allows a RT task to preempt at
>            any time.
> 
>    2) If the to be preempted task does not react within a certain time
>       frame (I used a full tick in my PoC) on the NEED_RESCHED_LAZY
>       request, which is the prerequisite to get rid of cond_resched()
>       and related muck.
> 
>       That's obviously mandatory for getting rid of cond_resched() and
>       related muck, no?

Keeping firmly in mind that there are no cond_resched() calls within RCU
read-side critical sections, sure.  Or, if you prefer, any such calls
are bugs.  And agreed, outside of atomic contexts (in my specific case,
including RCU readers), there does eventually need to be a preemption.

> I concede that there are a lot of details to be discussed before we get
> there, but I don't see a real show stopper yet.

Which is what I have been saying as well, at least as long as we can
have a way of building a kernel with a non-preemptible build of RCU.
And not just a preemptible RCU in which the scheduler (sometimes?)
refrains from preempting the RCU read-side critical sections, but
really only having the CONFIG_PREEMPT_RCU=n code built.

Give or take the needs of the KLP guys, but again, I must defer to
them.

> The important point is that the details are basically boiling down to
> policy decisions in the scheduler which are aided by hints from the
> programmer.
> 
> As I said before we might end up with something like
> 
>    preempt_me_not_if_not_absolutely_required();
>    ....
>    preempt_me_I_dont_care();
> 
> (+/- name bike shedding) to give the scheduler a better understanding of
> the context.
> 
> Something like that has distinct advantages over the current situation
> with all the cond_resched() muck:
> 
>   1) It is clearly scope based
> 
>   2) It is properly nesting
> 
>   3) It can be easily made implicit for existing scope constructs like
>      rcu_read_lock/unlock() or regular locking mechanisms.

You know, I was on board with throwing cond_resched() overboard (again,
give or take whatever KLP might need) when I first read of this in that
LWN article.  You therefore cannot possibly gain anything by continuing
to sell it to me, and, worse yet, you might provoke an heretofore-innocent
bystander into pushing some bogus but convincing argument against.  ;-)

Yes, there are risks due to additional state space exposed by the
additional preemption.  However, at least some of this is already covered
by quite a few people running preemptible kernels.  There will be some
not covered, given our sensitivity to low-probability bugs, but there
should also be some improvements in tail latency.  The process of getting
the first cond_resched()-free kernel deployed will therefore likely be
a bit painful, but overall the gains should be worth the pain.

> The important point is that at the very end the scheduler has the
> ultimate power to say: "Not longer Mr. Nice Guy" without the risk of any
> random damage due to the fact that preemption count is functional, which
> makes your life easier as well as you admitted already. But that does
> not mean you can eat the cake and still have it. :)

Which is exactly why I need rcu_read_lock() to map to preempt_disable()
and rcu_read_unlock() to preempt_enable().  ;-)

> That said, I completely understand your worries about the consequences,
> but please take the step back and look at it from a conceptual point of
> view.

Conceptual point of view?  That sounds suspiciously academic.  Who are
you and what did you do with the real Thomas Gleixner?  ;-)

But yes, consequences are extremely important, as always.

> The goal is to replace the hard coded (Kconfig or DYNAMIC) policy
> mechanisms with a flexible scheduler controlled policy mechanism.

Are you saying that CONFIG_PREEMPT_RT will also be selected at boot time
and/or via debugfs?

> That allows you to focus on one consolidated model and optimize that
> for particular policy scenarios instead of dealing with optimizing the
> hell out of hardcoded policies which force you to come up with
> horrible workaround for each of them.
> 
> Of course the policies have to be defined (scheduling classes affected
> depending on model, hint/annotation meaning etc.), but that's way more
> palatable than what we have now. Let me give you a simple example:
> 
>   Right now the only way out on preempt=none when a rogue code path
>   which lacks a cond_resched() fails to release the CPU is a big fat
>   stall splat and a hosed machine.
> 
>   I rather prefer to have the fully controlled hammer ready which keeps
>   the machine usable and the situation debuggable.
> 
>   You still can yell in dmesg, but that again is a flexible policy
>   decision and not hard coded by any means.

And I have agreed from my first read of that LWN article that allowing
preemption of code where preempt_count()=0 is a good thing.

The only thing that I am pushing back on is specifially your wish to
always be running the CONFIG_PREEMPT_RCU=y RCU code.  Yes, that is what
single-binary distros will do, just as they do now.  But again, some of
us are happy to build our own kernels.

There might be other things that I should be pushing back on, but that
is all that I am aware of right now.  ;-)

> >> > 3.	For nohz_full CPUs that run for a long time in the kernel,
> >> > 	there are no scheduling-clock interrupts.  RCU reaches for
> >> > 	the resched_cpu() hammer a few jiffies into the grace period.
> >> > 	And it sets the ->rcu_urgent_qs flag so that the holdout CPU's
> >> > 	interrupt-entry code will re-enable its scheduling-clock interrupt
> >> > 	upon receiving the resched_cpu() IPI.
> >> 
> >> You can spare the IPI by setting NEED_RESCHED on the remote CPU which
> >> will cause it to preempt.
> >
> > That is not sufficient for nohz_full CPUs executing in userspace,
> 
> That's not what I was talking about. You said:
> 
> >> > 3.	For nohz_full CPUs that run for a long time in the kernel,
>                                                            ^^^^^^
> Duh! I did not realize that you meant user space. For user space there
> is zero difference to the current situation. Once the task is out in
> user space it's out of RCU side critical sections, so that's obiously
> not a problem.
> 
> As I said: I might be confused. :)

And I might well also be confused.  Here is my view for nohz_full CPUs:

o	Running in userspace.  RCU will ignore them without disturbing
	the CPU, courtesy of context tracking.  As you say, there is
	no way (absent extremely strange sidechannel attacks) to
	have a kernel RCU read-side critical section here.

	These CPUs will ignore NEED_RESCHED until they exit usermode
	one way or another.  This exit will usually be supplied by
	the scheduler's wakeup IPI for the newly awakened task.

	But just setting NEED_RESCHED without otherwise getting the
	CPU's full attention won't have any effect.

o	Running in the kernel entry/exit code.	RCU will ignore them
	without disturbing the CPU, courtesy of context tracking.
	Unlike usermode, you can type rcu_read_lock(), but if you do,
	lockdep will complain bitterly.

	Assuming the time in the kernel is sharply bounded, as it
	usually will be, these CPUs will respond to NEED_RESCHED in a
	timely manner.	For longer times in the kernel, please see below.

o	Running in the kernel in deep idle, that is, where RCU is not
	watching.  RCU will ignore them without disturbing the CPU,
	courtesy of context tracking.  As with the entry/exit code,
	you can type rcu_read_lock(), but if you do, lockdep will
	complain bitterly.

	The exact response to NEED_RESCHED depends on the type of idle
	loop, with (as I understand it) polling idle loops responding
	quickly and other idle loops needing some event to wake up
	the CPU.  This event is typically an IPI, as is the case when
	the scheduler wakes up a task on the CPU in question.

o	Running in other parts of the kernel, but with scheduling
	clock interrupt enabled.  The next scheduling clock interrupt
	will take care of both RCU and NEED_RESCHED.  Give or take
	policy decisions, as you say above.

o	Running in other parts of the kernel, but with scheduling clock
	interrupt disabled.  If there is a grace period waiting on this
	CPU, RCU will eventually set a flag and invoke resched_cpu(),
	which will get the CPU's attention via an IPI and will also turn
	the scheduling clock interrupt back on.

	I believe that a wakeup from the scheduler has the same effect,
	and that it uses an IPI to get the CPU's attention when needed,
	but it has been one good long time since I traced out all the
	details.

	However, given that there is to be no cond_resched(), setting
	NEED_RESCHED without doing something like an IPI to get that
	CPU's attention will still not be guarantee to have any effect,
	just as with the nohz_full CPU executing in userspace, correct?

Did I miss anything?

> >> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
> >> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
> >> CONFIG_RT or such as it does not really change the preemption
> >> model itself. RT just reduces the preemption disabled sections with the
> >> lock conversions, forced interrupt threading and some more.
> >
> > Again, please, no.
> >
> > There are situations where we still need rcu_read_lock() and
> > rcu_read_unlock() to be preempt_disable() and preempt_enable(),
> > repectively.  Those can be cases selected only by Kconfig option, not
> > available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.
> 
> Why are you so fixated on making everything hardcoded instead of making
> it a proper policy decision problem. See above.

Because I am one of the people who will bear the consequences.

In that same vein, why are you so opposed to continuing to provide
the ability to build a kernel with CONFIG_PREEMPT_RCU=n?  This code
is already in place, is extremely well tested, and you need to handle
preempt_disable()/preeempt_enable() regions of code in any case.  What is
the real problem here?

> >> > 8.	As has been noted elsewhere, in this new limited-preemption
> >> > 	mode of operation, rcu_read_lock() readers remain preemptible.
> >> > 	This means that most of the CONFIG_PREEMPT_RCU #ifdefs remain.
> >> 
> >> Why? You fundamentally have a preemptible kernel with PREEMPT_RCU, no?
> >
> > That is in fact the problem.  Preemption can be good, but it is possible
> > to have too much of a good thing, and preemptible RCU read-side critical
> > sections definitely is in that category for some important workloads. ;-)
> 
> See above.
> 
> >> > 10.	The cond_resched_rcu() function must remain because we still
> >> > 	have non-preemptible rcu_read_lock() readers.
> >> 
> >> Where?
> >
> > In datacenters.
> 
> See above.
> 
> >> > 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> >> > 	might need to do something for non-preemptible RCU to make
> >> > 	up for the lack of cond_resched() calls.  Maybe just drop the
> >> > 	"IS_ENABLED()" and execute the body of the current "if" statement
> >> > 	unconditionally.
> >> 
> >> Again. There is no non-preemtible RCU with this model, unless I'm
> >> missing something important here.
> >
> > And again, there needs to be non-preemptible RCU with this model.
> 
> See above.

And back at you with all three instances of "See above".  ;-)

							Thanx, Paul
