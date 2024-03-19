Return-Path: <linux-kernel+bounces-107292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A603787FA92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E58D28249A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6C7C6C1;
	Tue, 19 Mar 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tr4nihV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085A65190
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839884; cv=none; b=gmjh1xd9DNNLFntTq7w0FqlRFFOXme8cZzbA+UAMc4tx4iNjXpAn0tSMRIT/ZY4ZanqVdBFj6Uv8Yr+l2YIRnQ6W/fAcnT+iL2fcR+bmugqfzUN7wR5kFi4PkGVn+VJQYk7x519TLVi248PphtgtUlO2RfIARuiVE1HHf8X4pu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839884; c=relaxed/simple;
	bh=ADlsmypvlr4K5Ss+djFQKD0ML+Ud9B5+9VJcMzQaWZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVFJagiSN90fNDJoxG0qSG7LbHT16x7u6Aa8KfBOxiQPIQyUKcMjP/mPORxkSa4++skW8iqAdnpvEdKwPqLmkyDjlnTChZsO2GZqgR2aBUfxzK8QKOqZfgZmanPJOTJebDKo/WWGC/kGNc1rd42a41/ppRA503Ue7B9BO6aitLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tr4nihV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40AAC433C7;
	Tue, 19 Mar 2024 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710839884;
	bh=ADlsmypvlr4K5Ss+djFQKD0ML+Ud9B5+9VJcMzQaWZM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Tr4nihV4V8tirh0D7kC8aEprkQb2FJloB50BEVD1bCx1/RzA2nnZHq/gZoVzQdvYP
	 +WzqoiA07ObLVHAiag4h45DlRu/KQme4WtYBPXpJO4HLbK1iRyUrbpYFY7yVr+W5Hq
	 zKwWnpueNELxCphTUO/t2j/OcDwroe67zB0hl8hmyM2IUuQPXVbefhZgLx9fXZo/+6
	 xcLifj+/KrFYNX1gdGLglM9X/1HwWPJAqLh7BqDgPQxKCaFoittyofr8NpEGnu1xh5
	 V7PjaDJIDexJ43vO2uReI/CJjWI3BYSpSIDA6HB+WwGFS1upp4KSH+6VVJCt38w+Tu
	 thYMPnYq5Bxyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E4D09CE0D20; Tue, 19 Mar 2024 02:18:00 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:18:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318230729.15497-3-frederic@kernel.org>

On Tue, Mar 19, 2024 at 12:07:29AM +0100, Frederic Weisbecker wrote:
> While running in nohz_full mode, a task may enqueue a timer while the
> tick is stopped. However the only places where the timer wheel,
> alongside the timer migration machinery's decision, may reprogram the
> next event accordingly with that new timer's expiry are the idle loop or
> any IRQ tail.
> 
> However neither the idle task nor an interrupt may run on the CPU if it
> resumes busy work in userspace for a long while in full dynticks mode.
> 
> To solve this, the timer enqueue path raises a self-IPI that will
> re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
> avoids potential locking inversion.
> 
> This is supposed to happen both for local and global timers but commit:
> 
> 	b2cf7507e186 ("timers: Always queue timers on the local CPU")
> 
> broke the global timers case with removing the ->is_idle field handling
> for the global base. As a result, global timers enqueue may go unnoticed
> in nohz_full.
> 
> Fix this with restoring the idle tracking of the global timer's base,
> allowing self-IPIs again on enqueue time.

Testing with the previous patch (1/2 in this series) reduced the number of
problems by about an order of magnitude, down to two sched_tick_remote()
instances and one enqueue_hrtimer() instance, very good!

I have kicked off a test including this patch.  Here is hoping!  ;-)

							Thanx, Paul

> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: b2cf7507e186 ("timers: Always queue timers on the local CPU")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/time/timer.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index e69e75d3858c..dee29f1f5b75 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -642,7 +642,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
>  	 * the base lock:
>  	 */
>  	if (base->is_idle) {
> -		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
> +		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED ||
> +			       tick_nohz_full_cpu(base->cpu)));
>  		wake_up_nohz_cpu(base->cpu);
>  	}
>  }
> @@ -2292,6 +2293,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
>  		 */
>  		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
>  			base_local->is_idle = true;
> +			/*
> +			 * Global timers queued locally while running in a task
> +			 * in nohz_full mode need a self-IPI to kick reprogramming
> +			 * in IRQ tail.
> +			 */
> +			if (tick_nohz_full_cpu(base_local->cpu))
> +				base_global->is_idle = true;
>  			trace_timer_base_idle(true, base_local->cpu);
>  		}
>  		*idle = base_local->is_idle;
> @@ -2364,6 +2372,8 @@ void timer_clear_idle(void)
>  	 * path. Required for BASE_LOCAL only.
>  	 */
>  	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
> +	if (tick_nohz_full_cpu(smp_processor_id()))
> +		__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
>  	trace_timer_base_idle(false, smp_processor_id());
>  
>  	/* Activate without holding the timer_base->lock */
> -- 
> 2.44.0
> 

