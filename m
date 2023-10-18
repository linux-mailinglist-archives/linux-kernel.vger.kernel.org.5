Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E27CD809
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJRJau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJRJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3840F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:23 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9QVf0nMPzrTNn;
        Wed, 18 Oct 2023 17:27:38 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:30:20 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 7/7] mm/kmemleak: fix partially freeing unknown object warning
Date:   Wed, 18 Oct 2023 18:29:52 +0800
Message-ID: <20231018102952.3339837-8-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018102952.3339837-1-liushixin2@huawei.com>
References: <20231018102952.3339837-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

delete_object_part() can be called by multiple callers in the
same time. If an object is found and removed by a caller, and
then another caller try to find it too, it failed and return
directly. It still be recorded by kmemleak even if it has already
been freed to buddy. With DEBUG on, kmemleak will report the
following warning,

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

Expand __create_object() and move __alloc_object() to the beginning.
Then use kmemleak_lock to protect __find_and_remove_object() and
__link_object() as a whole, which can guarantee all objects are
processed sequentialally.

Fixes: 53238a60dd4a ("kmemleak: Allow partial freeing of memory blocks")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c9125c18956..a956b2734324 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -816,16 +816,25 @@ static void delete_object_full(unsigned long ptr)
  */
 static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 {
-	struct kmemleak_object *object;
-	unsigned long start, end;
+	struct kmemleak_object *object, *object_l, *object_r;
+	unsigned long start, end, flags;
+
+	object_l = __alloc_object(GFP_KERNEL);
+	if (!object_l)
+		return;
 
-	object = find_and_remove_object(ptr, 1, is_phys);
+	object_r = __alloc_object(GFP_KERNEL);
+	if (!object_r)
+		goto out;
+
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
+	object = __find_and_remove_object(ptr, 1, is_phys);
 	if (!object) {
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
 			      ptr, size);
 #endif
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -835,14 +844,25 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
 	 */
 	start = object->pointer;
 	end = object->pointer + object->size;
-	if (ptr > start)
-		__create_object(start, ptr - start, object->min_count,
-			      GFP_KERNEL, is_phys);
-	if (ptr + size < end)
-		__create_object(ptr + size, end - ptr - size, object->min_count,
-			      GFP_KERNEL, is_phys);
+	if ((ptr > start) &&
+	    !__link_object(object_l, start, ptr - start,
+			   object->min_count, is_phys))
+		object_l = NULL;
+	if ((ptr + size < end) &&
+	    !__link_object(object_r, ptr + size, end - ptr - size,
+			   object->min_count, is_phys))
+		object_r = NULL;
+
+unlock:
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (object)
+		__delete_object(object);
 
-	__delete_object(object);
+out:
+	if (object_l)
+		mem_pool_free(object_l);
+	if (object_r)
+		mem_pool_free(object_r);
 }
 
 static void __paint_it(struct kmemleak_object *object, int color)
-- 
2.25.1

