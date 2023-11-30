Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C27FFD16
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376414AbjK3UvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjK3UvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:51:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802E610E6;
        Thu, 30 Nov 2023 12:51:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091071042;
        Thu, 30 Nov 2023 12:51:49 -0800 (PST)
Received: from [10.57.82.136] (unknown [10.57.82.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 089113F73F;
        Thu, 30 Nov 2023 12:50:59 -0800 (PST)
Message-ID: <74328aca-f66a-4827-b173-f83180722b25@arm.com>
Date:   Thu, 30 Nov 2023 20:50:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Simplify util_est
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        qyousef@layalina.io, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-3-vincent.guittot@linaro.org>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231127143238.1216582-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 14:32, Vincent Guittot wrote:
> With UTIL_EST_FASTUP now being permanent, we can take advantage of the
> fact that the ewma jumps directly to a higher utilization at dequeue to
> simplify util_est and remove the enqueued field.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   include/linux/sched.h | 35 +++-----------------
>   kernel/sched/debug.c  |  7 ++--
>   kernel/sched/fair.c   | 77 ++++++++++++++++---------------------------
>   kernel/sched/pelt.h   |  4 +--
>   4 files changed, 39 insertions(+), 84 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8d258162deb0..f322a1f11468 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -415,41 +415,16 @@ struct load_weight {
>   	u32				inv_weight;
>   };
>   
> -/**
> - * struct util_est - Estimation utilization of FAIR tasks
> - * @enqueued: instantaneous estimated utilization of a task/cpu
> - * @ewma:     the Exponential Weighted Moving Average (EWMA)
> - *            utilization of a task
> - *
> - * Support data structure to track an Exponential Weighted Moving Average
> - * (EWMA) of a FAIR task's utilization. New samples are added to the moving
> - * average each time a task completes an activation. Sample's weight is chosen
> - * so that the EWMA will be relatively insensitive to transient changes to the
> - * task's workload.
> - *
> - * The enqueued attribute has a slightly different meaning for tasks and cpus:
> - * - task:   the task's util_avg at last task dequeue time
> - * - cfs_rq: the sum of util_est.enqueued for each RUNNABLE task on that CPU
> - * Thus, the util_est.enqueued of a task represents the contribution on the
> - * estimated utilization of the CPU where that task is currently enqueued.
> - *
> - * Only for tasks we track a moving average of the past instantaneous
> - * estimated utilization. This allows to absorb sporadic drops in utilization
> - * of an otherwise almost periodic task.
> - *
> +/*
>    * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
>    * updates. When a task is dequeued, its util_est should not be updated if its
>    * util_avg has not been updated in the meantime.
> - * This information is mapped into the MSB bit of util_est.enqueued at dequeue
> - * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
> - * for a task) it is safe to use MSB.
> + * This information is mapped into the MSB bit of util_est at dequeue time.
> + * Since max value of util_est for a task is 1024 (PELT util_avg for a task)
> + * it is safe to use MSB.
>    */
> -struct util_est {
> -	unsigned int			enqueued;
> -	unsigned int			ewma;
>   #define UTIL_EST_WEIGHT_SHIFT		2
>   #define UTIL_AVG_UNCHANGED		0x80000000

NIT: These two defines might be better if placed right under util_est 
below, to indicate that they are only for util_est.

> -} __attribute__((__aligned__(sizeof(u64))));
>   
>   /*
>    * The load/runnable/util_avg accumulates an infinite geometric series
> @@ -505,7 +480,7 @@ struct sched_avg {
>   	unsigned long			load_avg;
>   	unsigned long			runnable_avg;
>   	unsigned long			util_avg;
> -	struct util_est			util_est;
> +	unsigned int			util_est;
>   } ____cacheline_aligned;
>   
>   struct sched_statistics {
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 168eecc209b4..8d5d98a5834d 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -684,8 +684,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>   			cfs_rq->avg.runnable_avg);
>   	SEQ_printf(m, "  .%-30s: %lu\n", "util_avg",
>   			cfs_rq->avg.util_avg);
> -	SEQ_printf(m, "  .%-30s: %u\n", "util_est_enqueued",
> -			cfs_rq->avg.util_est.enqueued);
> +	SEQ_printf(m, "  .%-30s: %u\n", "util_est",
> +			cfs_rq->avg.util_est);
>   	SEQ_printf(m, "  .%-30s: %ld\n", "removed.load_avg",
>   			cfs_rq->removed.load_avg);
>   	SEQ_printf(m, "  .%-30s: %ld\n", "removed.util_avg",
> @@ -1075,8 +1075,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>   	P(se.avg.runnable_avg);
>   	P(se.avg.util_avg);
>   	P(se.avg.last_update_time);
> -	P(se.avg.util_est.ewma);
> -	PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
> +	PM(se.avg.util_est, ~UTIL_AVG_UNCHANGED);
>   #endif
>   #ifdef CONFIG_UCLAMP_TASK
>   	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 146329678cb8..9540f6c73a76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4781,9 +4781,7 @@ static inline unsigned long task_runnable(struct task_struct *p)
>   
>   static inline unsigned long _task_util_est(struct task_struct *p)
>   {
> -	struct util_est ue = READ_ONCE(p->se.avg.util_est);
> -
> -	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> +	return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
>   }
>   
>   static inline unsigned long task_util_est(struct task_struct *p)
> @@ -4800,9 +4798,9 @@ static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>   		return;
>   
>   	/* Update root cfs_rq's estimated utilization */
> -	enqueued  = cfs_rq->avg.util_est.enqueued;
> +	enqueued  = cfs_rq->avg.util_est;
>   	enqueued += _task_util_est(p);
> -	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
>   
>   	trace_sched_util_est_cfs_tp(cfs_rq);
>   }
> @@ -4816,34 +4814,20 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>   		return;
>   
>   	/* Update root cfs_rq's estimated utilization */
> -	enqueued  = cfs_rq->avg.util_est.enqueued;
> +	enqueued  = cfs_rq->avg.util_est;
>   	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
> -	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> +	WRITE_ONCE(cfs_rq->avg.util_est, enqueued);
>   
>   	trace_sched_util_est_cfs_tp(cfs_rq);
>   }
>   
>   #define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
>   
> -/*
> - * Check if a (signed) value is within a specified (unsigned) margin,
> - * based on the observation that:
> - *
> - *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> - *
> - * NOTE: this only works when value + margin < INT_MAX.
> - */
> -static inline bool within_margin(int value, int margin)
> -{
> -	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> -}
> -
>   static inline void util_est_update(struct cfs_rq *cfs_rq,
>   				   struct task_struct *p,
>   				   bool task_sleep)
>   {
> -	long last_ewma_diff, last_enqueued_diff;
> -	struct util_est ue;
> +	unsigned int ewma, dequeued, last_ewma_diff;
>   
>   	if (!sched_feat(UTIL_EST))
>   		return;
> @@ -4855,23 +4839,25 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	if (!task_sleep)
>   		return;
>   
> +	/* Get current estimate of utilization */
> +	ewma = READ_ONCE(p->se.avg.util_est);
> +
>   	/*
>   	 * If the PELT values haven't changed since enqueue time,
>   	 * skip the util_est update.
>   	 */
> -	ue = p->se.avg.util_est;
> -	if (ue.enqueued & UTIL_AVG_UNCHANGED)
> +	if (ewma & UTIL_AVG_UNCHANGED)
>   		return;
>   
> -	last_enqueued_diff = ue.enqueued;
> +	/* Get utilization at dequeue */
> +	dequeued = task_util(p);
>   
>   	/*
>   	 * Reset EWMA on utilization increases, the moving average is used only
>   	 * to smooth utilization decreases.
>   	 */
> -	ue.enqueued = task_util(p);
> -	if (ue.ewma < ue.enqueued) {
> -		ue.ewma = ue.enqueued;
> +	if (ewma <= dequeued) {
> +		ewma = dequeued;
>   		goto done;
>   	}
>   
> @@ -4879,27 +4865,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	 * Skip update of task's estimated utilization when its members are
>   	 * already ~1% close to its last activation value.
>   	 */
> -	last_ewma_diff = ue.enqueued - ue.ewma;
> -	last_enqueued_diff -= ue.enqueued;
> -	if (within_margin(last_ewma_diff, UTIL_EST_MARGIN)) {
> -		if (!within_margin(last_enqueued_diff, UTIL_EST_MARGIN))
> -			goto done;
> -
> -		return;
> -	}
> +	last_ewma_diff = ewma - dequeued;
> +	if (last_ewma_diff < UTIL_EST_MARGIN)
> +		goto done;
>   
>   	/*
>   	 * To avoid overestimation of actual task utilization, skip updates if
>   	 * we cannot grant there is idle time in this CPU.
>   	 */
> -	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> +	if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
>   		return;
>   
>   	/*
>   	 * To avoid underestimate of task utilization, skip updates of EWMA if
>   	 * we cannot grant that thread got all CPU time it wanted.
>   	 */
> -	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> +	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
>   		goto done;
>   
>   
> @@ -4914,18 +4895,18 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
>   	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
>   	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> -	 *          = w * (      last_ewma_diff            ) +     ewma(t-1)
> -	 *          = w * (last_ewma_diff  +  ewma(t-1) / w)
> +	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
> +	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
>   	 *
>   	 * Where 'w' is the weight of new samples, which is configured to be
>   	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
>   	 */
> -	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
> -	ue.ewma  += last_ewma_diff;
> -	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +	ewma <<= UTIL_EST_WEIGHT_SHIFT;
> +	ewma  -= last_ewma_diff;
> +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
>   done:
> -	ue.enqueued |= UTIL_AVG_UNCHANGED;
> -	WRITE_ONCE(p->se.avg.util_est, ue);
> +	ewma |= UTIL_AVG_UNCHANGED;
> +	WRITE_ONCE(p->se.avg.util_est, ewma);
>   
>   	trace_sched_util_est_se_tp(&p->se);
>   }
> @@ -7653,16 +7634,16 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>   	if (sched_feat(UTIL_EST)) {
>   		unsigned long util_est;
>   
> -		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> +		util_est = READ_ONCE(cfs_rq->avg.util_est);
>   
>   		/*
>   		 * During wake-up @p isn't enqueued yet and doesn't contribute
> -		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
> +		 * to any cpu_rq(cpu)->cfs.avg.util_est.
>   		 * If @dst_cpu == @cpu add it to "simulate" cpu_util after @p
>   		 * has been enqueued.
>   		 *
>   		 * During exec (@dst_cpu = -1) @p is enqueued and does
> -		 * contribute to cpu_rq(cpu)->cfs.util_est.enqueued.
> +		 * contribute to cpu_rq(cpu)->cfs.util_est.
>   		 * Remove it to "simulate" cpu_util without @p's contribution.
>   		 *
>   		 * Despite the task_on_rq_queued(@p) check there is still a
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 3a0e0dc28721..9e1083465fbc 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -52,13 +52,13 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
>   		return;
>   
>   	/* Avoid store if the flag has been already reset */
> -	enqueued = avg->util_est.enqueued;
> +	enqueued = avg->util_est;
>   	if (!(enqueued & UTIL_AVG_UNCHANGED))
>   		return;
>   
>   	/* Reset flag to report util_avg has been updated */
>   	enqueued &= ~UTIL_AVG_UNCHANGED;
> -	WRITE_ONCE(avg->util_est.enqueued, enqueued);
> +	WRITE_ONCE(avg->util_est, enqueued);
>   }
>   
>   static inline u64 rq_clock_pelt(struct rq *rq)

Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
