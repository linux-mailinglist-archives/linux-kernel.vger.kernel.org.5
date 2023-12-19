Return-Path: <linux-kernel+bounces-5035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD48185B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407B41F25086
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EC14F77;
	Tue, 19 Dec 2023 10:52:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE314F68;
	Tue, 19 Dec 2023 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A00F1FB;
	Tue, 19 Dec 2023 02:53:03 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CE713F738;
	Tue, 19 Dec 2023 02:52:16 -0800 (PST)
Message-ID: <b31672e4-ab41-4724-86ef-038606318663@arm.com>
Date: Tue, 19 Dec 2023 10:53:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/23] PM: EM: Find first CPU active while updating OPP
 efficiency
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-4-lukasz.luba@arm.com>
 <20231217175829.a6hqz7mqlvrujsvs@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231217175829.a6hqz7mqlvrujsvs@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/17/23 17:58, Qais Yousef wrote:
> On 11/29/23 11:08, Lukasz Luba wrote:
>> The Energy Model might be updated at runtime and the energy efficiency
>> for each OPP may change. Thus, there is a need to update also the
>> cpufreq framework and make it aligned to the new values. In order to
>> do that, use a first active CPU from the Performance Domain. This is
>> needed since the first CPU in the cpumask might be offline when we
>> run this code path.
> 
> I didn't understand the problem here. It seems you're fixing a race, but the
> description is not clear to me what the race is.

I have explained that in v1, v4 comments for this patch.
When the EM is registered the fist CPU is always online. No problem
for the old code, but for new code with runtime modification at
later time, potentially from different subsystems - it it (e.g. thermal,
drivers, etc). The fist CPU might be offline, but still such EM
update for this domain shouldn'y fail. Although, when the CPU is offline
we cannot get the valid policy...

We can get it for next cpu in the cpumask, that's what the code is
doing.

> 
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 42486674b834..aa7c89f9e115 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>>   	struct em_perf_domain *pd = dev->em_pd;
>>   	struct cpufreq_policy *policy;
>>   	int found = 0;
>> -	int i;
>> +	int i, cpu;
>>   
>>   	if (!_is_cpu_device(dev) || !pd)
>>   		return;
>>   
>> -	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
>> +	/* Try to get a CPU which is active and in this PD */
>> +	cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);
>> +	if (cpu >= nr_cpu_ids) {
>> +		dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
>> +		return;
>> +	}
>> +
>> +	policy = cpufreq_cpu_get(cpu);
> 
> Shouldn't policy be NULL here if all policy->realted_cpus were offlined?

It will be NULL but we will capture that fact in other way in the 'if'
above.

We want something else.

We want to get policy using 'some' online CPU's id from our known
cpumask. Then we can continue with such policy in the code.

