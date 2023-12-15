Return-Path: <linux-kernel+bounces-1517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1360814F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5714B2295E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031141868;
	Fri, 15 Dec 2023 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kX35cx33"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4841864
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3YoRLKzm5xEtz8SxbphLTu66Lf4KGd0eUT6OAp2d8Y=;
  b=kX35cx33YzIYNODyXBD0UgklAOs9PdczvcS6ualgcT1mo6sdGjpsEjQ4
   6eWRpgEleLqaTcsBsiuhRGSjbwGTksaf68C/XTFCh13XpHvIkIFPU6Pu/
   Y1mKZ6wUNJZDOGjKliFtlCk0w3bN2FDyOKglvnYmCvyPb4fVXykhO40WH
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,279,1695679200"; 
   d="scan'208";a="74579656"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 19:18:29 +0100
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
Subject: [PATCH v2 2/2] sched/fair: take into account scheduling domain in select_idle_core()
Date: Fri, 15 Dec 2023 19:12:56 +0100
Message-Id: <20231215181254.715971-2-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215181254.715971-1-keisuke.nishimura@inria.fr>
References: <20231215181254.715971-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When picking out a CPU on a task wakeup, select_idle_core() has to take
into account the scheduling domain where the function looks for the CPU.
This is because the "isolcpus" kernel command line option can remove CPUs
from the domain to isolate them from other SMT siblings.

This change replaces the set of CPUs allowed to run the task from
p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
which is stored in the cpus argument provided by select_idle_cpu.

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---
V2: - Changed the log message to mention only isolcpus

 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e5cef258d3e..7c8883239dfd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7262,7 +7262,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7270,7 +7270,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.34.1


