Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F27806FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358522AbjHRIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358582AbjHRIRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:17:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552943C27
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:17:33 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRvnQ1vHGzVjkQ;
        Fri, 18 Aug 2023 16:15:22 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 16:17:29 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [RFC PATCH v2-next] mm: memory-failure: use rcu lock instead of tasklist_lock when collect_procs()
Date:   Fri, 18 Aug 2023 16:17:27 +0800
Message-ID: <20230818081727.4181963-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 - find_early_kill_thread()

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
v2:
 - 1. Modify the title description.
 - 2. Optimize the implementation of find_early_kill_thread() without
      functional changes.
---
 mm/ksm.c            |  4 ++--
 mm/memory-failure.c | 33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6b7b8928fb96..dcbc0c7f68e7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2919,7 +2919,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
 		struct anon_vma *av = rmap_item->anon_vma;
 
 		anon_vma_lock_read(av);
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		for_each_process(tsk) {
 			struct anon_vma_chain *vmac;
 			unsigned long addr;
@@ -2938,7 +2938,7 @@ void collect_procs_ksm(struct page *page, struct list_head *to_kill,
 				}
 			}
 		}
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 		anon_vma_unlock_read(av);
 	}
 }
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7b01fffe7a79..4f3081f47798 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -546,24 +546,29 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
  * Find a dedicated thread which is supposed to handle SIGBUS(BUS_MCEERR_AO)
  * on behalf of the thread group. Return task_struct of the (first found)
  * dedicated thread if found, and return NULL otherwise.
- *
- * We already hold read_lock(&tasklist_lock) in the caller, so we don't
- * have to call rcu_read_lock/unlock() in this function.
  */
 static struct task_struct *find_early_kill_thread(struct task_struct *tsk)
 {
 	struct task_struct *t;
+	bool found = false;
 
+	rcu_read_lock();
 	for_each_thread(tsk, t) {
 		if (t->flags & PF_MCE_PROCESS) {
-			if (t->flags & PF_MCE_EARLY)
-				return t;
+			if (t->flags & PF_MCE_EARLY) {
+				found = true;
+				break;
+			}
 		} else {
-			if (sysctl_memory_failure_early_kill)
-				return t;
+			if (sysctl_memory_failure_early_kill) {
+				found = true;
+				break;
+			}
 		}
 	}
-	return NULL;
+	rcu_read_unlock();
+
+	return found ? t : NULL;
 }
 
 /*
@@ -609,7 +614,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 		return;
 
 	pgoff = page_to_pgoff(page);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(tsk) {
 		struct anon_vma_chain *vmac;
 		struct task_struct *t = task_early_kill(tsk, force_early);
@@ -626,7 +631,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	anon_vma_unlock_read(av);
 }
 
@@ -642,7 +647,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	pgoff = page_to_pgoff(page);
 	for_each_process(tsk) {
 		struct task_struct *t = task_early_kill(tsk, force_early);
@@ -662,7 +667,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 				add_to_kill_anon_file(t, page, vma, to_kill);
 		}
 	}
-	read_unlock(&tasklist_lock);
+	rcu_read_unlock();
 	i_mmap_unlock_read(mapping);
 }
 
@@ -685,7 +690,7 @@ static void collect_procs_fsdax(struct page *page,
 	struct task_struct *tsk;
 
 	i_mmap_lock_read(mapping);
-	read_lock(&tasklist_lock);
+	rcu_read_lock();
 	for_each_process(tsk) {
 		struct task_struct *t = task_early_kill(tsk, true);
 
@@ -696,7 +701,7 @@ static void collect_procs_fsdax(struct page *page,
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

