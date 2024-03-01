Return-Path: <linux-kernel+bounces-87937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A286DB34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A938D283934
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729A52F74;
	Fri,  1 Mar 2024 05:37:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A32F53;
	Fri,  1 Mar 2024 05:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271463; cv=none; b=GkKFEU0y2aqurergXV+zwUfcatfHwRFh2wf8LESn/vAL166CptLQbCvZMmrscktbsM975bcW93gPAKUj9v07SCXk7SrOnT8UZ7cvvoMntinIqIL86nUweVtEgXdCj+5YDWRBEvlPBHkrGFAgdyolwjBH8Z3L4UM1ETuPPfA61hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271463; c=relaxed/simple;
	bh=iL+pGNNgmd70C0rWqDflHBLoKWck9FkmKXGOaKSX/P4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B8tBATGtMJRs14t2MrkIp467ZrcqWc3iLOQLt2UU/NQ3wybgibPzOWws8Msrjx+wMIbd9xuA/dF3fE1vNZx6JJzpHTF/xi/7XaI/Sy6LBjBl15+A/X6wU26haC5LOxicC4uWnK5z5qUaIXLV62LShn/2HyRVZdEhezZLK/soQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A471FB;
	Thu, 29 Feb 2024 21:38:17 -0800 (PST)
Received: from [10.162.42.8] (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EADDE3F6C4;
	Thu, 29 Feb 2024 21:37:34 -0800 (PST)
Message-ID: <030247ac-46d9-4b3b-ab18-08df5ddf9d68@arm.com>
Date: Fri, 1 Mar 2024 11:07:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V16 3/8] drivers: perf: arm_pmuv3: Enable branch stack
 sampling framework
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-4-anshuman.khandual@arm.com>
 <ZdYx8cawn0sAbktv@FVFF77S0Q05N>
Content-Language: en-US
In-Reply-To: <ZdYx8cawn0sAbktv@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/24 22:55, Mark Rutland wrote:
> Hi Anshuman,
> 
> On Thu, Jan 25, 2024 at 03:11:14PM +0530, Anshuman Khandual wrote:
>> Branch stack sampling support i.e capturing branch records during execution
>> in core perf, rides along with normal HW events being scheduled on the PMU.
>> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
>> with required HW implementation.
> 
> Please can we start a bit more clearly, e.g.
> 
> | drivers: perf: arm_pmu: add instructure for branch stack sampling
> | 
> | In order to support the Branch Record Buffer Extension (BRBE), we need to
> | extend the arm_pmu framework with some basic infrastructure for branch stack
> | sampling which arm_pmu drivers can opt-in to using. Subsequent patches will
> | use this to add support for BRBE in the PMUv3 driver.

Added this paragraph at the very beginning.

> 
>> ARMV8 PMU hardware support for branch stack sampling is indicated via a new
>> feature flag called 'has_branch_stack' that can be ascertained via probing.
>> This modifies current gate in armpmu_event_init() which blocks branch stack
>> sampling based perf events unconditionally. Instead allows such perf events
>> getting initialized on supporting PMU hardware.
> 
> This paragraph can be deleted. The addition of 'has_branch_stack' and its use
> in armpmu_event_init() is trivial and obvious in-context, and this distracts
> from the important parts of this patch.

Okay, dropped the above paragraph.

> 
>> Branch stack sampling is enabled and disabled along with regular PMU events
>> . This adds required function callbacks in armv8pmu_branch_xxx() format, to
>> drive the PMU branch stack hardware when supported. This also adds fallback
>> stub definitions for these callbacks for PMUs which would not have required
>> support.
> 
> Those additions to the PMUv3 driver should all be in the next patch.

Sure, will do that.

> 
> We don't add anything for the other PMU drivers that don't support branch
> sampling, so why do we need to do *anything* to the PMUv3 driver here, given we
> add the support in the next patch? Those additions only make this patch bigger
> and more confusing (and hence more painful to review).

Understood.

> 
>> If a task gets scheduled out, the current branch records get saved in the
>> task's context data, which can be later used to fill in the records upon an
>> event overflow. Hence, we enable PERF_ATTACH_TASK_DATA (event->attach_state
>> based flag) for branch stack requesting perf events. But this also requires
>> adding support for pmu::sched_task() callback to arm_pmu.
> 
> I think what this is trying to say is:
> 
> | With BRBE, the hardware records branches into a hardware FIFO, which will be
> | sampled by software when perf events overflow. A task may be context-switched
> | an arbitrary number of times between overflows, and to avoid losing samples
> | we need to save the current records when a task is context-switched out. To
> | do these we'll need to use the pmu::sched_task() callback, and we'll need to
> | allocate some per-task storage space using PERF_ATTACH_TASK_DATA.

Replaced as suggested.

> 
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V16:
>>
>> - Renamed arm_brbe.h as arm_pmuv3_branch.h
>> - Updated perf_sample_save_brstack()'s new argument requirements with NULL
>>
>>  drivers/perf/arm_pmu.c          |  57 ++++++++++++-
>>  drivers/perf/arm_pmuv3.c        | 141 +++++++++++++++++++++++++++++++-
>>  drivers/perf/arm_pmuv3_branch.h |  50 +++++++++++
>>  include/linux/perf/arm_pmu.h    |  29 ++++++-
>>  include/linux/perf/arm_pmuv3.h  |   1 -
>>  5 files changed, 273 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/perf/arm_pmuv3_branch.h
>>
>> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
>> index 8458fe2cebb4..16f488ae7747 100644
>> --- a/drivers/perf/arm_pmu.c
>> +++ b/drivers/perf/arm_pmu.c
>> @@ -317,6 +317,15 @@ armpmu_del(struct perf_event *event, int flags)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int idx = hwc->idx;
>>  
>> +	if (has_branch_stack(event)) {
>> +		WARN_ON_ONCE(!hw_events->brbe_users);
>> +		hw_events->brbe_users--;
>> +		if (!hw_events->brbe_users) {
>> +			hw_events->brbe_context = NULL;
>> +			hw_events->brbe_sample_type = 0;
>> +		}
>> +	}
>> +
> 
> If this is going to leak into the core arm_pmu code, use "branch_stack" rather
> than "brbe" for these field names.

Right, makes sense. I too was contemplating for that rename, will change.

> 
> However, I reckon we could just have two new callbacks on arm_pmu:
> 
> 	branch_stack_add(struct perf_event *event, ...);
> 	branch_stack_del(struct perf_event *event, ...);
> 
> ... and hide all of the details in the PMUv3 (or BRBE) driver for now, and the
> code above can just do:
> 
> 	if (has_branch_stack(event))
> 		branch_stack_del(event, ...);
> 
> ... and likewise in armpmu_add().
> 
> That way the actuel management logic for the context and so on can be added in
> the next patch, where the lifetime would be *much* clearer.

Right, will change as required.

> 
>>  	armpmu_stop(event, PERF_EF_UPDATE);
>>  	hw_events->events[idx] = NULL;
>>  	armpmu->clear_event_idx(hw_events, event);
>> @@ -333,6 +342,38 @@ armpmu_add(struct perf_event *event, int flags)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  	int idx;
>>  
>> +	if (has_branch_stack(event)) {
>> +		/*
>> +		 * Reset branch records buffer if a new CPU bound event
>> +		 * gets scheduled on a PMU. Otherwise existing branch
>> +		 * records present in the buffer might just leak into
>> +		 * such events.
>> +		 *
>> +		 * Also reset current 'hw_events->brbe_context' because
>> +		 * any previous task bound event now would have lost an
>> +		 * opportunity for continuous branch records.
>> +		 */
> 
> Doesn't this mean some user silently loses events? Why is that ok?

Previous task bound event that has been on the CPU will loose current branch
records available in BRBE when this happens. Buffer needs reset for records
integrity for the upcoming CPU bound event. Following options are available
in such cases. 

- Let it loose some samples, anyways it's going to be rare (proposed here) 
- Call armv8pmu_branch_save() to save them off on the event, before reset
- Tell the event that it has lost some samples - PERF_RECORD_LOST ?

Please suggest which would be a better solution ? OR there might be some other
approach for this scenario ?

> 
>> +		if (!event->ctx->task) {
>> +			hw_events->brbe_context = NULL;
>> +			if (armpmu->branch_reset)
>> +				armpmu->branch_reset();
>> +		}
>> +
>> +		/*
>> +		 * Reset branch records buffer if a new task event gets
>> +		 * scheduled on a PMU which might have existing records.
>> +		 * Otherwise older branch records present in the buffer
>> +		 * might leak into the new task event.
>> +		 */
>> +		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
>> +			hw_events->brbe_context = event->ctx;
>> +			if (armpmu->branch_reset)
>> +				armpmu->branch_reset();
>> +		}
> 
> Same question here.

As explained above.

> 
> How does this work on other architectures?

I had gone through some of them before but don't recollect the details right now.
I will get back on this later.

> 
> What do we do if the CPU-bound and task-bound events want different filters,
> etc?

Unless the same task comes back again on the CPU, buffer needs to be reset in all
other scenarios to guard against captured branch records integrity for the target
event. Then filter differences does not really matter.

> 
> This is the sort of gnarly detail that should be explained (or at least
> introduced) in the commit message.

Understood, will try and update the commit message accordingly.

> 
>> +		hw_events->brbe_users++;
>> +		hw_events->brbe_sample_type = event->attr.branch_sample_type;
> 
> What exactly is brbe_sample_type, and why does it get overriden *every time* we
> add a new event? What happens when events have different values for
> brbe_sample_type? Or is that forbidden somehow?

brbe_sample_type contains the final perf branch filter that gets into BRBE HW for
the recording session. The proposed solution here goes with the last perf event's
'attr.branch_sample_type' when they get collected for the given PMU via pmu_add()
callback.
	
	hw_events->brbe_sample_type = event->attr.branch_sample_type

So in a scenario where multiple branch events are programmed with different filter
requests, the captured branch records during PMU IRQ might not match the requests
for many events that were scheduled together. Hence we only give the branch records
to the matching events.

static void read_branch_records()
{
..
        /*
         * Overflowed event's branch_sample_type does not match the configured
         * branch filters in the BRBE HW. So the captured branch records here
         * cannot be co-related to the overflowed event. Report to the user as
         * if no branch records have been captured, and flush branch records.
         * The same scenario is applicable when the current task context does
         * not match with overflown event.
         */
        if ((cpuc->branch_sample_type != event->attr.branch_sample_type) ||
            (event->ctx->task && cpuc->branch_context != event->ctx))
                return;
..
}

Please note that we don't prohibit the events from being grouped together on the PMU
i.e pmu_add() does not fail when filters do not match. But there might be some other
approaches that could be taken in such scenarios.

A. Fail pmu_add() when branch_sample_type does not match

B. OR together all event's event->attr.branch_sample_type on a given PMU

	- Then captured records need to be post processed to find applicable samples
	  matching event's original filter request

	- But it might add some more latency to PMU IRQ handling ?

But please do let me know if there are better solutions that can be taken up.

> 
>> +	}
>> +
>>  	/* An event following a process won't be stopped earlier */
>>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>>  		return -ENOENT;
> 
> Unless this cpumask check has been made redundant, it means that the code above
> it is obviously wrong, since that pokes the BRBE HW and increments brbe_users
> *before* we decide whether the event can be installed on this CPU. That'll blow
> up on big.LITTLE,  e.g. we try and install a 'big' CPU event on a 'little' CPU,
> poke the BRBE HW and increment brbe_users, then *after* that we abort
> installing the event.

Agreed, aborting to install the event on the cpu after incrementing brbe_users
will be problematic.

> 
> Even ignoring big.LITTLE, we can fail immediately after this when we don't have
> enough counters, since the following code is:
> 
> |        /* An event following a process won't be stopped earlier */
> |        if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> |                return -ENOENT;
> |
> |        /* If we don't have a space for the counter then finish early. */
> |        idx = armpmu->get_event_idx(hw_events, event);
> |        if (idx < 0)
> |                return idx;
> 
> ... which'll go wrong if you try to open 1 more event than the CPU has
> counters.

Agreed, the event needs to clear that test as well before incrementing brbe_users.

Should the branch stack context needs to be installed only after the event has
cleared get_event_idx() successfully along with HW counters availability check
etc before proceeding to install on the CPU ? IOW just move the block bit down

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index ac07911263a9..d657ce337f10 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -336,9 +336,6 @@ armpmu_add(struct perf_event *event, int flags)
        struct hw_perf_event *hwc = &event->hw;
        int idx;
 
-       if (has_branch_stack(event))
-               armpmu->branch_stack_add(event, hw_events);
-
        /* An event following a process won't be stopped earlier */
        if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
                return -ENOENT;
@@ -348,6 +345,9 @@ armpmu_add(struct perf_event *event, int flags)
        if (idx < 0)
                return idx;
 
+       if (has_branch_stack(event))
+               armpmu->branch_stack_add(event, hw_events);
+
        /*
         * If there is an event in the counter we are going to use then make
         * sure it is disabled.


> 
>> @@ -511,13 +552,24 @@ static int armpmu_event_init(struct perf_event *event)
>>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
>>  		return -ENOENT;
>>  
>> -	/* does not support taken branch sampling */
>> -	if (has_branch_stack(event))
>> +	/*
>> +	 * Branch stack sampling events are allowed
>> +	 * only on PMU which has required support.
>> +	 */
>> +	if (has_branch_stack(event) && !armpmu->has_branch_stack)
>>  		return -EOPNOTSUPP;
>>  	return __hw_perf_event_init(event);
>>  }
>>  
> 
> I think we can delete the comment entirely here, but the code itself looks
> fine here.

Sure, will delete the above comment.

> 
>> +static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>> +{
>> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>> +
>> +	if (armpmu->sched_task)
>> +		armpmu->sched_task(pmu_ctx, sched_in);
>> +}
> 
> This looks fine.
> 
>>  static void armpmu_enable(struct pmu *pmu)
>>  {
>>  	struct arm_pmu *armpmu = to_arm_pmu(pmu);
>> @@ -864,6 +916,7 @@ struct arm_pmu *armpmu_alloc(void)
>>  	}
>>  
>>  	pmu->pmu = (struct pmu) {
>> +		.sched_task	= armpmu_sched_task,
>>  		.pmu_enable	= armpmu_enable,
>>  		.pmu_disable	= armpmu_disable,
>>  		.event_init	= armpmu_event_init,
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 23fa6c5da82c..9e17764a0929 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/nmi.h>
>>  
>>  #include <asm/arm_pmuv3.h>
>> +#include "arm_pmuv3_branch.h"
> 
> As above, I do not thing that the PMUv3 driver should change at all in this
> patch. As of this patch it achieves nothing, and it makes it really hard to
> understand what's going on because the important aspects are spread randomly
> across this patch and the next patch which actually adds the BRBE management.
> 
> Please factor the PMUv3 changes out into the patch adding the actual BRBE code.

Sure, will keep the following changes in this patch.

A. drivers/perf/arm_pmu.c

	- armpmu_add() --> armpmu->branch_stack_add()
	- armpmu_del() --> armpmu->branch_stack_del()
	- Allowing has_branch_stack() events in armpmu_event_init()
	- Adding callback arm_pmu->pmu->sched_task = armpmu_sched_task

B. include/linux/perf/arm_pmu.h

	- Adding branch elements into pmu_hw_events
	- Adding branch callbacks into arm_pmu
	- Adding sched_task() into arm_pmu
	- Adding has_branch_stack into arm_pmu

Move everything else into the next patch implementing BRBE.

drivers/perf/arm_pmuv3.c 
drivers/perf/arm_pmuv3_branch.h

> 
> [...]
> 
>> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
>> index 46377e134d67..c3e7d2cfb737 100644
>> --- a/include/linux/perf/arm_pmuv3.h
>> +++ b/include/linux/perf/arm_pmuv3.h
>> @@ -308,5 +308,4 @@
>>  		default: WARN(1, "Invalid PMEV* index\n");	\
>>  		}						\
>>  	} while (0)
>> -
>>  #endif
> 
> Unrelated whitespace change.

Already folded this in.

