Return-Path: <linux-kernel+bounces-167755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812D8BAEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706661C2180D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF885154C03;
	Fri,  3 May 2024 14:19:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E541057C84;
	Fri,  3 May 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745952; cv=none; b=B+rz3WikZKyFW5WkyTtXpaXww51JikTo4nj2LTalI5DdbNkGoKDwUsKaaRnQcaJgR9GNnQhwFQgEFI65uEkKMK8YdTkzoklfOfwvQgbPJsH4tRDsUGkiamf2imSZdkIuFlTb/k+Jx0pTiQuJK+GnaQaGez5iHH90cPe7vsZcymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745952; c=relaxed/simple;
	bh=J2E2MTOfGKJBQDbXhn2vGGm5jGIDG5H8kR6g4UqiTJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3CNfHKspo6D6TzCUDBRmXQiYRDKBtodAnex7ZWniy3XDxyr+4S52sYeSwF/kct9Ifergcgc8JfbDGRQpaa793DmvoYECyvBdU9UqHdX/57h/QpwA86lKBTZcMNqdUzIgZ+v73OpEHbwOyfi56d0c/2mNqmS38z4HRYH5n/JcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F15913D5;
	Fri,  3 May 2024 07:19:35 -0700 (PDT)
Received: from [10.57.34.89] (unknown [10.57.34.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E7A53F73F;
	Fri,  3 May 2024 07:19:07 -0700 (PDT)
Message-ID: <06e3fd1a-a4c0-4be5-840c-e5ba276fe253@arm.com>
Date: Fri, 3 May 2024 16:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
To: Viresh Kumar <viresh.kumar@linaro.org>, liwei <liwei728@huawei.com>,
 Ionela Voinescu <ionela.voinescu@arm.com>,
 Beata Michalska <beata.michalska@arm.com>,
 Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, liwei391@huawei.com,
 liaoyu15@huawei.com
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240429104945.esdukn6ayudgyumc@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Liwei,
The change itself seems ok, but I'm not sure I understand what the
issue is exactly.

On 4/29/24 12:49, Viresh Kumar wrote:
> CC'ing few folks who are working with the driver.
> 
> On 28-04-24, 17:28, liwei wrote:
>> When turning on turbo, if frequency configuration takes effect slowly,
>> the updated policy->cur may be equal to the frequency configured in
>> governor->limits(), performance governor will not adjust the frequency,
>> configured frequency will remain at turbo-freq.
>>
>> Simplified call stack looks as follows:
>> cpufreq_register_driver(&cppc_cpufreq_driver)
>> 	...
>> 	cppc_cpufreq_cpu_init()
>> 		cppc_get_perf_caps()
>> 		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
>> 			cppc_set_perf(highest_perf) // set highest_perf
>> 			policy->cur = cpufreq_driver->get() // if cur == policy->max

During the driver initialization, we have:
cppc_cpufreq_cpu_init()
\-policy->max = cppc_perf_to_khz(caps, caps->nominal_perf)
\-policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
\-cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
\-cppc_set_perf(cpu, &cpu_data->perf_ctrls); // set freq to highest_perf
so here:
policy->max = nominal_freq
policy->cur = highest_freq


And then for the cpufreq framework:
cpufreq_online()
// IIUC there is some delay here, so policy->cur = nominal_freq ?
// i.e. the freq. was requested to change to the highest_freq,
// but the change is not effective yet ?
\-policy->cur = cpufreq_driver->get(policy->cpu);
\-cpufreq_init_policy()
   \-cpufreq_set_policy()
     \-cpufreq_start_governor()
       \-cpufreq_verify_current_freq()
         \-new_freq = cpufreq_driver->get(policy->cpu); // new_freq = nominal_freq ?
         \-if (policy->cur != new_freq)
         \-  cpufreq_out_of_sync()
           \- policy->cur = new_freq;
     \-cpufreq_start_governor()
       \-cpufreq_gov_performance_limits()
         \-__cpufreq_driver_target(target_freq=policy->max) // with policy->max = nominal_freq ?
           \-if (target_freq == policy->cur)
           \-  // do nothing

I am not sure I understand when you are turning the turbo on with:
# echo 1 > /sys/devices/system/cpu/cpufreq/boost

Or do you mean that turbo is available but not turned on ?


Regards,
Pierre

>> 	cpufreq_init_policy()
>> 		...
>> 		cpufreq_start_governor() // governor: performance
>> 			new_freq = cpufreq_driver->get() // if new_freq == policy->max
>> 			if (policy->cur != new_freq)
>> 			cpufreq_out_of_sync(policy, new_freq)
>> 				...
>> 				policy->cur = new_freq
>> 			...
>> 			policy->governor->limits()
>> 				__cpufreq_driver_target(policy->max)
>> 					if (policy->cur==target)
>> 					// generate error, keep set highest_perf
>> 						ret
>> 					cppc_set_perf(target)
>>
>> Fix this by changing highest_perf to nominal_perf in cppc_cpufreq_cpu_init().
>>
>> Fixes: 5477fb3bd1e8 ("ACPI / CPPC: Add a CPUFreq driver for use with CPPC")
>> Signed-off-by: liwei <liwei728@huawei.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 64420d9cfd1e..db04a82b8a97 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -669,14 +669,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	if (caps->highest_perf > caps->nominal_perf)
>>   		boost_supported = true;
>>   
>> -	/* Set policy->cur to max now. The governors will adjust later. */
>> -	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>> -	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>> +	/* Set policy->cur to norm now. */
>> +	policy->cur = cppc_perf_to_khz(caps, caps->nominal_perf);
>> +	cpu_data->perf_ctrls.desired_perf =  caps->nominal_perf;
>>   
>>   	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>   	if (ret) {
>>   		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -			 caps->highest_perf, cpu, ret);
>> +			 caps->nominal_perf, cpu, ret);
>>   		goto out;
>>   	}
>>   
>> -- 
>> 2.25.1
> 

