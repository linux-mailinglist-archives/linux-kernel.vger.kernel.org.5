Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E207546D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGOEYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGOEYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:24:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582735AB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7FLmcjaPLpEGscatrzN5qp/wg/vDvmkauQ9Fg4Em8sE=; b=iY960qup3GgE02Qc8hTQi0rsqK
        1ig2TdspYQRUVHvoQt0nYZglzQb8SzK09LJYGooF+YhYJNMDQfkdNavbCcUqjtON2iqPn2rTz8wvB
        7KuwGjoADJqAgCESw9WNyWlZIgqcucnRFkF9WP9FiDf4+JvcqeDxSDFmo7AC3nsFFvRkrzZONP3//
        KTyRt7nwOQkqoKa1gdOzKn7fWbA15RC45913fcCB6Rm2VvPZzeoyj2Zw6Ao44b2+uHnoijdO9txwe
        uSbSfquHsw7enKXdBl8oSCYKtQFN5vU2Ve9v1r3lr+yC+tFwCpMLrh4Lia4dF0C1WlSJJY7Ep1D5w
        8PnT856A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3s-GU; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 3/5] memcg: Convert get_obj_cgroup_from_page to get_obj_cgroup_from_folio
Date:   Sat, 15 Jul 2023 05:23:41 +0100
Message-Id: <20230715042343.434588-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230715042343.434588-1-willy@infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <20230715042343.434588-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the one caller now has a folio, pass it in and use it.  Removes three
calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/memcontrol.h | 4 ++--
 mm/memcontrol.c            | 8 ++++----
 mm/zswap.c                 | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..7b676752f474 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1761,7 +1761,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
 
 struct obj_cgroup *get_obj_cgroup_from_current(void);
-struct obj_cgroup *get_obj_cgroup_from_page(struct page *page);
+struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio);
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
 void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
@@ -1845,7 +1845,7 @@ static inline void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 }
 
-static inline struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
+static inline struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	return NULL;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..acc9acb0c9a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3036,21 +3036,21 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	return objcg;
 }
 
-struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
+struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	struct obj_cgroup *objcg;
 
 	if (!memcg_kmem_online())
 		return NULL;
 
-	if (PageMemcgKmem(page)) {
-		objcg = __folio_objcg(page_folio(page));
+	if (folio_memcg_kmem(folio)) {
+		objcg = __folio_objcg(folio);
 		obj_cgroup_get(objcg);
 	} else {
 		struct mem_cgroup *memcg;
 
 		rcu_read_lock();
-		memcg = __folio_memcg(page_folio(page));
+		memcg = __folio_memcg(folio);
 		if (memcg)
 			objcg = __get_obj_cgroup_from_memcg(memcg);
 		else
diff --git a/mm/zswap.c b/mm/zswap.c
index ba50b186ee27..69d097d14255 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1235,7 +1235,7 @@ bool zswap_store(struct folio *folio)
 	 * cgroup-aware entry LRU, we will push out entries system-wide based on
 	 * local cgroup limits.
 	 */
-	objcg = get_obj_cgroup_from_page(page);
+	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg))
 		goto reject;
 
-- 
2.39.2

