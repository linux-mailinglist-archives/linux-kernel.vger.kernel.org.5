Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D076BF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHAVZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHAVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DC135AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=q92jsVFPZSP8G7FOeDp8TiMSNcZFRY9w1smIqAIutpc=; b=Zs/CXT4SulTjrAAiY5k/JWkVbm
        nhCxY6+yMoC+VlPJZokF8S4WA4fqGlAOTXENgeCoeHlkKzuq0wipZHItvz0AG72ro+VhW3Rlw8Fy+
        ElTqg9gWrlTzSzFSOHOjUXPVGaa4AsavKRfIAD17HosObUFW+rCfubbLhI/BsR7UiLTr3ExI55yRp
        T0wjF+UVz+E7tCmZssp6z135YlHwBTB0VPKI0UC8Z+JzCUVCktqH0bmCT1imWr3KQA7lvam5+LWJT
        mWBpEaT7XJ96fmYyMKMQdX53gcJGDStd6CGGK0Ni5ERXhsLs7R/SAuGQH379LjysbNS7AvlYS07Iz
        M3/Z86xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqn-00EvTw-1h;
        Tue, 01 Aug 2023 21:24:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEE5930310E;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 52AE820283BA4; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.236247952@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] sched: Simplify sched_tick_remote()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5651,9 +5651,6 @@ static void sched_tick_remote(struct wor
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr;
-	struct rq_flags rf;
-	u64 delta;
 	int os;
 
 	/*
@@ -5663,30 +5660,26 @@ static void sched_tick_remote(struct wor
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!tick_nohz_tick_stopped_cpu(cpu))
-		goto out_requeue;
+	if (tick_nohz_tick_stopped_cpu(cpu)) {
+		guard(rq_lock_irq)(rq);
+		struct task_struct *curr = rq->curr;
+
+		if (cpu_online(cpu)) {
+			update_rq_clock(rq);
+
+			if (!is_idle_task(curr)) {
+				/*
+				 * Make sure the next tick runs within a
+				 * reasonable amount of time.
+				 */
+				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			}
+			curr->sched_class->task_tick(rq, curr, 0);
 
-	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
-	if (cpu_is_offline(cpu))
-		goto out_unlock;
-
-	update_rq_clock(rq);
-
-	if (!is_idle_task(curr)) {
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		delta = rq_clock_task(rq) - curr->se.exec_start;
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			calc_load_nohz_remote(rq);
+		}
 	}
-	curr->sched_class->task_tick(rq, curr, 0);
-
-	calc_load_nohz_remote(rq);
-out_unlock:
-	rq_unlock_irq(rq, &rf);
-out_requeue:
 
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary


