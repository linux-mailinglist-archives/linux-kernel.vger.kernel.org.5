Return-Path: <linux-kernel+bounces-10222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B481D184
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BFE1F23E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B2D52F;
	Sat, 23 Dec 2023 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVpR/C5j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FCD52B;
	Sat, 23 Dec 2023 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300307; x=1734836307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ryKNR71ldFbhVXYFqqHil/sbwwAAIlJHYHVkfyR/mFU=;
  b=SVpR/C5jv0TqHSzmeS7+S5lTtSLrFl7IGKlLGgmrpP6Thzsdy8OtvVkJ
   cWncaSsuwGt+jXefjpO7IpQOiVzBpGGrCAzwkT97hNjBdxFD9PwX4WQIv
   D1xtd8+UCkSZiXIef2C7itNOHdqi3O9ZH44fu3V43Eytmo+ROn44lZNeA
   qa0iAZlEzxs1JE4VamFxFMLR4G+mo8eJ4JCdFLStL3UU4gywPnUnl2dgV
   mtDDukmcjqOm1kFxy65YD9okymacukPBZrlafmLElBV60Xp8dHAzsVYgJ
   KLGff7OnWgXBukqePa9Crjzvp/4xY4WxE8flUUvmOw6lpAup5+DpvN/H9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610814"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610814"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537434"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:23 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 06/34] idpf: use libie Rx buffer management for payload buffer
Date: Sat, 23 Dec 2023 03:55:26 +0100
Message-ID: <20231223025554.2316836-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf uses Page Pool for data buffers with hardcoded buffer lengths of
4k for "classic" buffers and 2k for "short" ones. This is not flexible
and does not ensure optimal memory usage. Why would you need 4k buffers
when the MTU is 1500?
Use libie for the data buffers and don't hardcode any buffer sizes. Let
them be calculated from the MTU for "classics" and then divide the
truesize by 2 for "short" ones. The memory usage is now greatly reduced
and 2 buffer queues starts make sense: on frames <= 1024, you'll recycle
(and resync) a page only after 4 HW writes rather than two.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 -
 drivers/net/ethernet/intel/idpf/idpf.h        |   1 -
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  24 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 194 ++++++------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  70 +------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   8 +-
 6 files changed, 88 insertions(+), 210 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index d2e9bef2e0cb..c96d244a1d54 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -379,7 +379,6 @@ config IDPF
 	depends on PCI_MSI
 	select DIMLIB
 	select LIBIE
-	select PAGE_POOL
 	help
 	  This driver supports Intel(R) Infrastructure Data Path Function
 	  devices.
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 8342df0f4f3d..596ece7df26a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -381,7 +381,6 @@ struct idpf_vport {
 	u32 rxq_desc_count;
 	u8 num_bufqs_per_qgrp;
 	u32 bufq_desc_count[IDPF_MAX_BUFQS_PER_RXQ_GRP];
-	u32 bufq_size[IDPF_MAX_BUFQS_PER_RXQ_GRP];
 	u16 num_rxq_grp;
 	struct idpf_rxq_group *rxq_grps;
 	u32 rxq_model;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 53ff572ce252..63a709743037 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -883,20 +883,24 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 				      u16 cleaned_count)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
+	const struct libie_buf_queue bq = {
+		.pp		= rx_q->pp,
+		.rx_bi		= rx_q->rx_buf.buf,
+		.truesize	= rx_q->truesize,
+		.count		= rx_q->desc_count,
+	};
 	u16 nta = rx_q->next_to_alloc;
-	struct idpf_rx_buf *buf;
 
 	if (!cleaned_count)
 		return false;
 
 	desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, nta);
-	buf = &rx_q->rx_buf.buf[nta];
 
 	do {
 		dma_addr_t addr;
 
-		addr = idpf_alloc_page(rx_q->pp, buf, rx_q->rx_buf_size);
-		if (unlikely(addr == DMA_MAPPING_ERROR))
+		addr = libie_rx_alloc(&bq, nta);
+		if (addr == DMA_MAPPING_ERROR)
 			break;
 
 		/* Refresh the desc even if buffer_addrs didn't change
@@ -906,11 +910,9 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 		desc->hdr_addr = 0;
 		desc++;
 
-		buf++;
 		nta++;
 		if (unlikely(nta == rx_q->desc_count)) {
 			desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, 0);
-			buf = rx_q->rx_buf.buf;
 			nta = 0;
 		}
 
@@ -1031,24 +1033,22 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
 
 		rx_buf = &rx_q->rx_buf.buf[ntc];
-		if (!fields.size) {
-			idpf_rx_put_page(rx_buf);
+		if (!libie_rx_sync_for_cpu(rx_buf, fields.size))
 			goto skip_data;
-		}
 
-		idpf_rx_sync_for_cpu(rx_buf, fields.size);
 		if (skb)
 			idpf_rx_add_frag(rx_buf, skb, fields.size);
 		else
-			skb = idpf_rx_construct_skb(rx_q, rx_buf, fields.size);
+			skb = idpf_rx_build_skb(rx_buf, fields.size);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb)
 			break;
 
 skip_data:
-		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
+		rx_buf->page = NULL;
 
+		IDPF_SINGLEQ_BUMP_RING_IDX(rx_q, ntc);
 		cleaned_count++;
 
 		/* skip if it is non EOP desc */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f696fd9839fc..c44737e243b0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -369,6 +369,10 @@ static void idpf_rx_hdr_buf_rel_all(struct idpf_queue *rxq)
  */
 static void idpf_rx_buf_rel_all(struct idpf_queue *rxq)
 {
+	struct libie_buf_queue bq = {
+		.pp	= rxq->pp,
+	};
+	struct device *dev;
 	u16 i;
 
 	/* queue already cleared, nothing to do */
@@ -382,8 +386,9 @@ static void idpf_rx_buf_rel_all(struct idpf_queue *rxq)
 	if (rxq->rx_hsplit_en)
 		idpf_rx_hdr_buf_rel_all(rxq);
 
-	page_pool_destroy(rxq->pp);
-	rxq->pp = NULL;
+	dev = bq.pp->p.dev;
+	libie_rx_page_pool_destroy(&bq);
+	rxq->dev = dev;
 
 	kfree(rxq->rx_buf.buf);
 	rxq->rx_buf.buf = NULL;
@@ -552,11 +557,9 @@ static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
 		.count		= bufq->desc_count,
 	};
 	u16 nta = bufq->next_to_alloc;
-	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
 
 	splitq_rx_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, nta);
-	buf = &bufq->rx_buf.buf[buf_id];
 
 	if (bufq->rx_hsplit_en) {
 		bq.pp = bufq->hdr_pp;
@@ -570,8 +573,12 @@ static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
 		splitq_rx_desc->hdr_addr = cpu_to_le64(addr);
 	}
 
-	addr = idpf_alloc_page(bufq->pp, buf, bufq->rx_buf_size);
-	if (unlikely(addr == DMA_MAPPING_ERROR))
+	bq.pp = bufq->pp;
+	bq.rx_bi = bufq->rx_buf.buf;
+	bq.truesize = bufq->truesize;
+
+	addr = libie_rx_alloc(&bq, buf_id);
+	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
 	splitq_rx_desc->pkt_addr = cpu_to_le64(addr);
@@ -607,28 +614,6 @@ static bool idpf_rx_post_init_bufs(struct idpf_queue *bufq, u16 working_set)
 	return true;
 }
 
-/**
- * idpf_rx_create_page_pool - Create a page pool
- * @rxbufq: RX queue to create page pool for
- *
- * Returns &page_pool on success, casted -errno on failure
- */
-static struct page_pool *idpf_rx_create_page_pool(struct idpf_queue *rxbufq)
-{
-	struct page_pool_params pp = {
-		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
-		.order		= 0,
-		.pool_size	= rxbufq->desc_count,
-		.nid		= NUMA_NO_NODE,
-		.dev		= rxbufq->vport->netdev->dev.parent,
-		.max_len	= PAGE_SIZE,
-		.dma_dir	= DMA_FROM_DEVICE,
-		.offset		= 0,
-	};
-
-	return page_pool_create(&pp);
-}
-
 /**
  * idpf_rx_buf_alloc_all - Allocate memory for all buffer resources
  * @rxbufq: queue for which the buffers are allocated; equivalent to
@@ -676,18 +661,28 @@ static int idpf_rx_buf_alloc_all(struct idpf_queue *rxbufq)
 /**
  * idpf_rx_bufs_init - Initialize page pool, allocate rx bufs, and post to HW
  * @rxbufq: RX queue to create page pool for
+ * @type: type of Rx buffers to allocate
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_bufs_init(struct idpf_queue *rxbufq)
+static int idpf_rx_bufs_init(struct idpf_queue *rxbufq,
+			     enum libie_rx_buf_type type)
 {
-	struct page_pool *pool;
+	struct libie_buf_queue bq = {
+		.truesize	= rxbufq->truesize,
+		.count		= rxbufq->desc_count,
+		.type		= type,
+		.hsplit		= rxbufq->rx_hsplit_en,
+	};
+	int ret;
 
-	pool = idpf_rx_create_page_pool(rxbufq);
-	if (IS_ERR(pool))
-		return PTR_ERR(pool);
+	ret = libie_rx_page_pool_create(&bq, &rxbufq->q_vector->napi);
+	if (ret)
+		return ret;
 
-	rxbufq->pp = pool;
+	rxbufq->pp = bq.pp;
+	rxbufq->truesize = bq.truesize;
+	rxbufq->rx_buf_size = bq.rx_buf_len;
 
 	return idpf_rx_buf_alloc_all(rxbufq);
 }
@@ -700,20 +695,21 @@ static int idpf_rx_bufs_init(struct idpf_queue *rxbufq)
  */
 int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 {
-	struct idpf_rxq_group *rx_qgrp;
+	bool split = idpf_is_queue_model_split(vport->rxq_model);
 	struct idpf_queue *q;
 	int i, j, err;
 
 	for (i = 0; i < vport->num_rxq_grp; i++) {
-		rx_qgrp = &vport->rxq_grps[i];
+		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
+		u32 truesize = 0;
 
 		/* Allocate bufs for the rxq itself in singleq */
-		if (!idpf_is_queue_model_split(vport->rxq_model)) {
+		if (!split) {
 			int num_rxq = rx_qgrp->singleq.num_rxq;
 
 			for (j = 0; j < num_rxq; j++) {
 				q = rx_qgrp->singleq.rxqs[j];
-				err = idpf_rx_bufs_init(q);
+				err = idpf_rx_bufs_init(q, LIBIE_RX_BUF_MTU);
 				if (err)
 					return err;
 			}
@@ -723,10 +719,18 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
 
 		/* Otherwise, allocate bufs for the buffer queues */
 		for (j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+			enum libie_rx_buf_type qt;
+
 			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			err = idpf_rx_bufs_init(q);
+			q->truesize = truesize;
+
+			qt = truesize ? LIBIE_RX_BUF_SHORT : LIBIE_RX_BUF_MTU;
+
+			err = idpf_rx_bufs_init(q, qt);
 			if (err)
 				return err;
+
+			truesize = q->truesize >> 1;
 		}
 	}
 
@@ -1009,17 +1013,11 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 	/* Adjust number of buffer queues per Rx queue group. */
 	if (!idpf_is_queue_model_split(vport->rxq_model)) {
 		vport->num_bufqs_per_qgrp = 0;
-		vport->bufq_size[0] = IDPF_RX_BUF_2048;
 
 		return;
 	}
 
 	vport->num_bufqs_per_qgrp = IDPF_MAX_BUFQS_PER_RXQ_GRP;
-	/* Bufq[0] default buffer size is 4K
-	 * Bufq[1] default buffer size is 2K
-	 */
-	vport->bufq_size[0] = IDPF_RX_BUF_4096;
-	vport->bufq_size[1] = IDPF_RX_BUF_2048;
 }
 
 /**
@@ -1353,7 +1351,6 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 			q->vport = vport;
 			q->rxq_grp = rx_qgrp;
 			q->idx = j;
-			q->rx_buf_size = vport->bufq_size[j];
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
 			q->rx_buf_stride = IDPF_RX_BUF_STRIDE;
 			q->rx_hsplit_en = hs;
@@ -1405,14 +1402,9 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 			q->vport = vport;
 			q->rxq_grp = rx_qgrp;
 			q->idx = (i * num_rxq) + j;
-			/* In splitq mode, RXQ buffer size should be
-			 * set to that of the first buffer queue
-			 * associated with this RXQ
-			 */
-			q->rx_buf_size = vport->bufq_size[0];
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
 			q->rx_max_pkt_size = vport->netdev->mtu +
-							IDPF_PACKET_HDR_PAD;
+							LIBIE_RX_LL_LEN;
 			idpf_rxq_set_descids(vport, q);
 		}
 	}
@@ -2986,70 +2978,10 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size)
 {
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
-			rx_buf->offset, size, rx_buf->truesize);
-
-	rx_buf->page = NULL;
-}
-
-/**
- * idpf_rx_construct_skb - Allocate skb and populate it
- * @rxq: Rx descriptor queue
- * @rx_buf: Rx buffer to pull data from
- * @size: the length of the packet
- *
- * This function allocates an skb. It then populates it with the page
- * data from the current receive descriptor, taking care to set up the
- * skb correctly.
- */
-struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
-				      struct idpf_rx_buf *rx_buf,
-				      unsigned int size)
-{
-	unsigned int headlen;
-	struct sk_buff *skb;
-	void *va;
-
-	va = page_address(rx_buf->page) + rx_buf->offset;
-
-	/* prefetch first cache line of first page */
-	net_prefetch(va);
-	/* allocate a skb to store the frags */
-	skb = __napi_alloc_skb(&rxq->q_vector->napi, IDPF_RX_HDR_SIZE,
-			       GFP_ATOMIC);
-	if (unlikely(!skb)) {
-		idpf_rx_put_page(rx_buf);
-
-		return NULL;
-	}
-
-	skb_mark_for_recycle(skb);
-
-	/* Determine available headroom for copy */
-	headlen = size;
-	if (headlen > IDPF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(skb->dev, va, IDPF_RX_HDR_SIZE);
-
-	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
-
-	/* if we exhaust the linear part then add what is left as a frag */
-	size -= headlen;
-	if (!size) {
-		idpf_rx_put_page(rx_buf);
-
-		return skb;
-	}
+	u32 hr = rx_buf->page->pp->p.offset;
 
-	skb_add_rx_frag(skb, 0, rx_buf->page, rx_buf->offset + headlen,
-			size, rx_buf->truesize);
-
-	/* Since we're giving the page to the stack, clear our reference to it.
-	 * We'll get a new one during buffer posting.
-	 */
-	rx_buf->page = NULL;
-
-	return skb;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
+			rx_buf->offset + hr, size, rx_buf->truesize);
 }
 
 /**
@@ -3249,24 +3181,24 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		hdr->page = NULL;
 
 payload:
-		if (pkt_len) {
-			idpf_rx_sync_for_cpu(rx_buf, pkt_len);
-			if (skb)
-				idpf_rx_add_frag(rx_buf, skb, pkt_len);
-			else
-				skb = idpf_rx_construct_skb(rxq, rx_buf,
-							    pkt_len);
-		} else {
-			idpf_rx_put_page(rx_buf);
-		}
+		if (!libie_rx_sync_for_cpu(rx_buf, pkt_len))
+			goto skip_data;
+
+		if (skb)
+			idpf_rx_add_frag(rx_buf, skb, pkt_len);
+		else
+			skb = idpf_rx_build_skb(rx_buf, pkt_len);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb)
 			break;
 
-		idpf_rx_post_buf_refill(refillq, buf_id);
+skip_data:
+		rx_buf->page = NULL;
 
+		idpf_rx_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
+
 		/* skip if it is non EOP desc */
 		if (!idpf_rx_splitq_is_eop(rx_desc))
 			continue;
@@ -3319,18 +3251,18 @@ static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
 				    struct virtchnl2_splitq_rx_buf_desc *buf_desc)
 {
 	struct libie_buf_queue bq = {
+		.pp		= bufq->pp,
+		.rx_bi		= bufq->rx_buf.buf,
+		.truesize	= bufq->truesize,
 		.count		= bufq->desc_count,
 	};
-	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
 	u16 buf_id;
 
 	buf_id = FIELD_GET(IDPF_RX_BI_BUFID_M, refill_desc);
 
-	buf = &bufq->rx_buf.buf[buf_id];
-
-	addr = idpf_alloc_page(bufq->pp, buf, bufq->rx_buf_size);
-	if (unlikely(addr == DMA_MAPPING_ERROR))
+	addr = libie_rx_alloc(&bq, buf_id);
+	if (addr == DMA_MAPPING_ERROR)
 		return -ENOMEM;
 
 	buf_desc->pkt_addr = cpu_to_le64(addr);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 357683559b57..0bbc654a24b9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -93,14 +93,10 @@ do {								\
 		idx = 0;					\
 } while (0)
 
-#define IDPF_RX_HDR_SIZE			256
-#define IDPF_RX_BUF_2048			2048
-#define IDPF_RX_BUF_4096			4096
 #define IDPF_RX_BUF_STRIDE			32
 #define IDPF_RX_BUF_POST_STRIDE			16
 #define IDPF_LOW_WATERMARK			64
-#define IDPF_PACKET_HDR_PAD	\
-	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN * 2)
+
 #define IDPF_TX_TSO_MIN_MSS			88
 
 /* Minimum number of descriptors between 2 descriptors with the RE bit set;
@@ -609,7 +605,6 @@ union idpf_queue_stats {
  * @sched_buf_hash: Hash table to stores buffers
  */
 struct idpf_queue {
-	struct device *dev;
 	struct idpf_vport *vport;
 	union {
 		struct idpf_txq_group *txq_grp;
@@ -624,10 +619,14 @@ struct idpf_queue {
 		} rx_buf;
 	};
 	struct page_pool *hdr_pp;
-	struct page_pool *pp;
+	union {
+		struct page_pool *pp;
+		struct device *dev;
+	};
 	void *desc_ring;
 
 	u32 hdr_truesize;
+	u32 truesize;
 	u16 idx;
 	u16 q_type;
 	u32 q_id;
@@ -866,60 +865,6 @@ static inline void idpf_tx_splitq_build_desc(union idpf_tx_flex_desc *desc,
 		idpf_tx_splitq_build_flow_desc(desc, params, td_cmd, size);
 }
 
-/**
- * idpf_alloc_page - Allocate a new RX buffer from the page pool
- * @pool: page_pool to allocate from
- * @buf: metadata struct to populate with page info
- * @buf_size: 2K or 4K
- *
- * Returns &dma_addr_t to be passed to HW for Rx, %DMA_MAPPING_ERROR otherwise.
- */
-static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
-					 struct idpf_rx_buf *buf,
-					 unsigned int buf_size)
-{
-	if (buf_size == IDPF_RX_BUF_2048)
-		buf->page = page_pool_dev_alloc_frag(pool, &buf->offset,
-						     buf_size);
-	else
-		buf->page = page_pool_dev_alloc_pages(pool);
-
-	if (!buf->page)
-		return DMA_MAPPING_ERROR;
-
-	buf->truesize = buf_size;
-
-	return page_pool_get_dma_addr(buf->page) + buf->offset +
-	       pool->p.offset;
-}
-
-/**
- * idpf_rx_put_page - Return RX buffer page to pool
- * @rx_buf: RX buffer metadata struct
- */
-static inline void idpf_rx_put_page(struct idpf_rx_buf *rx_buf)
-{
-	page_pool_put_page(rx_buf->page->pp, rx_buf->page,
-			   rx_buf->truesize, true);
-	rx_buf->page = NULL;
-}
-
-/**
- * idpf_rx_sync_for_cpu - Synchronize DMA buffer
- * @rx_buf: RX buffer metadata struct
- * @len: frame length from descriptor
- */
-static inline void idpf_rx_sync_for_cpu(struct idpf_rx_buf *rx_buf, u32 len)
-{
-	struct page *page = rx_buf->page;
-	struct page_pool *pp = page->pp;
-
-	dma_sync_single_range_for_cpu(pp->p.dev,
-				      page_pool_get_dma_addr(page),
-				      rx_buf->offset + pp->p.offset, len,
-				      page_pool_get_dma_dir(pp));
-}
-
 /**
  * idpf_vport_intr_set_wb_on_itr - enable descriptor writeback on disabled interrupts
  * @q_vector: pointer to queue vector struct
@@ -961,9 +906,6 @@ void idpf_deinit_rss(struct idpf_vport *vport);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport);
 void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size);
-struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
-				      struct idpf_rx_buf *rx_buf,
-				      unsigned int size);
 struct sk_buff *idpf_rx_build_skb(const struct libie_rx_buffer *buf, u32 size);
 bool idpf_init_rx_buf_hw_alloc(struct idpf_queue *rxq, struct idpf_rx_buf *buf);
 void idpf_rx_buf_hw_update(struct idpf_queue *rxq, u32 val);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d599c0199e22..5c3d7c3534af 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1647,6 +1647,12 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 			sets = rxq->rxq_grp->splitq.bufq_sets;
 
+			/* In splitq mode, RXQ buffer size should be
+			 * set to that of the first buffer queue
+			 * associated with this RXQ.
+			 */
+			rxq->rx_buf_size = sets[0].bufq.rx_buf_size;
+
 			qi[k].rx_bufq1_id = cpu_to_le16(sets[0].bufq.q_id);
 			if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP) {
 				qi[k].bufq2_ena = IDPF_BUFQ2_ENA;
@@ -3297,7 +3303,7 @@ void idpf_vport_init(struct idpf_vport *vport, struct idpf_vport_max_q *max_q)
 	rss_data->rss_lut_size = le16_to_cpu(vport_msg->rss_lut_size);
 
 	ether_addr_copy(vport->default_mac_addr, vport_msg->default_mac_addr);
-	vport->max_mtu = le16_to_cpu(vport_msg->max_mtu) - IDPF_PACKET_HDR_PAD;
+	vport->max_mtu = le16_to_cpu(vport_msg->max_mtu) - LIBIE_RX_LL_LEN;
 
 	/* Initialize Tx and Rx profiles for Dynamic Interrupt Moderation */
 	memcpy(vport->rx_itr_profile, rx_itr, IDPF_DIM_PROFILE_SLOTS);
-- 
2.43.0


