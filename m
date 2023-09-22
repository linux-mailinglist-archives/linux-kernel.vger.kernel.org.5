Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945557AAF23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjIVKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbjIVKIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:08:09 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D3CE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:08:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vsd76ZS_1695377268;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vsd76ZS_1695377268)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 18:07:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm/list_lru: Remove unused function
Date:   Fri, 22 Sep 2023 18:07:47 +0800
Message-Id: <20230922100747.17045-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function are defined in the list_lru.c file, but not called
elsewhere, so delete the unused function.

mm/list_lru.c:64:1: warning: unused function 'list_lru_from_kmem'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6677
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/list_lru.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 37c5c2ef6c0e..800f171d2c23 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -60,27 +60,6 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	return &lru->node[nid].lru;
 }
 
-static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
-		   struct mem_cgroup **memcg_ptr)
-{
-	struct list_lru_node *nlru = &lru->node[nid];
-	struct list_lru_one *l = &nlru->lru;
-	struct mem_cgroup *memcg = NULL;
-
-	if (!list_lru_memcg_aware(lru))
-		goto out;
-
-	memcg = mem_cgroup_from_slab_obj(ptr);
-	if (!memcg)
-		goto out;
-
-	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
-out:
-	if (memcg_ptr)
-		*memcg_ptr = memcg;
-	return l;
-}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -105,15 +84,6 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 {
 	return &lru->node[nid].lru;
 }
-
-static inline struct list_lru_one *
-list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
-		   struct mem_cgroup **memcg_ptr)
-{
-	if (memcg_ptr)
-		*memcg_ptr = NULL;
-	return &lru->node[nid].lru;
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
-- 
2.20.1.7.g153144c

