Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D887AC799
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjIXKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIXKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:39:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0F8101;
        Sun, 24 Sep 2023 03:39:30 -0700 (PDT)
Date:   Sun, 24 Sep 2023 10:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695551969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fFN/AmPZyxtAYIiavwOmm1Y7Ev2+sV7LPtdmU9WRmw=;
        b=Pzq1F+jHLiratYatHH4TITwm+IVb7aXDRkwi0bSxnPOCWydJdPgj87G0aU4rHBAN5ecPbt
        rF0GBLDQxS8XVcduXfl8BEOTUSCKryAnQrKJC33/USfQB/AVSw5VUz4St+koxytyOzIxg7
        Xvuh73ZlYSxXcb6CkxJoB4TF4Ihr1DI9s8qVFf4wg5K24l/bkCPYZTlZGuio+WNG7xeeSe
        Za8+Q2nTZZHMKUtNPTJB3Zcjqn26xZSklutNEuujptwTn5lKVr1cjOvSiNcLGKuj/3bdXo
        bM56cTDhBbsetXwyxa0id0boIdJHTR+7AsHZsPDYbD6LLT0uzG5i0eXZYjdp3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695551969;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fFN/AmPZyxtAYIiavwOmm1Y7Ev2+sV7LPtdmU9WRmw=;
        b=NqkoVBt3h9hpO8Gjw/SvtuZfGg5iu9nq7c8PX91CzNl2ozjfux8iaEG5eRx8ym5QVXIRfM
        tK/pdpRGgg2SMyAA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix warning in bandwidth distribution
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922230535.296350-2-joshdon@google.com>
References: <20230922230535.296350-2-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <169555196835.27769.10207934409952640022.tip-bot2@tip-bot2>
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

Commit-ID:     2f8c62296b6f656bbfd17e9f1fadd7478003a9d9
Gitweb:        https://git.kernel.org/tip/2f8c62296b6f656bbfd17e9f1fadd7478003a9d9
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Fri, 22 Sep 2023 16:05:35 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Sep 2023 12:08:29 +02:00

sched/fair: Fix warning in bandwidth distribution

We've observed the following warning being hit in
distribute_cfs_runtime():

	SCHED_WARN_ON(cfs_rq->runtime_remaining > 0)

We have the following race:

 - CPU 0: running bandwidth distribution (distribute_cfs_runtime).
   Inspects the local cfs_rq and makes its runtime_remaining positive.
   However, we defer unthrottling the local cfs_rq until after
   considering all remote cfs_rq's.

 - CPU 1: starts running bandwidth distribution from the slack timer. When
   it finds the cfs_rq for CPU 0 on the throttled list, it observers the
   that the cfs_rq is throttled, yet is not on the CSD list, and has a
   positive runtime_remaining, thus triggering the warning in
   distribute_cfs_runtime.

To fix this, we can rework the local unthrottling logic to put the local
cfs_rq on a local list, so that any future bandwidth distributions will
realize that the cfs_rq is about to be unthrottled.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922230535.296350-2-joshdon@google.com
---
 kernel/sched/fair.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41c960e..2973173 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5741,13 +5741,13 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 
 static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 {
-	struct cfs_rq *local_unthrottle = NULL;
 	int this_cpu = smp_processor_id();
 	u64 runtime, remaining = 1;
 	bool throttled = false;
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq, *tmp;
 	struct rq_flags rf;
 	struct rq *rq;
+	LIST_HEAD(local_unthrottle);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
@@ -5782,11 +5782,17 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		/* we check whether we're throttled above */
 		if (cfs_rq->runtime_remaining > 0) {
-			if (cpu_of(rq) != this_cpu ||
-			    SCHED_WARN_ON(local_unthrottle))
+			if (cpu_of(rq) != this_cpu) {
 				unthrottle_cfs_rq_async(cfs_rq);
-			else
-				local_unthrottle = cfs_rq;
+			} else {
+				/*
+				 * We currently only expect to be unthrottling
+				 * a single cfs_rq locally.
+				 */
+				SCHED_WARN_ON(!list_empty(&local_unthrottle));
+				list_add_tail(&cfs_rq->throttled_csd_list,
+					      &local_unthrottle);
+			}
 		} else {
 			throttled = true;
 		}
@@ -5794,15 +5800,23 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 next:
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	rcu_read_unlock();
 
-	if (local_unthrottle) {
-		rq = cpu_rq(this_cpu);
+	list_for_each_entry_safe(cfs_rq, tmp, &local_unthrottle,
+				 throttled_csd_list) {
+		struct rq *rq = rq_of(cfs_rq);
+
 		rq_lock_irqsave(rq, &rf);
-		if (cfs_rq_throttled(local_unthrottle))
-			unthrottle_cfs_rq(local_unthrottle);
+
+		list_del_init(&cfs_rq->throttled_csd_list);
+
+		if (cfs_rq_throttled(cfs_rq))
+			unthrottle_cfs_rq(cfs_rq);
+
 		rq_unlock_irqrestore(rq, &rf);
 	}
+	SCHED_WARN_ON(!list_empty(&local_unthrottle));
+
+	rcu_read_unlock();
 
 	return throttled;
 }
