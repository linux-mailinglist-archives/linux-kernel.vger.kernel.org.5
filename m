Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5579A17F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjIKCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjIKCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:50:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0CFD2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694400608; x=1725936608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4mZq0LFRLpF/Eewsf5OhQTqbdCfat91HMFkfFZr2ok=;
  b=Nbjfm/mQdQ6Rsutu/Tnty/64bJA5TG2OVNO3cD0LpA++BuApVGPFbwfg
   7lwGn4HuurygPrqBtjD1ZFawg71mMPlmoeBQXfHxJZnRL/9g35FlQWUXY
   m2w/xe7WleeeV4JKjBlo3Q7oix9vo5lGD+SCH4plBVQTefnVqnAxc0BXF
   6Vjqmocr1QzsMTQlmTrM1OrmLQtQK7tT7VN5YxtPRjKvtoZOB9CvRgRLL
   ViFmN/mI3727p+Oa5BVO5gM2+kfzxJjxDLNu0pFOIFNqTWMXf2XwMWrYL
   J+Ek2WIU796YYFQvYxEiFgR6lWlGTb07KdysT4CdQ88VElj29Qel13mti
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381781757"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="381781757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 19:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="719848025"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="719848025"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2023 19:49:59 -0700
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 1/2] sched/fair: Record the average sleep time of a task
Date:   Mon, 11 Sep 2023 10:49:41 +0800
Message-Id: <d4cf4b5d8d166f66695748405a449797b514610e.1694397335.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1694397335.git.yu.c.chen@intel.com>
References: <cover.1694397335.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a requirement to have the information on how
long a task sleeps. This information can be used for
better task placement that, the short sleeping task
can be woken up on its previous idle easier. The
optimization will be introduced in the next patch.

Define the sleep time of the task as:
The time delta between this task was dequeued and enqueued.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h |  3 +++
 kernel/sched/fair.c   | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 177b3f3676ef..c11879468027 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -561,6 +561,9 @@ struct sched_entity {
 	u64				vruntime;
 	s64				vlag;
 	u64				slice;
+	u64				prev_sleep_time;
+	/* average sleep duration of a task */
+	u64				sleep_avg;
 
 	u64				nr_migrations;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b7445cd5af9..e20f50726ab8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6457,6 +6457,20 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
+	u64 last_sleep = p->se.prev_sleep_time;
+
+	/*
+	 * Calculate the average sleep time of the wakee.
+	 * Use wakee's previous CPU's clock to get the
+	 * delta. The previous CPU should be online, otherwise
+	 * the sleep time could be larger than expected(the clock
+	 * of the offline previous CPU is paused). Check if there
+	 * is a sched_clock() reset on previous CPU due to suspend/resume.
+	 */
+	if ((flags & ENQUEUE_WAKEUP) && last_sleep && cpu_online(task_cpu(p)) &&
+	    sched_clock_cpu(task_cpu(p)) > last_sleep)
+		update_avg(&p->se.sleep_avg,
+			   sched_clock_cpu(task_cpu(p)) - last_sleep);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6551,6 +6565,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_sleep = flags & DEQUEUE_SLEEP;
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	u64 now;
 
 	util_est_dequeue(&rq->cfs, p);
 
@@ -6612,6 +6627,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
+	now = sched_clock_cpu(cpu_of(rq));
+	p->se.prev_sleep_time = task_sleep ? now : 0;
 }
 
 #ifdef CONFIG_SMP
-- 
2.25.1

