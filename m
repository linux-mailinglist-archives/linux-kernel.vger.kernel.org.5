Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1DA7CD802
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJRJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjJRJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:25 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2A9B0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:22 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9QVd0ZRSz15Nh8;
        Wed, 18 Oct 2023 17:27:37 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:30:19 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v3 4/7] mm: kmemleak: split __create_object into two functions
Date:   Wed, 18 Oct 2023 18:29:49 +0800
Message-ID: <20231018102952.3339837-5-liushixin2@huawei.com>
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

__create_object() consists of two part, the first part allocate a
kmemleak object and initialize it, the second part insert it into
object tree. This function need kmemleak_lock but actually only the
second part need lock.

Split it into two functions, the first function __alloc_object only
allocate a kmemleak object, and the second function __link_object()
will initialize the object and insert it into object tree, use the
kmemleak_lock to protect __link_object() only.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 61 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 289b3be5ee6e..064fc3695c6b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -623,25 +623,15 @@ static noinline depot_stack_handle_t set_track_prepare(void)
 	return trace_handle;
 }
 
-/*
- * Create the metadata (struct kmemleak_object) corresponding to an allocated
- * memory block and add it to the object_list and object_tree_root (or
- * object_phys_tree_root).
- */
-static void __create_object(unsigned long ptr, size_t size,
-			    int min_count, gfp_t gfp, bool is_phys)
+static struct kmemleak_object * __alloc_object(gfp_t gfp)
 {
-	unsigned long flags;
-	struct kmemleak_object *object, *parent;
-	struct rb_node **link, *rb_parent;
-	unsigned long untagged_ptr;
-	unsigned long untagged_objp;
+	struct kmemleak_object *object;
 
 	object = mem_pool_alloc(gfp);
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-		return;
+		return NULL;
 	}
 
 	INIT_LIST_HEAD(&object->object_list);
@@ -649,13 +639,8 @@ static void __create_object(unsigned long ptr, size_t size,
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
-	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
-	object->pointer = ptr;
-	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
-	object->min_count = min_count;
 	object->count = 0;			/* white color initially */
-	object->jiffies = jiffies;
 	object->checksum = 0;
 	object->del_state = 0;
 
@@ -680,7 +665,23 @@ static void __create_object(unsigned long ptr, size_t size,
 	/* kernel backtrace */
 	object->trace_handle = set_track_prepare();
 
-	raw_spin_lock_irqsave(&kmemleak_lock, flags);
+	return object;
+}
+
+static void __link_object(struct kmemleak_object *object, unsigned long ptr,
+			  size_t size, int min_count, bool is_phys)
+{
+
+	struct kmemleak_object *parent;
+	struct rb_node **link, *rb_parent;
+	unsigned long untagged_ptr;
+	unsigned long untagged_objp;
+
+	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
+	object->pointer = ptr;
+	object->size = kfence_ksize((void *)ptr) ?: size;
+	object->min_count = min_count;
+	object->jiffies = jiffies;
 
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	/*
@@ -711,14 +712,32 @@ static void __create_object(unsigned long ptr, size_t size,
 			 */
 			dump_object_info(parent);
 			kmem_cache_free(object_cache, object);
-			goto out;
+			return;
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
 					  &object_tree_root);
 	list_add_tail_rcu(&object->object_list, &object_list);
-out:
+}
+
+/*
+ * Create the metadata (struct kmemleak_object) corresponding to an allocated
+ * memory block and add it to the object_list and object_tree_root (or
+ * object_phys_tree_root).
+ */
+static void __create_object(unsigned long ptr, size_t size,
+				int min_count, gfp_t gfp, bool is_phys)
+{
+	struct kmemleak_object *object;
+	unsigned long flags;
+
+	object = __alloc_object(gfp);
+	if (!object)
+		return;
+
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
+	__link_object(object, ptr, size, min_count, is_phys);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
-- 
2.25.1

