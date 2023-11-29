Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8C7FDE99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjK2RnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjK2RnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:43:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2278D95;
        Wed, 29 Nov 2023 09:43:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C121474;
        Wed, 29 Nov 2023 09:44:11 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE0923F73F;
        Wed, 29 Nov 2023 09:43:20 -0800 (PST)
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
Subject: [PATCH 2/7] OF: Simplify DMA range calculations
Date:   Wed, 29 Nov 2023 17:42:59 +0000
Message-Id: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
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

Juggling start, end, and size values for a range is somewhat redundant
and a little hard to follow. Consolidate down to just using inclusive
start and end, which saves us worrying about size overflows for full
64-bit ranges (note that passing a potentially-overflowed value through
to arch_setup_dma_ops() is benign for all current implementations, and
this is working towards removing that anyway).

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 526a42cdf66e..51062a831970 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -97,7 +97,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
-	u64 mask, end, size = 0;
+	u64 mask, end = 0;
 	bool coherent;
 	int ret;
 
@@ -118,17 +118,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		const struct bus_dma_region *r = map;
-		u64 dma_end = 0;
 
 		/* Determine the overall bounds of all DMA regions */
 		for (dma_start = ~0; r->size; r++) {
 			/* Take lower and upper limits */
 			if (r->dma_start < dma_start)
 				dma_start = r->dma_start;
-			if (r->dma_start + r->size > dma_end)
-				dma_end = r->dma_start + r->size;
+			if (r->dma_start + r->size > end)
+				end = r->dma_start + r->size;
 		}
-		size = dma_end - dma_start;
 	}
 
 	/*
@@ -142,16 +140,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		dev->dma_mask = &dev->coherent_dma_mask;
 	}
 
-	if (!size && dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
-	else if (!size)
-		size = 1ULL << 32;
+	if (!end && dev->coherent_dma_mask)
+		end = dev->coherent_dma_mask;
+	else if (!end)
+		end = (1ULL << 32) - 1;
 
 	/*
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	end = dma_start + size - 1;
 	mask = DMA_BIT_MASK(ilog2(end) + 1);
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
@@ -177,7 +174,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
+	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, iommu, coherent);
 
 	if (!iommu)
 		of_dma_set_restricted_buffer(dev, np);
-- 
2.39.2.101.g768bb238c484.dirty

