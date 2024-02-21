Return-Path: <linux-kernel+bounces-75194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665BC85E484
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07743B22CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33F983CBD;
	Wed, 21 Feb 2024 17:25:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7583A1F;
	Wed, 21 Feb 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536316; cv=none; b=CyaKGOpwORpCLrlZeedJes2zJbQVJRMW9DUN9TKQxGza4B3393JCViKpgGkfPz4uNbWtQfKEkr115LLtKxvDyDkzB0f2ntMuxS0stf1LmwbcUY0YwykP0XJHJU5NqUYwgu3YyanSrMID9HsNlclOufq/nEnln9IrfkLBJi2jVhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536316; c=relaxed/simple;
	bh=pi3m3lINB34XM4b05DNPw2Om1XAK5T2xa3AtMdE8pgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKGy3yAVXGBJC0Pmx5pSrgrSz01PxwAVf5y1Mria76fEPNsKRD0nkf42xjDCMsCMOm7TRqvGBsQXdoDIBxKzwbg7NgD2677UJcQPhmWEQhElk+9iEqfJW+glATY0GdVBLCgsxspWgNonRjdHlP/B9etSPle1i26S5xTNqVDEArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DA351007;
	Wed, 21 Feb 2024 09:25:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D45D3F73F;
	Wed, 21 Feb 2024 09:25:10 -0800 (PST)
Date: Wed, 21 Feb 2024 17:25:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V16 3/8] drivers: perf: arm_pmuv3: Enable branch stack
 sampling framework
Message-ID: <ZdYx8cawn0sAbktv@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125094119.2542332-4-anshuman.khandual@arm.com>

Hi Anshuman,

On Thu, Jan 25, 2024 at 03:11:14PM +0530, Anshuman Khandual wrote:
> Branch stack sampling support i.e capturing branch records during execution
> in core perf, rides along with normal HW events being scheduled on the PMU.
> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
> with required HW implementation.

Please can we start a bit more clearly, e.g.

| drivers: perf: arm_pmu: add instructure for branch stack sampling
| 
| In order to support the Branch Record Buffer Extension (BRBE), we need to
| extend the arm_pmu framework with some basic infrastructure for branch stack
| sampling which arm_pmu drivers can opt-in to using. Subsequent patches will
| use this to add support for BRBE in the PMUv3 driver.

> ARMV8 PMU hardware support for branch stack sampling is indicated via a new
> feature flag called 'has_branch_stack' that can be ascertained via probing.
> This modifies current gate in armpmu_event_init() which blocks branch stack
> sampling based perf events unconditionally. Instead allows such perf events
> getting initialized on supporting PMU hardware.

This paragraph can be deleted. The addition of 'has_branch_stack' and its use
in armpmu_event_init() is trivial and obvious in-context, and this distracts
from the important parts of this patch.

> Branch stack sampling is enabled and disabled along with regular PMU events
> . This adds required function callbacks in armv8pmu_branch_xxx() format, to
> drive the PMU branch stack hardware when supported. This also adds fallback
> stub definitions for these callbacks for PMUs which would not have required
> support.

Those additions to the PMUv3 driver should all be in the next patch.

We don't add anything for the other PMU drivers that don't support branch
sampling, so why do we need to do *anything* to the PMUv3 driver here, given we
add the support in the next patch? Those additions only make this patch bigger
and more confusing (and hence more painful to review).

> If a task gets scheduled out, the current branch records get saved in the
> task's context data, which can be later used to fill in the records upon an
> event overflow. Hence, we enable PERF_ATTACH_TASK_DATA (event->attach_state
> based flag) for branch stack requesting perf events. But this also requires
> adding support for pmu::sched_task() callback to arm_pmu.

I think what this is trying to say is:

| With BRBE, the hardware records branches into a hardware FIFO, which will be
| sampled by software when perf events overflow. A task may be context-switched
| an arbitrary number of times between overflows, and to avoid losing samples
| we need to save the current records when a task is context-switched out. To
| do these we'll need to use the pmu::sched_task() callback, and we'll need to
| allocate some per-task storage space using PERF_ATTACH_TASK_DATA.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V16:
> 
> - Renamed arm_brbe.h as arm_pmuv3_branch.h
> - Updated perf_sample_save_brstack()'s new argument requirements with NULL
> 
>  drivers/perf/arm_pmu.c          |  57 ++++++++++++-
>  drivers/perf/arm_pmuv3.c        | 141 +++++++++++++++++++++++++++++++-
>  drivers/perf/arm_pmuv3_branch.h |  50 +++++++++++
>  include/linux/perf/arm_pmu.h    |  29 ++++++-
>  include/linux/perf/arm_pmuv3.h  |   1 -
>  5 files changed, 273 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/perf/arm_pmuv3_branch.h
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index 8458fe2cebb4..16f488ae7747 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -317,6 +317,15 @@ armpmu_del(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx = hwc->idx;
>  
> +	if (has_branch_stack(event)) {
> +		WARN_ON_ONCE(!hw_events->brbe_users);
> +		hw_events->brbe_users--;
> +		if (!hw_events->brbe_users) {
> +			hw_events->brbe_context = NULL;
> +			hw_events->brbe_sample_type = 0;
> +		}
> +	}
> +

If this is going to leak into the core arm_pmu code, use "branch_stack" rather
than "brbe" for these field names.

However, I reckon we could just have two new callbacks on arm_pmu:

	branch_stack_add(struct perf_event *event, ...);
	branch_stack_del(struct perf_event *event, ...);

.. and hide all of the details in the PMUv3 (or BRBE) driver for now, and the
code above can just do:

	if (has_branch_stack(event))
		branch_stack_del(event, ...);

.. and likewise in armpmu_add().

That way the actuel management logic for the context and so on can be added in
the next patch, where the lifetime would be *much* clearer.

>  	armpmu_stop(event, PERF_EF_UPDATE);
>  	hw_events->events[idx] = NULL;
>  	armpmu->clear_event_idx(hw_events, event);
> @@ -333,6 +342,38 @@ armpmu_add(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx;
>  
> +	if (has_branch_stack(event)) {
> +		/*
> +		 * Reset branch records buffer if a new CPU bound event
> +		 * gets scheduled on a PMU. Otherwise existing branch
> +		 * records present in the buffer might just leak into
> +		 * such events.
> +		 *
> +		 * Also reset current 'hw_events->brbe_context' because
> +		 * any previous task bound event now would have lost an
> +		 * opportunity for continuous branch records.
> +		 */

Doesn't this mean some user silently loses events? Why is that ok?

> +		if (!event->ctx->task) {
> +			hw_events->brbe_context = NULL;
> +			if (armpmu->branch_reset)
> +				armpmu->branch_reset();
> +		}
> +
> +		/*
> +		 * Reset branch records buffer if a new task event gets
> +		 * scheduled on a PMU which might have existing records.
> +		 * Otherwise older branch records present in the buffer
> +		 * might leak into the new task event.
> +		 */
> +		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
> +			hw_events->brbe_context = event->ctx;
> +			if (armpmu->branch_reset)
> +				armpmu->branch_reset();
> +		}

Same question here.

How does this work on other architectures?

What do we do if the CPU-bound and task-bound events want different filters,
etc?

This is the sort of gnarly detail that should be explained (or at least
introduced) in the commit message.

> +		hw_events->brbe_users++;
> +		hw_events->brbe_sample_type = event->attr.branch_sample_type;

What exactly is brbe_sample_type, and why does it get overriden *every time* we
add a new event? What happens when events have different values for
brbe_sample_type? Or is that forbidden somehow?

> +	}
> +
>  	/* An event following a process won't be stopped earlier */
>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>  		return -ENOENT;

Unless this cpumask check has been made redundant, it means that the code above
it is obviously wrong, since that pokes the BRBE HW and increments brbe_users
*before* we decide whether the event can be installed on this CPU. That'll blow
up on big.LITTLE,  e.g. we try and install a 'big' CPU event on a 'little' CPU,
poke the BRBE HW and increment brbe_users, then *after* that we abort
installing the event.

Even ignoring big.LITTLE, we can fail immediately after this when we don't have
enough counters, since the following code is:

|        /* An event following a process won't be stopped earlier */
|        if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
|                return -ENOENT;
|
|        /* If we don't have a space for the counter then finish early. */
|        idx = armpmu->get_event_idx(hw_events, event);
|        if (idx < 0)
|                return idx;

.. which'll go wrong if you try to open 1 more event than the CPU has
counters.

> @@ -511,13 +552,24 @@ static int armpmu_event_init(struct perf_event *event)
>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>  		return -ENOENT;
>  
> -	/* does not support taken branch sampling */
> -	if (has_branch_stack(event))
> +	/*
> +	 * Branch stack sampling events are allowed
> +	 * only on PMU which has required support.
> +	 */
> +	if (has_branch_stack(event) && !armpmu->has_branch_stack)
>  		return -EOPNOTSUPP;
>  	return __hw_perf_event_init(event);
>  }
>  

I think we can delete the comment entirely here, but the code itself looks
fine here.

> +static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
> +{
> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
> +
> +	if (armpmu->sched_task)
> +		armpmu->sched_task(pmu_ctx, sched_in);
> +}

This looks fine.

>  static void armpmu_enable(struct pmu *pmu)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
> @@ -864,6 +916,7 @@ struct arm_pmu *armpmu_alloc(void)
>  	}
>  
>  	pmu->pmu = (struct pmu) {
> +		.sched_task	= armpmu_sched_task,
>  		.pmu_enable	= armpmu_enable,
>  		.pmu_disable	= armpmu_disable,
>  		.event_init	= armpmu_event_init,
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 23fa6c5da82c..9e17764a0929 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -26,6 +26,7 @@
>  #include <linux/nmi.h>
>  
>  #include <asm/arm_pmuv3.h>
> +#include "arm_pmuv3_branch.h"

As above, I do not thing that the PMUv3 driver should change at all in this
patch. As of this patch it achieves nothing, and it makes it really hard to
understand what's going on because the important aspects are spread randomly
across this patch and the next patch which actually adds the BRBE management.

Please factor the PMUv3 changes out into the patch adding the actual BRBE code.

[...]

> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index 46377e134d67..c3e7d2cfb737 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -308,5 +308,4 @@
>  		default: WARN(1, "Invalid PMEV* index\n");	\
>  		}						\
>  	} while (0)
> -
>  #endif

Unrelated whitespace change.

Mark.

