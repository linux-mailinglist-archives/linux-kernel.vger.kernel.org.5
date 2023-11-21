Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B37F2686
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjKUHlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjKUHk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:40:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745B497
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700552454; x=1732088454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kDE9oNZ7PjL2CqLOzbBkD7BOUp0VBCVrH28Nu10oP9c=;
  b=EIh9LpPqo14pZR/q4qYTKUGmDwHxejQX/57dKeEjJBuxmlNLD4ZoUVPO
   DeqoewJunhpyHnV9GflEpz5UHbkDhJa+bEx5RqUfZ06+ypbTjnl1BtlIK
   tFAbbcl5VLTFFSZZwjFG7SQTMVy67DWAUhNETn4ozPGOGc1ZFxBH5xd4F
   T2ZLM0Zb7knlpF5hkKPPIAGSS2SlFbfn1rHjZ2SlXKcH1PCS1E648AOep
   4rK03qSXKudicczEf+X3J6pJetQdLCTU7eALB2gaIIoI5J7QHJhyPgG4C
   s+cGZagOJimnRHeJ9lgcy7FT5V4WOPrDXevsKeLdZ3FQMfFXF6G3zVCPX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376821688"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376821688"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:40:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884101994"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="884101994"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2023 23:40:39 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 1/3] sched/fair: Record the task sleeping time as the cache hot duration
Date:   Tue, 21 Nov 2023 15:39:40 +0800
Message-Id: <d42d4c0d0eb0f411084be382dc3a1d21ebb94b83.1700548379.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700548379.git.yu.c.chen@intel.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache hot duration is calculated by the average sleeping
time of a task, which is the time delta between the task
being dequeued and enqueued.

The cache hot duration of a task is introduced to describe
how soon this dequeue task could be woken up. During this
cache hot period, the task's previous CPU is regarded as
still cache-hot for the task. This information will be used
by SIS_CACHE to improve cache locality for short-sleeping tasks.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/fair.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d258162deb0..7d0fafd29345 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1347,6 +1347,10 @@ struct task_struct {
 	struct callback_head		cid_work;
 #endif
 
+	u64				last_dequeue_time;
+	u64				avg_hot_dur;	/* Average cache hot duration */
+	int				last_dequeue_cpu;
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	/* Cache last used pipe for splice(): */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53e7bf2ccc44..672616503e35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6667,6 +6667,36 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	u64 last_dequeue = p->last_dequeue_time;
+
+	if ((flags & ENQUEUE_WAKEUP) && last_dequeue &&
+	    cpu_online(p->last_dequeue_cpu)) {
+		/*
+		 * The enqueue task_cpu(p) has already been assigned
+		 * with a new one. Need to calculate the task's sleeping
+		 * time based on its previous running CPU.
+		 */
+		u64 now = sched_clock_cpu(p->last_dequeue_cpu);
+
+		/*
+		 * Record the task's short sleep time. This sleep time
+		 * indicates how soon this task might be woken up again.
+		 * The task's previous running CPU is regarded as cache-hot
+		 * in the sleep time. So, define the average sleep time of
+		 * the task as its cache-hot duration. The SIS could leverage
+		 * the cache-hot duration for better idle CPU selection.
+		 * This improves cache locality for short-sleeping tasks.
+		 *
+		 * If the sleep time is longer than sysctl_sched_migration_cost,
+		 * give the cache hot duration a penalty by cutting it to half.
+		 */
+		if (now > last_dequeue) {
+			if (now - last_dequeue < sysctl_sched_migration_cost)
+				update_avg(&p->avg_hot_dur, now - last_dequeue);
+			else
+				p->avg_hot_dur >>= 1;
+		}
+	}
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6821,6 +6851,15 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
+
+	if (task_sleep) {
+		p->last_dequeue_time = sched_clock_cpu(cpu_of(rq));
+		p->last_dequeue_cpu = cpu_of(rq);
+	} else {
+		/* 0 indicates the dequeue is not caused by sleep */
+		p->last_dequeue_time = 0;
+	}
+
 	hrtick_update(rq);
 }
 
-- 
2.25.1

