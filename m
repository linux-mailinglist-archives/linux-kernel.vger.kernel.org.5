Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E77CD80F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjJRJaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjJRJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F92FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:24 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9QTW6l4szRt63;
        Wed, 18 Oct 2023 17:26:39 +0800 (CST)
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
Subject: [PATCH v3 5/7] mm: kmemleak: use mem_pool_free() to free object
Date:   Wed, 18 Oct 2023 18:29:50 +0800
Message-ID: <20231018102952.3339837-6-liushixin2@huawei.com>
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

The kmemleak object is allocated by mem_pool_alloc(), which
could be from slab or mem_pool[], so it's not suitable using
__kmem_cache_free() to free the object, use __mem_pool_free()
instead.

Fixes: 0647398a8c7b ("mm: kmemleak: simple memory allocation pool for kmemleak objects")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 064fc3695c6b..ea34986c02b4 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -668,8 +668,8 @@ static struct kmemleak_object * __alloc_object(gfp_t gfp)
 	return object;
 }
 
-static void __link_object(struct kmemleak_object *object, unsigned long ptr,
-			  size_t size, int min_count, bool is_phys)
+static int __link_object(struct kmemleak_object *object, unsigned long ptr,
+			 size_t size, int min_count, bool is_phys)
 {
 
 	struct kmemleak_object *parent;
@@ -711,14 +711,15 @@ static void __link_object(struct kmemleak_object *object, unsigned long ptr,
 			 * be freed while the kmemleak_lock is held.
 			 */
 			dump_object_info(parent);
-			kmem_cache_free(object_cache, object);
-			return;
+			return -EEXIST;
 		}
 	}
 	rb_link_node(&object->rb_node, rb_parent, link);
 	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
 					  &object_tree_root);
 	list_add_tail_rcu(&object->object_list, &object_list);
+
+	return 0;
 }
 
 /*
@@ -731,14 +732,17 @@ static void __create_object(unsigned long ptr, size_t size,
 {
 	struct kmemleak_object *object;
 	unsigned long flags;
+	int ret;
 
 	object = __alloc_object(gfp);
 	if (!object)
 		return;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	__link_object(object, ptr, size, min_count, is_phys);
+	ret = __link_object(object, ptr, size, min_count, is_phys);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (ret)
+		mem_pool_free(object);
 }
 
 /* Create kmemleak object which allocated with virtual address. */
-- 
2.25.1

