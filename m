Return-Path: <linux-kernel+bounces-27529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB082F1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF031C23646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A631C6A5;
	Tue, 16 Jan 2024 15:33:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274C1C290;
	Tue, 16 Jan 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A82ED2F4;
	Tue, 16 Jan 2024 07:34:00 -0800 (PST)
Received: from [10.57.91.114] (unknown [10.57.91.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A8B3F766;
	Tue, 16 Jan 2024 07:33:10 -0800 (PST)
Message-ID: <e74edb50-5dba-4c81-a383-eb97e6bc5f29@arm.com>
Date: Tue, 16 Jan 2024 15:34:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
 amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, wvw@google.com
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
 <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
 <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>
 <20240115122156.5743y4trhm4tkgs3@airbuntu>
 <661068a2-7c46-4703-ba4d-5ce1cdf44b3d@arm.com>
 <20240116131033.45berjhpwzc4hwr7@airbuntu>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20240116131033.45berjhpwzc4hwr7@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/24 13:10, Qais Yousef wrote:
> On 01/15/24 12:36, Lukasz Luba wrote:
>>
>>
>> On 1/15/24 12:21, Qais Yousef wrote:
>>> On 01/10/24 13:53, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 1/4/24 19:23, Qais Yousef wrote:
>>>>> On 01/02/24 11:47, Lukasz Luba wrote:
>>>>>>> Did you see a problem or just being extra cautious here?
>>>>>>
>>>>>> There is no problem, 'cost' is a private coefficient for EAS only.
>>>>>
>>>>> Let me  ask differently, what goes wrong if you don't increase the resolution
>>>>> here? Why is it necessary?
>>>>>
>>>>
>>>>
>>>> When you have 800mW at CPU capacity 1024, then the value is small (below
>>>> 1 thousand).
>>>> Example:
>>>> power = 800000 uW
>>>> cost = 800000 / 1024 = 781
>>>>
>>>> While I know from past that sometimes OPPs might have close voltage
>>>> values and a rounding could occur and make some OPPs inefficient
>>>> while they aren't.
>>>>
>>>> This is what would happen when we have the 1x resolution:
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:551
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:644
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:744
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:851
>>>> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:493
>>>> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:493
>>>> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:493
>>>> The bottom 3 OPPs have the same 'cost' thus 2 OPPs are in-efficient,
>>>> which is not true (see below).
>>>>
>>>> This is what would happen when we have the 10x resolution:
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:5513
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:6443
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:7447
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:8514
>>>> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:4934
>>>> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:4933
>>>> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:4934
>>>> Here the OPP with 600MHz is more efficient than 408MHz,
>>>> which is true. So only 408MHz will be marked as in-efficient OPP.
>>>>
>>>>
>>>> This is what would happen when we have the 100x resolution:
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:55137
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:64433
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:74473
>>>> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:85140
>>>> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:49346
>>>> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:49331
>>>> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:49346
>>>> The higher (100x) resolution does not bring that much in
>>>> practice.
>>>
>>> So it seems a uW is not sufficient enough. We moved from mW because of
>>> resolution already. Shall we make it nW then and multiply by 1000 always? The
>>> choice of 10 looks arbitrary IMHO
>>>
>>
>> No, there is no need of nW in the 'power' field for this.
>> You've missed the point.
> 
> I think you're missing what I am saying. The multiplication by 10 looks like
> magic value to increase resolution based on a single observation you noticed.
> 
> The feedback I am giving is that this needs to be better explained, in
> a comment. And instead of multiplying by 10 multiply by 1000. Saying this is
> enough based on a single observation is not adequate IMO.

I think you are trying to review something which you don't have full
details and previous history. I have been fighting with those rounding
issues in past and there are commits with description of issues.
You haven't analyze all edge cases, one more is below (about your
proposal with 1000x the nW).

> 
> Also the difference is tiny. Could you actually measure a difference in overall
> power with and without this extra decimal point resolution? It might be better

Yes, I had such power measurements, but for older rounding issues. Take
into account that the EM model is reflecting one CPU, but in reality we
often have 4 CPUs linked together in one frequency domain. Thus, a small
energy difference is actually multiplied.

> to run at 816MHz and go back to idle faster. So the trade-off is not clear cut
> to me.

It's not the $subject to discuss other possible design which set such
trade-offs differently. Please don't mix many topics. A "race to idle"
from OPPs which have a bit higher voltage is totally different topic,
currently not in EAS design at all. Otherwise we end up in a heuristic
issue like: how much more 'inefficient' it has to be to skip it.
Currently we are strict in 'inefficient' OPP tagging.

> 
> So generally I am not keen on magic values based on single observations.
> I think removing this or use 1000 is better.

That is your opinion. I've tried to explain to you:
1) why we cannot remove it and why we need the 10x
2) why we don't need more that 10x

> 
> AFAICT you decided that 0.1uW is worth caring about. But 0.19uW difference
> isn't.

It's not strictly related to power value, but the earlier division
operation that we perform in setup time and not in runtime (in different
order on the arguments in the math involved). That operation cuts some
important information from the integer value (as listed above in those
different configurations' dumps of 'cost' values).

> 
> I can't see how much difference this makes in practice tbh. But using more
> uniform conversion so that the cost is in nW (keep the power field in uW) makes
> more sense at least.

This is the edge case which I've mentioned at the begging that you're
missing some background. Your proposal is to have 1000x resolution so in
nano-Watts power for the 'cost'. Let's consider example power of 1.4Watt
on single CPU at mid-high-freq OPP (700 capacity), running on 32bit
kernel, so unsigned long has 32bit.

power = 1.4W = 1400000000nW

cost = 1400000000 / 700 = 2000000 (2mln)

Then in EAS we can have this simulation:
4 CPUs with util 550 voting for this OPP (700 capacity),
so the em_cpu_energy() would perform:

return cost * sum_util

2000000 * (4 * 550) = 4400000000 <--- overflow on 32bit ulong

That's why I said you haven't considered your proposal fully.

> 
> It still raises the question whether this minuscule cost difference is actually
> better taken into account. I think the perf/watt for 816MHz is much better so
> skipping 600MHz as inefficient looks better to me.
> 

This is exactly the place where we disagree. You "think the perf/watt
for 816MHz is much better so skipping 600MHz as inefficient looks
better". For me, the numbers from 3 different configuration dumps are
telling me exactly opposite. I will base the algorithms on the numbers
and not on a heuristic that I think looks better.

I'm going to send v7. Please end this discussion on v5.

Regards,
Lukasz

