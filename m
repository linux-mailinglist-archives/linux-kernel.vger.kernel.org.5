Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CE7F782E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbjKXPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbjKXPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:50:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CBE1BDC;
        Fri, 24 Nov 2023 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700841012; x=1732377012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KtbQTdoYeZ6gJSB+BVtjf6MKUSnOW4lJjO7eZ1Wqeh8=;
  b=giAjRbuzHnhkAJP3LGeDcR1KTyxhxzpXTIK78ZY5E+feZ+6o47PSCL83
   ziWnlxV3bf0utcRCy1/J7vaKdE0CActKH+xYzjf6KAQPxylwrlloVQ/LT
   Kt6C0V7//SRrRVCOCUYq+gjC2vl5oR9KnsfdXAvQSn4eIk7nfsPFLtl80
   XH+UCYY7G2TrDKv2jbxKLeTxUV4FrQuCNyhO7CND3jFbGuMNaLOXyOy4A
   QizTNKq4Ak/c9veGy5xAm7V0nh5vNVfl5yFgWMgOFmU3322gQ+oTWaki0
   ObNX3tJURN0cQ3N/ct8eCuWRJlz1vFfn+Bd/a/g5yF/yuLnufaPPU6o2U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389592471"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389592471"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:50:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15659932"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 07:50:09 -0800
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 03/14] page_pool: avoid calling no-op externals when possible
Date:   Fri, 24 Nov 2023 16:47:21 +0100
Message-ID: <20231124154732.1623518-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
even on DMA-coherent platforms (like x86) with no active IOMMU or
swiotlb, just for the call ladder.
Indeed, it's

page_pool_put_page()
  page_pool_put_defragged_page()                  <- external
    __page_pool_put_page()
      page_pool_dma_sync_for_device()             <- non-inline
        dma_sync_single_range_for_device()
          dma_sync_single_for_device()            <- external
            dma_direct_sync_single_for_device()
              dev_is_dma_coherent()               <- exit

For the inline functions, no guarantees the compiler won't uninline them
(they're clearly not one-liners and sometimes the compilers manage to
uninline 2 + 2). The first external call is necessary, but the rest 2+
are done for nothing each time, plus a bunch of checks here and there.
Since Page Pool mappings are long-term and for one "device + addr" pair
dma_need_sync() will always return the same value (basically, whether it
belongs to an swiotlb pool), addresses can be tested once right after
they're obtained and the result can be reused until the page is
unmapped.
Do this test after a successful DMA mapping and reuse the lowest bit of
page::dma_addr to store the result, since Page Pool addresses are always
page-aligned and the lowest bits are unused.
page_pool_{g,s}et_dma_addr() will then take this bit into account and
exclude it from the actual address. Call page_pool_dma_sync_for_device()
only if the bit is set, shaving off several function calls back and
forth. If pool::dma_sync is not set, i.e. the driver didn't ask to
perform syncs, don't do this test and never touch the lowest bit.
On my x86_64, this gives from 2% to 5% performance benefit with no
negative impact for cases when IOMMU is on and the shortcut can't be
used.

Suggested-by: Yunsheng Lin <linyunsheng@huawei.com> # per-page flag
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 60 +++++++++++++++++++++++++++++----
 net/core/page_pool.c            | 10 +++---
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 4ebd544ae977..28bec368b8e9 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -52,6 +52,8 @@
 #ifndef _NET_PAGE_POOL_HELPERS_H
 #define _NET_PAGE_POOL_HELPERS_H
 
+#include <linux/dma-mapping.h>
+
 #include <net/page_pool/types.h>
 
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -354,6 +356,11 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
 	page_pool_put_page(pool, virt_to_head_page(va), -1, allow_direct);
 }
 
+/* Occupies page::dma_addr[0:0] and indicates whether the mapping needs to be
+ * synchronized (either for device, for CPU, or both).
+ */
+#define PAGE_POOL_DMA_ADDR_NEED_SYNC		BIT(0)
+
 /**
  * page_pool_get_dma_addr() - Retrieve the stored DMA address.
  * @page:	page allocated from a page pool
@@ -363,27 +370,66 @@ static inline void page_pool_free_va(struct page_pool *pool, void *va,
  */
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
-	dma_addr_t ret = page->dma_addr;
+	dma_addr_t ret = page->dma_addr & ~PAGE_POOL_DMA_ADDR_NEED_SYNC;
 
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA)
-		ret <<= PAGE_SHIFT;
+		ret <<= PAGE_SHIFT - 1;
 
 	return ret;
 }
 
-static inline bool page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+/**
+ * page_pool_set_dma_addr - save the obtained DMA address for @page
+ * @pool: &page_pool this page belongs to and was mapped by
+ * @page: page to save the address for
+ * @addr: DMA address to save
+ *
+ * If the pool was created with the DMA synchronization enabled, it will test
+ * whether the address needs to be synced and store the result as well to
+ * conserve CPU cycles.
+ *
+ * Return: false if the address doesn't fit into the corresponding field and
+ * thus can't be stored, true on success.
+ */
+static inline bool page_pool_set_dma_addr(const struct page_pool *pool,
+					  struct page *page,
+					  dma_addr_t addr)
 {
+	unsigned long val = addr;
+
+	if (unlikely(!addr)) {
+		page->dma_addr = 0;
+		return true;
+	}
+
 	if (PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA) {
-		page->dma_addr = addr >> PAGE_SHIFT;
+		val = addr >> (PAGE_SHIFT - 1);
 
 		/* We assume page alignment to shave off bottom bits,
 		 * if this "compression" doesn't work we need to drop.
 		 */
-		return addr != (dma_addr_t)page->dma_addr << PAGE_SHIFT;
+		if (addr != (dma_addr_t)val << (PAGE_SHIFT - 1))
+			return false;
 	}
 
-	page->dma_addr = addr;
-	return false;
+	if (pool->dma_sync && dma_need_sync(pool->p.dev, addr))
+		val |= PAGE_POOL_DMA_ADDR_NEED_SYNC;
+
+	page->dma_addr = val;
+
+	return true;
+}
+
+/**
+ * page_pool_dma_addr_need_sync - check whether a mapped page needs DMA syncs
+ * @page: page to check
+ *
+ * Return: the result previously saved by page_pool_set_dma_addr() to skip
+ * synchronization when not needed.
+ */
+static inline bool page_pool_dma_addr_need_sync(const struct page *page)
+{
+	return page->dma_addr & PAGE_POOL_DMA_ADDR_NEED_SYNC;
 }
 
 static inline bool page_pool_put(struct page_pool *pool)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a8da3ba3b1e8..09bdfdfc4788 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -366,10 +366,10 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	if (page_pool_set_dma_addr(page, dma))
+	if (!page_pool_set_dma_addr(pool, page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
+	if (page_pool_dma_addr_need_sync(page))
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
@@ -545,7 +545,7 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
-	page_pool_set_dma_addr(page, 0);
+	page_pool_set_dma_addr(pool, page, 0);
 skip_dma_unmap:
 	page_pool_clear_pp_info(page);
 
@@ -622,7 +622,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
+		if (page_pool_dma_addr_need_sync(page))
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
@@ -735,7 +735,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
-		if (pool->dma_sync)
+		if (page_pool_dma_addr_need_sync(page))
 			page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
-- 
2.42.0

