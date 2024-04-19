Return-Path: <linux-kernel+bounces-151789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063A8AB3E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B311C21DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E3139583;
	Fri, 19 Apr 2024 16:55:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422D1139CE8;
	Fri, 19 Apr 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545730; cv=none; b=TKHdxmjDht7PyEpUZ0kXfZt9QcjOeP+wNUEMpy9mE7UalkrqEkAkObLNbmYbUJTjsXpp6Ycn8x+pCoxtgODQMJDnbw9DxSPNfAq4ptjcxE5nBEQ0RoaQlVREbVRKNdED2p2WtM38Ug0jRijw2+fYWQeJAXLG33iTIVCybcgZkaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545730; c=relaxed/simple;
	bh=7FEGpDG9haiMZCIZH2smWlWn8fRlvHbcsm22cfLb438=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u/GWV4E9ghiMp6AbcJSzrEJ2rxlaAiRI8ht1WmT1DIbi4aWN1pRbT/YIa7ayQb1HsNT8TGW91c3tUMcePF6mvPvtwJF48K1JN5s7fZJ8lqvpCHhhLMHwClhA4GbUW4zVjSbsFustwmljMnVDL73hSqVP8zR3I9ArkgsKF80tzCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 321911576;
	Fri, 19 Apr 2024 09:55:57 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D2393F792;
	Fri, 19 Apr 2024 09:55:23 -0700 (PDT)
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
Date: Fri, 19 Apr 2024 17:54:44 +0100
Message-Id: <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
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

It's now easy to retrieve the device's DMA limits if we want to check
them against the domain aperture, so do that ourselves instead of
relying on them being passed through the callchain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a3039005b696..f542eabaefa4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct iommu_dma_options *options,
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
- * @base: IOVA at which the mappable address space starts
- * @limit: Last address of the IOVA space
  * @dev: Device the domain is being initialised for
  *
- * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
- * avoid rounding surprises. If necessary, we reserve the page at address 0
+ * If the geometry and dma_range_map include address 0, we reserve that page
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
-static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
-				 dma_addr_t limit, struct device *dev)
+static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	const struct bus_dma_region *map = dev->dma_range_map;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
 	int ret;
@@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
-	base_pfn = max_t(unsigned long, 1, base >> order);
+	base_pfn = 1;
 
 	/* Check the domain allows at least some access to the device... */
-	if (domain->geometry.force_aperture) {
+	if (map) {
+		dma_addr_t base = dma_range_map_min(map);
 		if (base > domain->geometry.aperture_end ||
-		    limit < domain->geometry.aperture_start) {
+		    dma_range_map_max(map) < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
 		/* ...then finally give it a kicking to make sure it fits */
-		base_pfn = max_t(unsigned long, base_pfn,
-				domain->geometry.aperture_start >> order);
+		base_pfn = max(base, domain->geometry.aperture_start) >> order;
 	}
 
 	/* start_pfn is always nonzero for an already-initialised domain */
@@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
 	if (iommu_is_dma_domain(domain)) {
-		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
+		if (iommu_dma_init_domain(domain, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
 	}
-- 
2.39.2.101.g768bb238c484.dirty


