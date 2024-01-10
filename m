Return-Path: <linux-kernel+bounces-22300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B7829BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34100287329
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F584A998;
	Wed, 10 Jan 2024 14:05:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F7495E0;
	Wed, 10 Jan 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C12152F4;
	Wed, 10 Jan 2024 06:05:51 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B85F43F5A1;
	Wed, 10 Jan 2024 06:05:03 -0800 (PST)
Message-ID: <429fbf32-f347-4d6a-88dc-362c898c3dfd@arm.com>
Date: Wed, 10 Jan 2024 14:06:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/23] PM: EM: Add helpers to read under RCU lock the
 EM table
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-13-lukasz.luba@arm.com>
 <CAJZ5v0g9nEis2Bcvygn70vAT=iifHisZ_7_T4PcmQSU_=_Ymgg@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g9nEis2Bcvygn70vAT=iifHisZ_7_T4PcmQSU_=_Ymgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 19:55, Rafael J. Wysocki wrote:
> On Thu, Jan 4, 2024 at 6:15 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> To use the runtime modifiable EM table there is a need to use RCU
>> read locking properly. Add helper functions for the device drivers and
>> frameworks to make sure it's done properly.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index f33257ed83fd..cfaf5d8b1aad 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -338,6 +338,20 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>>          return pd->nr_perf_states;
>>   }
>>
>> +static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
>> +{
>> +       struct em_perf_table __rcu *table;
>> +
>> +       rcu_read_lock();
>> +       table = rcu_dereference(pd->em_table);
>> +       return table->state;
>> +}
>> +
>> +static inline void em_put_table(void)
>> +{
>> +       rcu_read_unlock();
>> +}
> 
> The lack of symmetry between em_get_table() and em_put_table() is kind
> of confusing.
> 
> I don't really like these wrappers.
> 
> IMO it would be better to use rcu_read_lock()/rcu_read_unlock()
> directly everywhere they are needed and there can be a wrapper around
> rcu_dereference(pd->em_table), something like
> 
> static inline struct em_perf_state *em_perf_state_from_pd(struct
> em_perf_domain *pd)
> {
>          return rcu_dereference(pd->em_table)->state;
> }

Fair enough, I will change this and use explicit rcu_read_lock/unlock()
in the thermal/DTPM code together with this above function.
I will add comment to it that it needs to be called under the RCU read
section locked.

Then also it would be easier to handle the function names in patch 10/23
that you have also commented.

> 
>> +
>>   #else
>>   struct em_data_callback {};
>>   #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
>> @@ -384,6 +398,11 @@ int em_dev_update_perf_domain(struct device *dev,
>>   {
>>          return -EINVAL;
>>   }
>> +static inline struct em_perf_state *em_get_table(struct em_perf_domain *pd)
>> +{
>> +       return NULL;
>> +}
>> +static inline void em_put_table(void) {}
>>   #endif
>>
>>   #endif
>> --
> 

