Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D578555F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjHWKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHWKaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:30:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55597CD6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:30:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A999811FB;
        Wed, 23 Aug 2023 03:31:00 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574A83F64C;
        Wed, 23 Aug 2023 03:30:18 -0700 (PDT)
Message-ID: <77cd2ad7-7b94-7c45-fec3-131452229fc1@arm.com>
Date:   Wed, 23 Aug 2023 12:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
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
 <20230821224504.710576-3-qyousef@layalina.io>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230821224504.710576-3-qyousef@layalina.io>
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
> find_energy_efficient_cpu() bails out early if effective util of the
> task is 0 as the delta at this point will be zero and there's nothing
> for EAS to do. When uclamp is being used, this could lead to wrong
> decisions when uclamp_max is set to 0. In this case the task is capped

Does uclamp_max plays a role here? We check util and uclamp_min in this
condition.

> to performance point 0, but it is actually running and consuming energy
> and we can benefit from EAS energy calculations.
> 
> Rework the condition so that it bails out for when util is actually 0 or
> uclamp_min is requesting a higher performance point.

I do get the condition:

> +	if (!task_util_est(p) && p_util_min == 0)
>  		goto unlock;

which is !(task_util_est(p) || p_util_min)

But the text then should be '... bails out for when util is actually 0
and uclamp_min is 0 too'? Or 'uclamp_min is not requesting ...'.

> We can do that without needing to use uclamp_task_util(); remove it.
> 
> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/fair.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5da6538ed220..e19a36e7b433 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4571,22 +4571,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
>  	return max(task_util(p), _task_util_est(p));
>  }
>  
> -#ifdef CONFIG_UCLAMP_TASK
> -static inline unsigned long uclamp_task_util(struct task_struct *p,
> -					     unsigned long uclamp_min,
> -					     unsigned long uclamp_max)
> -{
> -	return clamp(task_util_est(p), uclamp_min, uclamp_max);
> -}
> -#else
> -static inline unsigned long uclamp_task_util(struct task_struct *p,
> -					     unsigned long uclamp_min,
> -					     unsigned long uclamp_max)
> -{
> -	return task_util_est(p);
> -}
> -#endif
> -
>  static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
>  				    struct task_struct *p)
>  {
> @@ -7699,7 +7683,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	target = prev_cpu;
>  
>  	sync_entity_load_avg(&p->se);
> -	if (!uclamp_task_util(p, p_util_min, p_util_max))
> +	if (!task_util_est(p) && p_util_min == 0)
>  		goto unlock;
>  
>  	eenv_task_busy_time(&eenv, p, prev_cpu);

With the question about the content of the patch header in mind:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
