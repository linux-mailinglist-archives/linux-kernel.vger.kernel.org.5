Return-Path: <linux-kernel+bounces-92917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C2872818
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B5F1F26393
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A70286AC0;
	Tue,  5 Mar 2024 19:57:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF65C601;
	Tue,  5 Mar 2024 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668668; cv=none; b=LVT/2LN6PF9O8J35lq4YyoKGRYHrv6SqBMCH2PHk1TLUZIYoBna4zAIYL7gLgHWwd9L3zT7Tb3tMzAt0WIzUYoRFMreiN0VlzSOjCn2GWFDesx4R1tsXYosDtoJvAuBCO/LKIT2rYzQAil84P81MjtmK2ukj/427TUp1lSE3CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668668; c=relaxed/simple;
	bh=aYz9x/2baT4VzDD9DzcaMPV6cSDul7JABLqGj4Vy7fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMPpQ3dMVlwxiJZPPPv+G+Y4wcfQKT+pTR+K3yEls29BIfnAPV9E47SS7sU6dzWNu49s0FLRufxBCtaE0jdgYtHeXgf2d3AUmH1Gr0/M7T9FzXPZHgtiudNPUwzM2SuNVF5nCo+3vcyTVSF0azW8fel02NJOsjaGwN8+DOG/VDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C4D1FB;
	Tue,  5 Mar 2024 11:58:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9325C3F73F;
	Tue,  5 Mar 2024 11:57:43 -0800 (PST)
Date: Tue, 5 Mar 2024 19:57:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <Zed5NMESl4wZk3PW@FVFF77S0Q05N>
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
 <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
 <1e8d070e-5616-4c6d-a08b-4b6e1a0a2bad@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8d070e-5616-4c6d-a08b-4b6e1a0a2bad@paulmck-laptop>

On Tue, Mar 05, 2024 at 09:53:42AM -0800, Paul E. McKenney wrote:
> On Mon, Mar 04, 2024 at 04:16:01AM -0500, Joel Fernandes wrote:
> > Hi Paul,
> 
> Thank you, Joel!
> 
> > On 3/2/2024 8:01 PM, Joel Fernandes wrote:
> > >> As you noted, one thing that Ankur's series changes is that preemption
> > >> can occur anywhere that it is not specifically disabled in kernels
> > >> built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.  This in
> > >> turn changes Tasks Rude RCU's definition of a quiescent state for these
> > >> kernels, adding all code regions where preemption is not specifically
> > >> disabled to the list of such quiescent states.
> > >>
> > >> Although from what I know, this is OK, it would be good to check the
> > >> calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
> > >> up so as to expect these new quiescent states.  One example where it
> > >> would definitely be OK is if there was a call to synchronize_rcu_tasks()
> > >> right before or after that call to synchronize_rcu_tasks_rude().
> > >>
> > >> Would you be willing to check the call sites to verify that they
> > >> are OK with this change in 
> > > Yes, I will analyze and make sure those users did not unexpectedly
> > > assume something about AUTO (i.e. preempt enabled sections using
> > > readers).
> > 
> > Other than RCU test code, there are just 3 call sites for RUDE right now, all in
> > ftrace.c.
> > 
> > (Long story short, PREEMPT_AUTO should not cause wreckage in TASKS_RCU_RUDE
> > other than any preexisting wreckage that !PREEMPT_AUTO already had. Steve is on
> > CC as well to CMIIW).
> > 
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

As a heads-up I'm actively digging through case 1 now and I think the existing
code is actually redundant or broken depending on architecture and
configuration (but largely redundant, hence not seeing any reports of an
issue).

I've dug through v3.14 up to v5.4, and I'll hopefully have a writeup of that
out tomorrow, or in the next couple of hours if I continue after dinner...

I haven't yet looked at cases 2 or 3 yet, and I haven't convinced myself on how
the CONFIG_DYNAMIC_FTRACE=y case works either.

Mark.

> > Case 2: Trampoline structures accessing
> > 
> > For this there is a code comment that says preemption will disabled so it should
> > not be dependent on any of the preemptiblity modes, because preempt_disable()
> > should disable preempt with PREEMPT_AUTO.
> > 
> > 		/*
> > 		 * We need to do a hard force of sched synchronization.
> > 		 * This is because we use preempt_disable() to do RCU, but
> > 		 * the function tracers can be called where RCU is not watching
> > 		 * (like before user_exit()). We can not rely on the RCU
> > 		 * infrastructure to do the synchronization, thus we must do it
> > 		 * ourselves.
> > 		 */
> > 		synchronize_rcu_tasks_rude();
> > 		[...]
> > 		ftrace_trampoline_free(ops);
> > 
> > Code comment probably needs update because it says 'can not rely on RCU..' ;-)
> 
> My guess is that this comment is left over from when that call to
> synchronize_rcu_tasks_rude() was open-coded.  ;-)
> 
> Maybe "We can not rely on vanilla RCU to do..."?
> 
> > My *guess* is the preempt_disable() mentioned in this case is
> > ftrace_ops_trampoline() where trampoline-related datas tructures are accessed
> > for stack unwinding purposes. This is a data structure protection thing AFAICS
> > and nothing to do with "trampoline execution" itself which needs "Tasks RCU" to
> > allow for preemption in trampolines.
> 
> Sounds plausible to me, but let's see what Steve's thoughts are.
> 
> > Case 3: This has to do with update of function graph tracing and there is the
> > same comment as case 2, where preempt will be disabled in readers, so it should
> > be safe for PREEMPT_AUTO (famous last words).
> > 
> > Though I am not yet able to locate that preempt_disable() which is not an
> > PREEMPT_AUTO-related issue anyway. Maybe its buried in function graph tracing
> > logic somewhere?
> 
> With the trampolines, isn't synchronize_rcu_tasks_rude() paired with
> a call to synchronize_rcu_tasks()?  In that case, rude's only job is
> getting all CPUs out of their previous sojourn in either the entry/exit
> code or the deep idle loop.  RCU Tasks waits for each task to voluntarily
> block, which takes care of all tasks executing elsewhere.  (Recall that
> RCU Tasks ignores the idle tasks.)
> 
> > Finally, my thought also was, if any of these thread usages/cases of Tasks RCU
> > RUDE assume working only on a CONFIG_PREEMPT_NONE=y or
> > CONFIG_PREEMPT_VOLUNTARY=y kernel, that could be worrying but AFAICS, they don't
> > assume anything related to that.
> 
> Good point, most generic code should need to tolerate preemption in
> any case.  But I have nine commits queued thus far that handle some
> CONFIG_AUTO breakage or another, so a little paranoia won't go too
> far amiss.  ;-)
> 
> Remaining on my list are uses of the various CONFIG_PREEMPT* Kconfig
> options, both in code and in Makefiles.  Though who knows?  Perhaps Ankur
> or Thomas have already done that.
> 
> 							Thanx, Paul
> 

