Return-Path: <linux-kernel+bounces-10221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14F81D17E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31F8B23E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F4D29E;
	Sat, 23 Dec 2023 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4TRcaBI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E1D2F8;
	Sat, 23 Dec 2023 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300303; x=1734836303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zIAQiD53pI9dF5o2if2XUK918+GApOkA7ZQmUOveiWM=;
  b=h4TRcaBIOCJ/hTSFlx4ACEldv1vn40veRRnElSVglc9/ZJIuk46bA5dv
   A419948LpPIXs2qgD2Lyf/hhkXAYw/133r9wh1bIYhDaOX6mEA6kCE2rK
   3XWy/QzL6RU44uLblmYdNXflJaqaQHswJh+kIm37rihATxcNLGfdFNRVg
   GZQjhmuWv0PLJdagYkaLhca/Avn+NIxY+DKEAjbidDqinTskrL6zs46VE
   tKkrFzE3SttEJPGKlGJob5vpTeb0DQ1Oolij7VCMQR/0BCImr+4GKEdng
   DhfOWgnrM54ao3zKm7c3DMzo+RuN7n+XIgP0oUClwQbXNe8yltId06JQu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610805"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610805"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537422"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:19 -0800
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
Subject: [PATCH RFC net-next 05/34] idpf: convert header split mode to libie + napi_build_skb()
Date: Sat, 23 Dec 2023 03:55:25 +0100
Message-ID: <20231223025554.2316836-6-aleksander.lobakin@intel.com>
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

Currently, idpf uses the following model for the header buffers:

* buffers are allocated via dma_alloc_coherent();
* when receiving, napi_alloc_skb() is called and then the header is
  copied to the newly allocated linear part.

This is far from optimal as DMA coherent zone is slow on many systems
and memcpy() neutralizes the idea and benefits of the header split.
Instead, use libie to create page_pools for the header buffers, allocate
them dynamically and then build an skb via napi_build_skb() around them
with no memory copy. With one exception...
When you enable header split, you except you'll always have a separate
header buffer, so that you could reserve headroom and tailroom only
there and then use full buffers for the data. For example, this is how
TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
The current hardware running idpf does *not* guarantee that you'll
always have headers placed separately. For example, on my setup, even
ICMP packets are written as one piece to the data buffers. You can't
build a valid skb around a data buffer in this case.
To not complicate things and not lose TCP zerocopy etc., when such thing
happens, use the empty header buffer and pull either full frame (if it's
short) or the Ethernet header there and build an skb around it. GRO
layer will pull more from the data buffer later. This W/A will hopefully
be removed one day.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 219 +++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  23 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  14 +-
 4 files changed, 159 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e58e08c9997d..53ff572ce252 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -868,6 +868,8 @@ static void idpf_rx_singleq_process_skb_fields(struct idpf_queue *rx_q,
 		idpf_rx_singleq_flex_hash(rx_q, skb, rx_desc, parsed);
 		idpf_rx_singleq_flex_csum(rx_q, skb, rx_desc, parsed);
 	}
+
+	skb_record_rx_queue(skb, rx_q->idx);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d81eff39a632..f696fd9839fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -331,18 +331,17 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 
 /**
  * idpf_rx_page_rel - Release an rx buffer page
- * @rxq: the queue that owns the buffer
  * @rx_buf: the buffer to free
  */
-static void idpf_rx_page_rel(struct idpf_queue *rxq, struct idpf_rx_buf *rx_buf)
+static void idpf_rx_page_rel(struct libie_rx_buffer *rx_buf)
 {
 	if (unlikely(!rx_buf->page))
 		return;
 
-	page_pool_put_full_page(rxq->pp, rx_buf->page, false);
+	page_pool_put_full_page(rx_buf->page->pp, rx_buf->page, false);
 
 	rx_buf->page = NULL;
-	rx_buf->page_offset = 0;
+	rx_buf->offset = 0;
 }
 
 /**
@@ -351,13 +350,17 @@ static void idpf_rx_page_rel(struct idpf_queue *rxq, struct idpf_rx_buf *rx_buf)
  */
 static void idpf_rx_hdr_buf_rel_all(struct idpf_queue *rxq)
 {
-	struct idpf_adapter *adapter = rxq->vport->adapter;
+	struct libie_buf_queue bq = {
+		.pp	= rxq->hdr_pp,
+	};
+
+	for (u32 i = 0; i < rxq->desc_count; i++)
+		idpf_rx_page_rel(&rxq->rx_buf.hdr_buf[i]);
+
+	libie_rx_page_pool_destroy(&bq);
+	rxq->hdr_pp = bq.pp;
 
-	dma_free_coherent(&adapter->pdev->dev,
-			  rxq->desc_count * IDPF_HDR_BUF_SIZE,
-			  rxq->rx_buf.hdr_buf_va,
-			  rxq->rx_buf.hdr_buf_pa);
-	rxq->rx_buf.hdr_buf_va = NULL;
+	kfree(rxq->rx_buf.hdr_buf);
 }
 
 /**
@@ -374,7 +377,7 @@ static void idpf_rx_buf_rel_all(struct idpf_queue *rxq)
 
 	/* Free all the bufs allocated and given to hw on Rx queue */
 	for (i = 0; i < rxq->desc_count; i++)
-		idpf_rx_page_rel(rxq, &rxq->rx_buf.buf[i]);
+		idpf_rx_page_rel(&rxq->rx_buf.buf[i]);
 
 	if (rxq->rx_hsplit_en)
 		idpf_rx_hdr_buf_rel_all(rxq);
@@ -484,17 +487,33 @@ void idpf_rx_buf_hw_update(struct idpf_queue *rxq, u32 val)
  */
 static int idpf_rx_hdr_buf_alloc_all(struct idpf_queue *rxq)
 {
-	struct idpf_adapter *adapter = rxq->vport->adapter;
-
-	rxq->rx_buf.hdr_buf_va =
-		dma_alloc_coherent(&adapter->pdev->dev,
-				   IDPF_HDR_BUF_SIZE * rxq->desc_count,
-				   &rxq->rx_buf.hdr_buf_pa,
-				   GFP_KERNEL);
-	if (!rxq->rx_buf.hdr_buf_va)
+	struct libie_buf_queue bq = {
+		.count		= rxq->desc_count,
+		.type		= LIBIE_RX_BUF_HDR,
+	};
+	struct libie_rx_buffer *hdr_buf;
+	int ret;
+
+	hdr_buf = kcalloc(bq.count, sizeof(*hdr_buf), GFP_KERNEL);
+	if (!hdr_buf)
 		return -ENOMEM;
 
+	rxq->rx_buf.hdr_buf = hdr_buf;
+
+	ret = libie_rx_page_pool_create(&bq, &rxq->q_vector->napi);
+	if (ret)
+		goto free_hdr;
+
+	rxq->hdr_pp = bq.pp;
+	rxq->hdr_truesize = bq.truesize;
+	rxq->rx_hbuf_size = bq.rx_buf_len;
+
 	return 0;
+
+free_hdr:
+	kfree(hdr_buf);
+
+	return ret;
 }
 
 /**
@@ -529,6 +548,9 @@ static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
 {
 	struct virtchnl2_splitq_rx_buf_desc *splitq_rx_desc = NULL;
+	struct libie_buf_queue bq = {
+		.count		= bufq->desc_count,
+	};
 	u16 nta = bufq->next_to_alloc;
 	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
@@ -537,9 +559,15 @@ static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
 	buf = &bufq->rx_buf.buf[buf_id];
 
 	if (bufq->rx_hsplit_en) {
-		splitq_rx_desc->hdr_addr =
-			cpu_to_le64(bufq->rx_buf.hdr_buf_pa +
-				    (u32)buf_id * IDPF_HDR_BUF_SIZE);
+		bq.pp = bufq->hdr_pp;
+		bq.rx_bi = bufq->rx_buf.hdr_buf;
+		bq.truesize = bufq->hdr_truesize;
+
+		addr = libie_rx_alloc(&bq, buf_id);
+		if (addr == DMA_MAPPING_ERROR)
+			return false;
+
+		splitq_rx_desc->hdr_addr = cpu_to_le64(addr);
 	}
 
 	addr = idpf_alloc_page(bufq->pp, buf, bufq->rx_buf_size);
@@ -1328,11 +1356,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 			q->rx_buf_size = vport->bufq_size[j];
 			q->rx_buffer_low_watermark = IDPF_LOW_WATERMARK;
 			q->rx_buf_stride = IDPF_RX_BUF_STRIDE;
-
-			if (hs) {
-				q->rx_hsplit_en = true;
-				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
-			}
+			q->rx_hsplit_en = hs;
 
 			bufq_set->num_refillqs = num_rxq;
 			bufq_set->refillqs = kcalloc(num_rxq, swq_size,
@@ -1373,10 +1397,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport, u16 num_rxq)
 				rx_qgrp->splitq.rxq_sets[j]->refillq1 =
 				      &rx_qgrp->splitq.bufq_sets[1].refillqs[j];
 
-			if (hs) {
-				q->rx_hsplit_en = true;
-				q->rx_hbuf_size = IDPF_HDR_BUF_SIZE;
-			}
+			q->rx_hsplit_en = hs;
 
 setup_rxq:
 			q->dev = &adapter->pdev->dev;
@@ -2947,6 +2968,8 @@ static int idpf_rx_process_skb_fields(struct idpf_queue *rxq,
 	idpf_rx_splitq_extract_csum_bits(rx_desc, &csum_bits);
 	idpf_rx_csum(rxq, skb, csum_bits, parsed);
 
+	skb_record_rx_queue(skb, rxq->idx);
+
 	return 0;
 }
 
@@ -2964,7 +2987,7 @@ void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 		      unsigned int size)
 {
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
-			rx_buf->page_offset, size, rx_buf->truesize);
+			rx_buf->offset, size, rx_buf->truesize);
 
 	rx_buf->page = NULL;
 }
@@ -2987,7 +3010,7 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 	struct sk_buff *skb;
 	void *va;
 
-	va = page_address(rx_buf->page) + rx_buf->page_offset;
+	va = page_address(rx_buf->page) + rx_buf->offset;
 
 	/* prefetch first cache line of first page */
 	net_prefetch(va);
@@ -3000,7 +3023,6 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 		return NULL;
 	}
 
-	skb_record_rx_queue(skb, rxq->idx);
 	skb_mark_for_recycle(skb);
 
 	/* Determine available headroom for copy */
@@ -3019,7 +3041,7 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 		return skb;
 	}
 
-	skb_add_rx_frag(skb, 0, rx_buf->page, rx_buf->page_offset + headlen,
+	skb_add_rx_frag(skb, 0, rx_buf->page, rx_buf->offset + headlen,
 			size, rx_buf->truesize);
 
 	/* Since we're giving the page to the stack, clear our reference to it.
@@ -3031,36 +3053,31 @@ struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 }
 
 /**
- * idpf_rx_hdr_construct_skb - Allocate skb and populate it from header buffer
- * @rxq: Rx descriptor queue
- * @va: Rx buffer to pull data from
+ * idpf_rx_build_skb - Allocate skb and populate it from header buffer
+ * @buf: Rx buffer to pull data from
  * @size: the length of the packet
  *
  * This function allocates an skb. It then populates it with the page data from
  * the current receive descriptor, taking care to set up the skb correctly.
- * This specifically uses a header buffer to start building the skb.
  */
-static struct sk_buff *idpf_rx_hdr_construct_skb(struct idpf_queue *rxq,
-						 const void *va,
-						 unsigned int size)
+struct sk_buff *idpf_rx_build_skb(const struct libie_rx_buffer *buf, u32 size)
 {
+	u32 hr = buf->page->pp->p.offset;
 	struct sk_buff *skb;
+	void *va;
 
-	/* allocate a skb to store the frags */
-	skb = __napi_alloc_skb(&rxq->q_vector->napi, size, GFP_ATOMIC);
+	va = page_address(buf->page) + buf->offset;
+	net_prefetch(va + hr);
+
+	skb = napi_build_skb(va, buf->truesize);
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_record_rx_queue(skb, rxq->idx);
-
-	memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
-
-	/* More than likely, a payload fragment, which will use a page from
-	 * page_pool will be added to the SKB so mark it for recycle
-	 * preemptively. And if not, it's inconsequential.
-	 */
 	skb_mark_for_recycle(skb);
 
+	skb_reserve(skb, hr);
+	__skb_put(skb, size);
+
 	return skb;
 }
 
@@ -3091,6 +3108,26 @@ static bool idpf_rx_splitq_is_eop(struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_de
 						  IDPF_RXD_EOF_SPLITQ));
 }
 
+static u32 idpf_rx_hsplit_wa(struct libie_rx_buffer *hdr,
+			     struct libie_rx_buffer *buf,
+			     u32 data_len)
+{
+	u32 copy = data_len <= SMP_CACHE_BYTES ? data_len : ETH_HLEN;
+	const void *src;
+	void *dst;
+
+	if (!libie_rx_sync_for_cpu(buf, copy))
+		return 0;
+
+	dst = page_address(hdr->page) + hdr->offset + hdr->page->pp->p.offset;
+	src = page_address(buf->page) + buf->offset + buf->page->pp->p.offset;
+	memcpy(dst, src, ALIGN(copy, sizeof(long)));
+
+	buf->offset += copy;
+
+	return copy;
+}
+
 /**
  * idpf_rx_splitq_clean - Clean completed descriptors from Rx queue
  * @rxq: Rx descriptor queue to retrieve receive buffer queue
@@ -3113,16 +3150,16 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 	/* Process Rx packets bounded by budget */
 	while (likely(total_rx_pkts < budget)) {
 		struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
+		struct idpf_rx_buf *hdr, *rx_buf = NULL;
 		struct idpf_sw_queue *refillq = NULL;
 		struct idpf_rxq_set *rxq_set = NULL;
-		struct idpf_rx_buf *rx_buf = NULL;
 		union virtchnl2_rx_desc *desc;
 		unsigned int pkt_len = 0;
 		unsigned int hdr_len = 0;
 		u16 gen_id, buf_id = 0;
-		 /* Header buffer overflow only valid for header split */
-		bool hbo = false;
 		int bufq_id;
+		 /* Header buffer overflow only valid for header split */
+		bool hbo;
 		u8 rxdid;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
@@ -3155,26 +3192,6 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		pkt_len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_PBUF_M,
 				    pkt_len);
 
-		hbo = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_HBO_M,
-				rx_desc->status_err0_qw1);
-
-		if (unlikely(hbo)) {
-			/* If a header buffer overflow, occurs, i.e. header is
-			 * too large to fit in the header split buffer, HW will
-			 * put the entire packet, including headers, in the
-			 * data/payload buffer.
-			 */
-			u64_stats_update_begin(&rxq->stats_sync);
-			u64_stats_inc(&rxq->q_stats.rx.hsplit_buf_ovf);
-			u64_stats_update_end(&rxq->stats_sync);
-			goto bypass_hsplit;
-		}
-
-		hdr_len = le16_to_cpu(rx_desc->hdrlen_flags);
-		hdr_len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_HDR_M,
-				    hdr_len);
-
-bypass_hsplit:
 		bufq_id = le16_to_cpu(rx_desc->pktlen_gen_bufq_id);
 		bufq_id = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_BUFQ_ID_M,
 				    bufq_id);
@@ -3192,16 +3209,46 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 
 		rx_buf = &rx_bufq->rx_buf.buf[buf_id];
 
-		if (hdr_len) {
-			const void *va = (u8 *)rx_bufq->rx_buf.hdr_buf_va +
-						(u32)buf_id * IDPF_HDR_BUF_SIZE;
+		if (!rx_bufq->hdr_pp)
+			goto payload;
+
+		hbo = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_HBO_M,
+				rx_desc->status_err0_qw1);
+		if (likely(!hbo))
+			/* If a header buffer overflow, occurs, i.e. header is
+			 * too large to fit in the header split buffer, HW will
+			 * put the entire packet, including headers, in the
+			 * data/payload buffer.
+			 */
+#define __HDR_LEN_MASK VIRTCHNL2_RX_FLEX_DESC_ADV_LEN_HDR_M
+			hdr_len = le16_get_bits(rx_desc->hdrlen_flags,
+						__HDR_LEN_MASK);
+#undef __HDR_LEN_MASK
+
+		hdr = &rx_bufq->rx_buf.hdr_buf[buf_id];
+
+		if (unlikely(!hdr_len && !skb)) {
+			hdr_len = idpf_rx_hsplit_wa(hdr, rx_buf, pkt_len);
+			pkt_len -= hdr_len;
+
+			u64_stats_update_begin(&rxq->stats_sync);
+			u64_stats_inc(&rxq->q_stats.rx.hsplit_buf_ovf);
+			u64_stats_update_end(&rxq->stats_sync);
+		}
+
+		if (libie_rx_sync_for_cpu(hdr, hdr_len)) {
+			skb = idpf_rx_build_skb(hdr, hdr_len);
+			if (!skb)
+				break;
 
-			skb = idpf_rx_hdr_construct_skb(rxq, va, hdr_len);
 			u64_stats_update_begin(&rxq->stats_sync);
 			u64_stats_inc(&rxq->q_stats.rx.hsplit_pkts);
 			u64_stats_update_end(&rxq->stats_sync);
 		}
 
+		hdr->page = NULL;
+
+payload:
 		if (pkt_len) {
 			idpf_rx_sync_for_cpu(rx_buf, pkt_len);
 			if (skb)
@@ -3271,6 +3318,9 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
 				    struct virtchnl2_splitq_rx_buf_desc *buf_desc)
 {
+	struct libie_buf_queue bq = {
+		.count		= bufq->desc_count,
+	};
 	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
 	u16 buf_id;
@@ -3289,8 +3339,15 @@ static int idpf_rx_update_bufq_desc(struct idpf_queue *bufq, u16 refill_desc,
 	if (!bufq->rx_hsplit_en)
 		return 0;
 
-	buf_desc->hdr_addr = cpu_to_le64(bufq->rx_buf.hdr_buf_pa +
-					 (u32)buf_id * IDPF_HDR_BUF_SIZE);
+	bq.pp = bufq->hdr_pp;
+	bq.rx_bi = bufq->rx_buf.hdr_buf;
+	bq.truesize = bufq->hdr_truesize;
+
+	addr = libie_rx_alloc(&bq, buf_id);
+	if (addr == DMA_MAPPING_ERROR)
+		return -ENOMEM;
+
+	buf_desc->hdr_addr = cpu_to_le64(addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4a97790cbf68..357683559b57 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -99,8 +99,6 @@ do {								\
 #define IDPF_RX_BUF_STRIDE			32
 #define IDPF_RX_BUF_POST_STRIDE			16
 #define IDPF_LOW_WATERMARK			64
-/* Size of header buffer specifically for header split */
-#define IDPF_HDR_BUF_SIZE			256
 #define IDPF_PACKET_HDR_PAD	\
 	(ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN * 2)
 #define IDPF_TX_TSO_MIN_MSS			88
@@ -315,16 +313,10 @@ struct idpf_rx_extracted {
 #define IDPF_TX_MAX_DESC_DATA_ALIGNED \
 	ALIGN_DOWN(IDPF_TX_MAX_DESC_DATA, IDPF_TX_MAX_READ_REQ_SIZE)
 
-#define IDPF_RX_DMA_ATTR \
-	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 #define IDPF_RX_DESC(rxq, i)	\
 	(&(((union virtchnl2_rx_desc *)((rxq)->desc_ring))[i]))
 
-struct idpf_rx_buf {
-	struct page *page;
-	unsigned int page_offset;
-	u16 truesize;
-};
+#define idpf_rx_buf libie_rx_buffer
 
 #define IDPF_RX_MAX_PTYPE_PROTO_IDS    32
 #define IDPF_RX_MAX_PTYPE_SZ	(sizeof(struct virtchnl2_ptype) + \
@@ -627,13 +619,15 @@ struct idpf_queue {
 	union {
 		struct idpf_tx_buf *tx_buf;
 		struct {
+			struct libie_rx_buffer *hdr_buf;
 			struct idpf_rx_buf *buf;
-			dma_addr_t hdr_buf_pa;
-			void *hdr_buf_va;
 		} rx_buf;
 	};
+	struct page_pool *hdr_pp;
 	struct page_pool *pp;
 	void *desc_ring;
+
+	u32 hdr_truesize;
 	u16 idx;
 	u16 q_type;
 	u32 q_id;
@@ -885,7 +879,7 @@ static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
 					 unsigned int buf_size)
 {
 	if (buf_size == IDPF_RX_BUF_2048)
-		buf->page = page_pool_dev_alloc_frag(pool, &buf->page_offset,
+		buf->page = page_pool_dev_alloc_frag(pool, &buf->offset,
 						     buf_size);
 	else
 		buf->page = page_pool_dev_alloc_pages(pool);
@@ -895,7 +889,7 @@ static inline dma_addr_t idpf_alloc_page(struct page_pool *pool,
 
 	buf->truesize = buf_size;
 
-	return page_pool_get_dma_addr(buf->page) + buf->page_offset +
+	return page_pool_get_dma_addr(buf->page) + buf->offset +
 	       pool->p.offset;
 }
 
@@ -922,7 +916,7 @@ static inline void idpf_rx_sync_for_cpu(struct idpf_rx_buf *rx_buf, u32 len)
 
 	dma_sync_single_range_for_cpu(pp->p.dev,
 				      page_pool_get_dma_addr(page),
-				      rx_buf->page_offset + pp->p.offset, len,
+				      rx_buf->offset + pp->p.offset, len,
 				      page_pool_get_dma_dir(pp));
 }
 
@@ -970,6 +964,7 @@ void idpf_rx_add_frag(struct idpf_rx_buf *rx_buf, struct sk_buff *skb,
 struct sk_buff *idpf_rx_construct_skb(struct idpf_queue *rxq,
 				      struct idpf_rx_buf *rx_buf,
 				      unsigned int size);
+struct sk_buff *idpf_rx_build_skb(const struct libie_rx_buffer *buf, u32 size);
 bool idpf_init_rx_buf_hw_alloc(struct idpf_queue *rxq, struct idpf_rx_buf *buf);
 void idpf_rx_buf_hw_update(struct idpf_queue *rxq, u32 val);
 void idpf_tx_buf_hw_update(struct idpf_queue *tx_q, u32 val,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 98c904f4dcf5..d599c0199e22 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1636,32 +1636,38 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++, k++) {
+			const struct idpf_bufq_set *sets;
 			struct idpf_queue *rxq;
 
 			if (!idpf_is_queue_model_split(vport->rxq_model)) {
 				rxq = rx_qgrp->singleq.rxqs[j];
 				goto common_qi_fields;
 			}
+
 			rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
-			qi[k].rx_bufq1_id =
-			  cpu_to_le16(rxq->rxq_grp->splitq.bufq_sets[0].bufq.q_id);
+			sets = rxq->rxq_grp->splitq.bufq_sets;
+
+			qi[k].rx_bufq1_id = cpu_to_le16(sets[0].bufq.q_id);
 			if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP) {
 				qi[k].bufq2_ena = IDPF_BUFQ2_ENA;
 				qi[k].rx_bufq2_id =
-				  cpu_to_le16(rxq->rxq_grp->splitq.bufq_sets[1].bufq.q_id);
+					cpu_to_le16(sets[1].bufq.q_id);
 			}
 			qi[k].rx_buffer_low_watermark =
 				cpu_to_le16(rxq->rx_buffer_low_watermark);
 			if (idpf_is_feature_ena(vport, NETIF_F_GRO_HW))
 				qi[k].qflags |= cpu_to_le16(VIRTCHNL2_RXQ_RSC);
 
-common_qi_fields:
+			rxq->rx_hbuf_size = sets[0].bufq.rx_hbuf_size;
+
 			if (rxq->rx_hsplit_en) {
 				qi[k].qflags |=
 					cpu_to_le16(VIRTCHNL2_RXQ_HDR_SPLIT);
 				qi[k].hdr_buffer_size =
 					cpu_to_le16(rxq->rx_hbuf_size);
 			}
+
+common_qi_fields:
 			qi[k].queue_id = cpu_to_le32(rxq->q_id);
 			qi[k].model = cpu_to_le16(vport->rxq_model);
 			qi[k].type = cpu_to_le32(rxq->q_type);
-- 
2.43.0


