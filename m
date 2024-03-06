Return-Path: <linux-kernel+bounces-94277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C1873C66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD271F21FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402371361D4;
	Wed,  6 Mar 2024 16:39:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB5F60882;
	Wed,  6 Mar 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743153; cv=none; b=nR4kfWu6do2gN+7rWzl/nHFy9JFgeNfMQCRcM/a5MtEmJQCHpEoWMoAOYm+9jGgpSBAbKtnIgM43NehYhbuC3lNyVszrRAy1sgILcs8vmz3ozci1E1uEWqB90KwhVhk15QGieUI44pFCcfIWipi8C2K/mNU21niSJdNVuXztVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743153; c=relaxed/simple;
	bh=naaNCoSOuNVUkWDcaYDQKKJnozHSJmiQUw1z+TKcMqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgxwjp7F+Y+vynLoFmf/7X4xUXaxdErN89Vm+2ggRPnNL3UeM+qmezJTamRb9pNksyJnRw3VeFg1lrYTHy9ag1SCoBL+7taJeHb+/0CWsATEPWc1GH8iVdhfqsNd7sHnVu8Jt4jXm/m4HBd7gxw4HgFXHvLPqzHrosnbmorOfn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FF81FB;
	Wed,  6 Mar 2024 08:39:47 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4FD93F73F;
	Wed,  6 Mar 2024 08:39:07 -0800 (PST)
Date: Wed, 6 Mar 2024 16:38:17 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: Handle generic events normally instead of
 trying all pmu
Message-ID: <Zeib-e1RYm2Dlk8c@FVFF77S0Q05N>
References: <20240306151017.2114-1-jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306151017.2114-1-jialong.yang@shingroup.cn>

On Wed, Mar 06, 2024 at 11:10:15PM +0800, JiaLong.Yang wrote:
> We have pay more effort on handling generic events. We treat them
> specially caused us paying more.

Are you seeing an actual problem in practice? ... or is this just intended as a
cleanup/improvement?

What problem are you actually trying to solve here?

> Now time have told us that PMU type between 0 and PERF_TYPE_MAX only
> corresponds to one PMU.

There can be at most one PMU registered for each type, but several PMUs may
need to handle events for that type.

Trivially, there are a number of PMUs which share the PERF_TYPE_SOFTWARE type,
e.g.

* perf_swevent, handled by perf_swevent_init()
* perf_cpu_clock, handled by cpu_clock_event_init()
* perf_task_clock, handled by task_clock_event_init()

.. which have non-overlapping events in the PERF_TYPE_SOFTWARE event
namespace.

On systems with heterogeneous PMUs (e.g. ARM big.LITTLE systems), several PMUs
can handle the PERF_TYPE_{HARDWARE,RAW,CACHE} event namespaces, and there's
existing software that depends upon that working *without* the extended HW type
IDs.

> So we can handle the special when registering PMU not in event opening. And
> we can know which PMU is used to the generic event.

No we cannot. There may be several PMUs which need to handle a given generic
event type.

> The added capabilities PERF_PMU_CAP_EVENT_HARDWARE and
> PERF_PMU_CAP_EVENT_HW_CACHE will alloc idr for PERF_TYPE_HARDWARE and
> PERF_TYPE_HW_CACHE with same PMU.

When I suggested using capabilities in:

  https://lore.kernel.org/lkml/ZecStMBA4YgQaBEZ@FVFF77S0Q05N/

.. I had meant that the core code could check just before calling the
pmu::event_init() function, in order to simplify the implementation of the
event_init() functions. I did not mean for this to change the way we
manipulated the IDR.

> We'd better handle uncore-task event before calling pmu->event_init().

This is a nice-to-have, but it's logically separate from the rest of this
patch.

> 
> The code is compatible with PERF_PMU_TYPE_SHIFT.
> /*
>  * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
>  * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
>  *					AA: hardware event ID
>  *					EEEEEEEE: PMU type ID
>  * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
>  *					BB: hardware cache ID
>  *					CC: hardware cache op ID
>  *					DD: hardware cache op result ID
>  *					EEEEEEEE: PMU type ID
>  * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
>  */
> 
> But the drivers have to give the corresponding capabilities obviously.
> 
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
> ---
>  include/linux/perf_event.h |  4 +-
>  kernel/events/core.c       | 83 +++++++++++++++++++++++---------------
>  2 files changed, 54 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a..edf4365ab7cc 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -290,7 +290,9 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_ITRACE			0x0020
>  #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
> -#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
> +#define PERF_PMU_CAP_EVENT_HARDWARE             0x0100
> +#define PERF_PMU_CAP_EVENT_HW_CACHE             0x0200
> +#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0300
>  
>  struct perf_output_handle;
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f0f0f71213a1..02f14ae09d09 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11516,6 +11516,7 @@ static struct lock_class_key cpuctx_lock;
>  int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  {
>  	int cpu, ret, max = PERF_TYPE_MAX;
> +	int cap = pmu->capabilities;
>  
>  	mutex_lock(&pmus_lock);
>  	ret = -ENOMEM;
> @@ -11523,7 +11524,6 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  	if (!pmu->pmu_disable_count)
>  		goto unlock;
>  
> -	pmu->type = -1;
>  	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n")) {
>  		ret = -EINVAL;
>  		goto free_pdc;
> @@ -11538,15 +11538,34 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  	if (ret < 0)
>  		goto free_pdc;
>  
> +	/*
> +	 * Ensure one type ([0, PERF_TYPE_MAX)) correspond to one PMU.
> +	 */
>  	WARN_ON(type >= 0 && ret != type);
>  
>  	type = ret;
>  	pmu->type = type;
>  
> +	if ((type != PERF_TYPE_HARDWARE) &&
> +	    (cap & PERF_PMU_CAP_EVENT_HARDWARE)) {
> +		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HARDWARE,
> +				PERF_TYPE_HARDWARE + 1, GFP_KERNEL);
> +		if (ret < 0)
> +			goto free_idr;
> +	}

This means that if I try to register more than one PMU with
PERF_PMU_CAP_EVENT_HARDWARE, the second will fail IDR allocation and fail to
register.

.. so this is entirely useless for systems with heterogeneous PMUs, where each
of those *should* be able to handle plain PERF_TYPE_HARDWARE events for legacy reasons.

I agree that the existing event initialization code is grotty, but that's
largely an artifact of maintaining existing ABI. AFAICT this patch breaks that,
and makes the code complex in a different way rather than actually simlifying anything.

Therefore, NAK to this patch.

As above, I think it does make sense to have the core code own some common
checks (e.g. rejecting task-bound uncore events, filting generic events from
PMUs that don't support those), so I'm open to patches doing that.

Mark.

> +
> +	if ((type != PERF_TYPE_HW_CACHE) &&
> +	    (cap & PERF_PMU_CAP_EVENT_HW_CACHE)) {
> +		ret = idr_alloc(&pmu_idr, pmu, PERF_TYPE_HW_CACHE,
> +				PERF_TYPE_HW_CACHE + 1, GFP_KERNEL);
> +		if (ret < 0)
> +			goto free_idr_hw;
> +	}
> +
>  	if (pmu_bus_running && !pmu->dev) {
>  		ret = pmu_dev_alloc(pmu);
>  		if (ret)
> -			goto free_idr;
> +			goto free_idr_hw_cache;
>  	}
>  
>  	ret = -ENOMEM;
> @@ -11604,6 +11623,14 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>  		put_device(pmu->dev);
>  	}
>  
> +free_idr_hw_cache:
> +	if (cap & PERF_PMU_CAP_EVENT_HW_CACHE)
> +		idr_remove(&pmu_idr, PERF_TYPE_HW_CACHE);
> +
> +free_idr_hw:
> +	if (cap & PERF_PMU_CAP_EVENT_HARDWARE)
> +		idr_remove(&pmu_idr, PERF_TYPE_HARDWARE);
> +
>  free_idr:
>  	idr_remove(&pmu_idr, pmu->type);
>  
> @@ -11648,6 +11675,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>  {
>  	struct perf_event_context *ctx = NULL;
>  	int ret;
> +	bool uncore_pmu = false, extded_pmu = false;
>  
>  	if (!try_module_get(pmu->module))
>  		return -ENODEV;
> @@ -11668,6 +11696,20 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>  		BUG_ON(!ctx);
>  	}
>  
> +	if (perf_invalid_context == pmu->task_ctx_nr)
> +		uncore_pmu = true;
> +
> +	if (pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
> +		extded_pmu = true;
> +
> +	/* Disallow uncore-task events. */
> +	if (uncore_pmu && (event->attach_state & PERF_ATTACH_TASK))
> +		return -EINVAL;
> +
> +	/* Ensure pmu not supporting generic events will not be passed such event. */
> +	if (!extded_pmu && (event->attr.type & PERF_PMU_CAP_EXTENDED_HW_TYPE))
> +		return -EINVAL;
> +
>  	event->pmu = pmu;
>  	ret = pmu->event_init(event);
>  
> @@ -11695,7 +11737,6 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>  
>  static struct pmu *perf_init_event(struct perf_event *event)
>  {
> -	bool extended_type = false;
>  	int idx, type, ret;
>  	struct pmu *pmu;
>  
> @@ -11720,36 +11761,15 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  	 * are often aliases for PERF_TYPE_RAW.
>  	 */
>  	type = event->attr.type;
> -	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) {
> -		type = event->attr.config >> PERF_PMU_TYPE_SHIFT;
> -		if (!type) {
> -			type = PERF_TYPE_RAW;
> -		} else {
> -			extended_type = true;
> -			event->attr.config &= PERF_HW_EVENT_MASK;
> -		}
> -	}
> +	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
> +		event->attr.config &= PERF_HW_EVENT_MASK;
>  
> -again:
>  	rcu_read_lock();
>  	pmu = idr_find(&pmu_idr, type);
>  	rcu_read_unlock();
> -	if (pmu) {
> -		if (event->attr.type != type && type != PERF_TYPE_RAW &&
> -		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
> -			goto fail;
>  
> -		ret = perf_try_init_event(pmu, event);
> -		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> -			type = event->attr.type;
> -			goto again;
> -		}
> -
> -		if (ret)
> -			pmu = ERR_PTR(ret);
> -
> -		goto unlock;
> -	}
> +	if (!pmu || perf_try_init_event(pmu, event))
> +		goto fail;
>  
>  	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>  		ret = perf_try_init_event(pmu, event);
> @@ -12026,11 +12046,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	}
>  
>  	/*
> -	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
> -	 * events (they don't make sense as the cgroup will be different
> -	 * on other CPUs in the uncore mask).
> +	 * Disallow uncore-cgroup events (they don't make sense
> +	 * as the cgroup will be different on other CPUs in the uncore mask).
>  	 */
> -	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
> +	if (task || cgroup_fd != -1) {
>  		err = -EINVAL;
>  		goto err_pmu;
>  	}
> -- 
> 2.25.1
> 

