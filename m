Return-Path: <linux-kernel+bounces-134400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA1589B106
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD8B2817B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1E3BB23;
	Sun,  7 Apr 2024 13:11:08 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0F3A267;
	Sun,  7 Apr 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495467; cv=none; b=DmZOEepeOniX5w8lTBHyjUMrH/I3E3DaIKNApoWIcnil4867UdkzcSKMoGAzxr/fJx2a50beHixXp1CFHDMn+jylEbOS5XOVzgoHafjDhxPXjs4G1qqguvAqCI3Xgh8/KfCQc9kPVbt6rMjc0TPMgEN62Tvi7/2EPLbqGq11tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495467; c=relaxed/simple;
	bh=AnePHUh3T6UCcCAQ+5WxCR2SiVsSzk+IcmWCs8HWTWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYFhYluQdH1daOvmpsFAvixyTWZ50+NJGhtqkRPh+vi3X3wYIW4TDErLmcTbTF+S1eHFLDjYabne7tuVuJbMk8Fdm8GET2CqloTjS4YKV/zHyZiMP+SLcthzAcmcLbMqivJ/qOeotD8mPKA8ThUbfi+64vN0qxE0eNED3TNT66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VCCGT43NLz1ym6R;
	Sun,  7 Apr 2024 21:08:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C8211A0172;
	Sun,  7 Apr 2024 21:11:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 21:11:01 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, <linux-mm@kvack.org>,
	<linux-afs@lists.infradead.org>
Subject: [PATCH net-next v1 03/12] mm: page_frag: change page_frag_alloc_* API to accept align param
Date: Sun, 7 Apr 2024 21:08:40 +0800
Message-ID: <20240407130850.19625-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240407130850.19625-1-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

When page_frag_alloc_* API doesn't need data alignment, the
ALIGN() operation is unnecessary, so change page_frag_alloc_*
API to accept align param instead of align_mask param, and do
the ALIGN()'ing in the inline helper when needed.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 20 ++++++++++++--------
 include/linux/skbuff.h          | 12 ++++++------
 mm/page_frag_cache.c            |  9 ++++-----
 net/core/skbuff.c               | 12 +++++-------
 net/rxrpc/txbuf.c               |  5 +++--
 5 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 04810d8d6a7d..cc0ede0912f3 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -25,21 +25,25 @@ struct page_frag_cache {
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
-			      gfp_t gfp_mask, unsigned int align_mask);
+void *page_frag_alloc(struct page_frag_cache *nc, unsigned int fragsz,
+		      gfp_t gfp_mask);
+
+static inline void *__page_frag_alloc_align(struct page_frag_cache *nc,
+					    unsigned int fragsz, gfp_t gfp_mask,
+					    unsigned int align)
+{
+	nc->offset = ALIGN(nc->offset, align);
+
+	return page_frag_alloc(nc, fragsz, gfp_mask);
+}
 
 static inline void *page_frag_alloc_align(struct page_frag_cache *nc,
 					  unsigned int fragsz, gfp_t gfp_mask,
 					  unsigned int align)
 {
 	WARN_ON_ONCE(!is_power_of_2(align));
-	return __page_frag_alloc_align(nc, fragsz, gfp_mask, -align);
-}
 
-static inline void *page_frag_alloc(struct page_frag_cache *nc,
-				    unsigned int fragsz, gfp_t gfp_mask)
-{
-	return page_frag_alloc_align(nc, fragsz, gfp_mask, ~0u);
+	return __page_frag_alloc_align(nc, fragsz, gfp_mask, align);
 }
 
 void page_frag_free(void *addr);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 76c5be5b1a8c..2ef14dde5bbc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3268,7 +3268,7 @@ static inline void skb_queue_purge(struct sk_buff_head *list)
 unsigned int skb_rbtree_purge(struct rb_root *root);
 void skb_errqueue_purge(struct sk_buff_head *list);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 /**
  * netdev_alloc_frag - allocate a page fragment
@@ -3279,14 +3279,14 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
  */
 static inline void *netdev_alloc_frag(unsigned int fragsz)
 {
-	return __netdev_alloc_frag_align(fragsz, ~0u);
+	return __netdev_alloc_frag_align(fragsz, 1u);
 }
 
 static inline void *netdev_alloc_frag_align(unsigned int fragsz,
 					    unsigned int align)
 {
 	WARN_ON_ONCE(!is_power_of_2(align));
-	return __netdev_alloc_frag_align(fragsz, -align);
+	return __netdev_alloc_frag_align(fragsz, align);
 }
 
 struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int length,
@@ -3346,18 +3346,18 @@ static inline void skb_free_frag(void *addr)
 	page_frag_free(addr);
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask);
+void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align);
 
 static inline void *napi_alloc_frag(unsigned int fragsz)
 {
-	return __napi_alloc_frag_align(fragsz, ~0u);
+	return __napi_alloc_frag_align(fragsz, 1u);
 }
 
 static inline void *napi_alloc_frag_align(unsigned int fragsz,
 					  unsigned int align)
 {
 	WARN_ON_ONCE(!is_power_of_2(align));
-	return __napi_alloc_frag_align(fragsz, -align);
+	return __napi_alloc_frag_align(fragsz, align);
 }
 
 struct sk_buff *napi_alloc_skb(struct napi_struct *napi, unsigned int length);
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 3e3e88d9af90..39c744c892ed 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -63,9 +63,8 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *__page_frag_alloc_align(struct page_frag_cache *nc,
-			      unsigned int fragsz, gfp_t gfp_mask,
-			      unsigned int align_mask)
+void *page_frag_alloc(struct page_frag_cache *nc, unsigned int fragsz,
+		      gfp_t gfp_mask)
 {
 	unsigned int size, offset;
 	struct page *page;
@@ -94,7 +93,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	size = PAGE_SIZE;
 #endif
 
-	offset = ALIGN(nc->offset, -align_mask);
+	offset = nc->offset;
 	if (unlikely(offset + fragsz > size)) {
 		page = virt_to_page(nc->va);
 
@@ -131,7 +130,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 
 	return nc->va + offset;
 }
-EXPORT_SYMBOL(__page_frag_alloc_align);
+EXPORT_SYMBOL(page_frag_alloc);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2a5ce6667bbb..e5196c284b33 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -305,18 +305,17 @@ void napi_get_frags_check(struct napi_struct *napi)
 	local_bh_enable();
 }
 
-void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 
 	fragsz = SKB_DATA_ALIGN(fragsz);
 
-	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-				       align_mask);
+	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align);
 }
 EXPORT_SYMBOL(__napi_alloc_frag_align);
 
-void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
+void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
 	void *data;
 
@@ -324,15 +323,14 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
 	if (in_hardirq() || irqs_disabled()) {
 		struct page_frag_cache *nc = this_cpu_ptr(&netdev_alloc_cache);
 
-		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC,
-					       align_mask);
+		data = __page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align);
 	} else {
 		struct napi_alloc_cache *nc;
 
 		local_bh_disable();
 		nc = this_cpu_ptr(&napi_alloc_cache);
 		data = __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
-					       align_mask);
+					       align);
 		local_bh_enable();
 	}
 	return data;
diff --git a/net/rxrpc/txbuf.c b/net/rxrpc/txbuf.c
index e0679658d9de..eb640875bf07 100644
--- a/net/rxrpc/txbuf.c
+++ b/net/rxrpc/txbuf.c
@@ -32,9 +32,10 @@ struct rxrpc_txbuf *rxrpc_alloc_data_txbuf(struct rxrpc_call *call, size_t data_
 		hoff = round_up(sizeof(*whdr), data_align) - sizeof(*whdr);
 	total = hoff + sizeof(*whdr) + data_size;
 
+	data_align = max_t(size_t, data_align, L1_CACHE_BYTES);
 	mutex_lock(&call->conn->tx_data_alloc_lock);
-	buf = __page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
-				      ~(data_align - 1) & ~(L1_CACHE_BYTES - 1));
+	buf = page_frag_alloc_align(&call->conn->tx_data_alloc, total, gfp,
+				    data_align);
 	mutex_unlock(&call->conn->tx_data_alloc_lock);
 	if (!buf) {
 		kfree(txb);
-- 
2.33.0


