Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632B7B319A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjI2Lov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjI2Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:44:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F06C61B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:44:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CDDC1063;
        Fri, 29 Sep 2023 04:45:20 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 103F93F59C;
        Fri, 29 Sep 2023 04:44:38 -0700 (PDT)
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
Subject: [PATCH v6 3/9] mm: thp: Account pte-mapped anonymous THP usage
Date:   Fri, 29 Sep 2023 12:44:14 +0100
Message-Id: <20230929114421.3761121-4-ryan.roberts@arm.com>
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

Add accounting for pte-mapped anonymous transparent hugepages at various
locations. This visibility will aid in debugging and tuning performance
for the "small order" thp extension that will be added in a subsequent
commit, where hugepages can be allocated which are large (greater than
order-0) but smaller than PMD_ORDER. This new accounting follows a
similar pattern to the existing NR_ANON_THPS, which measures pmd-mapped
anonymous transparent hugepages.

We account pte-mapped anonymous thp mappings per-page, where the page is
mapped at least once via PTE and the page belongs to a large folio. So
when a page belonging to a large folio is PTE-mapped for the first time,
then we add 1 to NR_ANON_THPS_PTEMAPPED. And when a page belonging to a
large folio is PTE-unmapped for the last time, then we remove 1 from
NR_ANON_THPS_PTEMAPPED.

/proc/meminfo:
  Introduce new "AnonHugePteMap" field, which reports the amount of
  memory (in KiB) mapped from large folios globally (similar to
  AnonHugePages field).

/proc/vmstat:
  Introduce new "nr_anon_thp_pte" field, which reports the amount of
  memory (in pages) mapped from large folios globally (similar to
  nr_anon_transparent_hugepages field).

/sys/devices/system/node/nodeX/meminfo
  Introduce new "AnonHugePteMap" field, which reports the amount of
  memory (in KiB) mapped from large folios per-node (similar to
  AnonHugePages field).

show_mem (panic logger):
  Introduce new "anon_thp_pte" field, which reports the amount of memory
  (in KiB) mapped from large folios per-node (similar to anon_thp
  field).

memory.stat (cgroup v1 and v2):
  Introduce new "anon_thp_pte" field, which reports the amount of memory
  (in bytes) mapped from large folios in the memcg (similar to rss_huge
  (v1) / anon_thp (v2) fields).

/proc/<pid>/smaps & /proc/<pid>/smaps_rollup:
  Introduce new "AnonHugePteMap" field, which reports the amount of
  memory (in KiB) mapped from large folios within the vma/process
  (similar to AnonHugePages field).

NOTE on charge migration: The new NR_ANON_THPS_PTEMAPPED charge is NOT
moved between cgroups, even when the (v1)
memory.move_charge_at_immigrate feature is enabled. That feature is
marked deprecated and the current code does not attempt to move the
NR_ANON_MAPPED charge for large PTE-mapped folios anyway (see comment in
mem_cgroup_move_charge_pte_range()). If this code was enhanced to allow
moving the NR_ANON_MAPPED charge for large PTE-mapped folios, we would
also need to add support for moving the new NR_ANON_THPS_PTEMAPPED
charge. This would likely get quite fiddly. Given the deprecation of
memory.move_charge_at_immigrate, I assume it is not valuable to
implement.

NOTE on naming: Given the new small order anonymous thp feature will be
exposed to user space as an extension to thp, I've opted to call the new
counters after thp also (as aposed to "large"/"large folio"/etc.), so
"huge" no longer strictly means PMD - one could argue hugetlb already
breaks this rule anyway. I also did not want to risk breaking back
compat by renaming/redefining the existing counters (which would have
resulted in more consistent and clearer names). So the existing
NR_ANON_THPS counters remain and continue to only refer to PMD-mapped
THPs. And I've added new counters, which only refer to PTE-mapped THPs.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/ABI/testing/procfs-smaps_rollup  |  1 +
 Documentation/admin-guide/cgroup-v1/memory.rst |  5 ++++-
 Documentation/admin-guide/cgroup-v2.rst        |  6 +++++-
 Documentation/admin-guide/mm/transhuge.rst     | 11 +++++++----
 Documentation/filesystems/proc.rst             | 14 ++++++++++++--
 drivers/base/node.c                            |  2 ++
 fs/proc/meminfo.c                              |  2 ++
 fs/proc/task_mmu.c                             |  4 ++++
 include/linux/mmzone.h                         |  1 +
 mm/memcontrol.c                                |  8 ++++++++
 mm/rmap.c                                      | 11 +++++++++--
 mm/show_mem.c                                  |  2 ++
 mm/vmstat.c                                    |  1 +
 13 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/procfs-smaps_rollup b/Documentation/ABI/testing/procfs-smaps_rollup
index b446a7154a1b..b50b3eda5a3f 100644
--- a/Documentation/ABI/testing/procfs-smaps_rollup
+++ b/Documentation/ABI/testing/procfs-smaps_rollup
@@ -34,6 +34,7 @@ Description:
 			Anonymous:	      68 kB
 			LazyFree:	       0 kB
 			AnonHugePages:	       0 kB
+			AnonHugePteMap:        0 kB
 			ShmemPmdMapped:	       0 kB
 			Shared_Hugetlb:	       0 kB
 			Private_Hugetlb:       0 kB
diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 5f502bf68fbc..b7efc7531896 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -535,7 +535,10 @@ memory.stat file includes following statistics:
     cache           # of bytes of page cache memory.
     rss             # of bytes of anonymous and swap cache memory (includes
                     transparent hugepages).
-    rss_huge        # of bytes of anonymous transparent hugepages.
+    rss_huge        # of bytes of anonymous transparent hugepages, mapped by
+                    PMD.
+    anon_thp_pte    # of bytes of anonymous transparent hugepages, mapped by
+                    PTE.
     mapped_file     # of bytes of mapped file (includes tmpfs/shmem)
     pgpgin          # of charging events to the memory cgroup. The charging
                     event happens each time a page is accounted as either mapped
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index b26b5274eaaf..48b961b8fc6d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1421,7 +1421,11 @@ PAGE_SIZE multiple when read back.
 
 	  anon_thp
 		Amount of memory used in anonymous mappings backed by
-		transparent hugepages
+		transparent hugepages, mapped by PMD
+
+	  anon_thp_pte
+		Amount of memory used in anonymous mappings backed by
+		transparent hugepages, mapped by PTE
 
 	  file_thp
 		Amount of cached filesystem data backed by transparent
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index b0cc8243e093..ebda57850643 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -291,10 +291,13 @@ Monitoring usage
 ================
 
 The number of anonymous transparent huge pages currently used by the
-system is available by reading the AnonHugePages field in ``/proc/meminfo``.
-To identify what applications are using anonymous transparent huge pages,
-it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages fields
-for each mapping.
+system is available by reading the AnonHugePages and AnonHugePteMap
+fields in ``/proc/meminfo``. To identify what applications are using
+anonymous transparent huge pages, it is necessary to read
+``/proc/PID/smaps`` and count the AnonHugePages and AnonHugePteMap
+fields for each mapping. Note that in both cases, AnonHugePages refers
+only to PMD-mapped THPs. AnonHugePteMap refers to THPs that are mapped
+using PTEs.
 
 The number of file transparent huge pages mapped to userspace is available
 by reading ShmemPmdMapped and ShmemHugePages fields in ``/proc/meminfo``.
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2b59cff8be17..ccbb76a509f0 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -464,6 +464,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
     KSM:                   0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
+    AnonHugePteMap:        0 kB
     ShmemPmdMapped:        0 kB
     Shared_Hugetlb:        0 kB
     Private_Hugetlb:       0 kB
@@ -511,7 +512,11 @@ pressure if the memory is clean. Please note that the printed value might
 be lower than the real value due to optimizations used in the current
 implementation. If this is not desirable please file a bug report.
 
-"AnonHugePages" shows the amount of memory backed by transparent hugepage.
+"AnonHugePages" shows the amount of memory backed by transparent hugepage,
+mapped by PMD.
+
+"AnonHugePteMap" shows the amount of memory backed by transparent hugepage,
+mapped by PTE.
 
 "ShmemPmdMapped" shows the amount of shared (shmem/tmpfs) memory backed by
 huge pages.
@@ -1006,6 +1011,7 @@ Example output. You may not have all of these fields.
     EarlyMemtestBad:       0 kB
     HardwareCorrupted:     0 kB
     AnonHugePages:   4149248 kB
+    AnonHugePteMap:        0 kB
     ShmemHugePages:        0 kB
     ShmemPmdMapped:        0 kB
     FileHugePages:         0 kB
@@ -1165,7 +1171,11 @@ HardwareCorrupted
               The amount of RAM/memory in KB, the kernel identifies as
               corrupted.
 AnonHugePages
-              Non-file backed huge pages mapped into userspace page tables
+              Non-file backed huge pages mapped into userspace page tables by
+              PMD
+AnonHugePteMap
+              Non-file backed huge pages mapped into userspace page tables by
+              PTE
 ShmemHugePages
               Memory used by shared memory (shmem) and tmpfs allocated
               with huge pages
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..08f1759387d2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -443,6 +443,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d SUnreclaim:     %8lu kB\n"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     "Node %d AnonHugePages:  %8lu kB\n"
+			     "Node %d AnonHugePteMap: %8lu kB\n"
 			     "Node %d ShmemHugePages: %8lu kB\n"
 			     "Node %d ShmemPmdMapped: %8lu kB\n"
 			     "Node %d FileHugePages:  %8lu kB\n"
@@ -475,6 +476,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
+			     nid, K(node_page_state(pgdat, NR_ANON_THPS_PTEMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..bac20cc60b6a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -143,6 +143,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
 		    global_node_page_state(NR_ANON_THPS));
+	show_val_kb(m, "AnonHugePteMap: ",
+		    global_node_page_state(NR_ANON_THPS_PTEMAPPED));
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3dd5be96691b..7b5dad163533 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -392,6 +392,7 @@ struct mem_size_stats {
 	unsigned long anonymous;
 	unsigned long lazyfree;
 	unsigned long anonymous_thp;
+	unsigned long anonymous_thp_pte;
 	unsigned long shmem_thp;
 	unsigned long file_thp;
 	unsigned long swap;
@@ -452,6 +453,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		mss->anonymous += size;
 		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
 			mss->lazyfree += size;
+		if (!compound && PageTransCompound(page))
+			mss->anonymous_thp_pte += size;
 	}
 
 	if (PageKsm(page))
@@ -833,6 +836,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nKSM:            ", mss->ksm);
 	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
+	SEQ_PUT_DEC(" kB\nAnonHugePteMap: ", mss->anonymous_thp_pte);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
 	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
 	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..5032fc31c651 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -186,6 +186,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_ANON_THPS_PTEMAPPED,
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d13dde2f8b56..07d8e0b55b0e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -809,6 +809,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
 		case NR_ANON_THPS:
+		case NR_ANON_THPS_PTEMAPPED:
 		case NR_SHMEM_PMDMAPPED:
 		case NR_FILE_PMDMAPPED:
 			WARN_ON_ONCE(!in_task());
@@ -1512,6 +1513,7 @@ static const struct memory_stat memory_stats[] = {
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	{ "anon_thp",			NR_ANON_THPS			},
+	{ "anon_thp_pte",		NR_ANON_THPS_PTEMAPPED		},
 	{ "file_thp",			NR_FILE_THPS			},
 	{ "shmem_thp",			NR_SHMEM_THPS			},
 #endif
@@ -4052,6 +4054,7 @@ static const unsigned int memcg1_stats[] = {
 	NR_ANON_MAPPED,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	NR_ANON_THPS,
+	NR_ANON_THPS_PTEMAPPED,
 #endif
 	NR_SHMEM,
 	NR_FILE_MAPPED,
@@ -4067,6 +4070,7 @@ static const char *const memcg1_stat_names[] = {
 	"rss",
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	"rss_huge",
+	"anon_thp_pte",
 #endif
 	"shmem",
 	"mapped_file",
@@ -6259,6 +6263,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 			 * can be done but it would be too convoluted so simply
 			 * ignore such a partial THP and keep it in original
 			 * memcg. There should be somebody mapping the head.
+			 * This simplification also means that pte-mapped large
+			 * folios are never migrated, which means we don't need
+			 * to worry about migrating the NR_ANON_THPS_PTEMAPPED
+			 * accounting.
 			 */
 			if (PageTransCompound(page))
 				goto put;
diff --git a/mm/rmap.c b/mm/rmap.c
index 106149690366..52dabee73023 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1205,7 +1205,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 {
 	struct folio *folio = page_folio(page);
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
+	int nr = 0, nr_pmdmapped = 0, nr_lgmapped = 0;
 	bool compound = flags & RMAP_COMPOUND;
 	bool first = true;
 
@@ -1214,6 +1214,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		first = atomic_inc_and_test(&page->_mapcount);
 		nr = first;
 		if (first && folio_test_large(folio)) {
+			nr_lgmapped = 1;
 			nr = atomic_inc_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
@@ -1241,6 +1242,8 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 
 	if (nr_pmdmapped)
 		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
+	if (nr_lgmapped)
+		__lruvec_stat_mod_folio(folio, NR_ANON_THPS_PTEMAPPED, nr_lgmapped);
 	if (nr)
 		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
@@ -1295,6 +1298,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		atomic_set(&folio->_nr_pages_mapped, nr);
+		__lruvec_stat_mod_folio(folio, NR_ANON_THPS_PTEMAPPED, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
@@ -1405,7 +1409,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 {
 	struct folio *folio = page_folio(page);
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	int nr = 0, nr_pmdmapped = 0;
+	int nr = 0, nr_pmdmapped = 0, nr_lgmapped = 0;
 	bool last;
 	enum node_stat_item idx;
 
@@ -1423,6 +1427,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 		last = atomic_add_negative(-1, &page->_mapcount);
 		nr = last;
 		if (last && folio_test_large(folio)) {
+			nr_lgmapped = 1;
 			nr = atomic_dec_return_relaxed(mapped);
 			nr = (nr < COMPOUND_MAPPED);
 		}
@@ -1454,6 +1459,8 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
 			idx = NR_FILE_PMDMAPPED;
 		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
 	}
+	if (nr_lgmapped && folio_test_anon(folio))
+		__lruvec_stat_mod_folio(folio, NR_ANON_THPS_PTEMAPPED, -nr_lgmapped);
 	if (nr) {
 		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
 		__lruvec_stat_mod_folio(folio, idx, -nr);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 4b888b18bdde..e648a815f0fb 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -254,6 +254,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			" shmem_thp:%lukB"
 			" shmem_pmdmapped:%lukB"
 			" anon_thp:%lukB"
+			" anon_thp_pte:%lukB"
 #endif
 			" writeback_tmp:%lukB"
 			" kernel_stack:%lukB"
@@ -280,6 +281,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
+			K(node_page_state(pgdat, NR_ANON_THPS_PTEMAPPED)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..267de0e4ddca 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1224,6 +1224,7 @@ const char * const vmstat_text[] = {
 	"nr_file_hugepages",
 	"nr_file_pmdmapped",
 	"nr_anon_transparent_hugepages",
+	"nr_anon_thp_pte",
 	"nr_vmscan_write",
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
-- 
2.25.1

