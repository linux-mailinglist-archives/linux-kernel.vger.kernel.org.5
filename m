Return-Path: <linux-kernel+bounces-53129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D984A109
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D048CB25349
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BB481A0;
	Mon,  5 Feb 2024 17:36:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D5E48786;
	Mon,  5 Feb 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154562; cv=none; b=MLFADHAWv/3kojEEpguFC56FbaDH6VR/hySV26ptEZbC1m/kpn+XiXB0AI8l6sVtSWVVCGdtEy/KrPrTNtfYmLm6JEk1YU4YN1LlRoqxRVqBWL+Hro/CLcHy4aDfrefnqSx9vSPe9V5gVFxt3f8Wdvvu9LUPN3qaQWfuUHNwudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154562; c=relaxed/simple;
	bh=y3teXgT1pKfAzEHmNJo3iLNwZ/H7kV889ZteVNjAdqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayKxYuI/oGCT/7Cw20gVZjqeqkii9FXyIE0/eD4IRxsu4dkscsARxuoiMbFAFBiTZYSxQMpRI4aeo+B/PoBEAvVJZOb4W9tKLIQdtz34OM8LVX34OIwxQc5CJ+3F7OIVMEngvRMrz6hYIQbjjmx0UMxDqbf4crcZwxlWjW/aMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0518612FC;
	Mon,  5 Feb 2024 09:36:42 -0800 (PST)
Received: from [10.57.47.222] (unknown [10.57.47.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600C73F5A1;
	Mon,  5 Feb 2024 09:35:57 -0800 (PST)
Message-ID: <f782f0d4-99ba-4876-bd20-03aaae20c0e0@arm.com>
Date: Mon, 5 Feb 2024 17:35:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <326b568d-d460-4a69-9336-28da328ffdcf@arm.com>
 <20240205120147.ui5zab2b2j4looex@airbuntu>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240205120147.ui5zab2b2j4looex@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 12:01, Qais Yousef wrote:
> Hi Christian
> 
> On 02/05/24 09:17, Christian Loehle wrote:
>> On 05/02/2024 02:25, Qais Yousef wrote:
>>> 10ms is too high for today's hardware, even low end ones. This default
>>> end up being used a lot on Arm machines at least. Pine64, mac mini and
>>> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
>>> it's too high for all of them.
>>>
>>> Change the default to 2ms which should be 'pessimistic' enough for worst
>>> case scenario, but not too high for platforms with fast DVFS hardware.
>>>
>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>>> ---
>>>  drivers/cpufreq/cpufreq.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 44db4f59c4cc..8207f7294cb6 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>>>  		 * for platforms where transition_latency is in milliseconds, it
>>>  		 * ends up giving unrealistic values.
>>>  		 *
>>> -		 * Cap the default transition delay to 10 ms, which seems to be
>>> +		 * Cap the default transition delay to 2 ms, which seems to be
>>>  		 * a reasonable amount of time after which we should reevaluate
>>>  		 * the frequency.
>>>  		 */
>>> -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
>>> +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
>>>  	}
>>>  
>>>  	return LATENCY_MULTIPLIER;
>>
>> Hi Qais,
>> as previously mentioned I'm working on improving iowait boost and while I'm not against
>> this patch per se it does make iowait boosting more aggressive. ((Doubling limited by rate_limit_us)
>> Since the boost is often applied when not useful (for Android e.g. periodic f2fs writebacks),
>> this might have some side effects. Please give me a couple of days for verifying any impact,
>> or did you do that already?
> 
> I don't understand the concern, could you elaborate more please?
> 
> Products already ship with 500us and 1ms which is lower than this 2ms.
> 
> On my AMD desktop it is already 1ms. And I think I've seen Intel systems
> defaulting to 500us or something low too. Ideally cpufreq drivers should set
> policy->transition_delay_us; so this path is taken if the driver didn't
> populate that. Which seems to be more common than I'd like tbh.

I'm not disagreeing with you on that part. I'm just worried about the side
effects w.r.t iowait boosting.

> 
> I never run with 10ms. It's too slow. But I had several tests in the past
> against 2ms posted for those margin and removal of uclamp-max aggregation
> series. Anyway. I ran PCMark storage on Pixel 6 (running mainlinish kernel) and
> I see
> 
> 10ms: 27600
> 2ms: 29750

Yes, decreasing the rate limit makes it more aggressive, nothing unexpected here.
But let's be frank, the scenarios in which iowait boosting actually shows its
biggest benefit you are either doing:
- Random Read (small iosize), single-threaded, synchronous IO
- anything O_DIRECT
and I'd argue more than likely you are doing something wrong if you're actually in
such a case in the real world. So I'm much more worried about boosting in scenarios
where it doesn't help (e.g. on an Android quite frequently: f2fs page cache writeback).

Decreasing the default transition latency makes (sugov) iowait boosting much more aggressive,
so I'm curious if this patch increases power consumption on systems that were at 10ms previously
when in non-IO workloads.

Hope that clears that up. Again, not an argument against your change, just being cautious of
the potential side effects and if they need some mitigations.

Kind Regards,
Christian

