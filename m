Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46A77BC81
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHNPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjHNPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129A010DB;
        Mon, 14 Aug 2023 08:08:08 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMGiIB3ZRF9xDuzowmKuMGbuFtNeEa/dk8I9+QRM62A=;
        b=crm6U1Y1puA8N68rUT3sEX9cqlewdFVZZCBRq2kQaq148y6iT29NohOJBl3R4JHIw97woh
        7xHjXBayhMJk0NQ6r2W9ofkoLF7OEcAiReaWFOniBQ5nqt2iimWiIbAH0DttzvEUiw7Mbg
        e97CsAddUSTLIjegT3Gdvo5aoefxj0bEZOU/zvX3Ay3ML/Ifaxn0JAfz6udZTyWn3Aw3Me
        zG2Usu7G3Aul7UwVzJjMaZtJFROmUuySvRsOxWtjiy4Flml/EzC7OMEF28GsCM6N5hecsf
        TM+1B8Y3FcBMkRMEElHo9uvvhVwNsDabcRAxgS3sXMSCbVQZV7uy+et2T7FZSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMGiIB3ZRF9xDuzowmKuMGbuFtNeEa/dk8I9+QRM62A=;
        b=A/v8uHIc6YkhrKwX4WgWj9AyS0n/YfPYLmkYO4r+DX+PvdR7DsEfNOJZKJtSJ7fiNpVY+S
        IuudXucGLZYvuDCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify: migrate_swap_stop()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211811.964370836@infradead.org>
References: <20230801211811.964370836@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568621.27769.9047614343930343004.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5bb76f1ddf2a7dd98f5a89d7755600ed1b4a7fcd
Gitweb:        https://git.kernel.org/tip/5bb76f1ddf2a7dd98f5a89d7755600ed1b4a7fcd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:25 +02:00

sched: Simplify: migrate_swap_stop()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211811.964370836@infradead.org
---
 kernel/sched/core.c  | 23 +++++++----------------
 kernel/sched/sched.h | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e8a8e9..66478a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3433,7 +3433,6 @@ static int migrate_swap_stop(void *data)
 {
 	struct migration_swap_arg *arg = data;
 	struct rq *src_rq, *dst_rq;
-	int ret = -EAGAIN;
 
 	if (!cpu_active(arg->src_cpu) || !cpu_active(arg->dst_cpu))
 		return -EAGAIN;
@@ -3441,33 +3440,25 @@ static int migrate_swap_stop(void *data)
 	src_rq = cpu_rq(arg->src_cpu);
 	dst_rq = cpu_rq(arg->dst_cpu);
 
-	double_raw_lock(&arg->src_task->pi_lock,
-			&arg->dst_task->pi_lock);
-	double_rq_lock(src_rq, dst_rq);
+	guard(double_raw_spinlock)(&arg->src_task->pi_lock, &arg->dst_task->pi_lock);
+	guard(double_rq_lock)(src_rq, dst_rq);
 
 	if (task_cpu(arg->dst_task) != arg->dst_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (task_cpu(arg->src_task) != arg->src_cpu)
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
-		goto unlock;
+		return -EAGAIN;
 
 	__migrate_swap_task(arg->src_task, arg->dst_cpu);
 	__migrate_swap_task(arg->dst_task, arg->src_cpu);
 
-	ret = 0;
-
-unlock:
-	double_rq_unlock(src_rq, dst_rq);
-	raw_spin_unlock(&arg->dst_task->pi_lock);
-	raw_spin_unlock(&arg->src_task->pi_lock);
-
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9c5035c..c299a58 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2614,6 +2614,12 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
 #endif
 
+#define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)		\
+__DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__) \
+static inline class_##name##_t class_##name##_constructor(type *lock, type *lock2) \
+{ class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;	\
+  _lock; return _t; }
+
 #ifdef CONFIG_SMP
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
@@ -2743,6 +2749,16 @@ static inline void double_raw_lock(raw_spinlock_t *l1, raw_spinlock_t *l2)
 	raw_spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
 }
 
+static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+{
+	raw_spin_unlock(l1);
+	raw_spin_unlock(l2);
+}
+
+DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
+		    double_raw_lock(_T->lock, _T->lock2),
+		    double_raw_unlock(_T->lock, _T->lock2))
+
 /*
  * double_rq_unlock - safely unlock two runqueues
  *
@@ -2800,6 +2816,10 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 
 #endif
 
+DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
+		    double_rq_lock(_T->lock, _T->lock2),
+		    double_rq_unlock(_T->lock, _T->lock2))
+
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 
