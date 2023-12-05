Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2109D8061BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbjLEWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbjLEWbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:31:18 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CCD40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:31:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca2a6f07b6so99909527b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701815482; x=1702420282; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+O/X+6Q6R9GcSlfV4mE6hrZwLOSfryTWJQe8aSINpg=;
        b=vkj29PYWuA3Lvngii0RoZUbybmsL5wmQqa3dYVJyzql1roFQ1+p2TJik0JLRpNxteK
         pmnWZ46ETSgS43c1ft2tAq2ReBHaBtxmwrQhdh89Tjpr4IititqZ5XvHgHS9QNYBpzoC
         w16H9xOlNPb3fi0hUzm1LPaTJx77UWeePKHt4WHYRLJKT9CHi9wv65/VWl4dEB1gqRnk
         JXFGJ36qYtBSZ/++gucOLgkZVSRRum/knmJx7DVhyv/37b08iMsDg+ohESPOQYNWI5j6
         tX8n1gq6vilinqha7jgtR+t8GpF8qStGpkKonX8ddrglOOR5Rz0fLVSDufsN0a8PwpvL
         b79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701815482; x=1702420282;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+O/X+6Q6R9GcSlfV4mE6hrZwLOSfryTWJQe8aSINpg=;
        b=RVrWfD7hbT9+wLVre+R82ATfMUHpPrqsAmCqo3Jij5MTQaQRihPb+U6O7rRK0mz4X+
         Xp9bB0Cw04md6lBwE98Tb263PfWWyj0ZFW7NCq1gLGBENd1DV2EKXrguCAE/E4oOnUEK
         3LiTLLFRBfnIwYaupd3+QWyW0ffn4CPfNjCO5gRD1lSq4pSnFnfknAg977gA6i5XnQJI
         qCtnn/bF3zIAH1YD4xBlym6Z10m9kZBwdSUosN9/bppCvcJN6OvI/sEc/0FzSGK/Q8KY
         vQXqFLdlZ3mAllYitsRFi3bESW78r+YnJjsli0q8Y4KP53bmeZ+9w67z//rLlWZ3LFIz
         mpNg==
X-Gm-Message-State: AOJu0Yz91Z1XxqQhmNnh0qw6Acuec2nUXumTNL9GsrLETPQehjSxW9EL
        ox/B8rktBt9nZWCr4OBupx81VMnOQ6okm7mH8A==
X-Google-Smtp-Source: AGHT+IHKJsHxq/nHYtjrj6RdhDbJfNsypVk+zy0W0oUlrazoZa/w9albj2MUOYGaJNKIBbloQpjIaA1ASk7A2y0Ihw==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:f645:15:697e:b77b])
 (user=souravpanda job=sendgmr) by 2002:a81:be17:0:b0:5d0:a744:719d with SMTP
 id i23-20020a81be17000000b005d0a744719dmr765078ywn.1.1701815482682; Tue, 05
 Dec 2023 14:31:22 -0800 (PST)
Date:   Tue,  5 Dec 2023 14:31:18 -0800
In-Reply-To: <20231205223118.3575485-1-souravpanda@google.com>
Mime-Version: 1.0
References: <20231205223118.3575485-1-souravpanda@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231205223118.3575485-2-souravpanda@google.com>
Subject: [PATCH v6 1/1] mm: report per-page metadata information
From:   Sourav Panda <souravpanda@google.com>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, souravpanda@google.com,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds two new per-node fields, namely nr_page_metadata and
nr_page_metadata_boot, to /sys/devices/system/node/nodeN/vmstat
and a global PageMetadata field to /proc/meminfo. This information can
be used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures. In contrast to
most other memory consumption statistics, per-page metadata might not
be included in MemTotal. For example, MemTotal does not include memblock
allocations but includes buddy allocations. In this patch, exported
field nr_page_metadata in /sys/devices/system/node/nodeN/vmstat would
exclusively track buddy allocations while nr_page_metadata_boot would
exclusively track memblock allocations. Furthermore, PageMetadata in
/proc/meminfo would exclusively track buddy allocations allowing it to
be compared against MemTotal.

This memory depends on build configurations, machine architectures, and
the way system is used:

Build configuration may include extra fields into "struct page",
and enable / disable "page_ext"
Machine architecture defines base page sizes. For example 4K x86,
8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
overhead is smaller on machines with larger page sizes.
System use can change per-page overhead by using vmemmap
optimizations with hugetlb pages, and emulated pmem devdax pages.
Also, boot parameters can determine whether page_ext is needed
to be allocated. This memory can be part of MemTotal or be outside
MemTotal depending on whether the memory was hot-plugged, booted with,
or hugetlb memory was returned back to the system.

Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Sourav Panda <souravpanda@google.com>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  7 +++++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 19 ++++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 49ef12df631b..d5901d04e082 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
     AnonPages:       4654780 kB
     Mapped:           266244 kB
     Shmem:              9976 kB
+    PageMetadata:     513419 kB
     KReclaimable:     517708 kB
     Slab:             660044 kB
     SReclaimable:     517708 kB
@@ -1095,6 +1096,8 @@ Mapped
               files which have been mmapped, such as libraries
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
+PageMetadata
+              Memory used for per-page metadata
 KReclaimable
               Kernel allocations that the kernel will attempt to reclaim
               under memory pressure. Includes SReclaimable (below), and other
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 45af9a989d40..f141bb2a550d 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	long available;
 	unsigned long pages[NR_LRU_LISTS];
 	unsigned long sreclaimable, sunreclaim;
+	unsigned long nr_page_metadata;
 	int lru;
+	int nid;
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
@@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	sreclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
 	sunreclaim = global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
 
+	nr_page_metadata = 0;
+	for_each_online_node(nid)
+		nr_page_metadata += node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
+
 	show_val_kb(m, "MemTotal:       ", i.totalram);
 	show_val_kb(m, "MemFree:        ", i.freeram);
 	show_val_kb(m, "MemAvailable:   ", available);
@@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Mapped:         ",
 		    global_node_page_state(NR_FILE_MAPPED));
 	show_val_kb(m, "Shmem:          ", i.sharedram);
+	show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
 	show_val_kb(m, "KReclaimable:   ", sreclaimable +
 		    global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3c25226beeed..ef176152be7c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -207,6 +207,10 @@ enum node_stat_item {
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
 #endif
+	NR_PAGE_METADATA,	/* Page metadata size (struct page and page_ext)
+				 * in pages
+				 */
+	NR_PAGE_METADATA_BOOT,	/* NR_PAGE_METADATA for bootmem */
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fed855bae6d8..af096a881f03 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -656,4 +656,8 @@ static inline void lruvec_stat_sub_folio(struct folio *folio,
 {
 	lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
 }
+
+void __init mod_node_early_perpage_metadata(int nid, long delta);
+void __init store_early_perpage_metadata(void);
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 87818ee7f01d..5b10d8d2b471 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -230,10 +230,14 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
  */
 static inline void free_vmemmap_page(struct page *page)
 {
-	if (PageReserved(page))
+	if (PageReserved(page)) {
 		free_bootmem_page(page);
-	else
+		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA_BOOT,
+				    -1);
+	} else {
 		__free_page(page);
+		mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, -1);
+	}
 }
 
 /* Free a list of the vmemmap pages */
@@ -389,6 +393,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
 		list_add(&walk.reuse_page->lru, vmemmap_pages);
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
 	}
 
 	/*
@@ -437,14 +442,20 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 	unsigned long nr_pages = (end - start) >> PAGE_SHIFT;
 	int nid = page_to_nid((struct page *)start);
 	struct page *page, *next;
+	int i;
 
-	while (nr_pages--) {
+	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page)
+		if (!page) {
+			mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+					    i);
 			goto out;
+		}
 		list_add(&page->lru, list);
 	}
 
+	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, nr_pages);
+
 	return 0;
 out:
 	list_for_each_entry_safe(page, next, list, lru)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..38f8e1f454a0 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/swap.h>
 #include <linux/cma.h>
+#include <linux/vmstat.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
 			panic("Failed to allocate %ld bytes for node %d memory map\n",
 			      size, pgdat->node_id);
 		pgdat->node_mem_map = map + offset;
+		mod_node_early_perpage_metadata(pgdat->node_id,
+						DIV_ROUND_UP(size, PAGE_SIZE));
 	}
 	pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
 				__func__, pgdat->node_id, (unsigned long)pgdat,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..dd78017105b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5636,6 +5636,7 @@ void __init setup_per_cpu_pageset(void)
 	for_each_online_pgdat(pgdat)
 		pgdat->per_cpu_nodestats =
 			alloc_percpu(struct per_cpu_nodestat);
+	store_early_perpage_metadata();
 }
 
 __meminit void zone_pcp_init(struct zone *zone)
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 4548fcc66d74..4ca9f298f34e 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
 		return -ENOMEM;
 	NODE_DATA(nid)->node_page_ext = base;
 	total_usage += table_size;
+	mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
+			    DIV_ROUND_UP(table_size, PAGE_SIZE));
 	return 0;
 }
 
@@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, int nid)
 	void *addr = NULL;
 
 	addr = alloc_pages_exact_nid(nid, size, flags);
-	if (addr) {
+	if (addr)
 		kmemleak_alloc(addr, size, 1, flags);
-		return addr;
-	}
+	else
+		addr = vzalloc_node(size, nid);
 
-	addr = vzalloc_node(size, nid);
+	if (addr) {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				    DIV_ROUND_UP(size, PAGE_SIZE));
+	}
 
 	return addr;
 }
@@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned long pfn, int nid)
 
 static void free_page_ext(void *addr)
 {
+	size_t table_size;
+	struct page *page;
+	struct pglist_data *pgdat;
+
+	table_size = page_ext_size * PAGES_PER_SECTION;
+
 	if (is_vmalloc_addr(addr)) {
+		page = vmalloc_to_page(addr);
+		pgdat = page_pgdat(page);
 		vfree(addr);
 	} else {
-		struct page *page = virt_to_page(addr);
-		size_t table_size;
-
-		table_size = page_ext_size * PAGES_PER_SECTION;
-
+		page = virt_to_page(addr);
+		pgdat = page_pgdat(page);
 		BUG_ON(PageReserved(page));
 		kmemleak_free(addr);
 		free_pages_exact(addr, table_size);
 	}
+
+	mod_node_page_state(pgdat, NR_PAGE_METADATA,
+			    -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
+
 }
 
 static void __free_page_ext(unsigned long pfn)
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..054b49539843 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 	if (r < 0)
 		return NULL;
 
+	if (system_state == SYSTEM_BOOTING) {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	} else {
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
+				    DIV_ROUND_UP(end - start, PAGE_SIZE));
+	}
+
 	return pfn_to_page(pfn);
 }
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..0c100ae1cf8b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -14,7 +14,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
-
+#include <linux/vmstat.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
 	 */
 	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
 	sparsemap_buf_end = sparsemap_buf + size;
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+	mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE));
+#endif
 }
 
 static void __init sparse_buffer_fini(void)
@@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_PAGE_METADATA,
+			    -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
 static void free_map_bootmem(struct page *memmap)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..23e88d8c21b7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1249,7 +1249,8 @@ const char * const vmstat_text[] = {
 	"pgpromote_success",
 	"pgpromote_candidate",
 #endif
-
+	"nr_page_metadata",
+	"nr_page_metadata_boot",
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
@@ -2278,4 +2279,27 @@ static int __init extfrag_debug_init(void)
 }
 
 module_init(extfrag_debug_init);
+
 #endif
+
+/*
+ * Page metadata size (struct page and page_ext) in pages
+ */
+static unsigned long early_perpage_metadata[MAX_NUMNODES] __initdata;
+
+void __init mod_node_early_perpage_metadata(int nid, long delta)
+{
+	early_perpage_metadata[nid] += delta;
+}
+
+void __init store_early_perpage_metadata(void)
+{
+	int nid;
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		nid = pgdat->node_id;
+		mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA_BOOT,
+				    early_perpage_metadata[nid]);
+	}
+}
-- 
2.43.0.472.g3155946c3a-goog

