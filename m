Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2237D53AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343513AbjJXOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjJXOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:10:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09789B6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:10:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF743C15;
        Tue, 24 Oct 2023 07:10:47 -0700 (PDT)
Received: from [192.168.2.82] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3BAF3F762;
        Tue, 24 Oct 2023 07:10:03 -0700 (PDT)
Message-ID: <908bb624-1778-4f57-a89b-503a4076cb2e@arm.com>
Date:   Tue, 24 Oct 2023 16:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] sched/fair: Introduce UTIL_FITS_CAPACITY
 feature (v2)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org
References: <20231019160523.1582101-1-mathieu.desnoyers@efficios.com>
 <20231019160523.1582101-2-mathieu.desnoyers@efficios.com>
 <f40522de-b71d-4848-8aa3-5b87d38bb847@arm.com>
 <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
Content-Language: en-US
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <c79ac631-61c7-4953-a657-74047a264029@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 17:04, Mathieu Desnoyers wrote:
> On 2023-10-23 10:11, Dietmar Eggemann wrote:
>> On 19/10/2023 18:05, Mathieu Desnoyers wrote:
> 
> [...]
>>>   +static unsigned long scale_rt_capacity(int cpu);
>>> +
>>> +/*
>>> + * Returns true if adding the task utilization to the estimated
>>> + * utilization of the runnable tasks on @cpu does not exceed the
>>> + * capacity of @cpu.
>>> + *
>>> + * This considers only the utilization of _runnable_ tasks on the @cpu
>>> + * runqueue, excluding blocked and sleeping tasks. This is achieved by
>>> + * using the runqueue util_est.enqueued.
>>> + */
>>> +static inline bool task_fits_remaining_cpu_capacity(unsigned long
>>> task_util,
>>> +                            int cpu)
>>
>> This is almost like the existing task_fits_cpu(p, cpu) (used in Capacity
>> Aware Scheduling (CAS) for Asymmetric CPU capacity systems) except the
>> latter only uses `util = task_util_est(p)` and deals with uclamp as well
>> and only tests whether p could fit on the CPU.
> 
> This is indeed a major difference between how asym capacity check works
> and what is introduced here:
> 
> asym capacity check only checks whether the given task theoretically
> fits in the cpu if that cpu was completely idle, without considering the
> current cpu utilization.

Yeah, asymmetric CPU capacity systems have to make sure that p fits on
the idle/sched_idle CPU, hence the use of sync_entity_load_avg() and
asym_fits_cpu().

> My approach is to consider the current util_est of the cpu to check
> whether the task fits in the remaining capacity.

True.

> I did not want to use the existing task_fits_cpu() helper because the
> notions of uclamp bounds appear to be heavily tied to the fact that it
> checks whether the task fits in an _idle_ runqueue, whereas the check I
> am introducing here is much more restrictive: it checks that the task
> fits on the runqueue within the remaining capacity.

I see. Essentially what you do is

util_fits_cpu(util_est(CPU + p), 0, 1024, CPU) in !uclamp_is_used()

The uclamp_is_used() case is task-centric though. (*)

>> Or like find_energy_efficient_cpu() (feec(), used in
>> Energy-Aware-Scheduling (EAS)) which uses cpu_util(cpu, p, cpu, 0) to
>> get:
>>
>>    max(util_avg(CPU + p), util_est(CPU + p))
> 
> I've tried using cpu_util(), but unfortunately anything that considers
> blocked/sleeping tasks in its utilization total does not work for my
> use-case.
> 
> From cpu_util():
> 
>  * CPU utilization is the sum of running time of runnable tasks plus the
>  * recent utilization of currently non-runnable tasks on that CPU.

OK,  I see. Occasions in which `util_avg(CPU + p) > util_est(CPU + p)`
would ruin it for your use-case.

>> feec()
>>      ...
>>      for (; pd; pd = pd->next)
>>          ...
>>          util = cpu_util(cpu, p, cpu, 0);
>>          ...
>>          fits = util_fits_cpu(util, util_min, util_max, cpu)
>>                                     ^^^^^^^^^^^^^^^^^^
>>                                    not used when uclamp is not active (1)
>>              ...
>>              capacity = capacity_of(cpu)
>>              fits = fits_capacity(util, capacity)
>>              if (!uclamp_is_used()) (1)
>>                  return fits
>>
>> So not introducing new functions like task_fits_remaining_cpu_capacity()
>> in this area and using existing one would be good.
> 
> If the notion of uclamp is not tied to the way asym capacity check is
> done against a theoretically idle runqueue, I'd be OK with using this,
> but so far both appear to be very much tied.

Yeah, uclamp_is_used() scenarios are more complicated (see *).

> When I stumbled on this fundamental difference between asym cpu capacity
> check and the check introduced here, I've started wondering whether the
> asym cpu capacity check would benefit from considering the target cpu
> current utilization as well.

We just adapted select_idle_sibling() for asymmetric CPU capacity
systems by adding the asym_fits_cpu() to the idle/sched_idle check.

For me so far sis() is all about finding an idle CPU and not task packing.

>>> +{
>>> +    unsigned long total_util;
>>> +
>>> +    if (!sched_util_fits_capacity_active())
>>> +        return false;
>>> +    total_util = READ_ONCE(cpu_rq(cpu)->cfs.avg.util_est.enqueued) +
>>> task_util;
>>> +    return fits_capacity(total_util, scale_rt_capacity(cpu));
>>
>> Why not use:
>>
>> static unsigned long capacity_of(int cpu)
>>      return cpu_rq(cpu)->cpu_capacity;
>>
>> which is maintained in update_cpu_capacity() as scale_rt_capacity(cpu)?
> 
> The reason for preferring scale_rt_capacity(cpu) over capacity_of(cpu)
> is that update_cpu_capacity() only runs periodically every
> balance-interval, therefore providing a coarse-grained remaining
> capacity approximation with respect to irq, rt, dl, and thermal
> utilization.
>> If it turns out that being coarse-grained is good enough, we may be able
> to save some cycles by using capacity_of(), but not without carefully
> considering the impacts of being imprecise.

OK, I see. We normally consider capacity_of(cpu) as accurate enough.

[...]

>>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>>> index ee7f23c76bd3..9a84a1401123 100644
>>> --- a/kernel/sched/features.h
>>> +++ b/kernel/sched/features.h
>>> @@ -97,6 +97,12 @@ SCHED_FEAT(WA_BIAS, true)
>>>   SCHED_FEAT(UTIL_EST, true)
>>>   SCHED_FEAT(UTIL_EST_FASTUP, true)
>>
>> IMHO, asymmetric CPU capacity systems would have to disable the sched
>> feature UTIL_FITS_CAPACITY. Otherwise CAS could deliver different
>> results. task_fits_remaining_cpu_capacity() and asym_fits_cpu() work
>> slightly different.
> 
> I don't think they should be mutually exclusive. We should look into the
> differences between those two more closely to make them work nicely
> together instead. For instance, why does asym capacity only consider
> whether tasks fit in a theoretically idle runqueue, when it could use
> the current utilization of the runqueue to check that the task fits in
> the remaining capacity ?

We have EAS (feec()) for this on asymmetric CPU capacity systems (as our
per-performance_domain packing strategy), which only works when
!overutilized. When overutilized, we just need asym_fits_cpu()
(select_idle_capacity() -> util_fits_cpu()) to select a fitting
idle/sched_idle CPU in CAS which includes the uclamp handling.

[...]
