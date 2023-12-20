Return-Path: <linux-kernel+bounces-6531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B41819A06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C11C20A71
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93EF1774A;
	Wed, 20 Dec 2023 08:05:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB101D520;
	Wed, 20 Dec 2023 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 833B51FB;
	Wed, 20 Dec 2023 00:05:52 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D7D3F64C;
	Wed, 20 Dec 2023 00:05:05 -0800 (PST)
Message-ID: <22c41b1a-333e-42b1-839f-a755d88313af@arm.com>
Date: Wed, 20 Dec 2023 08:06:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-12-lukasz.luba@arm.com>
 <2236f098-b889-4d70-b863-11a3f246889c@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <2236f098-b889-4d70-b863-11a3f246889c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 18:50, Dietmar Eggemann wrote:
> On 29/11/2023 12:08, Lukasz Luba wrote:
> 
> [...]
> 
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 489a358b9a00..614891fde8df 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -221,6 +221,52 @@ static int em_allocate_perf_table(struct em_perf_domain *pd,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * em_dev_update_perf_domain() - Update runtime EM table for a device
>> + * @dev		: Device for which the EM is to be updated
>> + * @table	: The new EM table that is going to used from now
> 
> s/going to used/going to be used
> 
>> + *
>> + * Update EM runtime modifiable table for the @dev using the privided @table.
> 
> s/privided/provided
> 
>> + *
>> + * This function uses mutex to serialize writers, so it must not be called
>> + * from non-sleeping context.
>> + *
>> + * Return 0 on success or a proper error in case of failure.
>> + */
>> +int em_dev_update_perf_domain(struct device *dev,
>> +			      struct em_perf_table __rcu *new_table)
>> +{
>> +	struct em_perf_table __rcu *old_table;
>> +	struct em_perf_domain *pd;
>> +
>> +	/*
>> +	 * The lock serializes update and unregister code paths. When the
>> +	 * EM has been unregistered in the meantime, we should capture that
>> +	 * when entering this critical section. It also makes sure that
> 
> What do you want to capture here? You want to block in this moment,
> right? Don't understand the 2. sentence here.
> 
> [...]

There is general issue with module... they can reload. A driver which
registered EM can than later disappear. I had similar issues for the
devfreq cooling. It can happen at any time. In this scenario let's
consider scenario w/ 2 kernel drivers:
1. Main driver which registered EM, e.g. GPU driver
2. Thermal driver which updates that EM
When 1. starts unload process, it has to make sure that it will
not free the main EM 'pd', because the 2. might try to use e.g.
'pd->nr_perf_states' while doing update at the moment.
Thus, this 'pd' has local mutex, to avoid issues of
module unload vs. EM update. The EM unregister will block on
that mutex and let the background update finish it's critical
section.

