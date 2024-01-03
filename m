Return-Path: <linux-kernel+bounces-15262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED9822953
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5DE1C2304C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C661862B;
	Wed,  3 Jan 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beUiVz5c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244718623
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8E5C433C7;
	Wed,  3 Jan 2024 08:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704269345;
	bh=/P93iDWx0rUgDH9n+aFD3T8XY72jOetnP/Drn34JroI=;
	h=From:To:Cc:Subject:Date:From;
	b=beUiVz5cN9puQyNHLSi1W8HtLbj0mt8+Oe8KQOvTgF5f+hxaLd8Qn3fvvWREInjEB
	 yQrg1j/ItpNZLzHW369EOdoi8yPtgAQgl4Z3L9vD4EAincXAYH5fbcXEDr7NIEXtzg
	 A0b+2uXr9gxA/2Bdp62YyhZfaU/07rn+iCLZonqEGZTX7FeQy5gZVA5NoIArOBYegm
	 Tdi+UEJHpA1pOWeErT5W6JR5L7YW+rHQ0VFCouwGrNSfILL+c1OlXKLsL1pPAn8e4c
	 qJ7kQcYry1oFaN3ppL0uT9ghFec8T2ZjgNS6qZs1zA5TT6+9gOXGSFK1UWaJmiOMj/
	 15JMMtqnFU9MA==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: curuwang@tencent.com,
	Alex Shi <alexs@kernel.org>
Subject: [PATCH v2] sched/stat: correct the task blocking state
Date: Wed,  3 Jan 2024 16:10:42 +0800
Message-ID: <20240103081042.1549189-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
stopped the idle kthreads from contributing to the load average. However,
the idle state time still contributes to the blocked state time instead of
the sleep time. As a result, we cannot determine if a task is stopped due
to some reasons or if it is idle by its own initiative. 

Distinguishing between these two states would make the system state clearer
and provide us with an opportunity to use the 'D' state of a task as an
indicator of latency issues.

Originally-from: Curu Wong <curuwang@tencent.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
To: linux-kernel@vger.kernel.org
To: Valentin Schneider <vschneid@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Mel Gorman <mgorman@suse.de>
To: Ben Segall <bsegall@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 include/linux/sched.h   | 6 ++++++
 kernel/sched/deadline.c | 5 +++--
 kernel/sched/fair.c     | 5 +++--
 kernel/sched/rt.c       | 5 +++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..002f80291837 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -140,6 +140,12 @@ struct user_event_mm;
 #define is_special_task_state(state)				\
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
+/* blocked task is UNINTERRUPTIBLE but not NOLOAD */
+#define is_blocked_state(state)				\
+	((state) & TASK_UNINTERRUPTIBLE && (!((state) & TASK_NOLOAD)))
+
+#define is_idle_state(state)	(((state) & TASK_IDLE) == TASK_IDLE)
+
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 # define debug_normal_state_change(state_value)				\
 	do {								\
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..99d46affc2aa 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1566,11 +1566,12 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 		unsigned int state;
 
 		state = READ_ONCE(p->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		/* idle state still accounts into sleep */
+		if (state & TASK_INTERRUPTIBLE || is_idle_state(state))
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_state(state))
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..69506253aadf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1278,10 +1278,11 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 
 		/* XXX racy against TTWU */
 		state = READ_ONCE(tsk->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		/* idle state still accounts into sleep */
+		if (state & TASK_INTERRUPTIBLE || is_idle_state(state))
 			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_state(state))
 			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..dd0e381689f8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1371,11 +1371,12 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 		unsigned int state;
 
 		state = READ_ONCE(p->__state);
-		if (state & TASK_INTERRUPTIBLE)
+		/* idle state still accounts into sleep */
+		if (state & TASK_INTERRUPTIBLE || is_idle_state(state))
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_state(state))
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 	}
-- 
2.43.0


