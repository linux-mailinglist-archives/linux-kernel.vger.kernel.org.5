Return-Path: <linux-kernel+bounces-73219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAC85BF84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369E6B22038
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369074E35;
	Tue, 20 Feb 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuCOz0bV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30274E17
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441843; cv=none; b=fn9bevkPF7tJajIpn8YrCflckDrpB1PfTjwoEig9OcpCTaNBeCDbh2D19HOnEM9Xh5hAgPDA6FGlTdJMVUWuIMPWpwaiOopKLfIcushjOlpJijPz5qKregUSTbp0QcS6vMS68n6aFu2TzbprTv1wGDMIWq1Eb6JCM9sPvneFibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441843; c=relaxed/simple;
	bh=gq82WFa6IDYKiSGDJkwUkXHp2KiwHIz0de8K52yYK3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkCTR6+rnGfz8uBCfWomtFGst7/R/kDVtJp8xaKTTWU+wkqYRN3daVkgC+zNxgJXHAihIoJgKnM3XMm6pfojHg96iO8/GrGrr1cffazt+elaRR3L/H5o4CTw6ND+FnUvVLMmXpfd0WkU7woDQZkvw0upvosIVQ4BuV65V7Mr0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuCOz0bV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C84C433C7;
	Tue, 20 Feb 2024 15:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441842;
	bh=gq82WFa6IDYKiSGDJkwUkXHp2KiwHIz0de8K52yYK3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuCOz0bVQTkDORMbxMRelpJRa2dDOyb8VhgF0LHY9h4/5+ZKSUsufcCuH+IfKZZ84
	 RCvreHuC87YqQN2A918ySqI7RerdPT/P+OaN8SPE4W5ZdeEUp65emWz/3sYXDvo91B
	 mlw46zXpYEHTzXyXaO/NwUQ3G15kACtXMRwVVTJ2KFIU+KRZrHXWsxIHRhsjcBnYGl
	 Z7p+wNWTfJpJf9oQyvjKVzD1YZ1a1UFwo6f6oBCZDA+PlMI8i6lmNiSuGv8E308Dr7
	 6qR54sRuUwwmSJcYKilMV3CJOG4+wxiDu8EgxB9GPn52v/Kj5R94XJR7IStqSLvY7J
	 kVHgKciRF+VYQ==
Date: Tue, 20 Feb 2024 16:10:40 +0100
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
Message-ID: <ZdTA8N7TkGG66Ay6@lothringen>
References: <20240115143743.27827-4-anna-maria@linutronix.de>
 <20240219085236.10624-1-anna-maria@linutronix.de>
 <ZdPYEzno3KqIPo4S@localhost.localdomain>
 <878r3f5s3w.fsf@somnus>
 <ZdSQBD_ZpWvH5SoZ@localhost.localdomain>
 <87zfvv4a45.fsf@somnus>
 <ZdScXhIS_G1cjaWG@localhost.localdomain>
 <87ttm344me.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttm344me.fsf@somnus>

On Tue, Feb 20, 2024 at 03:00:57PM +0100, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Tue, Feb 20, 2024 at 01:02:18PM +0100, Anna-Maria Behnsen a écrit :
> >> Frederic Weisbecker <frederic@kernel.org> writes:
> >> 
> >> > Le Tue, Feb 20, 2024 at 11:48:19AM +0100, Anna-Maria Behnsen a écrit :
> >> >> Frederic Weisbecker <frederic@kernel.org> writes:
> >> >> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> >> >> index 01fb50c1b17e..b93f0e6f273f 100644
> >> >> --- a/kernel/time/tick-sched.c
> >> >> +++ b/kernel/time/tick-sched.c
> >> >> @@ -895,21 +895,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >> >>  	/* Make sure we won't be trying to stop it twice in a row. */
> >> >>  	ts->timer_expires_base = 0;
> >> >>  
> >> >> -	/*
> >> >> -	 * If this CPU is the one which updates jiffies, then give up
> >> >> -	 * the assignment and let it be taken by the CPU which runs
> >> >> -	 * the tick timer next, which might be this CPU as well. If we
> >> >> -	 * don't drop this here, the jiffies might be stale and
> >> >> -	 * do_timer() never gets invoked. Keep track of the fact that it
> >> >> -	 * was the one which had the do_timer() duty last.
> >> >> -	 */
> >> >> -	if (cpu == tick_do_timer_cpu) {
> >> >> -		tick_do_timer_cpu = TICK_DO_TIMER_NONE;
> >> >> -		ts->do_timer_last = 1;
> >> >> -	} else if (tick_do_timer_cpu != TICK_DO_TIMER_NONE) {
> >> >> -		ts->do_timer_last = 0;
> >> >> -	}
> >> >> -
> >> >>  	/* Skip reprogram of event if it's not changed */
> >> >>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
> >> >>  		/* Sanity check: make sure clockevent is actually programmed */
> >> >
> >> > That should work but then you lose the optimization that resets
> >> > ts->do_timer_last even if the next timer hasn't changed.
> >> >
> >> 
> >> Beside of this optimization thing, I see onther problem. But I'm not
> >> sure, if I understood it correctly: When the CPU drops the
> >> tick_do_timer_cpu assignment and stops the tick, it is possible, that
> >> this CPU nevertheless executes tick_sched_do_timer() and then reassigns
> >> to tick_do_timer_cpu?
> >
> > Yes but in this case a timer interrupt has executed and ts->next_tick
> > is cleared, so the above skip reprogramm branch is not taken.
> >
> 
> Yes... So I need to change it without dropping the
> optimization. Otherwise someone might complain about it.
> 
> Two possible solutions:
> 
> a) split out this if/else thing for dropping the tick_do_timer_cpu
>    assignment into a separate function and call it:
>    - before the return in the skip reprogramm branch
>    - and after the if clause which contains stopping the tick (where it
>      is executed in the current proposal)
> 
> b) Take my current proposal and add before the return in the skip
>    reprogramm branch the following lines:
> 
>    if (tick_do_timer_cpu != TICK_DO_TIMER_NONE)
>    	ts->do_timer_last = 0;
> 
>    as the first part of the tick_do_timer_cpu/last logic shouldn't be
>    required (because then also ts->next_tick is already cleared).
> 
> What do you prefere? Or do you prefere something else?

Wouldn't the following work? If timer_idle is false, then the tick isn't
even stopped and there is nothing to do? So you can early return.

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fdd57f1af1d7..1b2984acafbd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -924,6 +924,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		expires = ts->timer_expires;
 	}
 
+	if (!timer_idle)
+		return;
+
 	/*
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs

