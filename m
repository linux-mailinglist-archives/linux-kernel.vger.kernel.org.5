Return-Path: <linux-kernel+bounces-44531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27E842353
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BA028B365
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7A6D1AA;
	Tue, 30 Jan 2024 11:38:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F836A344;
	Tue, 30 Jan 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614694; cv=none; b=e0IH8EiqpYQZRl1zo1IaeT90NokxG5LyRsnsXQ1ENc6v6rTazpb8sK3MCsoYEkC1+hRzEbau8vK5fY4hQIrtAETFwV6P3nE9hYOfDRsY0amQSPF9LfK4Vg9v33sbLJ0K0guKWFT2r3S4/sJQymd957OPFc8XrjkIcGiruNy2yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614694; c=relaxed/simple;
	bh=Po9UmepGah+wDcjtjlXv76oDnLy8VqpUY9/GZvXhthQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmakfbUSPhQTlM1spPW5B1k8xJnI8LRL7L5oY4+fD7/CwX6scuTSK4fR8bLyXK3nuO0ZjnBhcgUZBkgdOtVXlbhy+lMWwHPa8d2OyoRN+Q3E2/ItNiH1YpKlBowKBuTLQ/tNjR42Z7CbdKlvmWA6et7aU/iz3deFKoHLFwuV4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TPNR22P6rz1gy1H;
	Tue, 30 Jan 2024 19:36:14 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B48431404D7;
	Tue, 30 Jan 2024 19:38:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 19:38:03 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jason Wang <jasowang@redhat.com>, Alexander Duyck
	<alexanderduyck@fb.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v4 3/5] net: introduce page_frag_cache_drain()
Date: Tue, 30 Jan 2024 19:37:08 +0800
Message-ID: <20240130113710.34511-4-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240130113710.34511-1-linyunsheng@huawei.com>
References: <20240130113710.34511-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

When draining a page_frag_cache, most user are doing
the similar steps, so introduce an API to avoid code
duplication.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 11 ++---------
 drivers/net/ethernet/mediatek/mtk_wed_wo.c | 17 ++---------------
 drivers/nvme/host/tcp.c                    |  7 +------
 drivers/nvme/target/tcp.c                  |  4 +---
 include/linux/gfp.h                        |  1 +
 mm/page_alloc.c                            | 10 ++++++++++
 6 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index db6d9ae7cd78..dec6458bb8d7 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1276,17 +1276,10 @@ static void gve_unreg_xdp_info(struct gve_priv *priv)
 
 static void gve_drain_page_cache(struct gve_priv *priv)
 {
-	struct page_frag_cache *nc;
 	int i;
 
-	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
-		nc = &priv->rx[i].page_cache;
-		if (nc->va) {
-			__page_frag_cache_drain(virt_to_page(nc->va),
-						nc->pagecnt_bias);
-			nc->va = NULL;
-		}
-	}
+	for (i = 0; i < priv->rx_cfg.num_queues; i++)
+		page_frag_cache_drain(&priv->rx[i].page_cache);
 }
 
 static void gve_qpls_get_curr_alloc_cfg(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index d58b07e7e123..7063c78bd35f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -286,7 +286,6 @@ mtk_wed_wo_queue_free(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 static void
 mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
 	int i;
 
 	for (i = 0; i < q->n_desc; i++) {
@@ -301,19 +300,12 @@ mtk_wed_wo_queue_tx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 		entry->buf = NULL;
 	}
 
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
+	page_frag_cache_drain(&q->cache);
 }
 
 static void
 mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 {
-	struct page *page;
-
 	for (;;) {
 		void *buf = mtk_wed_wo_dequeue(wo, q, NULL, true);
 
@@ -323,12 +315,7 @@ mtk_wed_wo_queue_rx_clean(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q)
 		skb_free_frag(buf);
 	}
 
-	if (!q->cache.va)
-		return;
-
-	page = virt_to_page(q->cache.va);
-	__page_frag_cache_drain(page, q->cache.pagecnt_bias);
-	memset(&q->cache, 0, sizeof(q->cache));
+	page_frag_cache_drain(&q->cache);
 }
 
 static void
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d058d990532b..22e1fb9c9c0f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1344,7 +1344,6 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 
 static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct page *page;
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	unsigned int noreclaim_flag;
@@ -1355,11 +1354,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (queue->hdr_digest || queue->data_digest)
 		nvme_tcp_free_crypto(queue);
 
-	if (queue->pf_cache.va) {
-		page = virt_to_head_page(queue->pf_cache.va);
-		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
-		queue->pf_cache.va = NULL;
-	}
+	page_frag_cache_drain(&queue->pf_cache);
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	/* ->sock will be released by fput() */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6a1e6bb80062..56224dc59f17 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1591,7 +1591,6 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
-	struct page *page;
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
@@ -1615,8 +1614,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-	page = virt_to_head_page(queue->pf_cache.va);
-	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 }
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 28aea17fa59b..6cef1c241180 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -311,6 +311,7 @@ extern void __free_pages(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 struct page_frag_cache;
+void page_frag_cache_drain(struct page_frag_cache *nc);
 extern void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *__page_frag_alloc_align(struct page_frag_cache *nc, unsigned int fragsz,
 			      gfp_t gfp_mask, unsigned int align_mask);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 636145c29f70..06aa1ebbd21c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4699,6 +4699,16 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	return page;
 }
 
+void page_frag_cache_drain(struct page_frag_cache *nc)
+{
+	if (!nc->va)
+		return;
+
+	__page_frag_cache_drain(virt_to_head_page(nc->va), nc->pagecnt_bias);
+	nc->va = NULL;
+}
+EXPORT_SYMBOL(page_frag_cache_drain);
+
 void __page_frag_cache_drain(struct page *page, unsigned int count)
 {
 	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
-- 
2.33.0


