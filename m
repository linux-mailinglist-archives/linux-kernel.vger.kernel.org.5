Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F679776A7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbjHIUn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:43:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D64196
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9sqy4wj1SuZG+E1ZOkNDiw8zR5F8T4bHRpYkByM8S6o=; b=nS7fhtU07WM4lf+9GY1jnt0WyU
        JlGBQ/BiKLol5nqGk5z8qeenQ4mLmAK77ctDGsrQOk5L6gu1qUBv5+gGiwlrFiiE9486TOOUJiEhr
        uRJy0pNKE+NMQ2PIZ7Bw6RKDtz3MYP4N4P0O4+nSmPgWEyiwjHOJoBL5BhV5q7CJUODfjuCPJ4sOQ
        QiFWMm4eCkB4n2bzrPwFoC6c7Z4U2F0gNa+7v40ZGzYk8FWPRkntfdll5hUyv7KwBTOfCPh+5Qoyo
        C9lbPEJn0Ps1CMfRJXozS8klhujcmLiZ87nsZvsEwZS0JDDZ8PLoAUvXJSYa4d+pwXv43JqCZyPYi
        QOzmr+Pg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTq1m-005twI-2Q;
        Wed, 09 Aug 2023 20:43:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73EC430049D;
        Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5BDC5200D83A5; Wed,  9 Aug 2023 22:43:33 +0200 (CEST)
Message-ID: <20230809204200.310688520@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 22:24:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sched: Simplify yield_to()
References: <20230809202440.012625269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   73 ++++++++++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8799,55 +8799,46 @@ int __sched yield_to(struct task_struct
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
-
-	double_rq_lock(rq, p_rq);
-	if (task_rq(p) != p_rq) {
-		double_rq_unlock(rq, p_rq);
-		goto again;
-	}
-
-	if (!curr->sched_class->yield_to_task)
-		goto out_unlock;
-
-	if (curr->sched_class != p->sched_class)
-		goto out_unlock;
-
-	if (task_on_cpu(p_rq, p) || !task_is_running(p))
-		goto out_unlock;
-
-	yielded = curr->sched_class->yield_to_task(rq, p);
-	if (yielded) {
-		schedstat_inc(rq->yld_count);
+		p_rq = task_rq(p);
 		/*
-		 * Make p's CPU reschedule; pick_next_entity takes care of
-		 * fairness.
+		 * If we're the only runnable task on the rq and target rq also
+		 * has only one task, there's absolutely no point in yielding.
 		 */
-		if (preempt && rq != p_rq)
-			resched_curr(p_rq);
-	}
+		if (rq->nr_running == 1 && p_rq->nr_running == 1)
+			return -ESRCH;
 
-out_unlock:
-	double_rq_unlock(rq, p_rq);
-out_irq:
-	local_irq_restore(flags);
+		guard(double_rq_lock)(rq, p_rq);
+		if (task_rq(p) != p_rq)
+			goto again;
+
+		if (!curr->sched_class->yield_to_task)
+			return 0;
+
+		if (curr->sched_class != p->sched_class)
+			return 0;
+
+		if (task_on_cpu(p_rq, p) || !task_is_running(p))
+			return 0;
+
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
+	}
 
-	if (yielded > 0)
+	if (yielded)
 		schedule();
 
 	return yielded;


