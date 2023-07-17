Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D2B756396
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGQM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGQM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD701729;
        Mon, 17 Jul 2023 05:57:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeZMFXHXHMT9aWsOi0oXPAlwMzqJCK5WI43jBXroBus=;
        b=teLSeg9Wr0AP69oEvN51ywqJ7j931c0nc9XBntCyrHNZbm8QoB3YV8wU8VMiiPeWbIEpCV
        nuXlY1FmhEkCKSK8EdCwoleirx3VE52tDZm9WFkTgI0LyGRIk8MMNHIJfa5d1v2K7fCJB2
        9FUvVpSi31XNHZW6cykJj7Kf6LKb0ft5MQLnAhVESjRFehbStV9z5ftavSysIxztJqSlo7
        /qwMGU/M+oFdupka+PFK9/NqJpstumNh8/xDU/BqtfNr0AQwefr2hdkeVAWsW6K22vWkH7
        CEBDBLJxShvCS4xVxE8z1tQfd0lntF9UskqZH7s6V49ocn+GYyRRwHY6WyEFEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CeZMFXHXHMT9aWsOi0oXPAlwMzqJCK5WI43jBXroBus=;
        b=CjkSEWpUY0q1pBTPwvXn8v5ZUM5zvvwV1rt0+cUA1Vnvi99k3GvMvst9amBLAKNRvUE133
        GNtSanEsmkCL+kDA==
From:   "tip-bot2 for Tim C Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Determine active load balance for SMT
 sched groups
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce24f35d142308790f69be65930b82794ef6658a2=2E16887?=
 =?utf-8?q?70494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Ce24f35d142308790f69be65930b82794ef6658a2=2E168877?=
 =?utf-8?q?0494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168959857315.28540.4514179800273596180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fee1759e4f042aaaa643c50369a03a9a6559a575
Gitweb:        https://git.kernel.org/tip/fee1759e4f042aaaa643c50369a03a9a6559a575
Author:        Tim C Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 07 Jul 2023 15:57:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:51 +02:00

sched/fair: Determine active load balance for SMT sched groups

On hybrid CPUs with scheduling cluster enabled, we will need to
consider balancing between SMT CPU cluster, and Atom core cluster.

Below shows such a hybrid x86 CPU with 4 big cores and 8 atom cores.
Each scheduling cluster span a L2 cache.

          --L2-- --L2-- --L2-- --L2-- ----L2---- -----L2------
          [0, 1] [2, 3] [4, 5] [5, 6] [7 8 9 10] [11 12 13 14]
          Big    Big    Big    Big    Atom       Atom
          core   core   core   core   Module     Module

If the busiest group is a big core with both SMT CPUs busy, we should
active load balance if destination group has idle CPU cores.  Such
condition is considered by asym_active_balance() in load balancing but not
considered when looking for busiest group and computing load imbalance.
Add this consideration in find_busiest_group() and calculate_imbalance().

In addition, update the logic determining the busier group when one group
is SMT and the other group is non SMT but both groups are partially busy
with idle CPU. The busier group should be the group with idle cores rather
than the group with one busy SMT CPU.  We do not want to make the SMT group
the busiest one to pull the only task off SMT CPU and causing the whole core to
go empty.

Otherwise suppose in the search for the busiest group, we first encounter
an SMT group with 1 task and set it as the busiest.  The destination
group is an atom cluster with 1 task and we next encounter an atom
cluster group with 3 tasks, we will not pick this atom cluster over the
SMT group, even though we should.  As a result, we do not load balance
the busier Atom cluster (with 3 tasks) towards the local atom cluster
(with 1 task).  And it doesn't make sense to pick the 1 task SMT group
as the busier group as we also should not pull task off the SMT towards
the 1 task atom cluster and make the SMT core completely empty.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 80 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 159b202..accbfbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8447,6 +8447,11 @@ enum group_type {
 	 */
 	group_misfit_task,
 	/*
+	 * Balance SMT group that's fully busy. Can benefit from migration
+	 * a task on SMT with busy sibling to another CPU on idle core.
+	 */
+	group_smt_balance,
+	/*
 	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
 	 * and the task should be migrated to it instead of running on the
 	 * current CPU.
@@ -9154,6 +9159,7 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
+	unsigned int group_smt_balance;  /* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -9427,6 +9433,9 @@ group_type group_classify(unsigned int imbalance_pct,
 	if (sgs->group_asym_packing)
 		return group_asym_packing;
 
+	if (sgs->group_smt_balance)
+		return group_smt_balance;
+
 	if (sgs->group_misfit_task_load)
 		return group_misfit_task;
 
@@ -9496,6 +9505,36 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
+/* One group has more than one SMT CPU while the other group does not */
+static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
+				    struct sched_group *sg2)
+{
+	if (!sg1 || !sg2)
+		return false;
+
+	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
+		(sg2->flags & SD_SHARE_CPUCAPACITY);
+}
+
+static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
+			       struct sched_group *group)
+{
+	if (env->idle == CPU_NOT_IDLE)
+		return false;
+
+	/*
+	 * For SMT source group, it is better to move a task
+	 * to a CPU that doesn't have multiple tasks sharing its CPU capacity.
+	 * Note that if a group has a single SMT, SD_SHARE_CPUCAPACITY
+	 * will not be on.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY &&
+	    sgs->sum_h_nr_running > 1)
+		return true;
+
+	return false;
+}
+
 static inline bool
 sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 {
@@ -9588,6 +9627,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_asym_packing = 1;
 	}
 
+	/* Check for loaded SMT group to be balanced to dst CPU */
+	if (!local_group && smt_balance(env, sgs, group))
+		sgs->group_smt_balance = 1;
+
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
@@ -9672,6 +9715,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 			return false;
 		break;
 
+	case group_smt_balance:
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9701,6 +9745,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 
 	case group_has_spare:
 		/*
+		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
+		 * as we do not want to pull task off SMT core with one task
+		 * and make the core idle.
+		 */
+		if (smt_vs_nonsmt_groups(sds->busiest, sg)) {
+			if (sg->flags & SD_SHARE_CPUCAPACITY && sgs->sum_h_nr_running <= 1)
+				return false;
+			else
+				return true;
+		}
+
+		/*
 		 * Select not overloaded group with lowest number of idle cpus
 		 * and highest number of running tasks. We could also compare
 		 * the spare capacity which is more stable but it can end up
@@ -9896,6 +9952,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
 
 	case group_imbalanced:
 	case group_asym_packing:
+	case group_smt_balance:
 		/* Those types are not used in the slow wakeup path */
 		return false;
 
@@ -10027,6 +10084,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_imbalanced:
 	case group_asym_packing:
+	case group_smt_balance:
 		/* Those type are not used in the slow wakeup path */
 		return NULL;
 
@@ -10281,6 +10339,13 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
+	if (busiest->group_type == group_smt_balance) {
+		/* Reduce number of tasks sharing CPU capacity */
+		env->migration_type = migrate_task;
+		env->imbalance = 1;
+		return;
+	}
+
 	if (busiest->group_type == group_imbalanced) {
 		/*
 		 * In the group_imb case we cannot rely on group-wide averages
@@ -10536,16 +10601,23 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
-		if (env->idle == CPU_NOT_IDLE)
+		if (env->idle == CPU_NOT_IDLE) {
 			/*
 			 * If the busiest group is not overloaded (and as a
 			 * result the local one too) but this CPU is already
 			 * busy, let another idle CPU try to pull task.
 			 */
 			goto out_balanced;
+		}
+
+		if (busiest->group_type == group_smt_balance &&
+		    smt_vs_nonsmt_groups(sds.local, sds.busiest)) {
+			/* Let non SMT CPU pull from SMT CPU sharing with sibling */
+			goto force_balance;
+		}
 
 		if (busiest->group_weight > 1 &&
-		    local->idle_cpus <= (busiest->idle_cpus + 1))
+		    local->idle_cpus <= (busiest->idle_cpus + 1)) {
 			/*
 			 * If the busiest group is not overloaded
 			 * and there is no imbalance between this and busiest
@@ -10556,12 +10628,14 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			 * there is more than 1 CPU per group.
 			 */
 			goto out_balanced;
+		}
 
-		if (busiest->sum_h_nr_running == 1)
+		if (busiest->sum_h_nr_running == 1) {
 			/*
 			 * busiest doesn't have any tasks waiting to run
 			 */
 			goto out_balanced;
+		}
 	}
 
 force_balance:
