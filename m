Return-Path: <linux-kernel+bounces-22372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC94829CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A80281246
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8A4B5D7;
	Wed, 10 Jan 2024 14:49:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D563DBB3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7202F4;
	Wed, 10 Jan 2024 06:50:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5E03F64C;
	Wed, 10 Jan 2024 06:49:45 -0800 (PST)
Date: Wed, 10 Jan 2024 14:49:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] perf/core: Update
 perf_adjust_freq_unthr_context()
Message-ID: <ZZ6ug3IOeQlmQnsM@FVFF77S0Q05N>
References: <20240109213623.449371-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109213623.449371-1-namhyung@kernel.org>

On Tue, Jan 09, 2024 at 01:36:22PM -0800, Namhyung Kim wrote:
> It was unnecessarily disabling and enabling PMUs for each event.  It
> should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> at each PMU.  As pmu context has separate active lists for pinned group
> and flexible group, factor out a new function to do the job.
> 
> Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> even if it needs to unthrottle sampling events.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Tested-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Hi,

I've taken a quick look and I don't think this is quite right for
hybrid/big.LITTLE, but I think that should be relatively simple to fix (more on
that below).

This seems to be a bunch of optimizations; was that based on inspection alone,
or have you found a workload where this has a measureable impact?

> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
>  2 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..b2ff60fa487e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -883,6 +883,7 @@ struct perf_event_pmu_context {
>  
>  	unsigned int			nr_events;
>  	unsigned int			nr_cgroups;
> +	unsigned int			nr_freq;
>  
>  	atomic_t			refcount; /* event <-> epc */
>  	struct rcu_head			rcu_head;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 59b332cce9e7..ce9db9dbfd4c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2277,8 +2277,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	if (!is_software_event(event))
>  		cpc->active_oncpu--;
> -	if (event->attr.freq && event->attr.sample_freq)
> +	if (event->attr.freq && event->attr.sample_freq) {
>  		ctx->nr_freq--;
> +		epc->nr_freq--;
> +	}
>  	if (event->attr.exclusive || !cpc->active_oncpu)
>  		cpc->exclusive = 0;
>  
> @@ -2533,9 +2535,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	if (!is_software_event(event))
>  		cpc->active_oncpu++;
> -	if (event->attr.freq && event->attr.sample_freq)
> +	if (event->attr.freq && event->attr.sample_freq) {
>  		ctx->nr_freq++;
> -
> +		epc->nr_freq++;
> +	}
>  	if (event->attr.exclusive)
>  		cpc->exclusive = 1;
>  
> @@ -4098,30 +4101,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	}
>  }
>  
> -/*
> - * combine freq adjustment with unthrottling to avoid two passes over the
> - * events. At the same time, make sure, having freq events does not change
> - * the rate of unthrottling as that would introduce bias.
> - */
> -static void
> -perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> +static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
>  	u64 now, period = TICK_NSEC;
>  	s64 delta;
>  
> -	/*
> -	 * only need to iterate over all events iff:
> -	 * - context have events in frequency mode (needs freq adjust)
> -	 * - there are events to unthrottle on this cpu
> -	 */
> -	if (!(ctx->nr_freq || unthrottle))
> -		return;
> -
> -	raw_spin_lock(&ctx->lock);
> -
> -	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> +	list_for_each_entry(event, event_list, active_list) {
>  		if (event->state != PERF_EVENT_STATE_ACTIVE)
>  			continue;
>  
> @@ -4129,8 +4116,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		if (!event_filter_match(event))
>  			continue;
>  
> -		perf_pmu_disable(event->pmu);
> -
>  		hwc = &event->hw;
>  
>  		if (hwc->interrupts == MAX_INTERRUPTS) {
> @@ -4140,7 +4125,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		}
>  
>  		if (!event->attr.freq || !event->attr.sample_freq)
> -			goto next;
> +			continue;
>  
>  		/*
>  		 * stop the event and update event->count
> @@ -4162,8 +4147,39 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  			perf_adjust_period(event, period, delta, false);
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> -	next:
> -		perf_pmu_enable(event->pmu);
> +	}
> +}
> +
> +/*
> + * combine freq adjustment with unthrottling to avoid two passes over the
> + * events. At the same time, make sure, having freq events does not change
> + * the rate of unthrottling as that would introduce bias.
> + */
> +static void
> +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> +{
> +	struct perf_event_pmu_context *pmu_ctx;
> +
> +	/*
> +	 * only need to iterate over all events iff:
> +	 * - context have events in frequency mode (needs freq adjust)
> +	 * - there are events to unthrottle on this cpu
> +	 */
> +	if (!(ctx->nr_freq || unthrottle))
> +		return;
> +
> +	raw_spin_lock(&ctx->lock);
> +
> +	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +		if (!(pmu_ctx->nr_freq || unthrottle))
> +			continue;
> +		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
> +			continue;
> +
> +		perf_pmu_disable(pmu_ctx->pmu);
> +		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> +		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> +		perf_pmu_enable(pmu_ctx->pmu);
>  	}

I don't think this is correct for big.LITTLE/hybrid systems.

Imagine a system where CPUs 0-1 have pmu_a, CPUs 2-3 have pmu_b, and a task has
events for both pmu_a and pmu_b. The perf_event_context for that task will have
a perf_event_pmu_context for each PMU in its pmu_ctx_list.

Say that task is run on CPU0, and perf_event_task_tick() is called. That will
call perf_adjust_freq_unthr_context(), and it will iterate over the
pmu_ctx_list. Note that regardless of pmu_ctx->nr_freq, if 'unthottle' is true,
we'll go ahead and call the following for all of the pmu contexts in the
pmu_ctx_list:

	perf_pmu_disable(pmu_ctx->pmu);
	perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
	perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
	perf_pmu_enable(pmu_ctx->pmu);

.. and that means we might call that for pmu_b, even though it's not
associated with CPU0. That could be fatal depending on what those callbacks do.

The old logic avoided that possibility implicitly, since the events for pmu_b
couldn't be active, and so the check at the start of the look would skip all of
pmu_b's events:

	if (event->state != PERF_EVENT_STATE_ACTIVE)
		continue;

We could do similar by keeping track of how many active events each
perf_event_pmu_context has, which'd allow us to do something like:

	if (pmu_ctx->nr_active == 0)
		continue;
	
How does that sound to you?

Mark.

