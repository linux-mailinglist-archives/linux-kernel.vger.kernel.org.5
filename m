Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9C7E80F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjKJSUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjKJSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A65B5357AA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:59:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E144112FC;
        Fri, 10 Nov 2023 04:59:55 -0800 (PST)
Received: from e126645.arm.com (unknown [10.57.82.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C25FB3F7C5;
        Fri, 10 Nov 2023 04:59:08 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/fair: Use all little CPUs for CPU-bound workload
Date:   Fri, 10 Nov 2023 13:59:02 +0100
Message-Id: <20231110125902.2152380-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running n CPU-bound tasks on an n CPUs platform with asymmetric CPU
capacity might result in a task placement where two tasks run on a
big CPU and none on a little CPU. This placement could be more optimal
by using all CPUs.

Testing platform:
Juno-r2:
- 2 big CPUs (1-2), maximum capacity of 1024
- 4 little CPUs (0,3-5), maximum capacity of 383

Testing workload ([1]):
Spawn 6 CPU-bound tasks. During the first 100ms (step 1), each tasks
is affine to a CPU, except for:
- one little CPU which is left idle.
- one big CPU which has 2 tasks affine.
After the 100ms (step 2), remove the cpumask affinity.

Before patch:
During step 2, the load balancer running from the idle CPU tags sched
domains as:
- little CPUs: 'group_has_spare'. Indeed, 3 CPU-bound tasks run on a
  4 CPUs sched-domain, and the idle CPU provides enough spare
  capacity.
- big CPUs: 'group_overloaded'. Indeed, 3 tasks run on a 2 CPUs
  sched-domain, so the following path is used:
  group_is_overloaded()
  \-if (sgs->sum_nr_running <= sgs->group_weight) return true;

  The following path which would change the migration type to
  'migrate_task' is not taken:
  calculate_imbalance()
  \-if (env->idle != CPU_NOT_IDLE && env->imbalance == 0)
  as the local group has some spare capacity, so the imbalance
  is not 0.

The migration type requested is 'migrate_util' and the busiest
runqueue is the big CPU's runqueue having 2 tasks (each having a
utilization of 512). The idle little CPU cannot pull one of these
task as its capacity is too small for the task. The following path
is used:
detach_tasks()
\-case migrate_util:
  \-if (util > env->imbalance) goto next;

After patch:
When the local group has spare capacity and the busiest group is at
least tagged as 'group_fully_busy', if the local group has more CPUs
than CFS tasks and the busiest group more CFS tasks than CPUs,
request a 'migrate_task' type migration.

Improvement:
Running the testing workload [1] with the step 2 representing
a ~10s load for a big CPU:
Before patch: ~19.3s
After patch: ~18s (-6.7%)

The issue only happens at the DIE level on platforms able to have
'migrate_util' migration types, i.e. no DynamIQ systems where
SD_SHARE_PKG_RESOURCES is set.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df348aa55d3c..5a215c96d420 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10495,6 +10495,23 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			env->imbalance = max(local->group_capacity, local->group_util) -
 					 local->group_util;
 
+			/*
+			 * On an asymmetric system with CPU-bound tasks, a
+			 * migrate_util balance might not be able to migrate a
+			 * task from a big to a little CPU, letting a little
+			 * CPU unused.
+			 * If local has an empty CPU and busiest is overloaded,
+			 * balance one task with a migrate_task migration type
+			 * instead.
+			 */
+			if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+			    local->sum_nr_running < local->group_weight &&
+			    busiest->sum_nr_running > busiest->group_weight) {
+				env->migration_type = migrate_task;
+				env->imbalance = 1;
+				return;
+			}
+
 			/*
 			 * In some cases, the group's utilization is max or even
 			 * higher than capacity because of migrations but the
-- 
2.25.1

