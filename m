Return-Path: <linux-kernel+bounces-64941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7A58544EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC381C213BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415F12B99;
	Wed, 14 Feb 2024 09:19:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008612E76;
	Wed, 14 Feb 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902363; cv=none; b=DGrZcYeyXbAcJhIA6mAu27itqnbsHsofvWbVmMyzYZ8PB13PW+vK4V9MPfOHi4RrqiwwGOrh33unigEoVVY+phG61odpnknuX0KhB4pCQDUaPyt8okN3T4rhQb/NeqfQ6l341/YYKfS4NP+uzjhQuULm2ypI8OP9DQyCZIgzUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902363; c=relaxed/simple;
	bh=UkF3ey4nPdx8aIfzXOOtwbJzkTliSGUzFVsQmxy/7x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCge/xlSa4TkVjXNYCwMCHzJZPDBjFSEf8akzF9Nb7fX3J0ufJ62YUNTPOaGZuxSInKYTsb6IqL7aOyeyXs9ZPxbQf9bkjTbZ3qSIhqkVkAJ/gtJKVx2oAystPs4svKoexTct71OqkoL3rKVXmXDTP7ySytkk15tWCrIj+avV5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE421FB;
	Wed, 14 Feb 2024 01:20:00 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8DD3F766;
	Wed, 14 Feb 2024 01:19:17 -0800 (PST)
Message-ID: <ca000b2d-b552-43cb-8807-0a5f1450c6a2@arm.com>
Date: Wed, 14 Feb 2024 10:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Qais Yousef <qyousef@layalina.io>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Christian.Loehle@arm.com
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <20240205074514.kiolurpounokalum@vireshk-i7>
 <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 2/12/24 16:53, Rafael J. Wysocki wrote:
> On Mon, Feb 5, 2024 at 8:45 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 05-02-24, 02:25, Qais Yousef wrote:
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
>>>   drivers/cpufreq/cpufreq.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 44db4f59c4cc..8207f7294cb6 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
>>>                 * for platforms where transition_latency is in milliseconds, it
>>>                 * ends up giving unrealistic values.
>>>                 *
>>> -              * Cap the default transition delay to 10 ms, which seems to be
>>> +              * Cap the default transition delay to 2 ms, which seems to be
>>>                 * a reasonable amount of time after which we should reevaluate
>>>                 * the frequency.
>>>                 */
>>> -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
>>> +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
>>
>> Please add spaces around '*'.
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> I've adjusted the whitespace as suggested above and applied the patch
> as 5.9 material.
> 
> Thanks!
> 

To add some numbers, on a Juno-r2, with latency measured between the frequency
request on the kernel side and the SCP actually making the frequency update.

The SCP is the firmware responsible of making the frequency updates. It receives
the kernel requests and coordinate them/make the actual changes. The SCP also has
a mechanism called 'fast channel' (FC) where the kernel writes the requested
frequency to a memory area shared with the SCP. Every 4ms, the SCP polls/reads
these memory area and make the required modifications.

Latency values (in ms)
Workload:
Idle system, during ~30s
+---------------------------------------+
|       |   Without FC  |      With FC  |
+-------+---------------+---------------+
| count |       1663    |        1102   |
| mean  |          2.92 |          2.10 |
| std   |          1.90 |          1.58 |
| min   |          0.21 |          0.00 |
| 25%   |          1.64 |          0.91 |
| 50%   |          2.57 |          1.68 |
| 75%   |          3.66 |          2.97 |
| max   |         14.37 |         13.50 |
+-------+---------------+---------------+

Latency values (in ms)
Workload:
One 1% task per CPU, period = 32ms. This allows to wake up the CPU
every 32ms and send more requests/give more work to the SCP. Indeed
the SCP is also responsible of idle state transitions.
Test duration ~=30s.
+---------------------------------------+
|       |   Without FC  |      With FC  |
+-------+---------------+---------------+
| count |       1629    |       1446    |
| mean  |          3.23 |          2.31 |
| std   |          2.40 |          1.73 |
| min   |          0.05 |          0.02 |
| 25%   |          1.91 |          0.98 |
| 50%   |          2.65 |          2.00 |
| 75%   |          3.65 |          3.23 |
| max   |         20.56 |         16.73 |
+-------+---------------+---------------+

---

The latency increases when fast channels are not used and when there is an actual
workload. On average it is always > 2ms. Juno's release date seems to be 2014,
so the platform is quite old, but it should also have benefited from regular
firmware updates.

Regards,
Pierre

