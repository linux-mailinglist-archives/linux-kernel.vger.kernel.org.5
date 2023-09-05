Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF5792CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjIERw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjIERwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:52:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C422DFA1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1693933807;
        bh=nJEWOy4chE35FY+gum1RChzm+zavB/1iZGw4YSf1ONA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQZh80LQWZlqdZ8fW7AiGYy/He4V5P1DvVTXNLoLXAYK8Id8oOe9hb9YMVKKwX0vi
         Rw5CQhWIpiY1pcRlLki9qeM/SHhde/KF5QqGh8tv3zmokIr7tM/zDR+zuIyuvTnhNr
         aHJ6xya77s1jnpgdTUYc8ZF35ndbcl6oFO+waM1J2yDDblZEEzKccWWhcyGNyn1j3V
         6F4GSQynMDQsTBlorXj5z91aWTBIuZlfjT6bJDxDe9E2RgwZXvloDC282fOOavgvvP
         cUtWxanzKkjit0eOGwjMbLr7dXt6IP4WOI3Z7x6G4J4Jg5RkaJP7vLGcsl7eFSeAuH
         qXzg57zHISQ8A==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RgBp70jCWz1N2m;
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
Subject: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per task
Date:   Tue,  5 Sep 2023 13:11:04 -0400
Message-Id: <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
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

Rate limit migrations to 1 migration per 2 milliseconds per task. On a
kernel with EEVDF scheduler (commit b97d64c722598ffed42ece814a2cb791336c6679),
this speeds up hackbench from 62s to 45s on AMD EPYC 192-core (over 2 sockets).

This results in the following benchmark improvements:

        hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

from 62s to 45s. (27% speedup))

And similarly with perf bench:

        perf bench sched messaging -g 32 -p -t -l 100000

from 13.0s to 9.5s (26% speedup)

I have noticed that in order to observe the speedup, the workload needs
to keep the CPUs sufficiently busy to cause runqueue lock contention,
but not so busy that they don't go idle. This can be explained by the
fact that idle CPUs are a preferred target for task wakeup runqueue
selection, and therefore having idle cpus causes more migrations, which
triggers more remote wakeups. For both the hackbench and the perf bench
sched messaging benchmarks, the scale of the workload can be tweaked by
changing the number groups.

This was developed as part of the investigation into a weird regression
reported by AMD where adding a raw spinlock in the scheduler context
switch accelerated hackbench. It turned out that changing this raw
spinlock for a loop of 10000x cpu_relax within do_idle() had similar
benefits.

This patch results from the observation that the common effect of the
prior approaches that succeeded in speeding up this workload was to
diminish the number of migrations from 7.5k migrations/s to 1.5k
migrations/s.

This patch shows similar speedup on a 6.4.4 kernel with the CFS
scheduler.

With this patch applied, the "skip queued wakeups only when L2 is
shared" patch [1] brings the hackbench benchmark to 41s (34% speedup
from baseline), but the the "ratelimit update to tg->load_avg" patch
from Aaron Lu [2] does not seem to offer any speed up.

The values "1 migration" and the 2ms window size were determined
empirically with the hackbench benchmark on the targeted hardware.

I would be interested to hear feedback about performance impact of this
patch (improvement or regression) on other workloads and hardware,
especially for Intel CPUs.

Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/lkml/f6dc1652-bc39-0b12-4b6b-29a2f9cd8484@amd.com/
Link: https://lore.kernel.org/lkml/20230822113133.643238-1-mathieu.desnoyers@efficios.com/ [1]
Link: https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/ [2]
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
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 14 ++++++++++++++
 kernel/sched/sched.h  |  2 ++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..1111d04255cc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -564,6 +564,8 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
+	u64				next_migration_time;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 479db611f46e..0d294fce261d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4510,6 +4510,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
 	p->se.slice			= sysctl_sched_base_slice;
+	p->se.next_migration_time	= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d92da2d78774..24ac69913005 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -960,6 +960,14 @@ int sched_update_scaling(void)
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
+static bool should_migrate_task(struct task_struct *p, int prev_cpu)
+{
+	/* Rate limit task migration. */
+	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
+	       return false;
+	return true;
+}
+
 /*
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
@@ -7897,6 +7905,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
+	if (want_affine && !should_migrate_task(p, prev_cpu))
+		return prev_cpu;
+
 	rcu_read_lock();
 	for_each_domain(cpu, tmp) {
 		/*
@@ -7944,6 +7955,9 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
 	struct sched_entity *se = &p->se;
 
+	/* Rate limit task migration. */
+	se->next_migration_time = sched_clock_cpu(new_cpu) + SCHED_MIGRATION_RATELIMIT_WINDOW;
+
 	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cf54fe338e23..c9b1a5976761 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -104,6 +104,8 @@ struct cpuidle_state;
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
 
+#define SCHED_MIGRATION_RATELIMIT_WINDOW	2000000		/* 2 ms */
+
 extern __read_mostly int scheduler_running;
 
 extern unsigned long calc_load_update;
-- 
2.39.2

