Return-Path: <linux-kernel+bounces-88517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2686E2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FD31F23B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F806EB66;
	Fri,  1 Mar 2024 13:52:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1D5F84C;
	Fri,  1 Mar 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301176; cv=none; b=ocR6Z0YI139B7myAPTonxXgMrjhs5W93sPwjHFgd5w+SgEzKjbI8NpW2hhLqh4lUwfTjzkzVWlwJoEopGSaczyWALsyOCdOC8MEdYCKHgFti1qVwoBvGLXUY0zjdJ6pPD0/5lgkEDVvfig1n/sdDUTMw8W/B6yfXMkWG3Msj1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301176; c=relaxed/simple;
	bh=mmVNzpqrZ+2DnTuQ1GJSu4BE/r4oyWXHnA5jjSrdp3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+hUWXzciPnedKf/c/ojV6FsZlzC5isJZFLF61fPrWUkxqCB9uGHAHN17F6h87kei/ewFtiWUi4WfSowb6zBHBTxPsQFbFUlUskKthJs3IXH6IriNmb/0/1MEqUvZu4A7HME50QImFrnKRk/qT+R2nex7M3J36rqhOzA+44Grv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFB61FB;
	Fri,  1 Mar 2024 05:53:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.69.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9266D3F762;
	Fri,  1 Mar 2024 05:52:50 -0800 (PST)
Date: Fri, 1 Mar 2024 13:52:47 +0000
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
Message-ID: <ZeHdr3w9QP7WNkqy@FVFF77S0Q05N>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-4-anshuman.khandual@arm.com>
 <ZdYx8cawn0sAbktv@FVFF77S0Q05N>
 <030247ac-46d9-4b3b-ab18-08df5ddf9d68@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030247ac-46d9-4b3b-ab18-08df5ddf9d68@arm.com>

On Fri, Mar 01, 2024 at 11:07:32AM +0530, Anshuman Khandual wrote:
> On 2/21/24 22:55, Mark Rutland wrote:
> > On Thu, Jan 25, 2024 at 03:11:14PM +0530, Anshuman Khandual wrote:

> >> @@ -333,6 +342,38 @@ armpmu_add(struct perf_event *event, int flags)
> >>  	struct hw_perf_event *hwc = &event->hw;
> >>  	int idx;
> >>  
> >> +	if (has_branch_stack(event)) {
> >> +		/*
> >> +		 * Reset branch records buffer if a new CPU bound event
> >> +		 * gets scheduled on a PMU. Otherwise existing branch
> >> +		 * records present in the buffer might just leak into
> >> +		 * such events.
> >> +		 *
> >> +		 * Also reset current 'hw_events->brbe_context' because
> >> +		 * any previous task bound event now would have lost an
> >> +		 * opportunity for continuous branch records.
> >> +		 */
> > 
> > Doesn't this mean some user silently loses events? Why is that ok?
> 
> Previous task bound event that has been on the CPU will loose current branch
> records available in BRBE when this happens. Buffer needs reset for records
> integrity for the upcoming CPU bound event. Following options are available
> in such cases. 
> 
> - Let it loose some samples, anyways it's going to be rare (proposed here) 
> - Call armv8pmu_branch_save() to save them off on the event, before reset
> - Tell the event that it has lost some samples - PERF_RECORD_LOST ?
> 
> Please suggest which would be a better solution ? OR there might be some other
> approach for this scenario ?

TBH, I'm not immediately sure what the best option is here, and this is part of
the bigger problem of "how do multiple events with branch sampling interact?".

I'll need to go explore that problem space (and see what other architectures
do). For now, it would be good if you could handle the patch restructuring
(i.e. splitting the PMUv3 and arm_pmu changes) sorted first, and then we can
consider the BRBE sharing / lifetime problems atop that.

So for now (i.e. for v17), leave this as-is; 

[...]

> > 
> >> +		hw_events->brbe_users++;
> >> +		hw_events->brbe_sample_type = event->attr.branch_sample_type;
> > 
> > What exactly is brbe_sample_type, and why does it get overriden *every time* we
> > add a new event? What happens when events have different values for
> > brbe_sample_type? Or is that forbidden somehow?
> 
> brbe_sample_type contains the final perf branch filter that gets into BRBE HW for
> the recording session. The proposed solution here goes with the last perf event's
> 'attr.branch_sample_type' when they get collected for the given PMU via pmu_add()
> callback.
> 	
> 	hw_events->brbe_sample_type = event->attr.branch_sample_type
> 
> So in a scenario where multiple branch events are programmed with different filter
> requests, the captured branch records during PMU IRQ might not match the requests
> for many events that were scheduled together. Hence we only give the branch records
> to the matching events.
> 
> static void read_branch_records()
> {
> ...
>         /*
>          * Overflowed event's branch_sample_type does not match the configured
>          * branch filters in the BRBE HW. So the captured branch records here
>          * cannot be co-related to the overflowed event. Report to the user as
>          * if no branch records have been captured, and flush branch records.
>          * The same scenario is applicable when the current task context does
>          * not match with overflown event.
>          */
>         if ((cpuc->branch_sample_type != event->attr.branch_sample_type) ||
>             (event->ctx->task && cpuc->branch_context != event->ctx))
>                 return;
> ...
> }

I see; it's good that we filter that in read_branch_records(), but this doesn't
feel right from a lifetime perspective. For example, if you install a pinned
per-cpu event with branch sample type A, then a task temporarily installs a
task-bound event with branch sample type B, the type in HW will be left as B
and the cpu-bound event will never get samples again.

So I think we'll have to change *something* here, but that's part of the bigger
question above, so please leave this as-is for now.

> Please note that we don't prohibit the events from being grouped together on the PMU
> i.e pmu_add() does not fail when filters do not match. But there might be some other
> approaches that could be taken in such scenarios.
>
> A. Fail pmu_add() when branch_sample_type does not match
> 
> B. OR together all event's event->attr.branch_sample_type on a given PMU
> 
> 	- Then captured records need to be post processed to find applicable samples
> 	  matching event's original filter request
> 
> 	- But it might add some more latency to PMU IRQ handling ?
> 
> But please do let me know if there are better solutions that can be taken up.

It looks like LBR always does SW filtering, and I don't think it's actually
that expensive, so B looks like a nicer option.

However, I think that's part of that bigger question above, so for now please
leave that as-is.

> > 
> >> +	}
> >> +
> >>  	/* An event following a process won't be stopped earlier */
> >>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> >>  		return -ENOENT;
> > 
> > Unless this cpumask check has been made redundant, it means that the code above
> > it is obviously wrong, since that pokes the BRBE HW and increments brbe_users
> > *before* we decide whether the event can be installed on this CPU. That'll blow
> > up on big.LITTLE,  e.g. we try and install a 'big' CPU event on a 'little' CPU,
> > poke the BRBE HW and increment brbe_users, then *after* that we abort
> > installing the event.
> 
> Agreed, aborting to install the event on the cpu after incrementing brbe_users
> will be problematic.
> 
> > Even ignoring big.LITTLE, we can fail immediately after this when we don't have
> > enough counters, since the following code is:
> > 
> > |        /* An event following a process won't be stopped earlier */
> > |        if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
> > |                return -ENOENT;
> > |
> > |        /* If we don't have a space for the counter then finish early. */
> > |        idx = armpmu->get_event_idx(hw_events, event);
> > |        if (idx < 0)
> > |                return idx;
> > 
> > ... which'll go wrong if you try to open 1 more event than the CPU has
> > counters.
> 
> Agreed, the event needs to clear that test as well before incrementing brbe_users.
> 
> Should the branch stack context needs to be installed only after the event has
> cleared get_event_idx() successfully along with HW counters availability check
> etc before proceeding to install on the CPU ? IOW just move the block bit down

Yes; for now that should be sufficient.

[...]

> >> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> >> index 23fa6c5da82c..9e17764a0929 100644
> >> --- a/drivers/perf/arm_pmuv3.c
> >> +++ b/drivers/perf/arm_pmuv3.c
> >> @@ -26,6 +26,7 @@
> >>  #include <linux/nmi.h>
> >>  
> >>  #include <asm/arm_pmuv3.h>
> >> +#include "arm_pmuv3_branch.h"
> > 
> > As above, I do not thing that the PMUv3 driver should change at all in this
> > patch. As of this patch it achieves nothing, and it makes it really hard to
> > understand what's going on because the important aspects are spread randomly
> > across this patch and the next patch which actually adds the BRBE management.
> > 
> > Please factor the PMUv3 changes out into the patch adding the actual BRBE code.
> 
> Sure, will keep the following changes in this patch.
> 
> A. drivers/perf/arm_pmu.c
> 
> 	- armpmu_add() --> armpmu->branch_stack_add()
> 	- armpmu_del() --> armpmu->branch_stack_del()
> 	- Allowing has_branch_stack() events in armpmu_event_init()
> 	- Adding callback arm_pmu->pmu->sched_task = armpmu_sched_task
> 
> B. include/linux/perf/arm_pmu.h
> 
> 	- Adding branch elements into pmu_hw_events
> 	- Adding branch callbacks into arm_pmu
> 	- Adding sched_task() into arm_pmu
> 	- Adding has_branch_stack into arm_pmu
> 
> Move everything else into the next patch implementing BRBE.
> 
> drivers/perf/arm_pmuv3.c 
> drivers/perf/arm_pmuv3_branch.h

That looks good. Depending on what we do about BRBE sharing we might need an
armpmu::branch_stack_init() callback for event_init(), so if you end up needing
one now that's also fine.

Thanks,
Mark.

