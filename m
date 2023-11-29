Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E317FDE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjK2Rnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjK2RnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:43:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44E5B198;
        Wed, 29 Nov 2023 09:43:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CF8C15;
        Wed, 29 Nov 2023 09:44:16 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 123D23F73F;
        Wed, 29 Nov 2023 09:43:24 -0800 (PST)
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
Subject: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as limits
Date:   Wed, 29 Nov 2023 17:43:00 +0000
Message-Id: <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
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

Return the Root Complex/Named Component memory address size limit as an
inclusive limit value, rather than an exclusive size.  This saves us
having to special-case 64-bit overflow, and simplifies our caller too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/arm64/dma.c  |  9 +++------
 drivers/acpi/arm64/iort.c | 18 ++++++++----------
 include/linux/acpi_iort.h |  4 ++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index 93d796531af3..b98a149f8d50 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -8,7 +8,6 @@ void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
 	u64 end, mask;
-	u64 size = 0;
 	const struct bus_dma_region *map = NULL;
 
 	/*
@@ -23,9 +22,9 @@ void acpi_arch_dma_setup(struct device *dev)
 	}
 
 	if (dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+		end = dev->coherent_dma_mask;
 	else
-		size = 1ULL << 32;
+		end = (1ULL << 32) - 1;
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
@@ -36,18 +35,16 @@ void acpi_arch_dma_setup(struct device *dev)
 				end = r->dma_start + r->size - 1;
 		}
 
-		size = end + 1;
 		dev->dma_range_map = map;
 	}
 
 	if (ret == -ENODEV)
-		ret = iort_dma_get_ranges(dev, &size);
+		ret = iort_dma_get_ranges(dev, &end);
 	if (!ret) {
 		/*
 		 * Limit coherent and dma mask based on size retrieved from
 		 * firmware.
 		 */
-		end = size - 1;
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
 		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6496ff5a6ba2..eb64d8e17dd1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
 #endif
 
-static int nc_dma_get_range(struct device *dev, u64 *size)
+static int nc_dma_get_range(struct device *dev, u64 *limit)
 {
 	struct acpi_iort_node *node;
 	struct acpi_iort_named_component *ncomp;
@@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
 		return -EINVAL;
 	}
 
-	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
-			1ULL<<ncomp->memory_address_limit;
+	*limit = (1ULL << ncomp->memory_address_limit) - 1;
 
 	return 0;
 }
 
-static int rc_dma_get_range(struct device *dev, u64 *size)
+static int rc_dma_get_range(struct device *dev, u64 *limit)
 {
 	struct acpi_iort_node *node;
 	struct acpi_iort_root_complex *rc;
@@ -1408,8 +1407,7 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 		return -EINVAL;
 	}
 
-	*size = rc->memory_address_limit >= 64 ? U64_MAX :
-			1ULL<<rc->memory_address_limit;
+	*limit = (1ULL << rc->memory_address_limit) - 1;
 
 	return 0;
 }
@@ -1417,16 +1415,16 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 /**
  * iort_dma_get_ranges() - Look up DMA addressing limit for the device
  * @dev: device to lookup
- * @size: DMA range size result pointer
+ * @limit: DMA limit result pointer
  *
  * Return: 0 on success, an error otherwise.
  */
-int iort_dma_get_ranges(struct device *dev, u64 *size)
+int iort_dma_get_ranges(struct device *dev, u64 *limit)
 {
 	if (dev_is_pci(dev))
-		return rc_dma_get_range(dev, size);
+		return rc_dma_get_range(dev, limit);
 	else
-		return nc_dma_get_range(dev, size);
+		return nc_dma_get_range(dev, limit);
 }
 
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1cb65592c95d..d4ed5622cf2b 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -39,7 +39,7 @@ void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 /* IOMMU interface */
-int iort_dma_get_ranges(struct device *dev, u64 *size);
+int iort_dma_get_ranges(struct device *dev, u64 *limit);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
@@ -55,7 +55,7 @@ void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *hea
 static inline
 void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
 /* IOMMU interface */
-static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
+static inline int iort_dma_get_ranges(struct device *dev, u64 *limit)
 { return -ENODEV; }
 static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 { return -ENODEV; }
-- 
2.39.2.101.g768bb238c484.dirty

