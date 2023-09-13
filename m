Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBF79E8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbjIMNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240798AbjIMNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:11:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38619BB;
        Wed, 13 Sep 2023 06:11:14 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:11:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694610672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WSH5DAuj9ryML7nV9EnMVKVgDWCcsxry1G0kCNpwZ8g=;
        b=S6pEA7mzLAfDCh05I+zis080r8h8Rw3UH01N7AG4YLHkT5aV7b4svnYOgfCK0YTxwCS5Mj
        7GtPNggn2MOeBWmCOkRlD6YhPaZO5HuTXn03J+p0xeVFnZsS/IaA8VrTzfpJU5eizR1OYh
        hY1KhLycsoFbNGaRePhW5fR4Md8VOeupsCQ/+ww1x8jRpDTo4JymZTMPktctRlARYku3Me
        2Yx/3o6u0MXIXcaLUFo7F5R48yaPbp/elVkYF/r18uTkNWFX8ri6LFJ3Lf1mFXS6yAlCbs
        3q5ubRQT/WHnBIZmvOU4x7mFsN2pkAU4qyiCmZPfLJPXQtTFSXGwT3L+0cwifA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694610672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WSH5DAuj9ryML7nV9EnMVKVgDWCcsxry1G0kCNpwZ8g=;
        b=0L/IlosIMIxS958oIIG+X6Tz3FszJtsrlJ12ESripnaz3+DvsAKW54LjHLoadYMz1hRMaY
        BWNYBvlB5RDfrFCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify yield_to()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169461067223.27769.6572821196325694466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7a50f76674f8b6f4f30a1cec954179f10e20110c
Gitweb:        https://git.kernel.org/tip/7a50f76674f8b6f4f30a1cec954179f10e20110c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 16:58:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Sep 2023 15:01:28 +02:00

sched: Simplify yield_to()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 67 +++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d5cbb3..6c8c40a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8888,55 +8888,46 @@ int __sched yield_to(struct task_struct *p, bool preempt)
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
