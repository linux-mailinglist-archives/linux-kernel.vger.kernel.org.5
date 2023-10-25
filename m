Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB27D682F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJYKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbjJYKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:19:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4DADD
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zc1ZvfOUHg3+J3bBt4HRH7LLRvzl+9LSK612bp1S/zs=; b=qBlGf9Q5q9l5ldKC3jtBxPawMM
        HpazVSVRfUUwPtwYXlKeZ2EIuZj6ZHrpwZ8XA8eUPceYFxzVzZAnwg9ePz+7tCHz9Tt1fszqsXzUo
        Wh4tzGVK2HTm5fuDvlVww0ta5oi9oKOHSTyiOC4rNzoQRW2qAb2Gm4bJ8YpLWSa63wv07GU/flz/N
        Wg17u7c9KULOp5NYTw3UQOnoa0wjAsu0Ov2ZPr1P97JTq1PwSBFSKYmp5AKa6D75vvxswcBeKKimJ
        ZUuEoTW4rz/7FulGIYT9udXNadduDwNWbuwxm2Pp623jfEchns5YEugHje7TbdUb8a5H8XlWPeS6C
        KIyYAcrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvazA-00GHNf-1g;
        Wed, 25 Oct 2023 10:19:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33E2930047C; Wed, 25 Oct 2023 12:19:36 +0200 (CEST)
Date:   Wed, 25 Oct 2023 12:19:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/rt: Account execution time for cgroup and
 thread group if rt entity is task
Message-ID: <20231025101936.GF37471@noisy.programming.kicks-ass.net>
References: <20231023080954.1628449-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023080954.1628449-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 04:09:54PM +0800, Yajun Deng wrote:
> The rt entity can be a task group. Like the fair scheduler class, we don't
> need to account execution time for cgroup and thread group if the rt
> entity isn't a task.

Why not? I mean, this Changelog would be ever so much better if it
actually explained something instead of said: do as fair does.


>  kernel/sched/rt.c    |  4 ----
>  kernel/sched/sched.h | 13 +++++++++++--
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..ccded5670b61 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -165,8 +165,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
>  	hrtimer_cancel(&rt_b->rt_period_timer);
>  }
>  
> -#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
> -
>  static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
>  {
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -283,8 +281,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
>  
>  #else /* CONFIG_RT_GROUP_SCHED */
>  
> -#define rt_entity_is_task(rt_se) (1)
> -
>  static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
>  {
>  	return container_of(rt_se, struct task_struct, rt);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 65cad0e5729e..95d696e23a89 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -779,6 +779,12 @@ static inline long se_runnable(struct sched_entity *se)
>  }
>  #endif
>  
> +#ifdef CONFIG_RT_GROUP_SCHED
> +#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
> +#else
> +#define rt_entity_is_task(rt_se) (1)
> +#endif
> +
>  #ifdef CONFIG_SMP
>  /*
>   * XXX we want to get rid of these helpers and use the full load resolution.
> @@ -3266,9 +3272,12 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
>  						u64 now, u64 delta_exec)
>  {
>  	curr->se.sum_exec_runtime += delta_exec;
> -	account_group_exec_runtime(curr, delta_exec);
> -
>  	curr->se.exec_start = now;
> +
> +	if (curr->sched_class == &rt_sched_class && !rt_entity_is_task(&curr->rt))
> +		return;
> +
> +	account_group_exec_runtime(curr, delta_exec);
>  	cgroup_account_cputime(curr, delta_exec);
>  }


*groan*

what's wrong with something like the below?

---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb1996a674db..36f30b236900 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1327,7 +1327,7 @@ static void update_curr_dl(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec, true);
 
 	if (dl_entity_is_special(dl_se))
 		return;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3b627ab586fb..7d6b21b80150 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1014,7 +1014,7 @@ static void update_curr_rt(struct rq *rq)
 
 	trace_sched_stat_runtime(curr, delta_exec, 0);
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec, rt_entity_is_task(rt_se));
 
 	if (!rt_bandwidth_enabled())
 		return;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 41d760df458f..ce114a935af0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3272,13 +3272,16 @@ extern void sched_dynamic_update(int mode);
 #endif
 
 static inline void update_current_exec_runtime(struct task_struct *curr,
-						u64 now, u64 delta_exec)
+						u64 now, u64 delta_exec,
+						bool cgroup)
 {
 	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
 	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
+
+	if (cgroup) {
+		account_group_exec_runtime(curr, delta_exec);
+		cgroup_account_cputime(curr, delta_exec);
+	}
 }
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 6cf7304e6449..1bec2af7ce8d 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -81,7 +81,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 	schedstat_set(curr->stats.exec_max,
 		      max(curr->stats.exec_max, delta_exec));
 
-	update_current_exec_runtime(curr, now, delta_exec);
+	update_current_exec_runtime(curr, now, delta_exec, true);
 }
 
 /*
