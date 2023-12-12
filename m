Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73480ECD7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376526AbjLLNJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376504AbjLLNJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:09:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E06EA8;
        Tue, 12 Dec 2023 05:09:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A9F3143D;
        Tue, 12 Dec 2023 05:09:56 -0800 (PST)
Received: from [10.1.29.53] (e133047.arm.com [10.1.29.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B277D3F762;
        Tue, 12 Dec 2023 05:09:06 -0800 (PST)
Message-ID: <63cf5c75-6bd3-41c9-ac5e-518750874f8e@arm.com>
Date:   Tue, 12 Dec 2023 13:09:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <739492e4-b9a3-4c55-82e6-60b02d489c5f@arm.com>
 <20231212123401.xmggng7dtxvdxqj6@airbuntu>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231212123401.xmggng7dtxvdxqj6@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 12:34, Qais Yousef wrote:
> On 12/11/23 18:47, Christian Loehle wrote:
>> On 08/12/2023 01:52, Qais Yousef wrote:
>>> Due to the way code is structured, it makes a lot of sense to trigger
>>> cpufreq_update_util() from update_load_avg(). But this is too aggressive
>>> as in most cases we are iterating through entities in a loop to
>>> update_load_avg() in the hierarchy. So we end up sending too many
>>> request in an loop as we're updating the hierarchy.
>>
>> If this is actually less aggressive heavily depends on the workload,
>> I can argue the patch is more aggressive, as you call cpufreq_update_util
>> at every enqueue and dequeue, instead of just at enqueue.
>> For an I/O workload it is definitely more aggressive, see below.
> 
> I could have unwittingly broken something. Thanks for the report!
> 
> [SNIP]
>>>  dequeue_throttle:
>>>  	util_est_update(&rq->cfs, p, task_sleep);
>>> +	cpufreq_update_util(rq, 0);
>>
>> This is quite critical, instead of only calling the update
>> at enqueue (with SCHED_CPUFREQ_IOWAIT if applicable) it is
>> now called at every enqueue and dequeue. The only way for
> 
> I think it was called at enqueue/dequeue before, but now it is done
> unconditionally as I don't check for decay like before. It shouldn't change the
> behavior as if there's no frequency change, then the governor will do nothing

Well the governor will update the fields by calling sugov_iowait_apply
What exactly are you referring to when you say
"I think it was called at dequeue before"?
From what I can see this patch calls cpufreq_update_util much more
on an enqueue/dequeue workload like fio.

> including not update last_update_time IIRC.

sched_avg maybe, but iowait boosts last_update is changed,
I'll look into it, see below.

> 
>> schedutil (intel_pstate too?) to build up a value of
>> iowait_boost > 128 is a large enough rate_limit_us, as even
>> for just a in_iowait task the enqueue increases the boost and
>> its own dequeue could reduce it already. For just a basic
>> benchmark workload and 2000 rate_limit_us this doesn't seem
>> to be that critical, anything below 200 rate_limit_us didn't
> 
> 200us is too low. Does rk3399 support this? My pine64 has this SoC and
> I remember it doesn't support fastswitch and the time to wake up the sugov
> thread will be comparable to this before even trying to talk tot he hardware.

Unlikely it is actually supported, but I'm mostly concerned with the
actual iowait_boost value, so this limitation here actually is besides
my point. (The fact that tip:sched/core results are very different at 200us
from this patch gives me some confidence here.)

> 
> Not necessarily means that I don't have a bug in my code of course! :)
> 
>> show any iowait boosting > 128 anymore on my system.
>> Of course if the workload does more between enqueue and
>> dequeue (time until task issues next I/O) already larger
>> values of rate_limit_us will disable any significant
>> iowait boost benefit.
> 
> Hmm. It seems sugov_iowait_reset() is being called at the dequeue?

Also yes, but I'm actually worried about the reduce / halving in
iowait_boost_apply().
With a one-to-one correspondence of enqueue (inc boost if in_iowait) and
dequeue (dec boost regardless) with cpufreq_update_util() you would expect
there to never be any boost apart from the minimal between the enqueue and
the dequeue. It does build up anyway, but that is only because the reduce
in iowait_boost_apply() is never hit if the last update time delta is < rate_limit_us.
(and rate_limit_us=2000 gives us still some headroom for read->read userspace
workloads, for read->think->read this could be more problematic, see also below.)

(Now thinking about it the fact that last_update before determining if frequency
should be changed, could be an issue, I'll look into it some more, anyway at worst
it's an issue with larger impact with your patch.)

> 
> Tweaking the rate limit means short living tasks freq update at dequeue is
> likely to be ignored by the governor.
> 
> The short value means it is likely to be taken into account.
> 
> Not sure if this is uncovering a bug somewhere else or I broke something> 
>>
>> Just to add some numbers to the story:
>> fio --time_based --name=fiotest --filename=/dev/nvme0n1 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1
>> fio --time_based --name=fiotest --filename=/dev/mmcblk2 --runtime=30 --rw=randread --bs=4k --ioengine=psync --iodepth=1
>>
>> All results are sorted:
>> With this patch and rate_limit_us=2000:
>> (Second line is without iowait boosting, results are sorted):
>> [3883, 3980, 3997, 4018, 4019]
>> [2732, 2745, 2782, 2837, 2841]
>> /dev/mmcblk2
>> [4136, 4144, 4198, 4275, 4329]
>> [2753, 2975, 2975, 2975, 2976]
>>
>> Without this patch and rate_limit_us=2000:
>> [3918, 4021, 4043, 4081, 4085]
>> [2850, 2859, 2863, 2873, 2887]
>> /dev/mmcblk2
>> [4277, 4358, 4380, 4421, 4425]
>> [2796, 3103, 3128, 3180, 3200]
>>
>> With this patch and rate_limit_us=200:
>> /dev/nvme0n1
>> [2470, 2480, 2481, 2484, 2520]
>> [2473, 2510, 2517, 2534, 2572]
>> /dev/mmcblk2
>> [2286, 2338, 2440, 2504, 2535]
>> [2360, 2462, 2484, 2503, 2707]
>>
>> Without this patch and rate_limit_us=200:
>> /dev/nvme0n1
>> [3880, 3956, 4010, 4013, 4016]
>> [2732, 2867, 2937, 2937, 2939]
>> /dev/mmcblk2
>> [4783, 4791, 4821, 4855, 4860]
>> [2653, 3091, 3095, 3166, 3202]
> 
> Was any other patch in this series or remove margin series applied or just this
> one?

These specific numbers were just with this one.
I did a couple of tests to get a feel for the entire series(both),
but found no drastic change that would be uncovered by n=3 runs
anyway.

>>
>> I'm currently working on iowait boosting and seeing where it's
>> actually needed and how it could be improved, so always interested
>> in anyone's thoughts.
> 
> One of the problems identified with iowait boost is that it is per-cpu; which
> means tasks that are causing the iowait to happen will lose this boost when
> migrated.
> 
> Arm was working on a way to help convert it to per-task. See Lukasz email.

I guess that would be me now :)
Apart from considering per-task I'd like to get a reasonable scope for the
feature designed anyway.
Like in your patch, assuming rate_limit_us=2000, on my platform and scenarios
the context-switches + the minimum stuff fio does until between read syscalls
took around 200us (that's where the boost benefit disappears).
If we're considering workloads that do just a little more in-between than what
fio does (maybe actually looking at the data?) and therefore takes maybe >2000us
in-between, you disabled iowait boost for that workload with this patch.
My view right now is that this might not be critical, any attempts at recreating
such workloads (realistically) lead basically to them contributing enough util to
not need the iowait boost, but of course you can also create synthetic workloads
where this is not true.
If you want to play around with this too, I have recently added --thinkcycles
parameter to fio, you will have to build it from source though as it hasn't seen
a release since.

> 
>>
>> (The second line here doesn't provide additional
>> information, I left it in to compare for reproducibility).
>> All with CONFIG_HZ=100 on an rk3399.
> 
> Your tick is 10ms?! sugov_iowait_reset() should return false then. I see now,
> we undo the boost in sugov_iowait_apply().

Again, just to emphasize, the disabling of iowait boost then does not come from
sugov_iowait_reset, but sugov_iowait_apply, which will be called in dequeue regardless
in your patch, plus you're lowering the rate_limit_us, which right now acts as
a 'iowait boost protection' for your patch, if that makes sense.

Best Regards,
Christian

