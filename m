Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C727EA9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjKNFON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjKNFOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:14:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 347B6D71;
        Mon, 13 Nov 2023 21:14:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 375F8153B;
        Mon, 13 Nov 2023 21:14:49 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF0683F7B4;
        Mon, 13 Nov 2023 21:13:58 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [V14 3/8] drivers: perf: arm_pmuv3: Enable branch stack sampling framework
Date:   Tue, 14 Nov 2023 10:43:24 +0530
Message-Id: <20231114051329.327572-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114051329.327572-1-anshuman.khandual@arm.com>
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
. This adds required function callbacks in armv8pmu_branch_xxx() format, to
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
Changes in V14:

- Folded the following three patches from V13 series into this single patch

  drivers: perf: arm_pmu: Add new sched_task() callback
  arm64/perf: Add branch stack support in struct arm_pmu
  arm64/perf: Add branch stack support in struct pmu_hw_events
  arm64/perf: Add branch stack support in ARMV8 PMU

- All armv8pmu_branch_xxxx() stub definitions have been moved inside
  include/linux/perf/arm_pmuv3.h for easy access from both arm32 and
  arm64 platforms

- Added brbe_users, brbe_context and brbe_sample_type struct pmu_hw_events
- Added branch_reset() and sched_task() callbacks

- Changed and optimized branch records processing during a PMU IRQ
- NO branch records get captured for event with mismatched brbe_sample_type

- Branch record context is tracked from armpmu_del() & armpmu_add()
- Branch record hardware is driven from armv8pmu_start() & armv8pmu_stop()

 drivers/perf/arm_pmu.c         |  41 +++++++++-
 drivers/perf/arm_pmuv3.c       | 141 ++++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h   |  29 ++++++-
 include/linux/perf/arm_pmuv3.h |  46 +++++++++++
 4 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d712a19e47ac..76f1376ae594 100644
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
@@ -333,6 +342,22 @@ armpmu_add(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
 
+	if (has_branch_stack(event)) {
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
@@ -512,13 +537,24 @@ static int armpmu_event_init(struct perf_event *event)
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
@@ -865,6 +901,7 @@ struct arm_pmu *armpmu_alloc(void)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6ca7be05229c..7f973c77a95e 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -751,14 +751,63 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
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
 
+/*
+ * This is a read only constant and safe during multi threaded access
+ */
+static struct perf_branch_stack zero_branch_stack = { .nr = 0, .hw_idx = -1ULL};
+
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
+	    (event->ctx->task && cpuc->brbe_context != event->ctx)) {
+		perf_sample_save_brstack(data, event, &zero_branch_stack);
+		return;
+	}
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
+	perf_sample_save_brstack(data, event, &cpuc->branches->branch_stack);
+}
+
 static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 {
 	u32 pmovsr;
@@ -766,6 +815,7 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
 	int idx;
+	bool branch_captured = false;
 
 	/*
 	 * Get and reset the IRQ flags
@@ -809,6 +859,13 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
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
@@ -818,6 +875,8 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 			cpu_pmu->disable(event);
 	}
 	armv8pmu_start(cpu_pmu);
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_reset();
 
 	return IRQ_HANDLED;
 }
@@ -907,6 +966,24 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
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
@@ -977,6 +1054,9 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_reset();
 }
 
 static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
@@ -1014,6 +1094,20 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 
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
@@ -1130,6 +1224,35 @@ static void __armv8pmu_probe_pmu(void *info)
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
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
@@ -1146,7 +1269,21 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
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
@@ -1205,6 +1342,8 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
+	cpu_pmu->branch_reset		= armv8pmu_branch_reset;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 143fbc10ecfe..a489fdf163b4 100644
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
@@ -72,6 +84,17 @@ struct pmu_hw_events {
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
@@ -102,8 +125,12 @@ struct arm_pmu {
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
index 9c226adf938a..72da4522397c 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -303,4 +303,50 @@
 		}						\
 	} while (0)
 
+struct pmu_hw_events;
+struct arm_pmu;
+struct perf_event;
+
+#ifdef CONFIG_PERF_EVENTS
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
+#endif /* CONFIG_PERF_EVENTS */
 #endif
-- 
2.25.1

