Return-Path: <linux-kernel+bounces-139145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E789FF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FAD1C2332F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22B518130C;
	Wed, 10 Apr 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fuJ+kAUf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2C180A8F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771284; cv=none; b=SvPw0FfaScZUjNoAw9TC2hkmN/nVd/L8GtHkx7DR5+6URe+inJWAtXKggyvPikrL4u0dsiZ5sNK3QPPVQDpvUKgnx+6rVUqQWJcHPKkYSCJGk7WPFv/PACjggVY55U4ryfu3hz7gkvj5hv5qjcdKF3YHVA1uv6CBlNC8BuAUHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771284; c=relaxed/simple;
	bh=54cjhj1MvxcxwDVDiRWCuaZRtdP3D0ikbp/NE1kVtLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fglz05VwJb+/1TURDF25kCcsx5g39APvFQ8UWZBG1DUCJ4ITWWyNeRl73Di5uI2vLagsId3IxeSDLPR8Tg58OdQKeMRGAyA9gcLboahzDsGWVdhb2O4ksVX70zxlfXCjhBd4MZO9mJ8qYcDRsykIrxMZRKNMw9DBK4qz2WEFLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fuJ+kAUf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jp4lzJVKrHMBAce6M3dGqIknNVs5C5d3+JFf+6uz2ZQ=; b=fuJ+kAUfNyB88bt1nznuafax1e
	QHDIzaw+R+yS20ENp1PkiL1lrjMYC6bT/zAilLfaE3jTYBlz1LQ4K4gp7YNyTTx0siiCz2kVlJxzu
	/ZZci4NIAMTxSMPqtythJbJwLKcV16yoJFhSq/Q9eRxyWFialPSa2+xKGkN+WOdfHpX+rrv6pWF2a
	03mS9qPKtSxUd3ajQaDz1h8z16jHB5IQK1aTRhwyaT0/+34GQ7H817xF05gXLV5TGEq1EHTZ7V13L
	l5ezpm4TINWrIDCcqRCK26D/QedTH8H5qApEy7uzROI8ETDQKLmlENAVqlzrr1sJL1XHmAAIpOz6c
	crEgCKxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruc34-00000008BjW-0ppQ;
	Wed, 10 Apr 2024 17:47:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D39403004D5; Wed, 10 Apr 2024 19:47:49 +0200 (CEST)
Date: Wed, 10 Apr 2024 19:47:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V6 2/6] sched/deadline: Deferrable dl server
Message-ID: <20240410174749.GC30852@noisy.programming.kicks-ass.net>
References: <cover.1712337227.git.bristot@kernel.org>
 <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>

On Fri, Apr 05, 2024 at 07:28:01PM +0200, Daniel Bristot de Oliveira wrote:
> @@ -874,6 +895,37 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  		dl_se->dl_yielded = 0;
>  	if (dl_se->dl_throttled)
>  		dl_se->dl_throttled = 0;
> +
> +	/*
> +	 * If this is the replenishment of a deferred reservation,
> +	 * clear the flag and return.
> +	 */
> +	if (dl_se->dl_defer_armed) {
> +		dl_se->dl_defer_armed = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * A this point, if the deferred server is not armed, and the deadline
> +	 * is in the future, if it is not running already, throttle the server
> +	 * and arm the defer timer.
> +	 */
> +	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
> +	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
> +		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
> +			dl_se->dl_defer_armed = 1;
> +			dl_se->dl_throttled = 1;
> +			if (!start_dl_timer(dl_se)) {
> +				/*
> +				 * If for whatever reason (delays), if a previous timer was
> +				 *  queued but not serviced, cancel it.

(whitespace damage)

> +				 */
> +				hrtimer_try_to_cancel(&dl_se->dl_timer);
> +				dl_se->dl_defer_armed = 0;
> +				dl_se->dl_throttled = 0;
> +			}

This looks funny in that it 'obviously' should only set the variables to
1 on success, but I'm thinking it is this way because the timer (when
programming is successful) needs to observe the 1s.

That is, there is an implicit memory ordering here, perhaps put in a
comment to avoid someone 'fixing' this later?

> +		}
> +	}
>  }
>  
>  /*

> @@ -1056,8 +1117,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
>  	 * We want the timer to fire at the deadline, but considering
>  	 * that it is actually coming from rq->clock and not from
>  	 * hrtimer's time base reading.
> +	 *
> +	 * The deferred reservation will have its timer set to
> +	 * (deadline - runtime). At that point, the CBS rule will decide
> +	 * if the current deadline can be used, or if a replenishment is
> +	 * required to avoid add too much pressure on the system
> +	 * (current u > U).

(I wanted to type a comment about how this comment might not do the
subtlety justice, OTOH, fixing that might require much more text and
become unwieldy, so meh..)

>  	 */
> -	act = ns_to_ktime(dl_next_period(dl_se));
> +	if (dl_se->dl_defer_armed) {
> +		WARN_ON_ONCE(!dl_se->dl_throttled);
> +		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
> +	} else {

		/* act = deadline - rel-deadline + period */

> +		act = ns_to_ktime(dl_next_period(dl_se));

I had to look up what that function does, it either needs a better name
or I just need more exposure to this code I suppose :-)

> +	}
> +
>  	now = hrtimer_cb_get_time(timer);
>  	delta = ktime_to_ns(now) - rq_clock(rq);
>  	act = ktime_add_ns(act, delta);
> @@ -1107,6 +1180,64 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
>  #endif
>  }
>  
> +/* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
> +static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
> +
> +static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq = rq_of_dl_se(dl_se);
> +	enum hrtimer_restart restart = 0;
> +	struct rq_flags rf;
> +	u64 fw;
> +
> +	rq_lock(rq, &rf);

	guard(rq_lock)(rq, &rf);

> +	if (dl_se->dl_throttled) {
> +		sched_clock_tick();
> +		update_rq_clock(rq);
> +
> +		if (!dl_se->dl_runtime)
> +			goto unlock;
> +
> +		if (!dl_se->server_has_tasks(dl_se)) {
> +			replenish_dl_entity(dl_se);
> +			goto unlock;
> +		}
> +
> +		if (dl_se->dl_defer_armed) {
> +			/*
> +			 * First check if the server could consume runtime in background.
> +			 * If so, it is possible to push the defer timer for this amount
> +			 * of time. The dl_server_min_res serves as a limit to avoid
> +			 * forwarding the timer for a too small amount of time.
> +			 */
> +			if (dl_time_before(rq_clock(dl_se->rq),
> +				(dl_se->deadline - dl_se->runtime - dl_server_min_res))) {

:se cino=(0:0

that is, this wants to be something like:

			if (dl_time_before(rq_clock(dl_se->rq),
					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {

> +
> +				/* reset the defer timer */
> +				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
> +
> +				hrtimer_forward_now(timer, ns_to_ktime(fw));

> +				restart = 1;
> +				goto unlock;

				return HRTIMER_RESTART;

> +			}
> +
> +			dl_se->dl_defer_running = 1;
> +		}
> +
> +		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
> +
> +		if (!dl_task(dl_se->rq->curr) ||
> +			dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
> +			resched_curr(rq);
> +
> +		__push_dl_task(rq, &rf);
> +	}
> +unlock:
> +	rq_unlock(rq, &rf);
> +
> +	return restart ? HRTIMER_RESTART : HRTIMER_NORESTART;

	return HRTIMER_NORESTART;

> +}
> +
>  /*
>   * This is the bandwidth enforcement timer callback. If here, we know
>   * a task is not on its dl_rq, since the fact that the timer was running

> @@ -1320,22 +1431,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>  	return (delta * u_act) >> BW_SHIFT;
>  }
>  
> -static inline void
> -update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
> -                        int flags);
> -static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
> +s64 dl_scalled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)

%s/_scalled_/_scaled_/g ?

>  {
>  	s64 scaled_delta_exec;
>  
> -	if (unlikely(delta_exec <= 0)) {
> -		if (unlikely(dl_se->dl_yielded))
> -			goto throttle;
> -		return;
> -	}
> -
> -	if (dl_entity_is_special(dl_se))
> -		return;
> -
>  	/*
>  	 * For tasks that participate in GRUB, we implement GRUB-PA: the
>  	 * spare reclaimed bandwidth is used to clock down frequency.
> @@ -1354,8 +1453,64 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
>  	}
>  
> +	return scaled_delta_exec;
> +}
> +
> +static inline void
> +update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
> +			int flags);
> +static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
> +{
> +	s64 scaled_delta_exec;
> +
> +	if (unlikely(delta_exec <= 0)) {
> +		if (unlikely(dl_se->dl_yielded))
> +			goto throttle;
> +		return;
> +	}
> +
> +	if (dl_server(dl_se) && dl_se->dl_throttled && !dl_se->dl_defer)
> +		return;
> +
> +	if (dl_entity_is_special(dl_se))
> +		return;
> +
> +	scaled_delta_exec = dl_scalled_delta_exec(rq, dl_se, delta_exec);
> +
>  	dl_se->runtime -= scaled_delta_exec;
>  
> +	/*
> +	 * The fair server can consume its runtime while throttled (not queued/
> +	 * running as regular CFS).
> +	 *
> +	 * If the server consumes its entire runtime in this state. The server
> +	 * is not required for the current period. Thus, reset the server by
> +	 * starting a new period, pushing the activation.
> +	 */
> +	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
> +		/*
> +		 * If the server was previously activated - the starving condition
> +		 * took place, it this point it went away because the fair scheduler

                               ^ at ?

> +		 * was able to get runtime in background. So return to the initial
> +		 * state.
> +		 */
> +		dl_se->dl_defer_running = 0;
> +
> +		hrtimer_try_to_cancel(&dl_se->dl_timer);
> +
> +		replenish_dl_new_period(dl_se, dl_se->rq);
> +
> +		/*
> +		 * Not being able to start the timer seems problematic. If it could not
> +		 * be started for whatever reason, we need to "unthrottle" the DL server
> +		 * and queue right away. Otherwise nothing might queue it. That's similar
> +		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
> +		 */
> +		WARN_ON_ONCE(!start_dl_timer(dl_se));
> +
> +		return;
> +	}
> +
>  throttle:
>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
>  		dl_se->dl_throttled = 1;
> @@ -1415,9 +1570,47 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>  	}
>  }
>  
> +/*
> + * In the non-defer mode, the idle time is not accounted, as the
> + * server provides a guarantee.
> + *
> + * If the dl_server is in defer mode, the idle time is also considered
> + * as time available for the fair server. This avoids creating a
> + * regression with the rt throttling behavior where the idle time did
> + * not create a penalty to the rt schedulers.

I don't think it makes sense to refer to rt throttle behaviour here. The
goal is to delete that code, at which this comment becomes a hysterical
artifact.

I think we can easily give a rational reason for this behaviour without
referring current behaviour. That is, the point of all this is to grant
fair a chance to run, but if there is no fair task (idle), there is no
point in trying to run.

Hmm?

Also, this is done to avoid having to reprogram the timer muck when
cfs_rq::nr_running changes to/from 0 ?

> + */
> +void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
> +{
> +	s64 delta_exec, scaled_delta_exec;
> +
> +	if (!rq->fair_server.dl_defer)
> +		return;
> +
> +	/* no need to discount more */
> +	if (rq->fair_server.runtime < 0)
> +		return;
> +
> +	delta_exec = rq_clock_task(rq) - p->se.exec_start;
> +	if (delta_exec < 0)
> +		return;
> +
> +	scaled_delta_exec = dl_scalled_delta_exec(rq, &rq->fair_server, delta_exec);
> +
> +	rq->fair_server.runtime -= scaled_delta_exec;
> +
> +	if (rq->fair_server.runtime < 0) {
> +		rq->fair_server.dl_defer_running = 0;
> +		rq->fair_server.runtime = 0;
> +	}
> +
> +	p->se.exec_start = rq_clock_task(rq);
> +}
> +

