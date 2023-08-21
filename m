Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20118782616
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjHUJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjHUJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:13:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A4BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:13:17 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTmv81yWhz1L9FL;
        Mon, 21 Aug 2023 17:11:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 17:13:14 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v2] mm: memory-failure: use rcu lock instead of tasklist_lock when collect_procs()
Date:   Mon, 21 Aug 2023 17:13:12 +0800
Message-ID: <20230821091312.2034844-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a softlock issue in our test, analyzed the logs, and found that
the relevant CPU call trace as follows:

CPU0:
  _do_fork
    -> copy_process()
      -> write_lock_irq(&tasklist_lock)  //Disable irq,waiting for
      					 //tasklist_lock

CPU1:
  wp_page_copy()
    ->pte_offset_map_lock()
      -> spin_lock(&page->ptl);        //Hold page->ptl
    -> ptep_clear_flush()
      -> flush_tlb_others() ...
        -> smp_call_function_many()
          -> arch_send_call_function_ipi_mask()
            -> csd_lock_wait()         //Waiting for other CPUs respond
	                               //IPI

CPU2:
  collect_procs_anon()
    -> read_lock(&tasklist_lock)       //Hold tasklist_lock
      ->for_each_process(tsk)
        -> page_mapped_in_vma()
          -> page_vma_mapped_walk()
	    -> map_pte()
              ->spin_lock(&page->ptl)  //Waiting for page->ptl

We can see that CPU1 waiting for CPU0 respond IPI，CPU0 waiting for CPU2
unlock tasklist_lock, CPU2 waiting for CPU1 unlock page->ptl. As a result,
softlockup is triggered.

For collect_procs_anon(), we will not modify the tasklist, but only perform
read traversal. Therefore, we can use rcu lock instead of spin lock
tasklist_lock, from this, we can break the softlock chain above.

The same logic can also be applied to:
 - collect_procs_file()
 - collect_procs_fsdax()
 - collect_procs_ksm()

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
Since v1:
 - 1. According to Matthew's suggestion, only the comments of
      find_early_kill_thread() are modified, no need to hold the rcu lock.

Changes since RFC[1]:
 - 1. According to Naoya's suggestion, modify the tasklist_lock in the
      comment about locking order in mm/filemap.c.
 - 2. According to Kefeng's suggestion, optimize the implementation of
      find_early_kill_thread() without functional changes.
 - 3. Modify the title description.

[1] https://lore.kernel.org/lkml/20230815130154.1100779-1-tongtiangen@huawei.com/
---
 mm/filemap.c        |  3 ---
 mm/ksm.c            |  4 ++--
 mm/memory-failure.c | 16 ++++++++--------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 014b73eb96a1..dfade1ef1765 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -121,9 +121,6 @@
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
- *
- * ->i_mmap_rwsem
- *   ->tasklist_lock            (memory_failure, collect_procs_ao)
  */
 
 static void page_cache_delete(struct address_space *mapping,
diff --git a/mm/ksm.c b/mm/ksm.c
index 8d6aee05421d..981af9c72e7a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2925,7 +2925,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
 		struct anon_vma *av = rmap_item->anon_vma;
 
 		anon_vma_lock_read(av);
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		for_each_process(tsk) {
 			struct anon_vma_chain *vmac;
 			unsigned long addr;
@@ -2944,7 +2944,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
 				}
 			}
 		}
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 		anon_vma_unlock_read(av);
 	}
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7b01fffe7a79..4d6e43c88489 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -547,8 +547,8 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
  * on behalf of the thread group. Return task_struct of the (first found)
  * dedicated thread if found, and return NULL otherwise.
  *
- * We already hold read_lock(&tasklist_lock) in the caller, so we don't
- * have to call rcu_read_lock/unlock() in this function.
+ * We already hold rcu lock in the caller, so we don't have to call
+ * rcu_read_lock/unlock() in this function.
  */
 static struct task_struct *find_early_kill_thread(struct task_struct *tsk)
 {
@@ -609,7 +609,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 		return;
 
 	pgoff = page_to_pgoff(page);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(tsk) {
 		struct anon_vma_chain *vmac;
 		struct task_struct *t = task_early_kill(tsk, force_early);
@@ -626,7 +626,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	anon_vma_unlock_read(av);
 }
 
@@ -642,7 +642,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	pgoff = page_to_pgoff(page);
 	for_each_process(tsk) {
 		struct task_struct *t = task_early_kill(tsk, force_early);
@@ -662,7 +662,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 				add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 
@@ -685,7 +685,7 @@ static void collect_procs_fsdax(struct page *page,
 	struct task_struct *tsk;
 
 	i_mmap_lock_read(mapping);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(tsk) {
 		struct task_struct *t = task_early_kill(tsk, true);
 
@@ -696,7 +696,7 @@ static void collect_procs_fsdax(struct page *page,
 				add_to_kill_fsdax(t, page, vma, to_kill, pgoff);
 		}
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 #endif /* CONFIG_FS_DAX */
-- 
2.25.1

