Return-Path: <linux-kernel+bounces-14116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3385F821801
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20AA282112
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69D5677;
	Tue,  2 Jan 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfcmYcFy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292E53A5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 07:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDF6C433C8;
	Tue,  2 Jan 2024 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704180743;
	bh=OV5kQZVtgYNjmq8xkJXDaZLj5pV6ouoj+mekcsjkUbw=;
	h=From:To:Cc:Subject:Date:From;
	b=lfcmYcFy9H2YhEXtMCT30jydaiWMpym50FEYmk4ujJgEuOo82ndTjafV3Jwem+h6o
	 hrKzNvd67MsZbUwccQzsqVxe45tO2SVdL6tpbuoy/Z6aTjSDFeQf1NDy0odHpWgOvm
	 IjxOND1U5cuuFOyxnV3MvjaHwbrPtHH1wvY+JfvP+riFcgWv1v4eY4uk4kvNe3r3KP
	 mh9xPp45pOk46m+wFFgL0A2LCZJeSbh7ModG+D2fDaxGspJKuMuUTsPgZEgtRwVwdI
	 va9u9pzENaG1AxuTTxbaVsyprQyCkwn4jnZH/E/zvcRNuuAizLH2I09BgwrcUDt2uI
	 jJ8gPLcJmd3vg==
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
Subject: [PATCH] sched/tracing: correct the task blocking state
Date: Tue,  2 Jan 2024 15:33:51 +0800
Message-ID: <20240102073351.1527503-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
stopped the idle kthreads contribution to loadavg. Also task idle should
separated from blocked state too, otherwise we will get incorrect task
blocking state from event tracing sched:sched_stat_blocked.

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
 include/linux/sched.h   | 4 ++++
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..341e62255ea7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -140,6 +140,10 @@ struct user_event_mm;
 #define is_special_task_state(state)				\
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
 
+/* blocked task is UNINTERRUPTIBLE but not NOLOAD */
+#define is_blocked_task_state(state)				\
+	((state) & TASK_UNINTERRUPTIBLE && (!((state) & TASK_NOLOAD)))
+
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 # define debug_normal_state_change(state_value)				\
 	do {								\
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..b6afa596f071 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1570,7 +1570,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_task_state(state))
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_dl_rq(dl_rq)));
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7a3c63a2171..349b0c5104b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1281,7 +1281,7 @@ update_stats_dequeue_fair(struct cfs_rq *cfs_rq, struct sched_entity *se, int fl
 		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(tsk->stats.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_task_state(state))
 			__schedstat_set(tsk->stats.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..2fdf3d71428d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1375,7 +1375,7 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 			__schedstat_set(p->stats.sleep_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 
-		if (state & TASK_UNINTERRUPTIBLE)
+		if (is_blocked_task_state(state))
 			__schedstat_set(p->stats.block_start,
 					rq_clock(rq_of_rt_rq(rt_rq)));
 	}
-- 
2.43.0


