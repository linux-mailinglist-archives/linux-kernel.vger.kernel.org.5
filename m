Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C457B319B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjI2LpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjI2Lot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:44:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE02F1B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:44:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9363DA7;
        Fri, 29 Sep 2023 04:45:22 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC3AE3F59C;
        Fri, 29 Sep 2023 04:44:41 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 4/9] mm: thp: Introduce anon_orders and anon_always_mask sysfs files
Date:   Fri, 29 Sep 2023 12:44:15 +0100
Message-Id: <20230929114421.3761121-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929114421.3761121-1-ryan.roberts@arm.com>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for anonymous large folios that are
smaller than the PMD-size, introduce 2 new sysfs files that will be used
to control the new behaviours via the transparent_hugepage interface.
For now, the kernel still only supports PMD-order anonymous THP, so when
reading back anon_orders, it will reflect that. Therefore there are no
behavioural changes intended here.

The bulk of the change is implemented by converting
transhuge_vma_suitable() and hugepage_vma_check() so that they take a
bitfield of orders for which the user wants to determine support, and
the functions filter out all the orders that can't be supported. If
there is only 1 order set in the input then the output can continue to
be treated like a boolean; this is the case for most call sites.

The remainder is copied from Documentation/admin-guide/mm/transhuge.rst,
as modified by this commit. See that file for further details.

By default, allocation of anonymous THPs that are smaller than PMD-size
is disabled. These smaller allocation orders can be enabled by writing
an encoded set of orders as follows::

	echo 0x208 >/sys/kernel/mm/transparent_hugepage/anon_orders

Where an order refers to the number of pages in the large folio as
2^order, and where each order is encoded in the written value such that
each set bit represents an enabled order; So setting bit-2 indicates
that order-2 folios are in use, and order-2 means 2^2=4 pages (=16K if
the page size is 4K). The example above enables order-9 (PMD-order) and
order-3.

By enabling multiple orders, allocation of each order will be attempted,
highest to lowest, until a successful allocation is made. If the
PMD-order is unset, then no PMD-sized THPs will be allocated.

The kernel will ignore any orders that it does not support so read the
file back to determine which orders are enabled::

	cat /sys/kernel/mm/transparent_hugepage/anon_orders

For some workloads it may be desirable to limit some THP orders to be
used only for MADV_HUGEPAGE regions, while allowing others to be used
always. For example, a workload may only benefit from PMD-sized THP in
specific areas, but can take benefit of 32K sized THP more generally. In
this case, THP can be enabled in ``madvise`` mode as normal, but
specific orders can be configured to be allocated as if in ``always``
mode. The below example enables orders 9 and 3, with order-9 only
applied to MADV_HUGEPAGE regions, and order-3 applied always::

	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
	echo 0x208 >/sys/kernel/mm/transparent_hugepage/anon_orders
	echo 0x008 >/sys/kernel/mm/transparent_hugepage/anon_always_mask

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  74 ++++++++--
 Documentation/filesystems/proc.rst         |   6 +-
 fs/proc/task_mmu.c                         |   3 +-
 include/linux/huge_mm.h                    |  93 +++++++++---
 mm/huge_memory.c                           | 164 ++++++++++++++++++---
 mm/khugepaged.c                            |  18 ++-
 mm/memory.c                                |   6 +-
 mm/page_vma_mapped.c                       |   3 +-
 8 files changed, 296 insertions(+), 71 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index ebda57850643..9f954e73a4ca 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -45,10 +45,22 @@ components:
    the two is using hugepages just because of the fact the TLB miss is
    going to run faster.
 
+Furthermore, it is possible to configure THP to allocate large folios
+to back anonymous memory, which are smaller than PMD-size (for example
+16K, 32K, 64K, etc). These THPs continue to be PTE-mapped, but in many
+cases can still provide the similar benefits to those outlined above:
+Page faults are significantly reduced (by a factor of e.g. 4, 8, 16,
+etc), but latency spikes are much less prominent because the size of
+each page isn't as huge as the PMD-sized variant and there is less
+memory to clear in each page fault. Some architectures also employ TLB
+compression mechanisms to squeeze more entries in when a set of PTEs
+are virtually and physically contiguous and approporiately aligned. In
+this case, TLB misses will occur less often.
+
 THP can be enabled system wide or restricted to certain tasks or even
 memory ranges inside task's address space. Unless THP is completely
 disabled, there is ``khugepaged`` daemon that scans memory and
-collapses sequences of basic pages into huge pages.
+collapses sequences of basic pages into PMD-sized huge pages.
 
 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
 interface and using madvise(2) and prctl(2) system calls.
@@ -146,25 +158,69 @@ madvise
 never
 	should be self-explanatory.
 
-By default kernel tries to use huge zero page on read page fault to
-anonymous mapping. It's possible to disable huge zero page by writing 0
-or enable it back by writing 1::
+By default kernel tries to use huge, PMD-mapped zero page on read page
+fault to anonymous mapping. It's possible to disable huge zero page by
+writing 0 or enable it back by writing 1::
 
 	echo 0 >/sys/kernel/mm/transparent_hugepage/use_zero_page
 	echo 1 >/sys/kernel/mm/transparent_hugepage/use_zero_page
 
 Some userspace (such as a test program, or an optimized memory allocation
-library) may want to know the size (in bytes) of a transparent hugepage::
+library) may want to know the size (in bytes) of a PMD-mappable
+transparent hugepage::
 
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
 
+By default, allocation of anonymous THPs that are smaller than
+PMD-size is disabled. These smaller allocation orders can be enabled
+by writing an encoded set of orders as follows::
+
+	echo 0x208 >/sys/kernel/mm/transparent_hugepage/anon_orders
+
+Where an order refers to the number of pages in the large folio as
+2^order, and where each order is encoded in the written value such
+that each set bit represents an enabled order; So setting bit-2
+indicates that order-2 folios are in use, and order-2 means 2^2=4
+pages (=16K if the page size is 4K). The example above enables order-9
+(PMD-order) and order-3.
+
+By enabling multiple orders, allocation of each order will be
+attempted, highest to lowest, until a successful allocation is made.
+If the PMD-order is unset, then no PMD-sized THPs will be allocated.
+
+The kernel will ignore any orders that it does not support so read the
+file back to determine which orders are enabled::
+
+	cat /sys/kernel/mm/transparent_hugepage/anon_orders
+
+For some workloads it may be desirable to limit some THP orders to be
+used only for MADV_HUGEPAGE regions, while allowing others to be used
+always. For example, a workload may only benefit from PMD-sized THP in
+specific areas, but can take benefit of 32K sized THP more generally.
+In this case, THP can be enabled in ``madvise`` mode as normal, but
+specific orders can be configured to be allocated as if in ``always``
+mode. The below example enables orders 9 and 3, with order-9 only
+applied to MADV_HUGEPAGE regions, and order-3 applied always::
+
+	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
+	echo 0x208 >/sys/kernel/mm/transparent_hugepage/anon_orders
+	echo 0x008 >/sys/kernel/mm/transparent_hugepage/anon_always_mask
+
 khugepaged will be automatically started when
-transparent_hugepage/enabled is set to "always" or "madvise, and it'll
-be automatically shutdown if it's set to "never".
+transparent_hugepage/enabled is set to "always" or "madvise",
+providing the PMD-order is enabled in
+transparent_hugepage/anon_orders, and it'll be automatically shutdown
+if it's set to "never" or the PMD-order is disabled in
+transparent_hugepage/anon_orders.
 
 Khugepaged controls
 -------------------
 
+.. note::
+   khugepaged currently only searches for opportunities to collapse to
+   PMD-sized THP and no attempt is made to collapse to smaller order
+   THP.
+
 khugepaged runs usually at low frequency so while one may not want to
 invoke defrag algorithms synchronously during the page faults, it
 should be worth invoking defrag at least in khugepaged. However it's
@@ -285,7 +341,7 @@ Need of application restart
 The transparent_hugepage/enabled values and tmpfs mount option only affect
 future behavior. So to make them effective you need to restart any
 application that could have been using hugepages. This also applies to the
-regions registered in khugepaged.
+regions registered in khugepaged, and transparent_hugepage/anon_orders.
 
 Monitoring usage
 ================
@@ -416,7 +472,7 @@ for huge pages.
 Optimizing the applications
 ===========================
 
-To be guaranteed that the kernel will map a 2M page immediately in any
+To be guaranteed that the kernel will map a thp immediately in any
 memory region, the mmap region has to be hugepage naturally
 aligned. posix_memalign() can provide that guarantee.
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index ccbb76a509f0..72526f8bb658 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -533,9 +533,9 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.
 
-"THPeligible" indicates whether the mapping is eligible for allocating THP
-pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
-It just shows the current status.
+"THPeligible" indicates whether the mapping is eligible for allocating
+naturally aligned THP pages of any currently enabled order. 1 if true, 0
+otherwise. It just shows the current status.
 
 "VmFlags" field deserves a separate description. This member represents the
 kernel flags associated with the particular virtual memory area in two letter
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 7b5dad163533..f978dce7f7ce 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -869,7 +869,8 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %8u\n",
-		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
+		   !!hugepage_vma_check(vma, vma->vm_flags, true, false, true,
+					THP_ORDERS_ALL));
 
 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..2e7c338229a6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -67,6 +67,21 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
+/*
+ * Mask of all large folio orders supported for anonymous THP.
+ */
+#define THP_ORDERS_ALL_ANON	BIT(PMD_ORDER)
+
+/*
+ * Mask of all large folio orders supported for file THP.
+ */
+#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
+
+/*
+ * Mask of all large folio orders supported for THP.
+ */
+#define THP_ORDERS_ALL		(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
@@ -77,6 +92,7 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 
 extern unsigned long transparent_hugepage_flags;
+extern unsigned int huge_anon_orders;
 
 #define hugepage_flags_enabled()					       \
 	(transparent_hugepage_flags &				       \
@@ -86,6 +102,17 @@ extern unsigned long transparent_hugepage_flags;
 	(transparent_hugepage_flags &			\
 	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
 
+static inline int first_order(unsigned int orders)
+{
+	return fls(orders) - 1;
+}
+
+static inline int next_order(unsigned int *orders, int prev)
+{
+	*orders &= ~BIT(prev);
+	return first_order(*orders);
+}
+
 /*
  * Do the below checks:
  *   - For file vma, check if the linear page offset of vma is
@@ -97,23 +124,39 @@ extern unsigned long transparent_hugepage_flags;
  *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
  *     area.
  */
-static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long addr)
-{
-	unsigned long haddr;
-
-	/* Don't have to check pgoff for anonymous vma */
-	if (!vma_is_anonymous(vma)) {
-		if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
-				HPAGE_PMD_NR))
-			return false;
+static inline unsigned int transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long addr, unsigned int orders)
+{
+	int order;
+
+	/*
+	 * Iterate over orders, highest to lowest, removing orders that don't
+	 * meet alignment requirements from the set. Exit loop at first order
+	 * that meets requirements, since all lower orders must also meet
+	 * requirements.
+	 */
+
+	order = first_order(orders);
+
+	while (orders) {
+		unsigned long hpage_size = PAGE_SIZE << order;
+		unsigned long haddr = ALIGN_DOWN(addr, hpage_size);
+
+		if (haddr >= vma->vm_start &&
+		    haddr + hpage_size <= vma->vm_end) {
+			if (!vma_is_anonymous(vma)) {
+				if (IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
+						vma->vm_pgoff,
+						hpage_size >> PAGE_SHIFT))
+					break;
+			} else
+				break;
+		}
+
+		order = next_order(&orders, order);
 	}
 
-	haddr = addr & HPAGE_PMD_MASK;
-
-	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
-		return false;
-	return true;
+	return orders;
 }
 
 static inline bool file_thp_enabled(struct vm_area_struct *vma)
@@ -130,8 +173,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }
 
-bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
-			bool smaps, bool in_pf, bool enforce_sysfs);
+unsigned int hugepage_vma_check(struct vm_area_struct *vma,
+				unsigned long vm_flags, bool smaps, bool in_pf,
+				bool enforce_sysfs, unsigned int orders);
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -267,17 +311,18 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return false;
 }
 
-static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long addr)
+static inline unsigned int transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long addr, unsigned int orders)
 {
-	return false;
+	return 0;
 }
 
-static inline bool hugepage_vma_check(struct vm_area_struct *vma,
-				      unsigned long vm_flags, bool smaps,
-				      bool in_pf, bool enforce_sysfs)
+static inline unsigned int hugepage_vma_check(struct vm_area_struct *vma,
+					unsigned long vm_flags, bool smaps,
+					bool in_pf, bool enforce_sysfs,
+					unsigned int orders)
 {
-	return false;
+	return 0;
 }
 
 static inline void folio_prep_large_rmappable(struct folio *folio) {}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd90822b..bcecce769017 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -70,12 +70,48 @@ static struct shrinker deferred_split_shrinker;
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
+unsigned int huge_anon_orders __read_mostly = BIT(PMD_ORDER);
+static unsigned int huge_anon_always_mask __read_mostly;
 
-bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
-			bool smaps, bool in_pf, bool enforce_sysfs)
+/**
+ * hugepage_vma_check - determine which hugepage orders can be applied to vma
+ * @vma:  the vm area to check
+ * @vm_flags: use these vm_flags instead of vma->vm_flags
+ * @smaps: whether answer will be used for smaps file
+ * @in_pf: whether answer will be used by page fault handler
+ * @enforce_sysfs: whether sysfs config should be taken into account
+ * @orders: bitfield of all orders to consider
+ *
+ * Calculates the intersection of the requested hugepage orders and the allowed
+ * hugepage orders for the provided vma. Permitted orders are encoded as a set
+ * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
+ * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
+ *
+ * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
+ * orders are allowed.
+ */
+unsigned int hugepage_vma_check(struct vm_area_struct *vma,
+				unsigned long vm_flags, bool smaps, bool in_pf,
+				bool enforce_sysfs, unsigned int orders)
 {
+	/*
+	 * Fix up the orders mask; Supported orders for file vmas are static.
+	 * Supported orders for anon vmas are configured dynamically - but only
+	 * use the dynamic set if enforce_sysfs=true, otherwise use the full
+	 * set.
+	 */
+	if (vma_is_anonymous(vma))
+		orders &= enforce_sysfs ? READ_ONCE(huge_anon_orders)
+					: THP_ORDERS_ALL_ANON;
+	else
+		orders &= THP_ORDERS_ALL_FILE;
+
+	/* No orders in the intersection. */
+	if (!orders)
+		return 0;
+
 	if (!vma->vm_mm)		/* vdso */
-		return false;
+		return 0;
 
 	/*
 	 * Explicitly disabled through madvise or prctl, or some
@@ -84,16 +120,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * */
 	if ((vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-		return false;
+		return 0;
 	/*
 	 * If the hardware/firmware marked hugepage support disabled.
 	 */
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
-		return false;
+		return 0;
 
 	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
 	if (vma_is_dax(vma))
-		return in_pf;
+		return in_pf ? orders : 0;
 
 	/*
 	 * Special VMA and hugetlb VMA.
@@ -101,17 +137,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * VM_MIXEDMAP set.
 	 */
 	if (vm_flags & VM_NO_KHUGEPAGED)
-		return false;
+		return 0;
 
 	/*
-	 * Check alignment for file vma and size for both file and anon vma.
+	 * Check alignment for file vma and size for both file and anon vma by
+	 * filtering out the unsuitable orders.
 	 *
 	 * Skip the check for page fault. Huge fault does the check in fault
-	 * handlers. And this check is not suitable for huge PUD fault.
+	 * handlers.
 	 */
-	if (!in_pf &&
-	    !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
-		return false;
+	if (!in_pf) {
+		int order = first_order(orders);
+		unsigned long addr;
+
+		while (orders) {
+			addr = vma->vm_end - (PAGE_SIZE << order);
+			if (transhuge_vma_suitable(vma, addr, BIT(order)))
+				break;
+			order = next_order(&orders, order);
+		}
+
+		if (!orders)
+			return 0;
+	}
 
 	/*
 	 * Enabled via shmem mount options or sysfs settings.
@@ -120,23 +168,35 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 */
 	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
-				     !enforce_sysfs, vma->vm_mm, vm_flags);
+				     !enforce_sysfs, vma->vm_mm, vm_flags)
+			? orders : 0;
 
 	/* Enforce sysfs THP requirements as necessary */
-	if (enforce_sysfs &&
-	    (!hugepage_flags_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-					   !hugepage_flags_always())))
-		return false;
+	if (enforce_sysfs) {
+		/* enabled=never. */
+		if (!hugepage_flags_enabled())
+			return 0;
+
+		/* enabled=madvise without VM_HUGEPAGE. */
+		if (!(vm_flags & VM_HUGEPAGE) && !hugepage_flags_always()) {
+			if (vma_is_anonymous(vma)) {
+				orders &= READ_ONCE(huge_anon_always_mask);
+				if (!orders)
+					return 0;
+			} else
+				return 0;
+		}
+	}
 
 	/* Only regular file is valid */
 	if (!in_pf && file_thp_enabled(vma))
-		return true;
+		return orders;
 
 	if (!vma_is_anonymous(vma))
-		return false;
+		return 0;
 
 	if (vma_is_temporary_stack(vma))
-		return false;
+		return 0;
 
 	/*
 	 * THPeligible bit of smaps should show 1 for proper VMAs even
@@ -146,9 +206,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * the first page fault.
 	 */
 	if (!vma->anon_vma)
-		return (smaps || in_pf);
+		return (smaps || in_pf) ? orders : 0;
 
-	return true;
+	return orders;
 }
 
 static bool get_huge_zero_page(void)
@@ -391,11 +451,69 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+static ssize_t anon_orders_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0x%08x\n", READ_ONCE(huge_anon_orders));
+}
+
+static ssize_t anon_orders_store(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 const char *buf, size_t count)
+{
+	int err;
+	int ret = count;
+	unsigned int orders;
+
+	err = kstrtouint(buf, 0, &orders);
+	if (err)
+		ret = -EINVAL;
+
+	if (ret > 0) {
+		orders &= THP_ORDERS_ALL_ANON;
+		WRITE_ONCE(huge_anon_orders, orders);
+
+		err = start_stop_khugepaged();
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static struct kobj_attribute anon_orders_attr = __ATTR_RW(anon_orders);
+
+static ssize_t anon_always_mask_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "0x%08x\n", READ_ONCE(huge_anon_always_mask));
+}
+
+static ssize_t anon_always_mask_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int err;
+	unsigned int always_mask;
+
+	err = kstrtouint(buf, 0, &always_mask);
+	if (err)
+		return -EINVAL;
+
+	WRITE_ONCE(huge_anon_always_mask, always_mask);
+
+	return count;
+}
+
+static struct kobj_attribute anon_always_mask_attr = __ATTR_RW(anon_always_mask);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
 	&use_zero_page_attr.attr,
 	&hpage_pmd_size_attr.attr,
+	&anon_orders_attr.attr,
+	&anon_always_mask_attr.attr,
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
@@ -778,7 +896,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 
-	if (!transhuge_vma_suitable(vma, haddr))
+	if (!transhuge_vma_suitable(vma, haddr, BIT(PMD_ORDER)))
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..2b5c0321d96b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -446,7 +446,8 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    hugepage_flags_enabled()) {
-		if (hugepage_vma_check(vma, vm_flags, false, false, true))
+		if (hugepage_vma_check(vma, vm_flags, false, false, true,
+				       BIT(PMD_ORDER)))
 			__khugepaged_enter(vma->vm_mm);
 	}
 }
@@ -921,10 +922,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	if (!vma)
 		return SCAN_VMA_NULL;
 
-	if (!transhuge_vma_suitable(vma, address))
+	if (!transhuge_vma_suitable(vma, address, BIT(PMD_ORDER)))
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false,
-				cc->is_khugepaged))
+				cc->is_khugepaged, BIT(PMD_ORDER)))
 		return SCAN_VMA_CHECK;
 	/*
 	 * Anon VMA expected, the address may be unmapped then
@@ -1499,7 +1500,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
 	 * analogously elide sysfs THP settings here.
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false,
+				BIT(PMD_ORDER)))
 		return SCAN_VMA_CHECK;
 
 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2369,7 +2371,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags, false, false, true)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false, false, true,
+					BIT(PMD_ORDER))) {
 skip:
 			progress++;
 			continue;
@@ -2626,7 +2629,7 @@ int start_stop_khugepaged(void)
 	int err = 0;
 
 	mutex_lock(&khugepaged_mutex);
-	if (hugepage_flags_enabled()) {
+	if (hugepage_flags_enabled() && (huge_anon_orders & BIT(PMD_ORDER))) {
 		if (!khugepaged_thread)
 			khugepaged_thread = kthread_run(khugepaged, NULL,
 							"khugepaged");
@@ -2706,7 +2709,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 
 	*prev = vma;
 
-	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false,
+				BIT(PMD_ORDER)))
 		return -EINVAL;
 
 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
diff --git a/mm/memory.c b/mm/memory.c
index e4b0f6a461d8..b5b82fc8e164 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4256,7 +4256,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
-	if (!transhuge_vma_suitable(vma, haddr))
+	if (!transhuge_vma_suitable(vma, haddr, BIT(PMD_ORDER)))
 		return ret;
 
 	page = compound_head(page);
@@ -5055,7 +5055,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 retry_pud:
 	if (pud_none(*vmf.pud) &&
-	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
+	    hugepage_vma_check(vma, vm_flags, false, true, true, BIT(PUD_ORDER))) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -5089,7 +5089,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		goto retry_pud;
 
 	if (pmd_none(*vmf.pmd) &&
-	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
+	    hugepage_vma_check(vma, vm_flags, false, true, true, BIT(PMD_ORDER))) {
 		ret = create_huge_pmd(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e0b368e545ed..5f7e89c5b595 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -268,7 +268,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			 * cleared *pmd but not decremented compound_mapcount().
 			 */
 			if ((pvmw->flags & PVMW_SYNC) &&
-			    transhuge_vma_suitable(vma, pvmw->address) &&
+			    transhuge_vma_suitable(vma, pvmw->address,
+						   BIT(PMD_ORDER)) &&
 			    (pvmw->nr_pages >= HPAGE_PMD_NR)) {
 				spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
 
-- 
2.25.1

