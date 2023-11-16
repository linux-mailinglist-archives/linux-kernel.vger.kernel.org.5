Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1897EE53E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKPQeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjKPQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:34:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E409119B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:34:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92C461595;
        Thu, 16 Nov 2023 08:34:51 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF603F73F;
        Thu, 16 Nov 2023 08:34:03 -0800 (PST)
Message-ID: <3249da56-b5b8-4f10-a148-8a221cdf269a@arm.com>
Date:   Thu, 16 Nov 2023 17:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Use all little CPUs for CPU-bound workload
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20231110125902.2152380-1-pierre.gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231110125902.2152380-1-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 13:59, Pierre Gondois wrote:
> Running n CPU-bound tasks on an n CPUs platform with asymmetric CPU
> capacity might result in a task placement where two tasks run on a
> big CPU and none on a little CPU. This placement could be more optimal
> by using all CPUs.
> 
> Testing platform:
> Juno-r2:
> - 2 big CPUs (1-2), maximum capacity of 1024
> - 4 little CPUs (0,3-5), maximum capacity of 383
> 
> Testing workload ([1]):
> Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
> is affine to a CPU, except for:
> - one little CPU which is left idle.
> - one big CPU which has 2 tasks affine.
> After the 100ms (step 2), remove the cpumask affinity.

I used your workload on my Juno-r0 with LISA (rt-app overwrites the
mainline CPU capacity values [446 1024 1024 446 446 466] to [675 1024
1024 675 675 675] to adapt to rt-app busy loop's instruction mix.

Here I can't see the issue you bring up here. The two tasks sharing a
CPU have util_avg = ~512 and the load-balance from one task to the idle
little CPU is happening,

I assume it's the diff in CPU capacity of the little CPUs: 383 < 512 <
675 ?

> 
> Before patch:
> During step 2, the load balancer running from the idle CPU tags sched
> domains as:
> - little CPUs: 'group_has_spare'. Indeed, 3 CPU-bound tasks run on a
>   4 CPUs sched-domain, and the idle CPU provides enough spare
>   capacity.
> - big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
>   sched-domain, so the following path is used:
>   group_is_overloaded()
>   \-if (sgs->sum_nr_running <= sgs->group_weight) return true;
> 
>   The following path which would change the migration type to
>   'migrate_task' is not taken:
>   calculate_imbalance()
>   \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
>   as the local group has some spare capacity, so the imbalance
>   is not 0.
> 
> The migration type requested is 'migrate_util' and the busiest
> runqueue is the big CPU's runqueue having 2 tasks (each having a
> utilization of 512). The idle little CPU cannot pull one of these
> task as its capacity is too small for the task. The following path
> is used:

Ah, here you're describing the issue I mentioned above.

> detach_tasks()
> \-case migrate_util:
>   \-if (util > env->imbalance) goto next;
> 
> After patch:
> When the local group has spare capacity and the busiest group is at
> least tagged as 'group_fully_busy', if the local group has more CPUs
> than CFS tasks and the busiest group more CFS tasks than CPUs,
> request a 'migrate_task' type migration.
> 
> Improvement:
> Running the testing workload [1] with the step 2 representing
> a ~10s load for a big CPU:
> Before patch: ~19.3s
> After patch: ~18s (-6.7%)
> 
> The issue only happens at the DIE level on platforms able to have
> 'migrate_util' migration types, i.e. no DynamIQ systems where
> SD_SHARE_PKG_RESOURCES is set.

Right, mainline Arm DynamIQ should only have 1 SD level (MC). Android
might still be affected since they run MC and DIE.

> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df348aa55d3c..5a215c96d420 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10495,6 +10495,23 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			env->imbalance = max(local->group_capacity, local->group_util) -
>  					 local->group_util;
>  
> +			/*
> +			 * On an asymmetric system with CPU-bound tasks, a
> +			 * migrate_util balance might not be able to migrate a
> +			 * task from a big to a little CPU, letting a little
> +			 * CPU unused.
> +			 * If local has an empty CPU and busiest is overloaded,
> +			 * balance one task with a migrate_task migration type
> +			 * instead.
> +			 */
> +			if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +			    local->sum_nr_running < local->group_weight &&
> +			    busiest->sum_nr_running > busiest->group_weight) {
> +				env->migration_type = migrate_task;
> +				env->imbalance = 1;
> +				return;
> +			}
> +
>  			/*
>  			 * In some cases, the group's utilization is max or even
>  			 * higher than capacity because of migrations but the

