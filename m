Return-Path: <linux-kernel+bounces-73459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353A85C2D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F892834CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769477622;
	Tue, 20 Feb 2024 17:38:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D277A03;
	Tue, 20 Feb 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450716; cv=none; b=LRdBB3oxPFKymVtJhRdXwC3FUkZX8a/TcHKIjkd4dGaNlDdNKmZlsvrmzzCZ51VfFtrn7YzbmG/+3aAF5u5mMhb/S8A3TMGkeiUQb9lp4x3eoZdyk5R8LYUKQ+IM5Q+KCFimDvkhNMSQmhytITVyFnq9nNHWg89U3ck2otd0+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450716; c=relaxed/simple;
	bh=xZ3HnLeclv51MasLwuxwdlS6padjnTivPFbYZkZRoak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2iTh7nLagykMZrcfu/StoeYsR9q2GYAuFxCO4GYMDFr641NzNvkGOQyUsvi18tgIlYwLLNiPfctIPCkcIH9eO2YWnJMj4v8dw+wmaWKTbKsVv0gyELdN6CwnE7L+r1PoVKvGhj2rZrgjeCKYulMjAMyXUZQ17eZRT9IpAu5ipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0150EFEC;
	Tue, 20 Feb 2024 09:39:11 -0800 (PST)
Received: from [10.57.50.34] (unknown [10.57.50.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F483F762;
	Tue, 20 Feb 2024 09:38:29 -0800 (PST)
Message-ID: <d58de550-0ce1-4af9-9e2d-dedd5e73c797@arm.com>
Date: Tue, 20 Feb 2024 18:38:24 +0100
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
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Christian.Loehle@arm.com
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
 <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
 <20240220135037.qriyapwrznz2wdni@airbuntu>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20240220135037.qriyapwrznz2wdni@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Qais,

I added some other remarks,

On 2/20/24 14:50, Qais Yousef wrote:
> On 02/14/24 10:19, Pierre Gondois wrote:
>> Hello,
>>
>> On 2/12/24 16:53, Rafael J. Wysocki wrote:
>>> On Mon, Feb 5, 2024 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>>
>>>> On 05-02-24, 02:25, Qais Yousef wrote:
>>>>> 10ms is too high for today's hardware, even low end ones. This default
>>>>> end up being used a lot on Arm machines at least. Pine64, mac mini and
>>>>> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
>>>>> it's too high for all of them.
>>>>>
>>>>> Change the default to 2ms which should be 'pessimistic' enough for worst
>>>>> case scenario, but not too high for platforms with fast DVFS hardware.
>>>>>
>>>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>>>>> ---
>>>>>    drivers/cpufreq/cpufreq.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>>> index 44db4f59c4cc..8207f7294cb6 100644
>>>>> --- a/drivers/cpufreq/cpufreq.c
>>>>> +++ b/drivers/cpufreq/cpufreq.c
>>>>> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>>>>>                  * for platforms where transition_latency is in milliseconds, it
>>>>>                  * ends up giving unrealistic values.
>>>>>                  *
>>>>> -              * Cap the default transition delay to 10 ms, which seems to be
>>>>> +              * Cap the default transition delay to 2 ms, which seems to be
>>>>>                  * a reasonable amount of time after which we should reevaluate
>>>>>                  * the frequency.
>>>>>                  */
>>>>> -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
>>>>> +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
>>>>
>>>> Please add spaces around '*'.
>>>>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> I've adjusted the whitespace as suggested above and applied the patch
>>> as 5.9 material.
>>>
>>> Thanks!
>>>
>>
>> To add some numbers, on a Juno-r2, with latency measured between the frequency
>> request on the kernel side and the SCP actually making the frequency update.
>>
>> The SCP is the firmware responsible of making the frequency updates. It receives
>> the kernel requests and coordinate them/make the actual changes. The SCP also has
>> a mechanism called 'fast channel' (FC) where the kernel writes the requested
>> frequency to a memory area shared with the SCP. Every 4ms, the SCP polls/reads
>> these memory area and make the required modifications.
>>
>> Latency values (in ms)
>> Workload:
>> Idle system, during ~30s
>> +---------------------------------------+
>> |       |   Without FC  |      With FC  |
>> +-------+---------------+---------------+
>> | count |       1663    |        1102   |
>> | mean  |          2.92 |          2.10 |
>> | std   |          1.90 |          1.58 |
>> | min   |          0.21 |          0.00 |
>> | 25%   |          1.64 |          0.91 |
>> | 50%   |          2.57 |          1.68 |
>> | 75%   |          3.66 |          2.97 |
>> | max   |         14.37 |         13.50 |
>> +-------+---------------+---------------+
>>
>> Latency values (in ms)
>> Workload:
>> One 1% task per CPU, period = 32ms. This allows to wake up the CPU
>> every 32ms and send more requests/give more work to the SCP. Indeed
>> the SCP is also responsible of idle state transitions.
>> Test duration ~=30s.
>> +---------------------------------------+
>> |       |   Without FC  |      With FC  |
>> +-------+---------------+---------------+
>> | count |       1629    |       1446    |
>> | mean  |          3.23 |          2.31 |
>> | std   |          2.40 |          1.73 |
>> | min   |          0.05 |          0.02 |
>> | 25%   |          1.91 |          0.98 |
>> | 50%   |          2.65 |          2.00 |
>> | 75%   |          3.65 |          3.23 |
>> | max   |         20.56 |         16.73 |
>> +-------+---------------+---------------+
>>
>> ---

1.
With this patch, platforms like the Juno which:
- don't set a `transition_delay_us`
- have a high `transition_latency` (> 1ms)
can request freq. changes every 2ms.

If a platform has a `transition_latency` > 2ms, this means:
   `transition_latency` > `transition_delay_us`
I.e. a second freq. requests might be emitted before the first one
will be completed. On the Juno, this doesn't cause any 'real' issue
as the SCMI/mailbox mechanism works well, but this doesn't seem
correct.
If the util of CPUs is in between OPPs (i.e. freq. changes are often
required), the Juno:
- sends a freq. request
- waits for completion and schedules another task in the meantime
- upon completion, immediately sends a new freq.

I think that the following should be respected/checked:
- `transition_latency` < `transition_delay_us`
(it might also make sense to have, with K being any factor:)
- `transition_latency` * K < `transition_delay_us`


2.
There are references to the 10ms values at other places in the code:

include/linux/cpufreq.h
  * ondemand governor will work on any processor with transition latency <= 10ms,

drivers/cpufreq/cpufreq.c
  * For platforms that can change the frequency very fast (< 10
  * us), the above formula gives a decent transition delay. But
-> the 10us value matches 10ms = 10us * LATENCY_MULTIPLIER

Documentation/admin-guide/pm/cpufreq.rst
  Typically, it is set to values of the order of 10000 (10 ms).  Its
  default value is equal to the value of ``cpuinfo_transition_latency``


3.
There seems to be a dependency of the conservative/ondemand governors
over the the value returned by `cpufreq_policy_transition_delay_us()`:

drivers/cpufreq/cpufreq_governor.c
   dbs_data->sampling_rate = max_t(unsigned int,
     CPUFREQ_DBS_MIN_SAMPLING_INTERVAL,            // = 2 * tick period = 8ms
     cpufreq_policy_transition_delay_us(policy));  // [1]: val <= 2ms

[1]
if `transition_latency` is not set and `transition_delay_us` is,
which is the case for the Juno.

The `sampling_rate` is, FYIU, the period used to evaluate the ratio
of the idle/busy time, and if necessary increase/decrease the freq.

This patch will likely reduce this sampling rate from 10ms -> 8ms
(if `cpufreq_policy_transition_delay_us()`` now returns 2ms for some
platforms). This is not much, but just wanted to note it.

Regards,
Pierre


>>
>> The latency increases when fast channels are not used and when there is an actual
>> workload. On average it is always > 2ms. Juno's release date seems to be 2014,
>> so the platform is quite old, but it should also have benefited from regular
>> firmware updates.
> 
> Thanks for sharing the numbers
> 
>>
>> Regards,
>> Pierre

