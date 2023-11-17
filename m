Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73147EF44B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjKQOR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjKQORy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:17:54 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1611D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:17:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso1478463a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700230670; x=1700835470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWWEv6l55RiIgAmgBUo0sIrw6VzAGr6EZ9jqetUNzgo=;
        b=QrJ5qqjd6drGutBpoEsF06H02SfXilAM2jkoxAWvW/tErAAzr8kdH3xwuqzrh+MMKa
         Od/W/lo9TZgUV4DY26OMZYbXBVJPCVqw6qCuiJ6tht45FyDVhZFnxhaTOvAgMiHqy7fI
         RJ6rT8Z5x1lq4Ud41gFD2oj/GMwLXEHYx27Lh9jiA9uQQuzOe1KY8aJTucnZomeThCgn
         IB+jofelp063oaej5jXIx6I9MtZ731g1IyEWGilOxQ31VIumAWi3oR+rdvtdKwro4nMM
         RbRHTjVgX9jlPap7lwEuKu4MxypeiaG2o1rveKUeyj0EyobVHamm6yiPjXYYbyf2ZY01
         jzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700230670; x=1700835470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWWEv6l55RiIgAmgBUo0sIrw6VzAGr6EZ9jqetUNzgo=;
        b=CRbA4q1TpmNKnrJICANNUgHDhYNhF7src78Xx8/Cqm2zDmXpeqZRGHYCcUqB3SMad2
         jkiP6FclqHFg1U/a5zewBlRy0nU8RgYgVvH1HNx86QJpWg3sx6vfhYESb6qYuJmgg1t8
         0jsJxC+FpR1vYrxkWKi1eDyArjudZrWWlxcgVgXXQwzYYIo7A5l2HVFFbtihzA5S6EGn
         8buvmSDzGbXl2fY4thZYpu12bMoBspwKp2HQo7Z8x9ajBAaTrj1/ON/Yl+al82SRt1r+
         qlI9tWaL+ND/stu2Vg6iVFdqfhpsoBpJCDl9ls58mzvsypxkXhXRUkulzSSDxXpSKYQo
         aQeA==
X-Gm-Message-State: AOJu0Yy4Ww4edocNCHDZxV7GrD4FX4aSUMv/5oUQcUESMupjD44hLqNP
        DAQJTFFJhI5umaZCdrAlGshC4/ZNhBiooh9j8aI4eA==
X-Google-Smtp-Source: AGHT+IHGr3aRU0nJcLBWdmvWsdiJYN+Tr9OPRwE+4Bglb77JGQzOQROshyRbjPwNQIJGQ6YlXSc/Jwv6TmuqSvzKFO4=
X-Received: by 2002:a17:90b:1c82:b0:27c:f80a:2c8a with SMTP id
 oo2-20020a17090b1c8200b0027cf80a2c8amr15545840pjb.0.1700230669740; Fri, 17
 Nov 2023 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20231110125902.2152380-1-pierre.gondois@arm.com>
In-Reply-To: <20231110125902.2152380-1-pierre.gondois@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Nov 2023 15:17:38 +0100
Message-ID: <CAKfTPtAoaHBt6QBzzAE+rKwVaD88oMhEa8AiDNJLyYyTc2ZL1w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Use all little CPUs for CPU-bound workload
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Fri, 10 Nov 2023 at 13:59, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
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

This remembers me a similar discussion with Qais:
https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/

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
> detach_tasks()
> \-case migrate_util:
>   \-if (util > env->imbalance) goto next;
>
> After patch:
> When the local group has spare capacity and the busiest group is at
> least tagged as 'group_fully_busy', if the local group has more CPUs

the busiest group is more than  'group_fully_busy'

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
>                         env->imbalance = max(local->group_capacity, local->group_util) -
>                                          local->group_util;
>
> +                       /*
> +                        * On an asymmetric system with CPU-bound tasks, a
> +                        * migrate_util balance might not be able to migrate a
> +                        * task from a big to a little CPU, letting a little
> +                        * CPU unused.
> +                        * If local has an empty CPU and busiest is overloaded,

group_has_spare doesn't mean that the local has an empty cpu but that
one or more cpu might be idle some time which could not be the case
when the load balance happen

> +                        * balance one task with a migrate_task migration type
> +                        * instead.
> +                        */
> +                       if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +                           local->sum_nr_running < local->group_weight &&
> +                           busiest->sum_nr_running > busiest->group_weight) {
> +                               env->migration_type = migrate_task;
> +                               env->imbalance = 1;

I wonder if this is too aggressive. We can have cases where
(local->sum_nr_running < local->group_weight) at the time of the load
balance because one cpu can be shortly idle and you will migrate the
task that will then compete with another one on a little core. So
maybe you should do something similar to the migrate_load in
detach_tasks like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc8e9ced6aa8..3a04fa0f1eae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8977,7 +8977,7 @@ static int detach_tasks(struct lb_env *env)
                case migrate_util:
                        util = task_util_est(p);

-                       if (util > env->imbalance)
+                       if (shr_bound(util,
env->sd->nr_balance_failed) > env->imbalance)
                                goto next;

                        env->imbalance -= util;
--

This should cover more intermediate cases and would benefit to more
topology and cases

> +                               return;
> +                       }
> +
>                         /*
>                          * In some cases, the group's utilization is max or even
>                          * higher than capacity because of migrations but the
> --
> 2.25.1
>
