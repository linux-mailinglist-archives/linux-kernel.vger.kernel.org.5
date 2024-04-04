Return-Path: <linux-kernel+bounces-131475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CC898856
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63901F22186
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADD85C70;
	Thu,  4 Apr 2024 12:55:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4339C82C7E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235348; cv=none; b=UNnc2kVpaIw4huIRSFrkwa2l7poY966PHH6LHIhh/WNoFpCqcALFP511vLrx7o1xViyPT6AfiE3p36Wx2jNjwr/vWzd5dyRTunhGkvTf0fVyJq1nsbGm0Nu4YU+Tw0XIcGBERp6E749W7I7qnjd0pRRBktEi/tD8Y+v45WAlmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235348; c=relaxed/simple;
	bh=KOJGuxT0IUjEwMScrZ+bttZSWR5mJLELkbU52u3b8n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usSwZl9T/DLd1Ji/RGT+r0GVecvFql6YTzKZhFjce6zq7htXvsTEMRIGhs+kDQ5Nx3UMsdTra8z3x1w3TFLsFGnVOfs7ArGYBcJagbO+LG1Q+02+BlQaHbI1eKAsiYzso9fFWMtGqtPYQ6yjdUIJnjcmxgsmO4d8qV+vduLPz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D28FEC;
	Thu,  4 Apr 2024 05:56:15 -0700 (PDT)
Received: from [10.34.100.133] (e126645.nice.arm.com [10.34.100.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4FB13F64C;
	Thu,  4 Apr 2024 05:55:41 -0700 (PDT)
Message-ID: <cecd7e83-b83c-416e-b59b-296f84e5c574@arm.com>
Date: Thu, 4 Apr 2024 14:55:40 +0200
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
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <98443f19-c653-493e-a2a9-e1d07b9d8468@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Waiman,
Thanks for the link, I didn't see the patchset previously.

On 4/4/24 05:01, Waiman Long wrote:
> On 4/3/24 11:05, Pierre Gondois wrote:
>> Zhang Rui reported that find_new_ilb() was iterating over CPUs in
>> isolated cgroup partitions. This triggered spurious wakeups for
>> theses CPUs. [1]
>> The initial approach was to ignore CPUs on NULL sched domains, as
>> isolated CPUs have a NULL sched domain. However a CPU:
>> - with its tick disabled, so taken into account in
>>     nohz.[idle_cpus_mask|nr_cpus]
>> - which is placed in an isolated cgroup partition
>> will never update nohz.[idle_cpus_mask|nr_cpus] again.
>>
>> To avoid that, the following variables should be cleared
>> when a CPU is placed in an isolated cgroup partition:
>> - nohz.idle_cpus_mask
>> - nohz.nr_cpus
>> - rq->nohz_tick_stopped
>> This would allow to avoid considering wrong nohz.* values during
>> idle load balance.
>>
>> As suggested in [2] and to avoid calling nohz_balance_[enter|exit]_idle()
>> from a remote CPU and create concurrency issues, leverage the existing
>> housekeeping HK_TYPE_SCHED mask to reflect isolated CPUs (i.e. on NULL
>> sched domains).
>> Indeed the HK_TYPE_SCHED mask is currently never set by the
>> isolcpus/nohz_full kernel parameters, so it defaults to cpu_online_mask.
>> Plus it's current usage fits CPUs that are isolated and should
>> not take part in load balancing.
>>
>> Making use of HK_TYPE_SCHED for this purpose implies creating a
>> housekeeping mask which can be modified at runtime.
>>
>> [1] https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/
>> [2] https://lore.kernel.org/all/CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com/
>>
>> Pierre Gondois (7):
>>     sched/isolation: Introduce housekeeping_runtime isolation
>>     sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
>>     sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
>>     sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
>>     sched/topology: Remove CPUs with NULL sd from HKR_TYPE_SCHED mask
>>     sched/fair: Remove on_null_domain() and redundant checks
>>     sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
>>
>>    include/linux/sched/isolation.h | 30 ++++++++++++++++++++-
>>    include/linux/sched/nohz.h      |  2 ++
>>    kernel/sched/fair.c             | 44 +++++++++++++++++-------------
>>    kernel/sched/isolation.c        | 48 ++++++++++++++++++++++++++++++++-
>>    kernel/sched/topology.c         |  7 +++++
>>    5 files changed, 110 insertions(+), 21 deletions(-)
>>
> I had also posted a patch series on excluding isolated CPUs in isolated
> partitions from housekeeping cpumasks earlier this year. See
> 
> https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/
> 
> It took a different approach from this series. It looks like I should
> include HK_TYPE_MISC as well.

The common point between the 2 patchset is that find_new_ilb() won't
take into account isolated CPUs.
The present patchset also:
- clears nohz.[idle_cpus_mask|nr_cpus] variable when a CPU becomes isolated,
   cf. [PATCH 7/7] sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
- tries to clean up/gather on_null_domain()/HK_TYPE_SCHED/HK_TYPE_MISC
   mask checks, as HK_TYPE_SCHED/HK_TYPE_MISC masks are currently never
   set.
but it also:
- updates the housekeeping mask from sched/topology.c. It might be better
   to do it from cpuset.c as you did as the update originally comes from
   here and it is unlikely another place would require updating housekeeping
   CPUs.
   A new housekeeping_runtime type is also created, but I think the way you
   handle updating housekeeping mask at runtime is better.
- adds a dependency of sched/fair.c over CPU_ISOLATION (cf. housekeeping_*
   calls), as Peter noted (IIUC) [1].

Should I re-spin the patchset and try to correct those points ? Or do you
think this should be done differently ?

Regards,
Pierre

[1] https://lore.kernel.org/lkml/20240404072745.GA35684@noisy.programming.kicks-ass.net/

> 
> Cheers,
> Longman
> 

