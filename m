Return-Path: <linux-kernel+bounces-5040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF68185C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111802839F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778314F68;
	Tue, 19 Dec 2023 10:57:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037514F69;
	Tue, 19 Dec 2023 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 621AA1FB;
	Tue, 19 Dec 2023 02:57:58 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D98FE3F738;
	Tue, 19 Dec 2023 02:57:11 -0800 (PST)
Message-ID: <254a5071-5357-4c63-8fbb-75d68bf29221@arm.com>
Date: Tue, 19 Dec 2023 10:58:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/23] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com, rafael@kernel.org,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-5-lukasz.luba@arm.com>
 <985618de-73cf-4b54-aef4-6e7bbfe86b17@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <985618de-73cf-4b54-aef4-6e7bbfe86b17@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:49, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> The Energy Model (EM) is going to support runtime modification. There
>> are going to be 2 EM tables which store information. This patch aims
>> to prepare the code to be generic and use one of the tables. The function
>> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
>> instead a pointer to 'struct em_perf_state' (which is one of the EM's
>> tables).
> I thought the 2 EM tables design is gone?
> 
> IMHO it would be less code changes and hence a more enjoyable review
> experience if you would add the 'modifiable' feature to the existing EM
> (1) and not add (2) and then remove (1) in [21/23].

I have explained that to some other your email: such approach would
create a patch monster, touching all drivers and frameworks, to just
make sure they still can compile. This is not the right approach.


> 
> 
>   struct em_perf_domain {
> -	struct em_perf_state *table;                <-- (1)
>   	struct em_perf_table __rcu *runtime_table;  <-- (2)
> 
>> Prepare em_pd_get_efficient_state() for the upcoming changes and
>> make it possible to re-use. Return an index for the best performance
> 
> s/make it possible to re-use/make it possible to be re-used ?

OK

> 
>> state for a given EM table. The function arguments that are introduced
>> should allow to work on different performance state arrays. The caller of
>> em_pd_get_efficient_state() should be able to use the index either
>> on the default or the modifiable EM table.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   include/linux/energy_model.h | 30 +++++++++++++++++-------------
>>   1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index b9caa01dfac4..8069f526c9d8 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -175,33 +175,35 @@ void em_dev_unregister_perf_domain(struct device *dev);
>>   
>>   /**
>>    * em_pd_get_efficient_state() - Get an efficient performance state from the EM
>> - * @pd   : Performance domain for which we want an efficient frequency
>> - * @freq : Frequency to map with the EM
>> + * @state:		List of performance states, in ascending order
> 
> (3)
> 
>> + * @nr_perf_states:	Number of performance states
>> + * @freq:		Frequency to map with the EM
>> + * @pd_flags:		Performance Domain flags
>>    *
>>    * It is called from the scheduler code quite frequently and as a consequence
>>    * doesn't implement any check.
>>    *
>> - * Return: An efficient performance state, high enough to meet @freq
>> + * Return: An efficient performance state id, high enough to meet @freq
>>    * requirement.
>>    */
>> -static inline
>> -struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>> -						unsigned long freq)
>> +static inline int
>> +em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
>> +			  unsigned long freq, unsigned long pd_flags)
> 
> (3) but em_pd_get_efficient_state(struct em_perf_state *table
>                                                          ^^^^^
> [...]

Good catch, I'll change that.

