Return-Path: <linux-kernel+bounces-5246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859A9818879
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3507028322B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92218EA1;
	Tue, 19 Dec 2023 13:18:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438C18E1D;
	Tue, 19 Dec 2023 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9109B1FB;
	Tue, 19 Dec 2023 05:19:11 -0800 (PST)
Received: from [10.57.85.227] (unknown [10.57.85.227])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D163F5A1;
	Tue, 19 Dec 2023 05:18:24 -0800 (PST)
Message-ID: <00f6f550-0f60-4f62-a301-2af94c68b7f8@arm.com>
Date: Tue, 19 Dec 2023 13:19:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/23] PM: EM: Refactor how the EM table is allocated
 and populated
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-8-lukasz.luba@arm.com>
 <fbee5e3b-4c32-443a-b756-943762ae07b8@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <fbee5e3b-4c32-443a-b756-943762ae07b8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
>> Split the process of allocation and data initialization for the EM table.
>> The upcoming changes for modifiable EM will use it.
>>
>> This change is not expected to alter the general functionality.
> 
> NIT: IMHO, I guess you wanted to say: "No functional changes
> introduced"? I.e. all not only general functionality ...
> 

Yes 'no functional changes'. Rafael gave me that sense once - and I use
in such cases.

> [...]
> 
>>   static int em_create_pd(struct device *dev, int nr_states,
>> @@ -234,11 +234,15 @@ static int em_create_pd(struct device *dev, int nr_states,
>>   			return -ENOMEM;
>>   	}
>>   
>> -	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
>> -	if (ret) {
>> -		kfree(pd);
>> -		return ret;
>> -	}
>> +	pd->nr_perf_states = nr_states;
> 
> Why does `pd->nr_perf_states = nr_states;` have to move from
> em_create_perf_table() to em_create_pd()?

Because I have split the old code which did allocation and
initialization w/ data the in em_create_perf_table().

Now we are going to have separate:
1. allocation of a new table (which can be re-used later)
2. initialization of the data (power, freq, etc) in registration
    code path

It will allow to also allow to introduce update data function,
and simply use the same allocation function for both cases:
- EM registration code path
- update EM code path

> 
>> +
>> +	ret = em_allocate_perf_table(pd, nr_states);
>> +	if (ret)
>> +		goto free_pd;
>> +
>> +	ret = em_create_perf_table(dev, pd, pd->table, nr_states, cb, flags);
> 
> If you set it in em_create_pd() then you can use 'pd->nr_perf_states' in
> em_create_perf_table() and doesn't have to pass `nr_states`.
> 
> [...]

That's true. I could further refactor that function and remove that
'nr_states' argument.

I'll do this in v6. Thanks!

