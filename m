Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A5757936
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGRKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGRKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:23:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E171C1A8;
        Tue, 18 Jul 2023 03:23:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B632F4;
        Tue, 18 Jul 2023 03:23:53 -0700 (PDT)
Received: from [10.57.28.217] (unknown [10.57.28.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A276F3F67D;
        Tue, 18 Jul 2023 03:23:07 -0700 (PDT)
Message-ID: <2bfa9dda-410f-5c8a-bff4-54a5ea308a93@arm.com>
Date:   Tue, 18 Jul 2023 11:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <aa4a22b8-fc23-8c67-bdea-b6aac8f7e250@arm.com>
 <20230717182106.g6j3jpsjp35psl5y@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230717182106.g6j3jpsjp35psl5y@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 19:21, Qais Yousef wrote:
> +CC Vincent and Peter
> 
> On 07/17/23 14:47, Lukasz Luba wrote:
>> Hi Qais,
>>
>> The rule is 'one size doesn't fit all', please see below.
>>
>> On 7/11/23 18:58, Qais Yousef wrote:
>>> Hi Kajetan
>>>
>>> On 01/05/23 14:51, Kajetan Puchalski wrote:
>>>
>>> [...]
>>>
>>>> @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>>>>    			     struct cpuidle_device *dev)
>>>>    {
>>>>    	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>>>> +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>>>>    	int i;
>>>>    	memset(cpu_data, 0, sizeof(*cpu_data));
>>>> +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
>>>
>>> Given that utilization is invariant, why do we set the threshold based on
>>> cpu capacity?
>>
>>
>> To treat CPUs differently, not with the same policy.
>>
>>
>>>
>>> I'm not sure if this is a problem, but on little cores this threshold would be
>>> too low. Given that util is invariant - I wondered if we need to have a single
>>> threshold for all type of CPUs instead. Have you tried something like that
>>
>> A single threshold for all CPUs might be biased towards some CPUs. Let's
>> pick the value 15 - which was tested to work really good in benchmarks
>> for the big CPUs. On the other hand when you set that value to little
>> CPUs, with max_capacity = 124, than you have 15/124 ~= 13% threshold.
>> That means you prefer to enter deeper idle state ~9x times (at max
>> freq). What if the Little's freq is set to e.g. < ~20% fmax, which
>> corresponds to capacity < ~25? Let's try to simulate such scenario.
> 
> Hmm what I'm struggling with is that PELT is invariant. So the time it takes to
> rise and decay to threshold of 15 should be the same for all CPUs, no?

Yes, but that's not an issue. The idea is to have a threshold value
set to a level which corresponds to a long enough slip time (in
wall-clock). Then you don't waste the energy for turning on/off the
core too often.

> 
>>
>> In a situation we could have utilization 14 on Little CPU, than CPU capacity
>> (effectively frequency) voting based on utilization would be
>> 1.2 * 14 = ~17 so let's pick OPP corresponding to 17 capacity.
>> In such condition the little CPU would run the 14-util-periodic-task for
>> 14/17= ~82% of wall-clock time. That's a lot, and not suited for
>> entering deeper idle state on that CPU, isn't it?
> 
> Yes runtime is stretched. But we counter this at utilization level by making
> PELT invariant. I thought that any CPU in the system will now take the same
> amount of time to ramp-up and decay to the same util level. No?

The stretched runtime is what we want to derived out of rq util
information, mostly after task migration to some next cpu.

> 
> But maybe what you're saying is that we don't need to take the invariance into
> account?

Invariance is OK, since is the common ground when we migrate those tasks
across cores and we still can conclude based on util the sleeping
cpu time.

> 
> My concern (that is not backed by real problem yet) is that the threshold is
> near 0, and since PELT is invariant, the time to gain few points is constant
> irrespective of any CPU/capacity/freq and this means the little CPUs has to be
> absolutely idle with no activity almost at all, IIUC.

As I said, that is good for those Little CPU in term of better latency
for the tasks they serve and also doesn't harm the energy. The
deeper idle state for those tiny silicon area cores (and low-power
cells) doesn't bring much in avg for real workloads.
This is the trade-off: you don't want to sacrifice the latency factor,
you would rather pay a bit more energy not entering deep idle
on Little cores, but get better latency there.
For the big cores, which occupy bigger silicon area and are made from
High-Performance (HP) cells (and low V-threshold) leaking more, that
trade-off is set differently. That's why a similar small util task on
big core might be facing larger latency do to facing the need to
wake-up cpu from deeper idle state.

> 
>>
>> Apart from that, the little CPUs are tiny in terms of silicon area
>> and are less leaky in WFI than big cores. Therefore, they don't need
>> aggressive entries into deeper idle state. At the same time, they
>> are often used for serving interrupts, where the latency is important
>> factor.
> 
> On Pixel 6 this threshold will translate to util_threshold of 2. Which looks
> too low to me. Can't TEO do a good job before we reach such extremely low level
> of inactivity?

Kajetan has introduced a new trace event 'cpu_idle_miss' which was
helping us to say how to set the trade-off in different thresholds.
It appeared that we would rather prefer to miss-predict and be wrong
about missing opportunity to enter deeper idle. The opposite was more
harmful. You can enable that trace event on your platform and analyze
your use cases.

Regards,
Lukasz
