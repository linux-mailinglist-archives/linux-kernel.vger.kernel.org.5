Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E368756388
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGQM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGQM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88419B7;
        Mon, 17 Jul 2023 05:56:33 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDv4HP9mRzXxcXfC+VJIpYPLsIPQeo902sc28kX/Cj0=;
        b=pEOLZYMbwtm4eVJOa9OSX/2kAHjuEDD7A4hmPFxgDBoVFbNvCflrlXyFDsJkrvlqF6n7XW
        jLY8vbRX/CXk0+pG6gm6q8LJW3qK/6x2GEsHKIZhYP73u33lP007Csdvd/aGfYNVio/nw7
        4BgpuMJX2PRJA8sdqxnL3ygws3UtTYjQPf98W3fUKXIc/NZe4hOxJOtdpoL4UOyktzAYFM
        2oHm2zCW/EgQDjonIMWrr8rhTVXNRx3mTwpcz0qwEM7G5FmqkFXcdZsZlapQe3sWdwUwKR
        IlMnYmBfP4SAX7fIAudoxngX/BMk/fJk1RLQ5BOETqmBC8GspIFJMxXamyFIEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDv4HP9mRzXxcXfC+VJIpYPLsIPQeo902sc28kX/Cj0=;
        b=9tiZieivV41M2oV/0Lg4gDS+I7aPyb5F2Iptla/BqZPKtgoCjk8dSvPd0+w66WpTpPYUMz
        3eABOqPauC77/RDg==
From:   "tip-bot2 for Tim C Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4eacbaa236e680687dae2958378a6173654113df=2E16887?=
 =?utf-8?q?70494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C4eacbaa236e680687dae2958378a6173654113df=2E168877?=
 =?utf-8?q?0494=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168959857230.28540.6981196186824283885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ff1693236f5d97a939dbeb660c07671a2d57071
Gitweb:        https://git.kernel.org/tip/7ff1693236f5d97a939dbeb660c07671a2d57071
Author:        Tim C Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 07 Jul 2023 15:57:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:52 +02:00

sched/fair: Implement prefer sibling imbalance calculation between asymmetric groups

In the current prefer sibling load balancing code, there is an implicit
assumption that the busiest sched group and local sched group are
equivalent, hence the tasks to be moved is simply the difference in
number of tasks between the two groups (i.e. imbalance) divided by two.

However, we may have different number of cores between the cluster groups,
say when we take CPU offline or we have hybrid groups.  In that case,
we should balance between the two groups such that #tasks/#cores ratio
is the same between the same between both groups.  Hence the imbalance
computed will need to reflect this.

Adjust the sibling imbalance computation to take into account of the
above considerations.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/4eacbaa236e680687dae2958378a6173654113df.1688770494.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index accbfbb..c6246fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9535,6 +9535,41 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	return false;
 }
 
+static inline long sibling_imbalance(struct lb_env *env,
+				    struct sd_lb_stats *sds,
+				    struct sg_lb_stats *busiest,
+				    struct sg_lb_stats *local)
+{
+	int ncores_busiest, ncores_local;
+	long imbalance;
+
+	if (env->idle == CPU_NOT_IDLE || !busiest->sum_nr_running)
+		return 0;
+
+	ncores_busiest = sds->busiest->cores;
+	ncores_local = sds->local->cores;
+
+	if (ncores_busiest == ncores_local) {
+		imbalance = busiest->sum_nr_running;
+		lsub_positive(&imbalance, local->sum_nr_running);
+		return imbalance;
+	}
+
+	/* Balance such that nr_running/ncores ratio are same on both groups */
+	imbalance = ncores_local * busiest->sum_nr_running;
+	lsub_positive(&imbalance, ncores_busiest * local->sum_nr_running);
+	/* Normalize imbalance and do rounding on normalization */
+	imbalance = 2 * imbalance + ncores_local + ncores_busiest;
+	imbalance /= ncores_local + ncores_busiest;
+
+	/* Take advantage of resource in an empty sched group */
+	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	    busiest->sum_nr_running > 1)
+		imbalance = 2;
+
+	return imbalance;
+}
+
 static inline bool
 sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 {
@@ -10393,14 +10428,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		}
 
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
-			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
 			 * When prefer sibling, evenly spread running tasks on
 			 * groups.
 			 */
 			env->migration_type = migrate_task;
-			lsub_positive(&nr_diff, local->sum_nr_running);
-			env->imbalance = nr_diff;
+			env->imbalance = sibling_imbalance(env, sds, busiest, local);
 		} else {
 
 			/*
@@ -10597,7 +10630,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	 * group's child domain.
 	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
-	    busiest->sum_nr_running > local->sum_nr_running + 1)
+	    sibling_imbalance(env, &sds, busiest, local) > 1)
 		goto force_balance;
 
 	if (busiest->group_type != group_overloaded) {
