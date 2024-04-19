Return-Path: <linux-kernel+bounces-151791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB7A8AB3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7458A282CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7B13C9B7;
	Fri, 19 Apr 2024 16:55:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F98E13C9C2;
	Fri, 19 Apr 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545741; cv=none; b=BsdoZqDqXN7hjBnYShJgRQnHeGCnzlv44IhG8nrvz0VeH19ZDCCrhXCQnlhCoRaHkVfXTdrA5JjsZm1xKIxEYfvXBl5ASpJRa5ePiRmVahZKfFyPdhC97m9Ee8IjA1WT6EHVkop33CH77vfbxLh0LKc5lEy2ssMu9kTmEBZCRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545741; c=relaxed/simple;
	bh=vkmLFWky5n9icKv0qx28EP9nHmZqib2WVEqpl8j8NNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/XKpEdURA4JF50DDcsVJIRlhhuQhtyuqdnDoVMib6nq673cD/kZymVRI0g5i8bU87HDdEQm2myXzV6I5G5Kk3/ADtTqxbD624S4cfUh/2bA1ZirOtFNz+qRhvbFL86mfgUetuqnM3MpM9u/GQPV03oot6vq9hktbDXzcv3c3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9E7339;
	Fri, 19 Apr 2024 09:56:07 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 295803F792;
	Fri, 19 Apr 2024 09:55:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Date: Fri, 19 Apr 2024 17:54:46 +0100
Message-Id: <5291c2326eab405b1aa7693aa964e8d3cb7193de.1713523152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523152.git.robin.murphy@arm.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_base, size and iommu arguments are only used by ARM, and can
now easily be deduced from the device itself, so there's no need to pass
them through the callchain as well.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Michael Kelley <mhklinux@outlook.com> # For Hyper-V
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Make sure the ARM changes actually build (oops...)
---
 arch/arc/mm/dma.c               |  3 +--
 arch/arm/mm/dma-mapping-nommu.c |  3 +--
 arch/arm/mm/dma-mapping.c       | 16 +++++++++-------
 arch/arm64/mm/dma-mapping.c     |  3 +--
 arch/mips/mm/dma-noncoherent.c  |  3 +--
 arch/riscv/mm/dma-noncoherent.c |  3 +--
 drivers/acpi/scan.c             |  7 +------
 drivers/hv/hv_common.c          |  6 +-----
 drivers/of/device.c             |  4 +---
 include/linux/dma-map-ops.h     |  6 ++----
 10 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 197707bc7658..6b85e94f3275 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -90,8 +90,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 /*
  * Plug in direct dma map ops.
  */
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	/*
 	 * IOC hardware snoops all DMA traffic keeping the caches consistent
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index b94850b57995..97db5397c320 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -33,8 +33,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	}
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	if (IS_ENABLED(CONFIG_CPU_V7M)) {
 		/*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f68db05eba29..5adf1769eee4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1709,11 +1709,15 @@ void arm_iommu_detach_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
-static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    bool coherent)
+static void arm_setup_iommu_dma_ops(struct device *dev)
 {
 	struct dma_iommu_mapping *mapping;
+	u64 dma_base = 0, size = 1ULL << 32;
 
+	if (dev->dma_range_map) {
+		dma_base = dma_range_map_min(dev->dma_range_map);
+		size = dma_range_map_max(dev->dma_range_map) - dma_base;
+	}
 	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
@@ -1744,8 +1748,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 
 #else
 
-static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    bool coherent)
+static void arm_setup_iommu_dma_ops(struct device *dev)
 {
 }
 
@@ -1753,8 +1756,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	/*
 	 * Due to legacy code that sets the ->dma_coherent flag from a bus
@@ -1774,7 +1776,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return;
 
 	if (device_iommu_mapped(dev))
-		arm_setup_iommu_dma_ops(dev, dma_base, size, coherent);
+		arm_setup_iommu_dma_ops(dev);
 
 	xen_setup_dma_ops(dev);
 	dev->archdata.dma_ops_setup = true;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 313d8938a2f0..0b320a25a471 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -46,8 +46,7 @@ void arch_teardown_dma_ops(struct device *dev)
 }
 #endif
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	int cls = cache_line_size_of_cpu();
 
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 0f3cec663a12..ab4f2a75a7d0 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -137,8 +137,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 #endif
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	dev->dma_coherent = coherent;
 }
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 843107f834b2..cb89d7e0ba88 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -128,8 +128,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	ALT_CMO_OP(FLUSH, flush_addr, size, riscv_cbom_block_size);
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
 		   TAINT_CPU_OUT_OF_SPEC,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..b1a88992c1a9 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1675,12 +1675,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	/*
-	 * Historically this routine doesn't fail driver probing due to errors
-	 * in acpi_iommu_configure_id()
-	 */
-
-	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, attr == DEV_DMA_COHERENT);
 
 	return 0;
 }
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index dde3f9b6871a..9c452bfbd571 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -561,11 +561,7 @@ EXPORT_SYMBOL_GPL(hv_query_ext_cap);
 
 void hv_setup_dma_ops(struct device *dev, bool coherent)
 {
-	/*
-	 * Hyper-V does not offer a vIOMMU in the guest
-	 * VM, so pass 0/NULL for the IOMMU settings
-	 */
-	arch_setup_dma_ops(dev, 0, 0, coherent);
+	arch_setup_dma_ops(dev, coherent);
 }
 EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 9e7963972fa7..312c63361211 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -95,7 +95,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 {
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
-	u64 dma_start = 0;
 	u64 mask, end = 0;
 	bool coherent;
 	int iommu_ret;
@@ -118,7 +117,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		/* Determine the overall bounds of all DMA regions */
-		dma_start = dma_range_map_min(map);
 		end = dma_range_map_max(map);
 	}
 
@@ -175,7 +173,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	} else
 		dev_dbg(dev, "device is behind an iommu\n");
 
-	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, coherent);
+	arch_setup_dma_ops(dev, coherent);
 
 	if (iommu_ret)
 		of_dma_set_restricted_buffer(dev, np);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..ed89e1ce0114 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -426,11 +426,9 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 #endif
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		bool coherent);
+void arch_setup_dma_ops(struct device *dev, bool coherent);
 #else
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size, bool coherent)
+static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 }
 #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
-- 
2.39.2.101.g768bb238c484.dirty


