Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242517EBDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjKOHXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:23:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FECED1;
        Tue, 14 Nov 2023 23:22:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AE2DA7;
        Tue, 14 Nov 2023 23:23:41 -0800 (PST)
Received: from [10.163.37.87] (unknown [10.163.37.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E056E3F6C4;
        Tue, 14 Nov 2023 23:22:50 -0800 (PST)
Message-ID: <648dc72b-7120-498f-8963-dbdc0d1acce0@arm.com>
Date:   Wed, 15 Nov 2023 12:52:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling
 framework
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
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
 <62b84faf-f413-6bfd-5fc1-ac2489e61e00@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <62b84faf-f413-6bfd-5fc1-ac2489e61e00@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 17:44, James Clark wrote:
> 
> 
> On 14/11/2023 05:13, Anshuman Khandual wrote:
> [...]
> 
>> +/*
>> + * This is a read only constant and safe during multi threaded access
>> + */
>> +static struct perf_branch_stack zero_branch_stack = { .nr = 0, .hw_idx = -1ULL};
>> +
>> +static void read_branch_records(struct pmu_hw_events *cpuc,
>> +				struct perf_event *event,
>> +				struct perf_sample_data *data,
>> +				bool *branch_captured)
>> +{
>> +	/*
>> +	 * CPU specific branch records buffer must have been allocated already
>> +	 * for the hardware records to be captured and processed further.
>> +	 */
>> +	if (WARN_ON(!cpuc->branches))
>> +		return;
>> +
>> +	/*
>> +	 * Overflowed event's branch_sample_type does not match the configured
>> +	 * branch filters in the BRBE HW. So the captured branch records here
>> +	 * cannot be co-related to the overflowed event. Report to the user as
>> +	 * if no branch records have been captured, and flush branch records.
>> +	 * The same scenario is applicable when the current task context does
>> +	 * not match with overflown event.
>> +	 */
>> +	if ((cpuc->brbe_sample_type != event->attr.branch_sample_type) ||
>> +	    (event->ctx->task && cpuc->brbe_context != event->ctx)) {
>> +		perf_sample_save_brstack(data, event, &zero_branch_stack);
> 
> Is there any benefit to outputting a zero size stack vs not outputting
> anything at all?

The event has got PERF_SAMPLE_BRANCH_STACK marked and hence perf_sample_data
must have PERF_SAMPLE_BRANCH_STACK with it's br_stack pointing to the branch
records. Hence without assigning a zeroed struct perf_branch_stack, there is
a chance, that perf_sample_data will pass on some garbage branch records to
the ring buffer.

> 
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Read the branch records from the hardware once after the PMU IRQ
>> +	 * has been triggered but subsequently same records can be used for
>> +	 * other events that might have been overflowed simultaneously thus
>> +	 * saving much CPU cycles.
>> +	 */
>> +	if (!*branch_captured) {
>> +		armv8pmu_branch_read(cpuc, event);
>> +		*branch_captured = true;
>> +	}
>> +	perf_sample_save_brstack(data, event, &cpuc->branches->branch_stack);
>> +}
>> +
>>  static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  {
>>  	u32 pmovsr;
>> @@ -766,6 +815,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
>>  	struct pt_regs *regs;
>>  	int idx;
>> +	bool branch_captured = false;
>>  
>>  	/*
>>  	 * Get and reset the IRQ flags
>> @@ -809,6 +859,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  		if (!armpmu_event_set_period(event))
>>  			continue;
>>  
>> +		/*
>> +		 * PMU IRQ should remain asserted until all branch records
>> +		 * are captured and processed into struct perf_sample_data.
>> +		 */
>> +		if (has_branch_stack(event) && cpu_pmu->has_branch_stack)
>> +			read_branch_records(cpuc, event, &data, &branch_captured);
> 
> You could return instead of using the out param, not really any
> different, but maybe a bit more normal:
> 
>   branch_captured |= read_branch_records(cpuc, event, &data,
> branch_captured);

I am just wondering - how that would be any better ?

> 
>> +
>>  		/*
>>  		 * Perf event overflow will queue the processing of the event as
>>  		 * an irq_work which will be taken care of in the handling of
>> @@ -818,6 +875,8 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>>  			cpu_pmu->disable(event);
>>  	}
>>  	armv8pmu_start(cpu_pmu);
>> +	if (cpu_pmu->has_branch_stack)
>> +		armv8pmu_branch_reset();
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -907,6 +966,24 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
>>  	return event->hw.idx;
>>  }
>>  
>> +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
>> +{
>> +	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
>> +	void *task_ctx = pmu_ctx->task_ctx_data;
>> +
>> +	if (armpmu->has_branch_stack) {
>> +		/* Save branch records in task_ctx on sched out */
>> +		if (task_ctx && !sched_in) {
>> +			armv8pmu_branch_save(armpmu, task_ctx);
>> +			return;
>> +		}
>> +
>> +		/* Reset branch records on sched in */
>> +		if (sched_in)
>> +			armv8pmu_branch_reset();
>> +	}
>> +}
>> +
>>  /*
>>   * Add an event filter to a given event.
>>   */
>> @@ -977,6 +1054,9 @@ static void armv8pmu_reset(void *info)
>>  		pmcr |= ARMV8_PMU_PMCR_LP;
>>  
>>  	armv8pmu_pmcr_write(pmcr);
>> +
>> +	if (cpu_pmu->has_branch_stack)
>> +		armv8pmu_branch_reset();
>>  }
>>  
>>  static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
>> @@ -1014,6 +1094,20 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>>  
>>  	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
>>  
>> +	if (has_branch_stack(event)) {
>> +		if (!armv8pmu_branch_attr_valid(event))
>> +			return -EOPNOTSUPP;
>> +
>> +		/*
>> +		 * If a task gets scheduled out, the current branch records
>> +		 * get saved in the task's context data, which can be later
>> +		 * used to fill in the records upon an event overflow. Let's
>> +		 * enable PERF_ATTACH_TASK_DATA in 'event->attach_state' for
>> +		 * all branch stack sampling perf events.
>> +		 */
>> +		event->attach_state |= PERF_ATTACH_TASK_DATA;
>> +	}
>> +
>>  	/*
>>  	 * CHAIN events only work when paired with an adjacent counter, and it
>>  	 * never makes sense for a user to open one in isolation, as they'll be
>> @@ -1130,6 +1224,35 @@ static void __armv8pmu_probe_pmu(void *info)
>>  		cpu_pmu->reg_pmmir = read_pmmir();
>>  	else
>>  		cpu_pmu->reg_pmmir = 0;
>> +	armv8pmu_branch_probe(cpu_pmu);
> 
> I'm not sure if this is splitting hairs or not, but
> __armv8pmu_probe_pmu() is run on only one of 'any' of the supported CPUs
> for this PMU.

Right.

> 
> Is it not possible to have some of those CPUs support and some not
> support BRBE, even though they are all the same PMU type? Maybe we could

I am not sure, but not something I have come across.

> wait for it to explode with some weird system, or change it so that the
> BRBE probe is run on every CPU, with a second 'supported_brbe_mask' field.

Right, but for now, the current solutions looks sufficient.

> 
>> +}
>> +
>> +static int branch_records_alloc(struct arm_pmu *armpmu)
>> +{
>> +	struct branch_records __percpu *records;
>> +	int cpu;
>> +
>> +	records = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
>> +	if (!records)
>> +		return -ENOMEM;
>> +
> 
> Doesn't this technically need to take the CPU mask where BRBE is
> supported into account? Otherwise you are allocating for cores that
> never use it.
> 
> Also it's done per-CPU _and_ per-PMU type, multiplying the number of
> BRBE buffers allocated, even if they can only ever be used per-CPU.

Agreed, but I believe we have already been though this discussion, and
settled for this method - for being a simpler approach.

> 
>> +	/*
>> +	 * percpu memory allocated for 'records' gets completely consumed
>> +	 * here, and never required to be freed up later. So permanently
>> +	 * losing access to this anchor i.e 'records' is acceptable.
>> +	 *
>> +	 * Otherwise this allocation handle would have to be saved up for
>> +	 * free_percpu() release later if required.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		struct pmu_hw_events *events_cpu;
>> +		struct branch_records *records_cpu;
>> +
>> +		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
>> +		records_cpu = per_cpu_ptr(records, cpu);
>> +		events_cpu->branches = records_cpu;
>> +	}
>> +	return 0;
>>  }
>>  
>>  static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>> @@ -1146,7 +1269,21 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>>  	if (ret)
>>  		return ret;
>>  
>> -	return probe.present ? 0 : -ENODEV;
>> +	if (!probe.present)
>> +		return -ENODEV;
>> +
>> +	if (cpu_pmu->has_branch_stack) {
>> +		ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = branch_records_alloc(cpu_pmu);
>> +		if (ret) {
>> +			armv8pmu_task_ctx_cache_free(cpu_pmu);
>> +			return ret;
>> +		}
>> +	}
>> +	return 0;
>>  }
>>  
> 
> [...]
>> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
>> index 9c226adf938a..72da4522397c 100644
>> --- a/include/linux/perf/arm_pmuv3.h
>> +++ b/include/linux/perf/arm_pmuv3.h
>> @@ -303,4 +303,50 @@
>>  		}						\
>>  	} while (0)
>>  
>> +struct pmu_hw_events;
>> +struct arm_pmu;
>> +struct perf_event;
>> +
>> +#ifdef CONFIG_PERF_EVENTS
> 
> Very minor nit, but if you end up moving the stubs to the brbe header
> you probably don't need the #ifdef CONFIG_PERF_EVENTS because it just
> won't be included in that case.

Right, will drop CONFIG_PERF_EVENTS wrapper.

> 
>> +static inline void armv8pmu_branch_reset(void)
>> +{
>> +}
>> +
>> +static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu)
>> +{
>> +}
>> +
>> +static inline bool armv8pmu_branch_attr_valid(struct perf_event *event)
>> +{
>> +	WARN_ON_ONCE(!has_branch_stack(event));
>> +	return false;
>> +}
>> +
>> +static inline void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)
>> +{
>> +}
>> +
>> +static inline void armv8pmu_branch_disable(void)
>> +{
>> +}
>> +
>> +static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc,
>> +					struct perf_event *event)
>> +{
>> +	WARN_ON_ONCE(!has_branch_stack(event));
>> +}
>> +
>> +static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
>> +{
>> +}
>> +
>> +static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)
>> +{
>> +}
>> +#endif /* CONFIG_PERF_EVENTS */
>>  #endif
