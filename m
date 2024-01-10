Return-Path: <linux-kernel+bounces-22323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE499829C30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D558C1C240E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6B04C3D4;
	Wed, 10 Jan 2024 14:10:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C64C3B8;
	Wed, 10 Jan 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13BF92F4;
	Wed, 10 Jan 2024 06:11:23 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CB843F5A1;
	Wed, 10 Jan 2024 06:10:34 -0800 (PST)
Message-ID: <14e5634b-721a-4444-8825-967d807b71b7@arm.com>
Date: Wed, 10 Jan 2024 14:11:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-12-lukasz.luba@arm.com>
 <CAJZ5v0hqRkDmhRBfB4g-2EH2piv-KOQdwad7rVoSK8FzZKg=TA@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hqRkDmhRBfB4g-2EH2piv-KOQdwad7rVoSK8FzZKg=TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 19:47, Rafael J. Wysocki wrote:
> I don't really like using the API TLA in patch subjects, because it
> does not really say much.  IMO a subject like this would be better:
> 
> "PM: EM: Introduce em_dev_update_perf_domain() for EM updates"

Fair enough

> 
> On Thu, Jan 4, 2024 at 6:15 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Add API function em_dev_update_perf_domain() which allows to safely
>> change the EM.
> 
> "... which allows the EM to be changed safely."

OK

> 
> New paragraph:
> 
>> The concurrent modifiers are protected by the mutex
>> to serialize them. Removal of the old memory is asynchronous and
>> handled by the RCU mechanisms.
> 
> "Concurrent updaters are serialized with a mutex and the removal of
> memory that will not be used any more is carried out with the help of
> RCU."

OK

> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h |  8 +++++++
>>   kernel/power/energy_model.c  | 41 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 753d70d0ce7e..f33257ed83fd 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -183,6 +183,8 @@ struct em_data_callback {
>>
>>   struct em_perf_domain *em_cpu_get(int cpu);
>>   struct em_perf_domain *em_pd_get(struct device *dev);
>> +int em_dev_update_perf_domain(struct device *dev,
>> +                             struct em_perf_table __rcu *new_table);
>>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>                                  struct em_data_callback *cb, cpumask_t *span,
>>                                  bool microwatts);
>> @@ -376,6 +378,12 @@ struct em_perf_table __rcu *em_allocate_table(struct em_perf_domain *pd)
>>          return NULL;
>>   }
>>   static inline void em_free_table(struct em_perf_table __rcu *table) {}
>> +static inline
>> +int em_dev_update_perf_domain(struct device *dev,
>> +                             struct em_perf_table __rcu *new_table)
>> +{
>> +       return -EINVAL;
>> +}
>>   #endif
>>
>>   #endif
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index bbc406db0be1..496dc00835c6 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -220,6 +220,47 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
>>          return 0;
>>   }
>>
>> +/**
>> + * em_dev_update_perf_domain() - Update runtime EM table for a device
>> + * @dev                : Device for which the EM is to be updated
>> + * @table      : The new EM table that is going to be used from now
> 
> This is called "new_table" below.

good catch

> 
>> + *
>> + * Update EM runtime modifiable table for the @dev using the provided @table.
>> + *
>> + * This function uses mutex to serialize writers, so it must not be called
> 
> "uses a mutex"

OK

> 
>> + * from non-sleeping context.
> 
> "a non-sleeping context".

OK

> 
>> + *
>> + * Return 0 on success or a proper error in case of failure.
> 
> It is not clear what "a proper error" means.  It would be better to
> simply say "or an error code on failure" IMO.

Agree, I'll change it.

> 
>> + */
>> +int em_dev_update_perf_domain(struct device *dev,
>> +                             struct em_perf_table __rcu *new_table)
>> +{
>> +       struct em_perf_table __rcu *old_table;
>> +       struct em_perf_domain *pd;
>> +
>> +       /* Serialize update/unregister or concurrent updates */
>> +       mutex_lock(&em_pd_mutex);
>> +
>> +       if (!dev || !dev->em_pd) {
> 
> dev need not be checked under the lock.

True, I will put it about the lock.

> 
>> +               mutex_unlock(&em_pd_mutex);
>> +               return -EINVAL;
>> +       }
>> +       pd = dev->em_pd;
>> +
>> +       em_table_inc(new_table);
>> +
>> +       old_table = pd->em_table;
>> +       rcu_assign_pointer(pd->em_table, new_table);
>> +
>> +       em_cpufreq_update_efficiencies(dev, new_table->state);
>> +
>> +       em_table_dec(old_table);
>> +
>> +       mutex_unlock(&em_pd_mutex);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(em_dev_update_perf_domain);
>> +
>>   static int em_create_runtime_table(struct em_perf_domain *pd)
>>   {
>>          struct em_perf_table __rcu *table;
>> --


Thank you for the review!

Regards,
Lukasz

