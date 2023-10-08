Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5377BCB98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 03:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjJHBda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 21:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjJHBdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 21:33:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368A99
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 18:33:20 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S34Lj1DjzztTDg;
        Sun,  8 Oct 2023 09:28:45 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 8 Oct
 2023 09:33:18 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 3/4] mm/kmemleak: fix partially freeing unknown object warning
Date:   Sun, 8 Oct 2023 10:33:16 +0800
Message-ID: <20231008023317.3015699-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231008023317.3015699-1-liushixin2@huawei.com>
References: <20231008023317.3015699-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Fix the problem by adding a new mutex lock to make sure all objects are
deleted sequentially in delete_object_part(). The kmemleak_lock is not
suitable here because there is a memory allocation with flag GFP_KERNEL.

Fixes: 53238a60dd4a ("kmemleak: Allow partial freeing of memory blocks")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 54c2c90d3abc..ed497866361a 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -208,6 +208,8 @@ static struct rb_root object_tree_root = RB_ROOT;
 static struct rb_root object_phys_tree_root = RB_ROOT;
 /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
 static DEFINE_RAW_SPINLOCK(kmemleak_lock);
+/* Serial delete_object_part() to ensure all objects are deleted correctly */
+static DEFINE_MUTEX(delete_object_part_mutex);
 
 /* allocation caches for kmemleak internal data */
 static struct kmem_cache *object_cache;
@@ -785,13 +787,15 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 	struct kmemleak_object *object;
 	unsigned long start, end;
 
+	mutex_lock(&delete_object_part_mutex);
+
 	object = find_and_remove_object(ptr, 1, is_phys);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
 			      ptr, size);
 #endif
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -809,6 +813,9 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 			      GFP_KERNEL, is_phys);
 
 	__delete_object(object);
+
+unlock:
+	mutex_unlock(&delete_object_part_mutex);
 }
 
 static void __paint_it(struct kmemleak_object *object, int color)
-- 
2.25.1

