Return-Path: <linux-kernel+bounces-130032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C989736C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15E1B2BAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C78149E0E;
	Wed,  3 Apr 2024 15:06:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAA149DE9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156772; cv=none; b=NQjePjfPLQhOVhEvyO9lJG6G36/Phaw9buBc4AhctJz1BQon/U2wWy3cH3wDGD4Qid6AwGZi7hTwSXOk3Fz7/MTtc9QWhAUgvc80lJ8AGT3l91DTM3aS+naeLeEIbG4s7okQme6ZIDdftOvUG/jRm6IdqXcvl6YrdP4tDo163yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156772; c=relaxed/simple;
	bh=KeJBZfvQpzst1Q8dnNMU32tcHHCcw1VBPsqiOrQaTrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JTkG59YKOHNAHHxn24Oz90dxzgrsF/h11FnfwHQjU0EbBwjLSo8catuvhW8XI476Is/Ch38gc6rvIqltxc+7P2dIK6GsUq5Mjy8vLbhi/2tAxXRgfIYW4QwaiXYtq8Vzhkcf0xD+MPOFY/7ULFU/wfie2ggFjCuEAT8Rs+P1VpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492B01650;
	Wed,  3 Apr 2024 08:06:41 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.74.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64B0E3F7B4;
	Wed,  3 Apr 2024 08:06:06 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/7] sched/isolation: Introduce housekeeping_runtime isolation
Date: Wed,  3 Apr 2024 17:05:33 +0200
Message-Id: <20240403150543.2793354-2-pierre.gondois@arm.com>
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

CONFIG_CPU_ISOLATION allows to setup various cpu masks to
exclude CPUs from some activities. Masks that are not modified
default to cpu_online_mask.
Masks are set at boot time. If no mask is modified, the static key
'housekeeping_overridden' is left to false, allowing to minimize the
cost of calls to housekeeping_*() functions.

Create a new housekeeping runtime type, whose isolation masks
can be modified at runtime. Also add a set of functions
around this new type. This type is independent from the
'housekeeping_overridden' static key.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 include/linux/sched/isolation.h | 28 +++++++++++++++++++++
 kernel/sched/isolation.c        | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..5d2f40c6f04c 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -6,6 +6,10 @@
 #include <linux/init.h>
 #include <linux/tick.h>
 
+enum hkr_type {
+	HKR_TYPE_MAX
+};
+
 enum hk_type {
 	HK_TYPE_TIMER,
 	HK_TYPE_RCU,
@@ -26,6 +30,12 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
+
+extern const struct cpumask *housekeeping_runtime_cpumask(enum hkr_type type);
+extern bool housekeeping_runtime_test_cpu(int cpu, enum hkr_type type);
+extern void housekeeping_runtime_set_cpu(int cpu, enum hkr_type type);
+extern void housekeeping_runtime_clear_cpu(int cpu, enum hkr_type type);
+
 extern void __init housekeeping_init(void);
 
 #else
@@ -53,6 +63,24 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline const struct cpumask *housekeeping_runtime_cpumask(enum hkr_type type)
+{
+	return cpu_possible_mask;
+}
+
+static inline bool housekeeping_runtime_test_cpu(int cpu, enum hkr_type type)
+{
+	return true;
+}
+
+static inline void housekeeping_runtime_set_cpu(int cpu, enum hkr_type type)
+{
+}
+
+static inline void housekeeping_runtime_clear_cpu(int cpu, enum hkr_type type)
+{
+}
+
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..5acbed870c28 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -23,6 +23,13 @@ enum hk_flags {
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
+struct housekeeping_runtime {
+	cpumask_var_t cpumasks[HKR_TYPE_MAX];
+	unsigned long flags;
+};
+
+static struct housekeeping_runtime housekeeping_runtime;
+
 struct housekeeping {
 	cpumask_var_t cpumasks[HK_TYPE_MAX];
 	unsigned long flags;
@@ -79,10 +86,46 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+const struct cpumask *housekeeping_runtime_cpumask(enum hkr_type type)
+{
+	if (housekeeping_runtime.cpumasks[type])
+		return housekeeping_runtime.cpumasks[type];
+	return cpu_possible_mask;
+}
+
+bool housekeeping_runtime_test_cpu(int cpu, enum hkr_type type)
+{
+	if (housekeeping_runtime.cpumasks[type])
+		return cpumask_test_cpu(cpu, housekeeping_runtime.cpumasks[type]);
+	return true;
+}
+
+void housekeeping_runtime_set_cpu(int cpu, enum hkr_type type)
+{
+	if (housekeeping_runtime.cpumasks[type])
+		cpumask_set_cpu(cpu, housekeeping_runtime.cpumasks[type]);
+}
+
+void housekeeping_runtime_clear_cpu(int cpu, enum hkr_type type)
+{
+	if (housekeeping_runtime.cpumasks[type])
+		cpumask_clear_cpu(cpu, housekeeping_runtime.cpumasks[type]);
+}
+
+static void __init housekeeping_runtime_init(void)
+{
+	enum hkr_type type;
+
+	for (type = 0; type < HKR_TYPE_MAX; type++)
+		alloc_cpumask_var(&housekeeping_runtime.cpumasks[type], GFP_KERNEL);
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;
 
+	housekeeping_runtime_init();
+
 	if (!housekeeping.flags)
 		return;
 
-- 
2.25.1


