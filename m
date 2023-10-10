Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590CB7BF0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379396AbjJJCJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441825AbjJJCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:08:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC400E0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:08:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9653D1FB;
        Mon,  9 Oct 2023 19:09:30 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (entos-ampere02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B37183F7A6;
        Mon,  9 Oct 2023 19:08:47 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH v2] dma-mapping: fix dma_addressing_limited if dma_range_map can't cover all system RAM
Date:   Tue, 10 Oct 2023 02:08:35 +0000
Message-Id: <20231010020835.3678-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an unusual case that the range map covers right up to the top of
system RAM, but leaves a hole somewhere lower down. Then it prevents the
nvme device dma mapping in the checking path of phys_to_dma() and causes
the hangs at boot.

E.g. On an Armv8 Ampere server, the dsdt ACPI table is:
 Method (_DMA, 0, Serialized)  // _DMA: Direct Memory Access
            {
                Name (RBUF, ResourceTemplate ()
                {
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000000000000000, // Range Minimum
                        0x00000000FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000100000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000006010200000, // Range Minimum
                        0x000000602FFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x000000001FE00000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x00000060F0000000, // Range Minimum
                        0x00000060FFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000000010000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                    QWordMemory (ResourceConsumer, PosDecode, MinFixed,
MaxFixed, Cacheable, ReadWrite,
                        0x0000000000000000, // Granularity
                        0x0000007000000000, // Range Minimum
                        0x000003FFFFFFFFFF, // Range Maximum
                        0x0000000000000000, // Translation Offset
                        0x0000039000000000, // Length
                        ,, , AddressRangeMemory, TypeStatic)
                })

But the System RAM ranges are:
cat /proc/iomem |grep -i ram
90000000-91ffffff : System RAM
92900000-fffbffff : System RAM
880000000-fffffffff : System RAM
8800000000-bff5990fff : System RAM
bff59d0000-bff5a4ffff : System RAM
bff8000000-bfffffffff : System RAM
So some RAM ranges are out of dma_range_map.

Fixes it by checking whether each of the system RAM resources can be
properly encompassed within the dma_range_map.

Signed-off-by: Jia He <justin.he@arm.com>
---
v2:
  - refine the subject and commit msg (By Robin Murphy)
  - refactor the checking loop in check_ram_in_range_map() in the pages
    unit to avoid wrap to 0 on 32bits platforms (Robin)

 include/linux/dma-mapping.h | 12 +++++++++--
 kernel/dma/mapping.c        | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f0ccca16a0ac..b8abbb2619a2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -144,6 +144,7 @@ bool dma_pci_p2pdma_supported(struct device *dev);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
+bool all_ram_in_dma_range_map(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
@@ -264,6 +265,10 @@ static inline u64 dma_get_required_mask(struct device *dev)
 {
 	return 0;
 }
+static inline bool all_ram_in_dma_range_map(struct device *dev)
+{
+	return 1;
+}
 static inline size_t dma_max_mapping_size(struct device *dev)
 {
 	return 0;
@@ -475,8 +480,11 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
-			    dma_get_required_mask(dev);
+	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
+			    dma_get_required_mask(dev))
+		return true;
+
+	return !all_ram_in_dma_range_map(dev);
 }
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e323ca48f7f2..5f454949a428 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -7,6 +7,7 @@
  */
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/acpi.h>
+#include <linux/dma-direct.h> /* for bus_dma_region */
 #include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
@@ -819,6 +820,47 @@ size_t dma_opt_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
+/*
+ * To check whether all ram resource ranges are mapped in dma range map
+ * Returns 0 when continuous check is needed
+ * Returns 1 if there is some ram range can't be mapped to dma_range_map
+ */
+static int check_ram_in_range_map(unsigned long start_pfn,
+				  unsigned long nr_pages, void *data)
+{
+	unsigned long end_pfn = start_pfn + nr_pages;
+	struct device *dev = (struct device *)data;
+	struct bus_dma_region *region = NULL;
+	const struct bus_dma_region *m;
+
+	while (start_pfn < end_pfn) {
+		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+			if (start_pfn >= cpu_start_pfn
+			    && start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
+				region = (struct bus_dma_region *)m;
+				break;
+			}
+		}
+		if (!region)
+			return 1;
+
+		start_pfn = PFN_DOWN(region->cpu_start) + PFN_DOWN(region->size);
+	}
+
+	return 0;
+}
+
+bool all_ram_in_dma_range_map(struct device *dev)
+{
+	if (!dev->dma_range_map)
+		return 1;
+
+	return !walk_system_ram_range(0, ULONG_MAX, dev, check_ram_in_range_map);
+}
+EXPORT_SYMBOL_GPL(all_ram_in_dma_range_map);
+
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.25.1

