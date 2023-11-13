Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A97E9CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjKMNA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjKMNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:00:43 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA91981;
        Mon, 13 Nov 2023 05:00:36 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STTzy2H7vzWhL1;
        Mon, 13 Nov 2023 21:00:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:34 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mina Almasry <almasrymina@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Date:   Mon, 13 Nov 2023 21:00:35 +0800
Message-ID: <20231113130041.58124-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231113130041.58124-1-linyunsheng@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mina Almasry <almasrymina@google.com>

Implement a memory provider that allocates dmabuf devmem page_pool_iovs.

Support of PP_FLAG_DMA_MAP and PP_FLAG_DMA_SYNC_DEV is omitted for
simplicity.

The provider receives a reference to the struct netdev_dmabuf_binding
via the pool->mp_priv pointer. The driver needs to set this pointer for
the provider in the page_pool_params.

The provider obtains a reference on the netdev_dmabuf_binding which
guarantees the binding and the underlying mapping remains alive until
the provider is destroyed.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h | 28 +++++++++++
 net/core/page_pool.c          | 93 +++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5e4fcd45ba50..52e4cf98ebc6 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -124,6 +124,7 @@ struct mem_provider;
 
 enum pp_memory_provider_type {
 	__PP_MP_NONE, /* Use system allocator directly */
+	PP_MP_DMABUF_DEVMEM, /* dmabuf devmem provider */
 };
 
 struct pp_memory_provider_ops {
@@ -134,6 +135,33 @@ struct pp_memory_provider_ops {
 	void (*free_pages)(struct page_pool *pool, struct page *page);
 };
 
+extern const struct pp_memory_provider_ops dmabuf_devmem_ops;
+
+struct page_pool_iov {
+	unsigned long res0;
+	unsigned long pp_magic;
+	struct page_pool *pp;
+	struct page *page;  /* dmabuf memory provider specific field */
+	unsigned long dma_addr;
+	atomic_long_t pp_frag_count;
+	unsigned int res1;
+	refcount_t _refcount;
+};
+
+#define PAGE_POOL_MATCH(pg, iov)				\
+	static_assert(offsetof(struct page, pg) ==		\
+		      offsetof(struct page_pool_iov, iov))
+PAGE_POOL_MATCH(flags, res0);
+PAGE_POOL_MATCH(pp_magic, pp_magic);
+PAGE_POOL_MATCH(pp, pp);
+PAGE_POOL_MATCH(_pp_mapping_pad, page);
+PAGE_POOL_MATCH(dma_addr, dma_addr);
+PAGE_POOL_MATCH(pp_frag_count, pp_frag_count);
+PAGE_POOL_MATCH(_mapcount, res1);
+PAGE_POOL_MATCH(_refcount, _refcount);
+#undef PAGE_POOL_MATCH
+static_assert(sizeof(struct page_pool_iov) <= sizeof(struct page));
+
 struct page_pool {
 	struct page_pool_params p;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6c502bea842b..1bd7a2306f09 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -231,6 +231,9 @@ static int page_pool_init(struct page_pool *pool,
 	switch (pool->p.memory_provider) {
 	case __PP_MP_NONE:
 		break;
+	case PP_MP_DMABUF_DEVMEM:
+		pool->mp_ops = &dmabuf_devmem_ops;
+		break;
 	default:
 		err = -EINVAL;
 		goto free_ptr_ring;
@@ -1010,3 +1013,93 @@ void page_pool_update_nid(struct page_pool *pool, int new_nid)
 	}
 }
 EXPORT_SYMBOL(page_pool_update_nid);
+
+/*** "Dmabuf devmem memory provider" ***/
+
+static int mp_dmabuf_devmem_init(struct page_pool *pool)
+{
+	if (pool->p.flags & PP_FLAG_DMA_MAP ||
+	    pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static struct page *mp_dmabuf_devmem_alloc_pages(struct page_pool *pool,
+						 gfp_t gfp)
+{
+	struct page_pool_iov *ppiov;
+	struct page *page;
+	dma_addr_t dma;
+
+	ppiov = kvmalloc(sizeof(*ppiov), gfp | __GFP_ZERO);
+	if (!ppiov)
+		return NULL;
+
+	page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
+	if (!page) {
+		kvfree(ppiov);
+		return NULL;
+	}
+
+	dma = dma_map_page_attrs(pool->p.dev, page, 0,
+				 (PAGE_SIZE << pool->p.order),
+				 pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC |
+						  DMA_ATTR_WEAK_ORDERING);
+	if (dma_mapping_error(pool->p.dev, dma)) {
+		put_page(page);
+		kvfree(ppiov);
+		return NULL;
+	}
+
+	ppiov->pp = pool;
+	ppiov->pp_magic = PP_SIGNATURE;
+	ppiov->page = page;
+	refcount_set(&ppiov->_refcount, 1);
+	page_pool_fragment_page((struct page *)ppiov, 1);
+	page_pool_set_dma_addr((struct page *)ppiov, dma);
+	pool->pages_state_hold_cnt++;
+	trace_page_pool_state_hold(pool, (struct page *)ppiov,
+				   pool->pages_state_hold_cnt);
+	return (struct page *)ppiov;
+}
+
+static void mp_dmabuf_devmem_destroy(struct page_pool *pool)
+{
+}
+
+static void mp_dmabuf_devmem_release_page(struct page_pool *pool,
+					  struct page *page)
+{
+	struct page_pool_iov *ppiov = (struct page_pool_iov *)page;
+	dma_addr_t dma;
+
+	dma = page_pool_get_dma_addr(page);
+
+	/* When page is unmapped, it cannot be returned to our pool */
+	dma_unmap_page_attrs(pool->p.dev, dma,
+			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
+			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	page_pool_set_dma_addr(page, 0);
+
+	put_page(ppiov->page);
+}
+
+static void mp_dmabuf_devmem_free_pages(struct page_pool *pool,
+					struct page *page)
+{
+	int count;
+
+	count = atomic_inc_return_relaxed(&pool->pages_state_release_cnt);
+	trace_page_pool_state_release(pool, page, count);
+
+	kvfree(page);
+}
+
+const struct pp_memory_provider_ops dmabuf_devmem_ops = {
+	.init			= mp_dmabuf_devmem_init,
+	.destroy		= mp_dmabuf_devmem_destroy,
+	.alloc_pages		= mp_dmabuf_devmem_alloc_pages,
+	.release_page		= mp_dmabuf_devmem_release_page,
+	.free_pages		= mp_dmabuf_devmem_free_pages,
+};
+EXPORT_SYMBOL(dmabuf_devmem_ops);
-- 
2.33.0

