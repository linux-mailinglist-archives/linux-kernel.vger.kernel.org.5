Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6F767FE1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjG2OBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjG2OBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:01:08 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Jul 2023 07:01:07 PDT
Received: from sxb1plsmtpa01-09.prod.sxb1.secureserver.net (sxb1plsmtpa01-09.prod.sxb1.secureserver.net [188.121.53.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019731707
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 07:01:06 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id PkO0qJaTmd2niPkO3qO8D4; Sat, 29 Jul 2023 06:53:40 -0700
X-CMAE-Analysis: v=2.4 cv=Jax672GV c=1 sm=1 tr=0 ts=64c519e5
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17 a=j-LfP5YGAAAA:8
 a=Ni_nvw8SZd987JkjuKUA:9 a=pci6KG57UX3UzFLC8IW4:22
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, jiangshanlai@gmail.com, peterz@infradead.org
Subject: [RFC PATCH 1/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Sat, 29 Jul 2023 14:53:33 +0100
Message-Id: <20230729135334.566138-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230729135334.566138-1-atomlin@atomlin.com>
References: <20230729135334.566138-1-atomlin@atomlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHMW2asXrhdKbVG7RHnaPmtF0hWKkilp+9ztc8Mc21IXu2C7qnb9mNoZzhAiIaHq+I0a4jm+Gu4RhsDruM/P97xNIRIaVoUpqQqqNT20KkGPxMlMB+wE
 wtnfQB9ADGcQvj2CyXC9hknYGChNVCW9tcAgPkeL3kEy5BoMiJNtd73LoaQiMvG5ECuphwm0uMCiQ+SiD05aQI0HO9l8qe2L4yzmfkQDxBgxobSN4W/W02NI
 d1Qq3FCnQLJIZyOBL4gMFraxZiVUJXrzE/tmAIyI2+I=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel does not provide a way to differentiate between a
kworker and a rescue kworker for user-mode.
From user-mode, one can establish if a task is a kworker by testing for
PF_WQ_WORKER in a specified task's flags bit mask (or bitmap) via
/proc/[PID]/stat. Indeed, one can examine /proc/[PID]/stack and search
for the function namely "rescuer_thread". This is only available to the
root user.

It can be useful to identify a rescue kworker since their CPU affinity
cannot be modified and their initial CPU assignment can be safely ignored.
Furthermore, a workqueue that was created with WQ_MEM_RECLAIM and
WQ_SYSFS the cpumask file is not applicable to the rescue kworker.
By design a rescue kworker should run anywhere.

This patch introduces PF_WQ_RESCUE_WORKER and ensures it is set and
cleared appropriately.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/sched.h |  2 +-
 kernel/workqueue.c    | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 609bde814cb0..039fcf8d9ed6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1734,7 +1734,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_WQ_RESCUE_WORKER	0x00010000	/* I am a rescue workqueue worker */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 02a8f402eeb5..6d38d714b72b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2665,13 +2665,18 @@ static void process_scheduled_works(struct worker *worker)
 	}
 }
 
-static void set_pf_worker(bool val)
+static void set_pf_worker_and_rescuer(bool worker, bool rescue)
 {
 	mutex_lock(&wq_pool_attach_mutex);
-	if (val)
+	if (worker) {
 		current->flags |= PF_WQ_WORKER;
-	else
+		if (rescue)
+			current->flags |= PF_WQ_RESCUE_WORKER;
+	} else {
 		current->flags &= ~PF_WQ_WORKER;
+		if (rescue)
+			current->flags &= ~PF_WQ_RESCUE_WORKER;
+	}
 	mutex_unlock(&wq_pool_attach_mutex);
 }
 
@@ -2693,14 +2698,14 @@ static int worker_thread(void *__worker)
 	struct worker_pool *pool = worker->pool;
 
 	/* tell the scheduler that this is a workqueue worker */
-	set_pf_worker(true);
+	set_pf_worker_and_rescuer(true, false);
 woke_up:
 	raw_spin_lock_irq(&pool->lock);
 
 	/* am I supposed to die? */
 	if (unlikely(worker->flags & WORKER_DIE)) {
 		raw_spin_unlock_irq(&pool->lock);
-		set_pf_worker(false);
+		set_pf_worker_and_rescuer(false, false);
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
@@ -2804,7 +2809,7 @@ static int rescuer_thread(void *__rescuer)
 	 * Mark rescuer as worker too.  As WORKER_PREP is never cleared, it
 	 * doesn't participate in concurrency management.
 	 */
-	set_pf_worker(true);
+	set_pf_worker_and_rescuer(true, true);
 repeat:
 	set_current_state(TASK_IDLE);
 
@@ -2903,7 +2908,7 @@ static int rescuer_thread(void *__rescuer)
 
 	if (should_stop) {
 		__set_current_state(TASK_RUNNING);
-		set_pf_worker(false);
+		set_pf_worker_and_rescuer(false, true);
 		return 0;
 	}
 
-- 
2.39.1

