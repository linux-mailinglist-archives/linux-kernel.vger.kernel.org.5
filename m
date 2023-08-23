Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E478555E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjHWKaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHWKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:30:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98AACFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:30:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE34F1042;
        Wed, 23 Aug 2023 03:30:50 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B093F64C;
        Wed, 23 Aug 2023 03:30:08 -0700 (PDT)
Message-ID: <d5407fdf-8e49-1035-3188-f96248c96c44@arm.com>
Date:   Wed, 23 Aug 2023 12:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
References: <20230821224504.710576-1-qyousef@layalina.io>
 <20230821224504.710576-2-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230821224504.710576-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 00:45, Qais Yousef wrote:
> When uclamp_max is being used, the util of the task could be higher than
> the spare capacity of the CPU, but due to uclamp_max value we force fit
> it there.
> 
> The way the condition for checking for max_spare_cap in
> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> hence ending up never performing compute_energy() for this cluster and
> missing an opportunity for a better energy efficient placement to honour
> uclamp_max setting.
> 
> 	max_spare_cap = 0;
> 	cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high

Nitpick:

s/task_util(p)/cpu_util(cpu, p, cpu, ...) which is

max(cpu_util + task_util, cpu_util_est + task_util_est)

> 
> 	...
> 
> 	util_fits_cpu(...);		// will return true if uclamp_max forces it to fit
> 
> 	...
> 
> 	// this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> 	if (cpu_cap > max_spare_cap) {
> 		max_spare_cap = cpu_cap;
> 		max_spare_cap_cpu = cpu;
> 	}
> 
> prev_spare_cap suffers from a similar problem.
> 
> Fix the logic by converting the variables into long and treating -1
> value as 'not populated' instead of 0 which is a viable and correct
> spare capacity value. We need to be careful signed comparison is used
> when comparing with cpu_cap in one of the conditions.
> 
> Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0b7445cd5af9..5da6538ed220 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7707,11 +7707,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	for (; pd; pd = pd->next) {
>  		unsigned long util_min = p_util_min, util_max = p_util_max;
>  		unsigned long cpu_cap, cpu_thermal_cap, util;
> -		unsigned long cur_delta, max_spare_cap = 0;
> +		long prev_spare_cap = -1, max_spare_cap = -1;
>  		unsigned long rq_util_min, rq_util_max;
> -		unsigned long prev_spare_cap = 0;
> +		unsigned long cur_delta, base_energy;
>  		int max_spare_cap_cpu = -1;
> -		unsigned long base_energy;
>  		int fits, max_fits = -1;
>  
>  		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> @@ -7774,7 +7773,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  				prev_spare_cap = cpu_cap;
>  				prev_fits = fits;
>  			} else if ((fits > max_fits) ||
> -				   ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> +				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
>  				/*
>  				 * Find the CPU with the maximum spare capacity
>  				 * among the remaining CPUs in the performance
> @@ -7786,7 +7785,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			}
>  		}
>  
> -		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> +		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
>  			continue;
>  
>  		eenv_pd_busy_time(&eenv, cpus, p);
> @@ -7794,7 +7793,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
>  
>  		/* Evaluate the energy impact of using prev_cpu. */
> -		if (prev_spare_cap > 0) {
> +		if (prev_spare_cap > -1) {
>  			prev_delta = compute_energy(&eenv, pd, cpus, p,
>  						    prev_cpu);
>  			/* CPU utilization has changed */

We still need a solution to deal with situations in which `pd + task
contribution` > `pd_capacity`:

  compute_energy()

    if (dst_cpu >= 0)
     busy_time = min(pd_capacity, pd_busy_time + task_busy_time);
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                  pd + task contribution

busy_time is based on util (ENERGY_UTIL), not on the uclamp values
(FREQUENCY_UTIL) we try to fit into a PD (and finally onto a CPU).

With that as a reminder for us and the change in the cover letter:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
