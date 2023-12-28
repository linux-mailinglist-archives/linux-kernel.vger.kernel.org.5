Return-Path: <linux-kernel+bounces-12712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFDB81F936
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8BC285B42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940EF511;
	Thu, 28 Dec 2023 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkJxKhzQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E5E54C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703774833; x=1735310833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ehN9A+wNhkSsTAMHh+Wl+K3lACN4+0oYcTx4Tx451g=;
  b=KkJxKhzQuBT+8WgzWmXhGcFmB/K7d1Y9mjfVcAOQyQxxUa2dPOQK4NhZ
   Y+y6lGvMqRny1qrDEcOUsEOAvwtAi+gb4LasW90tSE0VmfYMmy+0QtdmV
   GsDhagDHsJXWKw17qYl3vlj2ycxL/TdqDMZx42jkGEhQk71lhom4B3xDM
   mWPwQhIjwPbR5WJCEdIc4ZP906JjlofSoc5xGgj71f++BJc44QghuDV8Y
   OexYEan68q6bC2O35bjLFwNOs1cEA5SgVfO6fH2dNFC2jh1YQTlFLPst5
   VdSiIblwPP5S8dtn9HgHwXqdUOQxDuQTnPLtz5WdOU6Ap1oPK52GFHiMy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="18106107"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="18106107"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:47:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="13016294"
Received: from fjohanne-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.35.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:47:10 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0EF5F10A537; Thu, 28 Dec 2023 17:47:07 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, REBASED 2/2] mm, treewide: Rename MAX_ORDER to MAX_PAGE_ORDER
Date: Thu, 28 Dec 2023 17:47:04 +0300
Message-ID: <20231228144704.14033-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
References: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely") has
changed the definition of MAX_ORDER to be inclusive. This has caused
issues with code that was not yet upstream and depended on the previous
definition.

To draw attention to the altered meaning of the define, rename MAX_ORDER
to MAX_PAGE_ORDER.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
 .../admin-guide/kernel-parameters.txt         | 24 +++++++++----------
 Documentation/networking/packet_mmap.rst      | 14 +++++------
 arch/arm/Kconfig                              |  2 +-
 arch/arm64/Kconfig                            | 20 ++++++++--------
 arch/arm64/include/asm/sparsemem.h            |  2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |  3 ++-
 arch/arm64/mm/hugetlbpage.c                   |  2 +-
 arch/m68k/Kconfig.cpu                         |  2 +-
 arch/nios2/Kconfig                            |  2 +-
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
 arch/powerpc/mm/hugetlbpage.c                 |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
 arch/sh/mm/Kconfig                            |  2 +-
 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/kernel/pci_sun4v.c                 |  2 +-
 arch/sparc/mm/tsb.c                           |  4 ++--
 arch/um/kernel/um_arch.c                      |  4 ++--
 arch/xtensa/Kconfig                           |  2 +-
 drivers/accel/qaic/qaic_data.c                |  2 +-
 drivers/base/regmap/regmap-debugfs.c          |  8 +++----
 drivers/block/floppy.c                        |  2 +-
 drivers/crypto/ccp/sev-dev.c                  |  2 +-
 drivers/crypto/hisilicon/sgl.c                |  6 ++---
 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |  2 +-
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c     |  8 +++----
 drivers/gpu/drm/ttm/ttm_pool.c                |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 drivers/iommu/dma-iommu.c                     |  2 +-
 drivers/irqchip/irq-gic-v3-its.c              |  4 ++--
 drivers/md/dm-bufio.c                         |  2 +-
 drivers/md/dm-crypt.c                         |  2 +-
 drivers/md/dm-flakey.c                        |  2 +-
 drivers/misc/genwqe/card_dev.c                |  2 +-
 drivers/misc/genwqe/card_utils.c              |  4 ++--
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.h            |  4 ++--
 drivers/video/fbdev/hyperv_fb.c               |  6 ++---
 drivers/video/fbdev/vermilion/vermilion.c     |  2 +-
 drivers/virtio/virtio_balloon.c               |  2 +-
 drivers/virtio/virtio_mem.c                   |  8 +++----
 fs/ramfs/file-nommu.c                         |  2 +-
 include/linux/hugetlb.h                       |  2 +-
 include/linux/mmzone.h                        | 14 +++++------
 include/linux/pageblock-flags.h               |  4 ++--
 include/linux/slab.h                          |  4 ++--
 kernel/dma/pool.c                             |  6 ++---
 kernel/dma/swiotlb.c                          |  4 ++--
 kernel/events/ring_buffer.c                   | 10 ++++----
 mm/Kconfig                                    |  6 ++---
 mm/compaction.c                               |  4 ++--
 mm/debug_page_alloc.c                         |  2 +-
 mm/debug_vm_pgtable.c                         |  4 ++--
 mm/huge_memory.c                              |  2 +-
 mm/hugetlb.c                                  |  4 ++--
 mm/internal.h                                 |  2 +-
 mm/kmsan/init.c                               |  6 ++---
 mm/memblock.c                                 |  7 +++---
 mm/memory_hotplug.c                           |  9 +++----
 mm/mm_init.c                                  | 22 ++++++++---------
 mm/page_alloc.c                               | 24 +++++++++----------
 mm/page_isolation.c                           | 17 ++++++-------
 mm/page_owner.c                               |  6 ++---
 mm/page_reporting.c                           |  4 ++--
 mm/shuffle.h                                  |  2 +-
 mm/slab.c                                     |  2 +-
 mm/slub.c                                     |  4 ++--
 mm/vmscan.c                                   |  2 +-
 mm/vmstat.c                                   |  2 +-
 net/smc/smc_ib.c                              |  2 +-
 security/integrity/ima/ima_crypto.c           |  2 +-
 tools/perf/Documentation/perf-intel-pt.txt    |  2 +-
 tools/testing/memblock/linux/mmzone.h         |  6 ++---
 tools/testing/selftests/mm/thuge-gen.c        |  3 ++-
 76 files changed, 186 insertions(+), 181 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 766b47ad8fb4..8246f94ca307 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -193,7 +193,7 @@ from this.
 -------------------------------
 
 Free areas descriptor. User-space tools use this value to iterate the
-free_area ranges. MAX_ORDER is used by the zone buddy allocator.
+free_area ranges. NR_PAGE_ORDERS is used by the zone buddy allocator.
 
 prb
 ---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..8a01b8112f0b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -970,17 +970,17 @@
 			buddy allocator. Bigger value increase the probability
 			of catching random memory corruption, but reduce the
 			amount of memory for normal system use. The maximum
-			possible value is MAX_ORDER/2.  Setting this parameter
-			to 1 or 2 should be enough to identify most random
-			memory corruption problems caused by bugs in kernel or
-			driver code when a CPU writes to (or reads from) a
-			random memory location. Note that there exists a class
-			of memory corruptions problems caused by buggy H/W or
-			F/W or by drivers badly programming DMA (basically when
-			memory is written at bus level and the CPU MMU is
-			bypassed) which are not detectable by
-			CONFIG_DEBUG_PAGEALLOC, hence this option will not help
-			tracking down these problems.
+			possible value is MAX_PAGE_ORDER/2.  Setting this
+			parameter to 1 or 2 should be enough to identify most
+			random memory corruption problems caused by bugs in
+			kernel or driver code when a CPU writes to (or reads
+			from) a random memory location. Note that there exists
+			a class of memory corruptions problems caused by buggy
+			H/W or F/W or by drivers badly programming DMA
+			(basically when memory is written at bus level and the
+			CPU MMU is bypassed) which are not detectable by
+			CONFIG_DEBUG_PAGEALLOC, hence this option will not
+			help tracking down these problems.
 
 	debug_pagealloc=
 			[KNL] When CONFIG_DEBUG_PAGEALLOC is set, this parameter
@@ -4136,7 +4136,7 @@
 			[KNL] Minimal page reporting order
 			Format: <integer>
 			Adjust the minimal page reporting order. The page
-			reporting is disabled when it exceeds MAX_ORDER.
+			reporting is disabled when it exceeds MAX_PAGE_ORDER.
 
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
 			timeout > 0: seconds before rebooting
diff --git a/Documentation/networking/packet_mmap.rst b/Documentation/networking/packet_mmap.rst
index 30a3be3c48f3..dca15d15feaf 100644
--- a/Documentation/networking/packet_mmap.rst
+++ b/Documentation/networking/packet_mmap.rst
@@ -263,20 +263,20 @@ the name indicates, this function allocates pages of memory, and the second
 argument is "order" or a power of two number of pages, that is
 (for PAGE_SIZE == 4096) order=0 ==> 4096 bytes, order=1 ==> 8192 bytes,
 order=2 ==> 16384 bytes, etc. The maximum size of a
-region allocated by __get_free_pages is determined by the MAX_ORDER macro. More
-precisely the limit can be calculated as::
+region allocated by __get_free_pages is determined by the MAX_PAGE_ORDER macro.
+More precisely the limit can be calculated as::
 
-   PAGE_SIZE << MAX_ORDER
+   PAGE_SIZE << MAX_PAGE_ORDER
 
    In a i386 architecture PAGE_SIZE is 4096 bytes
-   In a 2.4/i386 kernel MAX_ORDER is 10
-   In a 2.6/i386 kernel MAX_ORDER is 11
+   In a 2.4/i386 kernel MAX_PAGE_ORDER is 10
+   In a 2.6/i386 kernel MAX_PAGE_ORDER is 11
 
 So get_free_pages can allocate as much as 4MB or 8MB in a 2.4/2.6 kernel
 respectively, with an i386 architecture.
 
 User space programs can include /usr/include/sys/user.h and
-/usr/include/linux/mmzone.h to get PAGE_SIZE MAX_ORDER declarations.
+/usr/include/linux/mmzone.h to get PAGE_SIZE MAX_PAGE_ORDER declarations.
 
 The pagesize can also be determined dynamically with the getpagesize (2)
 system call.
@@ -324,7 +324,7 @@ Definitions:
 		(see /proc/slabinfo)
 <pointer size>  depends on the architecture -- ``sizeof(void *)``
 <page size>     depends on the architecture -- PAGE_SIZE or getpagesize (2)
-<max-order>     is the value defined with MAX_ORDER
+<max-order>     is the value defined with MAX_PAGE_ORDER
 <frame size>    it's an upper bound of frame's capture size (more on this later)
 ==============  ================================================================
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98b..b2ab8db63c4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1362,7 +1362,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..d97336d508fe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1519,15 +1519,15 @@ config XEN
 
 # include/linux/mmzone.h requires the following to be true:
 #
-#   MAX_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
+#   MAX_PAGE_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
 #
-# so the maximum value of MAX_ORDER is SECTION_SIZE_BITS - PAGE_SHIFT:
+# so the maximum value of MAX_PAGE_ORDER is SECTION_SIZE_BITS - PAGE_SHIFT:
 #
-#     | SECTION_SIZE_BITS |  PAGE_SHIFT  |  max MAX_ORDER  |  default MAX_ORDER |
-# ----+-------------------+--------------+-----------------+--------------------+
-# 4K  |       27          |      12      |       15        |         10         |
-# 16K |       27          |      14      |       13        |         11         |
-# 64K |       29          |      16      |       13        |         13         |
+#     | SECTION_SIZE_BITS |  PAGE_SHIFT  |  max MAX_PAGE_ORDER  |  default MAX_PAGE_ORDER |
+# ----+-------------------+--------------+----------------------+-------------------------+
+# 4K  |       27          |      12      |       15             |         10              |
+# 16K |       27          |      14      |       13             |         11              |
+# 64K |       29          |      16      |       13             |         13              |
 config ARCH_FORCE_MAX_ORDER
 	int
 	default "13" if ARM64_64K_PAGES
@@ -1535,16 +1535,16 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
 	  large blocks of physically contiguous memory is required.
 
 	  The maximal size of allocation cannot exceed the size of the
-	  section, so the value of MAX_ORDER should satisfy
+	  section, so the value of MAX_PAGE_ORDER should satisfy
 
-	    MAX_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
+	    MAX_PAGE_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
 
 	  Don't change if unsure.
 
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 5f5437621029..8a8acc220371 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -10,7 +10,7 @@
 /*
  * Section size must be at least 512MB for 64K base
  * page size config. Otherwise it will be less than
- * MAX_ORDER and the build process will fail.
+ * MAX_PAGE_ORDER and the build process will fail.
  */
 #ifdef CONFIG_ARM64_64K_PAGES
 #define SECTION_SIZE_BITS 29
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index b1e392186a0f..e691290d3765 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -228,7 +228,8 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
 	int i;
 
 	hyp_spin_lock_init(&pool->lock);
-	pool->max_order = min(MAX_ORDER, get_order(nr_pages << PAGE_SHIFT));
+	pool->max_order = min(MAX_PAGE_ORDER,
+			      get_order(nr_pages << PAGE_SHIFT));
 	for (i = 0; i <= pool->max_order; i++)
 		INIT_LIST_HEAD(&pool->free_area[i]);
 	pool->range_start = phys;
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f5aae342632c..8116ac599f80 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -51,7 +51,7 @@ void __init arm64_hugetlb_cma_reserve(void)
 	 * page allocator. Just warn if there is any change
 	 * breaking this assumption.
 	 */
-	WARN_ON(order <= MAX_ORDER);
+	WARN_ON(order <= MAX_PAGE_ORDER);
 	hugetlb_cma_reserve(order);
 }
 #endif /* CONFIG_CMA */
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index ad69b466a08b..9dcf245c9cbf 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -402,7 +402,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index d54464021a61..58d9565dc2c7 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -50,7 +50,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..da597729a9ba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -915,7 +915,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/book3s64/iommu_api.c
index d19fb1f3007d..c0e8d597e4cb 100644
--- a/arch/powerpc/mm/book3s64/iommu_api.c
+++ b/arch/powerpc/mm/book3s64/iommu_api.c
@@ -97,7 +97,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	}
 
 	mmap_read_lock(mm);
-	chunk = (1UL << (PAGE_SHIFT + MAX_ORDER)) /
+	chunk = (1UL << (PAGE_SHIFT + MAX_PAGE_ORDER)) /
 			sizeof(struct vm_area_struct *);
 	chunk = min(chunk, entries);
 	for (entry = 0; entry < entries; entry += chunk) {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f7c683b672c1..0a540b37aab6 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -615,7 +615,7 @@ void __init gigantic_hugetlb_cma_reserve(void)
 		order = mmu_psize_to_shift(MMU_PAGE_16G) - PAGE_SHIFT;
 
 	if (order) {
-		VM_WARN_ON(order <= MAX_ORDER);
+		VM_WARN_ON(order <= MAX_PAGE_ORDER);
 		hugetlb_cma_reserve(order);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 28fac4770073..23f5b5093ec1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1389,7 +1389,7 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	 * DMA window can be larger than available memory, which will
 	 * cause errors later.
 	 */
-	const u64 maxblock = 1UL << (PAGE_SHIFT + MAX_ORDER);
+	const u64 maxblock = 1UL << (PAGE_SHIFT + MAX_PAGE_ORDER);
 
 	/*
 	 * We create the default window as big as we can. The constraint is
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 511c17aede4a..455311d9a5e9 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -26,7 +26,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE:_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..204c43cb3d43 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -277,7 +277,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "12"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index c80b0a21d709..083e5f05a7f0 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -194,7 +194,7 @@ static void *dma_4v_alloc_coherent(struct device *dev, size_t size,
 
 	size = IO_PAGE_ALIGN(size);
 	order = get_order(size);
-	if (unlikely(order > MAX_ORDER))
+	if (unlikely(order > MAX_PAGE_ORDER))
 		return NULL;
 
 	npages = size >> IO_PAGE_SHIFT;
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 5e2931a18409..6acd8a4c1e2a 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 	unsigned long new_rss_limit;
 	gfp_t gfp_flags;
 
-	if (max_tsb_size > PAGE_SIZE << MAX_ORDER)
-		max_tsb_size = PAGE_SIZE << MAX_ORDER;
+	if (max_tsb_size > PAGE_SIZE << MAX_PAGE_ORDER)
+		max_tsb_size = PAGE_SIZE << MAX_PAGE_ORDER;
 
 	new_cache_index = 0;
 	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index b1bfed0c8528..7a9820797eae 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -373,10 +373,10 @@ int __init linux_main(int argc, char **argv)
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
 
 	/*
-	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
+	 * Zones have to begin on a 1 << MAX_PAGE_ORDER page boundary,
 	 * so this makes sure that's true for highmem
 	 */
-	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
+	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_PAGE_ORDER)) - 1);
 	if (physmem_size + iomem_size > max_physmem) {
 		highmem = physmem_size + iomem_size - max_physmem;
 		physmem_size -= highmem;
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7d792077e5fd..e031eaf36c99 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -793,7 +793,7 @@ config ARCH_FORCE_MAX_ORDER
 	default "10"
 	help
 	  The kernel page allocator limits the size of maximal physically
-	  contiguous allocations. The limit is called MAX_ORDER and it
+	  contiguous allocations. The limit is called MAX_PAGE_ORDER and it
 	  defines the maximal power of two of number of pages that can be
 	  allocated as a single contiguous block. This option allows
 	  overriding the default setting when ability to allocate very
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 4a8e43a7a6a4..aaeb2c9c071a 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -451,7 +451,7 @@ static int create_sgt(struct qaic_device *qdev, struct sg_table **sgt_out, u64 s
 		 * later
 		 */
 		buf_extra = (PAGE_SIZE - size % PAGE_SIZE) % PAGE_SIZE;
-		max_order = min(MAX_ORDER - 1, get_order(size));
+		max_order = min(MAX_PAGE_ORDER - 1, get_order(size));
 	} else {
 		/* allocate a single page for book keeping */
 		nr_pages = 1;
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index bdd80b73c3e6..fb84cda92a75 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -226,8 +226,8 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
-	if (count > (PAGE_SIZE << MAX_ORDER))
-		count = PAGE_SIZE << MAX_ORDER;
+	if (count > (PAGE_SIZE << MAX_PAGE_ORDER))
+		count = PAGE_SIZE << MAX_PAGE_ORDER;
 
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
@@ -373,8 +373,8 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	if (*ppos < 0 || !count)
 		return -EINVAL;
 
-	if (count > (PAGE_SIZE << MAX_ORDER))
-		count = PAGE_SIZE << MAX_ORDER;
+	if (count > (PAGE_SIZE << MAX_PAGE_ORDER))
+		count = PAGE_SIZE << MAX_PAGE_ORDER;
 
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 11114a5d9e5c..d0e41d52d6a9 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3079,7 +3079,7 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
 	}
 }
 
-#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
+#define MAX_LEN (1UL << MAX_PAGE_ORDER << PAGE_SHIFT)
 
 static int raw_cmd_copyin(int cmd, void __user *param,
 				 struct floppy_raw_cmd **rcmd)
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index fcaccd0b5a65..e4d3f45242f6 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -906,7 +906,7 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 		/*
 		 * The length of the ID shouldn't be assumed by software since
 		 * it may change in the future.  The allocation size is limited
-		 * to 1 << (PAGE_SHIFT + MAX_ORDER) by the page allocator.
+		 * to 1 << (PAGE_SHIFT + MAX_PAGE_ORDER) by the page allocator.
 		 * If the allocation fails, simply return ENOMEM rather than
 		 * warning in the kernel log.
 		 */
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 3df7a256e919..5c1012d7ffa9 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -70,11 +70,11 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 			 HISI_ACC_SGL_ALIGN_SIZE);
 
 	/*
-	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^MAX_ORDER,
+	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^MAX_PAGE_ORDER,
 	 * block size may exceed 2^31 on ia64, so the max of block size is 2^31
 	 */
-	block_size = 1 << (PAGE_SHIFT + MAX_ORDER < 32 ?
-			   PAGE_SHIFT + MAX_ORDER : 31);
+	block_size = 1 << (PAGE_SHIFT + MAX_PAGE_ORDER < 32 ?
+			   PAGE_SHIFT + MAX_PAGE_ORDER : 31);
 	sgl_num_per_block = block_size / sgl_size;
 	block_num = count / sgl_num_per_block;
 	remain_sgl = count % sgl_num_per_block;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index 6bc26b4b06b8..ea7561ae6e13 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -36,7 +36,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 	struct sg_table *st;
 	struct scatterlist *sg;
 	unsigned int npages; /* restricted by sg_alloc_table */
-	int max_order = MAX_ORDER;
+	int max_order = MAX_PAGE_ORDER;
 	unsigned int max_segment;
 	gfp_t gfp;
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 6b9f6cf50bf6..84c50c4c4af7 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -115,7 +115,7 @@ static int get_huge_pages(struct drm_i915_gem_object *obj)
 		do {
 			struct page *page;
 
-			GEM_BUG_ON(order > MAX_ORDER);
+			GEM_BUG_ON(order > MAX_PAGE_ORDER);
 			page = alloc_pages(GFP | __GFP_ZERO, order);
 			if (!page)
 				goto err;
diff --git a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
index 2d9cae8cd984..cceaa18d4e46 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_pool_test.c
@@ -109,7 +109,7 @@ static const struct ttm_pool_test_case ttm_pool_basic_cases[] = {
 	},
 	{
 		.description = "Above the allocation limit",
-		.order = MAX_ORDER + 1,
+		.order = MAX_PAGE_ORDER + 1,
 	},
 	{
 		.description = "One page, with coherent DMA mappings enabled",
@@ -118,7 +118,7 @@ static const struct ttm_pool_test_case ttm_pool_basic_cases[] = {
 	},
 	{
 		.description = "Above the allocation limit, with coherent DMA mappings enabled",
-		.order = MAX_ORDER + 1,
+		.order = MAX_PAGE_ORDER + 1,
 		.use_dma_alloc = true,
 	},
 };
@@ -165,7 +165,7 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 	fst_page = tt->pages[0];
 	last_page = tt->pages[tt->num_pages - 1];
 
-	if (params->order <= MAX_ORDER) {
+	if (params->order <= MAX_PAGE_ORDER) {
 		if (params->use_dma_alloc) {
 			KUNIT_ASSERT_NOT_NULL(test, (void *)fst_page->private);
 			KUNIT_ASSERT_NOT_NULL(test, (void *)last_page->private);
@@ -182,7 +182,7 @@ static void ttm_pool_alloc_basic(struct kunit *test)
 			 * order 0 blocks
 			 */
 			KUNIT_ASSERT_EQ(test, fst_page->private,
-					min_t(unsigned int, MAX_ORDER,
+					min_t(unsigned int, MAX_PAGE_ORDER,
 					      params->order));
 			KUNIT_ASSERT_EQ(test, last_page->private, 0);
 		}
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index d183bb97c526..b62f420a9f96 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -447,7 +447,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 	else
 		gfp_flags |= GFP_HIGHUSER;
 
-	for (order = min_t(unsigned int, MAX_ORDER, __fls(num_pages));
+	for (order = min_t(unsigned int, MAX_PAGE_ORDER, __fls(num_pages));
 	     num_pages;
 	     order = min_t(unsigned int, order, __fls(num_pages))) {
 		struct ttm_pool_type *pt;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 961205ba86d2..925ac6a47bce 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -188,7 +188,7 @@
 #ifdef CONFIG_CMA_ALIGNMENT
 #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
 #else
-#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER)
+#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_PAGE_ORDER)
 #endif
 
 /*
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..e59f50e11ea8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -884,7 +884,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
 
-	order_mask &= GENMASK(MAX_ORDER, 0);
+	order_mask &= GENMASK(MAX_PAGE_ORDER, 0);
 	if (!order_mask)
 		return NULL;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9a7a74239eab..d097001c1e3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2465,8 +2465,8 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	 * feature is not supported by hardware.
 	 */
 	new_order = max_t(u32, get_order(esz << ids), new_order);
-	if (new_order > MAX_ORDER) {
-		new_order = MAX_ORDER;
+	if (new_order > MAX_PAGE_ORDER) {
+		new_order = MAX_PAGE_ORDER;
 		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
 		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
 			&its->phys_base, its_base_type_string[type],
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index f03d7dba270c..13c65b7e1ed6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1170,7 +1170,7 @@ static void __cache_size_refresh(void)
  * If the allocation may fail we use __get_free_pages. Memory fragmentation
  * won't have a fatal effect here, but it just causes flushes of some other
  * buffers and more I/O will be performed. Don't use __get_free_pages if it
- * always fails (i.e. order > MAX_ORDER).
+ * always fails (i.e. order > MAX_PAGE_ORDER).
  *
  * If the allocation shouldn't fail we use __vmalloc. This is only for the
  * initial reserve allocation, so there's no risk of wasting all vmalloc
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2ae8560b6a14..855b482cbff1 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1673,7 +1673,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
 	unsigned int remaining_size;
-	unsigned int order = MAX_ORDER;
+	unsigned int order = MAX_PAGE_ORDER;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index f57fb821528d..7916ed9f10e8 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -434,7 +434,7 @@ static struct bio *clone_bio(struct dm_target *ti, struct flakey_c *fc, struct b
 
 	remaining_size = size;
 
-	order = MAX_ORDER;
+	order = MAX_PAGE_ORDER;
 	while (remaining_size) {
 		struct page *pages;
 		unsigned size_to_add, to_copy;
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 55fc5b80e649..4441aca2280a 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -443,7 +443,7 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vsize == 0)
 		return -EINVAL;
 
-	if (get_order(vsize) > MAX_ORDER)
+	if (get_order(vsize) > MAX_PAGE_ORDER)
 		return -ENOMEM;
 
 	dma_map = kzalloc(sizeof(struct dma_mapping), GFP_KERNEL);
diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index 1c798d6b2dfb..a2c4a9b4f871 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -210,7 +210,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
 void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
 			       dma_addr_t *dma_handle)
 {
-	if (get_order(size) > MAX_ORDER)
+	if (get_order(size) > MAX_PAGE_ORDER)
 		return NULL;
 
 	return dma_alloc_coherent(&cd->pci_dev->dev, size, dma_handle,
@@ -308,7 +308,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	sgl->write = write;
 	sgl->sgl_size = genwqe_sgl_size(sgl->nr_pages);
 
-	if (get_order(sgl->sgl_size) > MAX_ORDER) {
+	if (get_order(sgl->sgl_size) > MAX_PAGE_ORDER) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: too much memory requested!\n", __func__);
 		return ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b618797a7e8d..f1695c889d3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1041,7 +1041,7 @@ static void hns3_init_tx_spare_buffer(struct hns3_enet_ring *ring)
 		return;
 
 	order = get_order(alloc_size);
-	if (order > MAX_ORDER) {
+	if (order > MAX_PAGE_ORDER) {
 		if (net_ratelimit())
 			dev_warn(ring_to_dev(ring), "failed to allocate tx spare buffer, exceed to max order\n");
 		return;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 4e18b4cefa97..94ac36b1408b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -48,7 +48,7 @@
  * of 4096 jumbo frames (MTU=9000) we will need about 9K*4K = 36MB plus
  * some padding.
  *
- * But the size of a single DMA region is limited by MAX_ORDER in the
+ * But the size of a single DMA region is limited by MAX_PAGE_ORDER in the
  * kernel (about 16MB currently).  To support say 4K Jumbo frames, we
  * use a set of LTBs (struct ltb_set) per pool.
  *
@@ -75,7 +75,7 @@
  * pool for the 4MB. Thus the 16 Rx and Tx queues require 32 * 5 = 160
  * plus 16 for the TSO pools for a total of 176 LTB mappings per VNIC.
  */
-#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << MAX_ORDER) * PAGE_SIZE))
+#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << MAX_PAGE_ORDER) * PAGE_SIZE))
 #define IBMVNIC_ONE_LTB_SIZE	min((u32)(8 << 20), IBMVNIC_ONE_LTB_MAX)
 #define IBMVNIC_LTB_SET_SIZE	(38 << 20)
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index a80939fe2ee6..6a29d2594b91 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -927,8 +927,8 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
 	if (request_size == 0)
 		return -1;
 
-	if (order <= MAX_ORDER) {
-		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
+	if (order <= MAX_PAGE_ORDER) {
+		/* Call alloc_pages if the size is less than 2^MAX_PAGE_ORDER */
 		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
 		if (!page)
 			return -1;
@@ -958,7 +958,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 {
 	unsigned int order = get_order(size);
 
-	if (order <= MAX_ORDER)
+	if (order <= MAX_PAGE_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
 		dma_free_coherent(&hdev->device,
diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 840ead69654b..a32e5b2924c9 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -197,7 +197,7 @@ static int vmlfb_alloc_vram(struct vml_info *vinfo,
 		va = &vinfo->vram[i];
 		order = 0;
 
-		while (requested > (PAGE_SIZE << order) && order <= MAX_ORDER)
+		while (requested > (PAGE_SIZE << order) && order <= MAX_PAGE_ORDER)
 			order++;
 
 		err = vmlfb_alloc_vram_area(va, order, 0);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1fe93e93f5bc..59cdc0292dce 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -33,7 +33,7 @@
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
 					     __GFP_NOMEMALLOC)
 /* The order of free page blocks to report to host */
-#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_ORDER
+#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_PAGE_ORDER
 /* The size of a free page block in bytes */
 #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index fa5226c198cc..8e3223294442 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1154,13 +1154,13 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 {
-	unsigned long order = MAX_ORDER;
+	unsigned long order = MAX_PAGE_ORDER;
 	unsigned long i;
 
 	/*
 	 * We might get called for ranges that don't cover properly aligned
-	 * MAX_ORDER pages; however, we can only online properly aligned
-	 * pages with an order of MAX_ORDER at maximum.
+	 * MAX_PAGE_ORDER pages; however, we can only online properly aligned
+	 * pages with an order of MAX_PAGE_ORDER at maximum.
 	 */
 	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
 		order--;
@@ -1280,7 +1280,7 @@ static void virtio_mem_online_page(struct virtio_mem *vm,
 	bool do_online;
 
 	/*
-	 * We can get called with any order up to MAX_ORDER. If our subblock
+	 * We can get called with any order up to MAX_PAGE_ORDER. If our subblock
 	 * size is smaller than that and we have a mixture of plugged and
 	 * unplugged subblocks within such a page, we have to process in
 	 * smaller granularity. In that case we'll adjust the order exactly once
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index efb1b4c1a0a4..7a6d980e614d 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -70,7 +70,7 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 
 	/* make various checks */
 	order = get_order(newsize);
-	if (unlikely(order > MAX_ORDER))
+	if (unlikely(order > MAX_PAGE_ORDER))
 		return -EFBIG;
 
 	ret = inode_newsize_ok(inode, newsize);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 236ec7b63c54..c1ee640d87b1 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -829,7 +829,7 @@ static inline unsigned huge_page_shift(struct hstate *h)
 
 static inline bool hstate_is_gigantic(struct hstate *h)
 {
-	return huge_page_order(h) > MAX_ORDER;
+	return huge_page_order(h) > MAX_PAGE_ORDER;
 }
 
 static inline unsigned int pages_per_huge_page(const struct hstate *h)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 553d0b873632..42a189a0a2a4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -26,15 +26,15 @@
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
-#define MAX_ORDER 10
+#define MAX_PAGE_ORDER 10
 #else
-#define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
+#define MAX_PAGE_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
 #endif
-#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
+#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
 
 #define IS_MAX_ORDER_ALIGNED(pfn) IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)
 
-#define NR_PAGE_ORDERS (MAX_ORDER + 1)
+#define NR_PAGE_ORDERS (MAX_PAGE_ORDER + 1)
 
 /*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
@@ -952,7 +952,7 @@ struct zone {
 	struct free_area	free_area[NR_PAGE_ORDERS];
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
-	/* Pages to be accepted. All pages on the list are MAX_ORDER */
+	/* Pages to be accepted. All pages on the list are MAX_PAGE_ORDER */
 	struct list_head	unaccepted_pages;
 #endif
 
@@ -1762,8 +1762,8 @@ static inline bool movable_only_nodes(nodemask_t *nodes)
 #define SECTION_BLOCKFLAGS_BITS \
 	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
 
-#if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
-#error Allocator MAX_ORDER exceeds SECTION_SIZE
+#if (MAX_PAGE_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
+#error Allocator MAX_PAGE_ORDER exceeds SECTION_SIZE
 #endif
 
 static inline unsigned long pfn_to_section_nr(unsigned long pfn)
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index e83c4c095041..3f2409b968ec 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -41,14 +41,14 @@ extern unsigned int pageblock_order;
  * Huge pages are a constant size, but don't exceed the maximum allocation
  * granularity.
  */
-#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER)
+#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_PAGE_ORDER)
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
 #else /* CONFIG_HUGETLB_PAGE */
 
 /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
-#define pageblock_order		MAX_ORDER
+#define pageblock_order		MAX_PAGE_ORDER
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d6d6ffeeb9a2..d63823e518c0 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -308,7 +308,7 @@ static inline unsigned int arch_slab_minalign(void)
  * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
  */
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	5
 #endif
@@ -316,7 +316,7 @@ static inline unsigned int arch_slab_minalign(void)
 
 #ifdef CONFIG_SLUB
 #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
-#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
+#define KMALLOC_SHIFT_MAX	(MAX_PAGE_ORDER + PAGE_SHIFT)
 #ifndef KMALLOC_SHIFT_LOW
 #define KMALLOC_SHIFT_LOW	3
 #endif
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b481c48a31a6..d10613eb0f63 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -84,8 +84,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	void *addr;
 	int ret = -ENOMEM;
 
-	/* Cannot allocate larger than MAX_ORDER */
-	order = min(get_order(pool_size), MAX_ORDER);
+	/* Cannot allocate larger than MAX_PAGE_ORDER */
+	order = min(get_order(pool_size), MAX_PAGE_ORDER);
 
 	do {
 		pool_size = 1 << (PAGE_SHIFT + order);
@@ -190,7 +190,7 @@ static int __init dma_atomic_pool_init(void)
 
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
-	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER.
+	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_PAGE_ORDER.
 	 */
 	if (!atomic_pool_size) {
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 33d942615be5..176078bf2215 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -686,8 +686,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	size_t pool_size;
 	size_t tlb_size;
 
-	if (nslabs > SLABS_PER_PAGE << MAX_ORDER) {
-		nslabs = SLABS_PER_PAGE << MAX_ORDER;
+	if (nslabs > SLABS_PER_PAGE << MAX_PAGE_ORDER) {
+		nslabs = SLABS_PER_PAGE << MAX_PAGE_ORDER;
 		nareas = limit_nareas(nareas, nslabs);
 	}
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index e8d82c2f07d0..60ed43d1c29e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -610,8 +610,8 @@ static struct page *rb_alloc_aux_page(int node, int order)
 {
 	struct page *page;
 
-	if (order > MAX_ORDER)
-		order = MAX_ORDER;
+	if (order > MAX_PAGE_ORDER)
+		order = MAX_PAGE_ORDER;
 
 	do {
 		page = alloc_pages_node(node, PERF_AUX_GFP, order);
@@ -702,9 +702,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 
 	/*
 	 * kcalloc_node() is unable to allocate buffer if the size is larger
-	 * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
+	 * than: PAGE_SIZE << MAX_PAGE_ORDER; directly bail out in this case.
 	 */
-	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_ORDER)
+	if (get_order((unsigned long)nr_pages * sizeof(void *)) > MAX_PAGE_ORDER)
 		return -ENOMEM;
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
 				     node);
@@ -821,7 +821,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	size = sizeof(struct perf_buffer);
 	size += nr_pages * sizeof(void *);
 
-	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
+	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
 		goto fail;
 
 	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
diff --git a/mm/Kconfig b/mm/Kconfig
index 57cd378c73d6..31b60c2f4c64 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -367,7 +367,7 @@ config SHUFFLE_PAGE_ALLOCATOR
 	  the presence of a memory-side-cache. There are also incidental
 	  security benefits as it reduces the predictability of page
 	  allocations to compliment SLAB_FREELIST_RANDOM, but the
-	  default granularity of shuffling on the MAX_ORDER i.e, 10th
+	  default granularity of shuffling on the MAX_PAGE_ORDER i.e, 10th
 	  order of pages is selected based on cache utilization benefits
 	  on x86.
 
@@ -699,8 +699,8 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes available
 	  on a platform.
 
-	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
-	  clamped down to MAX_ORDER.
+	  Note that the pageblock_order cannot exceed MAX_PAGE_ORDER and will be
+	  clamped down to MAX_PAGE_ORDER.
 
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
diff --git a/mm/compaction.c b/mm/compaction.c
index 6c8378653cb6..9ea020c51f1f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -999,7 +999,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			 * a valid page order. Consider only values in the
 			 * valid order range to prevent low_pfn overflow.
 			 */
-			if (freepage_order > 0 && freepage_order <= MAX_ORDER) {
+			if (freepage_order > 0 && freepage_order <= MAX_PAGE_ORDER) {
 				low_pfn += (1UL << freepage_order) - 1;
 				nr_scanned += (1UL << freepage_order) - 1;
 			}
@@ -1017,7 +1017,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order <= MAX_ORDER)) {
+			if (likely(order <= MAX_PAGE_ORDER)) {
 				low_pfn += (1UL << order) - 1;
 				nr_scanned += (1UL << order) - 1;
 			}
diff --git a/mm/debug_page_alloc.c b/mm/debug_page_alloc.c
index f9d145730fd1..6755f0c9d4a3 100644
--- a/mm/debug_page_alloc.c
+++ b/mm/debug_page_alloc.c
@@ -22,7 +22,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
 {
 	unsigned long res;
 
-	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
+	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_PAGE_ORDER / 2) {
 		pr_err("Bad debug_guardpage_minorder value\n");
 		return 0;
 	}
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e651500e597a..5662e29fe253 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1091,7 +1091,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_debug_args *args, int order)
 	struct page *page = NULL;
 
 #ifdef CONFIG_CONTIG_ALLOC
-	if (order > MAX_ORDER) {
+	if (order > MAX_PAGE_ORDER) {
 		page = alloc_contig_pages((1 << order), GFP_KERNEL,
 					  first_online_node, NULL);
 		if (page) {
@@ -1101,7 +1101,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_debug_args *args, int order)
 	}
 #endif
 
-	if (order <= MAX_ORDER)
+	if (order <= MAX_PAGE_ORDER)
 		page = alloc_pages(GFP_KERNEL, order);
 
 	return page;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f542444a91f..8b1029d36d48 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -505,7 +505,7 @@ static int __init hugepage_init(void)
 	/*
 	 * hugepages can't be allocated by the buddy allocator
 	 */
-	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER > MAX_ORDER);
+	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER > MAX_PAGE_ORDER);
 	/*
 	 * we use page->mapping and page->index in second tail page
 	 * as list_head: assuming THP order >= 2
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6feb3e0630d1..ae77d9d32c5c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3410,7 +3410,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
- * Note: This only applies to gigantic (order > MAX_ORDER) pages.
+ * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
  */
 static void __init gather_bootmem_prealloc(void)
 {
@@ -4790,7 +4790,7 @@ static int __init default_hugepagesz_setup(char *s)
 	 * The number of default huge pages (for this size) could have been
 	 * specified as the first hugetlb parameter: hugepages=X.  If so,
 	 * then default_hstate_max_huge_pages is set.  If the default huge
-	 * page size is gigantic (> MAX_ORDER), then the pages must be
+	 * page size is gigantic (> MAX_PAGE_ORDER), then the pages must be
 	 * allocated here from bootmem allocator.
 	 */
 	if (default_hstate_max_huge_pages) {
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..de223517bd4e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -335,7 +335,7 @@ static inline bool page_is_buddy(struct page *page, struct page *buddy,
  * satisfies the following equation:
  *     P = B & ~(1 << O)
  *
- * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
+ * Assumption: *_mem_map is contiguous at least up to MAX_PAGE_ORDER
  */
 static inline unsigned long
 __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index 103e2e88ea03..3ac3b8921d36 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -141,7 +141,7 @@ struct smallstack {
 
 static struct smallstack collect = {
 	.index = 0,
-	.order = MAX_ORDER,
+	.order = MAX_PAGE_ORDER,
 };
 
 static void smallstack_push(struct smallstack *stack, struct page *pages)
@@ -211,8 +211,8 @@ static void kmsan_memblock_discard(void)
 	 *    order=N-1,
 	 *  - repeat.
 	 */
-	collect.order = MAX_ORDER;
-	for (int i = MAX_ORDER; i >= 0; i--) {
+	collect.order = MAX_PAGE_ORDER;
+	for (int i = MAX_PAGE_ORDER; i >= 0; i--) {
 		if (held_back[i].shadow)
 			smallstack_push(&collect, held_back[i].shadow);
 		if (held_back[i].origin)
diff --git a/mm/memblock.c b/mm/memblock.c
index 5a88d6d24d79..3bb1a163d7d5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2079,12 +2079,13 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		 * Free the pages in the largest chunks alignment allows.
 		 *
 		 * __ffs() behaviour is undefined for 0. start == 0 is
-		 * MAX_ORDER-aligned, set order to MAX_ORDER for the case.
+		 * MAX_PAGE_ORDER-aligned, set order to MAX_PAGE_ORDER for
+		 * the case.
 		 */
 		if (start)
-			order = min_t(int, MAX_ORDER, __ffs(start));
+			order = min_t(int, MAX_PAGE_ORDER, __ffs(start));
 		else
-			order = MAX_ORDER;
+			order = MAX_PAGE_ORDER;
 
 		while (start + (1UL << order) > end)
 			order--;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a5fc89a8652..68527e418bb8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -645,7 +645,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	unsigned long pfn;
 
 	/*
-	 * Online the pages in MAX_ORDER aligned chunks. The callback might
+	 * Online the pages in MAX_PAGE_ORDER aligned chunks. The callback might
 	 * decide to not expose all pages to the buddy (e.g., expose them
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
@@ -660,12 +660,13 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 		 * Free to online pages in the largest chunks alignment allows.
 		 *
 		 * __ffs() behaviour is undefined for 0. start == 0 is
-		 * MAX_ORDER-aligned, Set order to MAX_ORDER for the case.
+		 * MAX_PAGE_ORDER-aligned, Set order to MAX_PAGE_ORDER for
+		 * the case.
 		 */
 		if (pfn)
-			order = min_t(int, MAX_ORDER, __ffs(pfn));
+			order = min_t(int, MAX_PAGE_ORDER, __ffs(pfn));
 		else
-			order = MAX_ORDER;
+			order = MAX_PAGE_ORDER;
 
 		(*online_page_callback)(pfn_to_page(pfn), order);
 		pfn += (1UL << order);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..bcda51e28f1b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1454,7 +1454,7 @@ static inline void setup_usemap(struct zone *zone) {}
 /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
 void __init set_pageblock_order(void)
 {
-	unsigned int order = MAX_ORDER;
+	unsigned int order = MAX_PAGE_ORDER;
 
 	/* Check that pageblock_nr_pages has not already been setup */
 	if (pageblock_order)
@@ -1643,7 +1643,7 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 		struct page *map;
 
 		/*
-		 * The zone's endpoints aren't required to be MAX_ORDER
+		 * The zone's endpoints aren't required to be MAX_PAGE_ORDER
 		 * aligned but the node_mem_map endpoints must be in order
 		 * for the buddy allocator to function correctly.
 		 */
@@ -1973,11 +1973,11 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
 			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
-		__free_pages_core(page, MAX_ORDER);
+		__free_pages_core(page, MAX_PAGE_ORDER);
 		return;
 	}
 
-	/* Accept chunks smaller than MAX_ORDER upfront */
+	/* Accept chunks smaller than MAX_PAGE_ORDER upfront */
 	accept_memory(PFN_PHYS(pfn), PFN_PHYS(pfn + nr_pages));
 
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
@@ -2000,8 +2000,8 @@ static inline void __init pgdat_init_report_one_done(void)
 /*
  * Returns true if page needs to be initialized or freed to buddy allocator.
  *
- * We check if a current MAX_ORDER block is valid by only checking the validity
- * of the head pfn.
+ * We check if a current MAX_PAGE_ORDER block is valid by only checking the
+ * validity of the head pfn.
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
 {
@@ -2158,8 +2158,8 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 	deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, start_pfn);
 
 	/*
-	 * Initialize and free pages in MAX_ORDER sized increments so that we
-	 * can avoid introducing any issues with the buddy allocator.
+	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so that
+	 * we can avoid introducing any issues with the buddy allocator.
 	 */
 	while (spfn < end_pfn) {
 		deferred_init_maxorder(&i, zone, &spfn, &epfn);
@@ -2300,7 +2300,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 	}
 
 	/*
-	 * Initialize and free pages in MAX_ORDER sized increments so
+	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
@@ -2518,7 +2518,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 			else
 				table = memblock_alloc_raw(size,
 							   SMP_CACHE_BYTES);
-		} else if (get_order(size) > MAX_ORDER || hashdist) {
+		} else if (get_order(size) > MAX_PAGE_ORDER || hashdist) {
 			table = vmalloc_huge(size, gfp_flags);
 			virt = true;
 			if (table)
@@ -2765,7 +2765,7 @@ void __init mm_core_init(void)
 
 	/*
 	 * page_ext requires contiguous pages,
-	 * bigger than MAX_ORDER unless SPARSEMEM.
+	 * bigger than MAX_PAGE_ORDER unless SPARSEMEM.
 	 */
 	page_ext_init_flatmem();
 	mem_debugging_and_hardening_init();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a9082a725ee..433c75ae14eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -727,7 +727,7 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 	unsigned long higher_page_pfn;
 	struct page *higher_page;
 
-	if (order >= MAX_ORDER - 1)
+	if (order >= MAX_PAGE_ORDER - 1)
 		return false;
 
 	higher_page_pfn = buddy_pfn & pfn;
@@ -782,7 +782,7 @@ static inline void __free_one_page(struct page *page,
 	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 
-	while (order < MAX_ORDER) {
+	while (order < MAX_PAGE_ORDER) {
 		if (compaction_capture(capc, page, order, migratetype)) {
 			__mod_zone_freepage_state(zone, -(1 << order),
 								migratetype);
@@ -1308,7 +1308,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 
 	if (page_contains_unaccepted(page, order)) {
-		if (order == MAX_ORDER && __free_unaccepted(page))
+		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
 			return;
 
 		accept_page(page, order);
@@ -1338,7 +1338,7 @@ void __free_pages_core(struct page *page, unsigned int order)
  *
  * Note: the function may return non-NULL struct page even for a page block
  * which contains a memory hole (i.e. there is no physical memory for a subset
- * of the pfn range). For example, if the pageblock order is MAX_ORDER, which
+ * of the pfn range). For example, if the pageblock order is MAX_PAGE_ORDER, which
  * will fall into 2 sub-sections, and the end pfn of the pageblock may be hole
  * even though the start pfn is online and valid. This should be safe most of
  * the time because struct pages are still initialized via init_unavailable_range()
@@ -2025,7 +2025,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	 * approximates finding the pageblock with the most free pages, which
 	 * would be too costly to do exactly.
 	 */
-	for (current_order = MAX_ORDER; current_order >= min_order;
+	for (current_order = MAX_PAGE_ORDER; current_order >= min_order;
 				--current_order) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
@@ -2063,7 +2063,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	 * This should not happen - we already found a suitable fallback
 	 * when looking for the largest page.
 	 */
-	VM_BUG_ON(current_order > MAX_ORDER);
+	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
 
 do_steal:
 	page = get_page_from_free_area(area, fallback_mt);
@@ -4540,7 +4540,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	 * There are several places where we assume that the order value is sane
 	 * so bail out early if the request is out of bound.
 	 */
-	if (WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp))
+	if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
 		return NULL;
 
 	gfp &= gfp_allowed_mask;
@@ -4822,7 +4822,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
  * minimum number of pages to satisfy the request.  alloc_pages() can only
  * allocate memory in power-of-two pages.
  *
- * This function is also limited by MAX_ORDER.
+ * This function is also limited by MAX_PAGE_ORDER.
  *
  * Memory allocated by this function must be released by free_pages_exact().
  *
@@ -6380,7 +6380,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	order = 0;
 	outer_start = start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_ORDER) {
+		if (++order > MAX_PAGE_ORDER) {
 			outer_start = start;
 			break;
 		}
@@ -6642,7 +6642,7 @@ bool is_free_buddy_page(struct page *page)
 			break;
 	}
 
-	return order <= MAX_ORDER;
+	return order <= MAX_PAGE_ORDER;
 }
 EXPORT_SYMBOL(is_free_buddy_page);
 
@@ -6814,9 +6814,9 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	accept_page(page, MAX_ORDER);
+	accept_page(page, MAX_PAGE_ORDER);
 
-	__free_pages_ok(page, MAX_ORDER, FPI_TO_TAIL);
+	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
 
 	if (last)
 		static_branch_dec(&zones_with_unaccepted_pages);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index bcf99ba747a0..cd0ea3668253 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -226,7 +226,7 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 */
 	if (PageBuddy(page)) {
 		order = buddy_order(page);
-		if (order >= pageblock_order && order < MAX_ORDER) {
+		if (order >= pageblock_order && order < MAX_PAGE_ORDER) {
 			buddy = find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
@@ -290,11 +290,12 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  *			isolate_single_pageblock()
  * @migratetype:	migrate type to set in error recovery.
  *
- * Free and in-use pages can be as big as MAX_ORDER and contain more than one
+ * Free and in-use pages can be as big as MAX_PAGE_ORDER and contain more than one
  * pageblock. When not all pageblocks within a page are isolated at the same
  * time, free page accounting can go wrong. For example, in the case of
- * MAX_ORDER = pageblock_order + 1, a MAX_ORDER page has two pagelbocks.
- * [         MAX_ORDER           ]
+ * MAX_PAGE_ORDER = pageblock_order + 1, a MAX_PAGE_ORDER page has two
+ * pagelbocks.
+ * [      MAX_PAGE_ORDER         ]
  * [  pageblock0  |  pageblock1  ]
  * When either pageblock is isolated, if it is a free page, the page is not
  * split into separate migratetype lists, which is supposed to; if it is an
@@ -451,7 +452,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				 * the free page to the right migratetype list.
 				 *
 				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_ORDER, but after it is
+				 * can be bigger than MAX_PAGE_ORDER, but after it is
 				 * freed, the free page order is not. Use pfn within
 				 * the range to find the head of the free page.
 				 */
@@ -459,7 +460,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				outer_pfn = pfn;
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
 					/* stop if we cannot find the free page */
-					if (++order > MAX_ORDER)
+					if (++order > MAX_PAGE_ORDER)
 						goto failed;
 					outer_pfn &= ~0UL << order;
 				}
@@ -660,8 +661,8 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	int ret;
 
 	/*
-	 * Note: pageblock_nr_pages != MAX_ORDER. Then, chunks of free pages
-	 * are not aligned to pageblock_nr_pages.
+	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
+	 * pages are not aligned to pageblock_nr_pages.
 	 * Then we just check migratetype first.
 	 */
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages) {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 4f13ce7d2452..c8a7b0572e86 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -315,7 +315,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 				unsigned long freepage_order;
 
 				freepage_order = buddy_order_unsafe(page);
-				if (freepage_order <= MAX_ORDER)
+				if (freepage_order <= MAX_PAGE_ORDER)
 					pfn += (1UL << freepage_order) - 1;
 				continue;
 			}
@@ -549,7 +549,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		if (PageBuddy(page)) {
 			unsigned long freepage_order = buddy_order_unsafe(page);
 
-			if (freepage_order <= MAX_ORDER)
+			if (freepage_order <= MAX_PAGE_ORDER)
 				pfn += (1UL << freepage_order) - 1;
 			continue;
 		}
@@ -657,7 +657,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
 			if (PageBuddy(page)) {
 				unsigned long order = buddy_order_unsafe(page);
 
-				if (order > 0 && order <= MAX_ORDER)
+				if (order > 0 && order <= MAX_PAGE_ORDER)
 					pfn += (1UL << order) - 1;
 				continue;
 			}
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 66369cc5279b..e4c428e61d8c 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -20,7 +20,7 @@ static int page_order_update_notify(const char *val, const struct kernel_param *
 	 * If param is set beyond this limit, order is set to default
 	 * pageblock_order value
 	 */
-	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER);
+	return  param_set_uint_minmax(val, kp, 0, MAX_PAGE_ORDER);
 }
 
 static const struct kernel_param_ops page_reporting_param_ops = {
@@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_ORDER)
+		if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
diff --git a/mm/shuffle.h b/mm/shuffle.h
index a6bdf54f96f1..61bbcddeeee6 100644
--- a/mm/shuffle.h
+++ b/mm/shuffle.h
@@ -4,7 +4,7 @@
 #define _MM_SHUFFLE_H
 #include <linux/jump_label.h>
 
-#define SHUFFLE_ORDER MAX_ORDER
+#define SHUFFLE_ORDER MAX_PAGE_ORDER
 
 #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
 DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
diff --git a/mm/slab.c b/mm/slab.c
index 9ad3d0f2d1a5..f90f640440dd 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -465,7 +465,7 @@ static int __init slab_max_order_setup(char *str)
 {
 	get_option(&str, &slab_max_order);
 	slab_max_order = slab_max_order < 0 ? 0 :
-				min(slab_max_order, MAX_ORDER);
+				min(slab_max_order, MAX_PAGE_ORDER);
 	slab_max_order_set = true;
 
 	return 1;
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..73e44d046510 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4187,7 +4187,7 @@ static inline int calculate_order(unsigned int size)
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
 	order = get_order(size);
-	if (order <= MAX_ORDER)
+	if (order <= MAX_PAGE_ORDER)
 		return order;
 	return -ENOSYS;
 }
@@ -4715,7 +4715,7 @@ __setup("slub_min_order=", setup_slub_min_order);
 static int __init setup_slub_max_order(char *str)
 {
 	get_option(&str, (int *)&slub_max_order);
-	slub_max_order = min_t(unsigned int, slub_max_order, MAX_ORDER);
+	slub_max_order = min_t(unsigned int, slub_max_order, MAX_PAGE_ORDER);
 
 	if (slub_min_order > slub_max_order)
 		slub_min_order = slub_max_order;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9dd8977de5a2..083eab1cf8fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6395,7 +6395,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
 	 * Confirm they are large enough for max values.
 	 */
-	BUILD_BUG_ON(MAX_ORDER >= S8_MAX);
+	BUILD_BUG_ON(MAX_PAGE_ORDER >= S8_MAX);
 	BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
 	BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index fa7d93e97f7f..cc2133fc8b73 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1092,7 +1092,7 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
 {
 	unsigned long requested = 1UL << order;
 
-	if (WARN_ON_ONCE(order > MAX_ORDER))
+	if (WARN_ON_ONCE(order > MAX_PAGE_ORDER))
 		return 0;
 
 	if (!info->free_blocks_total)
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 89981dbe46c9..97704a9e84c7 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -844,7 +844,7 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *smcibdev)
 		goto out;
 	/* the calculated number of cq entries fits to mlx5 cq allocation */
 	cqe_size_order = cache_line_size() == 128 ? 7 : 6;
-	smc_order = MAX_ORDER - cqe_size_order;
+	smc_order = MAX_PAGE_ORDER - cqe_size_order;
 	if (SMC_MAX_CQE + 2 > (0x00000001 << smc_order) * PAGE_SIZE)
 		cqattr.cqe = (0x00000001 << smc_order) * PAGE_SIZE - 2;
 	smcibdev->roce_cq_send = ib_create_cq(smcibdev->ibdev,
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 51ad29940f05..f3738b2c8bcd 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -38,7 +38,7 @@ static int param_set_bufsize(const char *val, const struct kernel_param *kp)
 
 	size = memparse(val, NULL);
 	order = get_order(size);
-	if (order > MAX_ORDER)
+	if (order > MAX_PAGE_ORDER)
 		return -EINVAL;
 	ima_maxorder = order;
 	ima_bufsize = PAGE_SIZE << order;
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 4c90cc176f81..2109690b0d5f 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -683,7 +683,7 @@ Buffer handling
 ~~~~~~~~~~~~~~~
 
 There may be buffer limitations (i.e. single ToPa entry) which means that actual
-buffer sizes are limited to powers of 2 up to 4MiB (MAX_ORDER).  In order to
+buffer sizes are limited to powers of 2 up to 4MiB (MAX_PAGE_ORDER).  In order to
 provide other sizes, and in particular an arbitrarily large size, multiple
 buffers are logically concatenated.  However an interrupt must be used to switch
 between buffers.  That has two potential problems:
diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
index 134f8eab0768..71546e15bdd3 100644
--- a/tools/testing/memblock/linux/mmzone.h
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -17,10 +17,10 @@ enum zone_type {
 };
 
 #define MAX_NR_ZONES __MAX_NR_ZONES
-#define MAX_ORDER 10
-#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
+#define MAX_PAGE_ORDER 10
+#define MAX_ORDER_NR_PAGES (1 << MAX_PAGE_ORDER)
 
-#define pageblock_order		MAX_ORDER
+#define pageblock_order		MAX_PAGE_ORDER
 #define pageblock_nr_pages	BIT(pageblock_order)
 #define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
 #define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 16ed4dfa7359..622987f12c89 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -3,7 +3,8 @@
 
    Before running this huge pages for each huge page size must have been
    reserved.
-   For large pages beyond MAX_ORDER (like 1GB on x86) boot options must be used.
+   For large pages beyond MAX_PAGE_ORDER (like 1GB on x86) boot options must
+   be used.
    Also shmmax must be increased.
    And you need to run as root to work around some weird permissions in shm.
    And nothing using huge pages should run in parallel.
-- 
2.41.0


