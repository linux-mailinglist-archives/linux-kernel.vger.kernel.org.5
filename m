Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDAE7AE4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjIZFLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjIZFLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:11:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03A7101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705073; x=1727241073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8T7odWEBQZYn0UfnTi3NP5ddYKHmElS4lKfMfotAh8=;
  b=fmYkfuWFwKxuQV4DtoDGtSJan1ISGhN37UC+wQZpT1a2owDOVViw1Bhs
   cnhWVcfDSlgFmdeGj17vvuKXMAnrIPgzwoiFy12JlLxMJTSdGpAap/QMJ
   YcAOwV/0MSJQvZvzitKQPW16ExJa5RqiTdQ3TDiOF96Q8nRtBTC+4Ynr8
   Da653debpiNSNEhVTWEReRHjxv6hm6bZ6JTt2frh25cpDFlW7PzrdPT8F
   1Zlyb/2Z2TuXjrqcbVql0wfgh8hBtejIYZdB/QfaT9yeX1BRekb5mQhaF
   vDj+h7BUXWWtJv36udDMJ8P7IFlEf+Kjqaw2MgXLZ8KSMNF+nVxQKXfE1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366545731"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="366545731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872368066"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="872368066"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2023 22:11:08 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] sched/fair: Record the short sleeping time of a task
Date:   Tue, 26 Sep 2023 13:11:02 +0800
Message-Id: <b17a3db703494bdae8492843f7303c13b0dbd0fc.1695704179.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1695704179.git.yu.c.chen@intel.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During task wakeup, the wakee firstly checks if its previous
running CPU is idle. If yes, choose that CPU as its first
choice. However, in most cases, the wakee's previous CPU
could be chosen by someone else, which breaks the cache
locality.

Proposes a mechanism to reserve the task's previous
CPU for a short while. In this reservation period, other
tasks are not allowed to pick that CPU until a timeout.
The reservation period is defined as the average short
sleep time of the task. To be more specific, it is the
time delta between this task being dequeued and enqueued.
Only the sleep time shorter than sysctl_sched_migration_cost
will be recorded. If the sleep time is longer than
sysctl_sched_migration_cost, give the reservation period
a penalty by shrinking it to half. In this way, the 'burst'
sleeping time of the task is honored, meanwhile, if that
task becomes a long-sleeper, the reservation time of that
task is shrunk to reduce the impact on task wakeup.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/fair.c   | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index dc37ae787e33..4a0ac0276384 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -561,6 +561,9 @@ struct sched_entity {
 	u64				vruntime;
 	s64				vlag;
 	u64				slice;
+	u64				prev_dequeue_time;
+	/* the reservation period of this task during wakeup */
+	u64				sis_rsv_avg;
 
 	u64				nr_migrations;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0877878bcdb..297b9470829c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6456,6 +6456,24 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	u64 last_dequeue = p->se.prev_dequeue_time;
+	u64 now = sched_clock_cpu(task_cpu(p));
+
+	/*
+	 * If the task is a short-sleepting task, there is no need
+	 * to migrate it to other CPUs. Estimate the average short sleeping
+	 * time of the wakee. This sleep time is used as a hint to reserve
+	 * the dequeued task's previous CPU for a short while. During this
+	 * reservation period, select_idle_cpu() prevents other wakees from
+	 * choosing this CPU. This could bring a better cache locality.
+	 */
+	if ((flags & ENQUEUE_WAKEUP) && last_dequeue && cpu_online(task_cpu(p)) &&
+	    now > last_dequeue) {
+		if (now - last_dequeue < sysctl_sched_migration_cost)
+			update_avg(&p->se.sis_rsv_avg, now - last_dequeue);
+		else
+			p->se.sis_rsv_avg >>= 1;
+	}
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6550,6 +6568,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	u64 now;
 
 	util_est_dequeue(&rq->cfs, p);
 
@@ -6611,6 +6630,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+	now = sched_clock_cpu(cpu_of(rq));
+	p->se.prev_dequeue_time = task_sleep ? now : 0;
 }
 
 #ifdef CONFIG_SMP
-- 
2.25.1

