Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373717E6FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjKIQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjKIQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:50:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3700F1725
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:50:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D09C106F;
        Thu,  9 Nov 2023 08:51:33 -0800 (PST)
Received: from [10.1.31.52] (e133649.arm.com [10.1.31.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC00E3F7C5;
        Thu,  9 Nov 2023 08:50:46 -0800 (PST)
Message-ID: <531fd8a0-132e-425b-955b-d60a56004aba@arm.com>
Date:   Thu, 9 Nov 2023 16:50:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] sched/uclamp: Simulate PELT decay in
 util_avg_uclamp
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <d73fc3e9a02f047902fdd5e4c07402452d6e0590.1696345700.git.Hongyan.Xia2@arm.com>
 <b09848dc-dea8-46e7-9f24-c11c64fd5d74@arm.com>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <b09848dc-dea8-46e7-9f24-c11c64fd5d74@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2023 16:06, Dietmar Eggemann wrote:
> On 04/10/2023 11:04, Hongyan Xia wrote:
>> From: Hongyan Xia <hongyan.xia2@arm.com>
>>
>> Because util_avg_uclamp is not directly managed by PELT, it lacks the
>> nice property of slowly decaying to a lower value, resulting in
>> performance degredation due to premature frequency drops.
>>
>> Add functions to decay root cfs utilization and tasks that are not on
>> the rq. This way, we get the benefits of PELT while still maintaining
>> uclamp. The rules are simple:
>>
>> 1. When task is se->on_rq, enforce its util_avg_uclamp within uclamp
>>     range.
>> 2. When task is !se->on_rq, PELT decay its util_avg_uclamp.
>> 3. When the root CFS util drops, PELT decay to the target frequency
>>     instead of immediately dropping to a lower target frequency.
>>
>> TODO: Can we somehow integrate this uclamp sum aggregation directly into
>> util_avg, so that we don't need to introduce a new util_avg_uclamp
>> signal and don't need to simulate PELT decay?
> 
> That's a good question. I'm wondering why you were not able to integrate
> the maintenance of the util_avg_uclamp values inside the existing PELT
> update functionality in fair.c ((__update_load_avg_xxx(),
> propagate_entity_load_avg() -> update_tg_cfs_util() etc.)
> 
> Why do you need extra functions like ___decay_util_avg_uclamp_towards()
> and ___update_util_avg_uclamp() for this?

These new functions are already in __update_load_avg_xxx(). I just 
separate the new code into a separate function for readability.

I think we have talked offline on why we can't do things in 
propagate_entity_load_avg() -> update_tg_cfs_util(). Currently cfs_rq 
and se utilization is tracked independently. However, we can't track 
them separately in sum aggregation. If a cfs_rq has two tasks with 
utilization at 1024 and UCLAMP_MAX of 100, the cfs_rq must sum up those 
two tasks, at 200, and cannot use the logic inside 
propagate_entity_load_avg() -> update_tg_cfs_util() which is for 
tracking cfs_rq independently and won't know the utilization is only 200.

Again I may have misunderstood what you meant. Do you have a concrete 
example on how to do this without extra functions?

One idea I once had is to use the existing util_avg, and introduce a 
'util_bias' variable. When there's no uclamp, this bias is 0 and 
util_avg is what it is. When there's uclamp, for example, two tasks at 
utilization of 400 but UCLAMP_MAX of 300, then each task has a util_bias 
of -100, and cfs_rq will sum up the biases, at -200. Then, the cfs_rq 
will run at 600 instead of 800. This way, no PELT simulation is needed. 
However, this doesn't work, because say two tasks with utilization of 
1024 but UCLAMP_MAX at 100, each will have a bias of -924 and cfs_rq 
will sum up and have a bias of -1848, but the cfs_rq will be at 1024, 
not 2048, so adding this bias will give you cfs_rq utilization of -824, 
which is clearly wrong here.

>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> ---
>>   kernel/sched/fair.c  |  20 +++++++++
>>   kernel/sched/pelt.c  | 103 ++++++++++++++++++++++++++++++++++++++++---
>>   kernel/sched/sched.h |   2 +
>>   3 files changed, 119 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 33e5a6e751c0..420af57d01ee 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4311,17 +4311,22 @@ static inline int
>>   update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>>   {
>>   	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
>> +	unsigned int removed_root_util = 0;
> 
>   unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
> -unsigned int removed_root_util = 0;
> +unsigned int __maybe_unused removed_root_util = 0;
> 
> Otherwise you get `warning: unused variable ‘rq’` w/ !CONFIG_UCLAMP_TASK

Thanks. Ack.
> 
> [...]
> 
> 
>>   #ifdef CONFIG_UCLAMP_TASK
>> +static void ___decay_util_avg_uclamp_towards(u64 now,
>> +					     u64 last_update_time,
>> +					     u32 period_contrib,
>> +					     unsigned int *old,
>> +					     unsigned int new_val)
>> +{
>> +	unsigned int old_val = READ_ONCE(*old);
>> +	u64 delta, periods;
>> +
>> +	if (old_val <= new_val) {
>> +		WRITE_ONCE(*old, new_val);
>> +		return;
>> +	}
> 
> Why is the function called `decay`? In case `new >= old` you set old =
> new and bail out. So it's also more like an `update` function?

Bad naming indeed. I will rename it to ___update_util_avg_uclamp_towards

>> +	if (!last_update_time)
>> +		return;
>> +	delta = now - last_update_time;
>> +	if ((s64)delta < 0)
>> +		return;
>> +	delta >>= 10;
>> +	if (!delta)
>> +		return;
>> +
>> +	delta += period_contrib;
>> +	periods = delta / 1024;
>> +	if (periods) {
>> +		u64 diff = old_val - new_val;
>> +
>> +		/*
>> +		 * Let's assume 3 tasks, A, B and C. A is still on rq but B and
>> +		 * C have just been dequeued. The cfs.avg.util_avg_uclamp has
>> +		 * become A but root_cfs_util_uclamp just starts to decay and is
>> +		 * now still A + B + C.
>> +		 *
>> +		 * After p periods with y being the decay factor, the new
>> +		 * root_cfs_util_uclamp should become
>> +		 *
>> +		 * A + B * y^p + C * y^p == A + (A + B + C - A) * y^p
>> +		 *     == cfs.avg.util_avg_uclamp +
>> +		 *        (root_cfs_util_uclamp_at_the_start - cfs.avg.util_avg_uclamp) * y^p
>> +		 *     == cfs.avg.util_avg_uclamp + diff * y^p
>> +		 *
>> +		 * So, instead of summing up each individual decayed values, we
>> +		 * could just decay the diff and not bother with the summation
>> +		 * at all. This is why we decay the diff here.
>> +		 */
>> +		diff = decay_load(diff, periods);
>> +		WRITE_ONCE(*old, new_val + diff);
>> +	}
>> +}
> 
> Looks like ___decay_util_avg_uclamp_towards() is used for:
> 
> (1) tasks with !se->on_rq to decay before enqueue
> 
> (2) rq->root_cfs_util_uclamp to align with
>      &rq_of(cfs_rq)->cfs->avg.util_avg_uclamp
> 
> All the cfs_rq's and the taskgroup se's seem to be updated only in
> ___update_util_avg_uclamp() (which also handles the propagation towards
> the root taskgroup).

Yes, I would say that's a nice summary.

When !se->on_rq, we never use ___update_util_avg_uclamp() but instead do 
___update_util_avg_uclamp_towards().

> 
> [...]
