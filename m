Return-Path: <linux-kernel+bounces-25720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087182D4F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C144281A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FABEAFD;
	Mon, 15 Jan 2024 08:20:18 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEEEBE6C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-8f-65a4eab48500
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v6 6/7] mm: Defer TLB flush by keeping both src and dst folios at migration
Date: Mon, 15 Jan 2024 17:19:52 +0900
Message-Id: <20240115081953.2521-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC9ZZnoe6WV0tSDdZ2qFnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK2PV37qCpZsYK77MbWZrYNzay9jFyMkhIWAiceBqOyuM/WLub7A4m4C6xI0b
	P5lBbBEBM4mDrX/Yuxi5OJgFPjJJrP7ewQKSEBaIlnjV/YMNxGYRUJXYsPkAE4jNCzTo4KJb
	UAvkJVZvOAA2iFPAVOLdx+PsILYQUE3L3XWsIEMlBJrZJdZtaGWCaJCUOLjiBssERt4FjAyr
	GIUy88pyEzNzTPQyKvMyK/SS83M3MQJjYlntn+gdjJ8uBB9iFOBgVOLh/fF3caoQa2JZcWXu
	IUYJDmYlEd7qO0tShXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgsky
	cXBKNTBq6NU4qgfIvb1SuWZyxPaTsVME9z5mUyheKdG5/tHOUwu22QszvrMRmbLaVnRr8bJ1
	m7Z9j/XYG7m6Q0Vy3xx5u86716wye280ty6yj84tnJS9tK+ydPu7lW82b4jf7O0tkcjYsWzG
	+efSe+R3PNi39bPC78diK4+ePz17m6kis51C+xezEtEaJZbijERDLeai4kQA8qGgAoUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUg4654hZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyVv2tK1i6ibHiy9xmtgbGrb2MXYycHBICJhIv5v4Gs9kE
	1CVu3PjJDGKLCJhJHGz9w97FyMXBLPCRSWL19w4WkISwQLTEq+4fbCA2i4CqxIbNB5hAbF6g
	QQcX3YIaKi+xesMBsEGcAqYS7z4eZwexhYBqWu6uY53AyLWAkWEVo0hmXlluYmaOqV5xdkZl
	XmaFXnJ+7iZGYIAvq/0zcQfjl8vuhxgFOBiVeHh//F2cKsSaWFZcmXuIUYKDWUmEt/rOklQh
	3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxjV3Q5K8XB4c
	Uaif3jGr+bF7bvqxurr7tnFyXn8nncycNvf9LoHGW8KXFp9NjFqfbrGMu2O7QdGLpL9dbv2/
	eGIrnPaG7/wjPH19pf5Uq3NxPxv/vGNh+76UeRnzh3lBN6MmxLtk8y/JO+VknvG/RfZOx5Te
	qU46CbFCduf8FEo/FLgEBaZfVGIpzkg01GIuKk4EADoJu81sAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

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

The following evaluation using XSBench shows the improvement like:

   1. itlb flush was reduced by 93.9%.
   2. dtlb thread was reduced by 43.5%.
   3. stlb flush was reduced by 24.9%.
   4. dtlb store misses was reduced by 34.2%.
   5. itlb load misses was reduced by 45.5%.
   6. The runtime was reduced by 3.5%.

---

The measurement result:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu
   Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
   Linux Kernel - v6.7, numa balancing tiering on, demotion enabled
   Benchmark - XSBench -p 100000000 (-p option makes the runtime longer)

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

   BEFORE - mainline v6.7
   ------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 100000000

   Performance counter stats for 'system wide':

      85647229          itlb.itlb_flush
      480981504         tlb_flush.dtlb_thread
      323937200         tlb_flush.stlb_any
      238381632579      dTLB-load-misses
      601514255         dTLB-store-misses
      2974157461        iTLB-load-misses

   2252.883892112 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 12790664
   pgmigrate_success 26835314
   nr_tlb_remote_flush 3031412
   nr_tlb_remote_flush_received 45234862
   nr_tlb_local_flush_all 216584
   nr_tlb_local_flush_one 740940
   ...

   AFTER - mainline v6.7 + migrc
   ------------------------------------------
   $ perf stat -a \
	   -e itlb.itlb_flush \
	   -e tlb_flush.dtlb_thread \
	   -e tlb_flush.stlb_any \
	   -e dTLB-load-misses \
	   -e dTLB-store-misses \
	   -e iTLB-load-misses \
	   ./XSBench -p 100000000

   Performance counter stats for 'system wide':

      5240261           itlb.itlb_flush
      271581774         tlb_flush.dtlb_thread
      243149389         tlb_flush.stlb_any
      234502983364      dTLB-load-misses
      395673680         dTLB-store-misses
      1620215163        iTLB-load-misses

   2172.283436287 seconds time elapsed

   $ cat /proc/vmstat

   ...
   numa_pages_migrated 14897064
   pgmigrate_success 30825530
   nr_tlb_remote_flush 198290
   nr_tlb_remote_flush_received 2820156
   nr_tlb_local_flush_all 92048
   nr_tlb_local_flush_one 741401
   ...

Signed-off-by: Byungchul Park <byungchul@sk.com>

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/mm/tlb.c      |   4 +
 include/linux/mm.h     |   8 ++
 include/linux/mmzone.h |   7 ++
 include/linux/sched.h  |   8 ++
 mm/internal.h          |  49 ++++++++
 mm/memory.c            |   8 ++
 mm/migrate.c           | 271 +++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.c        |  11 +-
 mm/rmap.c              |  10 +-
 9 files changed, 364 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..9164fd7d5973 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1254,6 +1254,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 
 	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false,
 				  TLB_GENERATION_INVALID);
+
+	migrc_flush_start();
+
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
@@ -1268,6 +1271,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
+	migrc_flush_end(batch);
 	cpumask_clear(&batch->cpumask);
 
 	put_flush_tlb_info();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fc0581cce3a7..777b6904923c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2038,6 +2038,14 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 }
 #endif
 
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+extern void migrc_flush_start(void);
+extern void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch);
+#else
+static inline void migrc_flush_start(void) {}
+static inline void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch) {}
+#endif
+
 static inline void set_page_zone(struct page *page, enum zone_type zone)
 {
 	page->flags &= ~(ZONES_MASK << ZONES_PGSHIFT);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9db36e197712..492111cd1176 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1002,6 +1002,13 @@ struct zone {
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
 	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
+
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	/*
+	 * the number of folios pending for TLB flush in the zone
+	 */
+	atomic_t		migrc_pending_nr;
+#endif
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0317e7a65151..d8c285309a8f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1330,6 +1330,14 @@ struct task_struct {
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_ro;
 
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+	/*
+	 * whether all the mappings of a folio during unmap are read-only
+	 * so that migrc can work on the folio
+	 */
+	bool				can_migrc;
+#endif
+
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
diff --git a/mm/internal.h b/mm/internal.h
index 3be8fd5604e8..5b93e5abf953 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1284,4 +1284,53 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 }
 #endif /* CONFIG_SHRINKER_DEBUG */
 
+#if defined(CONFIG_MIGRATION) && defined(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH)
+/*
+ * Reset the indicator indicating there are no writable mappings at the
+ * beginning of every rmap traverse for unmap. Migrc can work only when
+ * all the mappings are read-only.
+ */
+static inline void can_migrc_init(void)
+{
+	current->can_migrc = true;
+}
+
+/*
+ * Mark the folio is not applicable to migrc, once it found a writble or
+ * dirty pte during rmap traverse for unmap.
+ */
+static inline void can_migrc_fail(void)
+{
+	current->can_migrc = false;
+}
+
+/*
+ * Check if all the mappings are read-only and read-only mappings even
+ * exist.
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
+ * Perform TLB flush needed and free the folios under migrc's control.
+ */
+bool migrc_flush_free_folios(void);
+#else /* CONFIG_MIGRATION && CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static inline void can_migrc_init(void) {}
+static inline void can_migrc_fail(void) {}
+static inline bool can_migrc_test(void) { return false; }
+static inline int migrc_pending_nr_in_zone(struct zone *z) { return 0; }
+static inline bool migrc_flush_free_folios(void) { return false; }
+#endif
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 6e0712d06cd4..e67de161da8b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3462,6 +3462,14 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	if (vmf->page)
 		folio = page_folio(vmf->page);
 
+	/*
+	 * The folio may or may not be one that is under migrc's control
+	 * and about to change its permission from read-only to writable.
+	 * Conservatively give up deferring TLB flush just in case.
+	 */
+	if (folio)
+		migrc_flush_free_folios();
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
diff --git a/mm/migrate.c b/mm/migrate.c
index bbe1ecef4956..da4d43ac2622 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,194 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+static struct tlbflush_unmap_batch migrc_ubc;
+static LIST_HEAD(migrc_folios);
+static DEFINE_SPINLOCK(migrc_lock);
+
+static void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	arch_tlbbatch_clear(&ubc->arch);
+	ubc->flush_required = false;
+	ubc->writable = false;
+}
+
+static void migrc_keep_folio(struct folio *f, struct list_head *h)
+{
+	list_move_tail(&f->lru, h);
+	folio_get(f);
+	atomic_inc(&folio_zone(f)->migrc_pending_nr);
+}
+
+static void migrc_undo_folio(struct folio *f)
+{
+	list_del(&f->lru);
+	folio_put(f);
+	atomic_dec(&folio_zone(f)->migrc_pending_nr);
+}
+
+static void migrc_release_folio(struct folio *f)
+{
+	folio_put_small_nopcp(f);
+	atomic_dec(&folio_zone(f)->migrc_pending_nr);
+}
+
+/*
+ * Need to synchronize between TLB flush and managing pending CPUs in
+ * migrc_ubc. Take a look at the following scenario:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	TLB flush
+ *				Unmap folios (needing TLB flush)
+ *				Add pending CPUs to migrc_ubc
+ *	Clear the CPUs from migrc_ubc
+ *
+ * The pending CPUs added in CPU1 should not be cleared from migrc_ubc
+ * in CPU0 because the TLB flush for migrc_ubc added in CPU1 has not
+ * been performed this turn. To avoid this, using 'migrc_flushing'
+ * variable, prevent adding pending CPUs to migrc_ubc and give up migrc
+ * mechanism if others are in the middle of TLB flush, like:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *	migrc_flushing++
+ *	TLB flush
+ *				Unmap folios (needing TLB flush)
+ *				If migrc_flushing == 0:
+ *				   Add pending CPUs to migrc_ubc
+ *				Else: <--- hit
+ *				   Give up migrc mechanism
+ *	Clear the CPUs from migrc_ubc
+ *	migrc_flush--
+ *
+ * Only the following case would be allowed for migrc mechanism to work:
+ *
+ *	CPU0			CPU1
+ *	----			----
+ *				Unmap folios (needing TLB flush)
+ *				If migrc_flushing == 0: <--- hit
+ *				   Add pending CPUs to migrc_ubc
+ *				Else:
+ *				   Give up migrc mechanism
+ *	migrc_flushing++
+ *	TLB flush
+ *	Clear the CPUs from migrc_ubc
+ *	migrc_flush--
+ */
+static int migrc_flushing;
+
+static bool migrc_add_pending_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	if (migrc_flushing) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+
+		/*
+		 * Give up migrc mechanism. Just let TLB flush needed
+		 * handled by try_to_unmap_flush() at the caller side.
+		 */
+		fold_ubc(tlb_ubc, ubc);
+		return false;
+	}
+	fold_ubc(&migrc_ubc, ubc);
+	spin_unlock_irqrestore(&migrc_lock, flags);
+	return true;
+}
+
+static bool migrc_add_pending_folios(struct list_head *folios)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	if (migrc_flushing) {
+		spin_unlock_irqrestore(&migrc_lock, flags);
+
+		/*
+		 * Give up migrc mechanism. The caller should perform
+		 * TLB flush needed using migrc_flush_free_folios() and
+		 * undo some on the folios e.g. restore folios'
+		 * reference count increased by migrc and more.
+		 */
+		return false;
+	}
+	list_splice(folios, &migrc_folios);
+	spin_unlock_irqrestore(&migrc_lock, flags);
+	return true;
+}
+
+void migrc_flush_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	migrc_flushing++;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+}
+
+void migrc_flush_end(struct arch_tlbflush_unmap_batch *arch)
+{
+	LIST_HEAD(folios);
+	struct folio *f, *f2;
+	unsigned long flags;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	if (!arch_tlbbatch_done(&migrc_ubc.arch, arch)) {
+		list_splice_init(&migrc_folios, &folios);
+		migrc_ubc.flush_required = false;
+		migrc_ubc.writable = false;
+	}
+	migrc_flushing--;
+	spin_unlock_irqrestore(&migrc_lock, flags);
+
+	list_for_each_entry_safe(f, f2, &folios, lru)
+		migrc_release_folio(f);
+}
+
+bool migrc_flush_free_folios(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	LIST_HEAD(folios);
+	struct folio *f, *f2;
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&migrc_lock, flags);
+	list_splice_init(&migrc_folios, &folios);
+	fold_ubc(tlb_ubc, &migrc_ubc);
+	spin_unlock_irqrestore(&migrc_lock, flags);
+
+	if (list_empty(&folios))
+		ret = false;
+
+	try_to_unmap_flush();
+	list_for_each_entry_safe(f, f2, &folios, lru)
+		migrc_release_folio(f);
+	return ret;
+}
+#else /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
+static void init_tlb_ubc(struct tlbflush_unmap_batch *ubc)
+{
+}
+static void migrc_keep_folio(struct folio *f, struct list_head *h)
+{
+}
+static void migrc_undo_folio(struct folio *f)
+{
+}
+static bool migrc_add_pending_ubc(struct tlbflush_unmap_batch *ubc)
+{
+	return false;
+}
+static bool migrc_add_pending_folios(struct list_head *folios)
+{
+	return false;
+}
+#endif
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -1274,7 +1462,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct folio *src, struct folio *dst,
 			      enum migrate_mode mode, enum migrate_reason reason,
-			      struct list_head *ret)
+			      struct list_head *ret, struct list_head *move_succ)
 {
 	int rc;
 	int old_page_state = 0;
@@ -1321,9 +1509,13 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 
 	/*
 	 * A folio that has been migrated has all references removed
-	 * and will be freed.
+	 * and will be freed, unless it's under migrc's control.
 	 */
-	list_del(&src->lru);
+	if (move_succ)
+		migrc_keep_folio(src, move_succ);
+	else
+		list_del(&src->lru);
+
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1618,7 +1810,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 		struct list_head *ret_folios,
 		struct migrate_pages_stats *stats,
 		int *retry, int *thp_retry, int *nr_failed,
-		int *nr_retry_pages)
+		int *nr_retry_pages, struct list_head *move_succ)
 {
 	struct folio *folio, *folio2, *dst, *dst2;
 	bool is_thp;
@@ -1635,7 +1827,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 
 		rc = migrate_folio_move(put_new_folio, private,
 				folio, dst, mode,
-				reason, ret_folios);
+				reason, ret_folios, move_succ);
 		/*
 		 * The rules are:
 		 *	Success: folio will be freed
@@ -1712,17 +1904,34 @@ static int migrate_pages_batch(struct list_head *from,
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
+	LIST_HEAD(unmap_folios_migrc);
+	LIST_HEAD(dst_folios_migrc);
+	LIST_HEAD(move_succ);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	struct tlbflush_unmap_batch pending_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
+	struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
+	bool do_migrc;
+	bool migrc_ubc_succ;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
+	/*
+	 * Apply migrc only to numa migration for now.
+	 */
+	init_tlb_ubc(&pending_ubc);
+	do_migrc = IS_ENABLED(CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) &&
+		   (reason == MR_DEMOTION || reason == MR_NUMA_MISPLACED);
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
+			bool can_migrc;
+
 			is_large = folio_test_large(folio);
 			is_thp = is_large && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
@@ -1752,9 +1961,12 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			can_migrc_init();
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
 					private, folio, &dst, mode, reason,
 					ret_folios);
+			can_migrc = do_migrc && can_migrc_test() && !is_large;
+
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1800,7 +2012,8 @@ static int migrate_pages_batch(struct list_head *from,
 				/* nr_failed isn't updated for not used */
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios) &&
+				    list_empty(&unmap_folios_migrc))
 					goto out;
 				else
 					goto move;
@@ -1814,8 +2027,19 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_succeeded += is_thp;
 				break;
 			case MIGRATEPAGE_UNMAP:
-				list_move_tail(&folio->lru, &unmap_folios);
-				list_add_tail(&dst->lru, &dst_folios);
+				if (can_migrc) {
+					list_move_tail(&folio->lru, &unmap_folios_migrc);
+					list_add_tail(&dst->lru, &dst_folios_migrc);
+
+					/*
+					 * Gather ro batch data to add
+					 * to migrc_ubc after unmap.
+					 */
+					fold_ubc(&pending_ubc, tlb_ubc_ro);
+				} else {
+					list_move_tail(&folio->lru, &unmap_folios);
+					list_add_tail(&dst->lru, &dst_folios);
+				}
 				break;
 			default:
 				/*
@@ -1829,12 +2053,19 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
+			/*
+			 * Done with the current folio. Fold the ro
+			 * batch data gathered, to the normal batch.
+			 */
+			fold_ubc(tlb_ubc, tlb_ubc_ro);
 		}
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	/* Should be before try_to_unmap_flush() */
+	migrc_ubc_succ = do_migrc && migrc_add_pending_ubc(&pending_ubc);
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
@@ -1848,7 +2079,27 @@ static int migrate_pages_batch(struct list_head *from,
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-				&nr_failed, &nr_retry_pages);
+				&nr_failed, &nr_retry_pages, NULL);
+		migrate_folios_move(&unmap_folios_migrc, &dst_folios_migrc,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages, migrc_ubc_succ ?
+				&move_succ : NULL);
+	}
+
+	/*
+	 * In case that migrc_add_pending_ubc() has been added
+	 * successfully but migrc_add_pending_folios() does not.
+	 */
+	if (migrc_ubc_succ && !migrc_add_pending_folios(&move_succ)) {
+		migrc_flush_free_folios();
+
+		/*
+		 * Undo src folios that have been successfully added to
+		 * move_succ.
+		 */
+		list_for_each_entry_safe(folio, folio2, &move_succ, lru)
+			migrc_undo_folio(folio);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1859,6 +2110,8 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Cleanup remaining folios */
 	migrate_folios_undo(&unmap_folios, &dst_folios,
 			put_new_folio, private, ret_folios);
+	migrate_folios_undo(&unmap_folios_migrc, &dst_folios_migrc,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 21b8c8cd1673..6ef0c22b1109 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2972,6 +2972,8 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 	long min = mark;
 	int o;
 
+	free_pages += migrc_pending_nr_in_zone(z);
+
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
@@ -3066,7 +3068,7 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 		long usable_free;
 		long reserved;
 
-		usable_free = free_pages;
+		usable_free = free_pages + migrc_pending_nr_in_zone(z);
 		reserved = __zone_watermark_unusable_free(z, 0, alloc_flags);
 
 		/* reserved may over estimate high-atomic reserves. */
@@ -3273,6 +3275,13 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
+			if (migrc_pending_nr_in_zone(zone) &&
+			    migrc_flush_free_folios() &&
+			    zone_watermark_fast(zone, order, mark,
+						ac->highest_zoneidx,
+						alloc_flags, gfp_mask))
+				goto try_this_zone;
+
 			if (has_unaccepted_memory()) {
 				if (try_to_accept_memory(zone, order))
 					goto try_this_zone;
diff --git a/mm/rmap.c b/mm/rmap.c
index da36f23ff7b0..79e1827dec89 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -676,9 +676,15 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	if (pte_write(pteval) || writable)
+	if (pte_write(pteval) || writable) {
 		tlb_ubc = &current->tlb_ubc;
-	else
+
+		/*
+		 * Migrc cannot work with the folio, once it found a
+		 * writable or dirty mapping on it.
+		 */
+		can_migrc_fail();
+	} else
 		tlb_ubc = &current->tlb_ubc_ro;
 
 	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
-- 
2.17.1


