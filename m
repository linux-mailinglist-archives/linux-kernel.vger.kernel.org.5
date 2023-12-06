Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812C806A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377137AbjLFJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjLFJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:00:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5756C1048D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:00:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B29F139F;
        Wed,  6 Dec 2023 01:01:38 -0800 (PST)
Received: from e126645.nice.arm.com (e126645.nice.arm.com [10.34.100.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88BD73F762;
        Wed,  6 Dec 2023 01:00:50 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Qais Yousef <qyousef@layalina.io>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3] sched/fair: Use all little CPUs for CPU-bound workload
Date:   Wed,  6 Dec 2023 10:00:43 +0100
Message-Id: <20231206090043.634697-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running n CPU-bound tasks on an n CPUs platform:
- with asymmetric CPU capacity
- not being a DynamIq system (i.e. having a PKG level sched domain
  without the SD_SHARE_PKG_RESOURCES flag set)
might result in a task placement where two tasks run on a big CPU
and none on a little CPU. This placement could be more optimal by
using all CPUs.

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
- little CPUs: 'group_has_spare'. Cf. group_has_capacity() and
  group_is_overloaded(), 3 CPU-bound tasks run on a 4 CPUs
  sched-domain, and the idle CPU provides enough spare capacity
  regarding the imbalance_pct
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
As the number of failed balancing attempts grows (with
'nr_balance_failed'), progressively make it easier to migrate
a big task to the idling little CPU. A similar mechanism is
used for the 'migrate_load' migration type.

Improvement:
Running the testing workload [1] with the step 2 representing
a ~10s load for a big CPU:
Before patch: ~19.3s
After patch: ~18s (-6.7%)

Similar issue reported at:
https://lore.kernel.org/lkml/20230716014125.139577-1-qyousef@layalina.io/

v1:
https://lore.kernel.org/all/20231110125902.2152380-1-pierre.gondois@arm.com/
v2:
https://lore.kernel.org/all/20231124153323.3202444-1-pierre.gondois@arm.com/

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

Notes:
    v2:
    - Used Vincent's approach.
    v3:
    - Updated commit message.
    - Added Reviewed-by tags

 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..9481b8cff31b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9060,7 +9060,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);
 
-			if (util > env->imbalance)
+			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= util;
-- 
2.25.1

