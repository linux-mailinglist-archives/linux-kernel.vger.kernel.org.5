Return-Path: <linux-kernel+bounces-135941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E289CD90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5151F2495E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EC81487E9;
	Mon,  8 Apr 2024 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmsjPJ7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF0495CB;
	Mon,  8 Apr 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611746; cv=none; b=ESjhSneVbZSVUCPnY7Wd1eWMQxmI0eBuaEVRxCGubcnmXEdAK3Sfe4Ii/XEJQC4Mc9VyacfK26vADwDSDLhh/NzPypwMLB9xrDVQJ+auvwvk3RK5PKMx0wnViULH1+GvOvkfYt7gDKDakVGgWzaqOS6ttO4L6jgHzuqBFHtyZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611746; c=relaxed/simple;
	bh=b9zm69YyzYDWwGcIyc+2QzF3WetCtaijzlqkIvHbTRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHf9+7KF3ujGJsO69iL9wL3s6pphGPxyJMD8z/swZjeyHQJpNYb9krwY1EZSrvMVY9PhWfE5Vik6mWV8KIg1grpuMli1Fpn5aqtc7Exi0cHRU4/tVHRXMBVKGvUQCSqnjnoVWbPscWNk3gFguj6HCDcLE+cmgBXDKqgrgdbzpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmsjPJ7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD47C433F1;
	Mon,  8 Apr 2024 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712611746;
	bh=b9zm69YyzYDWwGcIyc+2QzF3WetCtaijzlqkIvHbTRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmsjPJ7NG90s04vEQU4fL1/nHsAzU3ifvRZiiOUXvXb/5k1D8Me0QZnTLAkpBMnBm
	 iSkWKwXDXQPYW9gPQ5JaVf36cijcICsH7s/i6vqq3CrN1/4HXVdeC7As2zMkss0KYZ
	 8D8ouunUOdpEsfHaU5o4+bjb3ZpEKWvlZeqhjMfHZ0pG2p3544+mzObvQ2KCrQzfkG
	 nlP+U14YLlGcsYOnrRCUspbiFc0hjivATpf2PPV7AAluIj1DJMj7iblhXvUSqD89C1
	 y8y213watDoybYaavzPdp6i4KSRolSXVVg9dWrRhX6vVOBSaGPUSaA9QV4FF3JOKnX
	 M/GI00UkaFweQ==
Date: Mon, 8 Apr 2024 23:29:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <ZhRhn1B0rMSNv6mV@pavilion.home>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322065208.60456-3-bigeasy@linutronix.de>

Le Fri, Mar 22, 2024 at 07:48:22AM +0100, Sebastian Andrzej Siewior a écrit :
> A signal is delivered by raising irq_work() which works from any context
> including NMI. irq_work() can be delayed if the architecture does not
> provide an interrupt vector. In order not to lose a signal, the signal
> is injected via task_work during event_sched_out().
> 
> Instead going via irq_work, the signal could be added directly via
> task_work. The signal is sent to current and can be enqueued on its
> return path to userland instead of triggering irq_work. A dummy IRQ is
> required in the NMI case to ensure the task_work is handled before
> returning to user land. For this irq_work is used. An alternative would
> be just raising an interrupt like arch_send_call_function_single_ipi().
> 
> During testing with `remove_on_exec' it become visible that the event
> can be enqueued via NMI during execve(). The task_work must not be kept
> because free_event() will complain later. Also the new task will not
> have a sighandler installed.
> 
> Queue signal via task_work. Remove perf_event::pending_sigtrap and
> and use perf_event::pending_work instead. Raise irq_work in the NMI case
> for a dummy interrupt. Remove the task_work if the event is freed.
> 
> Tested-by: Marco Elver <elver@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

It clashes a bit with a series I have posted. Let's see the details:

> ---
>  include/linux/perf_event.h |  3 +-
>  kernel/events/core.c       | 58 ++++++++++++++++++++++----------------
>  2 files changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a9..24ac6765146c7 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -781,7 +781,6 @@ struct perf_event {
>  	unsigned int			pending_wakeup;
>  	unsigned int			pending_kill;
>  	unsigned int			pending_disable;
> -	unsigned int			pending_sigtrap;
>  	unsigned long			pending_addr;	/* SIGTRAP */
>  	struct irq_work			pending_irq;
>  	struct callback_head		pending_task;
> @@ -959,7 +958,7 @@ struct perf_event_context {
>  	struct rcu_head			rcu_head;
>  
>  	/*
> -	 * Sum (event->pending_sigtrap + event->pending_work)
> +	 * Sum (event->pending_work + event->pending_work)
>  	 *
>  	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
>  	 * that until the signal is delivered.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c7a0274c662c8..e0b2da8de485f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2283,21 +2283,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  		state = PERF_EVENT_STATE_OFF;
>  	}
>  
> -	if (event->pending_sigtrap) {
> -		bool dec = true;
> -
> -		event->pending_sigtrap = 0;
> -		if (state != PERF_EVENT_STATE_OFF &&
> -		    !event->pending_work) {
> -			event->pending_work = 1;
> -			dec = false;
> -			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> -			task_work_add(current, &event->pending_task, TWA_RESUME);
> -		}
> -		if (dec)
> -			local_dec(&event->ctx->nr_pending);
> -	}
> -
>  	perf_event_set_state(event, state);
>  
>  	if (!is_software_event(event))
> @@ -6741,11 +6726,6 @@ static void __perf_pending_irq(struct perf_event *event)
>  	 * Yay, we hit home and are in the context of the event.
>  	 */
>  	if (cpu == smp_processor_id()) {
> -		if (event->pending_sigtrap) {
> -			event->pending_sigtrap = 0;
> -			perf_sigtrap(event);
> -			local_dec(&event->ctx->nr_pending);
> -		}
>  		if (event->pending_disable) {
>  			event->pending_disable = 0;
>  			perf_event_disable_local(event);
> @@ -9592,14 +9572,23 @@ static int __perf_event_overflow(struct perf_event *event,
>  
>  		if (regs)
>  			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
> -		if (!event->pending_sigtrap) {
> -			event->pending_sigtrap = pending_id;
> +		if (!event->pending_work) {
> +			event->pending_work = pending_id;
>  			local_inc(&event->ctx->nr_pending);
> -			irq_work_queue(&event->pending_irq);
> +			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> +			task_work_add(current, &event->pending_task, TWA_RESUME);

If the overflow happens between exit_task_work() and perf_event_exit_task(),
you're leaking the event. (This was there before this patch).
See:
	https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m5e6c8ebbef04ab9a1d7f05340cd3e2716a9a8c39

> +			/*
> +			 * The NMI path returns directly to userland. The
> +			 * irq_work is raised as a dummy interrupt to ensure
> +			 * regular return path to user is taken and task_work
> +			 * is processed.
> +			 */
> +			if (in_nmi())
> +				irq_work_queue(&event->pending_irq);
>  		} else if (event->attr.exclude_kernel && valid_sample) {
>  			/*
>  			 * Should not be able to return to user space without
> -			 * consuming pending_sigtrap; with exceptions:
> +			 * consuming pending_work; with exceptions:
>  			 *
>  			 *  1. Where !exclude_kernel, events can overflow again
>  			 *     in the kernel without returning to user space.
> @@ -9609,7 +9598,7 @@ static int __perf_event_overflow(struct perf_event *event,
>  			 *     To approximate progress (with false negatives),
>  			 *     check 32-bit hash of the current IP.
>  			 */
> -			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
> +			WARN_ON_ONCE(event->pending_work != pending_id);
>  		}
>  
>  		event->pending_addr = 0;
> @@ -13049,6 +13038,13 @@ static void sync_child_event(struct perf_event *child_event)
>  		     &parent_event->child_total_time_running);
>  }
>  
> +static bool task_work_cb_match(struct callback_head *cb, void *data)
> +{
> +	struct perf_event *event = container_of(cb, struct perf_event, pending_task);
> +
> +	return event == data;
> +}

I suggest we introduce a proper API to cancel an actual callback head, see:

https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#mbfac417463018394f9d80c68c7f2cafe9d066a4b
https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m0a347249a462523358724085f2489ce9ed91e640

> +
>  static void
>  perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  {
> @@ -13088,6 +13084,18 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  		 * Kick perf_poll() for is_event_hup();
>  		 */
>  		perf_event_wakeup(parent_event);
> +		/*
> +		 * Cancel pending task_work and update counters if it has not
> +		 * yet been delivered to userland. free_event() expects the
> +		 * reference counter at one and keeping the event around until
> +		 * the task returns to userland can be a unexpected if there is
> +		 * no signal handler registered.
> +		 */
> +		if (event->pending_work &&
> +		    task_work_cancel_match(current, task_work_cb_match, event)) {
> +			put_event(event);
> +			local_dec(&event->ctx->nr_pending);
> +		}

So exiting task, privileged exec and also exit on exec call into this before
releasing the children.

And parents rely on put_event() from file close + the task work.

But what about remote release of children on file close?
See perf_event_release_kernel() directly calling free_event() on them.

One possible fix is to avoid the reference count game around task work
and flush them on free_event().

See here:

https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50

Thanks.

>  		free_event(event);
>  		put_event(parent_event);
>  		return;
> -- 
> 2.43.0
> 
> 

