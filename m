Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA077710F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjHJHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHJHK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221DB1718;
        Thu, 10 Aug 2023 00:10:57 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9nZYBKafsb5AcmBlyvDgam4VlWdSnQN658Xm+DS/8s=;
        b=XdxNhQeYYGln4pXkXgRkO6hQ8wtbB9UhBRamecXK+PW0OF8qh/T8+piK8yGDm79fX3mVwe
        7S9meCHxmCmPUhOVEP5ACuImSlFWT/401NKRBwYccyo4XrOLekHqDS1pPrC091kvRhgRWF
        G4t6VfowqYA6FyOV5+Hsi0Dvk47JoMM7BtyOH0/iYC1T8z5bR1W7dHce1Zfx6VQPX9Inq2
        xcC0bH6iAiq3QKYMImmaCmMKdPp3BJTgqnYEMoWWCWqVbm1QsBAy9hAiW76D3ESIE8Akhd
        a9G6/c+KWZxZphDqXv86KuVw9eIQxMKKpg3X5MEsfDSbp9JIp7eRDMorQzPqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9nZYBKafsb5AcmBlyvDgam4VlWdSnQN658Xm+DS/8s=;
        b=Cqv94L/HfFw8m/xN7zmtlEKxzWb4U00aFlToXoMv4RIqI14K4qCny39gCqT+aUNpZg5UJa
        6F+/hlYZP4cI9LAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Commit to lag based placement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124604.000198861@infradead.org>
References: <20230531124604.000198861@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145518.27769.13235689466256908432.tip-bot2@tip-bot2>
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

Commit-ID:     76cae9dbe185b82aeb0640aa2b73da4a8e0088ce
Gitweb:        https://git.kernel.org/tip/76cae9dbe185b82aeb0640aa2b73da4a8e0088ce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:58 +02:00

sched/fair: Commit to lag based placement

Removes the FAIR_SLEEPERS code in favour of the new LAG based
placement.

Specifically, the whole FAIR_SLEEPER thing was a very crude
approximation to make up for the lack of lag based placement,
specifically the 'service owed' part. This is important for things
like 'starve' and 'hackbench'.

One side effect of FAIR_SLEEPER is that it caused 'small' unfairness,
specifically, by always ignoring up-to 'thresh' sleeptime it would
have a 50%/50% time distribution for a 50% sleeper vs a 100% runner,
while strictly speaking this should (of course) result in a 33%/67%
split (as CFS will also do if the sleep period exceeds 'thresh').

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124604.000198861@infradead.org
---
 kernel/sched/fair.c     | 59 +----------------------------------------
 kernel/sched/features.h |  8 +-----
 2 files changed, 1 insertion(+), 66 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4d3505d..58798da 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5068,29 +5068,6 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 #endif
 }
 
-static inline bool entity_is_long_sleeper(struct sched_entity *se)
-{
-	struct cfs_rq *cfs_rq;
-	u64 sleep_time;
-
-	if (se->exec_start == 0)
-		return false;
-
-	cfs_rq = cfs_rq_of(se);
-
-	sleep_time = rq_clock_task(rq_of(cfs_rq));
-
-	/* Happen while migrating because of clock task divergence */
-	if (sleep_time <= se->exec_start)
-		return false;
-
-	sleep_time -= se->exec_start;
-	if (sleep_time > ((1ULL << 63) / scale_load_down(NICE_0_LOAD)))
-		return true;
-
-	return false;
-}
-
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
@@ -5172,43 +5149,9 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
-
-		vruntime -= lag;
-	}
-
-	if (sched_feat(FAIR_SLEEPERS)) {
-
-		/* sleeps up to a single latency don't count. */
-		if (!initial) {
-			unsigned long thresh;
-
-			if (se_is_idle(se))
-				thresh = sysctl_sched_min_granularity;
-			else
-				thresh = sysctl_sched_latency;
-
-			/*
-			 * Halve their sleep time's effect, to allow
-			 * for a gentler effect of sleepers:
-			 */
-			if (sched_feat(GENTLE_FAIR_SLEEPERS))
-				thresh >>= 1;
-
-			vruntime -= thresh;
-		}
-
-		/*
-		 * Pull vruntime of the entity being placed to the base level of
-		 * cfs_rq, to prevent boosting it if placed backwards.  If the entity
-		 * slept for a long time, don't even try to compare its vruntime with
-		 * the base as it may be too far off and the comparison may get
-		 * inversed due to s64 overflow.
-		 */
-		if (!entity_is_long_sleeper(se))
-			vruntime = max_vruntime(se->vruntime, vruntime);
 	}
 
-	se->vruntime = vruntime;
+	se->vruntime = vruntime - lag;
 
 	/*
 	 * When joining the competition; the exisiting tasks will be,
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 60cce1e..2a830ec 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,14 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /*
- * Only give sleepers 50% of their service deficit. This allows
- * them to run sooner, but does not allow tons of sleepers to
- * rip the spread apart.
- */
-SCHED_FEAT(FAIR_SLEEPERS, false)
-SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
-
-/*
  * Using the avg_vruntime, do the right thing and preserve lag across
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
