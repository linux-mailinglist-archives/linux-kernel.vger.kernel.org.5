Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51FA7F547C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjKVXZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbjKVXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:36 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C180A199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:30 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfcqUFguaDDZw+gf+d0LSy3BejslhVkAhwRYXLWAYww=;
        b=KVh3wxKIo4UY3M0nKsfWud9MNgWoL2E3pERfHvOTCAkXnvsURoSqAEjUmPalhXUSNLrOps
        qL0Vq27zCcEV27nYL27phxtsnLF4sUXNJKSd1c90XA5LM5BNTphc9LQscyej8ZjxlFAQtj
        zdogso5LeCN9DCAJz2BtPcz5+k96adw=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 4/7] mm: Centralize & improve oom reporting in show_mem.c
Date:   Wed, 22 Nov 2023 18:25:09 -0500
Message-ID: <20231122232515.177833-5-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
 - Changes show_mem() to always report on slab usage
 - Instead of reporting on all slabs, we only report on top 10 slabs,
   and in sorted order
 - Also reports on shrinkers, with the new shrinkers_to_text().
   Shrinkers need to be included in OOM/allocation failure reporting
   because they're responsible for memory reclaim - if a shrinker isn't
   giving up its memory, we need to know which one and why.

More OOM reporting can be moved to show_mem.c and improved, this patch
is only a start.

New example output on OOM/memory allocation failure:

00177 Mem-Info:
00177 active_anon:13706 inactive_anon:32266 isolated_anon:16
00177  active_file:1653 inactive_file:1822 isolated_file:0
00177  unevictable:0 dirty:0 writeback:0
00177  slab_reclaimable:6242 slab_unreclaimable:11168
00177  mapped:3824 shmem:3 pagetables:1266 bounce:0
00177  kernel_misc_reclaimable:0
00177  free:4362 free_pcp:35 free_cma:0
00177 Node 0 active_anon:54824kB inactive_anon:129064kB active_file:6612kB inactive_file:7288kB unevictable:0kB isolated(anon):64kB isolated(file):0kB mapped:15296kB dirty:0kB writeback:0kB shmem:12kB writeback_tmp:0kB kernel_stack:3392kB pagetables:5064kB all_unreclaimable? no
00177 DMA free:2232kB boost:0kB min:88kB low:108kB high:128kB reserved_highatomic:0KB active_anon:2924kB inactive_anon:6596kB active_file:428kB inactive_file:384kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 426 426 426
00177 DMA32 free:15092kB boost:5836kB min:8432kB low:9080kB high:9728kB reserved_highatomic:0KB active_anon:52196kB inactive_anon:122392kB active_file:6176kB inactive_file:7068kB unevictable:0kB writepending:0kB present:507760kB managed:441816kB mlocked:0kB bounce:0kB free_pcp:72kB local_pcp:0kB free_cma:0kB
00177 lowmem_reserve[]: 0 0 0 0
00177 DMA: 284*4kB (UM) 53*8kB (UM) 21*16kB (U) 11*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 2248kB
00177 DMA32: 2765*4kB (UME) 375*8kB (UME) 57*16kB (UM) 5*32kB (U) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15132kB
00177 4656 total pagecache pages
00177 1031 pages in swap cache
00177 Swap cache stats: add 6572399, delete 6572173, find 488603/3286476
00177 Free swap  = 509112kB
00177 Total swap = 2097148kB
00177 130938 pages RAM
00177 0 pages HighMem/MovableOnly
00177 16644 pages reserved
00177 Unreclaimable slab info:
00177 9p-fcall-cache    total: 8.25 MiB active: 8.25 MiB
00177 kernfs_node_cache total: 2.15 MiB active: 2.15 MiB
00177 kmalloc-64        total: 2.08 MiB active: 2.07 MiB
00177 task_struct       total: 1.95 MiB active: 1.95 MiB
00177 kmalloc-4k        total: 1.50 MiB active: 1.50 MiB
00177 signal_cache      total: 1.34 MiB active: 1.34 MiB
00177 kmalloc-2k        total: 1.16 MiB active: 1.16 MiB
00177 bch_inode_info    total: 1.02 MiB active: 922 KiB
00177 perf_event        total: 1.02 MiB active: 1.02 MiB
00177 biovec-max        total: 992 KiB active: 960 KiB
00177 Shrinkers:
00177 super_cache_scan: objects: 127
00177 super_cache_scan: objects: 106
00177 jbd2_journal_shrink_scan: objects: 32
00177 ext4_es_scan: objects: 32
00177 bch2_btree_cache_scan: objects: 8
00177   nr nodes:          24
00177   nr dirty:          0
00177   cannibalize lock:  0000000000000000
00177
00177 super_cache_scan: objects: 8
00177 super_cache_scan: objects: 1

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/oom_kill.c    | 23 ---------------------
 mm/show_mem.c    | 20 +++++++++++++++++++
 mm/slab.h        |  6 ++++--
 mm/slab_common.c | 52 +++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 9e6071fde34a..4b825a2b353f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -168,27 +168,6 @@ static bool oom_unkillable_task(struct task_struct *p)
 	return false;
 }
 
-/*
- * Check whether unreclaimable slab amount is greater than
- * all user memory(LRU pages).
- * dump_unreclaimable_slab() could help in the case that
- * oom due to too much unreclaimable slab used by kernel.
-*/
-static bool should_dump_unreclaim_slab(void)
-{
-	unsigned long nr_lru;
-
-	nr_lru = global_node_page_state(NR_ACTIVE_ANON) +
-		 global_node_page_state(NR_INACTIVE_ANON) +
-		 global_node_page_state(NR_ACTIVE_FILE) +
-		 global_node_page_state(NR_INACTIVE_FILE) +
-		 global_node_page_state(NR_ISOLATED_ANON) +
-		 global_node_page_state(NR_ISOLATED_FILE) +
-		 global_node_page_state(NR_UNEVICTABLE);
-
-	return (global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B) > nr_lru);
-}
-
 /**
  * oom_badness - heuristic function to determine which candidate task to kill
  * @p: task struct of which task we should calculate
@@ -462,8 +441,6 @@ static void dump_header(struct oom_control *oc)
 		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		__show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
-		if (should_dump_unreclaim_slab())
-			dump_unreclaimable_slab();
 	}
 	if (sysctl_oom_dump_tasks)
 		dump_tasks(oc);
diff --git a/mm/show_mem.c b/mm/show_mem.c
index ba0808d6917f..ab258ab1161c 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -12,10 +12,12 @@
 #include <linux/hugetlb.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/seq_buf.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
 
 #include "internal.h"
+#include "slab.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
@@ -401,6 +403,7 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 {
 	unsigned long total = 0, reserved = 0, highmem = 0;
 	struct zone *zone;
+	char *buf;
 
 	printk("Mem-Info:\n");
 	show_free_areas(filter, nodemask, max_zone_idx);
@@ -423,4 +426,21 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+
+	buf = kmalloc(4096, GFP_ATOMIC);
+	if (buf) {
+		struct seq_buf s;
+
+		printk("Unreclaimable slab info:\n");
+		seq_buf_init(&s, buf, 4096);
+		dump_unreclaimable_slab(&s);
+		printk("%s", seq_buf_str(&s));
+
+		printk("Shrinkers:\n");
+		seq_buf_init(&s, buf, 4096);
+		shrinkers_to_text(&s);
+		printk("%s", seq_buf_str(&s));
+
+		kfree(buf);
+	}
 }
diff --git a/mm/slab.h b/mm/slab.h
index 3d07fb428393..c16358a8424c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -818,10 +818,12 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 		 if ((__n = get_node(__s, __node)))
 
 
+struct seq_buf;
+
 #if defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG)
-void dump_unreclaimable_slab(void);
+void dump_unreclaimable_slab(struct seq_buf *);
 #else
-static inline void dump_unreclaimable_slab(void)
+static inline void dump_unreclaimable_slab(struct seq_buf *out)
 {
 }
 #endif
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 8d431193c273..1eadff512422 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -26,6 +26,7 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <linux/memcontrol.h>
+#include <linux/seq_buf.h>
 #include <linux/stackdepot.h>
 
 #include "internal.h"
@@ -1295,10 +1296,15 @@ static int slab_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-void dump_unreclaimable_slab(void)
+void dump_unreclaimable_slab(struct seq_buf *out)
 {
 	struct kmem_cache *s;
 	struct slabinfo sinfo;
+	struct slab_by_mem {
+		struct kmem_cache *s;
+		size_t total, active;
+	} slabs_by_mem[10], n;
+	int i, nr = 0;
 
 	/*
 	 * Here acquiring slab_mutex is risky since we don't prefer to get
@@ -1308,24 +1314,52 @@ void dump_unreclaimable_slab(void)
 	 * without acquiring the mutex.
 	 */
 	if (!mutex_trylock(&slab_mutex)) {
-		pr_warn("excessive unreclaimable slab but cannot dump stats\n");
+		seq_buf_puts(out, "excessive unreclaimable slab but cannot dump stats\n");
 		return;
 	}
 
-	pr_info("Unreclaimable slab info:\n");
-	pr_info("Name                      Used          Total\n");
-
 	list_for_each_entry(s, &slab_caches, list) {
 		if (s->flags & SLAB_RECLAIM_ACCOUNT)
 			continue;
 
 		get_slabinfo(s, &sinfo);
 
-		if (sinfo.num_objs > 0)
-			pr_info("%-17s %10luKB %10luKB\n", s->name,
-				(sinfo.active_objs * s->size) / 1024,
-				(sinfo.num_objs * s->size) / 1024);
+		if (!sinfo.num_objs)
+			continue;
+
+		n.s = s;
+		n.total = sinfo.num_objs * s->size;
+		n.active = sinfo.active_objs * s->size;
+
+		for (i = 0; i < nr; i++)
+			if (n.total < slabs_by_mem[i].total)
+				break;
+
+		if (nr < ARRAY_SIZE(slabs_by_mem)) {
+			memmove(&slabs_by_mem[i + 1],
+				&slabs_by_mem[i],
+				sizeof(slabs_by_mem[0]) * (nr - i));
+			nr++;
+		} else if (i) {
+			i--;
+			memmove(&slabs_by_mem[0],
+				&slabs_by_mem[1],
+				sizeof(slabs_by_mem[0]) * i);
+		} else {
+			continue;
+		}
+
+		slabs_by_mem[i] = n;
+	}
+
+	for (i = nr - 1; i >= 0; --i) {
+		seq_buf_printf(out, "%-17s total: ", slabs_by_mem[i].s->name);
+		seq_buf_human_readable_u64(out, slabs_by_mem[i].total, STRING_UNITS_2);
+		seq_buf_printf(out, " active: ");
+		seq_buf_human_readable_u64(out, slabs_by_mem[i].active, STRING_UNITS_2);
+		seq_buf_putc(out, '\n');
 	}
+
 	mutex_unlock(&slab_mutex);
 }
 
-- 
2.42.0

