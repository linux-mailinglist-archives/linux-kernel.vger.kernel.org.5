Return-Path: <linux-kernel+bounces-136967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F189DA69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614411F23E79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B37131194;
	Tue,  9 Apr 2024 13:33:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A60512F5BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669618; cv=none; b=jI5yWQlL+Y09L6DNXHD/lUc+fnYH6qYKiEdxIG1rGdFfsBr2lhONhqYmSISQqDFfHF2jnGDwaflqRkDPlg6A74QjWZHncllW081NCWUE/vWe5JwiIH4+Tx4yiDKAxgBpsfBZR4yMpM5Cq3Saqb5XXEaevTvocbMWcL235psWXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669618; c=relaxed/simple;
	bh=fwkzdKE+tW3BMjFP6EmSFT5s1nmcvcB5JeKygQXVYrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn7kGqH4j6BDB6U0cI7QldddEtbove3IdOE4zN4YXQqUhK8M/brKiF6CfZiJjzLi7hUOFZoVIGrnQ4kmm3O+nOVbezN0GVY7CC2aPf/upi1jdx+i6P7zUbD7xdbXt8YteP+uXSvE5U4qN3y1QvfhwB2Kiq1ARiB9Qj9UFbkBelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74DE139F;
	Tue,  9 Apr 2024 06:34:06 -0700 (PDT)
Received: from [10.34.100.110] (e126645.nice.arm.com [10.34.100.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A5763F766;
	Tue,  9 Apr 2024 06:33:33 -0700 (PDT)
Message-ID: <4c48e76b-80cb-4811-8be8-f8cfd5221a80@arm.com>
Date: Tue, 9 Apr 2024 15:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] sched/fair|isolation: Correctly clear
 nohz.[nr_cpus|idle_cpus_mask] for isolated CPUs
To: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>, Rui Zhang <rui.zhang@intel.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
 <98443f19-c653-493e-a2a9-e1d07b9d8468@redhat.com>
 <cecd7e83-b83c-416e-b59b-296f84e5c574@arm.com>
 <40c388eb-12c5-4136-ba21-6173e61c0e25@redhat.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <40c388eb-12c5-4136-ba21-6173e61c0e25@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/5/24 02:23, Waiman Long wrote:
> On 4/4/24 08:55, Pierre Gondois wrote:
>> Hello Waiman,
>> Thanks for the link, I didn't see the patchset previously.
>>
>> On 4/4/24 05:01, Waiman Long wrote:
>>> On 4/3/24 11:05, Pierre Gondois wrote:
>>>> Zhang Rui reported that find_new_ilb() was iterating over CPUs in
>>>> isolated cgroup partitions. This triggered spurious wakeups for
>>>> theses CPUs. [1]
>>>> The initial approach was to ignore CPUs on NULL sched domains, as
>>>> isolated CPUs have a NULL sched domain. However a CPU:
>>>> - with its tick disabled, so taken into account in
>>>>      nohz.[idle_cpus_mask|nr_cpus]
>>>> - which is placed in an isolated cgroup partition
>>>> will never update nohz.[idle_cpus_mask|nr_cpus] again.
>>>>
>>>> To avoid that, the following variables should be cleared
>>>> when a CPU is placed in an isolated cgroup partition:
>>>> - nohz.idle_cpus_mask
>>>> - nohz.nr_cpus
>>>> - rq->nohz_tick_stopped
>>>> This would allow to avoid considering wrong nohz.* values during
>>>> idle load balance.
>>>>
>>>> As suggested in [2] and to avoid calling
>>>> nohz_balance_[enter|exit]_idle()
>>>> from a remote CPU and create concurrency issues, leverage the existing
>>>> housekeeping HK_TYPE_SCHED mask to reflect isolated CPUs (i.e. on NULL
>>>> sched domains).
>>>> Indeed the HK_TYPE_SCHED mask is currently never set by the
>>>> isolcpus/nohz_full kernel parameters, so it defaults to
>>>> cpu_online_mask.
>>>> Plus it's current usage fits CPUs that are isolated and should
>>>> not take part in load balancing.
>>>>
>>>> Making use of HK_TYPE_SCHED for this purpose implies creating a
>>>> housekeeping mask which can be modified at runtime.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/
>>>> [2]
>>>> https://lore.kernel.org/all/CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com/
>>>>
>>>> Pierre Gondois (7):
>>>>      sched/isolation: Introduce housekeeping_runtime isolation
>>>>      sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
>>>>      sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
>>>>      sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
>>>>      sched/topology: Remove CPUs with NULL sd from HKR_TYPE_SCHED mask
>>>>      sched/fair: Remove on_null_domain() and redundant checks
>>>>      sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
>>>>
>>>>     include/linux/sched/isolation.h | 30 ++++++++++++++++++++-
>>>>     include/linux/sched/nohz.h      |  2 ++
>>>>     kernel/sched/fair.c             | 44 +++++++++++++++++-------------
>>>>     kernel/sched/isolation.c        | 48
>>>> ++++++++++++++++++++++++++++++++-
>>>>     kernel/sched/topology.c         |  7 +++++
>>>>     5 files changed, 110 insertions(+), 21 deletions(-)
>>>>
>>> I had also posted a patch series on excluding isolated CPUs in isolated
>>> partitions from housekeeping cpumasks earlier this year. See
>>>
>>> https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/
>>>
>>> It took a different approach from this series. It looks like I should
>>> include HK_TYPE_MISC as well.

Yes right, but as noted, if CONFIG_CPUSET is set without CPU_ISOLATION,
adding HK_TYPE_MISC to HOUSEKEEPING_FLAGS in your patchset would have no
effect right ?
The only check that would be always true is on_null_domain() from [1].

>>
>> The common point between the 2 patchset is that find_new_ilb() won't
>> take into account isolated CPUs.
>> The present patchset also:
>> - clears nohz.[idle_cpus_mask|nr_cpus] variable when a CPU becomes
>> isolated,
>>    cf. [PATCH 7/7] sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
>> - tries to clean up/gather on_null_domain()/HK_TYPE_SCHED/HK_TYPE_MISC
>>    mask checks, as HK_TYPE_SCHED/HK_TYPE_MISC masks are currently never
>>    set.
>> but it also:
>> - updates the housekeeping mask from sched/topology.c. It might be better
>>    to do it from cpuset.c as you did as the update originally comes from
>>    here and it is unlikely another place would require updating
>> housekeeping
>>    CPUs.
>>    A new housekeeping_runtime type is also created, but I think the way
>> you
>>    handle updating housekeeping mask at runtime is better.
>> - adds a dependency of sched/fair.c over CPU_ISOLATION (cf.
>> housekeeping_*
>>    calls), as Peter noted (IIUC) [1].
> 
> That is true. Without CONFIG_CPU_ISOLATION, all the housekeeping* calls
> are essentially no-ops.
> 
> OTOH, without CONFIG_CPU_ISOLATION, a number of isolation capabilities
> won't be there. Most distros will have this config option set anyway.
> 
> BTW, a number of the HK_TYPE_* are also used at runtime, like
> HK_TYPE_TIMER and HK_TYPE_RCU. So it is hard to artificially distinguish
> between runtime or boot time.
> 
> I don't believe you need to add direct dependency on
> CONFIG_CPU_ISOLATION, but you do have to add any housekeeping check as
> an additional check, not as a replacement of the existing check.

(on another topic)

Isolated CPUs currently keep the state they were in when the isolation was
done, i.e. if the tick was stopped when adding the CPU was added to the
isolated cpumask, then the CPU stays in nohz.idle_cpus_mask forever.
Similarly if the tick was not stopped, the CPU is cleared forever in
nohz.idle_cpus_mask.

This patchset also intended to clear isolated CPUs in nohz.idle_cpus_mask
to let them in a known state. This might not be a good approach.

nohz.idle_cpus_mask is also used in:
   nohz_run_idle_balance()
   \-_nohz_idle_balance()
     \-for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1)
       \-update_nohz_stats()
This is apparently done to update 'the blocked load of already idle CPUs'.
However isolated CPUs might not have their blocked load updated as they are:
- currently randomly part of nohz.idle_cpus_mask.
- after this patch, never part of nohz.idle_cpus_mask.

I am also wondering whether this makes sense for isolated CPUs to update
the blocked load of other CPUs, i.e. if the following would not be needed:



diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dd37168da50..9b92700564b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12291,6 +12291,9 @@ void nohz_run_idle_balance(int cpu)
  {
         unsigned int flags;
  
+       if (on_null_domain(cpu_rq(cpu)))
+               return;
+
         flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
  
         /*


Regards,
Pierre

