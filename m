Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A59D7E62FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjKIE7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKIE7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:59:25 -0500
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9720626A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 20:59:22 -0800 (PST)
X-AuditID: a67dfc5b-d6dff70000001748-01-654c6726db7e
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Subject: [v4 2/3] mm: Defer TLB flush by keeping both src and dst folios at migration
Date:   Thu,  9 Nov 2023 13:59:07 +0900
Message-Id: <20231109045908.54996-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109045908.54996-1-byungchul@sk.com>
References: <20231109045908.54996-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnka5auk+qwb1tVhZz1q9hs/i84R+b
        xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHF910NGi+O9B5gs
        Nm+aymzx+wdQ3ZwpVhYnZ01mcRDw+N7ax+KxYFOpx+YVWh6L97xk8ti0qpPNY9OnSewe786d
        Y/c4MeM3i8fOh5Ye804Gerzfd5XNY+svO4/Pm+Q83s1/yxbAF8Vlk5Kak1mWWqRvl8CV8WDF
        JpaCqfMZK27s38rWwLimpouRg0NCwERi2twMGPPOa7MuRk4ONgF1iRs3fjKD2CICZhIHW/+w
        dzFycTALPGCSmPt2BSNIQlggVOL6tk2MIL0sAqoSK66lg4R5BUwl/vxoZwKxJQTkJVZvOAA2
        hxNozp+p28FsIaCaqZ/3M0LUfGeTuDNXHMKWlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
        Miv0kvNzNzECQ35Z7Z/oHYyfLgQfYhTgYFTi4b3x1ztViDWxrLgy9xCjBAezkgjvBROfVCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2M2e/+WOckF75K
        Epm3xXbvj933nwj5xCQq5cXt9jkXpjVxi6z5ldUi3KInJ/G4cC+8zs00y2und8CbszOdQk/z
        neY0mLJ91+QcXW9Dny7x9VLXFp3s2Ns2aTLno60+Sz9+P/xl9pLZnZ8mPa3y7K116L2xZraQ
        XWPAWeZDy4vn1tzyEn2w7+zrcCWW4oxEQy3mouJEAMKp2ah1AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrKuW7pNq0PRfzWLO+jVsFp83/GOz
        eLGhndHi6/pfzBZPP/WxWByee5LV4vKuOWwW99b8Z7U4v2stq8WOpfuYLC4dWMBkcX3XQ0aL
        470HmCw2b5rKbPH7B1DdnClWFidnTWZxEPT43trH4rFgU6nH5hVaHov3vGTy2LSqk81j06dJ
        7B7vzp1j9zgx4zeLx86Hlh7zTgZ6vN93lc1j8YsPTB5bf9l5fN4k5/Fu/lu2AP4oLpuU1JzM
        stQifbsErowHKzaxFEydz1hxY/9WtgbGNTVdjBwcEgImEndem3UxcnKwCahL3LjxkxnEFhEw
        kzjY+oe9i5GLg1ngAZPE3LcrGEESwgKhEte3bWIE6WURUJVYcS0dJMwrYCrx50c7E4gtISAv
        sXrDAbA5nEBz/kzdDmYLAdVM/byfcQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB
        Qbys9s/EHYxfLrsfYhTgYFTi4U2Y4p0qxJpYVlyZe4hRgoNZSYT3golPqhBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVAMj27bMxezJh5SMchQLt+vcM5Vq
        EZNeMqHgUKfHx7MX7X3W2Amdzt86a8bNkE/PAyKz551vtWfd9Pyd9PGtxVu+T2lrFV+krccm
        a75217m9WyZZHjM70rT7g/dL9ZQyKeVvokY27GemHzKQjG95+feKnukuh1nXNb+3FW3PWrBA
        olI/6UWC5TU9JZbijERDLeai4kQAuUzSv14CAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of MIGRC mechanism that stands for 'Migration Read Copy'.
We always face the migration overhead at either promotion or demotion,
while working with tiered memory e.g. CXL memory and found out TLB
shootdown is a quite big one that is needed to get rid of if possible.

Fortunately, TLB flush can be defered if both source and destination of
folios during migration are kept until all TLB flushes required will
have been done, of course, only if the target PTE entries have read-only
permission, more precisely speaking, don't have write permission.
Otherwise, no doubt the folio might get messed up.

To achieve that:

   1. For the folios that map only to non-writable TLB entries, prevent
      TLB flush at migration by keeping both source and destination
      folios, which will be handled later at a better time.

   2. When any non-writable TLB entry changes to writable e.g. through
      fault handler, give up migrc mechanism so as to perform TLB flush
      required right away.

The measurement result:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
   Linux Kernel - v6.6-rc5, numa balancing tiering on, demotion enabled
   Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)

   run 'perf stat' using events:
      1) itlb.itlb_flush
      2) tlb_flush.dtlb_thread
      3) tlb_flush.stlb_any
      4) dTLB-load-misses
      5) dTLB-store-misses
      6) iTLB-load-misses

   run 'cat /proc/vmstat' and pick:
      1) numa_pages_migrated
      2) pgmigrate_success
      3) nr_tlb_remote_flush
      4) nr_tlb_remote_flush_received
      5) nr_tlb_local_flush_all
      6) nr_tlb_local_flush_one

   BEFORE - mainline v6.6-rc5
   ------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 50000000

   Performance counter stats for 'system wide':

      20953405     itlb.itlb_flush
      114886593    tlb_flush.dtlb_thread
      88267015     tlb_flush.stlb_any
      115304095543 dTLB-load-misses
      163904743    dTLB-store-misses
      608486259	   iTLB-load-misses

   556.787113849 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 3378748
   pgmigrate_success 7720310
   nr_tlb_remote_flush 751464
   nr_tlb_remote_flush_received 10742115
   nr_tlb_local_flush_all 21899
   nr_tlb_local_flush_one 740157
   ...

   AFTER - mainline v6.6-rc5 + migrc
   ------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 50000000

   Performance counter stats for 'system wide':

      4353555      itlb.itlb_flush
      72482780     tlb_flush.dtlb_thread
      68226458     tlb_flush.stlb_any
      114331610808 dTLB-load-misses
      116084771    dTLB-store-misses
      377180518    iTLB-load-misses

   552.667718220 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 3339325
   pgmigrate_success 7642363
   nr_tlb_remote_flush 192913
   nr_tlb_remote_flush_received 2327426
   nr_tlb_local_flush_all 25759
   nr_tlb_local_flush_one 740454
   ...

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h       |  21 ++++
 include/linux/mmzone.h         |   9 ++
 include/linux/page-flags.h     |   4 +
 include/linux/sched.h          |   6 +
 include/trace/events/mmflags.h |   3 +-
 mm/internal.h                  |  57 +++++++++
 mm/memory.c                    |  11 ++
 mm/migrate.c                   | 215 +++++++++++++++++++++++++++++++++
 mm/page_alloc.c                |  17 ++-
 mm/rmap.c                      |  11 +-
 10 files changed, 349 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..202de9b09bd6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1372,4 +1372,25 @@ enum {
 	/* See also internal only FOLL flags in mm/internal.h */
 };
 
+struct migrc_req {
+	/*
+	 * folios pending for TLB flush
+	 */
+	struct list_head folios;
+
+	/*
+	 * for hanging to the associated numa node
+	 */
+	struct llist_node llnode;
+
+	/*
+	 * architecture specific data for batched TLB flush
+	 */
+	struct arch_tlbflush_unmap_batch arch;
+
+	/*
+	 * associated numa node
+	 */
+	int nid;
+};
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..b79ac8053c6a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -980,6 +980,11 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
+
+	/*
+	 * the number of folios pending for TLB flush in the zone
+	 */
+	atomic_t		migrc_pending_nr;
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
@@ -1398,6 +1403,10 @@ typedef struct pglist_data {
 #ifdef CONFIG_MEMORY_FAILURE
 	struct memory_failure_stats mf_stats;
 #endif
+	/*
+	 * migrc requests including folios pending for TLB flush
+	 */
+	struct llist_head migrc_reqs;
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5c02720c53a5..ec7c178bfb49 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -136,6 +136,7 @@ enum pageflags {
 	PG_arch_2,
 	PG_arch_3,
 #endif
+	PG_migrc,		/* Page is under migrc's control */
 	__NR_PAGEFLAGS,
 
 	PG_readahead = PG_reclaim,
@@ -589,6 +590,9 @@ TESTCLEARFLAG(Young, young, PF_ANY)
 PAGEFLAG(Idle, idle, PF_ANY)
 #endif
 
+TESTCLEARFLAG(Migrc, migrc, PF_ANY)
+__PAGEFLAG(Migrc, migrc, PF_ANY)
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8a31527d9ed8..a2c16d21e365 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1326,6 +1326,12 @@ struct task_struct {
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
+	/*
+	 * if all the mappings of a folio during unmap are RO so that
+	 * migrc can work on it
+	 */
+	bool				can_migrc;
+
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 1478b9dd05fa..dafe302444d9 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -118,7 +118,8 @@
 	DEF_PAGEFLAG_NAME(mappedtodisk),				\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(migrc)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
diff --git a/mm/internal.h b/mm/internal.h
index 9764b240e259..a2b6f0321729 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1158,4 +1158,61 @@ struct vma_prepare {
 	struct vm_area_struct *remove;
 	struct vm_area_struct *remove2;
 };
+
+/*
+ * Initialize the page when allocated from buddy allocator.
+ */
+static inline void migrc_init_page(struct page *p)
+{
+	__ClearPageMigrc(p);
+}
+
+/*
+ * Check if the folio is pending for TLB flush and then clear the flag.
+ */
+static inline bool migrc_unpend_if_pending(struct folio *f)
+{
+	return folio_test_clear_migrc(f);
+}
+
+/*
+ * Reset the indicator indicating there are no writable mappings at the
+ * beginning of every rmap traverse for unmap. Migrc can work only when
+ * all the mappings are RO.
+ */
+static inline void can_migrc_init(void)
+{
+	current->can_migrc = true;
+}
+
+/*
+ * Mark the folio is not applicable to migrc once it found a writble or
+ * dirty pte during rmap traverse for unmap.
+ */
+static inline void can_migrc_fail(void)
+{
+	current->can_migrc = false;
+}
+
+/*
+ * Check if all the mappings are RO and RO mappings even exist.
+ */
+static inline bool can_migrc_test(void)
+{
+	return current->can_migrc && current->tlb_ubc_ro.flush_required;
+}
+
+/*
+ * Return the number of folios pending TLB flush that have yet to get
+ * freed in the zone.
+ */
+static inline int migrc_pending_nr_in_zone(struct zone *z)
+{
+	return atomic_read(&z->migrc_pending_nr);
+}
+
+/*
+ * Perform TLB flush needed and free the folios in the node.
+ */
+bool migrc_flush_free_folios(nodemask_t *nodes);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 6c264d2f969c..5287ea1639cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3359,6 +3359,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vmf->page)
 		folio = page_folio(vmf->page);
 
+	/*
+	 * This folio has its read copy to prevent inconsistency while
+	 * deferring TLB flushes. However, the problem might arise if
+	 * it's going to become writable.
+	 *
+	 * To prevent it, give up the deferring TLB flushes and perform
+	 * TLB flush right away.
+	 */
+	if (folio && migrc_unpend_if_pending(folio))
+		migrc_flush_free_folios(NULL);
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
diff --git a/mm/migrate.c b/mm/migrate.c
index 2053b54556ca..9ab7794b0390 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,162 @@
 
 #include "internal.h"
 
+/*
+ * Marks the folios as pending for TLB flush.
+ */
+static void migrc_mark_pending(struct folio *fsrc, struct folio *fdst)
+{
+	folio_get(fsrc);
+	__folio_set_migrc(fsrc);
+	__folio_set_migrc(fdst);
+}
+
+static bool migrc_under_processing(struct folio *fsrc, struct folio *fdst)
+{
+	/*
+	 * case1. folio_test_migrc(fsrc) && !folio_test_migrc(fdst):
+	 *
+	 *	fsrc was already under migrc's control even before the
+	 *	current migration. Migrc doesn't work with it this time.
+	 *
+	 * case2. !folio_test_migrc(fsrc) && !folio_test_migrc(fdst):
+	 *
+	 *	This is the normal case that is not migrc's interest.
+	 *
+	 * case3. folio_test_migrc(fsrc) && folio_test_migrc(fdst):
+	 *
+	 *	Only the case that migrc works on.
+	 */
+	return folio_test_migrc(fsrc) && folio_test_migrc(fdst);
+}
+
+static void migrc_undo_folios(struct folio *fsrc, struct folio *fdst)
+{
+	/*
+	 * TLB flushes needed are already done at this moment so the
+	 * flag doesn't have to be kept.
+	 */
+	__folio_clear_migrc(fsrc);
+	__folio_clear_migrc(fdst);
+	folio_put(fsrc);
+}
+
+static void migrc_expand_req(struct folio *fsrc, struct folio *fdst,
+			     struct migrc_req *req)
+{
+	if (req->nid == -1)
+		req->nid = folio_nid(fsrc);
+
+	/*
+	 * All the nids in a req should be the same.
+	 */
+	WARN_ON(req->nid != folio_nid(fsrc));
+
+	list_add(&fsrc->lru, &req->folios);
+	atomic_inc(&folio_zone(fsrc)->migrc_pending_nr);
+}
+
+/*
+ * Prepares for gathering folios pending for TLB flushes, try to
+ * allocate objects needed, initialize them and make them ready.
+ */
+static struct migrc_req *migrc_req_start(void)
+{
+	struct migrc_req *req;
+
+	req = kmalloc(sizeof(struct migrc_req), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	arch_tlbbatch_clear(&req->arch);
+	INIT_LIST_HEAD(&req->folios);
+	req->nid = -1;
+
+	return req;
+}
+
+/*
+ * Hang the request with the collected folios to the corresponding node.
+ */
+static void migrc_req_end(struct migrc_req *req)
+{
+	if (!req)
+		return;
+
+	if (list_empty(&req->folios)) {
+		kfree(req);
+		return;
+	}
+
+	llist_add(&req->llnode, &NODE_DATA(req->nid)->migrc_reqs);
+}
+
+/*
+ * Gather folios and architecture specific data to handle.
+ */
+static void migrc_gather(struct list_head *folios,
+			 struct arch_tlbflush_unmap_batch *arch,
+			 struct llist_head *reqs)
+{
+	struct llist_node *nodes;
+	struct migrc_req *req;
+	struct migrc_req *req2;
+
+	nodes = llist_del_all(reqs);
+	if (!nodes)
+		return;
+
+	llist_for_each_entry_safe(req, req2, nodes, llnode) {
+		arch_tlbbatch_fold(arch, &req->arch);
+		list_splice(&req->folios, folios);
+		kfree(req);
+	}
+}
+
+bool migrc_flush_free_folios(nodemask_t *nodes)
+{
+	struct folio *f, *f2;
+	int nid;
+	struct arch_tlbflush_unmap_batch arch;
+	LIST_HEAD(folios);
+
+	if (!nodes)
+		nodes = &node_possible_map;
+	arch_tlbbatch_clear(&arch);
+
+	for_each_node_mask(nid, *nodes)
+		migrc_gather(&folios, &arch, &NODE_DATA(nid)->migrc_reqs);
+
+	if (list_empty(&folios))
+		return false;
+
+	arch_tlbbatch_flush(&arch);
+	list_for_each_entry_safe(f, f2, &folios, lru) {
+		atomic_dec(&folio_zone(f)->migrc_pending_nr);
+		folio_put(f);
+	}
+	return true;
+}
+
+static void fold_ubc_ro_to_migrc(struct migrc_req *req)
+{
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+
+	if (!tlb_ubc_ro->flush_required)
+		return;
+
+	/*
+	 * Fold tlb_ubc_ro's data to the request.
+	 */
+	arch_tlbbatch_fold(&req->arch, &tlb_ubc_ro->arch);
+
+	/*
+	 * Reset tlb_ubc_ro's data.
+	 */
+	arch_tlbbatch_clear(&tlb_ubc_ro->arch);
+	tlb_ubc_ro->flush_required = false;
+}
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -379,6 +535,7 @@ static int folio_expected_refs(struct address_space *mapping,
 		struct folio *folio)
 {
 	int refs = 1;
+
 	if (!mapping)
 		return refs;
 
@@ -406,6 +563,12 @@ int folio_migrate_mapping(struct address_space *mapping,
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
 
+	/*
+	 * Migrc mechanism increased the reference count.
+	 */
+	if (migrc_under_processing(folio, newfolio))
+		expected_count++;
+
 	if (!mapping) {
 		/* Anonymous page without mapping */
 		if (folio_ref_count(folio) != expected_count)
@@ -1620,16 +1783,25 @@ static int migrate_pages_batch(struct list_head *from,
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	struct migrc_req *mreq = NULL;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
+	/*
+	 * Apply migrc only to numa migration for now.
+	 */
+	if (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED)
+		mreq = migrc_req_start();
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
+			bool can_migrc;
+
 			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
@@ -1657,9 +1829,21 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			can_migrc_init();
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
 					ret_folios);
+			/*
+			 * can_migrc is true only if:
+			 *
+			 *    1. struct migrc_req has been allocated &&
+			 *    2. There's no writable mapping at all &&
+			 *    3. There's read-only mapping found &&
+			 *    4. Not under migrc's control already
+			 */
+			can_migrc = mreq && can_migrc_test() &&
+				    !folio_test_migrc(folio);
+
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1720,6 +1904,19 @@ static int migrate_pages_batch(struct list_head *from,
 			case MIGRATEPAGE_UNMAP:
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
+
+				if (can_migrc) {
+					/*
+					 * To use ->lru exclusively, just
+					 * mark the page flag for now.
+					 *
+					 * The folio will be queued to
+					 * the current migrc request on
+					 * move success below.
+					 */
+					migrc_mark_pending(folio, dst);
+					fold_ubc_ro_to_migrc(mreq);
+				}
 				break;
 			default:
 				/*
@@ -1733,6 +1930,11 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
+			/*
+			 * Done with the current folio. Fold the ro
+			 * batch data gathered, to the normal batch.
+			 */
+			fold_ubc_ro();
 		}
 	}
 	nr_failed += retry;
@@ -1774,6 +1976,14 @@ static int migrate_pages_batch(struct list_head *from,
 			case MIGRATEPAGE_SUCCESS:
 				stats->nr_succeeded += nr_pages;
 				stats->nr_thp_succeeded += is_thp;
+
+				/*
+				 * Now that it's safe to use ->lru,
+				 * queue the folio to the current migrc
+				 * request.
+				 */
+				if (migrc_under_processing(folio, dst))
+					migrc_expand_req(folio, dst, mreq);
 				break;
 			default:
 				nr_failed++;
@@ -1791,6 +2001,8 @@ static int migrate_pages_batch(struct list_head *from,
 
 	rc = rc_saved ? : nr_failed;
 out:
+	migrc_req_end(mreq);
+
 	/* Cleanup remaining folios */
 	dst = list_first_entry(&dst_folios, struct folio, lru);
 	dst2 = list_next_entry(dst, lru);
@@ -1798,6 +2010,9 @@ static int migrate_pages_batch(struct list_head *from,
 		int page_was_mapped = 0;
 		struct anon_vma *anon_vma = NULL;
 
+		if (migrc_under_processing(folio, dst))
+			migrc_undo_folios(folio, dst);
+
 		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
 		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
 				       true, ret_folios);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f376302..914e93ab598e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1535,6 +1535,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+
+	for (i = 0; i != 1 << order; ++i)
+		migrc_init_page(page + i);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
@@ -2839,6 +2842,8 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	long min = mark;
 	int o;
 
+	free_pages += migrc_pending_nr_in_zone(z);
+
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
@@ -2933,7 +2938,7 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 		long usable_free;
 		long reserved;
 
-		usable_free = free_pages;
+		usable_free = free_pages + migrc_pending_nr_in_zone(z);
 		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
 
 		/* reserved may over estimate high-atomic reserves. */
@@ -3121,6 +3126,16 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
+			/*
+			 * Free the pending folios so that the remaining
+			 * code can use the updated vmstats and check
+			 * zone_watermark_fast() again.
+			 */
+			migrc_flush_free_folios(ac->nodemask);
+			if (zone_watermark_fast(zone, order, mark,
+			    ac->highest_zoneidx, alloc_flags, gfp_mask))
+				goto try_this_zone;
+
 			if (has_unaccepted_memory()) {
 				if (try_to_accept_memory(zone, order))
 					goto try_this_zone;
diff --git a/mm/rmap.c b/mm/rmap.c
index c787ae94b4c6..8786c14e08c9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -605,7 +605,6 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 }
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-
 void fold_ubc_ro(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
@@ -675,9 +674,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	if (pte_write(pteval) || writable)
+	if (pte_write(pteval) || writable) {
 		tlb_ubc = &current->tlb_ubc;
-	else
+
+		/*
+		 * migrc cannot work with the folio once it found a
+		 * writable or dirty mapping of it.
+		 */
+		can_migrc_fail();
+	} else
 		tlb_ubc = &current->tlb_ubc_ro;
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
-- 
2.17.1

