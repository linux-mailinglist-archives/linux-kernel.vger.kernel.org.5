Return-Path: <linux-kernel+bounces-59677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8284FA44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A922B29FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7612BEBC;
	Fri,  9 Feb 2024 16:50:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22012BE9C;
	Fri,  9 Feb 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497445; cv=none; b=KAYtTCVNW1/6Y3iJAllZT70nWK3YmX54Z637vHF9hvabH0McVDSRQme1xDEcienHJ66FgQjihLw1W1xwWPMLr9KdJisIsxoVfrjaVJd7nRKoFJ6hGQseQ1jYHCrDXyg+nP4gkGY7y9rwAw4RUjD8IafeClDW1xAV2jz42yl1z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497445; c=relaxed/simple;
	bh=dj4HiXbIQbXIq5aOa8YaHipGKB16kgEAFi56Lehan3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBsw6z3/52m54NhyPuqYkLt9bT/qAdXhCdaJBUoflLOoJLIa5+ep120IDf4OSwkYwbRmCVbbhM3tuRAz6ijuT9g6ZacaAuE5jIo+K40xC3Fh3q9dOrwXmgaKFLZt80/rixdzhL7VAOVEXH9+La71yQvSNSP8q4/Dlo5uduTWEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1847EFEC;
	Fri,  9 Feb 2024 08:51:25 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42FEA3F64C;
	Fri,  9 Feb 2024 08:50:39 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: 
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
Subject: [PATCH v3 5/7] iommu/dma: Make limit checks self-contained
Date: Fri,  9 Feb 2024 16:50:02 +0000
Message-Id: <2f9fe1c4fd29043db3d61d265bdf9908bb7fa85c.1707493264.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1707493264.git.robin.murphy@arm.com>
References: <cover.1707493264.git.robin.murphy@arm.com>
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
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index dbe3c225e0d5..52126f73f690 100644
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
@@ -1746,7 +1743,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
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


