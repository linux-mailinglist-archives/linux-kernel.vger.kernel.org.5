Return-Path: <linux-kernel+bounces-73027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70D85BC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C9EB21D43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B15657C4;
	Tue, 20 Feb 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKZ9TzAN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D265674E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432481; cv=none; b=b2jUOeXj88jWQyedScwv8vwO5nrcO/vIkvDuLyP8TaUn4S2nr+B/BZkr04kE0TlTU3vk/UPQKQXaw0XyJsFBq4HMiN+5fBZAv6emSa2OhVVDKgOr3d5J9RxfuqWDRBg7dqvoL/kBLsMjX0/iQeZTVcZaUz4p05+i17k0vlWiJsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432481; c=relaxed/simple;
	bh=V3/ia4j/mhNRtymZZcoOw8DBsoVzTWm+h8zRwMjxjJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFv79Sjb4rhxk1sugiBIn1C4LMzsrddfdxLJ+HjUr9d4yp0DBYLzjVNuu2W9J5E3ldJ7/hMKTxCNQX6tj/f3SylFUpcF9Oe+VfY/fc8oYEIYh4iVSatquwm3ewvD9UxnSWdO+80J4o+AwvJWvXv76NtGftKEIgcFppdOaJ3fd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKZ9TzAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2CCC433F1;
	Tue, 20 Feb 2024 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708432481;
	bh=V3/ia4j/mhNRtymZZcoOw8DBsoVzTWm+h8zRwMjxjJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKZ9TzANIUGmXo7dVfk5ZEhg6fAvJSblMOjOL+ym3D9hrlUvcIiUuyw0Wpe08GpPJ
	 7PlZyACIFntFwpZYcZwkO+bJ/CQy65mq6YU30OT/H0SCRmUZALdyaIdXWXlGiggTOU
	 1zyQAndHgOA8A7GJjqH4/TxIWbTet+wuIx2CKqsWE22aKr5PzCrI7EqhvwbEvxoksV
	 mthiJcF7CDHRwEh5R1OV8si2T+P09LdPrgGV/jB9fM94HBNKGnyzcSiVrSNNORwoWP
	 5CaPLSrY1EVAkXUFVVdWMNNCA87SNheB5EJ4ef3BJ2qrWC6wJKrMHoq3OHNsNzWVVr
	 KI4R1H65BmKHg==
Date: Tue, 20 Feb 2024 13:34:38 +0100
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
Message-ID: <ZdScXhIS_G1cjaWG@localhost.localdomain>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain>
 <878r3f5s3w.fsf@somnus>
 <ZdSQBD_ZpWvH5SoZ@localhost.localdomain>
 <87zfvv4a45.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfvv4a45.fsf@somnus>

Le Tue, Feb 20, 2024 at 01:02:18PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a écrit :
> >> Frederic Weisbecker <frederic@kernel.org> writes:
> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >> index 01fb50c1b17e..b93f0e6f273f 100644
> >> --- a/kernel/time/tick-sched.c
> >> +++ b/kernel/time/tick-sched.c
> >> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >>  	/* Make sure we won't be trying to stop it twice in a row. */
> >>  	ts->timer_expires_base = 0;
> >>  
> >> -	/*
> >> -	 * If this CPU is the one which updates jiffies, then give up
> >> -	 * the assignment and let it be taken by the CPU which runs
> >> -	 * the tick timer next, which might be this CPU as well. If we
> >> -	 * don't drop this here, the jiffies might be stale and
> >> -	 * do_timer() never gets invoked. Keep track of the fact that it
> >> -	 * was the one which had the do_timer() duty last.
> >> -	 */
> >> -	if (cpu == tick_do_timer_cpu) {
> >> -		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> >> -		ts->do_timer_last = 1;
> >> -	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> >> -		ts->do_timer_last = 0;
> >> -	}
> >> -
> >>  	/* Skip reprogram of event if it's not changed */
> >>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
> >>  		/* Sanity check: make sure clockevent is actually programmed */
> >
> > That should work but then you lose the optimization that resets
> > ts->do_timer_last even if the next timer hasn't changed.
> >
> 
> Beside of this optimization thing, I see onther problem. But I'm not
> sure, if I understood it correctly: When the CPU drops the
> tick_do_timer_cpu assignment and stops the tick, it is possible, that
> this CPU nevertheless executes tick_sched_do_timer() and then reassigns
> to tick_do_timer_cpu?

Yes but in this case a timer interrupt has executed and ts->next_tick
is cleared, so the above skip reprogramm branch is not taken.

Thanks.

> 
> Then it is mandatory that we have this drop the assignment also in the
> path when the tick is already stopped. Otherwise the problem described
> in the comment could happen with stale jiffies, no?
> 
> Thanks
> 
> > Thanks.
> >
> >
> >
> >> @@ -938,6 +923,21 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >>  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
> >>  	}
> >>  
> >> +	/*
> >> +	 * If this CPU is the one which updates jiffies, then give up
> >> +	 * the assignment and let it be taken by the CPU which runs
> >> +	 * the tick timer next, which might be this CPU as well. If we
> >> +	 * don't drop this here, the jiffies might be stale and
> >> +	 * do_timer() never gets invoked. Keep track of the fact that it
> >> +	 * was the one which had the do_timer() duty last.
> >> +	 */
> >> +	if (cpu == tick_do_timer_cpu) {
> >> +		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> >> +		ts->do_timer_last = 1;
> >> +	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> >> +		ts->do_timer_last = 0;
> >> +	}
> >> +
> >>  	ts->next_tick = expires;
> >>  
> >>  	/*

