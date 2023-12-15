Return-Path: <linux-kernel+bounces-1514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90844814F97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C207C1C238B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC53FB2E;
	Fri, 15 Dec 2023 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="R0rCQIem"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC553FB10
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i09mNEHJsuO9HrdfvWVKd9B+ZZ5GtdlLk9Ko7bVvgYg=;
  b=R0rCQIemH1n1KpU45JeZtzhBhvSQubONCbBeloEvvtbeSs7TWeCddZJM
   4Vk1Hd0X9AIco/ap+Os5ErJWSO4uw9Q6HVjPWsHrjJh6MybFycN3UsL2q
   vPfQ5Bm9tZCuuiLbJQiuta22RcvrZZlPntQ+dy7IZkmkt+0Hp9v0xcpL9
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,279,1695679200"; 
   d="scan'208";a="74579620"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:18:05 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Josh Don <joshdon@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <julia.lawall@inria.fr>,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH v2 1/2] sched/fair: take into account scheduling domain in select_idle_smt()
Date: Fri, 15 Dec 2023 19:12:54 +0100
Message-Id: <20231215181254.715971-1-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When picking out a CPU on a task wakeup, select_idle_smt() has to take
into account the scheduling domain of @target. This is because the
"isolcpus" kernel command line option can remove CPUs from the domain to
isolate them from other SMT siblings.

This fix checks if the candidate CPU is in the target scheduling domain.

The commit df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated
domain") originally proposed this fix by adding the check of the scheduling
domain in the loop. However, the commit 3e6efe87cd5cc ("sched/fair: Remove
redundant check in select_idle_smt()") accidentally removed the check.
This commit brings the check back.

Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---
V2: - Changed the log message to mention only isolcpus
    - Moved the check in the loop according to the original fix

 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcd0f230e21f..5e5cef258d3e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7284,13 +7284,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (cpu == target)
 			continue;
+		/*
+		 * Check if the CPU is in the LLC scheduling domain of @target.
+		 * Due to isolcpus, there is no guarantee that all the siblings are in the domain.
+		 */
+		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
@@ -7314,7 +7320,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7564,7 +7570,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.34.1


