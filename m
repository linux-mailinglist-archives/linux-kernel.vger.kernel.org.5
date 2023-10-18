Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2C7CD804
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjJRJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:30:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE8106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:30:22 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9QVd1WMDzrTTM;
        Wed, 18 Oct 2023 17:27:37 +0800 (CST)
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
Subject: [PATCH v3 6/7] mm: kmemleak: add __find_and_remove_object()
Date:   Wed, 18 Oct 2023 18:29:51 +0800
Message-ID: <20231018102952.3339837-7-liushixin2@huawei.com>
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

Add new __find_and_remove_object() without kmemleak_lock protect, it is
in preparation for the next patch.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index ea34986c02b4..7c9125c18956 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -583,6 +583,19 @@ static void __remove_object(struct kmemleak_object *object)
 	object->del_state |= DELSTATE_REMOVED;
 }
 
+static struct kmemleak_object *__find_and_remove_object(unsigned long ptr,
+							int alias,
+							bool is_phys)
+{
+	struct kmemleak_object *object;
+
+	object = __lookup_object(ptr, alias, is_phys);
+	if (object)
+		__remove_object(object);
+
+	return object;
+}
+
 /*
  * Look up an object in the object search tree and remove it from both
  * object_tree_root (or object_phys_tree_root) and object_list. The
@@ -596,9 +609,7 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	struct kmemleak_object *object;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
-	object = __lookup_object(ptr, alias, is_phys);
-	if (object)
-		__remove_object(object);
+	object = __find_and_remove_object(ptr, alias, is_phys);
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
-- 
2.25.1

