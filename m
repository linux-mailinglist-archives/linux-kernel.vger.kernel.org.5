Return-Path: <linux-kernel+bounces-132340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DF89935C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDF1F2374E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6620B0F;
	Fri,  5 Apr 2024 02:47:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632C17753;
	Fri,  5 Apr 2024 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285235; cv=none; b=IDlUJWEf1uqtgGwaVAViZKp6UEThqspQC/02ToXQjuWaOH6c2iZztJynL5pjOoBuWJKhXPWZUWZSuC53F2BDtAMknomHKt617sIt6YefhaKnOBOI1AmSsIeDhYyDth6BfOBEZe1+JZ+3mRLczwGypZNEyUXQ/jbXzfUzFFjMsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285235; c=relaxed/simple;
	bh=EHNN8gxcP0mvWTDSeJV0as52ujxSQR7IIlVMfz/G+jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPt/ISazRWt2z7r+PFdrkXOzem+OgOTa8DxWa36ygdU8QQa9CrXQnDvpWNdsOpSP1KFykA1Y/jpOrU56vea+e8PPgAOLOCLbio2I1lC2l9/dgw+1U0Qby4Z0cdkTnJ/mOWoM4cv4qiqk/Ji6hd0QDOxXiC5JG17Y6FZLBpv9zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA93F1007;
	Thu,  4 Apr 2024 19:47:43 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50AAA3F766;
	Thu,  4 Apr 2024 19:47:08 -0700 (PDT)
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
Subject: [PATCH V17 3/9] drivers: perf: arm_pmu: Add infrastructure for branch stack sampling
Date: Fri,  5 Apr 2024 08:16:33 +0530
Message-Id: <20240405024639.1179064-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405024639.1179064-1-anshuman.khandual@arm.com>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support the Branch Record Buffer Extension (BRBE), we need to
extend the arm_pmu framework with some basic infrastructure for the branch
stack sampling which arm_pmu drivers can opt-in using a new feature flag
called 'has_branch_stack'. Subsequent patches will use this to add support
for BRBE in the PMUv3 driver.

Branch stack sampling support i.e capturing branch records during execution
in core perf, rides along with normal HW events being scheduled on the PMU.
This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
with required HW implementation.

With BRBE, the hardware records branches into a hardware FIFO, which will
be sampled by software when perf events overflow. A task may be context-
switched an arbitrary number of times between overflows, and to avoid
losing samples we need to save the current records when a task is context-
switched out. To do these we'll need to use the pmu::sched_task() callback,
and we'll also need to allocate some per-task storage space via event flag
PERF_ATTACH_TASK_DATA.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V17:

- ARM PMUV3 changes have been moved into the BRBE driver patch instead
- Moved down branch_stack_add() in armpmu_add() after event's basic checks
- Added new callbacks in struct arm_pmu e.g branch_stack_[init|add|del]()
- Renamed struct arm_pmu callback branch_reset() as branch_stack_reset()
- Dropped the comment in armpmu_event_init()
- Renamed 'pmu_hw_events' elements from 'brbe_' to more generic 'branch_'

 drivers/perf/arm_pmu.c       | 25 ++++++++++++++++++++++---
 include/linux/perf/arm_pmu.h | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8458fe2cebb4..e694103e811f 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -317,6 +317,9 @@ armpmu_del(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
+	if (has_branch_stack(event))
+		armpmu->branch_stack_del(event, hw_events);
+
 	armpmu_stop(event, PERF_EF_UPDATE);
 	hw_events->events[idx] = NULL;
 	armpmu->clear_event_idx(hw_events, event);
@@ -342,6 +345,9 @@ armpmu_add(struct perf_event *event, int flags)
 	if (idx < 0)
 		return idx;
 
+	if (has_branch_stack(event))
+		armpmu->branch_stack_add(event, hw_events);
+
 	/*
 	 * If there is an event in the counter we are going to use then make
 	 * sure it is disabled.
@@ -511,13 +517,25 @@ static int armpmu_event_init(struct perf_event *event)
 		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
 		return -ENOENT;
 
-	/* does not support taken branch sampling */
-	if (has_branch_stack(event))
-		return -EOPNOTSUPP;
+	if (has_branch_stack(event)) {
+		if (!armpmu->has_branch_stack)
+			return -EOPNOTSUPP;
+
+		if (!armpmu->branch_stack_init(event))
+			return -EOPNOTSUPP;
+	}
 
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
@@ -864,6 +882,7 @@ struct arm_pmu *armpmu_alloc(void)
 	}
 
 	pmu->pmu = (struct pmu) {
+		.sched_task	= armpmu_sched_task,
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index b3b34f6670cf..9eda16dd684e 100644
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
+	void			*branch_context;
+
+	/* Active events requesting branch records */
+	unsigned int		branch_users;
+
+	/* Active branch sample type filters */
+	unsigned long		branch_sample_type;
 };
 
 enum armpmu_attr_groups {
@@ -96,8 +119,15 @@ struct arm_pmu {
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
+	bool		(*branch_stack_init)(struct perf_event *event);
+	void		(*branch_stack_add)(struct perf_event *event, struct pmu_hw_events *cpuc);
+	void		(*branch_stack_del)(struct perf_event *event, struct pmu_hw_events *cpuc);
+	void		(*branch_stack_reset)(void);
 	int		num_events;
-	bool		secure_access; /* 32-bit ARM only */
+	unsigned int	secure_access	: 1, /* 32-bit ARM only */
+			has_branch_stack: 1, /* 64-bit ARM only */
+			reserved	: 30;
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
-- 
2.25.1


