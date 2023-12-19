Return-Path: <linux-kernel+bounces-5016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D0D818551
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680F5B21FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B314AA4;
	Tue, 19 Dec 2023 10:29:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834EE14A8F;
	Tue, 19 Dec 2023 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2923D1FB;
	Tue, 19 Dec 2023 02:30:13 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A03BB3F738;
	Tue, 19 Dec 2023 02:29:26 -0800 (PST)
Message-ID: <89df2982-5492-43db-8e25-d974ff19fda2@arm.com>
Date: Tue, 19 Dec 2023 10:30:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/23] PM: EM: Refactor
 em_cpufreq_update_efficiencies() arguments
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-3-lukasz.luba@arm.com>
 <20231217175812.s5vaabxtm4cgil36@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217175812.s5vaabxtm4cgil36@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/23 17:58, Qais Yousef wrote:
> On 11/29/23 11:08, Lukasz Luba wrote:
>> In order to prepare the code for the modifiable EM perf_state table,
>> refactor existing function em_cpufreq_update_efficiencies().
> 
> nit: What is being refactored here? The description is not adding much info
> about the change.

The function takes the ptr to the table now as its argument. You have
missed that in the code below?

> 
> 
> Cheers
> 
> --
> Qais Yousef
> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 8b9dd4a39f63..42486674b834 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -237,10 +237,10 @@ static int em_create_pd(struct device *dev, int nr_states,
>>   	return 0;
>>   }
>>   
>> -static void em_cpufreq_update_efficiencies(struct device *dev)
>> +static void
>> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>>   {
>>   	struct em_perf_domain *pd = dev->em_pd;
>> -	struct em_perf_state *table;
>>   	struct cpufreq_policy *policy;
>>   	int found = 0;
>>   	int i;
>> @@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>>   		return;
>>   	}
>>   
>> -	table = pd->table;
>> -
>>   	for (i = 0; i < pd->nr_perf_states; i++) {
>>   		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>>   			continue;
>> @@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>   
>>   	dev->em_pd->flags |= flags;
>>   
>> -	em_cpufreq_update_efficiencies(dev);
>> +	em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>>   
>>   	em_debug_create_pd(dev);
>>   	dev_info(dev, "EM: created perf domain\n");
>> -- 
>> 2.25.1
>>
> 

