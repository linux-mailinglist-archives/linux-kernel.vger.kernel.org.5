Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933DE813936
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjLNR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjLNR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:58:02 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB27CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aKNROOurZHb88kWOnJ9PyU35ja83ohgQdj0uzQIZ/FY=;
  b=UNU+mnfC44eWGOwQRKPs4rZ6KXB9iOEAN8fELByERb0kAEfb6z/5xxte
   +B6ttHzSOoMb3uJJaj4xc1K8iti0M8OfuaBwwllMe/g7NO6Hz0Rd9q1Ls
   pW0o9aDSF60mDUCQHkPOt1KazOyQboD8gNqTHmu09IIaI4AotdQPaHsBP
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,276,1695679200"; 
   d="scan'208";a="142377318"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:58:06 +0100
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, Josh Don <joshdon@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-kernel@vger.kernel.org,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH 1/2] sched/fair: take into account scheduling domain in select_idle_smt()
Date:   Thu, 14 Dec 2023 18:55:50 +0100
Message-Id: <20231214175551.629945-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When picking out a CPU on a task wakeup, select_idle_smt() has to take
into account the scheduling domain of @target. This is because cpusets
and isolcpus can remove CPUs from the domain to isolate them from other
SMT siblings.

This fix checks if the candidate CPU is in the target scheduling domain.

The commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated
domain") originally proposed this fix by adding the check of the scheduling
domain in the loop. However, the commit 3e6efe87cd5cc ("sched/fair: Remove
redundant check in select_idle_smt()") accidentally removed the check.
This commit brings the check back with the tiny optimization of computing
the intersection of the task's CPU mask and the sched domain mask up front.

Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcd0f230e21f..71306b48cf68 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7284,11 +7284,18 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
+
+	/*
+	 * Check if a candidate cpu is in the LLC scheduling domain where target exists.
+	 * Due to isolcpus and cpusets, there is no guarantee that it holds.
+	 */
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+	for_each_cpu_and(cpu, cpu_smt_mask(target), cpus) {
 		if (cpu == target)
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -7314,7 +7321,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7564,7 +7571,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.34.1

