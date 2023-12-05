Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8703805307
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbjLELfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347022AbjLELex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:34:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE9D42;
        Tue,  5 Dec 2023 03:34:52 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SkyxY2tr3z14L6L;
        Tue,  5 Dec 2023 19:29:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 19:34:50 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, <linux-mm@kvack.org>
Subject: [PATCH net-next 1/6] mm/page_alloc: modify page_frag_alloc_align() to accept align as an argument
Date:   Tue, 5 Dec 2023 19:34:39 +0800
Message-ID: <20231205113444.63015-2-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231205113444.63015-1-linyunsheng@huawei.com>
References: <20231205113444.63015-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

napi_alloc_frag_align() and netdev_alloc_frag_align() accept
align as an argument, and they are thin wrappers around the
__napi_alloc_frag_align() and __netdev_alloc_frag_align() APIs
doing the align and align_mask conversion, in order to call
page_frag_alloc_align() directly.

As __napi_alloc_frag_align() and __netdev_alloc_frag_align()
APIs are only used by the above thin wrappers, it seems that
it makes more sense to remove align and align_mask conversion
and call page_frag_alloc_align() directly. By doing that, we
can also avoid the confusion between napi_alloc_frag_align()
accepting align as an argument and page_frag_alloc_align()
accepting align_mask as an argument when they both have the
'align' suffix.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
---
 include/linux/gfp.h    |  4 ++--
 include/linux/skbuff.h | 22 ++++------------------
 mm/page_alloc.c        |  6 ++++--
 net/core/skbuff.c      | 14 +++++++-------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..bbd75976541e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -314,12 +314,12 @@ struct page_frag_cache;
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
 extern void *page_frag_alloc_align(struct page_frag_cache *nc,
 				   unsigned int fragsz, gfp_t gfp_mask,
-				   unsigned int align_mask);
+				   unsigned int align);
 
 static inline void *page_frag_alloc(struct page_frag_cache *nc,
 			     unsigned int fragsz, gfp_t gfp_mask)
 {
-	return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return page_frag_alloc_align(nc, fragsz, gfp_mask, 1);
 }
 
 extern void page_frag_free(void *addr);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b370eb8d70f7..095747c500b6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3194,7 +3194,7 @@ static inline void skb_queue_purge(struct sk_buff_head *list)
 unsigned int skb_rbtree_purge(struct rb_root *root);
 void skb_errqueue_purge(struct sk_buff_head *list);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *netdev_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 /**
  * netdev_alloc_frag - allocate a page fragment
@@ -3205,14 +3205,7 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
  */
 static inline void *netdev_alloc_frag(unsigned int fragsz)
 {
-	return __netdev_alloc_frag_align(fragsz, ~0u);
-}
-
-static inline void *netdev_alloc_frag_align(unsigned int fragsz,
-					    unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __netdev_alloc_frag_align(fragsz, -align);
+	return netdev_alloc_frag_align(fragsz, 1);
 }
 
 struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int length,
@@ -3272,18 +3265,11 @@ static inline void skb_free_frag(void *addr)
 	page_frag_free(addr);
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *napi_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 static inline void *napi_alloc_frag(unsigned int fragsz)
 {
-	return __napi_alloc_frag_align(fragsz, ~0u);
-}
-
-static inline void *napi_alloc_frag_align(unsigned int fragsz,
-					  unsigned int align)
-{
-	WARN_ON_ONCE(!is_power_of_2(align));
-	return __napi_alloc_frag_align(fragsz, -align);
+	return napi_alloc_frag_align(fragsz, 1);
 }
 
 struct sk_buff *__napi_alloc_skb(struct napi_struct *napi,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 37ca4f4b62bf..9a16305cf985 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4718,12 +4718,14 @@ EXPORT_SYMBOL(__page_frag_cache_drain);
 
 void *page_frag_alloc_align(struct page_frag_cache *nc,
 		      unsigned int fragsz, gfp_t gfp_mask,
-		      unsigned int align_mask)
+		      unsigned int align)
 {
 	unsigned int size = PAGE_SIZE;
 	struct page *page;
 	int offset;
 
+	WARN_ON_ONCE(!is_power_of_2(align));
+
 	if (unlikely(!nc->va)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
@@ -4782,7 +4784,7 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
+	offset &= -align;
 	nc->offset = offset;
 
 	return nc->va + offset;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..b98d1da4004a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -291,17 +291,17 @@ void napi_get_frags_check(struct napi_struct *napi)
 	local_bh_enable();
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
-	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+	return page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align);
 }
-EXPORT_SYMBOL(__napi_alloc_frag_align);
+EXPORT_SYMBOL(napi_alloc_frag_align);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	void *data;
 
@@ -309,18 +309,18 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
-		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align);
 	} else {
 		struct napi_alloc_cache *nc;
 
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache);
-		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask);
+		data = page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align);
 		local_bh_enable();
 	}
 	return data;
 }
-EXPORT_SYMBOL(__netdev_alloc_frag_align);
+EXPORT_SYMBOL(netdev_alloc_frag_align);
 
 static struct sk_buff *napi_skb_cache_get(void)
 {
-- 
2.33.0

