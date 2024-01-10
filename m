Return-Path: <linux-kernel+bounces-22222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54E8829B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9261C22169
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26879487BB;
	Wed, 10 Jan 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="GUzQu5kV"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4D487A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUmA/Ml2ZG5TgPL4Phe8RcBWKwy7XONuxaFT8AYnGuo=;
  b=GUzQu5kVy6UIaZfNVDqWcHNtAT0u075oMEhf3pL0s18r0ul/3I4xkdYw
   GnuRPGCy8qRE1IshcnvsAcRXdX/UJ4nAguoyQfld3/HRU1QQYO982hZHh
   Nl7Fe7m6KSWJ3YRkxS7aqr7fpfDIA0cXjssNLkGU1lA39jmpBoBLTa9QT
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145881888"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 14:19:45 +0100
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH v2 1/2 RESEND] sched/fair: take into account scheduling domain in select_idle_smt()
Date: Wed, 10 Jan 2024 14:17:06 +0100
Message-Id: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
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
v2: - Changed the log message to mention only isolcpus
    - Moved the check in the loop according to the original fix

 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..66457d4b8965 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7311,13 +7311,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
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
@@ -7341,7 +7347,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7591,7 +7597,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}
-- 
2.34.1


