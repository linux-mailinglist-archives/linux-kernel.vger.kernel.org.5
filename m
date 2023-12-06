Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A6807038
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378196AbjLFMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378169AbjLFMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:50:50 -0500
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA89D45
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:50:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.Ve5fmIH_1701867051;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.Ve5fmIH_1701867051)
          by smtp.aliyun-inc.com;
          Wed, 06 Dec 2023 20:50:51 +0800
From:   "Henry Huang" <henry.hj@antgroup.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        <akpm@linux-foundation.org>, "Henry Huang" <henry.hj@antgroup.com>
Subject: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date:   Wed, 06 Dec 2023 20:50:07 +0800
Message-ID: <951fb7edab535cf522def4f5f2613947ed7b7d28.1701853894.git.henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701853894.git.henry.hj@antgroup.com>
References: <cover.1701853894.git.henry.hj@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-Gen LRU page-table walker clears pte young flag, but it doesn't
clear page idle flag. When we use /sys/kernel/mm/page_idle/bitmap to check
whether one page is accessed, it would tell us this page is idle,
but actually this page has been accessed.

For those unmapped filecache pages, page idle flag would not been
cleared in folio_mark_accessed if Multi-Gen LRU is enabled.
So we couln't use /sys/kernel/mm/page_idle/bitmap to check whether
a filecache page is read or written.

What's more, /sys/kernel/mm/page_idle/bitmap also clears pte young flag.
If one page is accessed, it would set page young flag. Multi-Gen LRU
page-table walker should check both page&pte young flags.

how-to-reproduce-problem

idle_page_track
   a tools to track process accessed memory during a specific time
usage
   idle_page_track $pid $time
how-it-works
   1. scan process vma from /proc/$pid/maps
   2. vfn --> pfn from /proc/$pid/pagemap
   3. write /sys/kernel/mm/page_idle/bitmap to
      mark phy page idle flag and clear pte young flag
   4. sleep $time
   5. read /sys/kernel/mm/page_idle/bitmap to
      test_and_clear pte young flag and
      return whether phy page is accessed

test ---- test program

 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>

 int main(int argc, const char *argv[])
 {
     char *buf = NULL;
     char pipe_info[4096];
     int n;
     int fd = -1;

     buf = malloc(1024*1024*1024UL);
     memset(buf, 0, 1024*1024*1024UL);
     fd = open("access.pipe", O_RDONLY);
     if (fd < 0)
         goto out;
     while (1) {
         n = read(fd, pipe_info, sizeof(pipe_info));
         if (!n) {
             sleep(1);
             continue;
         } else if (n < 0) {
             break;
         }
         memset(buf, 0, 1024*1024*1024UL);
         puts("finish access");
      }
 out:
     if (fd >=0)
         close(fd);
     if (buf)
         free(buf);

     return 0;
 }

prepare:
mkfifo access.pipe
./test
ps -ef | grep test
root       4106   3148  8 06:47 pts/0    00:00:01 ./test

We use /sys/kernel/debug/lru_gen to simulate mglru page-table scan.

case 1: mglru walker break page_idle
./idle_page_track 4106 60 &
sleep 5; echo 1 > access.pipe
sleep 5;  echo '+ 8 0 6 1 1' > /sys/kernel/debug/lru_gen

the output of idle_page_track is:
Est(s)     Ref(MB)
64.822        1.00
only found 1MB were accessed during 64.822s, but actually 1024MB were
accessed.

case 2: page_idle break mglru walker
echo 1 > access.pipe
./idle_page_track 4106 10
echo '+ 8 0 7 1 1' > /sys/kernel/debug/lru_gen
lru gen status:
memcg     8     /user.slice
 node     0
          5     772458       1065        9735
          6     737435     262244          72
          7     538053       1184         632
          8      59404       6422           0
almost pages should be in max_seq-1 queue, but actually not.

Signed-off-by: Henry Huang <henry.hj@antgroup.com>
---
 mm/swap.c   |  3 +++
 mm/vmscan.c | 40 ++++++++++++++++++++++++++++------------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..4bd14aabdc10 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -416,6 +416,9 @@ static void folio_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
+	if (folio_test_idle(folio))
+		folio_clear_idle(folio);
+
 	if (folio_test_unevictable(folio))
 		return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96abaa5a973e..c1dd9e7bc315 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3297,7 +3297,7 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 #endif
 
 static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
-				   struct pglist_data *pgdat, bool can_swap)
+				   struct pglist_data *pgdat, bool can_swap, bool clear_idle)
 {
 	struct folio *folio;
 
@@ -3306,6 +3306,10 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 		return NULL;
 
 	folio = pfn_folio(pfn);
+
+	if (clear_idle && folio_test_idle(folio))
+		folio_clear_idle(folio);
+
 	if (folio_nid(folio) != pgdat->node_id)
 		return NULL;
 
@@ -3355,6 +3359,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		unsigned long pfn;
 		struct folio *folio;
 		pte_t ptent = ptep_get(pte + i);
+		bool is_pte_young;
 
 		total++;
 		walk->mm_stats[MM_LEAF_TOTAL]++;
@@ -3363,16 +3368,20 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent)) {
-			walk->mm_stats[MM_LEAF_OLD]++;
+		is_pte_young = !!pte_young(ptent);
+		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap, is_pte_young);
+		if (!folio) {
+			if (!is_pte_young)
+				walk->mm_stats[MM_LEAF_OLD]++;
 			continue;
 		}
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
-		if (!folio)
+		if (!folio_test_clear_young(folio) && !is_pte_young) {
+			walk->mm_stats[MM_LEAF_OLD]++;
 			continue;
+		}
 
-		if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
+		if (is_pte_young && !ptep_test_and_clear_young(args->vma, addr, pte + i))
 			VM_WARN_ON_ONCE(true);
 
 		young++;
@@ -3435,6 +3444,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 	do {
 		unsigned long pfn;
 		struct folio *folio;
+		bool is_pmd_young;
 
 		/* don't round down the first address */
 		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
@@ -3449,11 +3459,15 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 			goto next;
 		}
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
+		is_pmd_young = !!pmd_young(pmd[i]);
+		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap, is_pmd_young);
 		if (!folio)
 			goto next;
 
-		if (!pmdp_test_and_clear_young(vma, addr, pmd + i))
+		if (is_pmd_young && !pmdp_test_and_clear_young(vma, addr, pmd + i))
+			VM_WARN_ON_ONCE(true);
+
+		if (!folio_test_clear_young(folio) && !is_pmd_young)
 			goto next;
 
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -4025,19 +4039,21 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
 		unsigned long pfn;
 		pte_t ptent = ptep_get(pte + i);
+		bool is_pte_young;
 
 		pfn = get_pte_pfn(ptent, pvmw->vma, addr);
 		if (pfn == -1)
 			continue;
 
-		if (!pte_young(ptent))
+		is_pte_young = !!pte_young(ptent);
+		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap, is_pte_young);
+		if (!folio)
 			continue;
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
-		if (!folio)
+		if (!folio_test_clear_young(folio) && !is_pte_young)
 			continue;
 
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+		if (is_pte_young && !ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
 			VM_WARN_ON_ONCE(true);
 
 		young++;
-- 
2.43.0

