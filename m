Return-Path: <linux-kernel+bounces-22285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDA829BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2241F22560
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E66495C8;
	Wed, 10 Jan 2024 13:55:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC448CC7;
	Wed, 10 Jan 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593492F4;
	Wed, 10 Jan 2024 05:56:08 -0800 (PST)
Received: from [10.57.87.179] (unknown [10.57.87.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54EC03F5A1;
	Wed, 10 Jan 2024 05:55:20 -0800 (PST)
Message-ID: <453d5cf0-9b74-43ff-bcd4-a6fdd7796056@arm.com>
Date: Wed, 10 Jan 2024 13:56:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/23] PM: EM: Refactor
 em_cpufreq_update_efficiencies() arguments
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com,
 amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
 len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io,
 wvw@google.com
References: <20240104171553.2080674-1-lukasz.luba@arm.com>
 <20240104171553.2080674-3-lukasz.luba@arm.com>
 <CAJZ5v0jCtS1XHczORnZFhwO7N=FommFNbQC7NdaM5SHKXUnTog@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jCtS1XHczORnZFhwO7N=FommFNbQC7NdaM5SHKXUnTog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 1/4/24 19:07, Rafael J. Wysocki wrote:
> The word "refactor" appears to be quite loaded in your patch
> descriptions, but it is not always the best one to use IMV.

Fair enough, I'll change those patches according to your comments.

> 
> For instance, this patch simply extends the argument list of
> em_cpufreq_update_efficiencies(), so I would say just that in the
> subject: "Extend em_cpufreq_update_efficiencies() argument list"
> 
> On Thu, Jan 4, 2024 at 6:14 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> In order to prepare the code for the modifiable EM perf_state table,
>> refactor existing function em_cpufreq_update_efficiencies().
> 
> "make em_cpufreq_update_efficiencies() take a pointer to the EM table
> as its second argument and modify it to use that new argument instead
> of the "table" member of dev->em_pd"
> 
> or something like this.

I think I got the point, will change it.

> 
>> The function now takes the ptr to the EM table as its argument.
>>
>> No functional impact.
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
>>          return 0;
>>   }
>>
>> -static void em_cpufreq_update_efficiencies(struct device *dev)
>> +static void
>> +em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>>   {
>>          struct em_perf_domain *pd = dev->em_pd;
>> -       struct em_perf_state *table;
>>          struct cpufreq_policy *policy;
>>          int found = 0;
>>          int i;
>> @@ -254,8 +254,6 @@ static void em_cpufreq_update_efficiencies(struct device *dev)
>>                  return;
>>          }
>>
>> -       table = pd->table;
>> -
>>          for (i = 0; i < pd->nr_perf_states; i++) {
>>                  if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>>                          continue;
>> @@ -397,7 +395,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>>
>>          dev->em_pd->flags |= flags;
>>
>> -       em_cpufreq_update_efficiencies(dev);
>> +       em_cpufreq_update_efficiencies(dev, dev->em_pd->table);
>>
>>          em_debug_create_pd(dev);
>>          dev_info(dev, "EM: created perf domain\n");
>> --
> 
> The code change itself LGTM.

Thanks

