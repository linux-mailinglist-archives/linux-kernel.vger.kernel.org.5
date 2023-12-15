Return-Path: <linux-kernel+bounces-1246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF22814C61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322F72856FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852703A8F4;
	Fri, 15 Dec 2023 16:02:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C4364B9;
	Fri, 15 Dec 2023 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E7C4C15;
	Fri, 15 Dec 2023 08:03:14 -0800 (PST)
Received: from [10.57.85.151] (unknown [10.57.85.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AA0D3F5A1;
	Fri, 15 Dec 2023 08:02:25 -0800 (PST)
Message-ID: <06412759-659c-4b80-b946-f533775baa02@arm.com>
Date: Fri, 15 Dec 2023 16:03:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched: Take cpufreq feedback into account
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-3-vincent.guittot@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 mgorman@suse.de, linux-pm@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, mhiramat@kernel.org, vschneid@redhat.com,
 bristot@redhat.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 agross@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, konrad.dybcio@linaro.org,
 andersson@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com,
 rafael@kernel.org, mingo@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, rui.zhang@intel.com
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231212142730.998913-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/12/23 14:27, Vincent Guittot wrote:
> Aggregate the different pressures applied on the capacity of CPUs and
> create a new function that returns the actual capacity of the CPU:
>    get_actual_cpu_capacity()
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 43 +++++++++++++++++++++++--------------------
>   1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcea3d55d95d..11d3be829302 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4932,12 +4932,20 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	trace_sched_util_est_se_tp(&p->se);
>   }
>   
> +static inline unsigned long get_actual_cpu_capacity(int cpu)
> +{
> +	unsigned long capacity = arch_scale_cpu_capacity(cpu);
> +
> +	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
> +
> +	return capacity;
> +}
>   static inline int util_fits_cpu(unsigned long util,
>   				unsigned long uclamp_min,
>   				unsigned long uclamp_max,
>   				int cpu)
>   {
> -	unsigned long capacity_orig, capacity_orig_thermal;
> +	unsigned long capacity_orig;
>   	unsigned long capacity = capacity_of(cpu);
>   	bool fits, uclamp_max_fits;
>   
> @@ -4970,7 +4978,6 @@ static inline int util_fits_cpu(unsigned long util,
>   	 * goal is to cap the task. So it's okay if it's getting less.
>   	 */
>   	capacity_orig = arch_scale_cpu_capacity(cpu);
> -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
>   
>   	/*
>   	 * We want to force a task to fit a cpu as implied by uclamp_max.
> @@ -5045,7 +5052,7 @@ static inline int util_fits_cpu(unsigned long util,
>   	 * handle the case uclamp_min > uclamp_max.
>   	 */
>   	uclamp_min = min(uclamp_min, uclamp_max);
> -	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> +	if (fits && (util < uclamp_min) && (uclamp_min > get_actual_cpu_capacity(cpu)))

That's quite long line, I would break it into 2.

>   		return -1;
>   
>   	return fits;
> @@ -7426,7 +7433,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>   		 * Look for the CPU with best capacity.
>   		 */
>   		else if (fits < 0)
> -			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
> +			cpu_cap = get_actual_cpu_capacity(cpu);
>   
>   		/*
>   		 * First, select CPU which fits better (-1 being better than 0).
> @@ -7919,8 +7926,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   	struct root_domain *rd = this_rq()->rd;
>   	int cpu, best_energy_cpu, target = -1;
>   	int prev_fits = -1, best_fits = -1;
> -	unsigned long best_thermal_cap = 0;
> -	unsigned long prev_thermal_cap = 0;
> +	unsigned long best_actual_cap = 0;
> +	unsigned long prev_actual_cap = 0;
>   	struct sched_domain *sd;
>   	struct perf_domain *pd;
>   	struct energy_env eenv;
> @@ -7950,7 +7957,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   
>   	for (; pd; pd = pd->next) {
>   		unsigned long util_min = p_util_min, util_max = p_util_max;
> -		unsigned long cpu_cap, cpu_thermal_cap, util;
> +		unsigned long cpu_cap, cpu_actual_cap, util;
>   		long prev_spare_cap = -1, max_spare_cap = -1;
>   		unsigned long rq_util_min, rq_util_max;
>   		unsigned long cur_delta, base_energy;
> @@ -7962,18 +7969,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   		if (cpumask_empty(cpus))
>   			continue;
>   
> -		/* Account thermal pressure for the energy estimation */
> +		/* Account external pressure for the energy estimation */
>   		cpu = cpumask_first(cpus);
> -		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
> -		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
> +		cpu_actual_cap = get_actual_cpu_capacity(cpu);
>   
> -		eenv.cpu_cap = cpu_thermal_cap;
> +		eenv.cpu_cap = cpu_actual_cap;
>   		eenv.pd_cap = 0;
>   
>   		for_each_cpu(cpu, cpus) {
>   			struct rq *rq = cpu_rq(cpu);
>   
> -			eenv.pd_cap += cpu_thermal_cap;
> +			eenv.pd_cap += cpu_actual_cap;
>   
>   			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>   				continue;
> @@ -8044,7 +8050,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   			if (prev_delta < base_energy)
>   				goto unlock;
>   			prev_delta -= base_energy;
> -			prev_thermal_cap = cpu_thermal_cap;
> +			prev_actual_cap = cpu_actual_cap;
>   			best_delta = min(best_delta, prev_delta);
>   		}
>   
> @@ -8059,7 +8065,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   			 * but best energy cpu has better capacity.
>   			 */
>   			if ((max_fits < 0) &&
> -			    (cpu_thermal_cap <= best_thermal_cap))
> +			    (cpu_actual_cap <= best_actual_cap))
>   				continue;
>   
>   			cur_delta = compute_energy(&eenv, pd, cpus, p,
> @@ -8080,14 +8086,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>   			best_delta = cur_delta;
>   			best_energy_cpu = max_spare_cap_cpu;
>   			best_fits = max_fits;
> -			best_thermal_cap = cpu_thermal_cap;
> +			best_actual_cap = cpu_actual_cap;
>   		}
>   	}
>   	rcu_read_unlock();
>   
>   	if ((best_fits > prev_fits) ||
>   	    ((best_fits > 0) && (best_delta < prev_delta)) ||
> -	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
> +	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
>   		target = best_energy_cpu;
>   
>   	return target;
> @@ -9466,7 +9472,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>   static unsigned long scale_rt_capacity(int cpu)
>   {
>   	struct rq *rq = cpu_rq(cpu);
> -	unsigned long max = arch_scale_cpu_capacity(cpu);
> +	unsigned long max = get_actual_cpu_capacity(cpu);

Maybe it's not strictly related to this patch, but I would swap the
2 above lines, so that they will be sorted (from longest to shortest).

>   	unsigned long used, free;
>   	unsigned long irq;
>   
> @@ -9478,12 +9484,9 @@ static unsigned long scale_rt_capacity(int cpu)
>   	/*
>   	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
>   	 * (running and not running) with weights 0 and 1024 respectively.
> -	 * avg_thermal.load_avg tracks thermal pressure and the weighted
> -	 * average uses the actual delta max capacity(load).
>   	 */
>   	used = READ_ONCE(rq->avg_rt.util_avg);
>   	used += READ_ONCE(rq->avg_dl.util_avg);
> -	used += thermal_load_avg(rq);
>   
>   	if (unlikely(used >= max))
>   		return 1;

The rest looks good

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

