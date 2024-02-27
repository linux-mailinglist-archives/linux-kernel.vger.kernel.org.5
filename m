Return-Path: <linux-kernel+bounces-82985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5A868C94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E52281F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D431384BE;
	Tue, 27 Feb 2024 09:43:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B51369BB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026987; cv=none; b=Sv222bBTfkZ+YkxApiAK0578ENpwaPzOXjKiaKQb6Ivi9k9vbaXCBTQj9pq0UBC2jItuFX3oU9Ne1EoXJapY2BaXH5DyWc1XRv5zxWbKa7cm7ZMmuV46VNYjYAqmpeAlV6zwbVZrmRMFlZlP3H1XWMao74/kjfS6Eanz4k3x0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026987; c=relaxed/simple;
	bh=1XTPpshTG3t8hNZuApNCvZ6UkkCZaeQ+3fXnxMkcyTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acMXmkMa618no8g3X1gJRxs1NAZcdPTz97u7NsazyrtJK4EnuOClTRRJd4QfHCrUpttuLKW7M+4ysoTwCGKuJdp9MUCGvtOeZJ8Mb/Y1GiLHNyV7vUcK+0zzbCGxjDW4txCjC0GsMjGtnQKXaE2nyqJPK08Qr6fQDv+ynmvvks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB5ABDA7;
	Tue, 27 Feb 2024 01:43:42 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CB2F3F762;
	Tue, 27 Feb 2024 01:43:03 -0800 (PST)
Message-ID: <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
Date: Tue, 27 Feb 2024 10:42:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240220225622.2626569-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 23:56, Qais Yousef wrote:
> If a misfit task is affined to a subset of the possible cpus, we need to
> verify that one of these cpus can fit it. Otherwise the load balancer
> code will continuously trigger needlessly leading the balance_interval
> to increase in return and eventually end up with a situation where real
> imbalances take a long time to address because of this impossible
> imbalance situation.
> 
> This can happen in Android world where it's common for background tasks
> to be restricted to little cores.
> 
> Similarly if we can't fit the biggest core, triggering misfit is
> pointless as it is the best we can ever get on this system.
> 
> To be able to detect that; we use asym_cap_list to iterate through
> capacities in the system to see if the task is able to run at a higher
> capacity level based on its p->cpus_ptr. We do that when the affinity
> change, a fair task is forked, or when a task switched to fair policy.
> We store the max_allowed_capacity in task_struct to allow for cheap
> comparison in the fast path.
> 
> Improve check_misfit_status() function by removing redundant checks.
> misfit_task_load will be 0 if the task can't move to a bigger CPU. And
> nohz_load_balance() already checks for cpu_check_capacity() before

s/nohz_load_balance()/nohz_balancer_kick() ?

> calling check_misfit_status().

Isn't there an issue with CPU hotplug.

On a tri-geared Juno:

root@juno:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
513
1024
1024
513
256
256

root@juno:~# taskset -pc 0,3-5 $$

[  108.248425] set_task_max_allowed_capacity() [bash 1636]
max_allowed_capacity=513 nr_cpus_allowed=4 cpus_mask=0,3-5

echo 0 > /sys//devices/system/cpu/cpu0/online
echo 0 > /sys//devices/system/cpu/cpu3/online

[  134.136887] set_task_max_allowed_capacity() [bash 1639]
max_allowed_capacity=513 nr_cpus_allowed=4 cpus_mask=0,3-5


Cpuset seems to be fine since it set task's cpumask.

[...]

> +/*
> + * Check the max capacity the task is allowed to run at for misfit detection.

Nitpick: It's rather a setter function so s/check/set here ?

> + */
> +static void set_task_max_allowed_capacity(struct task_struct *p)
> +{
> +	struct asym_cap_data *entry;
> +
> +	if (!sched_asym_cpucap_active())
> +		return;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
> +		cpumask_t *cpumask;
> +
> +		cpumask = cpu_capacity_span(entry);
> +		if (!cpumask_intersects(p->cpus_ptr, cpumask))
> +			continue;
> +
> +		p->max_allowed_capacity = entry->capacity;
> +		break;
> +	}
> +	rcu_read_unlock();
> +}

[...]

> @@ -9601,16 +9644,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>  				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
>  }
>  
> -/*
> - * Check whether a rq has a misfit task and if it looks like we can actually
> - * help that task: we can migrate the task to a CPU of higher capacity, or
> - * the task's current CPU is heavily pressured.
> - */
> -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> +/* Check if the rq has a misfit task */
> +static inline bool check_misfit_status(struct rq *rq, struct sched_domain *sd)

`struct sched_domain *sd` is not needed anymore.

Since there is only 1 user of check_misfit_status() you might remove it
entirely and use `rq->rq->misfit_task_load` directly in
nohz_balancer_kick() ?

[...]

