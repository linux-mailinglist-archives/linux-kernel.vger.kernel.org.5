Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F61079E8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjIMNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbjIMNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9260519BB;
        Wed, 13 Sep 2023 06:11:12 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K1u9XhqGdD8iDt6tL76z5B6EdFl2w7DNvw3G7mMcyyk=;
        b=gXZA4wC/8jjGIu2jay+Kq0xN+4E6ykuHTuNO+Rg1WwzbX97+5oYVCNNJXj3NxR/jFvfYAy
        wbdUsLztKCiCxKmywvw5KUxkiutQzbIaykxQOK+sjlacglVDosE4IAbfQ2rmMQvqQgW5wo
        kMOZcyWS/g1olPmw5MfJ2PNgYS3n7N92lvnQexWQOIETCltTXbOp7DJn2hsZEmGybhDuba
        1kDnX5P/XkRUTYIf+ltRI3q98xPEFiU0Elo2N8Xnxb0agptb3w+ns5VVjSg1S+183LA2rP
        9wV0O20QO7qnm7fCr6pm/kNTf5Y5CEBF/Jwx0YcsWwXBVv58Md7Q7g+j4xZJ3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610671;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K1u9XhqGdD8iDt6tL76z5B6EdFl2w7DNvw3G7mMcyyk=;
        b=xxHBIZ6rFBE+itkgLDAvW6oAlw+r06NVIh9sGrZLL3cLRJC6kn5JWC0VTsekGILXD74yX+
        xDEkw6BIsSkqhoAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify tg_set_cfs_bandwidth()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067069.27769.2758619210925283697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6fb45460615358157a6d3c990e74f9c1395247e2
Gitweb:        https://git.kernel.org/tip/6fb45460615358157a6d3c990e74f9c1395247e2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:45:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:42 +02:00

sched: Simplify tg_set_cfs_bandwidth()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpu.h |  2 ++
 kernel/sched/core.c | 38 +++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a..f19f565 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -153,6 +153,8 @@ static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
 static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
+DEFINE_LOCK_GUARD_0(cpus_read_lock, cpus_read_lock(), cpus_read_unlock())
+
 #ifdef CONFIG_PM_SLEEP_SMP
 extern int freeze_secondary_cpus(int primary);
 extern void thaw_secondary_cpus(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3f4fb8..5d9f363 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10802,11 +10802,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
-	cpus_read_lock();
-	mutex_lock(&cfs_constraints_mutex);
+	guard(cpus_read_lock)();
+	guard(mutex)(&cfs_constraints_mutex);
+
 	ret = __cfs_schedulable(tg, period, quota);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	runtime_enabled = quota != RUNTIME_INF;
 	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
@@ -10816,39 +10817,38 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 */
 	if (runtime_enabled && !runtime_was_enabled)
 		cfs_bandwidth_usage_inc();
-	raw_spin_lock_irq(&cfs_b->lock);
-	cfs_b->period = ns_to_ktime(period);
-	cfs_b->quota = quota;
-	cfs_b->burst = burst;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	scoped_guard (raw_spinlock_irq, &cfs_b->lock) {
+		cfs_b->period = ns_to_ktime(period);
+		cfs_b->quota = quota;
+		cfs_b->burst = burst;
 
-	/* Restart the period timer (if active) to handle new period expiry: */
-	if (runtime_enabled)
-		start_cfs_bandwidth(cfs_b);
+		__refill_cfs_bandwidth_runtime(cfs_b);
 
-	raw_spin_unlock_irq(&cfs_b->lock);
+		/*
+		 * Restart the period timer (if active) to handle new
+		 * period expiry:
+		 */
+		if (runtime_enabled)
+			start_cfs_bandwidth(cfs_b);
+	}
 
 	for_each_online_cpu(i) {
 		struct cfs_rq *cfs_rq = tg->cfs_rq[i];
 		struct rq *rq = cfs_rq->rq;
-		struct rq_flags rf;
 
-		rq_lock_irq(rq, &rf);
+		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
-		rq_unlock_irq(rq, &rf);
 	}
+
 	if (runtime_was_enabled && !runtime_enabled)
 		cfs_bandwidth_usage_dec();
-out_unlock:
-	mutex_unlock(&cfs_constraints_mutex);
-	cpus_read_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
