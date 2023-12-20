Return-Path: <linux-kernel+bounces-6980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C543C81A009
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65F94B216A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F138DE0;
	Wed, 20 Dec 2023 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYTxO7tC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904B38DD4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AEEC433C7;
	Wed, 20 Dec 2023 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703079834;
	bh=QMljrOv897FmsVWy5N1Xz1hinrz7EiFYEPnIJAs7QUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYTxO7tCPod+y4rqctr2YHQpxphABVWY/4y3FiRw1JNEEv9Dan5eWkIViHB2JPSaG
	 Dacl3Sbn3Q4HjTXCmizka1qqIj/bkNLFWROf49sEF/uEPpHC21Z34tehaxEPdSIVdB
	 rwH4WthiRs3UBfVvqnRM/d0yTHuWZanyIWsZXeb/fdGFGZrusA1L4ukUnzUoXXm/0e
	 EvZQj/pXAJ1+EH1V/qfhSfvDR+LmCsQN9sSNuvAe0eWzoE/cmIEyiHkoYU+gUhSlfJ
	 oHxoX62pQIgCBmdaZSuI2QHWewuRVS6Gli+AWVXu6gqIfdlHGd4YKRVn6izE81kRm5
	 xAaEboEdJlS9w==
Date: Wed, 20 Dec 2023 14:43:51 +0100
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
Subject: Re: [PATCH v9 05/32] tracing/timers: Add tracepoint for tracking
 timer base is_idle flag
Message-ID: <ZYLvl06i0zIZfclG@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-6-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:27AM +0100, Anna-Maria Behnsen a écrit :
> When debugging timer code the timer tracepoints are very important. There
> is no tracepoint when the is_idle flag of the timer base changes. Instead
> of always adding manually trace_printk(), add tracepoints which can be
> easily enabled whenever required.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a detail below, again this can be posted as a delta patch or
edited before applying:

> ---
> v9: New in v9
> ---
>  include/trace/events/timer.h | 20 ++++++++++++++++++++
>  kernel/time/timer.c          |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
> index 99ada928d445..1ef58a04fc57 100644
> --- a/include/trace/events/timer.h
> +++ b/include/trace/events/timer.h
> @@ -142,6 +142,26 @@ DEFINE_EVENT(timer_class, timer_cancel,
>  	TP_ARGS(timer)
>  );
>  
> +TRACE_EVENT(timer_base_idle,
> +
> +	TP_PROTO(bool is_idle, unsigned int cpu),
> +
> +	TP_ARGS(is_idle, cpu),
> +
> +	TP_STRUCT__entry(
> +		__field( bool,		is_idle	)
> +		__field( unsigned int,	cpu	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->is_idle	= is_idle;
> +		__entry->cpu		= cpu;
> +	),
> +
> +	TP_printk("is_idle=%d cpu=%d",
> +		  __entry->is_idle, __entry->cpu)
> +);
> +
>  #define decode_clockid(type)						\
>  	__print_symbolic(type,						\
>  		{ CLOCK_REALTIME,	"CLOCK_REALTIME"	},	\
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index a81d793a43d0..46a9b96a3976 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1964,6 +1964,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  		if ((expires - basem) > TICK_NSEC)
>  			base->is_idle = true;
>  	}
> +	trace_timer_base_idle(base->is_idle, base->cpu);

This will trigger a trace everytime we loop into idle or remotely
compute the next timer. Can we move that to when base->is_idle is set
from false to true only?

>  	raw_spin_unlock(&base->lock);
>  
>  	return cmp_next_hrtimer_event(basem, expires);
> @@ -1985,6 +1986,7 @@ void timer_clear_idle(void)
>  	 * the lock in the exit from idle path.
>  	 */
>  	base->is_idle = false;
> +	trace_timer_base_idle(0, smp_processor_id());

Same here. If base->is_idle was already false, you could spare a noisy
trace.

Thanks.

>  }
>  #endif
>  
> -- 
> 2.39.2
> 

