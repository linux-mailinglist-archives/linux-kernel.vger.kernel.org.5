Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0267D2825
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJWBwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjJWBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:52:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF1DF7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:51:57 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SDJ5G2fmzzrTMY;
        Mon, 23 Oct 2023 09:49:06 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 23 Oct
 2023 09:51:55 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Patrick Wang <patrick.wang.shcn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] mm/kmemleak: move the initialisation of object to __link_object
Date:   Mon, 23 Oct 2023 10:51:25 +0800
Message-ID: <20231023025125.90972-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Leave __alloc_object() just do the actual allocation and __link_object()
do the full initialisation.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a956b2734324..f51544a682de 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -642,16 +642,32 @@ static struct kmemleak_object * __alloc_object(gfp_t gfp)
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-		return NULL;
 	}
 
+	return object;
+}
+
+static int __link_object(struct kmemleak_object *object, unsigned long ptr,
+			 size_t size, int min_count, bool is_phys)
+{
+
+	struct kmemleak_object *parent;
+	struct rb_node **link, *rb_parent;
+	unsigned long untagged_ptr;
+	unsigned long untagged_objp;
+
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
 	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
+	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
+	object->pointer = ptr;
+	object->size = kfence_ksize((void *)ptr) ?: size;
 	object->excess_ref = 0;
+	object->min_count = min_count;
 	object->count = 0;			/* white color initially */
+	object->jiffies = jiffies;
 	object->checksum = 0;
 	object->del_state = 0;
 
@@ -676,24 +692,6 @@ static struct kmemleak_object * __alloc_object(gfp_t gfp)
 	/* kernel backtrace */
 	object->trace_handle = set_track_prepare();
 
-	return object;
-}
-
-static int __link_object(struct kmemleak_object *object, unsigned long ptr,
-			 size_t size, int min_count, bool is_phys)
-{
-
-	struct kmemleak_object *parent;
-	struct rb_node **link, *rb_parent;
-	unsigned long untagged_ptr;
-	unsigned long untagged_objp;
-
-	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
-	object->pointer = ptr;
-	object->size = kfence_ksize((void *)ptr) ?: size;
-	object->min_count = min_count;
-	object->jiffies = jiffies;
-
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	/*
 	 * Only update min_addr and max_addr with object
-- 
2.25.1

