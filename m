Return-Path: <linux-kernel+bounces-132343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D8899360
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66E6282903
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFAB1BDDB;
	Fri,  5 Apr 2024 02:47:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5623748;
	Fri,  5 Apr 2024 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285249; cv=none; b=r+6p0LkeaN5Z1MbOdQz0K0c2deCvnvZW3qBvs+GHU/YQNmLDPT5+9BQ0ZNpO5A/VJGaRy4BbWZrc4voGYZUhfE0kQN9+fy6XzJUnwa849ry6KqnRefFIeUpAYpkbDky3gQgAR6h41uW8bfUYET8p1vSI7jRhdPVtKWN0RVhU550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285249; c=relaxed/simple;
	bh=HjRN0OuBAADAp6ipJzjN6OnSIyntpICbneRIvx7fqlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+vV9Oop0fU++oigp4pV32sDAlpi5ya6rHXu+Nh7MbuNwhCGyHehKTEoo7MQasOrwlxHq2s2t30KVsK+quGg6PAf0o8JW7OvTtqCTvJwhhqF6ZzTblYdUiR2iVxwDPg0C/9IffCmMa1fGlYNSEKTwc5Wi+l3hJBqq+Wu5gCQ+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB3F1007;
	Thu,  4 Apr 2024 19:47:56 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96F2D3F766;
	Thu,  4 Apr 2024 19:47:20 -0700 (PDT)
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
Subject: [PATCH V17 5/9] drivers: perf: arm_pmuv3: Enable branch stack sampling via FEAT_BRBE
Date: Fri,  5 Apr 2024 08:16:35 +0530
Message-Id: <20240405024639.1179064-6-anshuman.khandual@arm.com>
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

This extends recently added branch stack sampling framework in ARMV8 PMU to
enable such events via new architecture feature called Branch Record Buffer
Extension aka BRBE. This implements all the armv8pmu_branch_xxx() callbacks
as expected at ARMV8 PMU level required to drive perf branch stack sampling
events. This adds a new config option CONFIG_ARM64_BRBE to encapsulate this
BRBE based implementation, available only on ARM64 platforms.

BRBE hardware captures a branch record via three distinct system registers
representing branch source address, branch target address, and other branch
information. A BRBE buffer implementation is organized as multiple banks of
32 branch records each, which is a collection of BRBSRC_EL1, BRBTGT_EL1 and
BRBINF_EL1 registers. Though total BRBE record entries i.e BRBE_MAX_ENTRIES
cannot exceed MAX_BRANCH_RECORDS as defined for ARM PMU.

Branch stack sampling is enabled and disabled along with regular PMU events
 This adds required function callbacks in armv8pmu_branch_xxx() format, to
drive the PMU branch stack hardware when supported. This also adds fallback
stub definitions for these callbacks for PMUs which would not have required
support.

BRBE hardware attributes get captured in a new reg_brbidr element in struct
arm_pmu during armv8pmu_branch_probe() which is called from broader probing
function __armv8pmu_probe_pmu(). Attributes such as number of branch record
entries implemented in the hardware can be derived from armpmu->reg_brbidr.

BRBE gets enabled via armv8pmu_branch_enable() where it also derives branch
filter, and additional requirements from event's 'attr.branch_sample_type'
and configures them via BRBFCR_EL1 and BRBCR_EL1 registers.

PMU event overflow triggers IRQ, where current branch records get captured,
stitched along with older records available in 'task_ctx', before getting
processed for core perf ring buffer. Task context switch outs incrementally
save current branch records in event's 'pmu_ctx->task_ctx_data' to optimize
workload's branch record samples.

In case multiple events with different branch sample type requests converge
on the same PMU, BRBE gets enabled for branch filters for the last event's
branch sample type. No branch records will be captured and processed for an
event if BRBE hardware config does not match its branch sample type, while
handling the PMU IRQ.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V17:

- Dropped Documentation/arch/arm64/brbe.rst
- Renamed armv8pmu_branch_reset() as armv8pmu_branch_stack_reset()
- Separated out booting.rst and EL2 boot requirements into a new patch
- Moved ARM PMUV3 changes into this patch
- Dropped process_branch_aborts() completely
- Added an warning if transaction states get detected unexpectedly
- Dropped enum brbe_bank_idx from the driver
- Defined armv8pmu_branch_stack_init/add/del() callbacks in the driver
- Changed BRBE driver to use existing SYS_BRBSRC/TGT/INF_EL1(n) format

 drivers/perf/Kconfig            |  11 +
 drivers/perf/Makefile           |   1 +
 drivers/perf/arm_brbe.c         | 968 ++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmuv3.c        | 146 ++++-
 drivers/perf/arm_pmuv3_branch.h |  73 +++
 include/linux/perf/arm_pmu.h    |   5 +
 6 files changed, 1203 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/arm_brbe.c
 create mode 100644 drivers/perf/arm_pmuv3_branch.h

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 7526a9e714fa..a8ce723642f0 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -204,6 +204,17 @@ config ARM_SPE_PMU
 	  Extension, which provides periodic sampling of operations in
 	  the CPU pipeline and reports this via the perf AUX interface.
 
+config ARM64_BRBE
+	bool "Enable support for branch stack sampling using FEAT_BRBE"
+	depends on PERF_EVENTS && ARM64 && ARM_PMU
+	default y
+	help
+	  Enable perf support for Branch Record Buffer Extension (BRBE) which
+	  records all branches taken in an execution path. This supports some
+	  branch types and privilege based filtering. It captures additional
+	  relevant information such as cycle count, misprediction and branch
+	  type, branch privilege level etc.
+
 config ARM_DMC620_PMU
 	tristate "Enable PMU support for the ARM DMC-620 memory controller"
 	depends on (ARM64 && ACPI) || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 29b1c28203ef..7f9b2b67fea2 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_STARFIVE_STARLINK_PMU) += starfive_starlink_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
+obj-$(CONFIG_ARM64_BRBE) += arm_brbe.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
new file mode 100644
index 000000000000..762c643506a1
--- /dev/null
+++ b/drivers/perf/arm_brbe.c
@@ -0,0 +1,968 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2022-2023 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "arm_pmuv3_branch.h"
+
+#define BRBFCR_EL1_BRANCH_FILTERS (BRBFCR_EL1_DIRECT   | \
+				   BRBFCR_EL1_INDIRECT | \
+				   BRBFCR_EL1_RTN      | \
+				   BRBFCR_EL1_INDCALL  | \
+				   BRBFCR_EL1_DIRCALL  | \
+				   BRBFCR_EL1_CONDDIR)
+
+#define BRBFCR_EL1_CONFIG_MASK    (BRBFCR_EL1_BANK_MASK | \
+				   BRBFCR_EL1_PAUSED    | \
+				   BRBFCR_EL1_EnI       | \
+				   BRBFCR_EL1_BRANCH_FILTERS)
+
+/*
+ * BRBTS_EL1 is currently not used for branch stack implementation
+ * purpose but BRBCR_ELx.TS needs to have a valid value from all
+ * available options. BRBCR_ELx_TS_VIRTUAL is selected for this.
+ */
+#define BRBCR_ELx_DEFAULT_TS      FIELD_PREP(BRBCR_ELx_TS_MASK, BRBCR_ELx_TS_VIRTUAL)
+
+#define BRBCR_ELx_CONFIG_MASK     (BRBCR_ELx_EXCEPTION | \
+				   BRBCR_ELx_ERTN      | \
+				   BRBCR_ELx_CC        | \
+				   BRBCR_ELx_MPRED     | \
+				   BRBCR_ELx_ExBRE     | \
+				   BRBCR_ELx_E0BRE     | \
+				   BRBCR_ELx_FZP       | \
+				   BRBCR_ELx_TS_MASK)
+
+/*
+ * BRBE Buffer Organization
+ *
+ * BRBE buffer is arranged as multiple banks of 32 branch record
+ * entries each. An individual branch record in a given bank could
+ * be accessed, after selecting the bank in BRBFCR_EL1.BANK and
+ * accessing the registers i.e [BRBSRC, BRBTGT, BRBINF] set with
+ * indices [0..31].
+ *
+ * Bank 0
+ *
+ *	---------------------------------	------
+ *	| 00 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 01 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 31 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ *
+ * Bank 1
+ *
+ *	---------------------------------	------
+ *	| 32 | BRBSRC | BRBTGT | BRBINF |	| 00 |
+ *	---------------------------------	------
+ *	| 33 | BRBSRC | BRBTGT | BRBINF |	| 01 |
+ *	---------------------------------	------
+ *	| .. | BRBSRC | BRBTGT | BRBINF |	| .. |
+ *	---------------------------------	------
+ *	| 63 | BRBSRC | BRBTGT | BRBINF |	| 31 |
+ *	---------------------------------	------
+ */
+#define BRBE_BANK_MAX_ENTRIES 32
+#define BRBE_MAX_BANK 2
+#define BRBE_MAX_ENTRIES (BRBE_BANK_MAX_ENTRIES * BRBE_MAX_BANK)
+
+#define BRBE_BANK0_IDX_MIN 0
+#define BRBE_BANK0_IDX_MAX 31
+#define BRBE_BANK1_IDX_MIN 32
+#define BRBE_BANK1_IDX_MAX 63
+
+struct brbe_regset {
+	unsigned long brbsrc;
+	unsigned long brbtgt;
+	unsigned long brbinf;
+};
+
+struct arm64_perf_task_context {
+	struct brbe_regset store[BRBE_MAX_ENTRIES];
+	int nr_brbe_records;
+};
+
+struct brbe_hw_attr {
+	int	brbe_version;
+	int	brbe_cc;
+	int	brbe_nr;
+	int	brbe_format;
+};
+
+#define RETURN_READ_BRBSRCN(n) \
+	read_sysreg_s(SYS_BRBSRC_EL1(n))
+
+#define RETURN_READ_BRBTGTN(n) \
+	read_sysreg_s(SYS_BRBTGT_EL1(n))
+
+#define RETURN_READ_BRBINFN(n) \
+	read_sysreg_s(SYS_BRBINF_EL1(n))
+
+#define BRBE_REGN_CASE(n, case_macro) \
+	case n: return case_macro(n); break
+
+#define BRBE_REGN_SWITCH(x, case_macro)				\
+	do {							\
+		switch (x) {					\
+		BRBE_REGN_CASE(0, case_macro);			\
+		BRBE_REGN_CASE(1, case_macro);			\
+		BRBE_REGN_CASE(2, case_macro);			\
+		BRBE_REGN_CASE(3, case_macro);			\
+		BRBE_REGN_CASE(4, case_macro);			\
+		BRBE_REGN_CASE(5, case_macro);			\
+		BRBE_REGN_CASE(6, case_macro);			\
+		BRBE_REGN_CASE(7, case_macro);			\
+		BRBE_REGN_CASE(8, case_macro);			\
+		BRBE_REGN_CASE(9, case_macro);			\
+		BRBE_REGN_CASE(10, case_macro);			\
+		BRBE_REGN_CASE(11, case_macro);			\
+		BRBE_REGN_CASE(12, case_macro);			\
+		BRBE_REGN_CASE(13, case_macro);			\
+		BRBE_REGN_CASE(14, case_macro);			\
+		BRBE_REGN_CASE(15, case_macro);			\
+		BRBE_REGN_CASE(16, case_macro);			\
+		BRBE_REGN_CASE(17, case_macro);			\
+		BRBE_REGN_CASE(18, case_macro);			\
+		BRBE_REGN_CASE(19, case_macro);			\
+		BRBE_REGN_CASE(20, case_macro);			\
+		BRBE_REGN_CASE(21, case_macro);			\
+		BRBE_REGN_CASE(22, case_macro);			\
+		BRBE_REGN_CASE(23, case_macro);			\
+		BRBE_REGN_CASE(24, case_macro);			\
+		BRBE_REGN_CASE(25, case_macro);			\
+		BRBE_REGN_CASE(26, case_macro);			\
+		BRBE_REGN_CASE(27, case_macro);			\
+		BRBE_REGN_CASE(28, case_macro);			\
+		BRBE_REGN_CASE(29, case_macro);			\
+		BRBE_REGN_CASE(30, case_macro);			\
+		BRBE_REGN_CASE(31, case_macro);			\
+		default:					\
+			pr_warn("unknown register index\n");	\
+			return -1;				\
+		}						\
+	} while (0)
+
+static inline int buffer_to_brbe_idx(int buffer_idx)
+{
+	return buffer_idx % BRBE_BANK_MAX_ENTRIES;
+}
+
+static inline u64 get_brbsrc_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBSRCN);
+}
+
+static inline u64 get_brbtgt_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBTGTN);
+}
+
+static inline u64 get_brbinf_reg(int buffer_idx)
+{
+	int brbe_idx = buffer_to_brbe_idx(buffer_idx);
+
+	BRBE_REGN_SWITCH(brbe_idx, RETURN_READ_BRBINFN);
+}
+
+static inline u64 brbe_record_valid(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_VALID_MASK, brbinf);
+}
+
+static inline bool brbe_invalid(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_NONE;
+}
+
+static inline bool brbe_record_is_complete(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_FULL;
+}
+
+static inline bool brbe_record_is_source_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_SOURCE;
+}
+
+static inline bool brbe_record_is_target_only(u64 brbinf)
+{
+	return brbe_record_valid(brbinf) == BRBINFx_EL1_VALID_TARGET;
+}
+
+static inline int brbe_get_in_tx(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_T_MASK, brbinf);
+}
+
+static inline int brbe_get_mispredict(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_MPRED_MASK, brbinf);
+}
+
+static inline int brbe_get_lastfailed(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_LASTFAILED_MASK, brbinf);
+}
+
+static inline int brbe_get_cycles(u64 brbinf)
+{
+	/*
+	 * Captured cycle count is unknown and hence
+	 * should not be passed on to the user space.
+	 */
+	if (brbinf & BRBINFx_EL1_CCU)
+		return 0;
+
+	return FIELD_GET(BRBINFx_EL1_CC_MASK, brbinf);
+}
+
+static inline int brbe_get_type(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_TYPE_MASK, brbinf);
+}
+
+static inline int brbe_get_el(u64 brbinf)
+{
+	return FIELD_GET(BRBINFx_EL1_EL_MASK, brbinf);
+}
+
+static inline int brbe_get_numrec(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_NUMREC_MASK, brbidr);
+}
+
+static inline int brbe_get_format(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_FORMAT_MASK, brbidr);
+}
+
+static inline int brbe_get_cc_bits(u64 brbidr)
+{
+	return FIELD_GET(BRBIDR0_EL1_CC_MASK, brbidr);
+}
+
+void armv8pmu_branch_stack_reset(void)
+{
+	asm volatile(BRB_IALL_INSN);
+	isb();
+}
+
+void armv8pmu_branch_stack_add(struct perf_event *event, struct pmu_hw_events *hw_events)
+{
+	/*
+	 * Reset branch records buffer if a new CPU bound event
+	 * gets scheduled on a PMU. Otherwise existing branch
+	 * records present in the buffer might just leak into
+	 * such events.
+	 *
+	 * Also reset current 'hw_events->branch_context' because
+	 * any previous task bound event now would have lost an
+	 * opportunity for continuous branch records.
+	 */
+	if (!event->ctx->task) {
+		hw_events->branch_context = NULL;
+		armv8pmu_branch_stack_reset();
+	}
+
+	/*
+	 * Reset branch records buffer if a new task event gets
+	 * scheduled on a PMU which might have existing records.
+	 * Otherwise older branch records present in the buffer
+	 * might leak into the new task event.
+	 */
+	if (event->ctx->task && hw_events->branch_context != event->ctx) {
+		hw_events->branch_context = event->ctx;
+		armv8pmu_branch_stack_reset();
+	}
+	hw_events->branch_users++;
+	hw_events->branch_sample_type = event->attr.branch_sample_type;
+}
+
+void armv8pmu_branch_stack_del(struct perf_event *event, struct pmu_hw_events *hw_events)
+{
+	WARN_ON_ONCE(!hw_events->branch_users);
+	hw_events->branch_users--;
+	if (!hw_events->branch_users) {
+		hw_events->branch_context = NULL;
+		hw_events->branch_sample_type = 0;
+	}
+}
+
+static bool valid_brbe_nr(int brbe_nr)
+{
+	return brbe_nr == BRBIDR0_EL1_NUMREC_8 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_16 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_32 ||
+	       brbe_nr == BRBIDR0_EL1_NUMREC_64;
+}
+
+static bool valid_brbe_cc(int brbe_cc)
+{
+	return brbe_cc == BRBIDR0_EL1_CC_20_BIT;
+}
+
+static bool valid_brbe_format(int brbe_format)
+{
+	return brbe_format == BRBIDR0_EL1_FORMAT_0;
+}
+
+static bool valid_brbe_version(int brbe_version)
+{
+	return brbe_version == ID_AA64DFR0_EL1_BRBE_IMP ||
+	       brbe_version == ID_AA64DFR0_EL1_BRBE_BRBE_V1P1;
+}
+
+static void select_brbe_bank(int bank)
+{
+	u64 brbfcr;
+
+	WARN_ON(bank > 1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_BANK_MASK;
+	brbfcr |= SYS_FIELD_PREP(BRBFCR_EL1, BANK, bank);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+}
+
+static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
+{
+	entry->brbinf = get_brbinf_reg(idx);
+
+	if (brbe_invalid(entry->brbinf))
+		return false;
+
+	entry->brbsrc = get_brbsrc_reg(idx);
+	entry->brbtgt = get_brbtgt_reg(idx);
+	return true;
+}
+
+/*
+ * Read all BRBE entries in HW until the first invalid entry.
+ *
+ * The caller must ensure that the BRBE is not concurrently modifying these
+ * branch entries.
+ */
+static int capture_brbe_regset(struct brbe_regset *buf, int nr_hw_entries)
+{
+	int idx = 0;
+
+	select_brbe_bank(0);
+	while (idx < nr_hw_entries && idx <= BRBE_BANK0_IDX_MAX) {
+		if (!__read_brbe_regset(&buf[idx], idx))
+			return idx;
+		idx++;
+	}
+
+	select_brbe_bank(1);
+	while (idx < nr_hw_entries && idx <= BRBE_BANK1_IDX_MAX) {
+		if (!__read_brbe_regset(&buf[idx], idx))
+			return idx;
+		idx++;
+	}
+	return idx;
+}
+
+/*
+ * This function concatenates branch records from stored and live buffer
+ * up to maximum nr_max records and the stored buffer holds the resultant
+ * buffer. The concatenated buffer contains all the branch records from
+ * the live buffer but might contain some from stored buffer considering
+ * the maximum combined length does not exceed 'nr_max'.
+ *
+ *	Stored records	Live records
+ *	------------------------------------------------^
+ *	|	S0	|	L0	|	Newest	|
+ *	---------------------------------		|
+ *	|	S1	|	L1	|		|
+ *	---------------------------------		|
+ *	|	S2	|	L2	|		|
+ *	---------------------------------		|
+ *	|	S3	|	L3	|		|
+ *	---------------------------------		|
+ *	|	S4	|	L4	|		nr_max
+ *	---------------------------------		|
+ *	|		|	L5	|		|
+ *	---------------------------------		|
+ *	|		|	L6	|		|
+ *	---------------------------------		|
+ *	|		|	L7	|		|
+ *	---------------------------------		|
+ *	|		|		|		|
+ *	---------------------------------		|
+ *	|		|		|	Oldest	|
+ *	------------------------------------------------V
+ *
+ *
+ * S0 is the newest in the stored records, where as L7 is the oldest in
+ * the live records. Unless the live buffer is detected as being full
+ * thus potentially dropping off some older records, L7 and S0 records
+ * are contiguous in time for a user task context. The stitched buffer
+ * here represents maximum possible branch records, contiguous in time.
+ *
+ *	Stored records  Live records
+ *	------------------------------------------------^
+ *	|	L0	|	L0	|	Newest	|
+ *	---------------------------------		|
+ *	|	L1	|	L1	|		|
+ *	---------------------------------		|
+ *	|	L2	|	L2	|		|
+ *	---------------------------------		|
+ *	|	L3	|	L3	|		|
+ *	---------------------------------		|
+ *	|	L4	|	L4	|	      nr_max
+ *	---------------------------------		|
+ *	|	L5	|	L5	|		|
+ *	---------------------------------		|
+ *	|	L6	|	L6	|		|
+ *	---------------------------------		|
+ *	|	L7	|	L7	|		|
+ *	---------------------------------		|
+ *	|	S0	|		|		|
+ *	---------------------------------		|
+ *	|	S1	|		|    Oldest	|
+ *	------------------------------------------------V
+ *	|	S2	| <----|
+ *	-----------------      |
+ *	|	S3	| <----| Dropped off after nr_max
+ *	-----------------      |
+ *	|	S4	| <----|
+ *	-----------------
+ */
+static int stitch_stored_live_entries(struct brbe_regset *stored,
+				      struct brbe_regset *live,
+				      int nr_stored, int nr_live,
+				      int nr_max)
+{
+	int nr_move = min(nr_stored, nr_max - nr_live);
+
+	/* Move the tail of the buffer to make room for the new entries */
+	memmove(&stored[nr_live], &stored[0], nr_move * sizeof(*stored));
+
+	/* Copy the new entries into the head of the buffer */
+	memcpy(&stored[0], &live[0], nr_live * sizeof(*stored));
+
+	/* Return the number of entries in the stitched buffer */
+	return min(nr_live + nr_stored, nr_max);
+}
+
+static int brbe_branch_save(struct brbe_regset *live, int nr_hw_entries)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	int nr_live;
+
+	write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	nr_live = capture_brbe_regset(live, nr_hw_entries);
+
+	write_sysreg_s(brbfcr & ~BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
+	isb();
+
+	return nr_live;
+}
+
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx)
+{
+	struct arm64_perf_task_context *task_ctx = ctx;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store, nr_hw_entries;
+
+	nr_hw_entries = brbe_get_numrec(arm_pmu->reg_brbidr);
+	nr_live = brbe_branch_save(live, nr_hw_entries);
+	nr_store = task_ctx->nr_brbe_records;
+	nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+					      nr_live, nr_hw_entries);
+	task_ctx->nr_brbe_records = nr_store;
+}
+
+/*
+ * Generic perf branch filters supported on BRBE
+ *
+ * New branch filters need to be evaluated whether they could be supported on
+ * BRBE. This ensures that such branch filters would not just be accepted, to
+ * fail silently. PERF_SAMPLE_BRANCH_HV is a special case that is selectively
+ * supported only on platforms where kernel is in hyp mode.
+ */
+#define BRBE_EXCLUDE_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_ABORT_TX	| \
+				     PERF_SAMPLE_BRANCH_IN_TX		| \
+				     PERF_SAMPLE_BRANCH_NO_TX		| \
+				     PERF_SAMPLE_BRANCH_CALL_STACK	| \
+				     PERF_SAMPLE_BRANCH_COUNTERS)
+
+#define BRBE_ALLOWED_BRANCH_FILTERS (PERF_SAMPLE_BRANCH_USER		| \
+				     PERF_SAMPLE_BRANCH_KERNEL		| \
+				     PERF_SAMPLE_BRANCH_HV		| \
+				     PERF_SAMPLE_BRANCH_ANY		| \
+				     PERF_SAMPLE_BRANCH_ANY_CALL	| \
+				     PERF_SAMPLE_BRANCH_ANY_RETURN	| \
+				     PERF_SAMPLE_BRANCH_IND_CALL	| \
+				     PERF_SAMPLE_BRANCH_COND		| \
+				     PERF_SAMPLE_BRANCH_IND_JUMP	| \
+				     PERF_SAMPLE_BRANCH_CALL		| \
+				     PERF_SAMPLE_BRANCH_NO_FLAGS	| \
+				     PERF_SAMPLE_BRANCH_NO_CYCLES	| \
+				     PERF_SAMPLE_BRANCH_TYPE_SAVE	| \
+				     PERF_SAMPLE_BRANCH_HW_INDEX	| \
+				     PERF_SAMPLE_BRANCH_PRIV_SAVE)
+
+#define BRBE_PERF_BRANCH_FILTERS    (BRBE_ALLOWED_BRANCH_FILTERS	| \
+				     BRBE_EXCLUDE_BRANCH_FILTERS)
+
+bool armv8pmu_branch_attr_valid(struct perf_event *event)
+{
+	u64 branch_type = event->attr.branch_sample_type;
+
+	/*
+	 * Ensure both perf branch filter allowed and exclude
+	 * masks are always in sync with the generic perf ABI.
+	 */
+	BUILD_BUG_ON(BRBE_PERF_BRANCH_FILTERS != (PERF_SAMPLE_BRANCH_MAX - 1));
+
+	if (branch_type & ~BRBE_ALLOWED_BRANCH_FILTERS) {
+		pr_debug_once("requested branch filter not supported 0x%llx\n", branch_type);
+		return false;
+	}
+
+	/*
+	 * If the event does not have at least one of the privilege
+	 * branch filters as in PERF_SAMPLE_BRANCH_PLM_ALL, the core
+	 * perf will adjust its value based on perf event's existing
+	 * privilege level via attr.exclude_[user|kernel|hv].
+	 *
+	 * As event->attr.branch_sample_type might have been changed
+	 * when the event reaches here, it is not possible to figure
+	 * out whether the event originally had HV privilege request
+	 * or got added via the core perf. Just report this situation
+	 * once and continue ignoring if there are other instances.
+	 */
+	if ((branch_type & PERF_SAMPLE_BRANCH_HV) && !is_kernel_in_hyp_mode())
+		pr_debug_once("hypervisor privilege filter not supported 0x%llx\n", branch_type);
+
+	return true;
+}
+
+int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)
+{
+	size_t size = sizeof(struct arm64_perf_task_context);
+
+	arm_pmu->pmu.task_ctx_cache = kmem_cache_create("arm64_brbe_task_ctx", size, 0, 0, NULL);
+	if (!arm_pmu->pmu.task_ctx_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)
+{
+	kmem_cache_destroy(arm_pmu->pmu.task_ctx_cache);
+}
+
+static int brbe_attributes_probe(struct arm_pmu *armpmu, u32 brbe)
+{
+	u64 brbidr = read_sysreg_s(SYS_BRBIDR0_EL1);
+	int brbe_version, brbe_format, brbe_cc, brbe_nr;
+
+	brbe_version = brbe;
+	brbe_format = brbe_get_format(brbidr);
+	brbe_cc = brbe_get_cc_bits(brbidr);
+	brbe_nr = brbe_get_numrec(brbidr);
+	armpmu->reg_brbidr = brbidr;
+
+	if (!valid_brbe_version(brbe_version) ||
+	   !valid_brbe_format(brbe_format) ||
+	   !valid_brbe_cc(brbe_cc) ||
+	   !valid_brbe_nr(brbe_nr))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+void armv8pmu_branch_probe(struct arm_pmu *armpmu)
+{
+	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	u32 brbe;
+
+	/*
+	 * BRBE implementation's branch entries cannot exceed maximum
+	 * branch records supported at the ARM PMU level abstraction.
+	 * Otherwise there is always a possibility of array overflow,
+	 * while processing BRBE branch records.
+	 */
+	BUILD_BUG_ON(BRBE_BANK_MAX_ENTRIES > MAX_BRANCH_RECORDS);
+
+	brbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_EL1_BRBE_SHIFT);
+	if (!brbe)
+		return;
+
+	if (brbe_attributes_probe(armpmu, brbe))
+		return;
+
+	armpmu->has_branch_stack = 1;
+}
+
+/*
+ * BRBE supports the following functional branch type filters while
+ * generating branch records. These branch filters can be enabled,
+ * either individually or as a group i.e ORing multiple filters
+ * with each other.
+ *
+ * BRBFCR_EL1_CONDDIR  - Conditional direct branch
+ * BRBFCR_EL1_DIRCALL  - Direct call
+ * BRBFCR_EL1_INDCALL  - Indirect call
+ * BRBFCR_EL1_INDIRECT - Indirect branch
+ * BRBFCR_EL1_DIRECT   - Direct branch
+ * BRBFCR_EL1_RTN      - Subroutine return
+ */
+static u64 branch_type_to_brbfcr(int branch_type)
+{
+	u64 brbfcr = 0;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		brbfcr |= BRBFCR_EL1_BRANCH_FILTERS;
+		return brbfcr;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		brbfcr |= BRBFCR_EL1_INDCALL;
+		brbfcr |= BRBFCR_EL1_DIRCALL;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		brbfcr |= BRBFCR_EL1_RTN;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_CALL)
+		brbfcr |= BRBFCR_EL1_INDCALL;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_COND)
+		brbfcr |= BRBFCR_EL1_CONDDIR;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+		brbfcr |= BRBFCR_EL1_INDIRECT;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_CALL)
+		brbfcr |= BRBFCR_EL1_DIRCALL;
+
+	return brbfcr & BRBFCR_EL1_CONFIG_MASK;
+}
+
+/*
+ * BRBE supports the following privilege mode filters while generating
+ * branch records.
+ *
+ * BRBCR_ELx_E0BRE - EL0 branch records
+ * BRBCR_ELx_ExBRE - EL1/EL2 branch records
+ *
+ * BRBE also supports the following additional functional branch type
+ * filters while generating branch records.
+ *
+ * BRBCR_ELx_EXCEPTION - Exception
+ * BRBCR_ELx_ERTN     -  Exception return
+ */
+static u64 branch_type_to_brbcr(int branch_type)
+{
+	u64 brbcr = BRBCR_ELx_DEFAULT_TS;
+
+	/*
+	 * BRBE should be paused on PMU interrupt while tracing kernel
+	 * space to stop capturing further branch records. Otherwise
+	 * interrupt handler branch records might get into the samples
+	 * which is not desired.
+	 *
+	 * BRBE need not be paused on PMU interrupt while tracing only
+	 * the user space, because it will automatically be inside the
+	 * prohibited region. But even after PMU overflow occurs, the
+	 * interrupt could still take much more cycles, before it can
+	 * be taken and by that time BRBE will have been overwritten.
+	 * Hence enable pause on PMU interrupt mechanism even for user
+	 * only traces as well.
+	 */
+	brbcr |= BRBCR_ELx_FZP;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_USER)
+		brbcr |= BRBCR_ELx_E0BRE;
+
+	/*
+	 * When running in the hyp mode, writing into BRBCR_EL1
+	 * actually writes into BRBCR_EL2 instead. Field E2BRE
+	 * is also at the same position as E1BRE.
+	 */
+	if (branch_type & PERF_SAMPLE_BRANCH_KERNEL)
+		brbcr |= BRBCR_ELx_ExBRE;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_HV) {
+		if (is_kernel_in_hyp_mode())
+			brbcr |= BRBCR_ELx_ExBRE;
+	}
+
+	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES))
+		brbcr |= BRBCR_ELx_CC;
+
+	if (!(branch_type & PERF_SAMPLE_BRANCH_NO_FLAGS))
+		brbcr |= BRBCR_ELx_MPRED;
+
+	/*
+	 * The exception and exception return branches could be
+	 * captured, irrespective of the perf event's privilege.
+	 * If the perf event does not have enough privilege for
+	 * a given exception level, then addresses which falls
+	 * under that exception level will be reported as zero
+	 * for the captured branch record, creating source only
+	 * or target only records.
+	 */
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY) {
+		brbcr |= BRBCR_ELx_EXCEPTION;
+		brbcr |= BRBCR_ELx_ERTN;
+	}
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_CALL)
+		brbcr |= BRBCR_ELx_EXCEPTION;
+
+	if (branch_type & PERF_SAMPLE_BRANCH_ANY_RETURN)
+		brbcr |= BRBCR_ELx_ERTN;
+
+	return brbcr & BRBCR_ELx_CONFIG_MASK;
+}
+
+void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)
+{
+	struct pmu_hw_events *cpuc = this_cpu_ptr(arm_pmu->hw_events);
+	u64 brbfcr, brbcr;
+
+	if (!(cpuc->branch_sample_type && cpuc->branch_users))
+		return;
+
+	/*
+	 * BRBE gets configured with a new mismatched branch sample
+	 * type request, overriding any previous branch filters.
+	 */
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_CONFIG_MASK;
+	brbfcr |= branch_type_to_brbfcr(cpuc->branch_sample_type);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~BRBCR_ELx_CONFIG_MASK;
+	brbcr |= branch_type_to_brbcr(cpuc->branch_sample_type);
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	isb();
+}
+
+void armv8pmu_branch_disable(void)
+{
+	u64 brbfcr, brbcr;
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbcr &= ~(BRBCR_ELx_E0BRE | BRBCR_ELx_ExBRE);
+	brbfcr |= BRBFCR_EL1_PAUSED;
+	write_sysreg_s(brbcr, SYS_BRBCR_EL1);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+}
+
+static void brbe_set_perf_entry_type(struct perf_branch_entry *entry, u64 brbinf)
+{
+	int brbe_type = brbe_get_type(brbinf);
+
+	switch (brbe_type) {
+	case BRBINFx_EL1_TYPE_DIRECT_UNCOND:
+		entry->type = PERF_BR_UNCOND;
+		break;
+	case BRBINFx_EL1_TYPE_INDIRECT:
+		entry->type = PERF_BR_IND;
+		break;
+	case BRBINFx_EL1_TYPE_DIRECT_LINK:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_INDIRECT_LINK:
+		entry->type = PERF_BR_IND_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_RET:
+		entry->type = PERF_BR_RET;
+		break;
+	case BRBINFx_EL1_TYPE_DIRECT_COND:
+		entry->type = PERF_BR_COND;
+		break;
+	case BRBINFx_EL1_TYPE_CALL:
+		entry->type = PERF_BR_CALL;
+		break;
+	case BRBINFx_EL1_TYPE_TRAP:
+		entry->type = PERF_BR_SYSCALL;
+		break;
+	case BRBINFx_EL1_TYPE_ERET:
+		entry->type = PERF_BR_ERET;
+		break;
+	case BRBINFx_EL1_TYPE_IRQ:
+		entry->type = PERF_BR_IRQ;
+		break;
+	case BRBINFx_EL1_TYPE_DEBUG_HALT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_HALT;
+		break;
+	case BRBINFx_EL1_TYPE_SERROR:
+		entry->type = PERF_BR_SERROR;
+		break;
+	case BRBINFx_EL1_TYPE_INSN_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_INST;
+		break;
+	case BRBINFx_EL1_TYPE_DATA_DEBUG:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_DATA;
+		break;
+	case BRBINFx_EL1_TYPE_ALIGN_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_ALGN;
+		break;
+	case BRBINFx_EL1_TYPE_INSN_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_INST;
+		break;
+	case BRBINFx_EL1_TYPE_DATA_FAULT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_NEW_FAULT_DATA;
+		break;
+	case BRBINFx_EL1_TYPE_FIQ:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_FIQ;
+		break;
+	case BRBINFx_EL1_TYPE_DEBUG_EXIT:
+		entry->type = PERF_BR_EXTEND_ABI;
+		entry->new_type = PERF_BR_ARM64_DEBUG_EXIT;
+		break;
+	default:
+		pr_warn_once("%d - unknown branch type captured\n", brbe_type);
+		entry->type = PERF_BR_UNKNOWN;
+		break;
+	}
+}
+
+static int brbe_get_perf_priv(u64 brbinf)
+{
+	int brbe_el = brbe_get_el(brbinf);
+
+	switch (brbe_el) {
+	case BRBINFx_EL1_EL_EL0:
+		return PERF_BR_PRIV_USER;
+	case BRBINFx_EL1_EL_EL1:
+		return PERF_BR_PRIV_KERNEL;
+	case BRBINFx_EL1_EL_EL2:
+		if (is_kernel_in_hyp_mode())
+			return PERF_BR_PRIV_KERNEL;
+		return PERF_BR_PRIV_HV;
+	default:
+		pr_warn_once("%d - unknown branch privilege captured\n", brbe_el);
+		return PERF_BR_PRIV_UNKNOWN;
+	}
+}
+
+static void capture_brbe_flags(struct perf_branch_entry *entry, struct perf_event *event,
+			       u64 brbinf)
+{
+	if (branch_sample_type(event))
+		brbe_set_perf_entry_type(entry, brbinf);
+
+	if (!branch_sample_no_cycles(event))
+		entry->cycles = brbe_get_cycles(brbinf);
+
+	if (!branch_sample_no_flags(event)) {
+		/*
+		 * BRBINFx_EL1.LASTFAILED indicates that a TME transaction failed (or
+		 * was cancelled) prior to this record, and some number of records
+		 * prior to this one, may have been generated during an attempt to
+		 * execute the transaction.
+		 */
+		entry->abort = brbe_get_lastfailed(brbinf);
+
+		/*
+		 * All these information (i.e transaction state and mispredicts)
+		 * are available for source only and complete branch records.
+		 */
+		if (brbe_record_is_complete(brbinf) ||
+		    brbe_record_is_source_only(brbinf)) {
+			entry->mispred = brbe_get_mispredict(brbinf);
+			entry->predicted = !entry->mispred;
+			entry->in_tx = brbe_get_in_tx(brbinf);
+		}
+
+		/*
+		 * Currently TME feature is neither implemented in any hardware
+		 * nor it is being supported in the kernel. Just warn here once
+		 * if TME related information shows up rather unexpectedly.
+		 */
+		if (entry->abort || entry->in_tx)
+			pr_warn_once("Unknown transaction states %d %d\n",
+				      entry->abort, entry->in_tx);
+	}
+
+	if (branch_sample_priv(event)) {
+		/*
+		 * All these information (i.e branch privilege level) are
+		 * available for target only and complete branch records.
+		 */
+		if (brbe_record_is_complete(brbinf) ||
+		    brbe_record_is_target_only(brbinf))
+			entry->priv = brbe_get_perf_priv(brbinf);
+	}
+}
+
+static void brbe_regset_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
+				       struct brbe_regset *regset, int idx)
+{
+	struct perf_branch_entry *entry = &cpuc->branches->branch_entries[idx];
+	u64 brbinf = regset[idx].brbinf;
+
+	perf_clear_branch_entry_bitfields(entry);
+	if (brbe_record_is_complete(brbinf)) {
+		entry->from = regset[idx].brbsrc;
+		entry->to = regset[idx].brbtgt;
+	} else if (brbe_record_is_source_only(brbinf)) {
+		entry->from = regset[idx].brbsrc;
+		entry->to = 0;
+	} else if (brbe_record_is_target_only(brbinf)) {
+		entry->from = 0;
+		entry->to = regset[idx].brbtgt;
+	}
+	capture_brbe_flags(entry, event, brbinf);
+}
+
+static void process_branch_entries(struct pmu_hw_events *cpuc, struct perf_event *event,
+				   struct brbe_regset *regset, int nr_regset)
+{
+	int idx;
+
+	for (idx = 0; idx < nr_regset; idx++)
+		brbe_regset_branch_entries(cpuc, event, regset, idx);
+
+	cpuc->branches->branch_stack.nr = nr_regset;
+	cpuc->branches->branch_stack.hw_idx = -1ULL;
+}
+
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	struct arm64_perf_task_context *task_ctx = event->pmu_ctx->task_ctx_data;
+	struct brbe_regset live[BRBE_MAX_ENTRIES];
+	int nr_live, nr_store, nr_hw_entries;
+
+	nr_hw_entries = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr);
+	nr_live = capture_brbe_regset(live, nr_hw_entries);
+	if (event->ctx->task) {
+		nr_store = task_ctx->nr_brbe_records;
+		nr_store = stitch_stored_live_entries(task_ctx->store, live, nr_store,
+						      nr_live, nr_hw_entries);
+		process_branch_entries(cpuc, event, task_ctx->store, nr_store);
+		task_ctx->nr_brbe_records = 0;
+	} else {
+		process_branch_entries(cpuc, event, live, nr_live);
+	}
+}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..6137ae4ba7c3 100644
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
+	if ((cpuc->branch_sample_type != event->attr.branch_sample_type) ||
+	    (event->ctx->task && cpuc->branch_context != event->ctx))
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
+		armv8pmu_branch_stack_reset();
 
 	return IRQ_HANDLED;
 }
@@ -985,6 +1038,40 @@ static int armv8pmu_user_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static bool armv8pmu_branch_stack_init(struct perf_event *event)
+{
+	if (armv8pmu_branch_attr_valid(event)) {
+		/*
+		 * If a task gets scheduled out, the current branch records
+		 * get saved in the task's context data, which can be later
+		 * used to fill in the records upon an event overflow. Let's
+		 * enable PERF_ATTACH_TASK_DATA in 'event->attach_state' for
+		 * all branch stack sampling perf events.
+		 */
+		event->attach_state |= PERF_ATTACH_TASK_DATA;
+		return true;
+	}
+	return false;
+}
+
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
+			armv8pmu_branch_stack_reset();
+	}
+}
+
 /*
  * Add an event filter to a given event.
  */
@@ -1077,6 +1164,9 @@ static void armv8pmu_reset(void *info)
 		pmcr |= ARMV8_PMU_PMCR_LP;
 
 	armv8pmu_pmcr_write(pmcr);
+
+	if (cpu_pmu->has_branch_stack)
+		armv8pmu_branch_stack_reset();
 }
 
 static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
@@ -1229,6 +1319,41 @@ static void __armv8pmu_probe_pmu(void *info)
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
@@ -1245,7 +1370,21 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
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
@@ -1304,6 +1443,11 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
+	cpu_pmu->sched_task		= armv8pmu_sched_task;
+	cpu_pmu->branch_stack_init	= armv8pmu_branch_stack_init;
+	cpu_pmu->branch_stack_add	= armv8pmu_branch_stack_add;
+	cpu_pmu->branch_stack_del	= armv8pmu_branch_stack_del;
+	cpu_pmu->branch_stack_reset	= armv8pmu_branch_stack_reset;
 
 	cpu_pmu->name			= name;
 	cpu_pmu->map_event		= map_event;
diff --git a/drivers/perf/arm_pmuv3_branch.h b/drivers/perf/arm_pmuv3_branch.h
new file mode 100644
index 000000000000..392f3c46e300
--- /dev/null
+++ b/drivers/perf/arm_pmuv3_branch.h
@@ -0,0 +1,73 @@
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
+#ifdef CONFIG_ARM64_BRBE
+void armv8pmu_branch_stack_add(struct perf_event *event, struct pmu_hw_events *cpuc);
+void armv8pmu_branch_stack_del(struct perf_event *event, struct pmu_hw_events *cpuc);
+void armv8pmu_branch_stack_reset(void);
+void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
+bool armv8pmu_branch_attr_valid(struct perf_event *event);
+void armv8pmu_branch_enable(struct arm_pmu *arm_pmu);
+void armv8pmu_branch_disable(void);
+void armv8pmu_branch_read(struct pmu_hw_events *cpuc,
+			  struct perf_event *event);
+void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx);
+int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu);
+void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu);
+#else
+static inline void armv8pmu_branch_stack_add(struct perf_event *event, struct pmu_hw_events *cpuc)
+{
+}
+
+static inline void armv8pmu_branch_stack_del(struct perf_event *event, struct pmu_hw_events *cpuc)
+{
+}
+
+static inline void armv8pmu_branch_stack_reset(void)
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
+#endif
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 9eda16dd684e..a8f916aa6823 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -141,6 +141,11 @@ struct arm_pmu {
 	/* store the PMMIR_EL1 to expose slots */
 	u64		reg_pmmir;
 
+#ifdef CONFIG_ARM64_BRBE
+	/* store the BRBIDR0_EL1 capturing attributes */
+	u64		reg_brbidr;
+#endif
+
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
 };
-- 
2.25.1


