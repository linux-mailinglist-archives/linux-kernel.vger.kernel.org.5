Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0F76A904
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjHAG1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjHAG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:27:19 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA851FF5;
        Mon, 31 Jul 2023 23:27:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFPx647PNz9xqcV;
        Tue,  1 Aug 2023 14:15:38 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.220.249])
        by APP1 (Coremail) with SMTP id LxC2BwCHOroapchkgAwYAA--.27948S7;
        Tue, 01 Aug 2023 07:26:15 +0100 (CET)
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
Subject: [PATCH v7 5/9] swiotlb: add a flag whether SWIOTLB is allowed to grow
Date:   Tue,  1 Aug 2023 08:24:00 +0200
Message-Id: <c6b051fd9ae34d42f2f4dd2ffb2c5dc968e22837.1690871004.git.petr.tesarik.ext@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
References: <cover.1690871004.git.petr.tesarik.ext@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHOroapchkgAwYAA--.27948S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW8XF1fKr1fZr13Wr4UArb_yoWrWry5pF
        15JF4rXF42qF1xArWxCw1xGF9akw4vkrW3urWa9ry5Ar43Jw1Yqa1DKFWYq34Fqrs2qF4a
        qFyS9F1Ykr17ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
        Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
        xan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8fHUDUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

Add a config option (CONFIG_SWIOTLB_DYNAMIC) to enable or disable dynamic
allocation of additional bounce buffers.

If this option is set, mark the default SWIOTLB as able to grow and
restricted DMA pools as unable.

However, if the address of the default memory pool is explicitly queried,
make the default SWIOTLB also unable to grow. This is currently used to set
up PCI BAR movable regions on some Octeon MIPS boards which may not be able
to use a SWIOTLB pool elsewhere in physical memory. See octeon_pci_setup()
for more details.

If a remap function is specified, it must be also called on any dynamically
allocated pools, but there are some issues:

- The remap function may block, so it should not be called from an atomic
  context.
- There is no corresponding unremap() function if the memory pool is
  freed.
- The only in-tree implementation (xen_swiotlb_fixup) requires that the
  number of slots in the memory pool is a multiple of SWIOTLB_SEGSIZE.

Keep it simple for now and disable growing the SWIOTLB if a remap function
was specified.

Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 include/linux/swiotlb.h |  4 ++++
 kernel/dma/Kconfig      | 13 +++++++++++++
 kernel/dma/swiotlb.c    | 13 +++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 247f0ab8795a..57be2a0a9fbf 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -100,6 +100,7 @@ struct io_tlb_pool {
  * @debugfs:	The dentry to debugfs.
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
+ * @can_grow:	%true if more pools can be allocated dynamically.
  * @total_used:	The total number of slots in the pool that are currently used
  *		across all areas. Used only for calculating used_hiwater in
  *		debugfs.
@@ -112,6 +113,9 @@ struct io_tlb_mem {
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	bool can_grow;
+#endif
 #ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 562463fe30ea..4c1e9a3c0ab6 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -90,6 +90,19 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config SWIOTLB_DYNAMIC
+	bool "Dynamic allocation of DMA bounce buffers"
+	default n
+	depends on SWIOTLB
+	help
+	  This enables dynamic resizing of the software IO TLB. The kernel
+	  starts with one memory pool at boot and it will allocate additional
+	  pools as needed. To reduce run-time kernel memory requirements, you
+	  may have to specify a smaller size of the initial pool using
+	  "swiotlb=" on the kernel command line.
+
+	  If unsure, say N.
+
 config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6fc2606e014b..767c8fb36a6b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -330,6 +330,11 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	io_tlb_default_mem.force_bounce =
 		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	if (!remap)
+		io_tlb_default_mem.can_grow = true;
+#endif
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -400,6 +405,11 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	if (!remap)
+		io_tlb_default_mem.can_grow = true;
+#endif
+
 	if (!default_nareas)
 		swiotlb_adjust_nareas(num_possible_cpus());
 
@@ -1073,6 +1083,9 @@ bool is_swiotlb_active(struct device *dev)
  */
 phys_addr_t default_swiotlb_base(void)
 {
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	io_tlb_default_mem.can_grow = false;
+#endif
 	return io_tlb_default_mem.defpool.start;
 }
 
-- 
2.25.1

