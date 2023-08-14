Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8577BC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHNPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjHNPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE68E77;
        Mon, 14 Aug 2023 08:08:05 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+POrq0SodKs+44G1WTBVPsIgZNhqV59p2iutKfz5rh4=;
        b=ekIcT+U/I0//Hx9VsYTVfMisaGsbYJ1oaOO1WHK0e8GjTd2PNNZz3i+i5wLBD4YGsoqQhd
        Za97wh9OoazqmX7FXsLegNPi8ozSPCBvUaniWT05hkZr7+NI8sxHthHJPZ4lgkre+xhvZW
        1JFb+o2OVZkgm75sUAK5K8E2nO1mvyuHWUqayis1AWggnzFgMtxVLd7Z0DBEEwU5jDx0OF
        ygOK3yZE3JzrnBvgpAIIyPmaKdpXyAQRVRANhdG37g2gWSo+CxzRhv+xucN+7KZSB+MBoE
        /rSEbXoJ+kp60mRS0R+9RlQex84JXDyTcsJd2VbY0emXxMOLxwZChrkpMTs1Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+POrq0SodKs+44G1WTBVPsIgZNhqV59p2iutKfz5rh4=;
        b=cFkaDA+MEVg9pJoAx9woy9pS+aalsUAreBYLvrfrOr/Dhte7ho9q7ByPqnA+uaNriN0zUs
        i44ZxOkiuuaO7vBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_core_cpu_{starting,deactivate}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.371787909@infradead.org>
References: <20230801211812.371787909@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568347.27769.10237844051102997046.tip-bot2@tip-bot2>
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

Commit-ID:     7170509cadbb76e5fa7d7b090d2cbdb93d56a2de
Gitweb:        https://git.kernel.org/tip/7170509cadbb76e5fa7d7b090d2cbdb93d56a2de
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:27 +02:00

sched: Simplify sched_core_cpu_{starting,deactivate}()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.371787909@infradead.org
---
 kernel/sched/core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f113a44..efe3848 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6400,20 +6400,24 @@ static void queue_core_balance(struct rq *rq)
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
+DEFINE_LOCK_GUARD_1(core_lock, int,
+		    sched_core_lock(*_T->lock, &_T->flags),
+		    sched_core_unlock(*_T->lock, &_T->flags),
+		    unsigned long flags)
+
 static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	guard(core_lock)(&cpu);
 
 	WARN_ON_ONCE(rq->core != rq);
 
 	/* if we're the first, we'll be our own leader */
 	if (cpumask_weight(smt_mask) == 1)
-		goto unlock;
+		return;
 
 	/* find the leader */
 	for_each_cpu(t, smt_mask) {
@@ -6427,7 +6431,7 @@ static void sched_core_cpu_starting(unsigned int cpu)
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
-		goto unlock;
+		return;
 
 	/* install and validate core_rq */
 	for_each_cpu(t, smt_mask) {
@@ -6438,29 +6442,25 @@ static void sched_core_cpu_starting(unsigned int cpu)
 
 		WARN_ON_ONCE(rq->core != core_rq);
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	guard(core_lock)(&cpu);
 
 	/* if we're the last man standing, nothing to do */
 	if (cpumask_weight(smt_mask) == 1) {
 		WARN_ON_ONCE(rq->core != rq);
-		goto unlock;
+		return;
 	}
 
 	/* if we're not the leader, nothing to do */
 	if (rq->core != rq)
-		goto unlock;
+		return;
 
 	/* find a new leader */
 	for_each_cpu(t, smt_mask) {
@@ -6471,7 +6471,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* impossible */
-		goto unlock;
+		return;
 
 	/* copy the shared state to the new leader */
 	core_rq->core_task_seq             = rq->core_task_seq;
@@ -6493,9 +6493,6 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 		rq = cpu_rq(t);
 		rq->core = core_rq;
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static inline void sched_core_cpu_dying(unsigned int cpu)
