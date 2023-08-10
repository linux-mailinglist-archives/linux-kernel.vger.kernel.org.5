Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D0777117
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjHJHLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjHJHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:11:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAA4F3;
        Thu, 10 Aug 2023 00:11:00 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6LBU85QchwzGO6KS9gGSbjstTRukMDpbcvc5ZosSeQ=;
        b=dDjlisZCKE4lDiFwHzkfvXBl9d8/dcXWcnB/hA+e1eyRgXXQaXDd1fpuIB9EZAaq+lGa44
        pFeIKiayPrrgWzfF6Xr5+H3CbBnb6lbS1RL2Sx/WlgwB+v0OL2j/BKgjtkVbFM8HNt9JBR
        WBsdmMjSqQt4ijUL0VQoZvLdKJxYEW7Vlm+warFv7WuEYqNdS+6TNZYohKFdgSP4znTI9g
        I0jKYLga4JpzVWgg3bJjRUkKNCGuJslqonVDBYZa7wnDY0ZdPlDx/KJZkqvu83cd8N1wnE
        29L49+Q2+r5Bw5ZhI++By1KWlfLMW2J7MY4wc/ozRRwPXNjVj4OTLwF5Kcn3vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6LBU85QchwzGO6KS9gGSbjstTRukMDpbcvc5ZosSeQ=;
        b=QgnWYeQzlZteqBxVyPosIOpllcIeOB3+qeyXKsAVS3FZ19uR4lnG2Uud1knCV20RK+X+sU
        dqj00doh/VIumXDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove sched_feat(START_DEBIT)
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124603.722361178@infradead.org>
References: <20230531124603.722361178@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145843.27769.11310689904341154664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13
Gitweb:        https://git.kernel.org/tip/e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/fair: Remove sched_feat(START_DEBIT)

With the introduction of avg_vruntime() there is no need to use worse
approximations. Take the 0-lag point as starting point for inserting
new tasks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124603.722361178@infradead.org
---
 kernel/sched/fair.c     | 21 +--------------------
 kernel/sched/features.h |  6 ------
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bb54606..fc43482 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -906,16 +906,6 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return slice;
 }
 
-/*
- * We calculate the vruntime slice of a to-be-inserted task.
- *
- * vs = s/w
- */
-static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	return calc_delta_fair(sched_slice(cfs_rq, se), se);
-}
-
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -4862,16 +4852,7 @@ static inline bool entity_is_long_sleeper(struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
-
-	/*
-	 * The 'current' period is already promised to the current tasks,
-	 * however the extra weight of the new task will slow them down a
-	 * little, place the new task so that it fits in the slot that
-	 * stays open at the end.
-	 */
-	if (initial && sched_feat(START_DEBIT))
-		vruntime += sched_vslice(cfs_rq, se);
+	u64 vruntime = avg_vruntime(cfs_rq);
 
 	/* sleeps up to a single latency don't count. */
 	if (!initial) {
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c..fa828b3 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,12 +7,6 @@
 SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
 
 /*
- * Place new tasks ahead so that they do not starve already running
- * tasks
- */
-SCHED_FEAT(START_DEBIT, true)
-
-/*
  * Prefer to schedule the task we woke last (assuming it failed
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.
