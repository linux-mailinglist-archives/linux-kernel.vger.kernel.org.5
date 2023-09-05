Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20457792E08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjIES6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIES6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:58:19 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F31989
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693933807;
        bh=bJBuLXFimTGj49hTckLdOskqDDIUXbyhVbxfarS8M5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBPgEzwRpwCorUtytaYsiQ3CewU13C7chO/5voaQ03mCsje48/Gnvu9A949eiyov/
         L5MPTprTW/YYnjoed/iQHgQp46IarGLv4X8vJ1kaiBR9LlIFffK1ZPoiHL6BzojTjU
         0KCnQUKfjk6jVpweHiIuws67/Vl1wGZwR97YA4xrssS6+7ul1jkoRr3Bg7eu0tqlEN
         /FLjeGGmv1TNDLqZS48Cabthv63G8VHUW3kO0FG2TmckQDfHfVb7lyy5GUoTpIxHtx
         JXa1qlrMmW8ozf5tY2e0k9g+E0+JALuBSbWjTa9S423zAYpP4PQRIfQKayxMJwvl9e
         14G8sfI55yhkA==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgBp7376kz1N2n;
        Tue,  5 Sep 2023 13:10:07 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Subject: [RFC PATCH 2/2] sched: Implement adaptative rate limiting of task migrations
Date:   Tue,  5 Sep 2023 13:11:05 -0400
Message-Id: <20230905171105.1005672-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a task migration quota (initially 10) within a 2ms window for
each task. Whenever a task reaches its quota, the following affine
wakeups keep the task on its previous CPU for the rest of the window.
When the migration quota has been entirely used within a window, the
available quota is divided by 2 for the next window, down to a minimum
of 1 per window. When the available quota is not entirely used within a
window, it is replenished by adding 1 per window.

One advantage of this approach is to leave extra room for sporadic
migration bursts, limiting the migration rate more strictly as tasks
repeatedly bust their quota.

Another advantage of this approach is to reduce the number of
sched_clock calls on the wakeup path when tasks are below their quota.

The resulting benchmarks are similar to those achieved with the
non-adaptative approach for hackbench and perf bench sched messaging
workloads.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: Julien Desfossez <jdesfossez@digitalocean.com>
Cc: x86@kernel.org
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   |  2 ++
 kernel/sched/fair.c   | 36 +++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h  |  2 ++
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1111d04255cc..2190e59ebc99 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -565,6 +565,8 @@ struct sched_entity {
 	u64				nr_migrations;
 
 	u64				next_migration_time;
+	int				nr_migrations_per_window;
+	int				quota_migrations_per_window;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d294fce261d..834e37231c36 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4511,6 +4511,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.vlag			= 0;
 	p->se.slice			= sysctl_sched_base_slice;
 	p->se.next_migration_time	= 0;
+	p->se.nr_migrations_per_window	= 0;
+	p->se.quota_migrations_per_window = SCHED_MIGRATION_QUOTA;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24ac69913005..e2f4c30483a1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -963,9 +963,11 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 static bool should_migrate_task(struct task_struct *p, int prev_cpu)
 {
 	/* Rate limit task migration. */
-	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
-	       return false;
-	return true;
+	if (p->se.nr_migrations_per_window < p->se.quota_migrations_per_window)
+		return true;
+	if (sched_clock_cpu(prev_cpu) > p->se.next_migration_time)
+		return true;
+	return false;
 }
 
 /*
@@ -7946,6 +7948,31 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	return new_cpu;
 }
 
+static void migrate_task_ratelimit_fair(struct task_struct *p, int new_cpu)
+{
+	struct sched_entity *se = &p->se;
+	u64 now;
+
+	/* Rate limit task migration. */
+	now = sched_clock_cpu(task_cpu(p));
+	if (now < se->next_migration_time) {
+		se->nr_migrations_per_window++;
+		if (!sched_clock_stable())
+			se->next_migration_time += sched_clock_cpu(new_cpu) - now;
+	} else {
+		if (!sched_clock_stable())
+			now = sched_clock_cpu(new_cpu);
+		se->next_migration_time = now + SCHED_MIGRATION_RATELIMIT_WINDOW;
+		if (se->nr_migrations_per_window >= se->quota_migrations_per_window)
+			se->quota_migrations_per_window = max(1, se->quota_migrations_per_window >> 1);
+		else
+			se->quota_migrations_per_window =
+				min(SCHED_MIGRATION_QUOTA,
+				    se->quota_migrations_per_window + SCHED_MIGRATION_QUOTA_REPLENISH);
+		se->nr_migrations_per_window = 1;
+	}
+}
+
 /*
  * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
  * cfs_rq_of(p) references at time of call are still valid and identify the
@@ -7955,8 +7982,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	struct sched_entity *se = &p->se;
 
-	/* Rate limit task migration. */
-	se->next_migration_time = sched_clock_cpu(new_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW;
+	migrate_task_ratelimit_fair(p, new_cpu);
 
 	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c9b1a5976761..04529661976c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -105,6 +105,8 @@ struct cpuidle_state;
 #define TASK_ON_RQ_MIGRATING	2
 
 #define SCHED_MIGRATION_RATELIMIT_WINDOW	2000000		/* 2 ms */
+#define SCHED_MIGRATION_QUOTA			10
+#define SCHED_MIGRATION_QUOTA_REPLENISH		1
 
 extern __read_mostly int scheduler_running;
 
-- 
2.39.2

