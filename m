Return-Path: <linux-kernel+bounces-140044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4538A0AB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61710285B50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2813E8B3;
	Thu, 11 Apr 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlwNPDQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D524A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822283; cv=none; b=brKZugVytOiTqK5ULRAkpJCl0BA8WBIISnkKYVqdhtTLgoRkkjxAn6Q41gk2X9/i9HwwiCPgOZeFGzCK3DI77zT+/Az0vPzBGDEWk4O+8Ol+5DT9egu5cBbadavK9VGXA4VgzH3KPyvh0gC1dspMjCY0HP+3fe2fShpKTKLI9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822283; c=relaxed/simple;
	bh=iP7Zt3axCkR/7sbaTLQSLwCfzTGKYdlpmdKbBBetESQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8dp9GDqeMUGo2c/1Qzhort+chsxoii8T+VZ7JxgnA4Wbs4Ab4oaRHTtlnoSgDPn6JxMb/T6qeRm46iD1TuiMhhs4uq49QcNvd94uhAI8pqh/86aYIcTg5Wl/kCR/ZO6KcYAsLECcEnQFspzrsYXbkbKDUev7aPBEfeWbFVIAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlwNPDQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AD0C433C7;
	Thu, 11 Apr 2024 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712822283;
	bh=iP7Zt3axCkR/7sbaTLQSLwCfzTGKYdlpmdKbBBetESQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HlwNPDQI3u2j4YMKfnZWexMlTxw3DO6eeX8ny1tSKCKmJmCXOFrPNrQGywYT95E01
	 fIf0a5i8iJyJh8ix8fB0Pfe6X8QGxL6Y+uq2Ft8LeTbSiiv6un+dyxjabABaIYwClu
	 DPCxQD+SwGqKadxQcfci7OLq1hrrBtdBZEXztut6r8aCSNWUhqPmOoGRB8zF8EH1bb
	 koA0AloFqkgga5W9orqYhjVHMyTJ3QTzHBmRB9UUgrx7ydvUKNuLbi5evGVe3h4Mb8
	 tyjTBAG1tOgL71/uNWPHHu/Z7K6mB2oe8/Z592E30OyUrSvaAffHvwakYmZUEiRzlk
	 rbh1wXq9Hc1Tg==
Message-ID: <8826ae4a-1ab8-4e61-9b9e-2a1c71bb0a78@kernel.org>
Date: Thu, 11 Apr 2024 09:57:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/6] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>, Joel Fernandes
 <joel@joelfernandes.org>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>
References: <cover.1712337227.git.bristot@kernel.org>
 <7b9c206e914ef257a2534199f25938ffafa3e59e.1712337227.git.bristot@kernel.org>
 <20240410174749.GC30852@noisy.programming.kicks-ass.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240410174749.GC30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 19:47, Peter Zijlstra wrote:
> On Fri, Apr 05, 2024 at 07:28:01PM +0200, Daniel Bristot de Oliveira wrote:
>> @@ -874,6 +895,37 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>>  		dl_se->dl_yielded = 0;
>>  	if (dl_se->dl_throttled)
>>  		dl_se->dl_throttled = 0;
>> +
>> +	/*
>> +	 * If this is the replenishment of a deferred reservation,
>> +	 * clear the flag and return.
>> +	 */
>> +	if (dl_se->dl_defer_armed) {
>> +		dl_se->dl_defer_armed = 0;
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * A this point, if the deferred server is not armed, and the deadline
>> +	 * is in the future, if it is not running already, throttle the server
>> +	 * and arm the defer timer.
>> +	 */
>> +	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
>> +	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
>> +		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
>> +			dl_se->dl_defer_armed = 1;
>> +			dl_se->dl_throttled = 1;
>> +			if (!start_dl_timer(dl_se)) {
>> +				/*
>> +				 * If for whatever reason (delays), if a previous timer was
>> +				 *  queued but not serviced, cancel it.
> 
> (whitespace damage)

OOops...


>> +				 */
>> +				hrtimer_try_to_cancel(&dl_se->dl_timer);
>> +				dl_se->dl_defer_armed = 0;
>> +				dl_se->dl_throttled = 0;
>> +			}
> 
> This looks funny in that it 'obviously' should only set the variables to
> 1 on success, but I'm thinking it is this way because the timer (when
> programming is successful) needs to observe the 1s.
> 
> That is, there is an implicit memory ordering here, perhaps put in a
> comment to avoid someone 'fixing' this later?

Yes, I will add a comment.

>> +		}
>> +	}
>>  }
>>  
>>  /*
> 
>> @@ -1056,8 +1117,20 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
>>  	 * We want the timer to fire at the deadline, but considering
>>  	 * that it is actually coming from rq->clock and not from
>>  	 * hrtimer's time base reading.
>> +	 *
>> +	 * The deferred reservation will have its timer set to
>> +	 * (deadline - runtime). At that point, the CBS rule will decide
>> +	 * if the current deadline can be used, or if a replenishment is
>> +	 * required to avoid add too much pressure on the system
>> +	 * (current u > U).
> 
> (I wanted to type a comment about how this comment might not do the
> subtlety justice, OTOH, fixing that might require much more text and
> become unwieldy, so meh..)

Yeah, I will write documentation about it, it has a "composed set of reasons" long
enough to fill more than a page. I will do it once we get the final version...

>>  	 */
>> -	act = ns_to_ktime(dl_next_period(dl_se));
>> +	if (dl_se->dl_defer_armed) {
>> +		WARN_ON_ONCE(!dl_se->dl_throttled);
>> +		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
>> +	} else {
> 
> 		/* act = deadline - rel-deadline + period */

ack

>> +		act = ns_to_ktime(dl_next_period(dl_se));
> 
> I had to look up what that function does, it either needs a better name
> or I just need more exposure to this code I suppose :-)
> 
>> +	}
>> +
>>  	now = hrtimer_cb_get_time(timer);
>>  	delta = ktime_to_ns(now) - rq_clock(rq);
>>  	act = ktime_add_ns(act, delta);
>> @@ -1107,6 +1180,64 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
>>  #endif
>>  }
>>  
>> +/* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
>> +static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
>> +
>> +static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
>> +{
>> +	struct rq *rq = rq_of_dl_se(dl_se);
>> +	enum hrtimer_restart restart = 0;
>> +	struct rq_flags rf;
>> +	u64 fw;
>> +
>> +	rq_lock(rq, &rf);
> 
> 	guard(rq_lock)(rq, &rf);

Arrhg... I knew it, just did not use it... boooh Daniel.

>> +	if (dl_se->dl_throttled) {
>> +		sched_clock_tick();
>> +		update_rq_clock(rq);
>> +
>> +		if (!dl_se->dl_runtime)
>> +			goto unlock;
>> +
>> +		if (!dl_se->server_has_tasks(dl_se)) {
>> +			replenish_dl_entity(dl_se);
>> +			goto unlock;
>> +		}
>> +
>> +		if (dl_se->dl_defer_armed) {
>> +			/*
>> +			 * First check if the server could consume runtime in background.
>> +			 * If so, it is possible to push the defer timer for this amount
>> +			 * of time. The dl_server_min_res serves as a limit to avoid
>> +			 * forwarding the timer for a too small amount of time.
>> +			 */
>> +			if (dl_time_before(rq_clock(dl_se->rq),
>> +				(dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
> 
> :se cino=(0:0
> 
> that is, this wants to be something like:
> 
> 			if (dl_time_before(rq_clock(dl_se->rq),
> 					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {

ack

>> +
>> +				/* reset the defer timer */
>> +				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
>> +
>> +				hrtimer_forward_now(timer, ns_to_ktime(fw));
> 
>> +				restart = 1;
>> +				goto unlock;
> 
> 				return HRTIMER_RESTART;
> 
>> +			}
>> +
>> +			dl_se->dl_defer_running = 1;
>> +		}
>> +
>> +		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
>> +
>> +		if (!dl_task(dl_se->rq->curr) ||
>> +			dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
>> +			resched_curr(rq);
>> +
>> +		__push_dl_task(rq, &rf);
>> +	}
>> +unlock:
>> +	rq_unlock(rq, &rf);
>> +
>> +	return restart ? HRTIMER_RESTART : HRTIMER_NORESTART;
> 
> 	return HRTIMER_NORESTART;
> 
>> +}
>> +
>>  /*
>>   * This is the bandwidth enforcement timer callback. If here, we know
>>   * a task is not on its dl_rq, since the fact that the timer was running
> 
>> @@ -1320,22 +1431,10 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
>>  	return (delta * u_act) >> BW_SHIFT;
>>  }
>>  
>> -static inline void
>> -update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
>> -                        int flags);
>> -static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
>> +s64 dl_scalled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
> 
> %s/_scalled_/_scaled_/g ?

Yeah, it is a typo, my head is constantly fighting with: "should I put a
single or a double consonant?" because of italian... I often put it when
I should not :-).

[...]

>> +	 *
>> +	 * If the server consumes its entire runtime in this state. The server
>> +	 * is not required for the current period. Thus, reset the server by
>> +	 * starting a new period, pushing the activation.
>> +	 */
>> +	if (dl_se->dl_defer && dl_se->dl_throttled && dl_runtime_exceeded(dl_se)) {
>> +		/*
>> +		 * If the server was previously activated - the starving condition
>> +		 * took place, it this point it went away because the fair scheduler
> 
>                                ^ at ?

at

>> +		 * was able to get runtime in background. So return to the initial
>> +		 * state.
>> +		 */
>> +		dl_se->dl_defer_running = 0;
>> +
>> +		hrtimer_try_to_cancel(&dl_se->dl_timer);
>> +
>> +		replenish_dl_new_period(dl_se, dl_se->rq);
>> +
>> +		/*
>> +		 * Not being able to start the timer seems problematic. If it could not
>> +		 * be started for whatever reason, we need to "unthrottle" the DL server
>> +		 * and queue right away. Otherwise nothing might queue it. That's similar
>> +		 * to what enqueue_dl_entity() does on start_dl_timer==0. For now, just warn.
>> +		 */
>> +		WARN_ON_ONCE(!start_dl_timer(dl_se));
>> +
>> +		return;
>> +	}
>> +
>>  throttle:
>>  	if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
>>  		dl_se->dl_throttled = 1;
>> @@ -1415,9 +1570,47 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
>>  	}
>>  }
>>  
>> +/*
>> + * In the non-defer mode, the idle time is not accounted, as the
>> + * server provides a guarantee.
>> + *
>> + * If the dl_server is in defer mode, the idle time is also considered
>> + * as time available for the fair server. This avoids creating a
>> + * regression with the rt throttling behavior where the idle time did
>> + * not create a penalty to the rt schedulers.
> 
> I don't think it makes sense to refer to rt throttle behaviour here. The
> goal is to delete that code, at which this comment becomes a hysterical
> artifact.

Agreed!

> I think we can easily give a rational reason for this behaviour without
> referring current behaviour. That is, the point of all this is to grant
> fair a chance to run, but if there is no fair task (idle), there is no
> point in trying to run.
> 
> Hmm?

right right, it was worth to explain why in the submission, but it is not worth
to keep in the code creating confusion.

> Also, this is done to avoid having to reprogram the timer muck when
> cfs_rq::nr_running changes to/from 0 ?

When the runtime is totally consumed in idle, the timer will be pushed away on
the change 0 to 1. IOW, to avoid boosting cfs when RT is behaving - giving space
for !rt.

-- Daniel

