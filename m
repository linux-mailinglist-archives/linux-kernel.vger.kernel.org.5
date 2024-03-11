Return-Path: <linux-kernel+bounces-98442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601F2877A38
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA881F21D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1B1FA1;
	Mon, 11 Mar 2024 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwAKF7/r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB71851;
	Mon, 11 Mar 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710129363; cv=none; b=bL1vljHRQNJDOSA/6GzFanEscJaEpvXaiDcQkRIuOB/UTCsx+1sgMZr/T3hUKoIsvfAw7kcMXtiJPMPwS31tED5VKPy5X2v4Lw33n7xgRlbg+HiJAxnuCPoHprQgsJleRWPa2nVy2bji2xpT+8qdmwltD30C0BbnYbvZncbsdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710129363; c=relaxed/simple;
	bh=y04QF4+5cZz4ZOvx0ly7MHtfHjrzslgDE4Mwuna6xFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrLwhJZjP86ZohVFsvX9ASb8CsnFdb8UYhRk9JxvZfSNIyIG8ottdCvfLukieQ5hltp5tcBqACUDIMGAFxF62s8maLf7sCTtMYbzwhDRKl8mObWuDtCrQlurhzhzDlzmZJtUBXt9cZ03pXRK+HA3UPZ5M7IZEVmgS63jZPB4a8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwAKF7/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06164C433F1;
	Mon, 11 Mar 2024 03:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710129363;
	bh=y04QF4+5cZz4ZOvx0ly7MHtfHjrzslgDE4Mwuna6xFs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YwAKF7/rSvI9BD+26YZyKnY2a3DAPfQtqb1ZH/8TkRthXLUi0J/yaazBgh8S2EXvp
	 CZtc5KfRaUznkopVxZ6nTAMHXwjWIqeeidUq4YX2HhXmCKzojxcmjve4uHsH7EBoxT
	 HTr2wpwPXi2t6rRI9dyw5Dm0ztMrC3oX7bfLKdsHU2fyarRn85MCbNoGYyyF+FprxL
	 KJ6/Nk98D3plXui//Pu36xL1aPnKIVZRiSvIi915lyGjaumQsYNJQsNabglK+M+/82
	 9KRxiYNoyhGWtAyhR/LXbot47UimjNcc0b4qMGgWhNW6TMWVdPqDUeQBBffeiremiz
	 D2frXILxYeIsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 971EDCE129E; Sun, 10 Mar 2024 20:56:02 -0700 (PDT)
Date: Sun, 10 Mar 2024 20:56:02 -0700
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
Message-ID: <0965542e-80a7-4837-b14e-903c635aa828@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>

On Sun, Mar 10, 2024 at 08:48:28PM -0400, Joel Fernandes wrote:
> On 3/10/2024 2:56 PM, Paul E. McKenney wrote:
> > On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
> >> Hello Ankur and Paul,
> >>
> >> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
> >>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
> >>> states for read-side critical sections via rcu_all_qs().
> >>> One reason why this was necessary: lacking preempt-count, the tick
> >>> handler has no way of knowing whether it is executing in a read-side
> >>> critical section or not.
> >>>
> >>> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
> >>> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
> >>> not provide for quiescent states via rcu_all_qs().
> >>>
> >>> So, use the availability of preempt_count() to report quiescent states
> >>> in rcu_flavor_sched_clock_irq().
> >>>
> >>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> >>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >>> ---
> >>>  kernel/rcu/tree_plugin.h | 11 +++++++----
> >>>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>> index 26c79246873a..9b72e9d2b6fe 100644
> >>> --- a/kernel/rcu/tree_plugin.h
> >>> +++ b/kernel/rcu/tree_plugin.h
> >>> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
> >>>   */
> >>>  static void rcu_flavor_sched_clock_irq(int user)
> >>>  {
> >>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> >>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> >>> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> >>> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
> >>
> >> I was wondering if it makes sense to even support !PREEMPT_RCU under
> >> CONFIG_PREEMPT_AUTO.
> >>
> >> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
> >> the next tick boundary in the worst case, with all preempt modes including
> >> the preempt=none mode.
> >>
> >> Considering this, does it makes sense for RCU to be non-preemptible in
> >> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
> >> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
> >> from happening, because rcu_read_lock() would preempt_disable().
> > 
> > Yes, it does make sense for RCU to be non-preemptible in kernels
> > built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
> > CONFIG_PREEMPT_VOLUNTARY=y.
> > As noted in earlier discussions, there are
> 
> Sorry if I missed a discussion, appreciate a link.

It is part of the discussion of the first version of this patch series,
if I recall correctly.

> > systems that are adequately but not abundantly endowed with memory.
> > Such systems need non-preemptible RCU to avoid preempted-reader OOMs.
> 
> Then why don't such systems have a problem with CONFIG_PREEMPT_DYNAMIC=y and
> preempt=none mode? CONFIG_PREEMPT_DYNAMIC forces CONFIG_PREEMPT_RCU=y. There's
> no way to set CONFIG_PREEMPT_RCU=n with CONFIG_PREEMPT_DYNAMIC=y and
> preempt=none boot parameter.  IMHO, if this feature is inconsistent with
> CONFIG_PREEMPT_DYNAMIC, that makes it super confusing.  In fact, I feel
> CONFIG_PREEMPT_AUTO should instead just be another "preempt=auto" boot parameter
> mode added to CONFIG_PREEMPT_DYNAMIC feature, otherwise the proliferation of
> CONFIG_PREEMPT config options is getting a bit insane. And likely going to be
> burden to the users configuring the PREEMPT Kconfig option IMHO.

Because such systems are built with CONFIG_PREEMPT_DYNAMIC=n.

You could argue that we should just build with CONFIG_PREEMPT_AUTO=n,
but the long-term goal of eliminating cond_resched() will make that
ineffective.

> > Note well that non-preemptible RCU explicitly disables preemption across
> > all RCU readers.
> 
> Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
> being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
> preemption in preempt=none. So the "Don't preempt the kernel" behavior has
> changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
> CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
> the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
> to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
> kernel but are worried about reader preemptions.

Such users can simply avoid building with either CONFIG_PREEMPT_NONE=y
or with CONFIG_PREEMPT_VOLUNTARY=y.  They might also experiment with
CONFIG_RCU_BOOST=y, and also with short timeouts until boosting.
If that doesn't do what they need, we talk with them and either help
them configure their kernels, make RCU do what they need, or help work
out some other way for them to get their jobs done.

> That aside, as such, I do agree your point of view, that preemptible readers
> presents a problem to folks using preempt=none in this series and we could
> decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
> just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
> consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a
> week from now, no one will likely be able to tell the difference ;-). So IMHO
> either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
> optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.
> 
> Let me know if I missed something.

Why not key off of the value of CONFIG_PREEMPT_DYNAMIC?  That way,
if both CONFIG_PREEMPT_AUTO=y and CONFIG_PREEMPT_DYNAMIC=y, RCU is
always preemptible.  Then CONFIG_PREEMPT_DYNAMIC=y enables boot-time
(and maybe even run-time) switching between preemption flavors, while
CONFIG_PREEMPT_AUTO instead enables unconditional preemption of any
region of code that has not explicitly disabled preemption (or irq or
bh or whatever).

But one way or another, we really do need non-preemptible RCU in
conjunction with CONFIG_PREEMPT_AUTO=y.

Also, I don't yet see CONFIG_PREEMPT_AUTO in -next.

							Thanx, Paul

