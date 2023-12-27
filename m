Return-Path: <linux-kernel+bounces-12079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACB81EFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824581F22195
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58784642C;
	Wed, 27 Dec 2023 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="NDqdcjcT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5E4595B;
	Wed, 27 Dec 2023 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 43D39440F19;
	Wed, 27 Dec 2023 17:02:43 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1703689363;
	bh=NDjhIXrijySlyAenotxkN/N6ucKkMmhIuT0+ciVsprY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDqdcjcTK2m+7XK61ZGidZ5CHtBbiSX38xo6izGJCY26bma2wq7IBWT4vz000eUw1
	 GBbwyf7OQe+WaevbOBXI+5vavzS5FexuGsu1cTgMYyNCTp1yxO8Kx5jqkppNWa6Z8j
	 G/94uSrvb6kFeiuJzbR3wWgZFMCTFEAZXRRD5jqHa1q3iQwABRitbkrY3IBwFqBRM9
	 ZlogSwyK6XNcbZ5B6kSPEuHxCz0+ItVYTRfoquADxy8KvWxqqP11b4ScQU54jhnxXU
	 S5X08TEbiHVEdcVcv7WEld7Zmelmi5aa6tL4Gh5BrEponHpbVWgdEmUQ1qNIAqcQTZ
	 dZT3UDYjbT/8A==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: [PATCH RFC 1/4] of: get dma area lower limit
Date: Wed, 27 Dec 2023 17:04:25 +0200
Message-ID: <be71fbb0963584b8c401423d9dd2fba2511bd5b4.1703683642.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703683642.git.baruch@tkos.co.il>
References: <cover.1703683642.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_dma_get_max_cpu_address() returns the highest CPU address that
devices can use for DMA. The implicit assumption is that all CPU
addresses below that limit are suitable for DMA. However the
'dma-ranges' property this code uses also encodes a lower limit for DMA
that is potentially non zero.

Rename to of_dma_get_cpu_limits(), and extend to retrieve also the lower
limit for the same 'dma-ranges' property describing the high limit.

Update callers of of_dma_get_max_cpu_address(). No functional change
intended.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/mm/init.c  |  4 +++-
 drivers/of/address.c  | 38 +++++++++++++++++++++++++++-----------
 drivers/of/unittest.c |  8 ++++----
 include/linux/of.h    | 11 ++++++++---
 4 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..d6c723ae6fb0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -136,11 +136,13 @@ static void __init zone_sizes_init(void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 	unsigned int __maybe_unused acpi_zone_dma_bits;
 	unsigned int __maybe_unused dt_zone_dma_bits;
+	phys_addr_t __maybe_unused max_cpu_address;
 	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
 
 #ifdef CONFIG_ZONE_DMA
 	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
+	of_dma_get_cpu_limits(NULL, &max_cpu_address, NULL);
+	dt_zone_dma_bits = fls64(max_cpu_address);
 	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index b59956310f66..51fa52bbe911 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -965,21 +965,25 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 #endif /* CONFIG_HAS_DMA */
 
 /**
- * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
+ * of_dma_get_cpu_limits - Gets highest CPU address suitable for DMA
  * @np: The node to start searching from or NULL to start from the root
+ * @max: Pointer to high address limit or NULL if not needed
+ * @min: Pointer to low address limit or NULL if not needed
  *
  * Gets the highest CPU physical address that is addressable by all DMA masters
- * in the sub-tree pointed by np, or the whole tree if NULL is passed. If no
- * DMA constrained device is found, it returns PHYS_ADDR_MAX.
+ * in the sub-tree pointed by np, or the whole tree if @np in NULL. If no
+ * DMA constrained device is found, @*max is PHYS_ADDR_MAX, and @*low is 0.
  */
-phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
+void __init of_dma_get_cpu_limits(struct device_node *np,
+		phys_addr_t *max, phys_addr_t *min)
 {
 	phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
 	struct of_range_parser parser;
-	phys_addr_t subtree_max_addr;
+	phys_addr_t min_cpu_addr = 0;
 	struct device_node *child;
 	struct of_range range;
 	const __be32 *ranges;
+	u64 cpu_start = 0;
 	u64 cpu_end = 0;
 	int len;
 
@@ -989,21 +993,33 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
 	ranges = of_get_property(np, "dma-ranges", &len);
 	if (ranges && len) {
 		of_dma_range_parser_init(&parser, np);
-		for_each_of_range(&parser, &range)
-			if (range.cpu_addr + range.size > cpu_end)
+		for_each_of_range(&parser, &range) {
+			if (range.cpu_addr + range.size > cpu_end) {
 				cpu_end = range.cpu_addr + range.size - 1;
+				cpu_start = range.cpu_addr;
+			}
+		}
 
-		if (max_cpu_addr > cpu_end)
+		if (max_cpu_addr > cpu_end) {
 			max_cpu_addr = cpu_end;
+			min_cpu_addr = cpu_start;
+		}
 	}
 
 	for_each_available_child_of_node(np, child) {
-		subtree_max_addr = of_dma_get_max_cpu_address(child);
-		if (max_cpu_addr > subtree_max_addr)
+		phys_addr_t subtree_max_addr, subtree_min_addr;
+
+		of_dma_get_cpu_limits(child, &subtree_max_addr, &subtree_min_addr);
+		if (max_cpu_addr > subtree_max_addr) {
 			max_cpu_addr = subtree_max_addr;
+			min_cpu_addr = subtree_min_addr;
+		}
 	}
 
-	return max_cpu_addr;
+	if (max)
+		*max = max_cpu_addr;
+	if (min)
+		*min = min_cpu_addr;
 }
 
 /**
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..21d273a05ba6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -908,7 +908,7 @@ static void __init of_unittest_changeset(void)
 #endif
 }
 
-static void __init of_unittest_dma_get_max_cpu_address(void)
+static void __init of_unittest_dma_get_cpu_limits(void)
 {
 	struct device_node *np;
 	phys_addr_t cpu_addr;
@@ -922,9 +922,9 @@ static void __init of_unittest_dma_get_max_cpu_address(void)
 		return;
 	}
 
-	cpu_addr = of_dma_get_max_cpu_address(np);
+	of_dma_get_cpu_limits(np, &cpu_addr, NULL);
 	unittest(cpu_addr == 0x4fffffff,
-		 "of_dma_get_max_cpu_address: wrong CPU addr %pad (expecting %x)\n",
+		 "of_dma_get_cpu_limits: wrong CPU addr %pad (expecting %x)\n",
 		 &cpu_addr, 0x4fffffff);
 }
 
@@ -4104,7 +4104,7 @@ static int __init of_unittest(void)
 	of_unittest_changeset();
 	of_unittest_parse_interrupts();
 	of_unittest_parse_interrupts_extended();
-	of_unittest_dma_get_max_cpu_address();
+	of_unittest_dma_get_cpu_limits();
 	of_unittest_parse_dma_ranges();
 	of_unittest_pci_dma_ranges();
 	of_unittest_bus_ranges();
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..629b402d81bf 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -445,7 +445,8 @@ int of_map_id(struct device_node *np, u32 id,
 	       const char *map_name, const char *map_mask_name,
 	       struct device_node **target, u32 *id_out);
 
-phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
+void of_dma_get_cpu_limits(struct device_node *np, phys_addr_t *max,
+		phys_addr_t *min);
 
 struct kimage;
 void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
@@ -865,9 +866,13 @@ static inline int of_map_id(struct device_node *np, u32 id,
 	return -EINVAL;
 }
 
-static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
+static inline void of_dma_get_cpu_limits(struct device_node *np,
+		phys_addr_t *max, phys_addr_t *min)
 {
-	return PHYS_ADDR_MAX;
+	if (max)
+		*max = PHYS_ADDR_MAX;
+	if (min)
+		*min = 0;
 }
 
 static inline const void *of_device_get_match_data(const struct device *dev)
-- 
2.43.0


