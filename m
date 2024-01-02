Return-Path: <linux-kernel+bounces-14302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD703821B15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42781C21E52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCDEADA;
	Tue,  2 Jan 2024 11:38:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16584F4F7;
	Tue,  2 Jan 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C661C15;
	Tue,  2 Jan 2024 03:38:54 -0800 (PST)
Received: from [10.57.86.61] (unknown [10.57.86.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48573F7A6;
	Tue,  2 Jan 2024 03:38:05 -0800 (PST)
Message-ID: <47c72c07-aafe-4f94-864b-53f9e45857db@arm.com>
Date: Tue, 2 Jan 2024 11:39:23 +0000
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
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-15-lukasz.luba@arm.com>
 <20231217180038.vcyaaoni3nvmlf6f@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217180038.vcyaaoni3nvmlf6f@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/23 18:00, Qais Yousef wrote:
> On 11/29/23 11:08, Lukasz Luba wrote:
>> The patch adds needed infrastructure to handle the late CPUs boot, which
>> might change the previous CPUs capacity values. With this changes the new
>> CPUs which try to register EM will trigger the needed re-calculations for
>> other CPUs EMs. Thanks to that the em_per_state::performance values will
>> be aligned with the CPU capacity information after all CPUs finish the
>> boot and EM registrations.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 121 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 121 insertions(+)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index b5016afe6a19..d3fa5a77de80 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -25,6 +25,9 @@ static DEFINE_MUTEX(em_pd_mutex);
>>   
>>   static void em_cpufreq_update_efficiencies(struct device *dev,
>>   					   struct em_perf_state *table);
>> +static void em_check_capacity_update(void);
>> +static void em_update_workfn(struct work_struct *work);
>> +static DECLARE_DELAYED_WORK(em_update_work, em_update_workfn);
>>   
>>   static bool _is_cpu_device(struct device *dev)
>>   {
>> @@ -596,6 +599,10 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>   
>>   unlock:
>>   	mutex_unlock(&em_pd_mutex);
>> +
>> +	if (_is_cpu_device(dev))
>> +		em_check_capacity_update();
>> +
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(em_dev_register_perf_domain);
>> @@ -631,3 +638,117 @@ void em_dev_unregister_perf_domain(struct device *dev)
>>   	mutex_unlock(&em_pd_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
>> +
>> +/*
>> + * Adjustment of CPU performance values after boot, when all CPUs capacites
>> + * are correctly calculated.
>> + */
>> +static void em_adjust_new_capacity(struct device *dev,
>> +				   struct em_perf_domain *pd,
>> +				   u64 max_cap)
>> +{
>> +	struct em_perf_table __rcu *runtime_table;
>> +	struct em_perf_state *table, *new_table;
>> +	int ret, table_size;
>> +
>> +	runtime_table = em_allocate_table(pd);
>> +	if (!runtime_table) {
>> +		dev_warn(dev, "EM: allocation failed\n");
>> +		return;
>> +	}
>> +
>> +	new_table = runtime_table->state;
>> +
>> +	table = em_get_table(pd);
>> +	/* Initialize data based on older runtime table */
>> +	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
>> +	memcpy(new_table, table, table_size);
>> +
>> +	em_put_table();
>> +
>> +	em_init_performance(dev, pd, new_table, pd->nr_perf_states);
>> +	ret = em_compute_costs(dev, new_table, NULL, pd->nr_perf_states,
>> +			       pd->flags);
>> +	if (ret) {
>> +		em_free_table(runtime_table);
>> +		return;
>> +	}
>> +
>> +	ret = em_dev_update_perf_domain(dev, runtime_table);
>> +	if (ret)
>> +		dev_warn(dev, "EM: update failed %d\n", ret);
>> +
>> +	/*
>> +	 * This is one-time-update, so give up the ownership in this updater.
>> +	 * The EM fwk will keep the reference and free the memory when needed.
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
>> +	for_each_possible_cpu(cpu) {
> 
> Can't we instead hook into cpufreq_online/offline() to check if we need to
> do any em related update for this policy?
> 

I think it would be a bit over-engineering. We know the moment when
there is a need for this check - it's when new EM is registered.
Also, for the cpu hotplug, not always the capacity would change,
which would confuse in such code. Not mentioning, that it will create
an extra everhead for that hotplug notification chain, for not good
reason.

