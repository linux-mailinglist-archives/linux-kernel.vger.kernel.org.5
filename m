Return-Path: <linux-kernel+bounces-29234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB81830B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3B41F24287
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C876224D3;
	Wed, 17 Jan 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8rDEUXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8731DFEA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705509935; cv=none; b=o65QE7o61WgYAUp4KEu0fMqYabD/KKOvDz/eCoCQXAIrETsPHhNNXW8849M94dMER9jSdYRa70+XQWxhZa2or8RD5YLKw+66Ibq0FqnTBJkSFEVWEaWjLCxX2BHWtjcLXDqT/NDIjprnUjUotdUEfUy2Sx880cV5HrNU0q1AZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705509935; c=relaxed/simple;
	bh=4MegXCDgR2Hm6ekLa5Z5V+6TsjyBquUqyY7PrvhPYAg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=WDM1TjQXShz4B3YE2OZ1WElGfcvrw4UH1S6uqx0ChPiOvTLR8Ip9nGja0u9dXQQEm17fGuWhR6hCowWq3tTCqAuNUdcbtcD8GT60UpOiNleoT9bIPT7GzjF8LRYU/uqEVw2aBDctpxYqm8iNFhDVjLhJST0lfr2Nw1Few+SZWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8rDEUXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C2C433F1;
	Wed, 17 Jan 2024 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705509935;
	bh=4MegXCDgR2Hm6ekLa5Z5V+6TsjyBquUqyY7PrvhPYAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8rDEUXle8rnkbaWen/weqQwkZHFgq2pyg9itw366gDqGWzdMNt2P0TW1Su8L3Xt+
	 2LfnjZkDIJJ4HVc9VNUUNOKveu9QQ+ElVUU3FUk0a7n0uYFLaaOqfTBOm3lF8OloH5
	 SwaEqgKpgeerp7HPY3Mnnqny0L8bI292QMoRqJJyylrKneE0VmyrlijdsMy4PdF6lM
	 mPflbkumFO2CaT61cslZVLUbt2t84tErvSSZWB5ZeMDVOikOZ7UkMK1Ry5bsR8ytor
	 qMMDsPw3V8E2WCVEoswahVmaXPs+dtjxbRu2VY+IS53U5M8cOQFVNUYVEw6JyM81pj
	 2frBa0vxLX3hw==
Date: Wed, 17 Jan 2024 17:45:31 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 04/20] timers: Optimization for
 timer_base_try_to_set_idle()
Message-ID: <ZagEK9l06c_7F3pH@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-5-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:27PM +0100, Anna-Maria Behnsen a écrit :
> When tick is stopped also the timer base is_idle flag is set. When
> reentering the timer_base_try_to_set_idle() with the tick stopped, there is
> no need to check whether the timer base needs to be set idle again. When a
> timer was enqueued in the meantime, this is already handled by the
> tick_nohz_next_event() call which was executed before
> tick_nohz_stop_tick().
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/tick-sched.c |  2 +-
>  kernel/time/timer.c      | 11 ++++++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c6223afc801f..27f1a2ae7f39 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -886,7 +886,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
>  	unsigned long basejiff = ts->last_jiffies;
>  	u64 basemono = ts->timer_expires_base;
> -	bool timer_idle;
> +	bool timer_idle = ts->tick_stopped;
>  	u64 expires;
>  
>  	/* Make sure we won't be trying to stop it twice in a row. */
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 3a668060692e..2f69a485a070 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1999,13 +1999,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>   * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
>   * @basej:	base time jiffies
>   * @basem:	base time clock monotonic
> - * @idle:	pointer to store the value of timer_base->is_idle
> + * @idle:	pointer to store the value of timer_base->is_idle on return;
> + *		*idle contains the information whether tick was already stopped
>   *
> - * Returns the tick aligned clock monotonic time of the next pending
> - * timer or KTIME_MAX if no timer is pending.
> + * Returns the tick aligned clock monotonic time of the next pending timer or
> + * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX is
> + * returned as well.
>   */
>  u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
>  {
> +	if (*idle)
> +		return KTIME_MAX;

Ok now I see the reason behind the behavioural change.

So either:

* We remove the old behaviour consisting in clearing base->is_idle if the new
  next timer is within a jiffy while the tick is stopped. But then the changelog
  from the previous patch should state that and comments must be clarified.

or:

* We restore the old behaviour, making things a bit more complicated I guess.

Thanks.

