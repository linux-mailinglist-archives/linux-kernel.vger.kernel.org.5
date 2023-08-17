Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1094C77F1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbjHQIJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348755AbjHQIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:09:08 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B6C8210D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:09:04 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c9-64ddd5986068
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        david@redhat.com, peterz@infradead.org, luto@kernel.org,
        dave.hansen@linux.intel.com
Subject: [RFC v2 2/6] mm: Defer TLB flush by keeping both src and dst folios at migration
Date:   Thu, 17 Aug 2023 17:05:55 +0900
Message-Id: <20230817080559.43200-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817080559.43200-1-byungchul@sk.com>
References: <20230817080559.43200-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe6Mq3dTDG4v0rWYs34Nm8WLDe2M
        Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsru96yGhxvPcAk8XvH0DZOVOsLE7O
        msziwOuxYFOpx+YVWh6L97xk8ti0qpPNY9OnSeweJ2b8ZvHY+dDSY97JQI/3+66yeWz9Zefx
        eZOcx7v5b9kCeKK4bFJSczLLUov07RK4MvYefM5c8Ps0Y0XHozdMDYyXFzF2MXJwSAiYSHw4
        HNvFyAlmTn6/ih3EZhNQl7hx4ycziC0iYCZxsPUPUJyLg1lgGZPE3QPnWEESwgKREt+37gab
        wyKgKjFhaTZImFfAVOLek35GiJnyEqs3HGAGKeEEmrP5rypIWAio5MPedawgIyUELrNJPPx5
        ggmiXlLi4IobLBMYeRcwMqxiFMrMK8tNzMwx0cuozMus0EvOz93ECAziZbV/oncwfroQfIhR
        gINRiYfXYdedFCHWxLLiytxDjBIczEoivD28t1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xp9
        K08REkhPLEnNTk0tSC2CyTJxcEo1MK5Pyd8j3rLGu7CAuffPMU5vx3YLg00bV5/8pmwRJfP8
        w8fN4qzxk3R26dz81pbR7LVN+PdrHmafu6vExEzunGNxZt97YbqBb87JzYcLzi3WneN779vr
        J5tmnrnInXo09Olfvdri1h/vAw0uZa60PR0p9GlaX41z1g5DQZ2XHJks8vNmWG7JbFNiKc5I
        NNRiLipOBAAvFlKpXgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsXC5WfdrDvj6t0Ug1kXFS3mrF/DZvFiQzuj
        xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlc3/WQ0eJ47wEmi98/gLJz
        plhZnJw1mcWBz2PBplKPzSu0PBbvecnksWlVJ5vHpk+T2D1OzPjN4rHzoaXHvJOBHu/3XWXz
        WPziA5PH1l92Hp83yXm8m/+WLYA3issmJTUnsyy1SN8ugStj78HnzAW/TzNWdDx6w9TAeHkR
        YxcjJ4eEgInE5Per2EFsNgF1iRs3fjKD2CICZhIHW/8Axbk4mAWWMUncPXCOFSQhLBAp8X3r
        bqBmDg4WAVWJCUuzQcK8AqYS9570Q82Ul1i94QAzSAkn0JzNf1VBwkJAJR/2rmOdwMi1gJFh
        FaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmBQLqv9M3EH45fL7ocYBTgYlXh4HXbdSRFiTSwr
        rsw9xCjBwawkwtvDeytFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoR
        TJaJg1OqgXF3ppPa9b2y+232FbS3Ox27O+cg/+YvQQvL4+MVfpzadX9+91Kr50ZM8+8fXd86
        b+MV9imyohxR//weH2p1DdeNi+FZdVqo64f2iQuzPtjd09Y0FI2b9XO1qXps06l5Xuyx0aVv
        eXgPp83a8vDMrMAH7T0TimQX7DDYVxhZ8uGRaVJdyZPaiq1KLMUZiYZazEXFiQDkjtyyRgIA
        AA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
We always face the migration overhead at either promotion or demotion,
while working with tiered memory e.g. CXL memory and found out TLB
shootdown is a quite big one that is needed to get rid of if possible.

Fortunately, TLB flush can be defered or even skipped if both source and
destination of folios during migration are kept until all TLB flushes
required will have been done, of course, only if the target PTE entries
have read only permission, more precisely speaking, don't have write
permission. Otherwise, no doubt the folio might get messed up.

To achieve that:

   1. For the folios that map only to non-writable TLB entries, prevent
      TLB flush at migration by keeping both source and destination
      folios, which will be handled later at a better time.

   2. When any non-writable TLB entry changes to writable e.g. through
      fault handler, give up CONFIG_MIGRC mechanism so as to perform
      TLB flush required right away.

The measurement result:

   Architecture - x86_64
   QEMU - kvm enabled, host cpu, 2nodes {(4cpus, 2GB), (cpuless, 6GB)}
   Linux Kernel - v6.4, numa balancing tiering on, demotion enabled
   Benchmark - XSBench with no parameter changed

   run 'perf stat' using events:
      1) itlb.itlb_flush
      2) tlb_flush.dtlb_thread
      3) tlb_flush.stlb_any

   run 'cat /proc/vmstat' and pick up:
      1) pgdemote_kswapd
      2) numa_pages_migrated
      3) pgmigrate_success
      4) nr_tlb_remote_flush
      5) nr_tlb_remote_flush_received
      6) nr_tlb_local_flush_all
      7) nr_tlb_local_flush_one

   BEFORE - mainline v6.4
   ------------------------------------------
   $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench

   Performance counter stats for './XSBench':

      426856       itlb.itlb_flush
      6900414      tlb_flush.dtlb_thread
      7303137      tlb_flush.stlb_any

   33.500486566 seconds time elapsed
   92.852128000 seconds user
   10.526718000 seconds sys

   $ cat /proc/vmstat

   ...
   pgdemote_kswapd 1052596
   numa_pages_migrated 1052359
   pgmigrate_success 2161846
   nr_tlb_remote_flush 72370
   nr_tlb_remote_flush_received 213711
   nr_tlb_local_flush_all 3385
   nr_tlb_local_flush_one 198679
   ...

   AFTER - mainline v6.4 + CONFIG_MIGRC
   ------------------------------------------
   $ perf stat -e itlb.itlb_flush,tlb_flush.dtlb_thread,tlb_flush.stlb_any ./XSBench

   Performance counter stats for './XSBench':

      179537       itlb.itlb_flush
      6131135      tlb_flush.dtlb_thread
      6920979      tlb_flush.stlb_any

   30.396700625 seconds time elapsed
   80.331252000 seconds user
   10.303761000 seconds sys

   $ cat /proc/vmstat

   ...
   pgdemote_kswapd 1044602
   numa_pages_migrated 1044202
   pgmigrate_success 2157808
   nr_tlb_remote_flush 30453
   nr_tlb_remote_flush_received 88840
   nr_tlb_local_flush_all 3039
   nr_tlb_local_flush_one 198875
   ...

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h |   1 +
 arch/x86/mm/tlb.c               |   5 +
 include/linux/mm.h              |  28 +++
 include/linux/mm_types.h        |  47 +++++
 include/linux/mmzone.h          |   3 +
 include/linux/sched.h           |   4 +
 init/Kconfig                    |  13 ++
 mm/internal.h                   |  10 ++
 mm/memory.c                     |  17 +-
 mm/migrate.c                    | 296 +++++++++++++++++++++++++++++++-
 mm/mm_init.c                    |   1 +
 mm/page_alloc.c                 |   3 +
 mm/rmap.c                       | 103 +++++++++++
 13 files changed, 526 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 63504cde364b..752d72ea209b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -279,6 +279,7 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 }
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
+extern void arch_tlbbatch_clean(struct arch_tlbflush_unmap_batch *batch);
 extern void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
 			       struct arch_tlbflush_unmap_batch *bsrc);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 69d145f1fff1..2dabf0f340fb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,6 +1265,11 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	put_cpu();
 }
 
+void arch_tlbbatch_clean(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
 void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
 			struct arch_tlbflush_unmap_batch *bsrc)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..1ceec7f3591e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3816,4 +3816,32 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+#ifdef CONFIG_MIGRC
+void migrc_init_page(struct page *p);
+bool migrc_pending(struct folio *f);
+void migrc_shrink(struct llist_head *h);
+void migrc_req_start(void);
+void migrc_req_end(void);
+bool migrc_req_processing(void);
+bool migrc_try_flush_free_folios(void);
+void migrc_try_flush_free_folios_dirty(void);
+struct migrc_req *fold_ubc_nowr_to_migrc(void);
+void free_migrc_req(struct migrc_req *req);
+
+extern atomic_t migrc_gen;
+extern struct llist_head migrc_reqs;
+extern struct llist_head migrc_reqs_dirty;
+#else
+static inline void migrc_init_page(struct page *p) {}
+static inline bool migrc_pending(struct folio *f) { return false; }
+static inline void migrc_shrink(struct llist_head *h) {}
+static inline void migrc_req_start(void) {}
+static inline void migrc_req_end(void) {}
+static inline bool migrc_req_processing(void) { return false; }
+static inline bool migrc_try_flush_free_folios(void) { return false; }
+static inline void migrc_try_flush_free_folios_dirty(void) {}
+static inline struct migrc_req *fold_ubc_nowr_to_migrc(void) { return NULL; }
+static inline void free_migrc_req(struct migrc_req *req) {}
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..56011670a6fe 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -228,6 +228,23 @@ struct page {
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
 	int _last_cpupid;
 #endif
+#ifdef CONFIG_MIGRC
+	/*
+	 * XXX: Need to get rid of the following additional fields.
+	 */
+
+	/*
+	 * for hanging onto a request(struct migrc_req), waiting for TLB
+	 * flushes to free up this page
+	 */
+	struct llist_node migrc_node;
+
+	/*
+	 * for keeping a state of this page e.g. whether pending for TLB
+	 * flushes, whether duplicated or whether in the initial state
+	 */
+	unsigned int migrc_state;
+#endif
 } _struct_page_alignment;
 
 /*
@@ -1255,4 +1272,34 @@ enum {
 	/* See also internal only FOLL flags in mm/internal.h */
 };
 
+#ifdef CONFIG_MIGRC
+struct migrc_req {
+	/*
+	 * pages hung onto this, pending for TLB flush
+	 */
+	struct llist_head pages;
+
+	/*
+	 * llist_node of the last page in 'pages'
+	 */
+	struct llist_node *last;
+
+	/*
+	 * for hanging onto the global llist, 'migrc_reqs'
+	 */
+	struct llist_node llnode;
+
+	/*
+	 * architecture specific batch data
+	 */
+	struct arch_tlbflush_unmap_batch arch;
+
+	/*
+	 * when this hung onto the global llist, 'migrc_reqs'
+	 */
+	int gen;
+};
+#else
+struct migrc_req {};
+#endif
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..6d645beaf7a6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1371,6 +1371,9 @@ typedef struct pglist_data {
 #ifdef CONFIG_MEMORY_FAILURE
 	struct memory_failure_stats mf_stats;
 #endif
+#ifdef CONFIG_MIGRC
+	atomic_t migrc_pending_nr;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2232b2cdfce8..d0a46089959d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1323,6 +1323,10 @@ struct task_struct {
 
 	struct tlbflush_unmap_batch	tlb_ubc;
 	struct tlbflush_unmap_batch	tlb_ubc_nowr;
+#ifdef CONFIG_MIGRC
+	struct migrc_req		*mreq;
+	struct migrc_req		*mreq_dirty;
+#endif
 
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..9f9d0f7e15d2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -907,6 +907,19 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config MIGRC
+	bool "Deferring TLB flush by keeping read copies on migration"
+	depends on ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	depends on NUMA_BALANCING
+	default n
+	help
+	  TLB flush is necessary when PTE changes by migration. However,
+	  TLB flush can be deferred if both copies of the src page and
+	  the dst page are kept until TLB flush if they are non-writable.
+	  System performance will be improved especially in case that
+	  promotion and demotion types of migrations are heavily
+	  happening.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/mm/internal.h b/mm/internal.h
index b90d516ad41f..a8e3168614d6 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -841,6 +841,8 @@ void try_to_unmap_flush(void);
 void try_to_unmap_flush_dirty(void);
 void flush_tlb_batched_pending(struct mm_struct *mm);
 void fold_ubc_nowr(void);
+int nr_flush_required(void);
+int nr_flush_required_nowr(void);
 #else
 static inline void try_to_unmap_flush(void)
 {
@@ -854,6 +856,14 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
 static inline void fold_ubc_nowr(void)
 {
 }
+static inline int nr_flush_required(void)
+{
+	return 0;
+}
+static inline int nr_flush_required_nowr(void)
+{
+	return 0;
+}
 #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
 
 extern const struct trace_print_flags pageflag_names[];
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..066b7d5b7217 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3345,6 +3345,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 
 	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
 
+	if (vmf->page)
+		folio = page_folio(vmf->page);
+
+	/*
+	 * This folio has its read copy to prevent inconsistency while
+	 * deferring TLB flushes. However, the problem might arise if
+	 * it's going to become writable.
+	 *
+	 * To prevent it, give up the deferring TLB flushes and perform
+	 * TLB flush right away.
+	 */
+	if (folio && migrc_pending(folio))
+		migrc_try_flush_free_folios();
+
 	/*
 	 * Shared mapping: we are guaranteed to have VM_WRITE and
 	 * FAULT_FLAG_WRITE set at this point.
@@ -3362,9 +3376,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		return wp_page_shared(vmf);
 	}
 
-	if (vmf->page)
-		folio = page_folio(vmf->page);
-
 	/*
 	 * Private mapping: create an exclusive anonymous page copy if reuse
 	 * is impossible. We might miss VM_WRITE for FOLL_FORCE handling.
diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a3127..f9446f5b312a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -58,6 +58,230 @@
 
 #include "internal.h"
 
+#ifdef CONFIG_MIGRC
+
+/*
+ * TODO: Yeah, it's a non-sense magic number. This simple value manages
+ * to work conservatively anyway. However, the value needs to be
+ * tuned and adjusted based on the internal condition of memory
+ * management subsystem later.
+ *
+ * Let's start with a simple value for now.
+ */
+static const int migrc_pending_max = 512; /* unit: page */
+
+atomic_t migrc_gen;
+LLIST_HEAD(migrc_reqs);
+LLIST_HEAD(migrc_reqs_dirty);
+
+enum {
+	MIGRC_STATE_NONE,
+	MIGRC_SRC_PENDING,
+	MIGRC_DST_PENDING,
+};
+
+static struct migrc_req *alloc_migrc_req(void)
+{
+	return kmalloc(sizeof(struct migrc_req), GFP_KERNEL);
+}
+
+void free_migrc_req(struct migrc_req *req)
+{
+	kfree(req);
+}
+
+static bool migrc_is_full(int nid)
+{
+	struct pglist_data *node = NODE_DATA(nid);
+
+	if (migrc_pending_max == -1)
+		return false;
+
+	return atomic_read(&node->migrc_pending_nr) >= migrc_pending_max;
+}
+
+void migrc_init_page(struct page *p)
+{
+	WRITE_ONCE(p->migrc_state, MIGRC_STATE_NONE);
+}
+
+/*
+ * The list should be isolated before.
+ */
+void migrc_shrink(struct llist_head *h)
+{
+	struct page *p, *p2;
+	struct llist_node *n;
+
+	n = llist_del_all(h);
+	llist_for_each_entry_safe(p, p2, n, migrc_node) {
+		if (p->migrc_state == MIGRC_SRC_PENDING) {
+			struct pglist_data *node;
+
+			node = NODE_DATA(page_to_nid(p));
+			atomic_dec(&node->migrc_pending_nr);
+		}
+
+		if (WARN_ON(!migrc_pending(page_folio(p))))
+			continue;
+
+		WRITE_ONCE(p->migrc_state, MIGRC_STATE_NONE);
+
+		/*
+		 * Ensure the folio is in the initial state once it has
+		 * been freed and then allocated.
+		 */
+		smp_wmb();
+
+		folio_put(page_folio(p));
+	}
+}
+
+static inline bool migrc_src_pending(struct folio *f)
+{
+	/*
+	 * For the case called from page fault handler, make sure the
+	 * order between seeing updated PTE and reading migrc_state.
+	 *
+	 * Or should be able to see the initial state if no one has
+	 * touched the state since allocation.
+	 */
+	smp_rmb();
+	return READ_ONCE(f->page.migrc_state) == MIGRC_SRC_PENDING;
+}
+
+static inline bool migrc_dst_pending(struct folio *f)
+{
+	/*
+	 * For the case called from page fault handler, make sure the
+	 * order between seeing updated PTE and reading migrc_state.
+	 *
+	 * Or should be able to see the initial state if no one has
+	 * touched the state since allocation.
+	 */
+	smp_rmb();
+	return READ_ONCE(f->page.migrc_state) == MIGRC_DST_PENDING;
+}
+
+bool migrc_pending(struct folio *f)
+{
+	return migrc_src_pending(f) || migrc_dst_pending(f);
+}
+
+static void migrc_expand_req(struct folio *fsrc, struct folio *fdst)
+{
+	struct migrc_req *req;
+	struct pglist_data *node;
+
+	req = fold_ubc_nowr_to_migrc();
+	if (!req)
+		return;
+
+	folio_get(fsrc);
+	WRITE_ONCE(fsrc->page.migrc_state, MIGRC_SRC_PENDING);
+	WRITE_ONCE(fdst->page.migrc_state, MIGRC_DST_PENDING);
+
+	/*
+	 * Keep the order between migrc_state update and PTE update.
+	 */
+	smp_wmb();
+
+	if (llist_add(&fsrc->page.migrc_node, &req->pages))
+		req->last = &fsrc->page.migrc_node;
+
+	node = NODE_DATA(folio_nid(fsrc));
+	atomic_inc(&node->migrc_pending_nr);
+
+	if (migrc_is_full(folio_nid(fsrc)))
+		migrc_try_flush_free_folios();
+}
+
+/*
+ * To start to gather pages pending for TLB flushes, try to allocate
+ * objects needed, initialize them and make them ready.
+ */
+void migrc_req_start(void)
+{
+	struct migrc_req *req;
+	struct migrc_req *req_dirty;
+
+	if (WARN_ON(current->mreq || current->mreq_dirty))
+		return;
+
+	req = alloc_migrc_req();
+	req_dirty = alloc_migrc_req();
+
+	if (!req || !req_dirty)
+		goto fail;
+
+	arch_tlbbatch_clean(&req->arch);
+	init_llist_head(&req->pages);
+	req->last = NULL;
+	current->mreq = req;
+
+	/*
+	 * Gather pages having a mapping, pte_dirty() == true, in a
+	 * separate request to handle try_to_unmap_flush_dirty().
+	 */
+	arch_tlbbatch_clean(&req_dirty->arch);
+	init_llist_head(&req_dirty->pages);
+	req_dirty->last = NULL;
+	current->mreq_dirty = req_dirty;
+	return;
+fail:
+	if (req_dirty)
+		free_migrc_req(req_dirty);
+	if (req)
+		free_migrc_req(req);
+}
+
+/*
+ * Hang the request with the collected pages onto the global llist,
+ * 'migrc_reqs', which will be referred when performing TLB flush via
+ * migrc_try_flush_free_folios().
+ */
+void migrc_req_end(void)
+{
+	struct migrc_req *req = current->mreq;
+	struct migrc_req *req_dirty = current->mreq_dirty;
+
+	WARN_ON((!req && req_dirty) || (req && !req_dirty));
+
+	if (!req || !req_dirty)
+		return;
+
+	if (llist_empty(&req->pages)) {
+		free_migrc_req(req);
+	} else {
+		req->gen = atomic_inc_return(&migrc_gen);
+		llist_add(&req->llnode, &migrc_reqs);
+	}
+	current->mreq = NULL;
+
+	/*
+	 * Gather pages having a mapping, pte_dirty() == true, in a
+	 * separate request to handle try_to_unmap_flush_dirty().
+	 */
+	if (llist_empty(&req_dirty->pages)) {
+		free_migrc_req(req_dirty);
+	} else {
+		req_dirty->gen = atomic_inc_return(&migrc_gen);
+		llist_add(&req_dirty->llnode, &migrc_reqs_dirty);
+	}
+	current->mreq_dirty = NULL;
+}
+
+bool migrc_req_processing(void)
+{
+	return current->mreq && current->mreq_dirty;
+}
+#else
+static inline bool migrc_src_pending(struct folio *f) { return false; }
+static inline bool migrc_dst_pending(struct folio *f) { return false; }
+static inline bool migrc_is_full(int nid) { return true; }
+static inline void migrc_expand_req(struct folio *fsrc, struct folio *fdst) {}
+#endif
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -383,6 +607,9 @@ static int folio_expected_refs(struct address_space *mapping,
 		struct folio *folio)
 {
 	int refs = 1;
+
+	refs += migrc_src_pending(folio) ? 1 : 0;
+
 	if (!mapping)
 		return refs;
 
@@ -1060,6 +1287,12 @@ static void migrate_folio_undo_src(struct folio *src,
 				   bool locked,
 				   struct list_head *ret)
 {
+	/*
+	 * TODO: There might be folios already pending for migrc.
+	 * However, there's no way to cancel those on failure for now.
+	 * Let's reflect the requirement when needed.
+	 */
+
 	if (page_was_mapped)
 		remove_migration_ptes(src, src, false);
 	/* Drop an anon_vma reference if we took one */
@@ -1627,10 +1860,17 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
+	bool migrc_cond1;
+	bool need_migrc_flush = false;
 
 	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
 			!list_empty(from) && !list_is_singular(from));
 
+	migrc_cond1 = (reason == MR_DEMOTION && current_is_kswapd()) ||
+		      (reason == MR_NUMA_MISPLACED);
+
+	if (migrc_cond1)
+		migrc_req_start();
 	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
 		retry = 0;
 		large_retry = 0;
@@ -1638,6 +1878,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
+			int nr_required;
+			bool migrc_cond2;
+			bool migrc;
+
 			/*
 			 * Large folio statistics is based on the source large
 			 * folio. Capture required information that might get
@@ -1671,8 +1915,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				continue;
 			}
 
+			nr_required = nr_flush_required();
 			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
 						 folio, &dst, mode, reason, ret_folios);
+			migrc_cond2 = nr_required == nr_flush_required() &&
+				      nr_flush_required_nowr() &&
+				      !migrc_is_full(folio_nid(folio));
+			migrc = migrc_cond1 && migrc_cond2;
+
+			/*
+			 * This folio already has been participating in
+			 * migrc mechanism previously.
+			 *
+			 * If it was the destination at the migration,
+			 * then TLB flush is needed to keep consistency
+			 * because the folio is about to move to
+			 * somewhere else again.
+			 *
+			 * If it was the source at the migration which
+			 * cannot happen because the folio was isolated
+			 * at that time so it couldn't play here, then
+			 * it should be warned.
+			 */
+			if (migrc_dst_pending(folio))
+				need_migrc_flush = true;
+			else if (migrc_src_pending(folio))
+				WARN_ON(1);
+
 			/*
 			 * The rules are:
 			 *	Success: folio will be freed
@@ -1722,9 +1991,11 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				nr_large_failed += large_retry;
 				stats->nr_thp_failed += thp_retry;
 				rc_saved = rc;
-				if (list_empty(&unmap_folios))
+				if (list_empty(&unmap_folios)) {
+					if (migrc_cond1)
+						migrc_req_end();
 					goto out;
-				else
+				} else
 					goto move;
 			case -EAGAIN:
 				if (is_large) {
@@ -1742,6 +2013,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 			case MIGRATEPAGE_UNMAP:
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
+
+				if (migrc)
+					/*
+					 * XXX: On migration failure,
+					 * extra TLB flush might happen.
+					 */
+					migrc_expand_req(folio, dst);
 				break;
 			default:
 				/*
@@ -1760,6 +2038,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 				stats->nr_failed_pages += nr_pages;
 				break;
 			}
+
+			/*
+			 * Setting up TLB batch information for this
+			 * folio is done. It's about to move on to the
+			 * next folio. Fold the remaining TLB batch
+			 * information if it exists.
+			 */
+			fold_ubc_nowr();
 		}
 	}
 	nr_failed += retry;
@@ -1767,9 +2053,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 	stats->nr_thp_failed += thp_retry;
 	stats->nr_failed_pages += nr_retry_pages;
 move:
+	if (migrc_cond1)
+		migrc_req_end();
+
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
+	if (need_migrc_flush)
+		migrc_try_flush_free_folios();
+
 	retry = 1;
 	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
 		retry = 0;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..87cbddc7d780 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -558,6 +558,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	migrc_init_page(page);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 47421bedc12b..c51cbdb45d86 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1730,6 +1730,9 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
+
+	for (i = 0; i != 1 << order; ++i)
+		migrc_init_page(page + i);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
diff --git a/mm/rmap.c b/mm/rmap.c
index d18460a48485..0652d25206ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -606,6 +606,97 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
 
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 
+#ifdef CONFIG_MIGRC
+static bool __migrc_try_flush_free_folios(struct llist_head *h)
+{
+	struct arch_tlbflush_unmap_batch arch;
+	struct llist_node *reqs;
+	struct migrc_req *req;
+	struct migrc_req *req2;
+	LLIST_HEAD(pages);
+
+	reqs = llist_del_all(h);
+	if (!reqs)
+		return false;
+
+	arch_tlbbatch_clean(&arch);
+
+	/*
+	 * TODO: Optimize the time complexity.
+	 */
+	llist_for_each_entry_safe(req, req2, reqs, llnode) {
+		struct llist_node *n;
+
+		arch_tlbbatch_fold(&arch, &req->arch);
+
+		n = llist_del_all(&req->pages);
+		llist_add_batch(n, req->last, &pages);
+		free_migrc_req(req);
+	}
+
+	arch_tlbbatch_flush(&arch);
+	migrc_shrink(&pages);
+	return true;
+}
+
+bool migrc_try_flush_free_folios(void)
+{
+	bool ret;
+
+	/*
+	 * If building up a request collecting pages is in progress,
+	 * the request needs to be finalized and hung onto the global
+	 * llist, 'migrc_reqs', so that it can be used in migrc's TLB
+	 * flush routine e.i. __migrc_try_flush_free_folios().
+	 */
+	if (migrc_req_processing()) {
+		migrc_req_end();
+		migrc_req_start();
+	}
+	ret = __migrc_try_flush_free_folios(&migrc_reqs);
+	ret = ret || __migrc_try_flush_free_folios(&migrc_reqs_dirty);
+
+	return ret;
+}
+
+void migrc_try_flush_free_folios_dirty(void)
+{
+	/*
+	 * If building up a request collecting pages is in progress,
+	 * the request needs to be finalized and hung onto the global
+	 * llist, 'migrc_reqs', so that it can be used in migrc's TLB
+	 * flush routine e.i. __migrc_try_flush_free_folios().
+	 */
+	if (migrc_req_processing()) {
+		migrc_req_end();
+		migrc_req_start();
+	}
+	__migrc_try_flush_free_folios(&migrc_reqs_dirty);
+}
+
+struct migrc_req *fold_ubc_nowr_to_migrc(void)
+{
+	struct tlbflush_unmap_batch *tlb_ubc_nowr = &current->tlb_ubc_nowr;
+	struct migrc_req *req;
+	bool dirty;
+
+	if (!tlb_ubc_nowr->nr_flush_required)
+		return NULL;
+
+	dirty = tlb_ubc_nowr->writable;
+	req = dirty ? current->mreq_dirty : current->mreq;
+	if (!req) {
+		fold_ubc_nowr();
+		return NULL;
+	}
+
+	arch_tlbbatch_fold(&req->arch, &tlb_ubc_nowr->arch);
+	tlb_ubc_nowr->nr_flush_required = 0;
+	tlb_ubc_nowr->writable = false;
+	return req;
+}
+#endif
+
 void fold_ubc_nowr(void)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
@@ -621,6 +712,16 @@ void fold_ubc_nowr(void)
 	tlb_ubc_nowr->writable = false;
 }
 
+int nr_flush_required(void)
+{
+	return current->tlb_ubc.nr_flush_required;
+}
+
+int nr_flush_required_nowr(void)
+{
+	return current->tlb_ubc_nowr.nr_flush_required;
+}
+
 /*
  * Flush TLB entries for recently unmapped pages from remote CPUs. It is
  * important if a PTE was dirty when it was unmapped that it's flushed
@@ -648,6 +749,8 @@ void try_to_unmap_flush_dirty(void)
 
 	if (tlb_ubc->writable || tlb_ubc_nowr->writable)
 		try_to_unmap_flush();
+
+	migrc_try_flush_free_folios_dirty();
 }
 
 /*
-- 
2.17.1

