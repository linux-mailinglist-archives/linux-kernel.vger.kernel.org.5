Return-Path: <linux-kernel+bounces-59676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93584FA41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4AB1F21B52
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89AA12BE99;
	Fri,  9 Feb 2024 16:50:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798812B15D;
	Fri,  9 Feb 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497442; cv=none; b=XmN0xumVhp0jkPWiMVaZl0HiP8CBOsQgqy46oEMCwrzNdBvcsQ8qNeOsYW/NWH4zy9ixFGkCVpNjAXexbDASFV4FA3CR5j4wI2RVNcKddecop8kI5ZZsizGA1KPe0AaC4C/VBicvkBgNccR7xCiazAl7qpiG4OQ8oKfeMifX1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497442; c=relaxed/simple;
	bh=xTtinJLnaC/I9VC5UbTSJ2+ulMHcbqG/ydth+2lej9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q++7b1V9VxKSQQFC75cgdNZTWGNhJlFAtS959fSvFf8+Gk1Aqz5MlOX2UGXRGMjMEOYmfFe/57CO2uisJ88JTbfrwx0/nxfhxIjnznXVNIfHakw3oqSK29foV4WV6RxYz7O6YUAUlyDKDOr+IvJCJ7CkMAq1FrCju/F6QrxEE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11730DA7;
	Fri,  9 Feb 2024 08:51:21 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08BD53F64C;
	Fri,  9 Feb 2024 08:50:34 -0800 (PST)
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
	Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 4/7] dma-mapping: Add helpers for dma_range_map bounds
Date: Fri,  9 Feb 2024 16:50:01 +0000
Message-Id: <cc90d296daa52e9cfe9fdd6681c68df4773a5e6a.1707493264.git.robin.murphy@arm.com>
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

Several places want to compute the lower and/or upper bounds of a
dma_range_map, so let's factor that out into reusable helpers.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: fix warning for 32-bit builds
---
 arch/loongarch/kernel/dma.c |  9 ++-------
 drivers/acpi/arm64/dma.c    |  8 +-------
 drivers/of/device.c         | 11 ++---------
 include/linux/dma-direct.h  | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
index 7a9c6a9dd2d0..429555fb4e13 100644
--- a/arch/loongarch/kernel/dma.c
+++ b/arch/loongarch/kernel/dma.c
@@ -8,17 +8,12 @@
 void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
-	u64 mask, end = 0;
+	u64 mask, end;
 	const struct bus_dma_region *map = NULL;
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
+		end = dma_range_map_max(map);
 
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index b98a149f8d50..52b2abf88689 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -28,13 +28,7 @@ void acpi_arch_dma_setup(struct device *dev)
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
-
+		end = dma_range_map_max(map);
 		dev->dma_range_map = map;
 	}
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 841ccd3a19d1..9e7963972fa7 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -117,16 +117,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
 	} else {
-		const struct bus_dma_region *r = map;
-
 		/* Determine the overall bounds of all DMA regions */
-		for (dma_start = ~0; r->size; r++) {
-			/* Take lower and upper limits */
-			if (r->dma_start < dma_start)
-				dma_start = r->dma_start;
-			if (r->dma_start + r->size > end)
-				end = r->dma_start + r->size;
-		}
+		dma_start = dma_range_map_min(map);
+		end = dma_range_map_max(map);
 	}
 
 	/*
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 3eb3589ff43e..edbe13d00776 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -54,6 +54,24 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
 	return (phys_addr_t)-1;
 }
 
+static inline dma_addr_t dma_range_map_min(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = (dma_addr_t)U64_MAX;
+
+	for (; map->size; map++)
+		ret = min(ret, map->dma_start);
+	return ret;
+}
+
+static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = 0;
+
+	for (; map->size; map++)
+		ret = max(ret, map->dma_start + map->size - 1);
+	return ret;
+}
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #ifndef phys_to_dma_unencrypted
-- 
2.39.2.101.g768bb238c484.dirty


