Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559A76BF3B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjHAVZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE035A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tN5fF7Wyh35qBJFCdjEuKMaMwIiqau8XmW0j2x/SMjk=; b=OBxsTC6ytcWiY/yE6bTaLRGenU
        UXNPiXEek3EpXmglUInzCpiKgnS3Xz9uHEbo7oY5WDfMfRjUz6q3DK9ojN+5Su+zHJowi8JZkdBJ8
        rZtpQZszObYqufmw4gEPMk5APgE2bWfFNTlvKj10VcO2RwkEUplUW2a7aLx0tk2rTvhA1MBl95JeA
        MLf1QC02VFnIlh00Zr9IL404fYayP1cF/EJqh1gO6LAcLlbPHhXEWK/jbPzOwChgZjJR1QxrVvTp9
        Ss9CbChT2TfWVE/c/meuiPSnO7OW5RaPYlArIXzJru3Hk79gP0WwXf/+mZQHrSIM7limw+vBxut7M
        /lGBWahg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQwqn-00B5yk-GZ; Tue, 01 Aug 2023 21:24:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEE9330334C;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5B5942026B3DC; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.371787909@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] sched: Simplify sched_core_cpu_{starting,deactivate}()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6331,20 +6331,24 @@ static void queue_core_balance(struct rq
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
@@ -6358,7 +6362,7 @@ static void sched_core_cpu_starting(unsi
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
-		goto unlock;
+		return;
 
 	/* install and validate core_rq */
 	for_each_cpu(t, smt_mask) {
@@ -6369,29 +6373,25 @@ static void sched_core_cpu_starting(unsi
 
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
@@ -6402,7 +6402,7 @@ static void sched_core_cpu_deactivate(un
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* impossible */
-		goto unlock;
+		return;
 
 	/* copy the shared state to the new leader */
 	core_rq->core_task_seq             = rq->core_task_seq;
@@ -6424,9 +6424,6 @@ static void sched_core_cpu_deactivate(un
 		rq = cpu_rq(t);
 		rq->core = core_rq;
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static inline void sched_core_cpu_dying(unsigned int cpu)


