Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDFD7CDB72
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJRMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:19:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A6E898;
        Wed, 18 Oct 2023 05:19:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDF3D2F4;
        Wed, 18 Oct 2023 05:20:09 -0700 (PDT)
Received: from [10.57.81.189] (unknown [10.57.81.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A07A3F762;
        Wed, 18 Oct 2023 05:19:26 -0700 (PDT)
Message-ID: <50c3fc7c-7f0a-4acb-b6da-b39dc123d9b9@arm.com>
Date:   Wed, 18 Oct 2023 13:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/schedutil: rework performance estimation
Content-Language: en-US
To:     Beata Michalska <beata.michalska@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20231013151450.257891-1-vincent.guittot@linaro.org>
 <20231013151450.257891-2-vincent.guittot@linaro.org>
 <ZS-Df8swrqcqP3Ue@e129154.nice.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ZS-Df8swrqcqP3Ue@e129154.nice.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 08:04, Beata Michalska wrote:
> Hi Vincent,
> 
> On Fri, Oct 13, 2023 at 05:14:49PM +0200, Vincent Guittot wrote:
>> The current method to take into account uclamp hints when estimating the
>> target frequency can end into situation where the selected target
>> frequency is finally higher than uclamp hints whereas there are no real
>> needs. Such cases mainly happen because we are currently mixing the
>> traditional scheduler utilization signal with the uclamp performance
>> hints. By adding these 2 metrics, we loose an important information when
>> it comes to select the target frequency and we have to make some
>> assumptions which can't fit all cases.

[snip]

>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index b9caa01dfac4..adec808b371a 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -243,7 +243,6 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>   	scale_cpu = arch_scale_cpu_capacity(cpu);
>>   	ps = &pd->table[pd->nr_perf_states - 1];
>>   
>> -	max_util = map_util_perf(max_util);
> Even though the effective_cpu_util does no longer include the headroom, it is
> being applied by sugov further down the line (sugov_effective_cpu_perf).
> Won't that bring back the original problem when freq selection within EM is
> not align with the one performed by sugov ?

It should be OK here to remove the above line. The map_util_perf()
is done before this em_cpu_energy() call, in the new code in


[snip]

>>   }
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 922905194c0c..d4f7b2f49c44 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7628,7 +7628,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>>   	for_each_cpu(cpu, pd_cpus) {
>>   		unsigned long util = cpu_util(cpu, p, -1, 0);
>>   
>> -		busy_time += effective_cpu_util(cpu, util, ENERGY_UTIL, NULL);
>> +		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
>>   	}
>>   
>>   	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
>> @@ -7651,7 +7651,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>>   	for_each_cpu(cpu, pd_cpus) {
>>   		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
>>   		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
>> -		unsigned long eff_util;
>> +		unsigned long eff_util, min, max;
>>   
>>   		/*
>>   		 * Performance domain frequency: utilization clamping
>> @@ -7660,7 +7660,23 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>>   		 * NOTE: in case RT tasks are running, by default the
>>   		 * FREQUENCY_UTIL's utilization can be max OPP.
>>   		 */
>> -		eff_util = effective_cpu_util(cpu, util, FREQUENCY_UTIL, tsk);
>> +		eff_util = effective_cpu_util(cpu, util, &min, &max);
>> +
>> +		/* Task's uclamp can modify min and max value */
>> +		if (tsk && uclamp_is_used()) {
>> +			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
>> +
>> +			/*
>> +			 * If there is no active max uclamp constraint,
>> +			 * directly use task's one otherwise keep max
>> +			 */
>> +			if (uclamp_rq_is_idle(cpu_rq(cpu)))
>> +				max = uclamp_eff_value(p, UCLAMP_MAX);
>> +			else
>> +				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
>> +		}
>> +
>> +		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
> This will include the headroom so won't it inflate the util here ?

Yes, that's the goal. It will inflate when needed. Currently, the
problem is that we always inflate (blindly) in the em_cpu_energy().
We don't know if the util value which is comming is from uclamp_max
and the frequency should not be higher, because something want to
clamp it.

The other question would be:
What if the PD has 4 CPUs, the max util found is 500 and is from
uclamp_max, but there is onother util on some other CPU 490?

That CPU is allowed and can have the +20% freq in voting.
In current design we don't punish the whole domain in such
scenario.
