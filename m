Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D87F71E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbjKXKoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345606AbjKXKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:43:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D1BF10F8;
        Fri, 24 Nov 2023 02:44:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16E251063;
        Fri, 24 Nov 2023 02:44:49 -0800 (PST)
Received: from [10.57.4.20] (unknown [10.57.4.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 991283F7A6;
        Fri, 24 Nov 2023 02:44:00 -0800 (PST)
Message-ID: <4a005396-46fd-443c-be15-6fe0e2a1dea5@arm.com>
Date:   Fri, 24 Nov 2023 10:43:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     lukasz.luba@arm.com, mingo@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, bristot@redhat.com, peterz@infradead.org,
        rafael@kernel.org, vschneid@redhat.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, bsegall@google.com, qyousef@layalina.io,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 14:01, Vincent Guittot wrote:
> [...]
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

Actually, does this also skip util_est increases as well, assuming no 
FASTUP? When a task is ramping up, another task could join and then 
blocks this task from ramping up its util_est.

Or do we think this is intended behavior for !FASTUP?

>   	/*
>   	 * Update Task's estimated utilization
>   	 *
