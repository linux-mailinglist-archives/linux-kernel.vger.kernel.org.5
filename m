Return-Path: <linux-kernel+bounces-98300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB28877817
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B041F21185
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258D39FC5;
	Sun, 10 Mar 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZpglDtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488439846;
	Sun, 10 Mar 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096963; cv=none; b=ULZ5ZwkcF+397l2puM0qwVMG0Clomzdzr1mhnhQTG1Hc/zHh24xu9ecuHMCkZM++a3l7OTAjYXWwmht/1tnXt/fMACVimcObxDXhITE5CZ3rs2EIEqp3LV5yKdPF5y2//7ErVSkBSjlrdlEjRu5QMB6T14CbN8uiInKiBjk9YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096963; c=relaxed/simple;
	bh=zWJfWBEp3dsUNUz7ef/tgjV61X9sOnNe47Uoh63sW0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crgEdQyiBBhkXgE3mhawlDcP5mGpp3pzXvowSongg+2E74JzesAfpD69n/FJug7nDf8dGiqICP2oMVJDXA0rtDPckY6ClJedhoyxCyAEhj+m7ZtM9prxKBH5Jeu7vR65YbvWvQ3CwpkOFudR/XwiDFHOnjP/rTxLgJ5ucLqo8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZpglDtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2777BC433F1;
	Sun, 10 Mar 2024 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710096963;
	bh=zWJfWBEp3dsUNUz7ef/tgjV61X9sOnNe47Uoh63sW0g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XZpglDtMPrfS4nN0wSsZkIpmkFigyMpHYGb6G5RaOGxo7nLdNxRDNkgFpwiXSS105
	 QpsOeIbknn2IQ3pOImrQbsGbYdTYspVtYugWk80JUK/bCMCazgBTS4VJ+Ik5C+pDwK
	 2uuDo6b5tHHv4+8x3RLsK59lfYmdjJCCOTO6ddqzBTqp43dg5YQ0Hq/gF0pNatQG0I
	 beFv1wO4ricatAB6iH5s6wlLl8xLkvyBxcuONIBoIy6OQfa6AkrnBCRQ03frL+MDuX
	 0589hzLWyCIpGw7m1e74BpfkcfRXC5mxVK6UNtB3TlCDhej3kBsdugP1wPHX1WyIoK
	 Cz31+30YLqXEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7C82CE0556; Sun, 10 Mar 2024 11:56:02 -0700 (PDT)
Date: Sun, 10 Mar 2024 11:56:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
	jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
	andrew.cooper3@citrix.com, bristot@kernel.org,
	mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
	mattst88@gmail.com, krypton@ulrich-teichert.org,
	rostedt@goodmis.org, David.Laight@aculab.com, richard@nod.at,
	mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Message-ID: <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310100330.GA2705505@joelbox2>

On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
> Hello Ankur and Paul,
> 
> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
> > With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> > states for read-side critical sections via rcu_all_qs().
> > One reason why this was necessary: lacking preempt-count, the tick
> > handler has no way of knowing whether it is executing in a read-side
> > critical section or not.
> > 
> > With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
> > PREEMPT_RCU=n). This means that cond_resched() is a stub which does
> > not provide for quiescent states via rcu_all_qs().
> > 
> > So, use the availability of preempt_count() to report quiescent states
> > in rcu_flavor_sched_clock_irq().
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  kernel/rcu/tree_plugin.h | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 26c79246873a..9b72e9d2b6fe 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
> >   */
> >  static void rcu_flavor_sched_clock_irq(int user)
> >  {
> > -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> > +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> > +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> > +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
> 
> I was wondering if it makes sense to even support !PREEMPT_RCU under
> CONFIG_PREEMPT_AUTO.
> 
> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
> the next tick boundary in the worst case, with all preempt modes including
> the preempt=none mode.
> 
> Considering this, does it makes sense for RCU to be non-preemptible in
> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
> from happening, because rcu_read_lock() would preempt_disable().

Yes, it does make sense for RCU to be non-preemptible in kernels
built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
CONFIG_PREEMPT_VOLUNTARY=y.  As noted in earlier discussions, there are
systems that are adequately but not abundantly endowed with memory.
Such systems need non-preemptible RCU to avoid preempted-reader OOMs.
Note well that non-preemptible RCU explicitly disables preemption across
all RCU readers.

							Thanx, Paul


> To that end, I wonder if CONFIG_PREEMPT_AUTO should select CONFIG_PREEMPTION
> (or CONFIG_PREEMPT_BUILD, not sure which) as well because it does cause
> kernel preemption. That then forces selection of CONFIG_PREEMPT_RCU as well.
> 
> thanks,
> 
>  - Joel
> 
> 
> 
> 
> 
> 
> 
> >  
> >  		/*
> >  		 * Get here if this CPU took its interrupt from user
> > -		 * mode or from the idle loop, and if this is not a
> > -		 * nested interrupt.  In this case, the CPU is in
> > -		 * a quiescent state, so note it.
> > +		 * mode, from the idle loop without this being a nested
> > +		 * interrupt, or while not holding a preempt count.
> > +		 * In this case, the CPU is in a quiescent state, so note
> > +		 * it.
> >  		 *
> >  		 * No memory barrier is required here because rcu_qs()
> >  		 * references only CPU-local variables that other CPUs
> > -- 
> > 2.31.1
> > 

