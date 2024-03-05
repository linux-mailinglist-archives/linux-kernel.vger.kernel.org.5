Return-Path: <linux-kernel+bounces-93029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0078729BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C175B1F26C01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A854012D1E2;
	Tue,  5 Mar 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNfD00kJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18941760;
	Tue,  5 Mar 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675577; cv=none; b=XCHollAosba/SAq8mZ/xFk0mNUJ/vhPaMcXtM7le9CV+aXrpDP8kY3x7ynNSx4mYRmX9NlshMchDtCUmUf6f+Cjr91nO9LhBmFXZSd4CZIlC52me3H/SmZntsJiMqxJPh3aOaEwx9lYvYEuLbXScSy/GmQCOSvlLMlFW+L8TGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675577; c=relaxed/simple;
	bh=4n4cJaGiBfviqhYzvifUNZzeLtoTUltIlpkyrGbqc58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJYmUuauJPlkEPWzg82HUBgHOyFUT2zRrTmwC8pj7bcoOcTtxShvihlz+GOm0nmv0U0/QcAgxSK6LfiMZMErycOW2R7p/Qs0+LM0O3oMy95i0+aT136xFDLnpFKDRn1pdMveJSt8KNq3l1QJIW4Sourpa5Dc7WWYw/gtBlsB3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNfD00kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48144C433F1;
	Tue,  5 Mar 2024 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709675577;
	bh=4n4cJaGiBfviqhYzvifUNZzeLtoTUltIlpkyrGbqc58=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NNfD00kJ9HOzL0kU7GxCv1KsxjipP/gFA700BWmkmcvHF3eCir3me80dtBw7U0QXq
	 2ZZ5pZqvuIaaIlt80+Ot90erqx1EbegR1zd+ocXwvmHsmGlKXEunr0lXYhf0igUWvT
	 rif6WBNNN7dsdeKv/NVXVmtOuY22yuVRXW/Kygtxzh3VRGpP59I8S07Bc013ccHaty
	 Y4pEZ4t8Cp3Wyg/VgJUSOq+JMkUIti7YARE6/z/IZuBublRfyXn9Kd0El9HMbPegWj
	 l/D0F2NXnSjjTRxPCcPJHDdrNV1PIgwhoq82E5SM6SdFb/iERbdg6cGaxlTX1iXmRx
	 C7tii6ghGXVmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E26C2CE0DFE; Tue,  5 Mar 2024 13:52:56 -0800 (PST)
Date: Tue, 5 Mar 2024 13:52:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
Message-ID: <dc018dca-c9a5-4cf8-b8e4-9ecdea297b41@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <55900c6a-f181-4c5c-8de2-bca640c4af3e@paulmck-laptop>
 <10FC3F5F-AA33-4F81-9EB6-87EB2D41F3EE@joelfernandes.org>
 <99b2ccae-07f6-4350-9c55-25ec7ae065c0@paulmck-laptop>
 <CAEXW_YQ+40a1-hk5ZP+QJ54xniSutosC7MjMscJJy8fen-gU9Q@mail.gmail.com>
 <f1e77cd2-18b2-4ab1-8ce3-da2c6babbd53@paulmck-laptop>
 <CAEXW_YRDiTXJ_GwK5soSVno73yN9FUA5GjLYAOcCTtqQvPGcFA@mail.gmail.com>
 <fcaf6cad-9959-4b6d-a6e4-05ae1b2fabdc@joelfernandes.org>
 <1e8d070e-5616-4c6d-a08b-4b6e1a0a2bad@paulmck-laptop>
 <Zed5NMESl4wZk3PW@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zed5NMESl4wZk3PW@FVFF77S0Q05N>

On Tue, Mar 05, 2024 at 07:57:40PM +0000, Mark Rutland wrote:
> On Tue, Mar 05, 2024 at 09:53:42AM -0800, Paul E. McKenney wrote:
> > On Mon, Mar 04, 2024 at 04:16:01AM -0500, Joel Fernandes wrote:
> > > Hi Paul,
> > 
> > Thank you, Joel!
> > 
> > > On 3/2/2024 8:01 PM, Joel Fernandes wrote:
> > > >> As you noted, one thing that Ankur's series changes is that preemption
> > > >> can occur anywhere that it is not specifically disabled in kernels
> > > >> built with CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.  This in
> > > >> turn changes Tasks Rude RCU's definition of a quiescent state for these
> > > >> kernels, adding all code regions where preemption is not specifically
> > > >> disabled to the list of such quiescent states.
> > > >>
> > > >> Although from what I know, this is OK, it would be good to check the
> > > >> calls to call_rcu_tasks_rude() or synchronize_rcu_tasks_rude() are set
> > > >> up so as to expect these new quiescent states.  One example where it
> > > >> would definitely be OK is if there was a call to synchronize_rcu_tasks()
> > > >> right before or after that call to synchronize_rcu_tasks_rude().
> > > >>
> > > >> Would you be willing to check the call sites to verify that they
> > > >> are OK with this change in 
> > > > Yes, I will analyze and make sure those users did not unexpectedly
> > > > assume something about AUTO (i.e. preempt enabled sections using
> > > > readers).
> > > 
> > > Other than RCU test code, there are just 3 call sites for RUDE right now, all in
> > > ftrace.c.
> > > 
> > > (Long story short, PREEMPT_AUTO should not cause wreckage in TASKS_RCU_RUDE
> > > other than any preexisting wreckage that !PREEMPT_AUTO already had. Steve is on
> > > CC as well to CMIIW).
> > > 
> > > Case 1: For !CONFIG_DYNAMIC_FTRACE update of ftrace_trace_function
> > > 
> > > This config is itself expected to be slow. However seeing what it does, it is
> > > trying to make sure the global function pointer "ftrace_trace_function" is
> > > updated and any readers of that pointers would have finished reading it. I don't
> > > personally think preemption has to be disabled across the entirety of the
> > > section that calls into this function. So sensitivity to preempt disabling
> > > should not be relevant for this case IMO, but lets see if ftrace folks disagree
> > > (on CC). It has more to do with, any callers of this function pointer are no
> > > longer calling into the old function.
> > 
> > Assuming the loads from the function pointer aren't torn by the compiler,
> > they will be loaded by a single instruction, which as you say cannot
> > be preempted.  Might be good to have READ_ONCE() if they aren't already
> > in place.
> 
> As a heads-up I'm actively digging through case 1 now and I think the existing
> code is actually redundant or broken depending on architecture and
> configuration (but largely redundant, hence not seeing any reports of an
> issue).
> 
> I've dug through v3.14 up to v5.4, and I'll hopefully have a writeup of that
> out tomorrow, or in the next couple of hours if I continue after dinner...
> 
> I haven't yet looked at cases 2 or 3 yet, and I haven't convinced myself on how
> the CONFIG_DYNAMIC_FTRACE=y case works either.

Ouch!  Looking forward to seeing what you come up with.

							Thanx, Paul

> Mark.
> 
> > > Case 2: Trampoline structures accessing
> > > 
> > > For this there is a code comment that says preemption will disabled so it should
> > > not be dependent on any of the preemptiblity modes, because preempt_disable()
> > > should disable preempt with PREEMPT_AUTO.
> > > 
> > > 		/*
> > > 		 * We need to do a hard force of sched synchronization.
> > > 		 * This is because we use preempt_disable() to do RCU, but
> > > 		 * the function tracers can be called where RCU is not watching
> > > 		 * (like before user_exit()). We can not rely on the RCU
> > > 		 * infrastructure to do the synchronization, thus we must do it
> > > 		 * ourselves.
> > > 		 */
> > > 		synchronize_rcu_tasks_rude();
> > > 		[...]
> > > 		ftrace_trampoline_free(ops);
> > > 
> > > Code comment probably needs update because it says 'can not rely on RCU..' ;-)
> > 
> > My guess is that this comment is left over from when that call to
> > synchronize_rcu_tasks_rude() was open-coded.  ;-)
> > 
> > Maybe "We can not rely on vanilla RCU to do..."?
> > 
> > > My *guess* is the preempt_disable() mentioned in this case is
> > > ftrace_ops_trampoline() where trampoline-related datas tructures are accessed
> > > for stack unwinding purposes. This is a data structure protection thing AFAICS
> > > and nothing to do with "trampoline execution" itself which needs "Tasks RCU" to
> > > allow for preemption in trampolines.
> > 
> > Sounds plausible to me, but let's see what Steve's thoughts are.
> > 
> > > Case 3: This has to do with update of function graph tracing and there is the
> > > same comment as case 2, where preempt will be disabled in readers, so it should
> > > be safe for PREEMPT_AUTO (famous last words).
> > > 
> > > Though I am not yet able to locate that preempt_disable() which is not an
> > > PREEMPT_AUTO-related issue anyway. Maybe its buried in function graph tracing
> > > logic somewhere?
> > 
> > With the trampolines, isn't synchronize_rcu_tasks_rude() paired with
> > a call to synchronize_rcu_tasks()?  In that case, rude's only job is
> > getting all CPUs out of their previous sojourn in either the entry/exit
> > code or the deep idle loop.  RCU Tasks waits for each task to voluntarily
> > block, which takes care of all tasks executing elsewhere.  (Recall that
> > RCU Tasks ignores the idle tasks.)
> > 
> > > Finally, my thought also was, if any of these thread usages/cases of Tasks RCU
> > > RUDE assume working only on a CONFIG_PREEMPT_NONE=y or
> > > CONFIG_PREEMPT_VOLUNTARY=y kernel, that could be worrying but AFAICS, they don't
> > > assume anything related to that.
> > 
> > Good point, most generic code should need to tolerate preemption in
> > any case.  But I have nine commits queued thus far that handle some
> > CONFIG_AUTO breakage or another, so a little paranoia won't go too
> > far amiss.  ;-)
> > 
> > Remaining on my list are uses of the various CONFIG_PREEMPT* Kconfig
> > options, both in code and in Makefiles.  Though who knows?  Perhaps Ankur
> > or Thomas have already done that.
> > 
> > 							Thanx, Paul
> > 

