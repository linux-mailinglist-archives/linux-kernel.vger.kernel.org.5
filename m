Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9479E8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbjIMNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbjIMNLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7619B9;
        Wed, 13 Sep 2023 06:11:16 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jjhk2NOlcOekS+9KNZbWh/C2ynHVx5QcKV0wX5xUGqg=;
        b=JpLoIuafpG6wlsZAlyygKEsq3o8LUqUnVBJIA1KktQUNiDvbtfZC2w8wIzWe/tfY5aUvKa
        LWQUnQe0mr3npdMcNZhEkAhA2kArZDaO7vm24aE9E0C7PId9qQ+Y0gD8NVuwdUxLNqnaeU
        dKMitLDsQ8lB5RNQYfNw49aU885yydzXsLXEoJ9HCqtGFfI0M5X6vsv0WWhJW0q4p43JPZ
        Z3qc4U2iAo0Pl1skif2wr7yxx0rwh2BZmJMSXnjCaE+VfYl4MMNrx5hmoYuWhJROZIBUwI
        RPeJZlzHfnIJTWc7JMryOMobK4zHtOUCb25MrW08vacetBMe2qWbyFIy533zcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jjhk2NOlcOekS+9KNZbWh/C2ynHVx5QcKV0wX5xUGqg=;
        b=CNnzyjUFXMnwWN387i793lndxYBeU0NIdau+Jq+XrV7VhVrmABQTjfPRVxsNEbbVDu7FeK
        SrmVXPXC04z9VlCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify set_user_nice()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067423.27769.1239931915350058927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     94b548a15e8ec47dfbf6925bdfb64bb5657dce0c
Gitweb:        https://git.kernel.org/tip/94b548a15e8ec47dfbf6925bdfb64bb5657dce0c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 20:52:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:14 +02:00

sched: Simplify set_user_nice()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  | 13 ++++++-------
 kernel/sched/sched.h |  5 +++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5c..fa57a56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7187,9 +7187,8 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 void set_user_nice(struct task_struct *p, long nice)
 {
 	bool queued, running;
-	int old_prio;
-	struct rq_flags rf;
 	struct rq *rq;
+	int old_prio;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -7197,7 +7196,9 @@ void set_user_nice(struct task_struct *p, long nice)
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = task_rq_lock(p, &rf);
+	CLASS(task_rq_lock, rq_guard)(p);
+	rq = rq_guard.rq;
+
 	update_rq_clock(rq);
 
 	/*
@@ -7208,8 +7209,9 @@ void set_user_nice(struct task_struct *p, long nice)
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
@@ -7232,9 +7234,6 @@ void set_user_nice(struct task_struct *p, long nice)
 	 * lowered its priority, then reschedule its CPU:
 	 */
 	p->sched_class->prio_changed(rq, p, old_prio);
-
-out_unlock:
-	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0484627..68768f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1658,6 +1658,11 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
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
