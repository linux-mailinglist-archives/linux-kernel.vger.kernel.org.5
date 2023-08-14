Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4941477BC7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjHNPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjHNPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:08:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B88E73;
        Mon, 14 Aug 2023 08:08:06 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:08:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaHbiCMCfbZIfXO7fsqxjcg2YfBJRG0ZhYvKRch2ogw=;
        b=ytZqVRMYtcAoIS8zc3ztUW0iqx9mzU8e+tBXi1qn4G1Ap5d2uq36wKduanXK+5AGZ0xxrp
        IRbqyCgSqftPWKuQJ/pxebjUbTu0fsESp0+RB+BYAR25KUgNklfUnMtnbVZeLGghWgjy+y
        9BSvt/36qdj+jPpgCHoC1mjuk55GHsgrQrLBZjEJiJf3+Z2biQ5VE3U0IaRZ4etB2loXyB
        fMGxYu1YYM/GRwSQ0YYB82hams9iXG371XE/27VdSuuxkgGSYE48zyO8q8TLLDjvm2t4mp
        BNX5zWaD1fGqdGfST9BOQrkeBfCc7PRY0sDVJyTz194rkvKePxa0epYJq6Ntbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692025685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LaHbiCMCfbZIfXO7fsqxjcg2YfBJRG0ZhYvKRch2ogw=;
        b=EjzGqrD9+hyeS2rgAV/UPM67Ni9kEIrNCTgo8J8eLuEJXiMLlyfkSG+izl9OuSJnleA0uc
        fa0bbNw94Zu5CJAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_tick_remote()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230801211812.236247952@infradead.org>
References: <20230801211812.236247952@infradead.org>
MIME-Version: 1.0
Message-ID: <169202568446.27769.11567105117886428004.tip-bot2@tip-bot2>
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

Commit-ID:     6dafc713e3b0d8ffbd696d200d8c9dd212ddcdfc
Gitweb:        https://git.kernel.org/tip/6dafc713e3b0d8ffbd696d200d8c9dd212ddcdfc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Aug 2023 22:41:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Aug 2023 17:01:26 +02:00

sched: Simplify sched_tick_remote()

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230801211812.236247952@infradead.org
---
 kernel/sched/core.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd7f2ed..1b2fa91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5721,9 +5721,6 @@ static void sched_tick_remote(struct work_struct *work)
 	struct tick_work *twork = container_of(dwork, struct tick_work, work);
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr;
-	struct rq_flags rf;
-	u64 delta;
 	int os;
 
 	/*
@@ -5733,30 +5730,26 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!tick_nohz_tick_stopped_cpu(cpu))
-		goto out_requeue;
+	if (tick_nohz_tick_stopped_cpu(cpu)) {
+		guard(rq_lock_irq)(rq);
+		struct task_struct *curr = rq->curr;
 
-	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
-	if (cpu_is_offline(cpu))
-		goto out_unlock;
+		if (cpu_online(cpu)) {
+			update_rq_clock(rq);
 
-	update_rq_clock(rq);
+			if (!is_idle_task(curr)) {
+				/*
+				 * Make sure the next tick runs within a
+				 * reasonable amount of time.
+				 */
+				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
+				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+			}
+			curr->sched_class->task_tick(rq, curr, 0);
 
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
