Return-Path: <linux-kernel+bounces-6592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AFB819ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5494B2659B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342341C6A8;
	Wed, 20 Dec 2023 08:41:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26971DA27;
	Wed, 20 Dec 2023 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFFA61FB;
	Wed, 20 Dec 2023 00:42:19 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7DF33F64C;
	Wed, 20 Dec 2023 00:41:32 -0800 (PST)
Message-ID: <bf11d4a5-44e0-4e76-b795-dbbb2b338d12@arm.com>
Date: Wed, 20 Dec 2023 08:42:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, rafael@kernel.org,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <ff68662a-6206-4bea-9307-071a50b368f9@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ff68662a-6206-4bea-9307-071a50b368f9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> The Energy Model (EM) can be modified at runtime which brings new
>> possibilities. The em_cpu_energy() is called by the Energy Aware Scheduler
>> (EAS) in it's hot path. The energy calculation uses power value for
> 
> NIT: s/it's/its

OK

> 
>> a given performance state (ps) and the CPU busy time as percentage for that
>> given frequency, which effectively is:
>>
>> pd_nrg = ps->power * busy_time_pct                        (1)
>>
>>                   cpu_util
>> busy_time_pct = -----------------                         (2)
>>                   ps->performance
>>
>> The 'ps->performance' is the CPU capacity (performance) at that given ps.
>> Thus, in a situation when the OS is not overloaded and we have EAS
>> working, the busy time is lower than 'ps->performance' that the CPU is
>> running at. Therefore, in longer scheduling period we can treat the power
>> value calculated above as the energy.
> 
> Not sure I understand what a longer 'scheduling period' has to do with
> that? Is this to highlight the issue between instantaneous power and the
> energy being the integral over it? And the 'scheduling period' is the
> runnable time of this task?

I can probably drop this sentence. I just wanted to describe that EAS
operates on power values, but actually assumes that it will be energy
because we know that the tasks will run longer. It's not the best
place to even try to describe this bit of EAS+EM in this patch header.

> 
>> We can optimize the last arithmetic operation in em_cpu_energy() and
>> remove the division. This can be done because em_perf_state::cost, which
>> is a special coefficient, can now hold the pre-calculated value including
>> the 'ps->performance' information for a performance state (ps):
>>
>>                ps->power
>> ps->cost = ---------------                                (3)
>>             ps->performance
> 
> Ah, this is equation (2) in the existing code with s/cap/performance.

yes

> 
>> In the past the 'ps->performance' had to be calculated at runtime every
>> time the em_cpu_energy() was called. Thus there was this formula involved:
>>
> 
>>                    ps->freq
>> ps->performance = ------------- * scale_cpu               (4)
>>                    cpu_max_freq
>>
>> When we inject (4) into (2) than we can have this equation:
>>
>>                   cpu_util * cpu_max_freq
>> busy_time_pct = ------------------------                  (5)
>>                   ps->freq * scale_cpu
>>
>> Because the right 'scale_cpu' value wasn't ready during the boot time
>> and EM initialization, we had to perform the division by 'scale_cpu'
>> at runtime. There was not safe mechanism to update EM at runtime.
>> It has changed thanks to EM runtime modification feature.
>>
>> It is possible to avoid the division by 'scale_cpu' at runtime, because
>> EM is updated whenever new max capacity CPU is set in the system or after
>> the boot has finished and proper CPU capacity is ready.
>>
>> Use that feature and do the needed division during the calculation of the
>> coefficient 'ps->cost'. That enhanced 'ps->cost' value can be then just
>> multiplied simply by utilization:
>>
>> pd_nrg = ps->cost * \Sum cpu_util                         (6)
>>
>> to get the needed energy for whole Performance Domain (PD).
>>
>> With this optimization, the em_cpu_energy() should run faster on the Big
>> CPU by 1.43x and on the Little CPU by 1.69x.
> 
> Where are those precise numbers are coming from? Which platform was it?

That was mainline big.Little board rockpi4 b w/ rockchip 3399, present
quite a few commercial devices (e.g. chromebooks or plenty other seen in
DT). The numbers are from measuring the time it takes to run this
function em_cpu_cost() in a loop for mln of times. Thus, the instruction
cache and data cache should be hot, but the operation would impact the
different score.

> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 68 +++++-------------------------------
>>   kernel/power/energy_model.c  |  7 ++--
>>   2 files changed, 12 insertions(+), 63 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index e30750500b10..0f5621898a81 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -115,27 +115,6 @@ struct em_perf_domain {
>>   #define EM_MAX_NUM_CPUS 16
>>   #endif
>>   
>> -/*
>> - * To avoid an overflow on 32bit machines while calculating the energy
>> - * use a different order in the operation. First divide by the 'cpu_scale'
>> - * which would reduce big value stored in the 'cost' field, then multiply by
>> - * the 'sum_util'. This would allow to handle existing platforms, which have
>> - * e.g. power ~1.3 Watt at max freq, so the 'cost' value > 1mln micro-Watts.
>> - * In such scenario, where there are 4 CPUs in the Perf. Domain the 'sum_util'
>> - * could be 4096, then multiplication: 'cost' * 'sum_util'  would overflow.
>> - * This reordering of operations has some limitations, we lose small
>> - * precision in the estimation (comparing to 64bit platform w/o reordering).
>> - *
>> - * We are safe on 64bit machine.
>> - */
>> -#ifdef CONFIG_64BIT
>> -#define em_estimate_energy(cost, sum_util, scale_cpu) \
>> -	(((cost) * (sum_util)) / (scale_cpu))
>> -#else
>> -#define em_estimate_energy(cost, sum_util, scale_cpu) \
>> -	(((cost) / (scale_cpu)) * (sum_util))
>> -#endif
>> -
>>   struct em_data_callback {
>>   	/**
>>   	 * active_power() - Provide power at the next performance state of
>> @@ -249,29 +228,16 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>   {
>>   	struct em_perf_table *runtime_table;
>>   	struct em_perf_state *ps;
>> -	unsigned long scale_cpu;
>> -	int cpu, i;
>> +	int i;
>>   
>>   	if (!sum_util)
>>   		return 0;
>>   
>> -	/*
>> -	 * In order to predict the performance state, map the utilization of
>> -	 * the most utilized CPU of the performance domain to a requested
>> -	 * frequency, like schedutil. Take also into account that the real
>> -	 * frequency might be set lower (due to thermal capping). Thus, clamp
>> -	 * max utilization to the allowed CPU capacity before calculating
>> -	 * effective frequency.
> 
> Why do you remove this comment? IMHO, it's still valid and independent
> of the changes here?

Fair enough, I thought this comment makes more confusion in the new
function, but I'll keep it.

> 
>> -	 */
>> -	cpu = cpumask_first(to_cpumask(pd->cpus));
>> -	scale_cpu = arch_scale_cpu_capacity(cpu);
>> -
>>   	/*
>>   	 * No rcu_read_lock() since it's already called by task scheduler.
>>   	 * The runtime_table is always there for CPUs, so we don't check.
>>   	 */
>>   	runtime_table = rcu_dereference(pd->runtime_table);
>> -
>>   	ps = &runtime_table->state[pd->nr_perf_states - 1];
>>   
>>   	max_util = map_util_perf(max_util);
>> @@ -286,35 +252,21 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>   	ps = &runtime_table->state[i];
>>   
>>   	/*
>> -	 * The capacity of a CPU in the domain at the performance state (ps)
>> -	 * can be computed as:
>> -	 *
>> -	 *             ps->freq * scale_cpu
>> -	 *   ps->cap = --------------------                          (1)
>> -	 *                 cpu_max_freq
>> -	 *
>> -	 * So, ignoring the costs of idle states (which are not available in
>> -	 * the EM), the energy consumed by this CPU at that performance state
>> +	 * The energy consumed by the CPU at the given performance state (ps)
>>   	 * is estimated as:
>>   	 *
>> -	 *             ps->power * cpu_util
>> -	 *   cpu_nrg = --------------------                          (2)
>> -	 *                   ps->cap
>> +	 *                ps->power
>> +	 *   cpu_nrg = --------------- * cpu_util                    (1)
>> +	 *             ps->performance
>>   	 *
>> -	 * since 'cpu_util / ps->cap' represents its percentage of busy time.
>> +	 * The 'cpu_util / ps->performance' represents its percentage of
>> +	 * busy time. The idle cost is ignored (it's not available in the EM).
>>   	 *
>>   	 *   NOTE: Although the result of this computation actually is in
>>   	 *         units of power, it can be manipulated as an energy value
>>   	 *         over a scheduling period, since it is assumed to be
>>   	 *         constant during that interval.
>>   	 *
>> -	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
>> -	 * of two terms:
>> -	 *
>> -	 *             ps->power * cpu_max_freq   cpu_util
>> -	 *   cpu_nrg = ------------------------ * ---------          (3)
>> -	 *                    ps->freq            scale_cpu
>> -	 *
>>   	 * The first term is static, and is stored in the em_perf_state struct
>>   	 * as 'ps->cost'.
>>   	 *
>> @@ -323,11 +275,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>>   	 * total energy of the domain (which is the simple sum of the energy of
>>   	 * all of its CPUs) can be factorized as:
>>   	 *
>> -	 *            ps->cost * \Sum cpu_util
>> -	 *   pd_nrg = ------------------------                       (4)
>> -	 *                  scale_cpu
>> +	 *   pd_nrg = ps->cost * \Sum cpu_util                       (2)
>>   	 */
>> -	return em_estimate_energy(ps->cost, sum_util, scale_cpu);
>> +	return ps->cost * sum_util;
> 
> Can you not keep the existing comment and only change:
> 
> (a) that ps->cap id ps->performance in (2) and
> 
> (b) that:
> 
>            *             ps->power * cpu_max_freq   cpu_util
>            *   cpu_nrg = ------------------------ * ---------     (3)
>            *                    ps->freq            scale_cpu
> 
>                          <---- (old) ps->cost --->
> 
>      is now
> 
>                  ps->power * cpu_max_freq       1
>      ps-> cost = ------------------------ * ----------
>                          ps->freq            scale_cpu
> 
>                  <---- (old) ps->cost --->
> 
> and (c) that (4) has changed to:
> 
>           *   pd_nrg = ps->cost * \Sum cpu_util                   (4)
> 
> which avoid the division?
> 
> Less changes is always much nicer since it makes it so much easier to
> detect history and review changes.

I'm open to change that, but I will have to contact you offline
what you mean. This comment section in code is really tricky to
handle right.

> 
> I do understand the changes from the technical viewpoint but the review
> took me way too long which I partly blame to all the changes in the
> comments which could have been avoided. Just want to make sure that
> others done have to go through this pain too.
> 

I'll try to apply your comments and produce smaller diff in that
patch.

