Return-Path: <linux-kernel+bounces-38303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03783BD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0B293DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0B1CA83;
	Thu, 25 Jan 2024 09:41:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC401CD14;
	Thu, 25 Jan 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175715; cv=none; b=pcy3K4N/5+86+tH0oxy+5KmEf5jEdCf4iD9xX8j/w/E0wXC+/x+6jxMYmHON6OhT7uoG27UqGAuC2gSIYTr4mO/NCi0b0YkTlSXqno2IZ5vJ8Ammv0xav6PqFDnbgl+rDbQ6FrWzWi4alZGbp6z4LCIz6pPPgQlm7mFKpvmfPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175715; c=relaxed/simple;
	bh=nfag3pHszLoX0gSwmmf7FHkBVu74OyBI+6RfcEJaxxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NI5x51QxMZIAnzW0gy9GBkAIarfnMQIH/sWOWHjLINjMr14fGm8pjeZd/mGldxzek6Pyrb17K+I9MNeDTjWzrpCXBD5U04MqPvdCe/q8bRBAYGDisBt7aVn3Zn0jFpjo5NKjU1o1ysuHGWdCc1wb3yUD5b4yh+3R12KojuWbS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D817714BF;
	Thu, 25 Jan 2024 01:42:36 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 33E0E3F73F;
	Thu, 25 Jan 2024 01:41:46 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling framework
Date: Thu, 25 Jan 2024 15:11:14 +0530
Message-Id: <20240125094119.2542332-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-1-anshuman.khandual@arm.com>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Branch stack sampling support i.e capturing branch records during execution
in core perf, rides along with normal HW events being scheduled on the PMU.
This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
with required HW implementation.

ARMV8 PMU hardware support for branch stack sampling is indicated via a new
feature flag called 'has_branch_stack' that can be ascertained via probing.
This modifies current gate in armpmu_event_init() which blocks branch stack
sampling based perf events unconditionally. Instead allows such perf events
getting initialized on supporting PMU hardware.

Branch stack sampling is enabled and disabled along with regular PMU events
 This adds required function callbacks in armv8pmu_branch_xxx() format, to
drive the PMU branch stack hardware when supported. This also adds fallback
stub definitions for these callbacks for PMUs which would not have required
support.

If a task gets scheduled out, the current branch records get saved in the
task's context data, which can be later used to fill in the records upon an
event overflow. Hence, we enable PERF_ATTACH_TASK_DATA (event->attach_state
based flag) for branch stack requesting perf events. But this also requires
adding support for pmu::sched_task() callback to arm_pmu.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V16:

- Renamed arm_brbe.h as arm_pmuv3_branch.h
- Updated perf_sample_save_brstack()'s new argument requirements with NULL

 drivers/perf/arm_pmu.c          |  57 ++++++++++++-
 drivers/perf/arm_pmuv3.c        | 141 +++++++++++++++++++++++++++++++-
 drivers/perf/arm_pmuv3_branch.h |  50 +++++++++++
 include/linux/perf/arm_pmu.h    |  29 ++++++-
 include/linux/perf/arm_pmuv3.h  |   1 -
 5 files changed, 273 insertions(+), 5 deletions(-)
 create mode 100644 drivers/perf/arm_pmuv3_branch.h

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4..16f488ae7747 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -317,6 +317,15 @@ armpmu_del(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	if (has_branch_stack(event)) {
+		WARN_ON_ONCE(!hw_events->brbe_users);
+		hw_events->brbe_users--;
+		if (!hw_events->brbe_users) {
+			hw_events->brbe_context = NULL;
+			hw_events->brbe_sample_type = 0;
+		}
+	}
+
 	armpmu_stop(event, PERF_EF_UPDATE);
 	hw_events->events[idx] = NULL;
 	armpmu->clear_event_idx(hw_events, event);
@@ -333,6 +342,38 @@ armpmu_add(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 
+	if (has_branch_stack(event)) {
+		/*
+		 * Reset branch records buffer if a new CPU bound event
+		 * gets scheduled on a PMU. Otherwise existing branch
+		 * records present in the buffer might just leak into
+		 * such events.
+		 *
+		 * Also reset current 'hw_events->brbe_context' because
+		 * any previous task bound event now would have lost an
+		 * opportunity for continuous branch records.
+		 */
+		if (!event->ctx->task) {
+			hw_events->brbe_context = NULL;
+			if (armpmu->branch_reset)
+				armpmu->branch_reset();
+		}
+
+		/*
+		 * Reset branch records buffer if a new task event gets
+		 * scheduled on a PMU which might have existing records.
+		 * Otherwise older branch records present in the buffer
+		 * might leak into the new task event.
+		 */
+		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
+			hw_events->brbe_context = event->ctx;
+			if (armpmu->branch_reset)
+				armpmu->branch_reset();
+		}
+		hw_events->brbe_users++;
+		hw_events->brbe_sample_type = event->attr.branch_sample_type;
+	}
+
 	/* An event following a process won't be stopped earlier */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return -ENOENT;
@@ -511,13 +552,24 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
+	/*
+	 * Branch stack sampling events are allowed
+	 * only on PMU which has required support.
+	 */
+	if (has_branch_stack(event) && !armpmu->has_branch_stack)
 		return -EOPNOTSUPP;
 
 	return __hw_perf_event_init(event);
 }
 
+static void armpmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+
+	if (armpmu->sched_task)
+		armpmu->sched_task(pmu_ctx, sched_in);
+}
+
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
@@ -864,6 +916,7 @@ struct arm_pmu *armpmu_alloc(void)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..9e17764a0929 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -26,6 +26,7 @@
 #include <linux/nmi.h>
 
 #include <asm/arm_pmuv3.h>
+#include "arm_pmuv3_branch.h"
 
 /* ARMv8 Cortex-A53 specific event types. */
 #define ARMV8_A53_PERFCTR_PREF_LINEFILL				0xC2
@@ -829,14 +830,56 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
 
 	kvm_vcpu_pmu_resync_el0();
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_enable(cpu_pmu);
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 {
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_disable();
+
 	/* Disable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
+static void read_branch_records(struct pmu_hw_events *cpuc,
+				struct perf_event *event,
+				struct perf_sample_data *data,
+				bool *branch_captured)
+{
+	/*
+	 * CPU specific branch records buffer must have been allocated already
+	 * for the hardware records to be captured and processed further.
+	 */
+	if (WARN_ON(!cpuc->branches))
+		return;
+
+	/*
+	 * Overflowed event's branch_sample_type does not match the configured
+	 * branch filters in the BRBE HW. So the captured branch records here
+	 * cannot be co-related to the overflowed event. Report to the user as
+	 * if no branch records have been captured, and flush branch records.
+	 * The same scenario is applicable when the current task context does
+	 * not match with overflown event.
+	 */
+	if ((cpuc->brbe_sample_type != event->attr.branch_sample_type) ||
+	    (event->ctx->task && cpuc->brbe_context != event->ctx))
+		return;
+
+	/*
+	 * Read the branch records from the hardware once after the PMU IRQ
+	 * has been triggered but subsequently same records can be used for
+	 * other events that might have been overflowed simultaneously thus
+	 * saving much CPU cycles.
+	 */
+	if (!*branch_captured) {
+		armv8pmu_branch_read(cpuc, event);
+		*branch_captured = true;
+	}
+	perf_sample_save_brstack(data, event, &cpuc->branches->branch_stack, NULL);
+}
+
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u32 pmovsr;
@@ -844,6 +887,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
+	bool branch_captured = false;
 
 	/*
 	 * Get and reset the IRQ flags
@@ -887,6 +931,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		/*
+		 * PMU IRQ should remain asserted until all branch records
+		 * are captured and processed into struct perf_sample_data.
+		 */
+		if (has_branch_stack(event) && cpu_pmu->has_branch_stack)
+			read_branch_records(cpuc, event, &data, &branch_captured);
+
 		/*
 		 * Perf event overflow will queue the processing of the event as
 		 * an irq_work which will be taken care of in the handling of
@@ -896,6 +947,8 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 			cpu_pmu->disable(event);
 	}
 	armv8pmu_start(cpu_pmu);
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_reset();
 
 	return IRQ_HANDLED;
 }
@@ -985,6 +1038,24 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
+{
+	struct arm_pmu *armpmu = to_arm_pmu(pmu_ctx->pmu);
+	void *task_ctx = pmu_ctx->task_ctx_data;
+
+	if (armpmu->has_branch_stack) {
+		/* Save branch records in task_ctx on sched out */
+		if (task_ctx && !sched_in) {
+			armv8pmu_branch_save(armpmu, task_ctx);
+			return;
+		}
+
+		/* Reset branch records on sched in */
+		if (sched_in)
+			armv8pmu_branch_reset();
+	}
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1077,6 +1148,9 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_reset();
 }
 
 static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
@@ -1114,6 +1188,20 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 
 	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
 
+	if (has_branch_stack(event)) {
+		if (!armv8pmu_branch_attr_valid(event))
+			return -EOPNOTSUPP;
+
+		/*
+		 * If a task gets scheduled out, the current branch records
+		 * get saved in the task's context data, which can be later
+		 * used to fill in the records upon an event overflow. Let's
+		 * enable PERF_ATTACH_TASK_DATA in 'event->attach_state' for
+		 * all branch stack sampling perf events.
+		 */
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
+	}
+
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
 	 * never makes sense for a user to open one in isolation, as they'll be
@@ -1229,6 +1317,41 @@ static void __armv8pmu_probe_pmu(void *info)
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
+
+	/*
+	 * BRBE is being probed on a single cpu for a
+	 * given PMU. The remaining cpus, are assumed
+	 * to have the exact same BRBE implementation.
+	 */
+	armv8pmu_branch_probe(cpu_pmu);
+}
+
+static int branch_records_alloc(struct arm_pmu *armpmu)
+{
+	struct branch_records __percpu *records;
+	int cpu;
+
+	records = alloc_percpu_gfp(struct branch_records, GFP_KERNEL);
+	if (!records)
+		return -ENOMEM;
+
+	/*
+	 * percpu memory allocated for 'records' gets completely consumed
+	 * here, and never required to be freed up later. So permanently
+	 * losing access to this anchor i.e 'records' is acceptable.
+	 *
+	 * Otherwise this allocation handle would have to be saved up for
+	 * free_percpu() release later if required.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct pmu_hw_events *events_cpu;
+		struct branch_records *records_cpu;
+
+		events_cpu = per_cpu_ptr(armpmu->hw_events, cpu);
+		records_cpu = per_cpu_ptr(records, cpu);
+		events_cpu->branches = records_cpu;
+	}
+	return 0;
 }
 
 static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
@@ -1245,7 +1368,21 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	if (ret)
 		return ret;
 
-	return probe.present ? 0 : -ENODEV;
+	if (!probe.present)
+		return -ENODEV;
+
+	if (cpu_pmu->has_branch_stack) {
+		ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
+		if (ret)
+			return ret;
+
+		ret = branch_records_alloc(cpu_pmu);
+		if (ret) {
+			armv8pmu_task_ctx_cache_free(cpu_pmu);
+			return ret;
+		}
+	}
+	return 0;
 }
 
 static void armv8pmu_disable_user_access_ipi(void *unused)
@@ -1304,6 +1441,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
+	cpu_pmu->branch_reset		= armv8pmu_branch_reset;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
diff --git a/drivers/perf/arm_pmuv3_branch.h b/drivers/perf/arm_pmuv3_branch.h
new file mode 100644
index 000000000000..609e4d4ccac6
--- /dev/null
+++ b/drivers/perf/arm_pmuv3_branch.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Branch Record Buffer Extension Helpers.
+ *
+ * Copyright (C) 2022-2023 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include <linux/perf/arm_pmu.h>
+
+static inline void armv8pmu_branch_reset(void)
+{
+}
+
+static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu)
+{
+}
+
+static inline bool armv8pmu_branch_attr_valid(struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+	return false;
+}
+
+static inline void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)
+{
+}
+
+static inline void armv8pmu_branch_disable(void)
+{
+}
+
+static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc,
+					struct perf_event *event)
+{
+	WARN_ON_ONCE(!has_branch_stack(event));
+}
+
+static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
+{
+}
+
+static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)
+{
+	return 0;
+}
+
+static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)
+{
+}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index b3b34f6670cf..8cfcc735c0f7 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -46,6 +46,18 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_63BIT) == ARMPMU_EVT_63BIT);
 	},								\
 }
 
+/*
+ * Maximum branch record entries which could be processed
+ * for core perf branch stack sampling support, regardless
+ * of the hardware support available on a given ARM PMU.
+ */
+#define MAX_BRANCH_RECORDS 64
+
+struct branch_records {
+	struct perf_branch_stack	branch_stack;
+	struct perf_branch_entry	branch_entries[MAX_BRANCH_RECORDS];
+};
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
@@ -66,6 +78,17 @@ struct pmu_hw_events {
 	struct arm_pmu		*percpu_pmu;
 
 	int irq;
+
+	struct branch_records	*branches;
+
+	/* Active context for task events */
+	void			*brbe_context;
+
+	/* Active events requesting branch records */
+	unsigned int		brbe_users;
+
+	/* Active branch sample type filters */
+	unsigned long		brbe_sample_type;
 };
 
 enum armpmu_attr_groups {
@@ -96,8 +119,12 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+	void		(*branch_reset)(void);
 	int		num_events;
-	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	secure_access	: 1, /* 32-bit ARM only */
+			has_branch_stack: 1, /* 64-bit ARM only */
+			reserved	: 30;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 46377e134d67..c3e7d2cfb737 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -308,5 +308,4 @@
 		default: WARN(1, "Invalid PMEV* index\n");	\
 		}						\
 	} while (0)
-
 #endif
-- 
2.25.1


