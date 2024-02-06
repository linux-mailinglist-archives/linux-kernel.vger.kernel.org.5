Return-Path: <linux-kernel+bounces-54721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49884B2DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E863B24221
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289F11292CF;
	Tue,  6 Feb 2024 10:55:57 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C158131
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216956; cv=none; b=HkmK8pTRPC5rA24Zj9aWHhc1ZYETv8kXrzYBcbTLr9t9xp5VO4DE6n3G3EiCAZGTYFkmU0Kt4vc8X0T+1zVaLa/S0DtjNYRDpl3oCeW8kVh+VfhmxrtzAxWF2j214p0mCb7c8VDd1dXF3KTNbco8H2KO+P36EV73YKpIRaDlQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216956; c=relaxed/simple;
	bh=Rz8sbgycJLKAZBfAqkmFCkKszu2C/D37PBPjyk4d8LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhNt3NMDnjMFdetTr2YbKLFppB1KNVEZwxzDuhSd33eaWXNt3cJbJiLStINmhYH6Ifk+y90hkbfiL1t0x1fTCTb4ncpntULjx4Xiw0IGGAF+/zD7yrY32KBX2jY3PzcCVAXJ6xmJMG4Q9hWylLpBaH1n3bI4ev0FlFHlEKSTues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.138])
	by sina.com (172.16.235.24) with ESMTP
	id 65C2102B00005DAB; Tue, 6 Feb 2024 18:55:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34362945088986
X-SMAIL-UIID: 363A5DE36BF243C2AA6DAD8F9285E6A2-20240206-185542-1
From: Hillf Danton <hdanton@sina.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when updating misfit
Date: Tue,  6 Feb 2024 18:55:30 +0800
Message-Id: <20240206105530.763-1-hdanton@sina.com>
In-Reply-To: <20240205021123.2225933-3-qyousef@layalina.io>
References: <20240205021123.2225933-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  5 Feb 2024 02:11:23 +0000 Qais Yousef <qyousef@layalina.io>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5092,24 +5092,36 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
>  
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  {
> +	unsigned long cpu_cap;
> +	int cpu = cpu_of(rq);
> +
>  	if (!sched_asym_cpucap_active())
>  		return;
>  
> -	if (!p || p->nr_cpus_allowed == 1) {
> -		rq->misfit_task_load = 0;
> -		return;
> -	}
> +	if (!p || p->nr_cpus_allowed == 1)
> +		goto out;
>  
> -	if (task_fits_cpu(p, cpu_of(rq))) {
> -		rq->misfit_task_load = 0;
> -		return;
> -	}
> +	cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> +	/* If we can't fit the biggest CPU, that's the best we can ever get. */
> +	if (cpu_cap == rq->rd->max_cpu_capacity)
> +		goto out;
> +
> +	/* Affinity allows us to go somewhere higher? */
> +	if (cpu_cap == p->max_allowed_capacity)
> +		goto out;

Looks good.
> +
> +	if (task_fits_cpu(p, cpu))
> +		goto out;
>  
>  	/*
>  	 * Make sure that misfit_task_load will not be null even if
>  	 * task_h_load() returns 0.
>  	 */
>  	rq->misfit_task_load = max_t(unsigned long, task_h_load(p), 1);
> +	return;
> +out:
> +	rq->misfit_task_load = 0;
>  }
>  
>  #else /* CONFIG_SMP */
> @@ -8241,6 +8253,36 @@ static void task_dead_fair(struct task_struct *p)
>  	remove_entity_load_avg(&p->se);
>  }
>  
> +/*
> + * Check the max capacity the task is allowed to run at for misfit detection.
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

Given what max_allowed_capacity could mean, it is needed to find the max
capacity by iterating the asym_cap_list instead of the first capacity
determined by the allowed CPU mask.
> +	}
> +	rcu_read_unlock();
> +}

BTW is it working in case of systems with a super core?

	cpu0-3	cpu4-6	cpu7
	little	big	super
	core	core	core

