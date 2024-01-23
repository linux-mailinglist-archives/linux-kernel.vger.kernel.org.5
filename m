Return-Path: <linux-kernel+bounces-35846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA7839740
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128B428AD89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFD81AA9;
	Tue, 23 Jan 2024 18:07:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AC8120A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033255; cv=none; b=YUKi02bLGqBq8gDIP+346+X/oL9C+eQNmjt8W/1a5ExybPgeNGAdAlmT+H35dOWZ9mFH+QPNoSyE2/SjFKogyvNOMkQ1vteV39sKwN3yvL4GsoSb2sVR00k0lNDYROFyYeH5gmfPFoTKuyojSldVCaKCqEQojuYj9diTjSXMPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033255; c=relaxed/simple;
	bh=aw0/A6c0bkVUDry0Q1qtqnAwY8QhF/w9QoJfqmSwWf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kr+XVXlBpZ93KSOPQ58+uknRHjpQCUfaJDTe90dJeZ0p/WD0MSR4gR2uUISFks+rNSGORvd1AuMDUpwjiqFpTXXSv+v9VaL4zQQNh6sLJIzC0MTXfWl9H851/hFF0WZmrOyrivOObMdlFnefraJQhtq72LFeZa5vytH1LhiOmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AA431FB;
	Tue, 23 Jan 2024 10:08:17 -0800 (PST)
Received: from [172.27.248.88] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F19D53F7F4;
	Tue, 23 Jan 2024 10:07:30 -0800 (PST)
Message-ID: <ece7ce3f-17f3-42a5-90d7-d0410235059d@arm.com>
Date: Tue, 23 Jan 2024 18:07:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <20240122180212.67csjrnsbs7vq57i@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240122180212.67csjrnsbs7vq57i@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:02, Qais Yousef wrote:
> On 01/22/24 09:59, Dietmar Eggemann wrote:
>> On 05/01/2024 23:20, Qais Yousef wrote:
>>> From: Qais Yousef <qais.yousef@arm.com>

[...]

>>> +	/*
>>> +	 * If the task affinity is not set to default, make sure it is not
>>> +	 * restricted to a subset where no CPU can ever fit it. Triggering
>>> +	 * misfit in this case is pointless as it has no where better to move
>>> +	 * to. And it can lead to balance_interval to grow too high as we'll
>>> +	 * continuously fail to move it anywhere.
>>> +	 */
>>> +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
>>
>> Shouldn't this be cpu_active_mask ?
> 
> Hmm. So the intention was to check if the affinity was changed from default.
> 
> If we hotplug all but little we could end up with the same problem, yes you're
> right.
> 
> But if the affinity is set to only to littles and cpu_active_mask is only for
> littles too, then we'll also end up with the same problem as they both are
> equal.

Yes, that's true.

> Better to drop this check then? With the sorted list the common case should be
> quick to return as they'll have 1024 as a possible CPU.

Or you keep 'cpu_possible_mask' and rely on the fact that the
asym_cap_list entries are removed if those CPUs are hotplugged out. In
this case the !has_fitting_cpu path should prevent useless Misfit load
balancing approaches.

[...]

>> What happen when we hotplug out all CPUs of one CPU capacity value?
>> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
>> (partition_sched_domains_locked()).
> 
> Right. I missed that. We can add another intersection check against
> cpu_active_mask.
> 
> I am assuming the skipping was done by design, not a bug that needs fixing?
> I see for suspend (cpuhp_tasks_frozen) the domains are rebuilt, but not for
> hotplug.

IMHO, it's by design. We setup asym_cap_list only when new_topology is
set (update_topology_flags_workfn() from init_cpu_capacity_callback() or
topology_init_cpu_capacity_cppc()). I.e. when the (max) CPU capacity can
change.
In all the other !new_topology cases we check `has_asym |= sd->flags &
SD_ASYM_CPUCAPACITY` and set sched_asym_cpucapacity accordingly in
build_sched_domains(). Before we always reset sched_asym_cpucapacity in
detach_destroy_domains().
But now we would have to keep asym_cap_list in sync with the active CPUs
I guess.

[...]

>>>  #else /* CONFIG_SMP */
>>> @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>>>   */
>>>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>>>  {
>>> -	return rq->misfit_task_load &&
>>> -		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
>>> -		 check_cpu_capacity(rq, sd));
>>> +	return rq->misfit_task_load && check_cpu_capacity(rq, sd);
>>
>> You removed 'arch_scale_cpu_capacity(rq->cpu) <
>> rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
> 
> Based on Pierre review since we no longer trigger misfit for big cores.
> I thought Pierre's remark was correct so did the change in v3

Ah, this is the replacement:

- if (task_fits_cpu(p, cpu_of(rq))) {  <- still MF for util > 0.8 * 1024
-     rq->misfit_task_load = 0;
-     return;
+ cpu_cap = arch_scale_cpu_capacity(cpu);
+
+ /* If we can't fit the biggest CPU, that's the best we can ever get */
+   if (cpu_cap == SCHED_CAPACITY_SCALE)
+       goto out;

> 
> 	https://lore.kernel.org/lkml/bae88015-4205-4449-991f-8104436ab3ba@arm.com/
> 
>> setup (max CPU capacity equal 1024) which is what we probably use 100%
>> of the time now. It might get useful again when Vincent will introduce
>> his 'user space system pressure' implementation?
> 
> I don't mind putting it back if you think it'd be required again in the near
> future. I still didn't get a chance to look at Vincent patches properly, but if
> there's a clash let's reduce the work.

Vincent did already comment on this in this thread.

[...]

>>> @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
>>>  
>>>  	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
>>>  		if (cpumask_empty(cpu_capacity_span(entry))) {
>>> -			list_del(&entry->link);
>>> -			kfree(entry);
>>> +			list_del_rcu(&entry->link);
>>> +			call_rcu(&entry->rcu, free_asym_cap_entry);
>>
>> Looks like there could be brief moments in which one CPU capacity group
>> of CPUs could be twice in asym_cap_list. I'm thinking about initial
>> startup + max CPU frequency related adjustment of CPU capacity
>> (init_cpu_capacity_callback()) for instance. Not sure if this is really
>> an issue?
> 
> I don't think so. As long as the reader sees a consistent value and no crashes
> ensued, a momentarily wrong decision in transient or extra work is fine IMO.
> I don't foresee a big impact.

OK.

