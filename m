Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D257FDEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjK2RoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjK2Rnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:43:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EBC7173B;
        Wed, 29 Nov 2023 09:43:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB751758;
        Wed, 29 Nov 2023 09:44:32 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B41E83F73F;
        Wed, 29 Nov 2023 09:43:41 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>
Cc:     Vineet Gupta <vgupta@kernel.org>,
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
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH 7/7] dma-mapping: Simplify arch_setup_dma_ops()
Date:   Wed, 29 Nov 2023 17:43:04 +0000
Message-Id: <590a4a1b7d10fb9bb1c42ca6cd438e98e6cc94a7.1701268753.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1701268753.git.robin.murphy@arm.com>
References: <cover.1701268753.git.robin.murphy@arm.com>
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

The dma_base, size and iommu arguments are only used by ARM, and can
now easily be deduced from the device itself, so there's no need to pass
them through the callchain as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arc/mm/dma.c               |  3 +--
 arch/arm/mm/dma-mapping-nommu.c |  3 +--
 arch/arm/mm/dma-mapping.c       | 12 ++++++++----
 arch/arm64/mm/dma-mapping.c     |  3 +--
 arch/mips/mm/dma-noncoherent.c  |  3 +--
 arch/riscv/mm/dma-noncoherent.c |  3 +--
 drivers/acpi/scan.c             |  3 +--
 drivers/hv/hv_common.c          |  6 +-----
 drivers/of/device.c             |  4 +---
 include/linux/dma-map-ops.h     |  6 ++----
 10 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 2a7fbbb83b70..6b85e94f3275 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -90,8 +90,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 /*
  * Plug in direct dma map ops.
  */
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	/*
 	 * IOC hardware snoops all DMA traffic keeping the caches consistent
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index cfd9c933d2f0..97db5397c320 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -33,8 +33,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	}
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	if (IS_ENABLED(CONFIG_CPU_V7M)) {
 		/*
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5409225b4abc..70a2131f9b09 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1716,7 +1716,12 @@ static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				    const struct iommu_ops *iommu, bool coherent)
 {
 	struct dma_iommu_mapping *mapping;
+	u64 dma_base = 0, size = SZ_4GB;
 
+	if (dev->dma_range_map) {
+		dma_base = dma_range_map_min(dev->dma_range_map);
+		size = dma_range_map_max(dev->dma_range_map) - dma_base;
+	}
 	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
 	if (IS_ERR(mapping)) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
@@ -1756,8 +1761,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	/*
 	 * Due to legacy code that sets the ->dma_coherent flag from a bus
@@ -1776,8 +1780,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (dev->dma_ops)
 		return;
 
-	if (iommu)
-		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
+	if (device_iommu_mapped(dev))
+		arm_setup_iommu_dma_ops(dev);
 
 	xen_setup_dma_ops(dev);
 	dev->archdata.dma_ops_setup = true;
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 96ff791199e8..0b320a25a471 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -46,8 +46,7 @@ void arch_teardown_dma_ops(struct device *dev)
 }
 #endif
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	int cls = cache_line_size_of_cpu();
 
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 3c4fc97b9f39..ab4f2a75a7d0 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -137,8 +137,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 #endif
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	dev->dma_coherent = coherent;
 }
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 4e4e469b8dd6..cb89d7e0ba88 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -128,8 +128,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
 	ALT_CMO_OP(FLUSH, flush_addr, size, riscv_cbom_block_size);
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent)
+void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 	WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
 		   TAINT_CPU_OUT_OF_SPEC,
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ee88a727f200..cad171fc31e8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1640,8 +1640,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	arch_setup_dma_ops(dev, 0, U64_MAX,
-				iommu, attr == DEV_DMA_COHERENT);
+	arch_setup_dma_ops(dev, attr == DEV_DMA_COHERENT);
 
 	return 0;
 }
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 4372f5d146ab..0e2decd1167a 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -484,11 +484,7 @@ EXPORT_SYMBOL_GPL(hv_query_ext_cap);
 
 void hv_setup_dma_ops(struct device *dev, bool coherent)
 {
-	/*
-	 * Hyper-V does not offer a vIOMMU in the guest
-	 * VM, so pass 0/NULL for the IOMMU settings
-	 */
-	arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
+	arch_setup_dma_ops(dev, coherent);
 }
 EXPORT_SYMBOL_GPL(hv_setup_dma_ops);
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 66879edb4a61..3394751015d3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -96,7 +96,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
-	u64 dma_start = 0;
 	u64 mask, end = 0;
 	bool coherent;
 	int ret;
@@ -118,7 +117,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		/* Determine the overall bounds of all DMA regions */
-		dma_start = dma_range_map_min(map);
 		end = dma_range_map_max(map);
 	}
 
@@ -167,7 +165,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, iommu, coherent);
+	arch_setup_dma_ops(dev, coherent);
 
 	if (!iommu)
 		of_dma_set_restricted_buffer(dev, np);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a52e508d1869..023f265eae2e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -426,11 +426,9 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 #endif
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-		const struct iommu_ops *iommu, bool coherent);
+void arch_setup_dma_ops(struct device *dev, bool coherent);
 #else
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-		u64 size, const struct iommu_ops *iommu, bool coherent)
+static inline void arch_setup_dma_ops(struct device *dev, bool coherent)
 {
 }
 #endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */
-- 
2.39.2.101.g768bb238c484.dirty

