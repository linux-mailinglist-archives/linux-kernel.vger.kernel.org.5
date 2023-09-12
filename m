Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D569D79CE68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjILKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjILKal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8051726;
        Tue, 12 Sep 2023 03:29:02 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iEujX5toaF9pezhF/bbHRVvwipV/jeRcb51TpsPRK+U=;
        b=DJ9ytuG7th25rPLKF57KrifS1Qp2+vEY4itK8tf/ujxzii2bJIrQJcecqs2ImsDM94Ncxj
        RBWm12jxn8gy+WNitKauRqI+QnlytgJvp5nm9PcD1cZ8i28vXUU/OdAHF+k9QAS7ykWslk
        +stmwOMLXlwnP2+YgurRmV9qQ+2AIdnhLt+oJB2sOMXO+/xhwj7lI/kBwWdXiIZjC55AvV
        foeFZM5iuK1j1NxtEutUNos6K2RQKRk27/wTnpip/d6zAb+m0CFjXhJS0Fskr2qBAQsx3K
        eQms6hKra1gBOlTrdbh1xVoovT539YavkSA1vaipMidm6+UwM65oA+Hnmm6pSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514540;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iEujX5toaF9pezhF/bbHRVvwipV/jeRcb51TpsPRK+U=;
        b=Ei1vaT7u2G8VL9DdvLSGxiBvkImS3BWULl1XGLrv+pO/uAdLJoRPTGf/xcLbOtLJrIB5Mv
        suhOfkHGqdyR58CA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify set_user_nice()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451454033.27769.14330488410812815255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7db0c4c81425e6e0d69dcb56e8c5e99d63f4ef07
Gitweb:        https://git.kernel.org/tip/7db0c4c81425e6e0d69dcb56e8c5e99d63f4ef07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:52:55 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:14 +02:00

sched: Simplify set_user_nice()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 13 ++++++-------
 kernel/sched/sched.h |  5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index efe3848..e4d8b7a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7188,9 +7188,8 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio;
-	struct rq_flags rf;
 	struct rq *rq;
+	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -7198,7 +7197,9 @@ void set_user_nice(struct task_struct *p, long nice)
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = task_rq_lock(p, &rf);
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+
 	update_rq_clock(rq);
 
 	/*
@@ -7209,8 +7210,9 @@ void set_user_nice(struct task_struct *p, long nice)
 	 */
 	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
-		goto out_unlock;
+		return;
 	}
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -7233,9 +7235,6 @@ void set_user_nice(struct task_struct *p, long nice)
 	 * lowered its priority, then reschedule its CPU:
 	 */
 	p->sched_class->prio_changed(rq, p, old_prio);
-
-out_unlock:
-	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a01b7a..62013c4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1657,6 +1657,11 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
+		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
+		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
