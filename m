Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6411577DE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbjHPKEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbjHPKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:04:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D13C1;
        Wed, 16 Aug 2023 03:04:14 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQkCl3HDQztRyn;
        Wed, 16 Aug 2023 18:00:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 18:04:11 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Eric Dumazet <edumazet@google.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v7 3/6] page_pool: remove PP_FLAG_PAGE_FRAG
Date:   Wed, 16 Aug 2023 18:01:10 +0800
Message-ID: <20230816100113.41034-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230816100113.41034-1-linyunsheng@huawei.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PP_FLAG_PAGE_FRAG is not really needed after pp_frag_count
handling is unified and page_pool_alloc_frag() is supported
in 32-bit arch with 64-bit DMA, so remove it.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                | 2 --
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c          | 3 +--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c            | 2 +-
 include/net/page_pool/types.h                            | 8 ++------
 net/core/page_pool.c                                     | 3 ---
 net/core/skbuff.c                                        | 2 +-
 7 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7be917a8da48..60b699be0d9b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3249,8 +3249,6 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
-	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
-		pp.flags |= PP_FLAG_PAGE_FRAG;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index eac2d0573241..ff0c219365f1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4926,8 +4926,7 @@ static void hns3_put_ring_config(struct hns3_nic_priv *priv)
 static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
 {
 	struct page_pool_params pp_params = {
-		.flags = PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
-				PP_FLAG_DMA_SYNC_DEV,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = hns3_page_order(ring),
 		.pool_size = ring->desc_num * hns3_buf_size(ring) /
 				(PAGE_SIZE << hns3_page_order(ring)),
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index dce3cea00032..edc6acebf369 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1433,7 +1433,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		return 0;
 	}
 
-	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
+	pp_params.flags = PP_FLAG_DMA_MAP;
 	pp_params.pool_size = numptrs;
 	pp_params.nid = NUMA_NO_NODE;
 	pp_params.dev = pfvf->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d158320bc15d..fe7cc67b7ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -566,7 +566,7 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
-		.flags = PP_FLAG_PAGE_FRAG,
+		.flags = 0,
 		.nid = NUMA_NO_NODE,
 		.dev = dev->dma_dev,
 	};
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 079337c42aa6..4775cf95edb7 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -15,19 +15,15 @@
  */
 #define PP_FLAG_DMA_SYNC_DEV		BIT(1)
 
-/* for page frag feature */
-#define PP_FLAG_PAGE_FRAG		BIT(2)
-
 /* If set driver will do the page splitting itself. This is used to fail the
  * page_pool creation because there is overlap issue between pp_frag_count and
  * dma_addr_upper in 'struct page' for some arches with
  * PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
  */
-#define PP_FLAG_PAGE_SPLIT_IN_DRIVER	BIT(3)
+#define PP_FLAG_PAGE_SPLIT_IN_DRIVER	BIT(2)
 
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
 				 PP_FLAG_DMA_SYNC_DEV |\
-				 PP_FLAG_PAGE_FRAG |\
 				 PP_FLAG_PAGE_SPLIT_IN_DRIVER)
 
 /*
@@ -53,7 +49,7 @@ struct pp_alloc_cache {
 
 /**
  * struct page_pool_params - page pool parameters
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_PAGE_FRAG,
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV,
  *		PP_FLAG_PAGE_SPLIT_IN_DRIVER
  * @order:	2^order pages on allocation
  * @pool_size:	size of the ptr_ring
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 386e6d791e90..d3b8efe98d5e 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -751,9 +751,6 @@ struct page *__page_pool_alloc_frag(struct page_pool *pool,
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
 	struct page *page = pool->frag_page;
 
-	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG)))
-		return NULL;
-
 	*offset = pool->frag_offset;
 
 	if (page && *offset + size > max_size) {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 33fdf04d4334..4b90b6ed10b2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5709,7 +5709,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* In general, avoid mixing page_pool and non-page_pool allocated
 	 * pages within the same SKB. Additionally avoid dealing with clones
 	 * with page_pool pages, in case the SKB is using page_pool fragment
-	 * references (PP_FLAG_PAGE_FRAG). Since we only take full page
+	 * references (page_pool_alloc_frag()). Since we only take full page
 	 * references for cloned SKBs at the moment that would result in
 	 * inconsistent reference counts.
 	 * In theory we could take full references if @from is cloned and
-- 
2.33.0

