Return-Path: <linux-kernel+bounces-29182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A6830A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DFA286DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA09224C0;
	Wed, 17 Jan 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg8q5AwX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C62209F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507352; cv=none; b=fRErBmNKsZYTjzeSHDzYA5hDA/BB+SVcOMOIMtUkHYM2rrbkqRbxuqplr7Yfpp546zQl2+yYCR3MKqMhmb3bBGxW+RqbBKHEDpMh1Ukl7bi0VQvTn1KNvpglwh1KX9GU+Rb7JXXgetN7nZ1orHOEQ7AamuESuU+U1oLrMz1lHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507352; c=relaxed/simple;
	bh=jqy1DdjlJGDyd/SGVsfNqCnPGorjXpxaG+GQG8uwcAo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=no6iZyvgwcaCZHnM7kAe3fLc409sfpP0vRldo69Bw1MFYGpnN+lfR1qt1TzosvP8XLIFIeYTjP3ciFglR8lu/7s85RbtLTEjI2fITh/S9rmdKjbyPviVSsC/d7jkvQnzO2pL11d2NEFGX0GGptuUmL9YA75xApsI6yFoHxQjGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg8q5AwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52595C433F1;
	Wed, 17 Jan 2024 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705507350;
	bh=jqy1DdjlJGDyd/SGVsfNqCnPGorjXpxaG+GQG8uwcAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg8q5AwXagCTazHnxNumnwrFf+WAgr5sBDZUiY8ezKNAtrKILSqRxMR+CndQ9Ifhh
	 eNyBTx61B6tDNXVm26Bn/phc+03OQoOr/1U5dbLUq9RzCFMdcUFOS0Y1R9KnzS+Mau
	 SWNckPA2Wv8SxIkDuCnmGEAXRlyuPCA70xZKwI+g4u4WVDARrKVNThMfwiy7n1OKxP
	 1p4xF9TYod++8bOnI2ZXjHaZN1Oy5YC3CF1+HIHJ7YSQ2P7MiDLftpLJ+yXkavLd9t
	 FZtVCtou57+4dsJwoGRlweTS8jzGHfWkEppK2lnZUqDWKAVa4qHF6ps9HQcmP1yKms
	 ZVMVg8dchurng==
Date: Wed, 17 Jan 2024 17:02:27 +0100
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
Subject: Re: [PATCH v10 03/20] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <Zaf6E61X_l1Bx6Mu@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-4-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:26PM +0100, Anna-Maria Behnsen a écrit :
> @@ -889,12 +884,41 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
>  static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  {
>  	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> +	unsigned long basejiff = ts->last_jiffies;
>  	u64 basemono = ts->timer_expires_base;
> -	u64 expires = ts->timer_expires;
> +	bool timer_idle;
> +	u64 expires;
>  
>  	/* Make sure we won't be trying to stop it twice in a row. */
>  	ts->timer_expires_base = 0;
>  
> +	/*
> +	 * Now the tick should be stopped definitely - so the timer base needs
> +	 * to be marked idle as well to not miss a newly queued timer.
> +	 */
> +	expires = timer_base_try_to_set_idle(basejiff, basemono, &timer_idle);
> +	if (!timer_idle) {
> +		/*
> +		 * Do not clear tick_stopped here when it was already set - it

Can that really happen? Looking at __get_next_timer_interrupt(), you're making a
behavioural change: if base->is_idle was previously set and the next timer is
now below/equal a jiffy, base->is_idle is not going to be cleared by
__get_next_timer_interrupt().

Therefore you shouldn't observe ts->tick_stopped && !timer_idle

But I'm assuming that behavioural change wasn't intended?

> +		 * will be retained on the next idle iteration when the tick
> +		 * expired earlier than expected.

I'm a bit confused by this sentence.

> +		 */
> +		expires = basemono + TICK_NSEC;

Do you need this line?

> @@ -1147,11 +1175,6 @@ void tick_nohz_idle_stop_tick(void)
>  void tick_nohz_idle_retain_tick(void)
>  {
>  	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));

Looks like the content of tick_nohz_retain_tick() can move here now.

> -	/*
> -	 * Undo the effect of get_next_timer_interrupt() called from
> -	 * tick_nohz_next_event().
> -	 */
> -	timer_clear_idle();
>  }

Thanks.

