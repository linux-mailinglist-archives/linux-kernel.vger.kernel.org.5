Return-Path: <linux-kernel+bounces-72925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633BD85BACA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946661C2190A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C56773B;
	Tue, 20 Feb 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUjWxzsx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10600664CE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429320; cv=none; b=GWj6TT8bLPU6YJwYb/41XBFknClv75F7o1dy0BBqUdlvtJqbWI9AFfdwV7jE+shpIETG76JjXxX2+TD/gzen/6hoRI989kf09pWaWcmJ9EHOiVa+QG2bZlz92PfDupaW09DqP1a8yLmTtHzx/FHZYkBAOM+mTmFxIe5kUkkB3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429320; c=relaxed/simple;
	bh=q++Ve8879Npx2wq1JnlALpXBfW43mRaompH7G7hkYn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHxjho22YJHqKGujL5omH3bnmF80vV2c/JaDXNYanp1PKPHu3pW6jdW+9/i6+az+z6KT6OgdauIXrqtgfnoasrPghQa1uZfJhcRZLPx0hgbBs0IgehiCUOlKgxrZ7829GgLIq6dABBJt+rabrzU+arCqGI+2K68NGWX5qwvUpMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUjWxzsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D9C433A6;
	Tue, 20 Feb 2024 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708429319;
	bh=q++Ve8879Npx2wq1JnlALpXBfW43mRaompH7G7hkYn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUjWxzsxc7b/+LXSnMFEghOioBejkwFTOwX/XcP7a5GLe8qmThsFBC9ENzl2O6M0X
	 pGUvvtRmB+dW1/bamR9c/NQ9mjzbiwxvmDg4joH9rvwYWwhiY1Cax8/XM/cTp3GTyR
	 /NPEm8gFGBigZzbrFCe0PIOf31RI9w+DfHo6Q4yc1oSQxHABGuwYU+gyDUaZwxJGW0
	 f1RaWdUzl5HQKjtRFFWUlLh9GGdE4yPzByvHzWvu7WifbmtdDQR6jAVm5VMCQ0/FIn
	 lXICU3JuTh4AFEMfgJWJwVtzrC2PipoF3ITA0AMRNEaEK9WnpIPx8ApeMftjsKW2w+
	 QCrqqsPtKeniw==
Date: Tue, 20 Feb 2024 12:41:56 +0100
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
Subject: Re: [PATCH v10a] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <ZdSQBD_ZpWvH5SoZ@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain>
 <878r3f5s3w.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r3f5s3w.fsf@somnus>

Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 01fb50c1b17e..b93f0e6f273f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	/* Make sure we won't be trying to stop it twice in a row. */
>  	ts->timer_expires_base = 0;
>  
> -	/*
> -	 * If this CPU is the one which updates jiffies, then give up
> -	 * the assignment and let it be taken by the CPU which runs
> -	 * the tick timer next, which might be this CPU as well. If we
> -	 * don't drop this here, the jiffies might be stale and
> -	 * do_timer() never gets invoked. Keep track of the fact that it
> -	 * was the one which had the do_timer() duty last.
> -	 */
> -	if (cpu == tick_do_timer_cpu) {
> -		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> -		ts->do_timer_last = 1;
> -	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> -		ts->do_timer_last = 0;
> -	}
> -
>  	/* Skip reprogram of event if it's not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */

That should work but then you lose the optimization that resets
ts->do_timer_last even if the next timer hasn't changed.

Thanks.



> @@ -938,6 +923,21 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
>  	}
>  
> +	/*
> +	 * If this CPU is the one which updates jiffies, then give up
> +	 * the assignment and let it be taken by the CPU which runs
> +	 * the tick timer next, which might be this CPU as well. If we
> +	 * don't drop this here, the jiffies might be stale and
> +	 * do_timer() never gets invoked. Keep track of the fact that it
> +	 * was the one which had the do_timer() duty last.
> +	 */
> +	if (cpu == tick_do_timer_cpu) {
> +		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> +		ts->do_timer_last = 1;
> +	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> +		ts->do_timer_last = 0;
> +	}
> +
>  	ts->next_tick = expires;
>  
>  	/*

