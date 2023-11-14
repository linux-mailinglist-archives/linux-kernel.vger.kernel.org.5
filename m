Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593007EB563
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjKNRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjKNRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:10:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 773F7123;
        Tue, 14 Nov 2023 09:10:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3247BC15;
        Tue, 14 Nov 2023 09:11:38 -0800 (PST)
Received: from [10.57.72.217] (unknown [10.57.72.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5183F641;
        Tue, 14 Nov 2023 09:10:51 -0800 (PST)
Message-ID: <5f281bb8-9d74-041f-4311-6d68b5ee271d@arm.com>
Date:   Tue, 14 Nov 2023 17:10:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 framework
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
 <20231114051329.327572-4-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231114051329.327572-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2023 05:13, Anshuman Khandual wrote:
[...]
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d712a19e47ac..76f1376ae594 100644
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
>  	armpmu_stop(event, PERF_EF_UPDATE);
>  	hw_events->events[idx] = NULL;
>  	armpmu->clear_event_idx(hw_events, event);
> @@ -333,6 +342,22 @@ armpmu_add(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	int idx;
>  
> +	if (has_branch_stack(event)) {
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

What about a per-thread event following a per-cpu event? Doesn't that
also need to branch_reset()? If hw_events->brbe_context was already
previously assigned, once the per-thread event is switched in it skips
this reset following a per-cpu event on the same core.

I think it should be possible to add a test for this scenario by
creating simulaneous per-cpu and per-thread events and checking for leakage.

> +		}
> +		hw_events->brbe_users++;
> +		hw_events->brbe_sample_type = event->attr.branch_sample_type;
> +	}
> +
>  	/* An event following a process won't be stopped earlier */
>  	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
>  		return -ENOENT;
> @@ -512,13 +537,24 @@ static int armpmu_event_init(struct perf_event *event)
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
>  
>  	return __hw_perf_event_init(event);
>  }
>  

[...]
> +/*
> + * This is a read only constant and safe during multi threaded access
> + */
> +static struct perf_branch_stack zero_branch_stack = { .nr = 0, .hw_idx = -1ULL};
> +
> +static void read_branch_records(struct pmu_hw_events *cpuc,
> +				struct perf_event *event,
> +				struct perf_sample_data *data,
> +				bool *branch_captured)
> +{
> +	/*
> +	 * CPU specific branch records buffer must have been allocated already
> +	 * for the hardware records to be captured and processed further.
> +	 */
> +	if (WARN_ON(!cpuc->branches))
> +		return;
> +
> +	/*
> +	 * Overflowed event's branch_sample_type does not match the configured
> +	 * branch filters in the BRBE HW. So the captured branch records here
> +	 * cannot be co-related to the overflowed event. Report to the user as
> +	 * if no branch records have been captured, and flush branch records.
> +	 * The same scenario is applicable when the current task context does
> +	 * not match with overflown event.
> +	 */
> +	if ((cpuc->brbe_sample_type != event->attr.branch_sample_type) ||
> +	    (event->ctx->task && cpuc->brbe_context != event->ctx)) {
> +		perf_sample_save_brstack(data, event, &zero_branch_stack);
> +		return;
> +	}

I think we should probably add a test for this scenario too. Like that
the second event opened on the same thread as another event with
different brbe settings always produces zero records.

I actually tried to reproduce this behaviour but couldn't. Not sure if I
did something wrong though.

