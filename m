Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD467F2689
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjKUHlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjKUHlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:41:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13C121
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700552464; x=1732088464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KjPJrAVxXZh2V7iwRKhLhm1MJKfGXzVaYnYYF6gMzhg=;
  b=mN4XMyMyr0/FtqZ9tllMoXVAby60n9EJ7zHwRnSbZwS1GJyuJoCZ+6mv
   oExDxf5bPL5t7IQk+W3R9wy+eAELogtzTGRUwi+bMazCOuqO1ZplOZTKP
   qsoUXa3N2Xkcs4THVw5Pwek+gUYEifa7PxD0N2wxHFFfUEbKcFBcygqSG
   O5csuxszB+2LvkgZQ/8CQObveHU56fbpz54Xrz0oBRHGTN2/JSlv+6FKh
   Uj3DBGC8VPnFjaEnO51/pi96qev+gOPfs/ljfZgxKVLBT8O8NiEeCpyKo
   ikjzt5GG3DM1Z/pOwVYfkY7sCwZxbtVFqXO2YS0gTsyrZ/L+lLvpQXU4w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4978256"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4978256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836972249"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="836972249"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 23:40:59 -0800
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
Subject: [PATCH v2 2/3] sched/fair: Calculate the cache-hot time of the idle CPU
Date:   Tue, 21 Nov 2023 15:39:54 +0800
Message-Id: <6dccbf0f54cc4ee068a157b9eebfb4b5fa3cc4af.1700548379.git.yu.c.chen@intel.com>
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

When a CPU is about to become idle due to task dequeue, uses
the dequeued task's average sleep time to set the cache
hot timeout of this idle CPU. This information can facilitate
SIS to skip the cache-hot idle CPU and scan for the next
cache-cold one. When that task is woken up again, it can choose
its previous CPU and reuses its hot-cache.

This is a preparation for the next patch to introduce SIS_CACHE
based task wakeup.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++++-
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 672616503e35..c309b3d203c0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6853,8 +6853,17 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	util_est_update(&rq->cfs, p, task_sleep);
 
 	if (task_sleep) {
-		p->last_dequeue_time = sched_clock_cpu(cpu_of(rq));
+		u64 now = sched_clock_cpu(cpu_of(rq));
+
+		p->last_dequeue_time = now;
 		p->last_dequeue_cpu = cpu_of(rq);
+
+#ifdef CONFIG_SMP
+		/* this rq becomes idle, update its cache hot timeout */
+		if (sched_feat(SIS_CACHE) && !rq->nr_running &&
+		    p->avg_hot_dur)
+			rq->cache_hot_timeout = max(rq->cache_hot_timeout, now + p->avg_hot_dur);
+#endif
 	} else {
 		/* 0 indicates the dequeue is not caused by sleep */
 		p->last_dequeue_time = 0;
@@ -7347,6 +7356,25 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 
 #endif /* CONFIG_SCHED_SMT */
 
+/*
+ * Return true if the idle CPU is cache-hot for someone,
+ * return false otherwise.
+ */
+static __maybe_unused bool cache_hot_cpu(int cpu, int *hot_cpu)
+{
+	if (!sched_feat(SIS_CACHE))
+		return false;
+
+	if (sched_clock_cpu(cpu) >= cpu_rq(cpu)->cache_hot_timeout)
+		return false;
+
+	/* record the first cache hot idle cpu as the backup */
+	if (*hot_cpu == -1)
+		*hot_cpu = cpu;
+
+	return true;
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3ddf84de430..0af282712cd1 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
  */
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_CACHE, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..191ed62ef06d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1083,6 +1083,7 @@ struct rq {
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
+	u64			cache_hot_timeout;
 
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
-- 
2.25.1

