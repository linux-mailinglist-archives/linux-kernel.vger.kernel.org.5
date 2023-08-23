Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8D785560
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHWKar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbjHWKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:30:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E37CD1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:30:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E4E11042;
        Wed, 23 Aug 2023 03:31:15 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5769D3F64C;
        Wed, 23 Aug 2023 03:30:33 -0700 (PDT)
Message-ID: <671ff8bf-ed3e-b651-d9da-6507fddee010@arm.com>
Date:   Wed, 23 Aug 2023 12:30:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] sched/tp: Add new tracepoint to track compute
 energy computation
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
 <20230821224504.710576-4-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230821224504.710576-4-qyousef@layalina.io>
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
> It was useful to track feec() placement decision and debug the spare
> capacity and optimization issues vs uclamp_max.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  include/trace/events/sched.h | 5 +++++
>  kernel/sched/core.c          | 1 +
>  kernel/sched/fair.c          | 7 ++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index fbb99a61f714..a13d5d06be9d 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -735,6 +735,11 @@ DECLARE_TRACE(sched_update_nr_running_tp,
>  	TP_PROTO(struct rq *rq, int change),
>  	TP_ARGS(rq, change));
>  
> +DECLARE_TRACE(sched_compute_energy_tp,
> +	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy,
> +		 unsigned long max_util, unsigned long busy_time),
> +	TP_ARGS(p, dst_cpu, energy, max_util, busy_time));
> +
>  #endif /* _TRACE_SCHED_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index efe3848978a0..36c60ad9966a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e19a36e7b433..779c285203e3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7604,11 +7604,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
>  {
>  	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
>  	unsigned long busy_time = eenv->pd_busy_time;
> +	unsigned long energy;
>  
>  	if (dst_cpu >= 0)
>  		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
>  
> -	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> +	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> +
> +	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
> +
> +	return energy;
>  }
>  
>  /*

I will make sure that this gets integrated into our trace module in Lisa
https://github.com/ARM-software/lisa .

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
