Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4A7FF06A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjK3Nmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345645AbjK3Nml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:42:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26F8619F;
        Thu, 30 Nov 2023 05:42:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ABAE143D;
        Thu, 30 Nov 2023 05:43:32 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 608C93F5A1;
        Thu, 30 Nov 2023 05:42:43 -0800 (PST)
Message-ID: <b5d83fcd-09fb-4680-a594-d4848fddc50a@arm.com>
Date:   Thu, 30 Nov 2023 14:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Simplify util_est
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, corbet@lwn.net, alexs@kernel.org,
        siyanteng@loongson.cn, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     lukasz.luba@arm.com, hongyan.xia2@arm.com
References: <20231127143238.1216582-1-vincent.guittot@linaro.org>
 <20231127143238.1216582-3-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231127143238.1216582-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 15:32, Vincent Guittot wrote:
> With UTIL_EST_FASTUP now being permanent, we can take advantage of the
> fact that the ewma jumps directly to a higher utilization at dequeue to
> simplify util_est and remove the enqueued field.
> 

Did some simple test with a ramp-up/ramp_down (10-80-10%) task affine to
a CPU.

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/util_est_fastup.ipynb

LGTM.

[...]

> @@ -4879,27 +4865,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	 * Skip update of task's estimated utilization when its members are
>  	 * already ~1% close to its last activation value.
>  	 */
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
>  	/*
>  	 * To avoid overestimation of actual task utilization, skip updates if
>  	 * we cannot grant there is idle time in this CPU.
>  	 */
> -	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
> +	if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
>  		return;

Not directly related to the changes: Should we not use `goto done` here
is well to rearm UTIL_AVG_UNCHANGED?

>  	/*
>  	 * To avoid underestimate of task utilization, skip updates of EWMA if
>  	 * we cannot grant that thread got all CPU time it wanted.
>  	 */
> -	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> +	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
>  		goto done;
>  
>  
> @@ -4914,18 +4895,18 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
>  	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
>  	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> -	 *          = w * (      last_ewma_diff            ) +     ewma(t-1)
> -	 *          = w * (last_ewma_diff  +  ewma(t-1) / w)
> +	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
> +	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
>  	 *
>  	 * Where 'w' is the weight of new samples, which is configured to be
>  	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
>  	 */

The text above still mentioned ue.enqueued and that we store the current
PELT value ... which isn't the case anymore.


> -	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
> -	ue.ewma  += last_ewma_diff;
> -	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +	ewma <<= UTIL_EST_WEIGHT_SHIFT;
> +	ewma  -= last_ewma_diff;
> +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
>  done:
> -	ue.enqueued |= UTIL_AVG_UNCHANGED;
> -	WRITE_ONCE(p->se.avg.util_est, ue);
> +	ewma |= UTIL_AVG_UNCHANGED;
> +	WRITE_ONCE(p->se.avg.util_est, ewma);
>  
>  	trace_sched_util_est_se_tp(&p->se);
>  }

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
