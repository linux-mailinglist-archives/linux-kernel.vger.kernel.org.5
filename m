Return-Path: <linux-kernel+bounces-130040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9B897371
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341E7B2D344
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6714A4E9;
	Wed,  3 Apr 2024 15:07:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4B149E0A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156830; cv=none; b=CXR+3PhdlcY904SSaygKOrhTCAoBj3Rli4KBNvuGfowZYoKvhqrche0S/aNJWE3Uzx72FEvmJtIHtmSI0FGQJGLM//GDi6ixkKTDNBMYZ8Y3hlRAOGbimsHkgmTClpgXufYoF6S46NngErqL0DdUNAOdEbZLeJfYOT+u4RS2s5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156830; c=relaxed/simple;
	bh=W3JT2si9ImtOXLQWk2Xzg1pUyMSMDml9LjW4wwC97aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTuC6jyOIJGZpP8M5Wz/FMYBMkdP6qOYBp4Dm3YCfXdQ5BpPazQk/WvuEpL9fb0WETRSJsIfQ+0EF3JS5OI5oP/DTPmReVXJQUFeJGiMI9sFeFC2F8O2X4K3qi6ubv2Q4zFH/GQxcnHX1kygtJMPJHszU//Uply/DpvryLfwPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF09F1691;
	Wed,  3 Apr 2024 08:07:39 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DFCF3F7B4;
	Wed,  3 Apr 2024 08:07:04 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Aaron Lu <aaron.lu@intel.com>,
	Rui Zhang <rui.zhang@intel.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/7] sched/fair: Clear idle_cpus_mask for CPUs with NULL sd
Date: Wed,  3 Apr 2024 17:05:39 +0200
Message-Id: <20240403150543.2793354-8-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403150543.2793354-1-pierre.gondois@arm.com>
References: <20240403150543.2793354-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported in [1], an isolated CPU keeps the values of:
- rq->nohz_tick_stopped
- nohz.idle_cpus_mask
- nohz.nr_cpus
when a NULL sd is attached to the CPU. Clear the values.

[1] https://lore.kernel.org/all/20230804090858.7605-1-rui.zhang@intel.com/

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/sched/nohz.h |  2 ++
 kernel/sched/fair.c        | 11 +++++++++++
 kernel/sched/topology.c    |  6 ++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 6d67e9a5af6b..18e620715c9d 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,8 +9,10 @@
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern void nohz_clear_state(int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
+static void nohz_clear_state(int cpu) { }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9657c8f2176b..6786d4d78e41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12014,6 +12014,17 @@ static void nohz_balancer_kick(struct rq *rq)
 		kick_ilb(flags);
 }
 
+void nohz_clear_state(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (rq->nohz_tick_stopped) {
+		rq->nohz_tick_stopped = 0;
+		cpumask_clear_cpu(cpu, nohz.idle_cpus_mask);
+		atomic_dec(&nohz.nr_cpus);
+	}
+}
+
 static void set_cpu_sd_state_busy(int cpu)
 {
 	struct sched_domain *sd;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b4fc212ccfb0..e8e40b7d964b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -775,10 +775,12 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 	sched_domain_debug(sd, cpu);
 
-	if (sd)
+	if (sd) {
 		housekeeping_runtime_set_cpu(cpu, HKR_TYPE_SCHED);
-	else
+	} else {
 		housekeeping_runtime_clear_cpu(cpu, HKR_TYPE_SCHED);
+		nohz_clear_state(cpu);
+	}
 
 	rq_attach_root(rq, rd);
 	tmp = rq->sd;
-- 
2.25.1


