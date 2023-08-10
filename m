Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004477710C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHJHLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHJHK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:10:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE316E40;
        Thu, 10 Aug 2023 00:10:55 -0700 (PDT)
Date:   Thu, 10 Aug 2023 07:10:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691651454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRMGQbnt+EejVojWFOjZ+198weyN4/ybwQwKVtvdVUE=;
        b=Wpq6Wlq+/tcnJ2a5ngDAgQ0+WPdVsjwQcrJ4rU3eER38lvugm6aoNeKihpH+TOC9N0kDqQ
        3NOY5r8fSnh5reiZKS7bdCwTrNUufRkWw/PaBxgBm4nDw3jxWrp941L80Oqb+j6WhJuC0v
        tYzWUgiH+sZnv2o+KFX4KG11RnoeOaZvY7vdP0H0zPKppu6fjbDdX463q6XtbUwajQJ9xg
        1+hBDpSW1B67HDZP1FcNVwHrTvu9Eu28umMhTS4EB+E1/+gfPIVLGs4uq2QK9IeUXQ/ASM
        IPTnrR3HiLKHG0SeA5vY3Kf/IHX8TuVyLwHuDBUtjDWKmzeA/MYDkO7M2COYjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691651454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRMGQbnt+EejVojWFOjZ+198weyN4/ybwQwKVtvdVUE=;
        b=8wYr/24Th+ywpZgT+XjEXN2DCFAxFMevs+4dFQ2pGh93JFpMrZh9/PzC1iJnQ9nOyDtCMD
        f09nbkcHRQGVt+Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Rename sysctl_sched_min_granularity to
 sysctl_sched_base_slice
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230531124604.205287511@infradead.org>
References: <20230531124604.205287511@infradead.org>
MIME-Version: 1.0
Message-ID: <169165145351.27769.2096429671772156342.tip-bot2@tip-bot2>
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

Commit-ID:     e4ec3318a17f5dcf11bc23b2d2c1da4c1c5bb507
Gitweb:        https://git.kernel.org/tip/e4ec3318a17f5dcf11bc23b2d2c1da4c1c5bb507
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 31 May 2023 13:58:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Jul 2023 09:43:59 +02:00

sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice

EEVDF uses this tunable as the base request/slice -- make sure the
name reflects this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230531124604.205287511@infradead.org
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/debug.c |  4 ++--
 kernel/sched/fair.c  | 12 ++++++------
 kernel/sched/sched.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e85a2fd..a5d3422 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4502,7 +4502,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_min_granularity;
+	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f8d190c..4c3d0d9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -347,7 +347,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
-	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("base_slice_ns", 0644, debugfs_sched, &sysctl_sched_base_slice);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
@@ -863,7 +863,7 @@ static void sched_debug_header(struct seq_file *m)
 	SEQ_printf(m, "  .%-40s: %Ld\n", #x, (long long)(x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
-	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_base_slice);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0605eb4..61747a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -75,8 +75,8 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
  *
  * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_min_granularity			= 750000ULL;
-static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
+unsigned int sysctl_sched_base_slice			= 750000ULL;
+static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 /*
  * After fork, child runs first. If set to 0 (default) then
@@ -237,7 +237,7 @@ static void update_sysctl(void)
 
 #define SET_SYSCTL(name) \
 	(sysctl_##name = (factor) * normalized_sysctl_##name)
-	SET_SYSCTL(sched_min_granularity);
+	SET_SYSCTL(sched_base_slice);
 #undef SET_SYSCTL
 }
 
@@ -943,7 +943,7 @@ int sched_update_scaling(void)
 
 #define WRT_SYSCTL(name) \
 	(normalized_sysctl_##name = sysctl_##name / (factor))
-	WRT_SYSCTL(sched_min_granularity);
+	WRT_SYSCTL(sched_base_slice);
 #undef WRT_SYSCTL
 
 	return 0;
@@ -964,9 +964,9 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
 	 * nice) while the request time r_i is determined by
-	 * sysctl_sched_min_granularity.
+	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_min_granularity;
+	se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f814bb7..7ff9965 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2503,7 +2503,7 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_base_slice;
 
 #ifdef CONFIG_SCHED_DEBUG
 extern int sysctl_resched_latency_warn_ms;
