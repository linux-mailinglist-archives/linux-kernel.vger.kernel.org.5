Return-Path: <linux-kernel+bounces-103123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A1587BB50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE07DB22282
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEC37155;
	Thu, 14 Mar 2024 10:32:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33E433AD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412369; cv=none; b=TPsDUO0Mk+tUINccbSUxQ+Dk7SYpbUpc6ax9zEyFRpyEfgDNpj1kW9K0H4XXYyg1wLmQ6D5rc7VxcgXxJ51tA8BwOMnno8turgXFjSIs2IH3JWZxNFsGswvTYcXwhVPdzta9CqWBCpL5epGj0IaMCK6W/1qsCfNd89sSH70U+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412369; c=relaxed/simple;
	bh=T3CRS2D6IyxZhJqi3IevJf7S4LZx3430x8yV1L90zQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkpazqUBqiXk8dwCNnglJQyzZ9Ls8ZhEYW/4of4XfNfI7KQJKgNgkHxwY8imFPXGwQuBXVTZCyTuHlFSnhbtcWOWQf8P0yvwqYzc0LjWHGi3y2zHHB74bogsv5bKbY+9r2ubmZ/2/1sA6AHw6dstvi2Ps/pnejMGdhVFJ6C6Jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97036DA7;
	Thu, 14 Mar 2024 03:33:21 -0700 (PDT)
Received: from [10.57.10.233] (unknown [10.57.10.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6A053F73F;
	Thu, 14 Mar 2024 03:32:40 -0700 (PDT)
Message-ID: <672228a5-5b5b-4c32-9fd9-4e1b59c08dd2@arm.com>
Date: Thu, 14 Mar 2024 11:32:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
Content-Language: en-US
To: Ze Gao <zegao2021@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Mel Gorman <mgorman@suse.de>, Juri Lelli <juri.lelli@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ben Segall <bsegall@google.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ze Gao <zegao@tencent.com>
References: <20240313085817.48892-1-zegao@tencent.com>
 <d43ed111-085b-432b-ad5b-433d5031fad1@arm.com>
 <CAD8CoPAC0ti2=mAbP5GMN6ZidZnPV-Antf7KrjwPtEnE7gYOdg@mail.gmail.com>
 <CAD8CoPCAU0OnE9R-usnyggRO5BZe3ey5=JOK8Waf3pvs7uQTtQ@mail.gmail.com>
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAD8CoPCAU0OnE9R-usnyggRO5BZe3ey5=JOK8Waf3pvs7uQTtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/14/24 04:49, Ze Gao wrote:
> On Thu, Mar 14, 2024 at 10:59 AM Ze Gao <zegao2021@gmail.com> wrote:
>>
>> On Wed, Mar 13, 2024 at 11:16 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>
>>> Hello Ze,
>>>
>>> I am running stress-ng with the following command:
>>>     stress-ng -c 1 -l 10 &
>>> and migrating the process with:
>>>     taskset -pc [cpus] [pid]
>>>
>>> The thread seems to be migrated via:
>>> sched_setaffinity
>>>     \-__sched_setaffinity()
>>>       \-__set_cpus_allowed_ptr()
>>>         \-__set_cpus_allowed_ptr_locked()
>>>           \- [1]
>>
>>
>>
>>> [1]
>>> /*
>>>    * Picking a ~random cpu helps in cases where we are changing affinity
>>>    * for groups of tasks (ie. cpuset), so that load balancing is not
>>>    * immediately required to distribute the tasks within their new mask.
>>>    */
>>> dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
>>>
>>> So it seems the destination CPU chosen among the new CPU affinity mask is done
>>> here, by picking a random CPU in the mask.
>>
>> IIUC, this is for running/queued/waking tasks instead of blocked tasks.
>>
>> Am I missing something obvious here?

Not at all, I just didn't tested the patch on a blocked task as you said.

>>
>>> Checking the cpus_ptr in select_idle_sibling() might be useful in other cases,
>>> but I think the experiment doesn't show that. Maybe a another small tweak could
>>
>> The experiment is used to illustrate that the status quo does not do well
>> but has to rely on select_fallback_rq() to choose a cpu for a woken task
>> which turns out to be a bad choice since it's already monopolized by a
>> cpu bound task, that is why a second migration happens with the help
>> of the load balancer.
> 
> Btw, perf alone does not show obvious results here, you need some
> other observability tools to make sure the migration is not initiated by
> __set_cpus_allowed_ptr_locked (i.e., for running tasks). I achieve this
> by directly adding some tracepoints to both select_fallback_rq() and
> select_idle_sibling().

FWIW, I could effectively reproduce the issue described in the commit message, so:
Tested-by: Pierre Gondois <pierre.gondois@arm.com>

Regards,
Pierre

> 
> Regards,
>          -- Ze
> 
>> Actually, we can reuse the same reasons for doing so as in
>>
>>      commit 46a87b3851f0("sched/core: Distribute tasks within affinity masks")
>>
>>> be done at [1] instead ?
>>
>> As for blocked tasks, check out what is commented on set_task_cpu() and
>> select_task_rq(), since we never call set_task_cpu() on blocked tasks which
>> in turn, we have no way to change p->wake_cpu to dest_cpu being randomly
>> chosen here, so when it's woken up, it still needs to go through the
>> select_task_rq() process using the outdated p->wake_cpu.
>>
>>
>> Thanks,
>>          -- Ze
>>
>>> Regards,
>>> Pierre
>>>
>>> On 3/13/24 09:58, Ze Gao wrote:
>>>> We observered select_idle_sibling() is likely to return the *target* cpu
>>>> early which is likely to be the previous cpu this task is running on even
>>>> when it's actually not within the affinity list newly set, from where after
>>>> we can only rely on select_fallback_rq() to choose one for us at its will
>>>> (the first valid mostly for now).
>>>>
>>>> However, the one chosen by select_fallback_rq() is highly likely not a
>>>> good enough candidate, sometimes it has to rely on load balancer to kick
>>>> in to place itself to a better cpu, which adds one or more unnecessary
>>>> migrations in no doubt. For example, this is what I get when I move task
>>>> 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
>>>>
>>>>           swapper       0 [013]   959.791829: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=13 dest_cpu=23
>>>> kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=23 dest_cpu=24
>>>>
>>>> The thing is we can actually do better if we do checks early and take more
>>>> advantages of the *target* in select_idle_sibling(). That is, we continue
>>>> the idle cpu selection if *target* fails the test of cpumask_test_cpu(
>>>> *target*, p->cpus_ptr). By doing so, we are likely to pick a good candidate,
>>>> especially when the newly allowed cpu set shares some cpu resources with
>>>> *target*.
>>>>
>>>> And with this change, we clearly see the improvement when I move task 3964
>>>> to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
>>>>
>>>>           swapper       0 [027]  4249.204658: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=27 dest_cpu=26
>>>>
>>>> Note we do the same check for *prev* in select_idle_sibling() as well.
>>>>
>>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>>> ---
>>>>    kernel/sched/fair.c | 13 ++++++++-----
>>>>    1 file changed, 8 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 533547e3c90a..9ef6e74c6b2a 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7511,16 +7511,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>>         */
>>>>        lockdep_assert_irqs_disabled();
>>>>
>>>> -     if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>>>> -         asym_fits_cpu(task_util, util_min, util_max, target))
>>>> +     if (cpumask_test_cpu(target, p->cpus_ptr) &&
>>>> +             (available_idle_cpu(target) || sched_idle_cpu(target)) &&
>>>> +             asym_fits_cpu(task_util, util_min, util_max, target))
>>>>                return target;
>>>>
>>>>        /*
>>>>         * If the previous CPU is cache affine and idle, don't be stupid:
>>>>         */
>>>> -     if (prev != target && cpus_share_cache(prev, target) &&
>>>> -         (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>>>> -         asym_fits_cpu(task_util, util_min, util_max, prev)) {
>>>> +     if (cpumask_test_cpu(prev, p->cpus_ptr) &&
>>>> +             prev != target &&
>>>> +             cpus_share_cache(prev, target) &&
>>>> +             (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>>>> +             asym_fits_cpu(task_util, util_min, util_max, prev)) {
>>>>
>>>>                if (!static_branch_unlikely(&sched_cluster_active) ||
>>>>                    cpus_share_resources(prev, target))

