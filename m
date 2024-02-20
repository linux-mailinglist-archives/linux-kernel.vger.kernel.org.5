Return-Path: <linux-kernel+bounces-73772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F289185CAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBCE1F220DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4915442F;
	Tue, 20 Feb 2024 22:43:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12855787
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468983; cv=none; b=WhEs9XdUlmDV5FATJpoSfKjSVzsrMgTqSnNDojlP+y+km7vyvcKsoXiL/4qQf6fRQ/cbnLWhbE9eKGHHPUvOtVWS0dXfI2SzAfqXqCKd8ga+HD+heo19/wHhxAT2vxMPXimtmfOcBXfCTgSjBf5gySjvRFLSyKCm0EhOP+IPw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468983; c=relaxed/simple;
	bh=xYpfPVm/8SPiEX+OWlLBzy/fT7uIpIumid6muk1Xdm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrOlrt6LmxBUTlGSfkXqFg04MSM0KRKxcx9bg2Zdfmn8wiZ07KwPZFSWSAymRxIW4ATdKTnFYIRo7j8uzoaqumNCour0+VyF7Y0PbzGGD+xRZPgnRyWJnjO+MMo38cQ+FhDZAmfHRukdVaejUBNnqY1Ixc4iadzO1xaYh8+4BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB40EFEC;
	Tue, 20 Feb 2024 14:43:36 -0800 (PST)
Received: from [10.57.48.60] (unknown [10.57.48.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E101A3F762;
	Tue, 20 Feb 2024 14:42:55 -0800 (PST)
Message-ID: <7dc34867-dfa8-403e-8a58-920bbda16bec@arm.com>
Date: Tue, 20 Feb 2024 22:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] uclamp sum aggregation
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>, linux-kernel@vger.kernel.org,
 David Dai <davidai@google.com>, Saravana Kannan <saravanak@google.com>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
 <20240206152054.k3uskf3rhd4icmzt@airbuntu>
 <1cc2b8c4-ea0e-4e98-a1a3-2916cccb1ab1@arm.com>
 <20240220154731.ujnbaa65djmiroco@airbuntu>
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240220154731.ujnbaa65djmiroco@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2024 15:47, Qais Yousef wrote:
> On 02/06/24 17:32, Hongyan Xia wrote:
>> On 06/02/2024 15:20, Qais Yousef wrote:
>>> On 02/01/24 13:11, Hongyan Xia wrote:
>>>
>>>> [1]: https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.com/
>>>
>>> Their solution is not acceptable for the same reason yours isn't. Saravana and
>>> David know this and we discussed at LPC. uclamp hints are limits and should not
>>> be summed.
>>
>> Uclamp is a performance hint and nothing in its definition says it can't be
> 
> That's the major problem here. The definition says it can't be summed because
> they're limits. So if two tasks boosted to 1024, then their combined
> performance limit is 2048? Or if 4 tasks are capped to 512, then the combined
> limits is 2048? You're changing the behavior. If not, please help me understand
> how not. You're treating them as 'bandwidth' hints.

You have not looked at this series closely. '4 tasks are capped to 512, 
then the combined limits is 2048?'. This is a misinterpretation of this 
series. The fact that you conclude this series like this is already 
alarming to me.

Also, if you spend time playing with this series or just look at my 
evaluation results, you'll see it gives a much better 'dynamic range' 
than max aggregation. You need only a smaller uclamp value in sum 
aggregation to achieve the same results, often with less power 
consumption. Higher values can give you better performance in a way max 
aggregation can't, and the same amount of power budget often gives you 
less jank.

About changing behavior, yes, I'm changing it from a less effective hint 
to a more effective one.

>> summed. Clearly whether a uclamp approach should be taken should be
>> determined by how well it works as a hint, not by how we calculate it. I
>> would not say I want to reject max aggregation simply because it throws away
>> all other uclamp values except the max. It's because I have real evaluation
>> results showing sum aggregation works as a much better hint.
> 
> It is easy to get numbers that shows improvements. That doesn't necessarily
> mean it is correct.

But telling people that your implementation meets a definition of uclamp 
without showing improved results or a roadmap to address all the 
drawbacks won't convince people that it's the correct solution.

Also, it's likely something that is simpler and works better is correct. 
It's not always true, but it's likely.

>>
>>>> [2]: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510
>>>
>>> I think I clarified several times so far that this is not related to uclamp.
>>> Could you please refrain from referring to it again in the future? This is
>>> misleading and neither helps your cause nor its cause. The fact that you're
>>> relating to it makes me very worried as both links demonstrate lack of
>>> understanding/confusion of what uclamp is supposed to be.
>>
>> The intention of the code is irrelevant. What I'm talking about is what
> 
> It is relevant.
> 
> 1. You failed to get consent on using this an example.
> 2. You failed to demonstrate the purpose of the code and why it was
>     actually added. I don't think you know the full details anyway.
> 3. You're using a hack that is problematic and needs to be deleted as a proof
>     of something good that _we do not want_.
> 4. How do you know it works as you think it is? You're making wrong assumptions
>     that are misleading and quite frankly annoying.
> 
> Generally we don't want to discuss this in this venue. So for the last time
> please stop bringing it up altogether and let's focus on the problems you are
> seeing and trying to fix and leave other people's code out of the discussion.

I find these 4 points arrogant and offensive, which do not belong to the 
mailing list.

I do not need consent from you or need to know the full back story to 
talk about what a piece of public code does. The fun thing is, I even 
spent time understanding what the code intends to do, but clearly to you 
I still 'don't know the full details anyway' and not qualified to talk 
about what the code actually does in real world, as if the intention of 
a kitchen knife matters so much when I explain the knife is dangerous 
and can kill people.

Meanwhile you are making the wrong comment that this series is 
'combining the limits'. Of course, I could just say you failed to 
demonstrate good understanding of the series (this time not just the 
intention, but also what it actually does), but that kind of words 
rarely helps in making any technical progress on mailing lists.

>> effect the code actually has. The fact that you keep thinking I don't
>> understand what the code does even after me explaining "I know what the
>> intention of the code is, I'm just talking about the actual effect of the
>> code" is an even more worrying sign.
>>
>>> Again, this solution is not acceptable and you're moving things in the wrong
>>> direction. We don't want to redesign what uclamp means, but fix some corner
>>> cases. And you're doing the former not the latter.
>>
>> I'm saying max aggregation is not effective and proposing a more effective
>> implementation. In fact, you have sent a series that removes max
>> aggregation. Clearly that does not count as fixing corner cases but is
>> actually a redesign, and I don't understand why you are allowed to do such
>> things and I am not. Also, when something becomes harder and harder to fix,
>> a redesign that solves all the problems is clearly justified.
> 
> I don't have issues with max aggregation removal. I actually would love to see
> it gone. But summing uclamp values changes the meaning of uclamp hints. Which
> is my number 1 concern.
> 
> And you're lumping too many problems to max aggregations. It was brought up
> several times that overutilized definition being tied to misfit is not fit for
> purpose anymore. This needs to be fixed. feec() fails to distribute fairly when
> capacities are equal. This is a known old problem. This needs fixing. energy
> computation needs to evolve to deal with a number of new realities. This needs
> fixing. Load balancer can't correct bad decision at wake up in aligned way with
> feec(), this needs fixing. Adding a new signal is not the right way to fix
> these problems. And the only issue with max-aggregation in practice is the fact
> it is not effective in restricting power use for uclamp_max. It has also the
> minor problem of boosting unnecessarily for the duration of enqueue of the
> task. The correct behavior we want and other vendors has expressed to me in the
> past is to apply the boost/cap only when required; ie the task is running. The
> hardware can cope with this. And this is tied to how cpufreq governor works and
> if there are hardware limitations that makes this hard to achieve, then it is
> up to the governor to decide this, not the scheduler. We already have util_avg
> and util_est. I really don't think we need another addition. We just need to
> fix issues else where and improve the interface with the cpufreq governor to
> honour the performance limits the tasks have so that we can get rid off
> max-aggregation.

We need to lay quite some groundwork for the existing implementation, 
seen by many patches merged recently. Patch like "sched/uclamp: Set 
max_spare_cap_cpu even if max_spare_cap is 0" has already created other 
problems, shown in my evaluation results which I doubt you looked at, 
and now you are saying we need to cope with cpufreq governor and 
hardware limits. It sounds like a much bigger hack when the 
effectiveness of uclamp depends on governor and hardware limits. Also, 
we still don't know how many lines of code are needed to address all 
these problems.

This conversation is going nowhere. The fact that we have gone back and 
forth so many times and you have spent quite some time lecturing me that 
I don't know stuff, and you haven't commented on the drawbacks shown in 
my whitebox tests or on evaluation numbers shown in benchmarks or on 
anything technical of this series even once is very alarming to me. 
Meanwhile, other people have spotted and pointed out technical issues 
like the under-utilization problem. We have wasted too much time on 
this, and I probably will only reply to you on technical discussions 
from now on.

>>
>> What I can summarize from sum aggregation is:
>>
>> Pros:
>> 1. A more effective implementation, proven by evaluation numbers
>> 2. Consuming the same or even less power in benchmarks
>> 3. 350 lines of code in total, less than half of max aggregation
>> 4. This series shows the entirety and effectiveness of sum aggregation, at
>> this very moment, today. Max aggregation needs further filtering and load
>> balancing patches which we have not seen yet.
>> 5. Resolves the drawbacks from max aggregation (which you might say is the
>> same as 4)
>> 6. Significantly reduces uclamp overhead, no bucket operations
>>
>> Cons:
>> 1. should not be summed (although the scheduler used to sum up utilization
>> and util_est sums up a processed PELT signal today)
>> 2. Under-utilization case (which is a problem GROUP_THROTTLE also has, and
>> can be worked around. Please, I know the intention of GROUP_THROTTLE, I'm
>> just talking about its actual effects).
>>
>> I don't see why the things I listed above is in the wrong direction.

