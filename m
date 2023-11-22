Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747767F4CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjKVQlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjKVQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:40:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83A5010C7;
        Wed, 22 Nov 2023 08:40:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15A91FEC;
        Wed, 22 Nov 2023 08:41:06 -0800 (PST)
Received: from [10.57.4.117] (unknown [10.57.4.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47D43F73F;
        Wed, 22 Nov 2023 08:40:15 -0800 (PST)
Message-ID: <0bc60a26-af18-4108-8b8d-238a1df1775b@arm.com>
Date:   Wed, 22 Nov 2023 16:40:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     lukasz.luba@arm.com, juri.lelli@redhat.com, mingo@redhat.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, bsegall@google.com,
        rostedt@goodmis.org, bristot@redhat.com, mgorman@suse.de,
        vschneid@redhat.com, rafael@kernel.org, qyousef@layalina.io,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>
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

Hi Vincent,

On 22/11/2023 14:01, Vincent Guittot wrote:
> It has been reported that thread's util_est can significantly decrease as
> a result of sharing the CPU with other threads. The use case can be easily
> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> When the task is alone on the CPU, its max utilization and its util_est is
> around 888. If another similar task starts to run on the same CPU, TA will
> have to share the CPU runtime and its maximum utilization will decrease
> around half the CPU capacity (512) then TA's util_est will follow this new
> maximum trend which is only the result of sharing the CPU with others
> tasks. Such situation can be detected with runnable_avg wich is close or
> equal to util_avg when TA is alone but increases above util_avg when TA
> shares the CPU with other threads and wait on the runqueue.

Thanks for bringing this case up. I'm a bit nervous skipping util_est 
updates this way. While it is true that this avoids dropping util_est 
when the task is still busy doing stuff, it also avoids dropping 
util_est when the task really is becoming less busy. If a task has a 
legitimate reason to drop its utilization, it looks weird to me that its 
util_est dropping can be stopped by a new task joining this rq which 
pushes up runnable_avg.

Also, something about rt-app. Is there an easy way to ask an rt-app 
thread to achieve a certain amount of throughput (like loops per 
second)? I think 'runs 1ms and sleeps 100us' may not entirely simulate a 
task that really wants to preserve a util_est of 888. If its utilization 
really is that high, its sleep time will become less and less when 
sharing the rq with another task, or even has no idle time and become 
1024 which will trigger overutilization and migration.

> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> This patch implements what I mentioned in [1]. I have been able to
> reproduce such pattern with rt-app.
> 
> [1] https://lore.kernel.org/lkml/CAKfTPtDd-HhF-YiNTtL9i5k0PfJbF819Yxu4YquzfXgwi7voyw@mail.gmail.com/#t
> 
>   kernel/sched/fair.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857698..eeb505d28905 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4774,6 +4774,11 @@ static inline unsigned long task_util(struct task_struct *p)
>   	return READ_ONCE(p->se.avg.util_avg);
>   }
>   
> +static inline unsigned long task_runnable(struct task_struct *p)
> +{
> +	return READ_ONCE(p->se.avg.runnable_avg);
> +}
> +
>   static inline unsigned long _task_util_est(struct task_struct *p)
>   {
>   	struct util_est ue = READ_ONCE(p->se.avg.util_est);
> @@ -4892,6 +4897,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>   	if (task_util(p) > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
>   		return;
>   
> +	/*
> +	 * To avoid underestimate of task utilization, skip updates of ewma if
> +	 * we cannot grant that thread got all CPU time it wanted.
> +	 */
> +	if ((ue.enqueued + UTIL_EST_MARGIN) < task_runnable(p))
> +		goto done;
> +
> +
>   	/*
>   	 * Update Task's estimated utilization
>   	 *
