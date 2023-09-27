Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC47AF8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjI0DnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjI0DkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:40:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B72689
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:06:11 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwLzZ6TCkzrSnL;
        Wed, 27 Sep 2023 11:03:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 11:06:10 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 2/3] mm/kmemleak: fix partially freeing unknown object warning
Date:   Wed, 27 Sep 2023 11:59:22 +0800
Message-ID: <20230927035923.1425340-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927035923.1425340-1-liushixin2@huawei.com>
References: <20230927035923.1425340-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete_object_part() can be called by multiple callers in the same time.
If an object is found and removed by a caller, and then another caller
try to find it too, it failed and return directly. The secound part still
be recorded by kmemleak even if it has alreadly been freed to buddy.
With DEBUG on, kmemleak will report the following warning:

 kmemleak: Partially freeing unknown object at 0xa1af86000 (size 4096)
 CPU: 0 PID: 742 Comm: test_huge Not tainted 6.6.0-rc3kmemleak+ #54
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x37/0x50
  kmemleak_free_part_phys+0x50/0x60
  hugetlb_vmemmap_optimize+0x172/0x290
  ? __pfx_vmemmap_remap_pte+0x10/0x10
  __prep_new_hugetlb_folio+0xe/0x30
  prep_new_hugetlb_folio.isra.0+0xe/0x40
  alloc_fresh_hugetlb_folio+0xc3/0xd0
  alloc_surplus_hugetlb_folio.constprop.0+0x6e/0xd0
  hugetlb_acct_memory.part.0+0xe6/0x2a0
  hugetlb_reserve_pages+0x110/0x2c0
  hugetlbfs_file_mmap+0x11d/0x1b0
  mmap_region+0x248/0x9a0
  ? hugetlb_get_unmapped_area+0x15c/0x2d0
  do_mmap+0x38b/0x580
  vm_mmap_pgoff+0xe6/0x190
  ksys_mmap_pgoff+0x18a/0x1f0
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 53238a60dd4a ("kmemleak: Allow partial freeing of memory blocks")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 54c2c90d3abc..5a2bbd85df57 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -208,6 +208,8 @@ static struct rb_root object_tree_root = RB_ROOT;
 static struct rb_root object_phys_tree_root = RB_ROOT;
 /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
+/* Serial delete_object_part() to ensure all objects is deleted correctly */
+static DEFINE_RAW_SPINLOCK(delete_object_part_mutex);
 
 /* allocation caches for kmemleak internal data */
 static struct kmem_cache *object_cache;
@@ -784,13 +786,16 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 {
 	struct kmemleak_object *object;
 	unsigned long start, end;
+	unsigned long flags;
 
+	raw_spin_lock_irqsave(&delete_object_part_mutex, flags);
 	object = find_and_remove_object(ptr, 1, is_phys);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
 			      ptr, size);
 #endif
+		raw_spin_unlock_irqrestore(&delete_object_part_mutex, flags);
 		return;
 	}
 
@@ -809,6 +814,7 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 			      GFP_KERNEL, is_phys);
 
 	__delete_object(object);
+	raw_spin_unlock_irqrestore(&delete_object_part_mutex, flags);
 }
 
 static void __paint_it(struct kmemleak_object *object, int color)
-- 
2.25.1

