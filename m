Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC08C7CE490
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjJRRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjJRR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CE1703
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3138C433C7;
        Wed, 18 Oct 2023 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697649593;
        bh=vNjn/15RcYMia5ZZJe0f0BdPZYhHLOsp2VGxgL2hCHY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HiwPk+Q2urKgKk0X7/lYboIaMgkqwqEHFR57qScXLmxASMZnBRC5M9dqKTz8BAvE/
         BoSN1nBx8uHOg5isUg1VlMdouCxhcHq/GAapnTjXtpOdW9obJ8lTbC7k/e69Zkm+IO
         bF9/iYMKkASWBnd6Fo1JLseGxwxEpyW1FZf1ytBsZye74lsHd7o+tPsjUjE8b++1Kt
         mscmoeRWYxJRrCyarv63TeLEA1cm79aAAnVu4K2xSNTQTlWT3U+uPeRSd5+Z+JRoA5
         x0K5P2Q1jMAw4x8SErKkgIm5krGNcxf306Aaj87dMiqn+3apvD6zoJ/lS/WWHFwzY3
         fJEu+KByWB0FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44AD8CE0DE3; Wed, 18 Oct 2023 10:19:53 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:19:53 -0700
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
Message-ID: <61bb51f7-99ed-45bf-8c3e-f1d65137c894@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87pm1c3wbn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm1c3wbn.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:16:12PM +0200, Thomas Gleixner wrote:
> Paul!
> 
> On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
> > Belatedly calling out some RCU issues.  Nothing fatal, just a
> > (surprisingly) few adjustments that will need to be made.  The key thing
> > to note is that from RCU's viewpoint, with this change, all kernels
> > are preemptible, though rcu_read_lock() readers remain
> > non-preemptible.
> 
> Why? Either I'm confused or you or both of us :)

Isn't rcu_read_lock() defined as preempt_disable() and rcu_read_unlock()
as preempt_enable() in this approach?  I certainly hope so, as RCU
priority boosting would be a most unwelcome addition to many datacenter
workloads.

> With this approach the kernel is by definition fully preemptible, which
> means means rcu_read_lock() is preemptible too. That's pretty much the
> same situation as with PREEMPT_DYNAMIC.

Please, just no!!!

Please note that the current use of PREEMPT_DYNAMIC with preempt=none
avoids preempting RCU read-side critical sections.  This means that the
distro use of PREEMPT_DYNAMIC has most definitely *not* tested preemption
of RCU readers in environments expecting no preemption.

> For throughput sake this fully preemptible kernel provides a mechanism
> to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
> NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.
> 
> That means the preemption points in preempt_enable() and return from
> interrupt to kernel will not see NEED_RESCHED and the tasks can run to
> completion either to the point where they call schedule() or when they
> return to user space. That's pretty much what PREEMPT_NONE does today.
> 
> The difference to NONE/VOLUNTARY is that the explicit cond_resched()
> points are not longer required because the scheduler can preempt the
> long running task by setting NEED_RESCHED instead.
> 
> That preemption might be suboptimal in some cases compared to
> cond_resched(), but from my initial experimentation that's not really an
> issue.

I am not (repeat NOT) arguing for keeping cond_resched().  I am instead
arguing that the less-preemptible variants of the kernel should continue
to avoid preempting RCU read-side critical sections.

> > With that:
> >
> > 1.	As an optimization, given that preempt_count() would always give
> > 	good information, the scheduling-clock interrupt could sense RCU
> > 	readers for new-age CONFIG_PREEMPT_NONE=y kernels.  As might the
> > 	IPI handlers for expedited grace periods.  A nice optimization.
> > 	Except that...
> >
> > 2.	The quiescent-state-forcing code currently relies on the presence
> > 	of cond_resched() in CONFIG_PREEMPT_RCU=n kernels.  One fix
> > 	would be to do resched_cpu() more quickly, but some workloads
> > 	might not love the additional IPIs.  Another approach to do #1
> > 	above to replace the quiescent states from cond_resched() with
> > 	scheduler-tick-interrupt-sensed quiescent states.
> 
> Right. The tick can see either the lazy resched bit "ignored" or some
> magic "RCU needs a quiescent state" and force a reschedule.

Good, thank you for confirming.

> > 	Plus...
> >
> > 3.	For nohz_full CPUs that run for a long time in the kernel,
> > 	there are no scheduling-clock interrupts.  RCU reaches for
> > 	the resched_cpu() hammer a few jiffies into the grace period.
> > 	And it sets the ->rcu_urgent_qs flag so that the holdout CPU's
> > 	interrupt-entry code will re-enable its scheduling-clock interrupt
> > 	upon receiving the resched_cpu() IPI.
> 
> You can spare the IPI by setting NEED_RESCHED on the remote CPU which
> will cause it to preempt.

That is not sufficient for nohz_full CPUs executing in userspace, which
won't see that NEED_RESCHED until they either take an interrupt or do
a system call.  And applications often work hard to prevent nohz_full
CPUs from doing either.

Please note that if the holdout CPU really is a nohz_full CPU executing
in userspace, RCU will see this courtesy of context tracking and will
therefore avoid ever IPIin it.  The IPIs only happen if a nohz_full
CPU ends up executing for a long time in the kernel, which is an error
condition for the nohz_full use cases that I am aware of.

> > 	So nohz_full CPUs should be OK as far as RCU is concerned.
> > 	Other subsystems might have other opinions.
> >
> > 4.	As another optimization, kvfree_rcu() could unconditionally
> > 	check preempt_count() to sense a clean environment suitable for
> > 	memory allocation.
> 
> Correct. All the limitations of preempt count being useless are gone.

Woo-hoo!!!  And that is of course a very attractive property of this.

> > 5.	Kconfig files with "select TASKS_RCU if PREEMPTION" must
> > 	instead say "select TASKS_RCU".  This means that the #else
> > 	in include/linux/rcupdate.h that defines TASKS_RCU in terms of
> > 	vanilla RCU must go.  There might be be some fallout if something
> > 	fails to select TASKS_RCU, builds only with CONFIG_PREEMPT_NONE=y,
> > 	and expects call_rcu_tasks(), synchronize_rcu_tasks(), or
> > 	rcu_tasks_classic_qs() do do something useful.
> 
> In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
> remaining would be CONFIG_PREEMPT_RT, which should be renamed to
> CONFIG_RT or such as it does not really change the preemption
> model itself. RT just reduces the preemption disabled sections with the
> lock conversions, forced interrupt threading and some more.

Again, please, no.

There are situations where we still need rcu_read_lock() and
rcu_read_unlock() to be preempt_disable() and preempt_enable(),
repectively.  Those can be cases selected only by Kconfig option, not
available in kernels compiled with CONFIG_PREEMPT_DYNAMIC=y.

> > 6.	You might think that RCU Tasks (as opposed to RCU Tasks Trace
> > 	or RCU Tasks Rude) would need those pesky cond_resched() calls
> > 	to stick around.  The reason is that RCU Tasks readers are ended
> > 	only by voluntary context switches.  This means that although a
> > 	preemptible infinite loop in the kernel won't inconvenience a
> > 	real-time task (nor an non-real-time task for all that long),
> > 	and won't delay grace periods for the other flavors of RCU,
> > 	it would indefinitely delay an RCU Tasks grace period.
> >
> > 	However, RCU Tasks grace periods seem to be finite in preemptible
> > 	kernels today, so they should remain finite in limited-preemptible
> > 	kernels tomorrow.  Famous last words...
> 
> That's an issue which you have today with preempt FULL, right? So if it
> turns out to be a problem then it's not a problem of the new model.

Agreed, and hence my last three lines of text above.  Plus the guy who
requested RCU Tasks said that it was OK for its grace periods to take
a long time, and I am holding Steven Rostedt to that.  ;-)

> > 7.	RCU Tasks Trace, RCU Tasks Rude, and SRCU shouldn't notice
> > 	any algorithmic difference from this change.
> >
> > 8.	As has been noted elsewhere, in this new limited-preemption
> > 	mode of operation, rcu_read_lock() readers remain preemptible.
> > 	This means that most of the CONFIG_PREEMPT_RCU #ifdefs remain.
> 
> Why? You fundamentally have a preemptible kernel with PREEMPT_RCU, no?

That is in fact the problem.  Preemption can be good, but it is possible
to have too much of a good thing, and preemptible RCU read-side critical
sections definitely is in that category for some important workloads.  ;-)

> > 9.	The rcu_preempt_depth() macro could do something useful in
> > 	limited-preemption kernels.  Its current lack of ability in
> > 	CONFIG_PREEMPT_NONE=y kernels has caused trouble in the past.
> 
> Correct.
> 
> > 10.	The cond_resched_rcu() function must remain because we still
> > 	have non-preemptible rcu_read_lock() readers.
> 
> Where?

In datacenters.

> > 11.	My guess is that the IPVS_EST_TICK_CHAINS heuristic remains
> > 	unchanged, but I must defer to the include/net/ip_vs.h people.
> 
> *blink*

No argument here.  ;-)

> > 12.	I need to check with the BPF folks on the BPF verifier's
> > 	definition of BTF_ID(func, rcu_read_unlock_strict).
> >
> > 13.	The kernel/locking/rtmutex.c file's rtmutex_spin_on_owner()
> > 	function might have some redundancy across the board instead
> > 	of just on CONFIG_PREEMPT_RCU=y.  Or might not.
> >
> > 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> > 	might need to do something for non-preemptible RCU to make
> > 	up for the lack of cond_resched() calls.  Maybe just drop the
> > 	"IS_ENABLED()" and execute the body of the current "if" statement
> > 	unconditionally.
> 
> Again. There is no non-preemtible RCU with this model, unless I'm
> missing something important here.

And again, there needs to be non-preemptible RCU with this model.

> > 15.	I must defer to others on the mm/pgtable-generic.c file's
> > 	#ifdef that depends on CONFIG_PREEMPT_RCU.
> 
> All those ifdefs should die :)

Like all things, they will eventually.  ;-)

> > While in the area, I noted that KLP seems to depend on cond_resched(),
> > but on this I must defer to the KLP people.
> 
> Yeah, KLP needs some thoughts, but that's not rocket science to fix IMO.

Not rocket science, just KLP science, which I am happy to defer to the
KLP people.

> > I am sure that I am missing something, but I have not yet seen any
> > show-stoppers.  Just some needed adjustments.
> 
> Right. If it works out as I think it can work out the main adjustments
> are to remove a large amount of #ifdef maze and related gunk :)

Just please don't remove the #ifdef gunk that is still needed!

							Thanx, Paul
