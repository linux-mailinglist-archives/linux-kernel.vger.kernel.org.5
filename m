Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B47F4C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjKVQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjKVQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:30:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CA001B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:30:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35A2A176B;
        Wed, 22 Nov 2023 08:31:01 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A217C3F73F;
        Wed, 22 Nov 2023 08:30:11 -0800 (PST)
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
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs interface
Date:   Wed, 22 Nov 2023 16:29:43 +0000
Message-Id: <20231122162950.3854897-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122162950.3854897-1-ryan.roberts@arm.com>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding support for anonymous small-sized THP,
introduce new sysfs structure that will be used to control the new
behaviours. A new directory is added under transparent_hugepage for each
supported THP size, and contains an `enabled` file, which can be set to
"global" (to inherrit the global setting), "always", "madvise" or
"never". For now, the kernel still only supports PMD-sized anonymous
THP, so only 1 directory is populated.

The first half of the change converts transhuge_vma_suitable() and
hugepage_vma_check() so that they take a bitfield of orders for which
the user wants to determine support, and the functions filter out all
the orders that can't be supported, given the current sysfs
configuration and the VMA dimensions. If there is only 1 order set in
the input then the output can continue to be treated like a boolean;
this is the case for most call sites.

The second half of the change implements the new sysfs interface. It has
been done so that each supported THP size has a `struct thpsize`, which
describes the relevant metadata and is itself a kobject. This is pretty
minimal for now, but should make it easy to add new per-thpsize files to
the interface if needed in future (e.g. per-size defrag). Rather than
keep the `enabled` state directly in the struct thpsize, I've elected to
directly encode it into huge_anon_orders_[always|madvise|global]
bitfields since this reduces the amount of work required in
transhuge_vma_suitable() which is called for every page fault.

The remainder is copied from Documentation/admin-guide/mm/transhuge.rst,
as modified by this commit. See that file for further details.

Transparent Hugepage Support for anonymous memory can be entirely
disabled (mostly for debugging purposes) or only enabled inside
MADV_HUGEPAGE regions (to avoid the risk of consuming more memory
resources) or enabled system wide. This can be achieved
per-supported-THP-size with one of::

	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled

where <size> is the hugepage size being addressed, the available sizes
for which vary by system. Alternatively it is possible to specify that
a given hugepage size will inherrit the global enabled setting::

	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled

The global (legacy) enabled setting can be set as follows::

	echo always >/sys/kernel/mm/transparent_hugepage/enabled
	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
	echo never >/sys/kernel/mm/transparent_hugepage/enabled

By default, PMD-sized hugepages have enabled="global" and all other
hugepage sizes have enabled="never". If enabling multiple hugepage
sizes, the kernel will select the most appropriate enabled size for a
given allocation.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  74 ++++--
 Documentation/filesystems/proc.rst         |   6 +-
 fs/proc/task_mmu.c                         |   3 +-
 include/linux/huge_mm.h                    | 100 +++++---
 mm/huge_memory.c                           | 263 +++++++++++++++++++--
 mm/khugepaged.c                            |  16 +-
 mm/memory.c                                |   6 +-
 mm/page_vma_mapped.c                       |   3 +-
 8 files changed, 387 insertions(+), 84 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b0cc8243e093..52565e0bd074 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -45,10 +45,23 @@ components:
    the two is using hugepages just because of the fact the TLB miss is
    going to run faster.

+As well as PMD-sized THP described above, it is also possible to
+configure the system to allocate "small-sized THP" to back anonymous
+memory (for example 16K, 32K, 64K, etc). These THPs continue to be
+PTE-mapped, but in many cases can still provide similar benefits to
+those outlined above: Page faults are significantly reduced (by a
+factor of e.g. 4, 8, 16, etc), but latency spikes are much less
+prominent because the size of each page isn't as huge as the PMD-sized
+variant and there is less memory to clear in each page fault. Some
+architectures also employ TLB compression mechanisms to squeeze more
+entries in when a set of PTEs are virtually and physically contiguous
+and approporiately aligned. In this case, TLB misses will occur less
+often.
+
 THP can be enabled system wide or restricted to certain tasks or even
 memory ranges inside task's address space. Unless THP is completely
 disabled, there is ``khugepaged`` daemon that scans memory and
-collapses sequences of basic pages into huge pages.
+collapses sequences of basic pages into PMD-sized huge pages.

 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
 interface and using madvise(2) and prctl(2) system calls.
@@ -95,12 +108,29 @@ Global THP controls
 Transparent Hugepage Support for anonymous memory can be entirely disabled
 (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
 regions (to avoid the risk of consuming more memory resources) or enabled
-system wide. This can be achieved with one of::
+system wide. This can be achieved per-supported-THP-size with one of::
+
+	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
+	echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
+	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
+
+where <size> is the hugepage size being addressed, the available sizes
+for which vary by system. Alternatively it is possible to specify that
+a given hugepage size will inherrit the global enabled setting::
+
+	echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
+
+The global (legacy) enabled setting can be set as follows::

 	echo always >/sys/kernel/mm/transparent_hugepage/enabled
 	echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
 	echo never >/sys/kernel/mm/transparent_hugepage/enabled

+By default, PMD-sized hugepages have enabled="global" and all other
+hugepage sizes have enabled="never". If enabling multiple hugepage
+sizes, the kernel will select the most appropriate enabled size for a
+given allocation.
+
 It's also possible to limit defrag efforts in the VM to generate
 anonymous hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
@@ -146,25 +176,34 @@ madvise
 never
 	should be self-explanatory.

-By default kernel tries to use huge zero page on read page fault to
-anonymous mapping. It's possible to disable huge zero page by writing 0
-or enable it back by writing 1::
+By default kernel tries to use huge, PMD-mappable zero page on read
+page fault to anonymous mapping. It's possible to disable huge zero
+page by writing 0 or enable it back by writing 1::

 	echo 0 >/sys/kernel/mm/transparent_hugepage/use_zero_page
 	echo 1 >/sys/kernel/mm/transparent_hugepage/use_zero_page

-Some userspace (such as a test program, or an optimized memory allocation
-library) may want to know the size (in bytes) of a transparent hugepage::
+Some userspace (such as a test program, or an optimized memory
+allocation library) may want to know the size (in bytes) of a
+PMD-mappable transparent hugepage::

 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size

-khugepaged will be automatically started when
-transparent_hugepage/enabled is set to "always" or "madvise, and it'll
-be automatically shutdown if it's set to "never".
+khugepaged will be automatically started when one or more hugepage
+sizes are enabled (either by directly setting "always" or "madvise",
+or by setting "global" while the global enabled is set to "always" or
+"madvise"), and it'll be automatically shutdown when the last hugepage
+size is disabled (either by directly setting "never", or by setting
+"global" while the global enabled is set to "never").

 Khugepaged controls
 -------------------

+.. note::
+   khugepaged currently only searches for opportunities to collapse to
+   PMD-sized THP and no attempt is made to collapse to small-sized
+   THP.
+
 khugepaged runs usually at low frequency so while one may not want to
 invoke defrag algorithms synchronously during the page faults, it
 should be worth invoking defrag at least in khugepaged. However it's
@@ -282,10 +321,11 @@ force
 Need of application restart
 ===========================

-The transparent_hugepage/enabled values and tmpfs mount option only affect
-future behavior. So to make them effective you need to restart any
-application that could have been using hugepages. This also applies to the
-regions registered in khugepaged.
+The transparent_hugepage/enabled and
+transparent_hugepage/hugepages-<size>kB/enabled values and tmpfs mount
+option only affect future behavior. So to make them effective you need
+to restart any application that could have been using hugepages. This
+also applies to the regions registered in khugepaged.

 Monitoring usage
 ================
@@ -308,6 +348,10 @@ frequently will incur overhead.
 There are a number of counters in ``/proc/vmstat`` that may be used to
 monitor how successfully the system is providing huge pages for use.

+.. note::
+   Currently the below counters only record events relating to
+   PMD-sized THP. Events relating to small-sized THP are not included.
+
 thp_fault_alloc
 	is incremented every time a huge page is successfully
 	allocated to handle a page fault.
@@ -413,7 +457,7 @@ for huge pages.
 Optimizing the applications
 ===========================

-To be guaranteed that the kernel will map a 2M page immediately in any
+To be guaranteed that the kernel will map a THP immediately in any
 memory region, the mmap region has to be hugepage naturally
 aligned. posix_memalign() can provide that guarantee.

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 49ef12df631b..f8e8dd1fd148 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -528,9 +528,9 @@ replaced by copy-on-write) part of the underlying shmem object out on swap.
 does not take into account swapped out page of underlying shmem objects.
 "Locked" indicates whether the mapping is locked in memory or not.

-"THPeligible" indicates whether the mapping is eligible for allocating THP
-pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
-It just shows the current status.
+"THPeligible" indicates whether the mapping is eligible for allocating
+naturally aligned THP pages of any currently enabled size. 1 if true, 0
+otherwise. It just shows the current status.

 "VmFlags" field deserves a separate description. This member represents the
 kernel flags associated with the particular virtual memory area in two letter
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51e0ec658457..2e25362ca9fa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -865,7 +865,8 @@ static int show_smap(struct seq_file *m, void *v)
 	__show_smap(m, &mss, false);

 	seq_printf(m, "THPeligible:    %8u\n",
-		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
+		   !!hugepage_vma_check(vma, vma->vm_flags, true, false, true,
+					THP_ORDERS_ALL));

 	if (arch_pkeys_enabled())
 		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..7d6f7d96b039 100644
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
@@ -78,13 +93,18 @@ extern struct kobj_attribute shmem_enabled_attr;

 extern unsigned long transparent_hugepage_flags;

-#define hugepage_flags_enabled()					       \
-	(transparent_hugepage_flags &				       \
-	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		       \
-	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
-#define hugepage_flags_always()				\
-	(transparent_hugepage_flags &			\
-	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
+bool hugepage_flags_enabled(void);
+
+static inline int first_order(unsigned long orders)
+{
+	return fls_long(orders) - 1;
+}
+
+static inline int next_order(unsigned long *orders, int prev)
+{
+	*orders &= ~BIT(prev);
+	return first_order(*orders);
+}

 /*
  * Do the below checks:
@@ -97,23 +117,39 @@ extern unsigned long transparent_hugepage_flags;
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
+static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long orders)
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
@@ -130,8 +166,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
 	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
 }

-bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
-			bool smaps, bool in_pf, bool enforce_sysfs);
+unsigned long hugepage_vma_check(struct vm_area_struct *vma,
+				 unsigned long vm_flags, bool smaps, bool in_pf,
+				 bool enforce_sysfs, unsigned long orders);

 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
@@ -267,17 +304,18 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 	return false;
 }

-static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long addr)
+static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long orders)
 {
-	return false;
+	return 0;
 }

-static inline bool hugepage_vma_check(struct vm_area_struct *vma,
-				      unsigned long vm_flags, bool smaps,
-				      bool in_pf, bool enforce_sysfs)
+static inline unsigned long hugepage_vma_check(struct vm_area_struct *vma,
+					unsigned long vm_flags, bool smaps,
+					bool in_pf, bool enforce_sysfs,
+					unsigned long orders)
 {
-	return false;
+	return 0;
 }

 static inline void folio_prep_large_rmappable(struct folio *folio) {}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6eb55f97a3d2..0b545d56420c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -74,12 +74,60 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
+static unsigned long huge_anon_orders_always __read_mostly;
+static unsigned long huge_anon_orders_madvise __read_mostly;
+static unsigned long huge_anon_orders_global __read_mostly;

-bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
-			bool smaps, bool in_pf, bool enforce_sysfs)
+#define hugepage_global_enabled()			\
+	(transparent_hugepage_flags &			\
+	 ((1<<TRANSPARENT_HUGEPAGE_FLAG) |		\
+	  (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
+
+#define hugepage_global_always()			\
+	(transparent_hugepage_flags &			\
+	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
+
+bool hugepage_flags_enabled(void)
 {
+	/*
+	 * We cover both the anon and the file-backed case here; we must return
+	 * true if globally enabled, even when all anon sizes are set to never.
+	 * So we don't need to look at huge_anon_orders_global.
+	 */
+	return hugepage_global_enabled() ||
+	       huge_anon_orders_always ||
+	       huge_anon_orders_madvise;
+}
+
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
+unsigned long hugepage_vma_check(struct vm_area_struct *vma,
+				 unsigned long vm_flags, bool smaps, bool in_pf,
+				 bool enforce_sysfs, unsigned long orders)
+{
+	/* Check the intersection of requested and supported orders. */
+	orders &= vma_is_anonymous(vma) ?
+			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
+	if (!orders)
+		return 0;
+
 	if (!vma->vm_mm)		/* vdso */
-		return false;
+		return 0;

 	/*
 	 * Explicitly disabled through madvise or prctl, or some
@@ -88,16 +136,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
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
 	 * khugepaged special VMA and hugetlb VMA.
@@ -105,17 +153,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * VM_MIXEDMAP set.
 	 */
 	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
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
@@ -124,13 +184,27 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
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
+		if (vma_is_anonymous(vma)) {
+			unsigned long mask = READ_ONCE(huge_anon_orders_always);
+
+			if (vm_flags & VM_HUGEPAGE)
+				mask |= READ_ONCE(huge_anon_orders_madvise);
+			if (hugepage_global_always() ||
+			   ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
+				mask |= READ_ONCE(huge_anon_orders_global);
+
+			orders &= mask;
+			if (!orders)
+				return 0;
+		} else if (!hugepage_global_enabled() ||
+			  (!(vm_flags & VM_HUGEPAGE) && !hugepage_global_always()))
+			return 0;
+	}

 	if (!vma_is_anonymous(vma)) {
 		/*
@@ -138,15 +212,15 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 		 * in fault path.
 		 */
 		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
-			return true;
+			return orders;
 		/* Only regular file is valid in collapse path */
 		if (((!in_pf || smaps)) && file_thp_enabled(vma))
-			return true;
-		return false;
+			return orders;
+		return 0;
 	}

 	if (vma_is_temporary_stack(vma))
-		return false;
+		return 0;

 	/*
 	 * THPeligible bit of smaps should show 1 for proper VMAs even
@@ -156,9 +230,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * the first page fault.
 	 */
 	if (!vma->anon_vma)
-		return (smaps || in_pf);
+		return (smaps || in_pf) ? orders : 0;

-	return true;
+	return orders;
 }

 static bool get_huge_zero_page(void)
@@ -412,9 +486,127 @@ static const struct attribute_group hugepage_attr_group = {
 	.attrs = hugepage_attr,
 };

+static void hugepage_exit_sysfs(struct kobject *hugepage_kobj);
+static void thpsize_release(struct kobject *kobj);
+static LIST_HEAD(thpsize_list);
+
+struct thpsize {
+	struct kobject kobj;
+	struct list_head node;
+	int order;
+};
+
+#define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
+
+static ssize_t thpsize_enabled_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	int order = to_thpsize(kobj)->order;
+	const char *output;
+
+	if (test_bit(order, &huge_anon_orders_always))
+		output = "[always] global madvise never";
+	else if (test_bit(order, &huge_anon_orders_global))
+		output = "always [global] madvise never";
+	else if (test_bit(order, &huge_anon_orders_madvise))
+		output = "always global [madvise] never";
+	else
+		output = "always global madvise [never]";
+
+	return sysfs_emit(buf, "%s\n", output);
+}
+
+static ssize_t thpsize_enabled_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int order = to_thpsize(kobj)->order;
+	ssize_t ret = count;
+
+	if (sysfs_streq(buf, "always")) {
+		set_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_global);
+		clear_bit(order, &huge_anon_orders_madvise);
+	} else if (sysfs_streq(buf, "global")) {
+		set_bit(order, &huge_anon_orders_global);
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_madvise);
+	} else if (sysfs_streq(buf, "madvise")) {
+		set_bit(order, &huge_anon_orders_madvise);
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_global);
+	} else if (sysfs_streq(buf, "never")) {
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_global);
+		clear_bit(order, &huge_anon_orders_madvise);
+	} else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static struct kobj_attribute thpsize_enabled_attr =
+	__ATTR(enabled, 0644, thpsize_enabled_show, thpsize_enabled_store);
+
+static struct attribute *thpsize_attrs[] = {
+	&thpsize_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group thpsize_attr_group = {
+	.attrs = thpsize_attrs,
+};
+
+static const struct kobj_type thpsize_ktype = {
+	.release = &thpsize_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static struct thpsize *thpsize_create(int order, struct kobject *parent)
+{
+	unsigned long size = (PAGE_SIZE << order) / SZ_1K;
+	struct thpsize *thpsize;
+	int ret;
+
+	thpsize = kzalloc(sizeof(*thpsize), GFP_KERNEL);
+	if (!thpsize)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
+				   "hugepages-%lukB", size);
+	if (ret) {
+		kfree(thpsize);
+		return ERR_PTR(ret);
+	}
+
+	ret = sysfs_create_group(&thpsize->kobj, &thpsize_attr_group);
+	if (ret) {
+		kobject_put(&thpsize->kobj);
+		return ERR_PTR(ret);
+	}
+
+	thpsize->order = order;
+	return thpsize;
+}
+
+static void thpsize_release(struct kobject *kobj)
+{
+	kfree(to_thpsize(kobj));
+}
+
 static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 {
 	int err;
+	struct thpsize *thpsize;
+	unsigned long orders;
+	int order;
+
+	/*
+	 * Default to setting PMD-sized THP to follow the global setting and
+	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
+	 * constant so we have to do this here.
+	 */
+	huge_anon_orders_global = BIT(PMD_ORDER);

 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
@@ -434,8 +626,24 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 		goto remove_hp_group;
 	}

+	orders = THP_ORDERS_ALL_ANON;
+	order = first_order(orders);
+	while (orders) {
+		thpsize = thpsize_create(order, *hugepage_kobj);
+		if (IS_ERR(thpsize)) {
+			pr_err("failed to create thpsize for order %d\n", order);
+			err = PTR_ERR(thpsize);
+			goto remove_all;
+		}
+		list_add(&thpsize->node, &thpsize_list);
+		order = next_order(&orders, order);
+	}
+
 	return 0;

+remove_all:
+	hugepage_exit_sysfs(*hugepage_kobj);
+	return err;
 remove_hp_group:
 	sysfs_remove_group(*hugepage_kobj, &hugepage_attr_group);
 delete_obj:
@@ -445,6 +653,13 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)

 static void __init hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 {
+	struct thpsize *thpsize, *tmp;
+
+	list_for_each_entry_safe(thpsize, tmp, &thpsize_list, node) {
+		list_del(&thpsize->node);
+		kobject_put(&thpsize->kobj);
+	}
+
 	sysfs_remove_group(hugepage_kobj, &khugepaged_attr_group);
 	sysfs_remove_group(hugepage_kobj, &hugepage_attr_group);
 	kobject_put(hugepage_kobj);
@@ -811,7 +1026,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	struct folio *folio;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;

-	if (!transhuge_vma_suitable(vma, haddr))
+	if (!transhuge_vma_suitable(vma, haddr, BIT(PMD_ORDER)))
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 064654717843..c3a874c0d601 100644
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
@@ -922,10 +923,10 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
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
@@ -1503,7 +1504,8 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
 	 * analogously elide sysfs THP settings here.
 	 */
-	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false,
+				BIT(PMD_ORDER)))
 		return SCAN_VMA_CHECK;

 	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
@@ -2368,7 +2370,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!hugepage_vma_check(vma, vma->vm_flags, false, false, true)) {
+		if (!hugepage_vma_check(vma, vma->vm_flags, false, false, true,
+					BIT(PMD_ORDER))) {
 skip:
 			progress++;
 			continue;
@@ -2705,7 +2708,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,

 	*prev = vma;

-	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
+	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false,
+				BIT(PMD_ORDER)))
 		return -EINVAL;

 	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
diff --git a/mm/memory.c b/mm/memory.c
index c32954e16b28..9d5e61d6d859 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4319,7 +4319,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	pmd_t entry;
 	vm_fault_t ret = VM_FAULT_FALLBACK;

-	if (!transhuge_vma_suitable(vma, haddr))
+	if (!transhuge_vma_suitable(vma, haddr, BIT(PMD_ORDER)))
 		return ret;

 	page = compound_head(page);
@@ -5117,7 +5117,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return VM_FAULT_OOM;
 retry_pud:
 	if (pud_none(*vmf.pud) &&
-	    hugepage_vma_check(vma, vm_flags, false, true, true)) {
+	    hugepage_vma_check(vma, vm_flags, false, true, true, BIT(PUD_ORDER))) {
 		ret = create_huge_pud(&vmf);
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
@@ -5151,7 +5151,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
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

