Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF6476A8FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjHAG0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjHAG0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:26:18 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F3A1BE6;
        Mon, 31 Jul 2023 23:26:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RFPw76dncz9y7ky;
        Tue,  1 Aug 2023 14:14:47 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwCHOroapchkgAwYAA--.27948S4;
        Tue, 01 Aug 2023 07:25:22 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR ARM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM),
        linux-mm@kvack.org (open list:SLAB ALLOCATOR)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v7 2/9] swiotlb: make io_tlb_default_mem local to swiotlb.c
Date:   Tue,  1 Aug 2023 08:23:57 +0200
Message-Id: <32456334747b6e7f25e839c21d614815088c3c2f.1690871004.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHOroapchkgAwYAA--.27948S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DZw13KF1DAF48Zw13Arb_yoWxZr4Upr
        yUAFyrGF42qrn7urW3Cw1kAF1Ygwn2kay7CrySgwn8Z3WUJwn8JFWktrWYyr1rJrW8uF4f
        AFyvvryYkF47Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8vtCUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

SWIOTLB implementation details should not be exposed to the rest of the
kernel. This will allow to make changes to the implementation without
modifying non-swiotlb code.

To avoid breaking existing users, provide helper functions for the few
required fields.

As a bonus, using a helper function to initialize struct device allows to
get rid of an #ifdef in driver core.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 arch/mips/pci/pci-octeon.c |  2 +-
 drivers/base/core.c        |  4 +---
 drivers/xen/swiotlb-xen.c  |  2 +-
 include/linux/swiotlb.h    | 25 +++++++++++++++++++++++-
 kernel/dma/swiotlb.c       | 39 +++++++++++++++++++++++++++++++++++++-
 mm/slab_common.c           |  5 ++---
 6 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index e457a18cbdc5..d19d9d456309 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -664,7 +664,7 @@ static int __init octeon_pci_setup(void)
 
 		/* BAR1 movable regions contiguous to cover the swiotlb */
 		octeon_bar1_pci_phys =
-			io_tlb_default_mem.start & ~((1ull << 22) - 1);
+			default_swiotlb_base() & ~((1ull << 22) - 1);
 
 		for (index = 0; index < 32; index++) {
 			union cvmx_pci_bar1_indexx bar1_index;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3dff5037943e..46d1d78c5beb 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3108,9 +3108,7 @@ void device_initialize(struct device *dev)
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	dev->dma_coherent = dma_default_coherent;
 #endif
-#ifdef CONFIG_SWIOTLB
-	dev->dma_io_tlb_mem = &io_tlb_default_mem;
-#endif
+	swiotlb_dev_init(dev);
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 67aa74d20162..946bd56f0ac5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -381,7 +381,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return xen_phys_to_dma(hwdev, io_tlb_default_mem.end - 1) <= mask;
+	return xen_phys_to_dma(hwdev, default_swiotlb_limit()) <= mask;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 4e52cd5e0bdc..2d453b3e7771 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -110,7 +110,6 @@ struct io_tlb_mem {
 	atomic_long_t used_hiwater;
 #endif
 };
-extern struct io_tlb_mem io_tlb_default_mem;
 
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
@@ -128,13 +127,22 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 
 void swiotlb_init(bool addressing_limited, unsigned int flags);
 void __init swiotlb_exit(void);
+void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
+bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
+phys_addr_t default_swiotlb_base(void);
+phys_addr_t default_swiotlb_limit(void);
 #else
 static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
 {
 }
+
+static inline void swiotlb_dev_init(struct device *dev)
+{
+}
+
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
@@ -151,6 +159,11 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
+static inline bool is_swiotlb_allocated(void)
+{
+	return false;
+}
+
 static inline bool is_swiotlb_active(struct device *dev)
 {
 	return false;
@@ -159,6 +172,16 @@ static inline bool is_swiotlb_active(struct device *dev)
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
+
+static inline phys_addr_t default_swiotlb_base(void)
+{
+	return 0;
+}
+
+static inline phys_addr_t default_swiotlb_limit(void)
+{
+	return 0;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ee57fd9949dc..0840bc15fb53 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -71,7 +71,7 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
-struct io_tlb_mem io_tlb_default_mem;
+static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
@@ -489,6 +489,15 @@ void __init swiotlb_exit(void)
 	memset(mem, 0, sizeof(*mem));
 }
 
+/**
+ * swiotlb_dev_init() - initialize swiotlb fields in &struct device
+ * @dev:	Device to be initialized.
+ */
+void swiotlb_dev_init(struct device *dev)
+{
+	dev->dma_io_tlb_mem = &io_tlb_default_mem;
+}
+
 /*
  * Return the offset into a iotlb slot required to keep the device happy.
  */
@@ -953,6 +962,14 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
 }
 
+/**
+ * is_swiotlb_allocated() - check if the default software IO TLB is initialized
+ */
+bool is_swiotlb_allocated(void)
+{
+	return io_tlb_default_mem.nslabs;
+}
+
 bool is_swiotlb_active(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -960,6 +977,26 @@ bool is_swiotlb_active(struct device *dev)
 	return mem && mem->nslabs;
 }
 
+/**
+ * default_swiotlb_base() - get the base address of the default SWIOTLB
+ *
+ * Get the lowest physical address used by the default software IO TLB pool.
+ */
+phys_addr_t default_swiotlb_base(void)
+{
+	return io_tlb_default_mem.start;
+}
+
+/**
+ * default_swiotlb_limit() - get the address limit of the default SWIOTLB
+ *
+ * Get the highest physical address used by the default software IO TLB pool.
+ */
+phys_addr_t default_swiotlb_limit(void)
+{
+	return io_tlb_default_mem.end - 1;
+}
+
 #ifdef CONFIG_DEBUG_FS
 
 static int io_tlb_used_get(void *data, u64 *val)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d1555ea2981a..c639dba9a3b7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -864,10 +864,9 @@ void __init setup_kmalloc_cache_index_table(void)
 
 static unsigned int __kmalloc_minalign(void)
 {
-#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
-	if (io_tlb_default_mem.nslabs)
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	    is_swiotlb_allocated())
 		return ARCH_KMALLOC_MINALIGN;
-#endif
 	return dma_get_cache_alignment();
 }
 
-- 
2.25.1

