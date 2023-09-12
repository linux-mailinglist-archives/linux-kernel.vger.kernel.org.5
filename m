Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9779CE64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjILKeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjILKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:30:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45041723;
        Tue, 12 Sep 2023 03:29:00 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694514539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9/c5WAScPORoGVq2FSiwIsh38H/zaJClHn7ZgyVDpdw=;
        b=Aa7aIz7+RULKnXj50xg3WkDkp4ZsuQg7lmRDuXit0NZpFiJywvJJnenfztW9ymrPzIKEfV
        mxBFjYrHtzVOwkFwxh0DTgs4t7rFkMtpvXfmF7kdHneHkuovulTP7zkL+IWJVay5FS7pt5
        /PjdJiuvptsbaUq1plWIpo9g7rx7ifCHJ1COohEr61m8JwBNX81r833dSNKT/zlZqtaoxY
        tbAQgV+oiaUHvPhgVjxsLca3gXHAaQsU7f9HherGA+OH+QOFKBplp6xlSMDWVDySsEpUUA
        lPwuZfETo5Gnj8bgme/bizlaYQYC1/1QOI1Y7czcDfQzSqrqD3QhDf2Pq2wAhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694514539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9/c5WAScPORoGVq2FSiwIsh38H/zaJClHn7ZgyVDpdw=;
        b=gIslnSMuU/6KDZEZVzo/l0EAU/CG2LL6gktjhWZWNIjw1JDwgCkt1bVoWNUynQzJmAvkOu
        OPyk6PxJHNWTtRBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify yield_to()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169451453874.27769.1812735099642835156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a5a9d756c80f46cda38952d9ccd4e810b8bdb9d7
Gitweb:        https://git.kernel.org/tip/a5a9d756c80f46cda38952d9ccd4e810b8bdb9d7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:58:23 +02:00
Committer:     root <root@noisy.programming.kicks-ass.net>
CommitterDate: Sat, 09 Sep 2023 15:10:16 +02:00

sched: Simplify yield_to()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 67 +++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9b9fa9..e825839 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8889,55 +8889,46 @@ int __sched yield_to(struct task_struct *p, bool preempt)
 {
 	struct task_struct *curr = current;
 	struct rq *rq, *p_rq;
-	unsigned long flags;
 	int yielded = 0;
 
-	local_irq_save(flags);
-	rq = this_rq();
+	scoped_guard (irqsave) {
+		rq = this_rq();
 
 again:
-	p_rq = task_rq(p);
-	/*
-	 * If we're the only runnable task on the rq and target rq also
-	 * has only one task, there's absolutely no point in yielding.
-	 */
-	if (rq->nr_running == 1 && p_rq->nr_running == 1) {
-		yielded = -ESRCH;
-		goto out_irq;
-	}
+		p_rq = task_rq(p);
+		/*
+		 * If we're the only runnable task on the rq and target rq also
+		 * has only one task, there's absolutely no point in yielding.
+		 */
+		if (rq->nr_running == 1 && p_rq->nr_running == 1)
+			return -ESRCH;
 
-	double_rq_lock(rq, p_rq);
-	if (task_rq(p) != p_rq) {
-		double_rq_unlock(rq, p_rq);
-		goto again;
-	}
+		guard(double_rq_lock)(rq, p_rq);
+		if (task_rq(p) != p_rq)
+			goto again;
 
-	if (!curr->sched_class->yield_to_task)
-		goto out_unlock;
+		if (!curr->sched_class->yield_to_task)
+			return 0;
 
-	if (curr->sched_class != p->sched_class)
-		goto out_unlock;
+		if (curr->sched_class != p->sched_class)
+			return 0;
 
-	if (task_on_cpu(p_rq, p) || !task_is_running(p))
-		goto out_unlock;
+		if (task_on_cpu(p_rq, p) || !task_is_running(p))
+			return 0;
 
-	yielded = curr->sched_class->yield_to_task(rq, p);
-	if (yielded) {
-		schedstat_inc(rq->yld_count);
-		/*
-		 * Make p's CPU reschedule; pick_next_entity takes care of
-		 * fairness.
-		 */
-		if (preempt && rq != p_rq)
-			resched_curr(p_rq);
+		yielded = curr->sched_class->yield_to_task(rq, p);
+		if (yielded) {
+			schedstat_inc(rq->yld_count);
+			/*
+			 * Make p's CPU reschedule; pick_next_entity
+			 * takes care of fairness.
+			 */
+			if (preempt && rq != p_rq)
+				resched_curr(p_rq);
+		}
 	}
 
-out_unlock:
-	double_rq_unlock(rq, p_rq);
-out_irq:
-	local_irq_restore(flags);
-
-	if (yielded > 0)
+	if (yielded)
 		schedule();
 
 	return yielded;
