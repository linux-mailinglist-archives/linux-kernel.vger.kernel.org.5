Return-Path: <linux-kernel+bounces-94296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D850873CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539A828680E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66254138489;
	Wed,  6 Mar 2024 16:54:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2231350CC;
	Wed,  6 Mar 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744056; cv=none; b=VjdeJf6aI6rtzi0mnzQpaHtJgkEbmeCrI1fKd8z40CfHGtAJvxalAiGHGaWtSBYvmBlEuVc2S6YdL/LfjJQRRhJBOgjfCpWolGd34TBw2Ge+B87+POXwFjpFf8IO3oKWJOV8fphIBO3pzbQ1xpE1c2D32miczNR0q2jAHrxYT/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744056; c=relaxed/simple;
	bh=v5+TxbknxLDLvq0CiWVJI2Fi/TMVvUgAVjtheoKiDAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEuE32kgMz9JDaNnSEDY1cxUV1UR0labpy/GPGbhVrpebYcNCMsjdRNw9bpxGCRGkz/j/AFpdDP6YGk5ZULxmNRVXYiMqsx7tm4za+6ANZxeUd6Cwl3suRvWIbzFCVKlLWLLRrdOk4vzSW6bneJWo4dU3LoBC1HRUCY3cK97Xm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2AFC433F1;
	Wed,  6 Mar 2024 16:54:15 +0000 (UTC)
Date: Wed, 6 Mar 2024 11:56:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Network Development
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 rcu@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <20240306115607.09b332db@gandalf.local.home>
In-Reply-To: <1e8d070e-5616-4c6d-a08b-4b6e1a0a2bad@paulmck-laptop>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
	<10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
	<99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
	<CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
	<f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
	<CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
	<fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
	<1e8d070e-5616-4c6d-a08b-4b6e1a0a2bad@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 09:53:42 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Case 1: For !CONFIG_DYNAMIC_FTRACE update of ftrace_trace_function
> > 
> > This config is itself expected to be slow. However seeing what it does, it is
> > trying to make sure the global function pointer "ftrace_trace_function" is
> > updated and any readers of that pointers would have finished reading it. I don't
> > personally think preemption has to be disabled across the entirety of the
> > section that calls into this function. So sensitivity to preempt disabling
> > should not be relevant for this case IMO, but lets see if ftrace folks disagree
> > (on CC). It has more to do with, any callers of this function pointer are no
> > longer calling into the old function.  
> 
> Assuming the loads from the function pointer aren't torn by the compiler,
> they will be loaded by a single instruction, which as you say cannot
> be preempted.  Might be good to have READ_ONCE() if they aren't already
> in place.

See my previous reply about READ_ONCE() logic, but going back to the reason
for rcu_synchronize_rude() we have this:

from kernel/trace/ftrace.c: update_ftrace_function()

> 	ftrace_trace_function = ftrace_ops_list_func;

The reason for switching to ftrace_ops_list_func is because the registered
ftrace_ops is what is to be passed to the function callback. For
non-dynamic ftrace, if we switch ftrace_trace_function to the function,
it's going to get the ftrace_ops of the old function, and that could be
disastrous if the callback is expecting to get its own ftrace_ops.

The ftrace_ops_list_func is an iterator of all the registered callbacks,
and will pass each callback its own ftrace_ops. So by switching to the
list_func, we guarantee that the callback will get its own ftrace_ops.

> 	/*
> 	 * Make sure all CPUs see this. Yes this is slow, but static
> 	 * tracing is slow and nasty to have enabled.
> 	 */
> 	synchronize_rcu_tasks_rude();

Now perhaps we don't need rude here. We just need to make sure that there's
no function that's about to call the old ftrace_trace_function.

> 	/* Now all cpus are using the list ops. */
> 	function_trace_op = set_function_trace_op;

We update the ftrace_ops that gets passed to whatever is registered to
ftrace_trace_function (but ftrace_ops_list_func ignores this parameter, as
it's just a helper function to call other callbacks).

> 	/* Make sure the function_trace_op is visible on all CPUs */
> 	smp_wmb();
> 	/* Nasty way to force a rmb on all cpus */
> 	smp_call_function(ftrace_sync_ipi, NULL, 1);

Needs to make sure everything will see the new ftarce_trace_op.

> 	/* OK, we are all set to update the ftrace_trace_function now! */
> #endif /* !CONFIG_DYNAMIC_FTRACE */
> 
> 	ftrace_trace_function = func;

Finally, we update what will be called by the trampoline, as func expects
to get the set_function_trace_op here. And it should.

> 
> > Case 2: Trampoline structures accessing
> > 
> > For this there is a code comment that says preemption will disabled so
> > it should not be dependent on any of the preemptiblity modes, because
> > preempt_disable() should disable preempt with PREEMPT_AUTO.

If ftrace_ops itself was allocated, meaning that when ftrace_shutdown()
returns, it had better not have anything calling the callback that will
reference the ftrace_ops, because after ftrace_shutdown() returns, it is OK
to free ftrace_ops.

Thus, the trampoline does not call the ftrace_ops callback directly, but
instead once again calls ftrace_ops_list_func! That's because
ftrace_ops_list_func has:

> 	bit = trace_test_and_set_recursion(ip, parent_ip, TRACE_LIST_START);

Where the above disables preemption.

> 	if (bit < 0)
> 		return;
> 
> 	do_for_each_ftrace_op(op, ftrace_ops_list) {
> 		/* Stub functions don't need to be called nor tested */
> 		if (op->flags & FTRACE_OPS_FL_STUB)
> 			continue;
> 		/*
> 		 * Check the following for each ops before calling their func:
> 		 *  if RCU flag is set, then rcu_is_watching() must be true
> 		 *  Otherwise test if the ip matches the ops filter
> 		 *
> 		 * If any of the above fails then the op->func() is not executed.
> 		 */
> 		if ((!(op->flags & FTRACE_OPS_FL_RCU) || rcu_is_watching()) &&
> 		    ftrace_ops_test(op, ip, regs)) {

If the callback expects RCU to be watching, then it is skipped if RCU is
not watching. If we have fixed all the places that function tracing can
happen to make sure RCU is always watching, we could possibly get rid of
this code.

This may be the case, because trace_test_and_set_recursion() has:

#ifdef CONFIG_ARCH_WANTS_NO_INSTR
# define trace_warn_on_no_rcu(ip)					\
	({								\
		bool __ret = !rcu_is_watching();			\
		if (__ret && !trace_recursion_test(TRACE_RECORD_RECURSION_BIT)) { \
			trace_recursion_set(TRACE_RECORD_RECURSION_BIT); \
			WARN_ONCE(true, "RCU not on for: %pS\n", (void *)ip); \
			trace_recursion_clear(TRACE_RECORD_RECURSION_BIT); \
		}							\
		__ret;							\
	})
#else
# define trace_warn_on_no_rcu(ip)	false
#endif

> 			if (FTRACE_WARN_ON(!op->func)) {
> 				pr_warn("op=%p %pS\n", op, op);
> 				goto out;
> 			}
> 			op->func(ip, parent_ip, op, fregs);
> 		}
> 	} while_for_each_ftrace_op(op);
> out:
> 	trace_clear_recursion(bit);

Thus, if RCU is always watching for all function calls, then we can remove
the rude here. Perhaps we could remove rude everywhere?


> > 
> > 		/*
> > 		 * We need to do a hard force of sched synchronization.
> > 		 * This is because we use preempt_disable() to do RCU,
> > but
> > 		 * the function tracers can be called where RCU is not
> > watching
> > 		 * (like before user_exit()). We can not rely on the RCU
> > 		 * infrastructure to do the synchronization, thus we
> > must do it
> > 		 * ourselves.
> > 		 */
> > 		synchronize_rcu_tasks_rude();
> > 		[...]
> > 		ftrace_trampoline_free(ops);
> > 
> > Code comment probably needs update because it says 'can not rely on
> > RCU..' ;-)  

Can not rely on normal RCU ;-)

> 
> My guess is that this comment is left over from when that call to
> synchronize_rcu_tasks_rude() was open-coded.  ;-)

Correct.

> 
> Maybe "We can not rely on vanilla RCU to do..."?

If RCU is always watching, then we can. But is that the case for all archs?

> 
> > My *guess* is the preempt_disable() mentioned in this case is
> > ftrace_ops_trampoline() where trampoline-related datas tructures are
> > accessed for stack unwinding purposes. This is a data structure
> > protection thing AFAICS and nothing to do with "trampoline execution"
> > itself which needs "Tasks RCU" to allow for preemption in trampolines.  
> 
> Sounds plausible to me, but let's see what Steve's thoughts are.

As mentioned above, the preempt_disable() is in the ftrace_ops_list_func()
that these callbacks are forced to go through.

> 
> > Case 3: This has to do with update of function graph tracing and there
> > is the same comment as case 2, where preempt will be disabled in
> > readers, so it should be safe for PREEMPT_AUTO (famous last words).

The preempt_disable here is in kernel/trace/trace.h:

  ftrace_graph_addr()

-- Steve

> > 
> > Though I am not yet able to locate that preempt_disable() which is not
> > an PREEMPT_AUTO-related issue anyway. Maybe its buried in function
> > graph tracing logic somewhere?  
> 
> With the trampolines, isn't synchronize_rcu_tasks_rude() paired with
> a call to synchronize_rcu_tasks()?  In that case, rude's only job is
> getting all CPUs out of their previous sojourn in either the entry/exit
> code or the deep idle loop.  RCU Tasks waits for each task to voluntarily
> block, which takes care of all tasks executing elsewhere.  (Recall that
> RCU Tasks ignores the idle tasks.)
> 
> > Finally, my thought also was, if any of these thread usages/cases of
> > Tasks RCU RUDE assume working only on a CONFIG_PREEMPT_NONE=y or
> > CONFIG_PREEMPT_VOLUNTARY=y kernel, that could be worrying but AFAICS,
> > they don't assume anything related to that.  
> 
> Good point, most generic code should need to tolerate preemption in
> any case.  But I have nine commits queued thus far that handle some
> CONFIG_AUTO breakage or another, so a little paranoia won't go too
> far amiss.  ;-)
> 
> Remaining on my list are uses of the various CONFIG_PREEMPT* Kconfig
> options, both in code and in Makefiles.  Though who knows?  Perhaps Ankur
> or Thomas have already done that.


