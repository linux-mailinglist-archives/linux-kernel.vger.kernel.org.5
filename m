Return-Path: <linux-kernel+bounces-6560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58100819A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F611F21A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0E1A5B3;
	Wed, 20 Dec 2023 08:22:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B751D698;
	Wed, 20 Dec 2023 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC03B1FB;
	Wed, 20 Dec 2023 00:22:58 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00B383F64C;
	Wed, 20 Dec 2023 00:22:11 -0800 (PST)
Message-ID: <7e3133e6-92cc-43fe-b78e-d50ef0c88efe@arm.com>
Date: Wed, 20 Dec 2023 08:23:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/23] PM: EM: Support late CPUs booting and capacity
 adjustment
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-15-lukasz.luba@arm.com>
 <7ecf31b4-3782-41e7-9372-a1d4e7a46d39@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <7ecf31b4-3782-41e7-9372-a1d4e7a46d39@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> The patch adds needed infrastructure to handle the late CPUs boot, which
>> might change the previous CPUs capacity values. With this changes the new
>> CPUs which try to register EM will trigger the needed re-calculations for
>> other CPUs EMs. Thanks to that the em_per_state::performance values will
>> be aligned with the CPU capacity information after all CPUs finish the
>> boot and EM registrations.
> 
> IMHO, it's worth mentioning here that this added functionality is the 1.
> use case of the modifiable EM.

Make sense. I will add that. It's quite important information, since
it also justifies the EM update feature.

> 
> [...]
> 
>> + * Adjustment of CPU performance values after boot, when all CPUs capacites
>> + * are correctly calculated.
>> + */
>> +static void em_adjust_new_capacity(struct device *dev,
>> +				   struct em_perf_domain *pd,
>> +				   u64 max_cap)
>> +{
> 
> [...]
> 
>> +	/*
>> +	 * This is one-time-update, so give up the ownership in this updater.
>> +	 * The EM fwk will keep the reference and free the memory when needed.
> 
> s/fwk/framework ?

OK

> 
>> +	 */
>> +	em_free_table(runtime_table);
>> +}
>> +
>> +static void em_check_capacity_update(void)
>> +{
>> +	cpumask_var_t cpu_done_mask;
>> +	struct em_perf_state *table;
>> +	struct em_perf_domain *pd;
>> +	unsigned long cpu_capacity;
>> +	int cpu;
>> +
>> +	if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
>> +		pr_warn("no free memory\n");
>> +		return;
>> +	}
>> +
>> +	/* Check if CPUs capacity has changed than update EM */
> 
> s/than/then ?
> 
> Maybe this comment is not needed since there is (1) further down?

Yes, I'll remove that.

> 
> 
>> +	for_each_possible_cpu(cpu) {
>> +		struct cpufreq_policy *policy;
>> +		unsigned long em_max_perf;
>> +		struct device *dev;
>> +		int nr_states;
>> +
>> +		if (cpumask_test_cpu(cpu, cpu_done_mask))
>> +			continue;
>> +
>> +		policy = cpufreq_cpu_get(cpu);
>> +		if (!policy) {
>> +			pr_debug("Accessing cpu%d policy failed\n", cpu);
>> +			schedule_delayed_work(&em_update_work,
>> +					      msecs_to_jiffies(1000));
>> +			break;
>> +		}
>> +		cpufreq_cpu_put(policy);
>> +
>> +		pd = em_cpu_get(cpu);
>> +		if (!pd || em_is_artificial(pd))
>> +			continue;
>> +
>> +		cpumask_or(cpu_done_mask, cpu_done_mask,
>> +			   em_span_cpus(pd));
>> +
>> +		nr_states = pd->nr_perf_states;
>> +		cpu_capacity = arch_scale_cpu_capacity(cpu);
>> +
>> +		table = em_get_table(pd);
>> +		em_max_perf = table[pd->nr_perf_states - 1].performance;
>> +		em_put_table();
>> +
>> +		/*
>> +		 * Check if the CPU capacity has been adjusted during boot
>> +		 * and trigger the update for new performance values.
>> +		 */
> 
> (1)
> 
> [...]

