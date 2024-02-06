Return-Path: <linux-kernel+bounces-54455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE484AF77
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151871C24726
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8B12AACF;
	Tue,  6 Feb 2024 08:01:17 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385C12AAC3
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206477; cv=none; b=L8AYMX7lkHGU6Dk6ywye/N9OiadeZl66hAxXrwY3flAxd9awXb3dWS5TqiHt4ZpxbllXZiHNLvfR7LZ/K1CLJwTQBEyV/u4Iz8Z9z2nwkkt/YvbhkVnChqOL1PUW7RRyskzUaT8Q32kbzqk2PUnyTMnvxkgF7v8MON29hqXpSrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206477; c=relaxed/simple;
	bh=fmhTYTwqZx8d+uKtvsowSz7QMkwruX8ClBH7swlZWZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q3R4y/AHmmylmTNFghvmJ3aZ3Y0mltJrZMzbH0Vjs6BnbUqeyydDoIfPBk0IEAy5uYCS6wfxbXVd7R4ZM5wPBMjIA8SDf/ie9qWPXij98g8pmo4NHCjv3L8Mq5mswjHl5nvwbfNzB4Gv0FaJdn9n3GnBT2dbytH2hUwvAlmINwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41680iiv065768;
	Tue, 6 Feb 2024 16:00:44 +0800 (+08)
	(envelope-from Yunlong.Xing@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TTbK24BmNz2SDHVM;
	Tue,  6 Feb 2024 16:00:38 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 6 Feb 2024 16:00:42 +0800
From: Yunlong Xing <yunlong.xing@unisoc.com>
To: <tj@kernel.org>, <jiangshanlai@gmail.com>, <yunlong.xing23@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <hongyu.jin@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <zhengxu.zhang@unisoc.com>
Subject: [PATCH] workqueue: Fix pool->nr_running type back to atomic
Date: Tue, 6 Feb 2024 16:00:24 +0800
Message-ID: <20240206080024.2373490-1-yunlong.xing@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 41680iiv065768

In CPU-hotplug test, when plug the core, set_cpus_allowed_ptr() restoring
the cpus_mask of the per-cpu worker may fail, the cpus_mask of the worker
remain wq_unbound_cpumask until the core hotpluged next time. so, workers
in the same per-cpu pool can run concurrently and change nr_running at the
 same time, atomic problem occur.

Crash ps info:
[RU]  PID: 19966    TASK: ffffff802a71a580  CPU: 6    COMMAND: "kworker/6:1"
[ID]  PID: 2620     TASK: ffffff80d451a580  CPU: 0    COMMAND: "kworker/6:2"

workqueue_online_cpu()
->rebind_workers()
  ->set_cpus_allowed_ptr()
  // restore cpus_mask failed
     kworker/6:2 cpus_mask is 0xFF
     worker enter idle

T1:kworker/6:1(CPU6)						T2:kworker/6:2(CPU0)

1:worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND)
  ->pool->nr_running++;  (1)

2:wq_worker_sleeping()
  ->pool->nr_running--;  (0)

3:wq_worker_running()						worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND)
  ->pool->nr_running++;  (1)                                    ->pool->nr_running++; (1)

//Two workers that running on two CPUs modify the nr_running at the same
time, atomic problems（race condition） may occur. the nr_running should
be 2, but in this case it is 1.

4:								worker_set_flags(worker, WORKER_PREP)
								->pool->nr_running--;  (0)

5:worker_set_flags(worker, WORKER_PREP)
  ->pool->nr_running--;  (-1)

The complete following debug log:

[70285.393470] wqdb kworker/6:1:19966 cpu6  pool 6 ffffff817f311900 nr_running++ is 1, by clr 264
[70285.393484] wqdb kworker/6:1:19966 cpu6  pool 6 ffffff817f311900 nr_running-- is 0, by sleep
[70285.399883] wqdb kworker/6:1:19966 cpu6  pool 6 ffffff817f311900 nr_running++ is 1, by run
[70285.399882] wqdb kworker/6:2:2620  cpu0  pool 6 ffffff817f311900 nr_running++ is 1, by clr 264
[70285.399894] wqdb kworker/6:2:2620  cpu0  pool 6 ffffff817f311900 nr_running-- is 0, by set 8
[70285.400013] wqdb kworker/6:1:19966 cpu6  pool 6 ffffff817f311900 nr_running-- is -1, by set 8
[70285.400017] wqdb kworker/6:1:19966 cpu6  pool 6 ffffff817f311900 nr_running_error is -1

Recover nr_running to the atomic variable type and use atomic method
where nr_running is accessed.

Fixes: bc35f7ef9628 ("workqueue: Convert the type of pool->nr_running to int")
Cc: stable@vger.kernel.org
Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
---
 kernel/workqueue.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..e74d9b83322c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -161,12 +161,10 @@ struct worker_pool {
 	bool			cpu_stall;	/* WD: stalled cpu bound pool */
 
 	/*
-	 * The counter is incremented in a process context on the associated CPU
-	 * w/ preemption disabled, and decremented or reset in the same context
-	 * but w/ pool->lock held. The readers grab pool->lock and are
-	 * guaranteed to see if the counter reached zero.
+	 * The workers associated the same CPU maybe running on different CPU,
+	 * so need use atomic_t.
 	 */
-	int			nr_running;
+	atomic_t		nr_running;
 
 	struct list_head	worklist;	/* L: list of pending works */
 
@@ -832,7 +830,7 @@ static bool work_is_canceling(struct work_struct *work)
  */
 static bool need_more_worker(struct worker_pool *pool)
 {
-	return !list_empty(&pool->worklist) && !pool->nr_running;
+	return !list_empty(&pool->worklist) && !atomic_read(&pool->nr_running);
 }
 
 /* Can I start working?  Called from busy but !running workers. */
@@ -844,7 +842,7 @@ static bool may_start_working(struct worker_pool *pool)
 /* Do I need to keep working?  Called from currently running workers. */
 static bool keep_working(struct worker_pool *pool)
 {
-	return !list_empty(&pool->worklist) && (pool->nr_running <= 1);
+	return !list_empty(&pool->worklist) && (atomic_read(&pool->nr_running) <= 1);
 }
 
 /* Do we need a new worker?  Called from manager. */
@@ -879,7 +877,7 @@ static inline void worker_set_flags(struct worker *worker, unsigned int flags)
 	/* If transitioning into NOT_RUNNING, adjust nr_running. */
 	if ((flags & WORKER_NOT_RUNNING) &&
 	    !(worker->flags & WORKER_NOT_RUNNING)) {
-		pool->nr_running--;
+		atomic_dec(&pool->nr_running);
 	}
 
 	worker->flags |= flags;
@@ -908,7 +906,7 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 	 */
 	if ((flags & WORKER_NOT_RUNNING) && (oflags & WORKER_NOT_RUNNING))
 		if (!(worker->flags & WORKER_NOT_RUNNING))
-			pool->nr_running++;
+			atomic_inc(&pool->nr_running);
 }
 
 /* Return the first idle worker.  Called with pool->lock held. */
@@ -951,7 +949,7 @@ static void worker_enter_idle(struct worker *worker)
 		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
 
 	/* Sanity check nr_running. */
-	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
+	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && atomic_read(&pool->nr_running));
 }
 
 /**
@@ -1262,7 +1260,7 @@ void wq_worker_running(struct task_struct *task)
 	 */
 	preempt_disable();
 	if (!(worker->flags & WORKER_NOT_RUNNING))
-		worker->pool->nr_running++;
+		atomic_inc(&worker->pool->nr_running);
 	preempt_enable();
 
 	/*
@@ -1313,7 +1311,7 @@ void wq_worker_sleeping(struct task_struct *task)
 		return;
 	}
 
-	pool->nr_running--;
+	atomic_dec(&pool->nr_running);
 	if (kick_pool(pool))
 		worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;
 
@@ -5418,7 +5416,7 @@ static void unbind_workers(int cpu)
 		 * an unbound (in terms of concurrency management) pool which
 		 * are served by workers tied to the pool.
 		 */
-		pool->nr_running = 0;
+		atomic_set(&pool->nr_running, 0);
 
 		/*
 		 * With concurrency management just turned off, a busy
-- 
2.25.1


