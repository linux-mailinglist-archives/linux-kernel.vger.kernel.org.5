Return-Path: <linux-kernel+bounces-4904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287B8183A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D63286217
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99311C9D;
	Tue, 19 Dec 2023 08:44:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D714A87;
	Tue, 19 Dec 2023 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B7C81FB;
	Tue, 19 Dec 2023 00:44:45 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7933F738;
	Tue, 19 Dec 2023 00:43:58 -0800 (PST)
Message-ID: <9f7ec4e9-b076-4ba2-af27-1ed74e0355a7@arm.com>
Date: Tue, 19 Dec 2023 08:45:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/23] PM: EM: Add API for memory allocations for new
 tables
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-11-lukasz.luba@arm.com>
 <20231217175954.ascmdio7smqwmnfi@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217175954.ascmdio7smqwmnfi@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/23 17:59, Qais Yousef wrote:
> On 11/29/23 11:08, Lukasz Luba wrote:
>> The runtime modified EM table can be provided from drivers. Create
>> mechanism which allows safely allocate and free the table for device
>> drivers. The same table can be used by the EAS in task scheduler code
>> paths, so make sure the memory is not freed when the device driver module
>> is unloaded.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 11 +++++++++
>>   kernel/power/energy_model.c  | 44 ++++++++++++++++++++++++++++++++++--
>>   2 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 94a77a813724..e785211828fe 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/device.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/kobject.h>
>> +#include <linux/kref.h>
>>   #include <linux/rcupdate.h>
>>   #include <linux/sched/cpufreq.h>
>>   #include <linux/sched/topology.h>
>> @@ -39,10 +40,12 @@ struct em_perf_state {
>>   /**
>>    * struct em_perf_table - Performance states table
>>    * @rcu:	RCU used for safe access and destruction
>> + * @refcount:	Reference count to track the owners
>>    * @state:	List of performance states, in ascending order
>>    */
>>   struct em_perf_table {
>>   	struct rcu_head rcu;
>> +	struct kref refcount;
>>   	struct em_perf_state state[];
>>   };
>>   
>> @@ -184,6 +187,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>   				struct em_data_callback *cb, cpumask_t *span,
>>   				bool microwatts);
>>   void em_dev_unregister_perf_domain(struct device *dev);
>> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd);
>> +void em_free_table(struct em_perf_table __rcu *table);
>>   
>>   /**
>>    * em_pd_get_efficient_state() - Get an efficient performance state from the EM
>> @@ -368,6 +373,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>>   {
>>   	return 0;
>>   }
>> +static inline
>> +struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
>> +{
>> +	return NULL;
>> +}
>> +static inline void em_free_table(struct em_perf_table __rcu *table) {}
>>   #endif
>>   
>>   #endif
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 489287666705..489a358b9a00 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -114,12 +114,46 @@ static void em_destroy_table_rcu(struct rcu_head *rp)
>>   	kfree(runtime_table);
>>   }
>>   
>> -static void em_free_table(struct em_perf_table __rcu *table)
>> +static void em_release_table_kref(struct kref *kref)
>>   {
>> +	struct em_perf_table __rcu *table;
>> +
>> +	/* It was the last owner of this table so we can free */
>> +	table = container_of(kref, struct em_perf_table, refcount);
>> +
>>   	call_rcu(&table->rcu, em_destroy_table_rcu);
>>   }
>>   
>> -static struct em_perf_table __rcu *
>> +static inline void em_inc_usage(struct em_perf_table __rcu *table)
>> +{
>> +	kref_get(&table->refcount);
>> +}
>> +
>> +static void em_dec_usage(struct em_perf_table __rcu *table)
>> +{
>> +	kref_put(&table->refcount, em_release_table_kref);
>> +}
> 
> nit: em_table_inc/dec() instead? matches general theme elsewhere in the code
> base.

Looks good, I will change it.

> 
>> +
>> +/**
>> + * em_free_table() - Handles safe free of the EM table when needed
>> + * @table : EM memory which is going to be freed
>> + *
>> + * No return values.
>> + */
>> +void em_free_table(struct em_perf_table __rcu *table)
>> +{
>> +	em_dec_usage(table);
>> +}
>> +
>> +/**
>> + * em_allocate_table() - Handles safe allocation of the new EM table
>> + * @table : EM memory which is going to be freed
>> + *
>> + * Increments the reference counter to mark that there is an owner of that
>> + * EM table. That might be a device driver module or EAS.
>> + * Returns allocated table or error.
>> + */
>> +struct em_perf_table __rcu *
>>   em_allocate_table(struct em_perf_domain *pd)
>>   {
>>   	struct em_perf_table __rcu *table;
>> @@ -128,6 +162,12 @@ em_allocate_table(struct em_perf_domain *pd)
>>   	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
>>   
>>   	table = kzalloc(sizeof(*table) + table_size, GFP_KERNEL);
>> +	if (!table)
>> +		return table;
>> +
>> +	kref_init(&table->refcount);
>> +	em_inc_usage(table);
> 
> Doesn't kref_init() initialize to the count to 1 already? Is the em_inc_usage()
> needed here?

Good catch this is not needed here. Thanks!

