Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14DA800318
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377512AbjLAFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377524AbjLAFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:39:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEFF199E;
        Thu, 30 Nov 2023 21:39:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD9E143D;
        Thu, 30 Nov 2023 21:40:31 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDC8F3F73F;
        Thu, 30 Nov 2023 21:39:39 -0800 (PST)
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
Subject: [PATCH V15 4/8] drivers: perf: arm_pmuv3: Enable branch stack sampling via FEAT_BRBE
Date:   Fri,  1 Dec 2023 11:09:02 +0530
Message-Id: <20231201053906.1261704-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201053906.1261704-1-anshuman.khandual@arm.com>
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in V15:

- Added a text in brbe.rst regarding single cpu probe
- Replaced BRBFCR_EL1_DEFAULT_CONFIG with BRBFCR_EL1_CONFIG_MASK
- Added BRBFCR_EL1_CONFIG_MASK masking in branch_type_to_brbfcr()
- Moved BRBE helpers from arm_brbe.h into arm_brbe.c
- Moved armv8_pmu_xxx() declaration inside arm_brbe.h for arm64 (CONFIG_ARM64_BRBE)
- Included arm_brbe.h header in arm_brbe.c
- Dropped BRBE custom pr_fmt()

 Documentation/arch/arm64/booting.rst |   6 +
 Documentation/arch/arm64/brbe.rst    | 156 +++++
 arch/arm64/include/asm/el2_setup.h   | 113 ++-
 drivers/perf/Kconfig                 |  11 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/arm_brbe.c              | 985 +++++++++++++++++++++++++++
 drivers/perf/arm_brbe.h              |  13 +
 include/linux/perf/arm_pmu.h         |   5 +
 8 files changed, 1287 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/arch/arm64/brbe.rst
 create mode 100644 drivers/perf/arm_brbe.c

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index b57776a68f15..2276df285e83 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -349,6 +349,12 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
 
+  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
+
   For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
 
   - If EL3 is present:
diff --git a/Documentation/arch/arm64/brbe.rst b/Documentation/arch/arm64/brbe.rst
new file mode 100644
index 000000000000..ecb553c06f38
--- /dev/null
+++ b/Documentation/arch/arm64/brbe.rst
@@ -0,0 +1,156 @@
+============================================
+Branch Record Buffer Extension aka FEAT_BRBE
+============================================
+
+Author: Anshuman Khandual <anshuman.khandual@arm.com>
+
+FEAT_BRBE is an optional architecture feature, which creates branch records
+containing information about change in control flow. The branch information
+contains source address, target address, and some relevant metadata related
+to that change in control flow. BRBE can be configured to filter out branch
+records based on their type and privilege level.
+
+BRBE Hardware
+=============
+
+FEAT_BRBE support on a given implementation, can be determined from system
+register field ID_AA64DFR0_EL1.BRBE, containing 'ID_AA64DFR0_EL1_BRBE_IMP'
+or 'ID_AA64DFR0_EL1_BRBE_BRBE_V1P1'. All BRBE system registers, including
+branch record banks are available for each CPU.
+
+1) Branch Record System Registers
+---------------------------------
+
+A single BRBE branch record representing a single change in control flow is
+constructed from three distinct BRBE system registers.
+
+1. BRBSRC<N>_EL1 - Branch record source address register
+2. BRBTGT<N>_EL1 - Branch record target address register
+3. BRBINF<N>_EL1 - Branch record information register
+
+'N' indices mentioned above ranges inside [0 .. 31] which forms a complete
+branch records bank, and given implementation can have multiple such banks
+of branch records.
+
+2) Branch Record Generation Filters and Controls
+------------------------------------------------
+Branch records generation and their capture control system registers
+
+1. BRBCR_EL1	- Branch record generation control
+2. BRBCR_EL2	- Branch record generation control
+3. BRBFCR_EL1	- Branch record function control
+
+Branch records generation can be filtered based on control flow change type
+and respective execution privilege level. Additional branch record relevant
+information such as elapsed cycles count, and prediction-misprediction can
+also be selectively enabled.
+
+3) Branch Record Information
+----------------------------
+
+Apart from branch source and destination addresses, captured branch records
+also contain information such as prediction, privilege levels, cycle count,
+and transaction state, control flow type etc. These informations are stored
+in respective BRBINF<N>_EL1 registers.
+
+Perf Implementation
+===================
+
+Perf branch stack sampling framework has been enabled on arm64 platform via
+this new FEAT_BRBE feature. The following description explains how this has
+been implemented in various levels of abstraction - from perf core all the
+way to ARMv8 PMUv3 implementation.
+
+1) Branch stack abstraction at ARM PMU
+--------------------------------------
+
+Basic branch stack abstractions such as 'has_branch_stack' pmu feature flag
+in 'struct arm_pmu', defining 'struct branch_records' based branch records
+buffer in 'struct pmu_hw_events' have been implemented at ARM PMU level.
+
+There is an assumption that all cpus on a given ARM PMU implements the same
+BRBE properties, and these get probed on a random cpu belonging to that ARM
+PMU.
+
+2) Branch stack implementation at ARMv8 PMUv3
+---------------------------------------------
+
+Basic branch stack driving callbacks armv8pmu_branch_xxx() alongside normal
+PMU HW events have been implemented at ARMv8 PMUv3 level with fallback stub
+definitions in case where a given ARMv8 PMUv3 does not implement FEAT_BRBE.
+
+**Detect branch stack support**
+
+__armv8pmu_probe_pmu()
+	armv8pmu_branch_probe()
+		arm_pmu->has_branch_stack = 1
+
+**Allocate branch stack buffers**
+
+__armv8pmu_probe_pmu()
+	armv8pmu_branch_probe()
+		arm_pmu->has_branch_stack
+			- armv8pmu_task_ctx_cache_alloc()
+			- branch_records_alloc()
+
+**Allow branch stack event**
+
+armpmu_event_init()
+	armpmu->has_branch_stack
+		has_branch_stack()
+			- branch event allowed to be created
+
+**Check branch stack event feasibility**
+
+__armv8_pmuv3_map_event()
+	has_branch_stack()
+		- event->attach_state | PERF_ATTACH_TASK_DATA
+		- armv8pmu_branch_attr_valid()
+
+**Enable branch record generation**
+
+armpmu_enable()
+	armpmu->start()
+		armv8pmu_start()
+			armv8pmu_branch_enable()
+
+**Disable branch record generation**
+
+armpmu_disable()
+	armpmu->stop()
+		armv8pmu_stop()
+			armv8pmu_branch_disable()
+
+**Capture branch record at PMU IRQ**
+
+armv8pmu_handle_irq()
+	has_branch_stack()
+		armv8pmu_branch_read()
+		perf_sample_save_brstack()
+
+**Process context sched in or out**
+
+armv8pmu_sched_task()
+	armpmu->has_branch_stack
+		- armv8pmu_branch_reset() --> sched_in
+		- armv8pmu_branch_save()  --> sched_out
+
+**Reset branch stack buffer**
+
+armv8pmu_reset()
+	armpmu->has_branch_stack
+		armv8pmu_branch_reset()
+
+
+3) BRBE implementation at ARMv8 PMUv3
+-------------------------------------
+
+FEAT_BRBE specific branch stack callbacks are implemented and are available
+via the new CONFIG_ARM64_BRBE config option. These implementation callbacks
+drive branch records generation control, and capture along side regular PMU
+HW events at ARMv8 PMUv3 level.
+
+Accessing FEAT_BRBE system registers, and instructions without this feature
+being available on the hardware will trigger illegal exceptions. Hence all
+armv8pmu_branch_xxx() should get called after ensuring PMU has branch stack
+support aka FEAT_BRBE via armpmu->has_branch_stack.
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..649b926bf69d 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -154,6 +154,51 @@
 .Lskip_set_cptr_\@:
 .endm
 
+#ifdef CONFIG_ARM64_BRBE
+/*
+ * Enable BRBE cycle count
+ *
+ * BRBE requires both BRBCR_EL1.CC and BRBCR_EL2.CC fields, be set
+ * for the cycle counts to be available in BRBINF<N>_EL1.CC during
+ * branch record processing after a PMU interrupt. This enables CC
+ * field on both these registers while still executing inside EL2.
+ *
+ * BRBE driver would still be able to toggle branch records cycle
+ * count support via BRBCR_EL1.CC field regardless of whether the
+ * kernel ends up executing in EL1 or EL2.
+ */
+.macro __init_el2_brbe
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_cc_\@
+
+	mrs_s	x0, SYS_BRBCR_EL2
+	orr	x0, x0, BRBCR_ELx_CC
+	msr_s	SYS_BRBCR_EL2, x0
+
+	/*
+	 * Accessing BRBCR_EL1 register here does not require
+	 * BRBCR_EL12 addressing mode as HCR_EL2.E2H is still
+	 * clear. Regardless, check for HCR_E2H and be on the
+	 * safer side.
+	 */
+	mrs	x1, hcr_el2
+	and	x1, x1, #HCR_E2H
+	cbz	x1, .Lset_brbe_el1_direct_\@
+
+	mrs_s	x0, SYS_BRBCR_EL12
+	orr	x0, x0, BRBCR_ELx_CC
+	msr_s	SYS_BRBCR_EL12, x0
+	b	.Lskip_brbe_cc_\@
+
+.Lset_brbe_el1_direct_\@:
+	mrs_s	x0, SYS_BRBCR_EL1
+	orr	x0, x0, BRBCR_ELx_CC
+	msr_s	SYS_BRBCR_EL1, x0
+.Lskip_brbe_cc_\@:
+.endm
+#endif
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
@@ -161,16 +206,62 @@
 	cbz	x1, .Lskip_fgt_\@
 
 	mov	x0, xzr
+	mov	x2, xzr
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
 	cmp	x1, #3
 	b.lt	.Lset_debug_fgt_\@
+
 	/* Disable PMSNEVFR_EL1 read and write traps */
-	orr	x0, x0, #(1 << 62)
+	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
 
 .Lset_debug_fgt_\@:
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_reg_fgt_\@
+
+	/*
+	 * Disable read traps for the following BRBE related
+	 * registers.
+	 *
+	 * BRBSRC_EL1
+	 * BRBTGT_EL1
+	 * BRBINF_EL1
+	 * BRBSRCINJ_EL1
+	 * BRBTGTINJ_EL1
+	 * BRBINFINJ_EL1
+	 * BRBTS_EL1
+	 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
+
+	/*
+	 * Disable write traps for the following BRBE related
+	 * registers.
+	 *
+	 * BRBSRCINJ_EL1
+	 * BRBTGTINJ_EL1
+	 * BRBINFINJ_EL1
+	 * BRBTS_EL1
+	 */
+	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
+
+	/*
+	 * Disable both read and write traps for the following
+	 * BRBE related registers.
+	 *
+	 * BRBCR_EL1
+	 * BRBFCR_EL1
+	 */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
+	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
+
+	/* Disable BRBIDR_EL1 read traps */
+	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
+
+.Lskip_brbe_reg_fgt_\@:
 	msr_s	SYS_HDFGRTR_EL2, x0
-	msr_s	SYS_HDFGWTR_EL2, x0
+	msr_s	SYS_HDFGWTR_EL2, x2
 
 	mov	x0, xzr
 	mrs	x1, id_aa64pfr1_el1
@@ -193,7 +284,20 @@
 .Lset_fgt_\@:
 	msr_s	SYS_HFGRTR_EL2, x0
 	msr_s	SYS_HFGWTR_EL2, x0
-	msr_s	SYS_HFGITR_EL2, xzr
+
+	mov	x0, xzr
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
+	cbz	x1, .Lskip_brbe_insn_fgt_\@
+
+	/* Disable traps for BRBIALL instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBIALL_MASK
+
+	/* Disable traps for BRBINJ instruction */
+	orr	x0, x0, #HFGITR_EL2_nBRBINJ_MASK
+
+.Lskip_brbe_insn_fgt_\@:
+	msr_s	SYS_HFGITR_EL2, x0
 
 	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
 	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
@@ -228,6 +332,9 @@
 	__init_el2_nvhe_idregs
 	__init_el2_cptr
 	__init_el2_fgt
+#ifdef CONFIG_ARM64_BRBE
+	__init_el2_brbe
+#endif
 .endm
 
 #ifndef __KVM_NVHE_HYPERVISOR__
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..4cfafe375b17 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -180,6 +180,17 @@ config ARM_SPE_PMU
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
index 16b3ec4db916..a8b7bc22e3d6 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
+obj-$(CONFIG_ARM64_BRBE) += arm_brbe.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
new file mode 100644
index 000000000000..a2d59d137b48
--- /dev/null
+++ b/drivers/perf/arm_brbe.c
@@ -0,0 +1,985 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Branch Record Buffer Extension Driver.
+ *
+ * Copyright (C) 2022-2023 ARM Limited
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include "arm_brbe.h"
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
+enum brbe_bank_idx {
+	BRBE_BANK_IDX_INVALID = -1,
+	BRBE_BANK_IDX_0,
+	BRBE_BANK_IDX_1,
+	BRBE_BANK_IDX_MAX
+};
+
+#define RETURN_READ_BRBSRCN(n) \
+	read_sysreg_s(SYS_BRBSRC##n##_EL1)
+
+#define RETURN_READ_BRBTGTN(n) \
+	read_sysreg_s(SYS_BRBTGT##n##_EL1)
+
+#define RETURN_READ_BRBINFN(n) \
+	read_sysreg_s(SYS_BRBINF##n##_EL1)
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
+void armv8pmu_branch_reset(void)
+{
+	asm volatile(BRB_IALL_INSN);
+	isb();
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
+	WARN_ON(bank > BRBE_BANK_IDX_1);
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
+	select_brbe_bank(BRBE_BANK_IDX_0);
+	while (idx < nr_hw_entries && idx <= BRBE_BANK0_IDX_MAX) {
+		if (!__read_brbe_regset(&buf[idx], idx))
+			return idx;
+		idx++;
+	}
+
+	select_brbe_bank(BRBE_BANK_IDX_1);
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
+				     PERF_SAMPLE_BRANCH_CALL_STACK)
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
+	if (!(cpuc->brbe_sample_type && cpuc->brbe_users))
+		return;
+
+	/*
+	 * BRBE gets configured with a new mismatched branch sample
+	 * type request, overriding any previous branch filters.
+	 */
+	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	brbfcr &= ~BRBFCR_EL1_CONFIG_MASK;
+	brbfcr |= branch_type_to_brbfcr(cpuc->brbe_sample_type);
+	write_sysreg_s(brbfcr, SYS_BRBFCR_EL1);
+	isb();
+
+	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
+	brbcr &= ~BRBCR_ELx_CONFIG_MASK;
+	brbcr |= branch_type_to_brbcr(cpuc->brbe_sample_type);
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
+	case BRBINFx_EL1_TYPE_UNCOND_DIRECT:
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
+	case BRBINFx_EL1_TYPE_COND_DIRECT:
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
+		 *
+		 * We will remove such entries later in process_branch_aborts().
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
+/*
+ * A branch record with BRBINFx_EL1.LASTFAILED set, implies that all
+ * preceding consecutive branch records, that were in a transaction
+ * (i.e their BRBINFx_EL1.TX set) have been aborted.
+ *
+ * Similarly BRBFCR_EL1.LASTFAILED set, indicate that all preceding
+ * consecutive branch records up to the last record, which were in a
+ * transaction (i.e their BRBINFx_EL1.TX set) have been aborted.
+ *
+ * --------------------------------- -------------------
+ * | 00 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 01 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX success]
+ * --------------------------------- -------------------
+ * | 02 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 03 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 04 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 05 | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 1 |
+ * --------------------------------- -------------------
+ * | .. | BRBSRC | BRBTGT | BRBINF | | TX = 0 | LF = 0 |
+ * --------------------------------- -------------------
+ * | 61 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 62 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ * | 63 | BRBSRC | BRBTGT | BRBINF | | TX = 1 | LF = 0 | [TX failed]
+ * --------------------------------- -------------------
+ *
+ * BRBFCR_EL1.LASTFAILED == 1
+ *
+ * BRBFCR_EL1.LASTFAILED fails all those consecutive, in transaction
+ * branches records near the end of the BRBE buffer.
+ *
+ * Architecture does not guarantee a non transaction (TX = 0) branch
+ * record between two different transactions. So it is possible that
+ * a subsequent lastfailed record (TX = 0, LF = 1) might erroneously
+ * mark more than required transactions as aborted.
+ */
+static void process_branch_aborts(struct pmu_hw_events *cpuc)
+{
+	u64 brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
+	bool lastfailed = !!(brbfcr & BRBFCR_EL1_LASTFAILED);
+	int idx = brbe_get_numrec(cpuc->percpu_pmu->reg_brbidr) - 1;
+	struct perf_branch_entry *entry;
+
+	do {
+		entry = &cpuc->branches->branch_entries[idx];
+		if (entry->in_tx) {
+			entry->abort = lastfailed;
+		} else {
+			lastfailed = entry->abort;
+			entry->abort = false;
+		}
+	} while (idx--, idx >= 0);
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
+	process_branch_aborts(cpuc);
+}
diff --git a/drivers/perf/arm_brbe.h b/drivers/perf/arm_brbe.h
index 609e4d4ccac6..4e63b2eac67f 100644
--- a/drivers/perf/arm_brbe.h
+++ b/drivers/perf/arm_brbe.h
@@ -8,6 +8,18 @@
  */
 #include <linux/perf/arm_pmu.h>
 
+#ifdef CONFIG_ARM64_BRBE
+void armv8pmu_branch_reset(void);
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
 static inline void armv8pmu_branch_reset(void)
 {
 }
@@ -48,3 +60,4 @@ static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu)
 static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu)
 {
 }
+#endif
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index a489fdf163b4..76d49c1d8659 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -144,6 +144,11 @@ struct arm_pmu {
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

