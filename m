Return-Path: <linux-kernel+bounces-132290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AE089928E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA181C20E92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240781F;
	Fri,  5 Apr 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYE+Psq8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC82A639
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276617; cv=none; b=uUJtGoNGk09nNHifLRKBkFOZPhOPZEwVGNL1ladHhD0SKmMgkYkZDeD4eOwMlPF3WJV+JtyFFyxw+hjlC36yAGKz2EK8j3F/ZXrmjpIgX6nWRxSgabsQbQ0unYX7skhEdm4w/pjVXQFIHXA5B1u9+rYwkuujUf2sykR8o46rWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276617; c=relaxed/simple;
	bh=8/JOeeTlUxTqBOtl+3ciCprfYfexP4jRhTANTcXX9HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4tZK2qBwndvTyxb6JjAfWGx3HjT+JYjTJ9R5mm5tg4wzdffSWeAzPHV8oLTYHddKX2pzGl/jdJ7ARtA0QG4ypwbxLgWezb7T1itQctJoS+OmR4HCqLhf3Iu4KFKam7+aAk2Zx9mqS+dwJCrRq7DmwGCYWIlHBYJHbv8E86oMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYE+Psq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712276614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CV+bol1vHIx6BLIs3U/BiWhYJFthx/DWToSvFpXu72w=;
	b=BYE+Psq8pyhAHkARacxy+6NOplqxUUxFXmBQpgU09INhVsRdYtydMv5vx26WVODSIqTWCo
	GL+pLjKi6GEEUoIE0v3uFO2w12SwKsmGl8zEKPtptCighgabvOKXCpw01DNmY7+E13QY7G
	bfJkStkAtG/PjDiMg8/F9Gj2hI2I6Fc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-H2OgJ7F8PaSb8OSbCeP-Ew-1; Thu, 04 Apr 2024 20:23:30 -0400
X-MC-Unique: H2OgJ7F8PaSb8OSbCeP-Ew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0CE1185A781;
	Fri,  5 Apr 2024 00:23:29 +0000 (UTC)
Received: from [10.22.33.193] (unknown [10.22.33.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D5B01C060D0;
	Fri,  5 Apr 2024 00:23:27 +0000 (UTC)
Message-ID: <40c388eb-12c5-4136-ba21-6173e61c0e25@redhat.com>
Date: Thu, 4 Apr 2024 20:23:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] sched/fair|isolation: Correctly clear
 nohz.[nr_cpus|idle_cpus_mask] for isolated CPUs
Content-Language: en-US
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <cecd7e83-b83c-416e-b59b-296f84e5c574@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 4/4/24 08:55, Pierre Gondois wrote:
> Hello Waiman,
> Thanks for the link, I didn't see the patchset previously.
>
> On 4/4/24 05:01, Waiman Long wrote:
>> On 4/3/24 11:05, Pierre Gondois wrote:
>>> Zhang Rui reported that find_new_ilb() was iterating over CPUs in
>>> isolated cgroup partitions. This triggered spurious wakeups for
>>> theses CPUs. [1]
>>> The initial approach was to ignore CPUs on NULL sched domains, as
>>> isolated CPUs have a NULL sched domain. However a CPU:
>>> - with its tick disabled, so taken into account in
>>>     nohz.[idle_cpus_mask|nr_cpus]
>>> - which is placed in an isolated cgroup partition
>>> will never update nohz.[idle_cpus_mask|nr_cpus] again.
>>>
>>> To avoid that, the following variables should be cleared
>>> when a CPU is placed in an isolated cgroup partition:
>>> - nohz.idle_cpus_mask
>>> - nohz.nr_cpus
>>> - rq->nohz_tick_stopped
>>> This would allow to avoid considering wrong nohz.* values during
>>> idle load balance.
>>>
>>> As suggested in [2] and to avoid calling 
>>> nohz_balance_[enter|exit]_idle()
>>> from a remote CPU and create concurrency issues, leverage the existing
>>> housekeeping HK_TYPE_SCHED mask to reflect isolated CPUs (i.e. on NULL
>>> sched domains).
>>> Indeed the HK_TYPE_SCHED mask is currently never set by the
>>> isolcpus/nohz_full kernel parameters, so it defaults to 
>>> cpu_online_mask.
>>> Plus it's current usage fits CPUs that are isolated and should
>>> not take part in load balancing.
>>>
>>> Making use of HK_TYPE_SCHED for this purpose implies creating a
>>> housekeeping mask which can be modified at runtime.
>>>
>>> [1] 
>>> https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/
>>> [2] 
>>> https://lore.kernel.org/all/CAKfTPtAMd_KNKhXXGk5MEibzzQUX3BFkWgxtEW2o8FFTX99DKw@mail.gmail.com/
>>>
>>> Pierre Gondois (7):
>>>     sched/isolation: Introduce housekeeping_runtime isolation
>>>     sched/isolation: Move HK_TYPE_SCHED to housekeeping runtime
>>>     sched/isolation: Use HKR_TYPE_SCHED in find_new_ilb()
>>>     sched/fair: Move/add on_null_domain()/housekeeping_cpu() checks
>>>     sched/topology: Remove CPUs with NULL sd from HKR_TYPE_SCHED mask
>>>     sched/fair: Remove on_null_domain() and redundant checks
>>>     sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
>>>
>>>    include/linux/sched/isolation.h | 30 ++++++++++++++++++++-
>>>    include/linux/sched/nohz.h      |  2 ++
>>>    kernel/sched/fair.c             | 44 +++++++++++++++++-------------
>>>    kernel/sched/isolation.c        | 48 
>>> ++++++++++++++++++++++++++++++++-
>>>    kernel/sched/topology.c         |  7 +++++
>>>    5 files changed, 110 insertions(+), 21 deletions(-)
>>>
>> I had also posted a patch series on excluding isolated CPUs in isolated
>> partitions from housekeeping cpumasks earlier this year. See
>>
>> https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/
>>
>> It took a different approach from this series. It looks like I should
>> include HK_TYPE_MISC as well.
>
> The common point between the 2 patchset is that find_new_ilb() won't
> take into account isolated CPUs.
> The present patchset also:
> - clears nohz.[idle_cpus_mask|nr_cpus] variable when a CPU becomes 
> isolated,
>   cf. [PATCH 7/7] sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
> - tries to clean up/gather on_null_domain()/HK_TYPE_SCHED/HK_TYPE_MISC
>   mask checks, as HK_TYPE_SCHED/HK_TYPE_MISC masks are currently never
>   set.
> but it also:
> - updates the housekeeping mask from sched/topology.c. It might be better
>   to do it from cpuset.c as you did as the update originally comes from
>   here and it is unlikely another place would require updating 
> housekeeping
>   CPUs.
>   A new housekeeping_runtime type is also created, but I think the way 
> you
>   handle updating housekeeping mask at runtime is better.
> - adds a dependency of sched/fair.c over CPU_ISOLATION (cf. 
> housekeeping_*
>   calls), as Peter noted (IIUC) [1].

That is true. Without CONFIG_CPU_ISOLATION, all the housekeeping* calls 
are essentially no-ops.

OTOH, without CONFIG_CPU_ISOLATION, a number of isolation capabilities 
won't be there. Most distros will have this config option set anyway.

BTW, a number of the HK_TYPE_* are also used at runtime, like 
HK_TYPE_TIMER and HK_TYPE_RCU. So it is hard to artificially distinguish 
between runtime or boot time.

I don't believe you need to add direct dependency on 
CONFIG_CPU_ISOLATION, but you do have to add any housekeeping check as 
an additional check, not as a replacement of the existing check.

Cheers,
Longman


