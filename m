Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09677CDD00
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjJRNQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjJRNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:16:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4983
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:16:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697634973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1KbJzsMswh2mzowMIcPFg0mKYIxRl5P0zkuZOEKHbQ=;
        b=gejEfomVSSPFDM3tkGMf8t4Qu5BVmhC6BR6SaWrHWjv/zzcbeeOU3GRv5CTzuVdpa5FSO6
        3C5ufjHodJnO7I3jtN1/3qjNP/1a65Od+dzd+Vo8Q6JvSUbDESVO6NoZxxCo8usKf5oTKw
        ipPvXKxmJ1fs2LM7Mos6XMQNoVQwYifkfTnWEYhzmKRfRFogAklfC+7uBqg85MylaMlWTK
        LrG1VbmoOONe5w0Jofo9vrvCDf99BSPDdYgpDAUU+5j7uW1MokpWHl7k4n+OgJX2y2Y63n
        +LMQswMvmLCB14dncar+q6oR15VpT/BcrRGhkNVNd2uypEMisLDNJfclNcp35Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697634973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1KbJzsMswh2mzowMIcPFg0mKYIxRl5P0zkuZOEKHbQ=;
        b=8x3Q182IRY/FzFHBln9PzBuXO3PmpOJjlCjBAAx6Fzx6Itxwo4/5JP1H6PmaY2SmTuMEy8
        nn3fxXVLR2qbduBw==
To:     paulmck@kernel.org
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
In-Reply-To: <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
Date:   Wed, 18 Oct 2023 15:16:12 +0200
Message-ID: <87pm1c3wbn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul!

On Tue, Oct 17 2023 at 18:03, Paul E. McKenney wrote:
> Belatedly calling out some RCU issues.  Nothing fatal, just a
> (surprisingly) few adjustments that will need to be made.  The key thing
> to note is that from RCU's viewpoint, with this change, all kernels
> are preemptible, though rcu_read_lock() readers remain
> non-preemptible.

Why? Either I'm confused or you or both of us :)

With this approach the kernel is by definition fully preemptible, which
means means rcu_read_lock() is preemptible too. That's pretty much the
same situation as with PREEMPT_DYNAMIC.

For throughput sake this fully preemptible kernel provides a mechanism
to delay preemption for SCHED_OTHER tasks, i.e. instead of setting
NEED_RESCHED the scheduler sets NEED_RESCHED_LAZY.

That means the preemption points in preempt_enable() and return from
interrupt to kernel will not see NEED_RESCHED and the tasks can run to
completion either to the point where they call schedule() or when they
return to user space. That's pretty much what PREEMPT_NONE does today.

The difference to NONE/VOLUNTARY is that the explicit cond_resched()
points are not longer required because the scheduler can preempt the
long running task by setting NEED_RESCHED instead.

That preemption might be suboptimal in some cases compared to
cond_resched(), but from my initial experimentation that's not really an
issue.

> With that:
>
> 1.	As an optimization, given that preempt_count() would always give
> 	good information, the scheduling-clock interrupt could sense RCU
> 	readers for new-age CONFIG_PREEMPT_NONE=y kernels.  As might the
> 	IPI handlers for expedited grace periods.  A nice optimization.
> 	Except that...
>
> 2.	The quiescent-state-forcing code currently relies on the presence
> 	of cond_resched() in CONFIG_PREEMPT_RCU=n kernels.  One fix
> 	would be to do resched_cpu() more quickly, but some workloads
> 	might not love the additional IPIs.  Another approach to do #1
> 	above to replace the quiescent states from cond_resched() with
> 	scheduler-tick-interrupt-sensed quiescent states.

Right. The tick can see either the lazy resched bit "ignored" or some
magic "RCU needs a quiescent state" and force a reschedule.

> 	Plus...
>
> 3.	For nohz_full CPUs that run for a long time in the kernel,
> 	there are no scheduling-clock interrupts.  RCU reaches for
> 	the resched_cpu() hammer a few jiffies into the grace period.
> 	And it sets the ->rcu_urgent_qs flag so that the holdout CPU's
> 	interrupt-entry code will re-enable its scheduling-clock interrupt
> 	upon receiving the resched_cpu() IPI.

You can spare the IPI by setting NEED_RESCHED on the remote CPU which
will cause it to preempt.

> 	So nohz_full CPUs should be OK as far as RCU is concerned.
> 	Other subsystems might have other opinions.
>
> 4.	As another optimization, kvfree_rcu() could unconditionally
> 	check preempt_count() to sense a clean environment suitable for
> 	memory allocation.

Correct. All the limitations of preempt count being useless are gone.

> 5.	Kconfig files with "select TASKS_RCU if PREEMPTION" must
> 	instead say "select TASKS_RCU".  This means that the #else
> 	in include/linux/rcupdate.h that defines TASKS_RCU in terms of
> 	vanilla RCU must go.  There might be be some fallout if something
> 	fails to select TASKS_RCU, builds only with CONFIG_PREEMPT_NONE=y,
> 	and expects call_rcu_tasks(), synchronize_rcu_tasks(), or
> 	rcu_tasks_classic_qs() do do something useful.

In the end there is no CONFIG_PREEMPT_XXX anymore. The only knob
remaining would be CONFIG_PREEMPT_RT, which should be renamed to
CONFIG_RT or such as it does not really change the preemption
model itself. RT just reduces the preemption disabled sections with the
lock conversions, forced interrupt threading and some more.

> 6.	You might think that RCU Tasks (as opposed to RCU Tasks Trace
> 	or RCU Tasks Rude) would need those pesky cond_resched() calls
> 	to stick around.  The reason is that RCU Tasks readers are ended
> 	only by voluntary context switches.  This means that although a
> 	preemptible infinite loop in the kernel won't inconvenience a
> 	real-time task (nor an non-real-time task for all that long),
> 	and won't delay grace periods for the other flavors of RCU,
> 	it would indefinitely delay an RCU Tasks grace period.
>
> 	However, RCU Tasks grace periods seem to be finite in preemptible
> 	kernels today, so they should remain finite in limited-preemptible
> 	kernels tomorrow.  Famous last words...

That's an issue which you have today with preempt FULL, right? So if it
turns out to be a problem then it's not a problem of the new model.

> 7.	RCU Tasks Trace, RCU Tasks Rude, and SRCU shouldn't notice
> 	any algorithmic difference from this change.
>
> 8.	As has been noted elsewhere, in this new limited-preemption
> 	mode of operation, rcu_read_lock() readers remain preemptible.
> 	This means that most of the CONFIG_PREEMPT_RCU #ifdefs remain.

Why? You fundamentally have a preemptible kernel with PREEMPT_RCU, no?

> 9.	The rcu_preempt_depth() macro could do something useful in
> 	limited-preemption kernels.  Its current lack of ability in
> 	CONFIG_PREEMPT_NONE=y kernels has caused trouble in the past.

Correct.

> 10.	The cond_resched_rcu() function must remain because we still
> 	have non-preemptible rcu_read_lock() readers.

Where?

> 11.	My guess is that the IPVS_EST_TICK_CHAINS heuristic remains
> 	unchanged, but I must defer to the include/net/ip_vs.h people.

*blink*

> 12.	I need to check with the BPF folks on the BPF verifier's
> 	definition of BTF_ID(func, rcu_read_unlock_strict).
>
> 13.	The kernel/locking/rtmutex.c file's rtmutex_spin_on_owner()
> 	function might have some redundancy across the board instead
> 	of just on CONFIG_PREEMPT_RCU=y.  Or might not.
>
> 14.	The kernel/trace/trace_osnoise.c file's run_osnoise() function
> 	might need to do something for non-preemptible RCU to make
> 	up for the lack of cond_resched() calls.  Maybe just drop the
> 	"IS_ENABLED()" and execute the body of the current "if" statement
> 	unconditionally.

Again. There is no non-preemtible RCU with this model, unless I'm
missing something important here.

> 15.	I must defer to others on the mm/pgtable-generic.c file's
> 	#ifdef that depends on CONFIG_PREEMPT_RCU.

All those ifdefs should die :)

> While in the area, I noted that KLP seems to depend on cond_resched(),
> but on this I must defer to the KLP people.

Yeah, KLP needs some thoughts, but that's not rocket science to fix IMO.

> I am sure that I am missing something, but I have not yet seen any
> show-stoppers.  Just some needed adjustments.

Right. If it works out as I think it can work out the main adjustments
are to remove a large amount of #ifdef maze and related gunk :)

Thanks,

        tglx
