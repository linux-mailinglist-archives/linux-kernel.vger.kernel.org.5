Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DEC7D2C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJWIEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:04:29 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E320D65
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:04:23 -0700 (PDT)
Message-ID: <744750b3-27f6-a832-af9b-eea4825fcac6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698048261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9ZkR+TAxsb47GS5kogIBmOxsCjBIAW+1akzDqQqg6A=;
        b=qszkJRLL/7Vhfhn89hXtTi5IjlnCnjhFDCebAKlBdxDg/41cGDf+PW2ybNaNIRpw6m2wVJ
        7pGDgODajSc5WeCk6pHJsTmk+YTKkb7D363lz6Gbb279JGuoHG6cb6G7Fn8w58J+o6edvw
        87kmFaUprTrT/XNjlA8OoEKDUXal2iI=
Date:   Mon, 23 Oct 2023 16:04:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] sched/rt: Account execution time for cgroup and thread
 group if rt entity is task
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20231023065418.1548239-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20231023065418.1548239-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please ignore it, it's missing '#endif'.


On 2023/10/23 14:54, Yajun Deng wrote:
> The rt entity can be a task group. Like the fair scheduler class, we don't
> need to account execution time for cgroup and thread group if the rt
> entity isn't a task.
>
> Check the scheduler class of the task and make sure that the rt entity is a
> task.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   kernel/sched/rt.c    |  4 ----
>   kernel/sched/sched.h | 12 ++++++++++--
>   2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..ccded5670b61 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -165,8 +165,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
>   	hrtimer_cancel(&rt_b->rt_period_timer);
>   }
>   
> -#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
> -
>   static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
>   {
>   #ifdef CONFIG_SCHED_DEBUG
> @@ -283,8 +281,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
>   
>   #else /* CONFIG_RT_GROUP_SCHED */
>   
> -#define rt_entity_is_task(rt_se) (1)
> -
>   static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
>   {
>   	return container_of(rt_se, struct task_struct, rt);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 65cad0e5729e..c338c24e495d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -779,6 +779,11 @@ static inline long se_runnable(struct sched_entity *se)
>   }
>   #endif
>   
> +#ifdef CONFIG_RT_GROUP_SCHED
> +#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
> +#else
> +#define rt_entity_is_task(rt_se) (1)
> +
>   #ifdef CONFIG_SMP
>   /*
>    * XXX we want to get rid of these helpers and use the full load resolution.
> @@ -3266,9 +3271,12 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
>   						u64 now, u64 delta_exec)
>   {
>   	curr->se.sum_exec_runtime += delta_exec;
> -	account_group_exec_runtime(curr, delta_exec);
> -
>   	curr->se.exec_start = now;
> +
> +	if (curr->sched_class == &rt_sched_class && !rt_entity_is_task(&curr->rt))
> +		return;
> +
> +	account_group_exec_runtime(curr, delta_exec);
>   	cgroup_account_cputime(curr, delta_exec);
>   }
>   
