Return-Path: <linux-kernel+bounces-55055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070584B6F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1448289026
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018D131E58;
	Tue,  6 Feb 2024 13:53:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A6131E3B;
	Tue,  6 Feb 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227592; cv=none; b=a5kHelZnfkjEACoSIfTLifrtshwtjqsIiNnuqgC3DBfrAxqY6mmupuNRSiG2nNQs042hYNu4wBlUKxuUdgJyiGE43VOp7LurlPT80DnblRGpf7d7sxFRud7zb6mwGvkJ11TFNNxEUdytIrO6gUmkfaKRiyLZF0ZtN1AOFYxmxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227592; c=relaxed/simple;
	bh=GeIHvzGJUx6TpZYFTpsqM29CfERIaLtZeoY/9kXIZig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL1yP0h7GPxmM+cf1SKEBJFRmW4MO2PWAUQM0+Krr6G0lnfvZHnYUHWEwvjCpOy788fqe6MzRuHRyoVXHGVot2DK7buMCGCB1k8vVkDyQqC/5PGVrYVX5RdTcZseWZURj8gg32AYn8E1FdOZiVeFeoZnLowYhLrzFN16LC2cVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB7911FB;
	Tue,  6 Feb 2024 05:53:50 -0800 (PST)
Received: from [10.57.8.150] (unknown [10.57.8.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B740B3F5A1;
	Tue,  6 Feb 2024 05:53:05 -0800 (PST)
Message-ID: <ec8c1bb3-4efb-423e-adc8-c68a9e76c69c@arm.com>
Date: Tue, 6 Feb 2024 13:53:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/23] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com, xuewen.yan94@gmail.com, linux-pm@vger.kernel.org,
 rafael@kernel.org
References: <20240117095714.1524808-1-lukasz.luba@arm.com>
 <20240117095714.1524808-5-lukasz.luba@arm.com>
 <000f7a73-9bd0-4c78-ba24-ef2e150882e7@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <000f7a73-9bd0-4c78-ba24-ef2e150882e7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/17/24 12:45, Hongyan Xia wrote:
> On 17/01/2024 09:56, Lukasz Luba wrote:
>> The Energy Model (EM) is going to support runtime modification. There
>> are going to be 2 EM tables which store information. This patch aims
>> to prepare the code to be generic and use one of the tables. The function
>> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
>> instead a pointer to 'struct em_perf_state' (which is one of the EM's
>> tables).
>>
>> Prepare em_pd_get_efficient_state() for the upcoming changes and
>> make it possible to be re-used. Return an index for the best performance
>> state for a given EM table. The function arguments that are introduced
>> should allow to work on different performance state arrays. The caller of
>> em_pd_get_efficient_state() should be able to use the index either
>> on the default or the modifiable EM table.
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 30 +++++++++++++++++-------------
>>   1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index c19e7effe764..b01277b17946 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device 
>> *dev);
>>   /**
>>    * em_pd_get_efficient_state() - Get an efficient performance state 
>> from the EM
>> - * @pd   : Performance domain for which we want an efficient frequency
>> - * @freq : Frequency to map with the EM
>> + * @table:        List of performance states, in ascending order
>> + * @nr_perf_states:    Number of performance states
>> + * @freq:        Frequency to map with the EM
>> + * @pd_flags:        Performance Domain flags
>>    *
>>    * It is called from the scheduler code quite frequently and as a 
>> consequence
>>    * doesn't implement any check.
>>    *
>> - * Return: An efficient performance state, high enough to meet @freq
>> + * Return: An efficient performance state id, high enough to meet @freq
>>    * requirement.
>>    */
>> -static inline
>> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain 
>> *pd,
>> -                        unsigned long freq)
>> +static inline int
>> +em_pd_get_efficient_state(struct em_perf_state *table, int 
>> nr_perf_states,
>> +              unsigned long freq, unsigned long pd_flags)
>>   {
>>       struct em_perf_state *ps;
>>       int i;
>> -    for (i = 0; i < pd->nr_perf_states; i++) {
>> -        ps = &pd->table[i];
>> +    for (i = 0; i < nr_perf_states; i++) {
>> +        ps = &table[i];
>>           if (ps->frequency >= freq) {
>> -            if (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>> +            if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
>>                   ps->flags & EM_PERF_STATE_INEFFICIENT)
>>                   continue;
>> -            break;
>> +            return i;
>>           }
>>       }
>> -    return ps;
>> +    return nr_perf_states - 1;
>>   }
>>   /**
>> @@ -226,7 +228,7 @@ static inline unsigned long em_cpu_energy(struct 
>> em_perf_domain *pd,
>>   {
>>       unsigned long freq, ref_freq, scale_cpu;
>>       struct em_perf_state *ps;
>> -    int cpu;
>> +    int cpu, i;
>>       if (!sum_util)
>>           return 0;
>> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct 
>> em_perf_domain *pd,
>>        * Find the lowest performance state of the Energy Model above the
>>        * requested frequency.
>>        */
>> -    ps = em_pd_get_efficient_state(pd, freq);
>> +    i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
>> +                      pd->flags);
>> +    ps = &pd->table[i];
>>       /*
>>        * The capacity of a CPU in the domain at the performance state 
>> (ps)
> 
> Reviewed-by: Hongyan Xia <hongyan.xia@arm.com>
> 

Thank you Hongyan for the reviews!
I might address your NIT comment for the patch 2/24 when
I do the re-basing and sending the v8 (if there is a need).

Regards,
Lukasz

