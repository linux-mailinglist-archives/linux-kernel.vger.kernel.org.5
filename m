Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086D7AAD9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjIVJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjIVJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:15:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A418F;
        Fri, 22 Sep 2023 02:15:09 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RsRPl0jHJz15NQm;
        Fri, 22 Sep 2023 17:12:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:15:07 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v10 4/6] page_pool: introduce page_pool[_cache]_alloc() API
Date:   Fri, 22 Sep 2023 17:11:36 +0800
Message-ID: <20230922091138.18014-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230922091138.18014-1-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently page pool supports the below use cases:
use case 1: allocate page without page splitting using
            page_pool_alloc_pages() API if the driver knows
            that the memory it need is always bigger than
            half of the page allocated from page pool.
use case 2: allocate page frag with page splitting using
            page_pool_alloc_frag() API if the driver knows
            that the memory it need is always smaller than
            or equal to the half of the page allocated from
            page pool.

There is emerging use case [1] & [2] that is a mix of the
above two case: the driver doesn't know the size of memory it
need beforehand, so the driver may use something like below to
allocate memory with least memory utilization and performance
penalty:

if (size << 1 > max_size)
	page = page_pool_alloc_pages();
else
	page = page_pool_alloc_frag();

To avoid the driver doing something like above, add the
page_pool[_cache]_alloc() API to support the above use case,
and update the true size of memory that is acctually allocated
by updating '*size' back to the driver in order to avoid
exacerbating truesize underestimate problem.

Rename page_pool_free() which is used in the destroy process to
__page_pool_destroy() to avoid confusion with the newly added
API.

1. https://lore.kernel.org/all/d3ae6bd3537fbce379382ac6a42f67e22f27ece2.1683896626.git.lorenzo@kernel.org/
2. https://lore.kernel.org/all/20230526054621.18371-3-liangchen.linux@gmail.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 65 +++++++++++++++++++++++++++++++++
 net/core/page_pool.c            |  4 +-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 0228b433bc45..251c075084b8 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -82,6 +82,65 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+	struct page *page;
+
+	if ((*size << 1) > max_size) {
+		*size = max_size;
+		*offset = 0;
+		return page_pool_alloc_pages(pool, gfp);
+	}
+
+	page = page_pool_alloc_frag(pool, offset, *size, gfp);
+	if (unlikely(!page))
+		return NULL;
+
+	/* There is very likely not enough space for another fragment, so append
+	 * the remaining size to the current fragment to avoid truesize
+	 * underestimate problem.
+	 */
+	if (pool->frag_offset + *size > max_size) {
+		*size = max_size - *offset;
+		pool->frag_offset = max_size;
+	}
+
+	return page;
+}
+
+static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
+					       unsigned int *offset,
+					       unsigned int *size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_alloc(pool, offset, size, gfp);
+}
+
+static inline void *page_pool_cache_alloc(struct page_pool *pool,
+					  unsigned int *size, gfp_t gfp)
+{
+	unsigned int offset;
+	struct page *page;
+
+	page = page_pool_alloc(pool, &offset, size, gfp);
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page) + offset;
+}
+
+static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
+					      unsigned int *size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_cache_alloc(pool, size, gfp);
+}
+
 /**
  * page_pool_get_dma_dir() - Retrieve the stored DMA direction.
  * @pool:	pool from which page was allocated
@@ -221,6 +280,12 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
 		(sizeof(dma_addr_t) > sizeof(unsigned long))
 
+static inline void page_pool_cache_free(struct page_pool *pool, void *data,
+					bool allow_direct)
+{
+	page_pool_put_page(pool, virt_to_head_page(data), -1, allow_direct);
+}
+
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 2a3671c97ca7..5e409b98aba0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -809,7 +809,7 @@ static void page_pool_empty_ring(struct page_pool *pool)
 	}
 }
 
-static void page_pool_free(struct page_pool *pool)
+static void __page_pool_destroy(struct page_pool *pool)
 {
 	if (pool->disconnect)
 		pool->disconnect(pool);
@@ -860,7 +860,7 @@ static int page_pool_release(struct page_pool *pool)
 	page_pool_scrub(pool);
 	inflight = page_pool_inflight(pool);
 	if (!inflight)
-		page_pool_free(pool);
+		__page_pool_destroy(pool);
 
 	return inflight;
 }
-- 
2.33.0

