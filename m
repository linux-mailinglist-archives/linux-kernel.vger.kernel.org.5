Return-Path: <linux-kernel+bounces-115934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BFC8898C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5F81C31AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0038DE23;
	Mon, 25 Mar 2024 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjdUsUPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E015AD85;
	Sun, 24 Mar 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322134; cv=none; b=QxRpBsueBPN3aWFgL9b1hblPoP7jaY9oJAJ6OA6cZMH2/YMAfDYbsJJBfuaq5C5MAWo0eN1TN/LwbTcyd4mFUcHSx6ZdT363bmwDX76q+BMYvJccZaJFIj8nl5w4ewj/5ZKIFcyzIAFfQTcj4b/nl8/c956WHGTKfKTbvkq7dTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322134; c=relaxed/simple;
	bh=q+yWXPGXitfzU4m2jctnJ7pNJsjDEalVNxI7R0AvQu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BerOU1eJnn7CKObQRaN3zky/EdGPZb0Jl8BgAQRq/VSl2w0gYH8HxgLo0oQs4bjArqT9wYZEoAB7a8tR0kbxtOrE9sjguPGE/h03HjZ8cbctrxyMgWFhreWpQzeo9L2ykqvVWQqQS+Ciz0DHrqPubi5vnyHRdZKNI0kUNIfLtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjdUsUPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A7C43399;
	Sun, 24 Mar 2024 23:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322134;
	bh=q+yWXPGXitfzU4m2jctnJ7pNJsjDEalVNxI7R0AvQu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjdUsUPJIPaSoh/ttwD0nwyaFBCtQBRKdPIXc6DAmubyJIfMg0PTpFHr0rf+PCvdC
	 PRGAZFED3dHPXYHAR+u22M0Z/RX/Y+4JIDVJHnFjYhO6CBlMZ1Woh+zZ5gRor427V9
	 vspL6ytfbXpfuzoRQl/CHItyDs/czR1bEaOrkCrvT6uUFgmImHboMSKxpbLxs2F0jp
	 hkF2/mOiGTSYxRrD2D3cwit/JPEPgJjq66jZXgY/l2CSSkrlcwK6MTPg55xC0+a2qi
	 JhARtL+3CLV8uXe0oBUU/JGeEWBVJVCLzLnmK8dx6XBGVLB2PA8T6yDIit+aYIwbfp
	 g3zL/rpFBxkSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 211/451] iommu/vt-d: Retrieve IOMMU perfmon capability information
Date: Sun, 24 Mar 2024 19:08:07 -0400
Message-ID: <20240324231207.1351418-212-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit a6a5006dad572a53b5df3f47e1471d207ae9ba49 ]

The performance monitoring infrastructure, perfmon, is to support
collection of information about key events occurring during operation of
the remapping hardware, to aid performance tuning and debug. Each
remapping hardware unit has capability registers that indicate support
for performance monitoring features and enumerate the capabilities.

Add alloc_iommu_pmu() to retrieve IOMMU perfmon capability information
for each iommu unit. The information is stored in the iommu->pmu data
structure. Capability registers are read-only, so it's safe to prefetch
and store them in the pmu structure. This could avoid unnecessary VMEXIT
when this code is running in the virtualization environment.

Add free_iommu_pmu() to free the saved capability information when
freeing the iommu unit.

Add a kernel config option for the IOMMU perfmon feature. Unless a user
explicitly uses the perf tool to monitor the IOMMU perfmon event, there
isn't any impact for the existing IOMMU. Enable it by default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230128200428.1459118-3-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 70bad345e622 ("iommu: Fix compilation without CONFIG_IOMMU_INTEL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/Kconfig   |  11 +++
 drivers/iommu/intel/Makefile  |   1 +
 drivers/iommu/intel/dmar.c    |   7 ++
 drivers/iommu/intel/iommu.h   |  43 ++++++++-
 drivers/iommu/intel/perfmon.c | 172 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/perfmon.h |  40 ++++++++
 6 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd21..12e1e90fdae13 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -96,4 +96,15 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	  passing intel_iommu=sm_on to the kernel. If not sure, please use
 	  the default value.
 
+config INTEL_IOMMU_PERF_EVENTS
+	def_bool y
+	bool "Intel IOMMU performance events"
+	depends on INTEL_IOMMU && PERF_EVENTS
+	help
+	  Selecting this option will enable the performance monitoring
+	  infrastructure in the Intel IOMMU. It collects information about
+	  key events occurring during operation of the remapping hardware,
+	  to aid performance tuning and debug. These are available on modern
+	  processors which support Intel VT-d 4.0 and later.
+
 endif # INTEL_IOMMU
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fa0dae16441cb..7af3b8a4f2a00 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 418af1db0192d..4759f79ad7b94 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -34,6 +34,7 @@
 #include "../irq_remapping.h"
 #include "perf.h"
 #include "trace.h"
+#include "perfmon.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
@@ -1104,6 +1105,9 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (sts & DMA_GSTS_QIES)
 		iommu->gcmd |= DMA_GCMD_QIE;
 
+	if (alloc_iommu_pmu(iommu))
+		pr_debug("Cannot alloc PMU for iommu (seq_id = %d)\n", iommu->seq_id);
+
 	raw_spin_lock_init(&iommu->register_lock);
 
 	/*
@@ -1131,6 +1135,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 err_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_unmap:
+	free_iommu_pmu(iommu);
 	unmap_iommu(iommu);
 error_free_seq_id:
 	ida_free(&dmar_seq_ids, iommu->seq_id);
@@ -1146,6 +1151,8 @@ static void free_iommu(struct intel_iommu *iommu)
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
 
+	free_iommu_pmu(iommu);
+
 	if (iommu->irq) {
 		if (iommu->pr_irq) {
 			free_irq(iommu->pr_irq, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c99cb715bd9a2..c1348bedab3b3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -125,6 +125,11 @@
 #define DMAR_MTRR_PHYSMASK8_REG 0x208
 #define DMAR_MTRR_PHYSBASE9_REG 0x210
 #define DMAR_MTRR_PHYSMASK9_REG 0x218
+#define DMAR_PERFCAP_REG	0x300
+#define DMAR_PERFCFGOFF_REG	0x310
+#define DMAR_PERFOVFOFF_REG	0x318
+#define DMAR_PERFCNTROFF_REG	0x31c
+#define DMAR_PERFEVNTCAP_REG	0x380
 #define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
 #define DMAR_VCMD_REG		0xe00 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
@@ -148,6 +153,7 @@
  */
 #define cap_esrtps(c)		(((c) >> 63) & 1)
 #define cap_esirtps(c)		(((c) >> 62) & 1)
+#define cap_ecmds(c)		(((c) >> 61) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
@@ -179,7 +185,8 @@
  * Extended Capability Register
  */
 
-#define	ecap_rps(e)		(((e) >> 49) & 0x1)
+#define ecap_pms(e)		(((e) >> 51) & 0x1)
+#define ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
@@ -210,6 +217,22 @@
 #define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
 #define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
 
+/*
+ * Decoding Perf Capability Register
+ */
+#define pcap_num_cntr(p)	((p) & 0xffff)
+#define pcap_cntr_width(p)	(((p) >> 16) & 0x7f)
+#define pcap_num_event_group(p)	(((p) >> 24) & 0x1f)
+#define pcap_filters_mask(p)	(((p) >> 32) & 0x1f)
+#define pcap_interrupt(p)	(((p) >> 50) & 0x1)
+/* The counter stride is calculated as 2 ^ (x+10) bytes */
+#define pcap_cntr_stride(p)	(1ULL << ((((p) >> 52) & 0x7) + 10))
+
+/*
+ * Decoding Perf Event Capability Register
+ */
+#define pecap_es(p)		((p) & 0xfffffff)
+
 /* Virtual command interface capability */
 #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
 
@@ -561,6 +584,22 @@ struct dmar_domain {
 					   iommu core */
 };
 
+struct iommu_pmu {
+	struct intel_iommu	*iommu;
+	u32			num_cntr;	/* Number of counters */
+	u32			num_eg;		/* Number of event group */
+	u32			cntr_width;	/* Counter width */
+	u32			cntr_stride;	/* Counter Stride */
+	u32			filter;		/* Bitmask of filter support */
+	void __iomem		*base;		/* the PerfMon base address */
+	void __iomem		*cfg_reg;	/* counter configuration base address */
+	void __iomem		*cntr_reg;	/* counter 0 address*/
+	void __iomem		*overflow;	/* overflow status register */
+
+	u64			*evcap;		/* Indicates all supported events */
+	u32			**cntr_evcap;	/* Supported events of each counter. */
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -608,6 +647,8 @@ struct intel_iommu {
 
 	struct dmar_drhd_unit *drhd;
 	void *perf_statistic;
+
+	struct iommu_pmu *pmu;
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
new file mode 100644
index 0000000000000..db5791a544551
--- /dev/null
+++ b/drivers/iommu/intel/perfmon.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Support Intel IOMMU PerfMon
+ * Copyright(c) 2023 Intel Corporation.
+ */
+#define pr_fmt(fmt)	"DMAR: " fmt
+#define dev_fmt(fmt)	pr_fmt(fmt)
+
+#include <linux/dmar.h>
+#include "iommu.h"
+#include "perfmon.h"
+
+static inline void __iomem *
+get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
+{
+	u32 off = dmar_readl(iommu->reg + offset);
+
+	return iommu->reg + off;
+}
+
+int alloc_iommu_pmu(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu;
+	int i, j, ret;
+	u64 perfcap;
+	u32 cap;
+
+	if (!ecap_pms(iommu->ecap))
+		return 0;
+
+	/* The IOMMU PMU requires the ECMD support as well */
+	if (!cap_ecmds(iommu->cap))
+		return -ENODEV;
+
+	perfcap = dmar_readq(iommu->reg + DMAR_PERFCAP_REG);
+	/* The performance monitoring is not supported. */
+	if (!perfcap)
+		return -ENODEV;
+
+	/* Sanity check for the number of the counters and event groups */
+	if (!pcap_num_cntr(perfcap) || !pcap_num_event_group(perfcap))
+		return -ENODEV;
+
+	/* The interrupt on overflow is required */
+	if (!pcap_interrupt(perfcap))
+		return -ENODEV;
+
+	iommu_pmu = kzalloc(sizeof(*iommu_pmu), GFP_KERNEL);
+	if (!iommu_pmu)
+		return -ENOMEM;
+
+	iommu_pmu->num_cntr = pcap_num_cntr(perfcap);
+	iommu_pmu->cntr_width = pcap_cntr_width(perfcap);
+	iommu_pmu->filter = pcap_filters_mask(perfcap);
+	iommu_pmu->cntr_stride = pcap_cntr_stride(perfcap);
+	iommu_pmu->num_eg = pcap_num_event_group(perfcap);
+
+	iommu_pmu->evcap = kcalloc(iommu_pmu->num_eg, sizeof(u64), GFP_KERNEL);
+	if (!iommu_pmu->evcap) {
+		ret = -ENOMEM;
+		goto free_pmu;
+	}
+
+	/* Parse event group capabilities */
+	for (i = 0; i < iommu_pmu->num_eg; i++) {
+		u64 pcap;
+
+		pcap = dmar_readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
+				  i * IOMMU_PMU_CAP_REGS_STEP);
+		iommu_pmu->evcap[i] = pecap_es(pcap);
+	}
+
+	iommu_pmu->cntr_evcap = kcalloc(iommu_pmu->num_cntr, sizeof(u32 *), GFP_KERNEL);
+	if (!iommu_pmu->cntr_evcap) {
+		ret = -ENOMEM;
+		goto free_pmu_evcap;
+	}
+	for (i = 0; i < iommu_pmu->num_cntr; i++) {
+		iommu_pmu->cntr_evcap[i] = kcalloc(iommu_pmu->num_eg, sizeof(u32), GFP_KERNEL);
+		if (!iommu_pmu->cntr_evcap[i]) {
+			ret = -ENOMEM;
+			goto free_pmu_cntr_evcap;
+		}
+		/*
+		 * Set to the global capabilities, will adjust according
+		 * to per-counter capabilities later.
+		 */
+		for (j = 0; j < iommu_pmu->num_eg; j++)
+			iommu_pmu->cntr_evcap[i][j] = (u32)iommu_pmu->evcap[j];
+	}
+
+	iommu_pmu->cfg_reg = get_perf_reg_address(iommu, DMAR_PERFCFGOFF_REG);
+	iommu_pmu->cntr_reg = get_perf_reg_address(iommu, DMAR_PERFCNTROFF_REG);
+	iommu_pmu->overflow = get_perf_reg_address(iommu, DMAR_PERFOVFOFF_REG);
+
+	/*
+	 * Check per-counter capabilities. All counters should have the
+	 * same capabilities on Interrupt on Overflow Support and Counter
+	 * Width.
+	 */
+	for (i = 0; i < iommu_pmu->num_cntr; i++) {
+		cap = dmar_readl(iommu_pmu->cfg_reg +
+				 i * IOMMU_PMU_CFG_OFFSET +
+				 IOMMU_PMU_CFG_CNTRCAP_OFFSET);
+		if (!iommu_cntrcap_pcc(cap))
+			continue;
+
+		/*
+		 * It's possible that some counters have a different
+		 * capability because of e.g., HW bug. Check the corner
+		 * case here and simply drop those counters.
+		 */
+		if ((iommu_cntrcap_cw(cap) != iommu_pmu->cntr_width) ||
+		    !iommu_cntrcap_ios(cap)) {
+			iommu_pmu->num_cntr = i;
+			pr_warn("PMU counter capability inconsistent, counter number reduced to %d\n",
+				iommu_pmu->num_cntr);
+		}
+
+		/* Clear the pre-defined events group */
+		for (j = 0; j < iommu_pmu->num_eg; j++)
+			iommu_pmu->cntr_evcap[i][j] = 0;
+
+		/* Override with per-counter event capabilities */
+		for (j = 0; j < iommu_cntrcap_egcnt(cap); j++) {
+			cap = dmar_readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_CFG_OFFSET +
+					 IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
+					 (j * IOMMU_PMU_OFF_REGS_STEP));
+			iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] = iommu_event_select(cap);
+			/*
+			 * Some events may only be supported by a specific counter.
+			 * Track them in the evcap as well.
+			 */
+			iommu_pmu->evcap[iommu_event_group(cap)] |= iommu_event_select(cap);
+		}
+	}
+
+	iommu_pmu->iommu = iommu;
+	iommu->pmu = iommu_pmu;
+
+	return 0;
+
+free_pmu_cntr_evcap:
+	for (i = 0; i < iommu_pmu->num_cntr; i++)
+		kfree(iommu_pmu->cntr_evcap[i]);
+	kfree(iommu_pmu->cntr_evcap);
+free_pmu_evcap:
+	kfree(iommu_pmu->evcap);
+free_pmu:
+	kfree(iommu_pmu);
+
+	return ret;
+}
+
+void free_iommu_pmu(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
+		return;
+
+	if (iommu_pmu->evcap) {
+		int i;
+
+		for (i = 0; i < iommu_pmu->num_cntr; i++)
+			kfree(iommu_pmu->cntr_evcap[i]);
+		kfree(iommu_pmu->cntr_evcap);
+	}
+	kfree(iommu_pmu->evcap);
+	kfree(iommu_pmu);
+	iommu->pmu = NULL;
+}
diff --git a/drivers/iommu/intel/perfmon.h b/drivers/iommu/intel/perfmon.h
new file mode 100644
index 0000000000000..4b0d9c1fea6ff
--- /dev/null
+++ b/drivers/iommu/intel/perfmon.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * PERFCFGOFF_REG, PERFFRZOFF_REG
+ * PERFOVFOFF_REG, PERFCNTROFF_REG
+ */
+#define IOMMU_PMU_NUM_OFF_REGS			4
+#define IOMMU_PMU_OFF_REGS_STEP			4
+
+#define IOMMU_PMU_CFG_OFFSET			0x100
+#define IOMMU_PMU_CFG_CNTRCAP_OFFSET		0x80
+#define IOMMU_PMU_CFG_CNTREVCAP_OFFSET		0x84
+#define IOMMU_PMU_CFG_SIZE			0x8
+#define IOMMU_PMU_CFG_FILTERS_OFFSET		0x4
+
+#define IOMMU_PMU_CAP_REGS_STEP			8
+
+#define iommu_cntrcap_pcc(p)			((p) & 0x1)
+#define iommu_cntrcap_cw(p)			(((p) >> 8) & 0xff)
+#define iommu_cntrcap_ios(p)			(((p) >> 16) & 0x1)
+#define iommu_cntrcap_egcnt(p)			(((p) >> 28) & 0xf)
+
+#define iommu_event_select(p)			((p) & 0xfffffff)
+#define iommu_event_group(p)			(((p) >> 28) & 0xf)
+
+#ifdef CONFIG_INTEL_IOMMU_PERF_EVENTS
+int alloc_iommu_pmu(struct intel_iommu *iommu);
+void free_iommu_pmu(struct intel_iommu *iommu);
+#else
+static inline int
+alloc_iommu_pmu(struct intel_iommu *iommu)
+{
+	return 0;
+}
+
+static inline void
+free_iommu_pmu(struct intel_iommu *iommu)
+{
+}
+#endif /* CONFIG_INTEL_IOMMU_PERF_EVENTS */
-- 
2.43.0


