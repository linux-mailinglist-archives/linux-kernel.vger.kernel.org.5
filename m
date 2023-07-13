Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248407526C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGMPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGMPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:25:09 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9781FD6;
        Thu, 13 Jul 2023 08:25:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4R1ymx3zJRz9v7H1;
        Thu, 13 Jul 2023 23:13:53 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.218.161])
        by APP1 (Coremail) with SMTP id LxC2BwA3k94BF7BkxG6BBA--.7207S3;
        Thu, 13 Jul 2023 16:24:16 +0100 (CET)
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
        iommu@lists.linux.dev (open list:XEN SWIOTLB SUBSYSTEM)
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, petr@tesarici.cz
Subject: [PATCH v4 1/8] swiotlb: make io_tlb_default_mem local to swiotlb.c
Date:   Thu, 13 Jul 2023 17:23:12 +0200
Message-Id: <7f64111986f4f361a2deb4a1a1b6f588e63a851b.1689261692.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwA3k94BF7BkxG6BBA--.7207S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1DXF47Xw4UJw4xGF15Arb_yoWxKFyrpr
        yUAFyrGF42grn7ArW3C3WkAF1Y93Z7K3y7CryS9w15ZFnxGwn8JF4DtrWYyr1rJrW8uF4f
        AFy0vFyakw47Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
        7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjPCztUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/arm/xen/mm.c          |  2 +-
 arch/mips/pci/pci-octeon.c |  2 +-
 arch/x86/kernel/pci-dma.c  |  2 +-
 drivers/base/core.c        |  4 +---
 drivers/xen/swiotlb-xen.c  |  2 +-
 include/linux/swiotlb.h    | 25 +++++++++++++++++++++++-
 kernel/dma/swiotlb.c       | 39 +++++++++++++++++++++++++++++++++++++-
 7 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 3d826c0b5fee..0f32c14eb786 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -125,7 +125,7 @@ static int __init xen_mm_init(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
+	if (!is_swiotlb_allocated()) {
 		rc = swiotlb_init_late(swiotlb_size_or_default(),
 				       xen_swiotlb_gfp(), NULL);
 		if (rc < 0)
diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
index e457a18cbdc5..c5c4c1f7d5e4 100644
--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -664,7 +664,7 @@ static int __init octeon_pci_setup(void)
 
 		/* BAR1 movable regions contiguous to cover the swiotlb */
 		octeon_bar1_pci_phys =
-			io_tlb_default_mem.start & ~((1ull << 22) - 1);
+			default_swiotlb_start() & ~((1ull << 22) - 1);
 
 		for (index = 0; index < 32; index++) {
 			union cvmx_pci_bar1_indexx bar1_index;
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de6be0a3965e..08c6ffc3550f 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -90,7 +90,7 @@ int pci_xen_swiotlb_init_late(void)
 		return 0;
 
 	/* we can work with the default swiotlb */
-	if (!io_tlb_default_mem.nslabs) {
+	if (!is_swiotlb_allocated()) {
 		int rc = swiotlb_init_late(swiotlb_size_or_default(),
 					   GFP_KERNEL, xen_swiotlb_fixup);
 		if (rc < 0)
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
index 4e52cd5e0bdc..07216af59e93 100644
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
+phys_addr_t default_swiotlb_start(void);
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
+static inline phys_addr_t default_swiotlb_start(void)
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
index 2b83e3ad9dca..873b077d7e37 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -71,7 +71,7 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
-struct io_tlb_mem io_tlb_default_mem;
+static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
@@ -486,6 +486,15 @@ void __init swiotlb_exit(void)
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
@@ -950,6 +959,14 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
 }
 
+/**
+ * is_swiotlb_allocated() - check if the default software IO TLB is initialized
+ */
+bool is_swiotlb_allocated(void)
+{
+	return !!io_tlb_default_mem.nslabs;
+}
+
 bool is_swiotlb_active(struct device *dev)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
@@ -958,6 +975,26 @@ bool is_swiotlb_active(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
+/**
+ * default_swiotlb_start() - get the start of the default SWIOTLB
+ *
+ * Get the lowest physical address used by the default software IO TLB pool.
+ */
+phys_addr_t default_swiotlb_start(void)
+{
+	return io_tlb_default_mem.start;
+}
+
+/**
+ * default_swiotlb_limit() - get the highest address in the default SWIOTLB
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
-- 
2.25.1

