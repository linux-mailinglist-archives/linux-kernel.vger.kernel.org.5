Return-Path: <linux-kernel+bounces-10224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186781D18D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1883C28361F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E110979;
	Sat, 23 Dec 2023 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQz/WXLy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9710798;
	Sat, 23 Dec 2023 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300315; x=1734836315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NYAAWOP0iCM4cesVBIAO//J8ovtZjd+T6TbmxzFlxK8=;
  b=ZQz/WXLy9Xo3vJtDnv/c8Eu5NBCocVnOFeWzsGlr1Y5czo6//HhshO3/
   45y2fG2oV6ID1DRc2A7mAvleEzSQV13lZrO5xZ62+k4OrmBXHjtaBrCPs
   k1ID2XCfslwpvTJ63Rml6sImmVShzN8N/GqjHaMGzXy8KetInwOUFIHux
   OFsEWrBjo3bbnOVunwbFSbaatKrUDO2YOhUc0cRLDdJ0Zvi24Z97V080F
   8d7ITDlurlRoIJzMxOVWCC73T1n0bUhxDhAIClFRQYtWMPAQTJaN/dQEs
   QVPXMcuYYqLlGcKGw5C0MirU8iTieQ54wD7qHP+myeesRRvoWuVLXR2+4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610832"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610832"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537459"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:31 -0800
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
Subject: [PATCH RFC net-next 08/34] idpf: convert to libie Tx buffer completion
Date: Sat, 23 Dec 2023 03:55:28 +0100
Message-ID: <20231223025554.2316836-9-aleksander.lobakin@intel.com>
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

&idpf_tx_buffer is almost identical to the previous generations, as well
as the way it's handled. Moreover, relying on dma_unmap_addr() and
!!buf->skb instead of explicit defining of buffer's type was never good.
Use the newly added libie helpers to do it properly and reduce the
copy-paste around the Tx code.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  38 ++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 107 +++---------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  43 +------
 3 files changed, 31 insertions(+), 157 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 63a709743037..23dcc02e6976 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -190,6 +190,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 				struct idpf_tx_buf *first,
 				struct idpf_tx_offload_params *offloads)
 {
+	enum libie_tx_buf_type type = LIBIE_TX_BUF_SKB;
 	u32 offsets = offloads->hdr_offsets;
 	struct idpf_tx_buf *tx_buf = first;
 	struct idpf_base_tx_desc *tx_desc;
@@ -219,6 +220,8 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 		if (dma_mapping_error(tx_q->dev, dma))
 			return idpf_tx_dma_map_error(tx_q, skb, first, i);
 
+		tx_buf->type = type;
+
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buf, len, size);
 		dma_unmap_addr_set(tx_buf, dma, dma);
@@ -270,6 +273,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_q->tx_buf[i];
+		type = LIBIE_TX_BUF_FRAG;
 	}
 
 	skb_tx_timestamp(first->skb);
@@ -447,7 +451,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 				  int *cleaned)
 {
 	unsigned int budget = tx_q->vport->compln_clean_budget;
-	unsigned int total_bytes = 0, total_pkts = 0;
+	struct libie_sq_onstack_stats ss = { };
 	struct idpf_base_tx_desc *tx_desc;
 	s16 ntc = tx_q->next_to_clean;
 	struct idpf_netdev_priv *np;
@@ -495,20 +499,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 		tx_buf->next_to_watch = NULL;
 
 		/* update the statistics for this packet */
-		total_bytes += tx_buf->bytecount;
-		total_pkts += tx_buf->gso_segs;
-
-		napi_consume_skb(tx_buf->skb, napi_budget);
-
-		/* unmap skb header data */
-		dma_unmap_single(tx_q->dev,
-				 dma_unmap_addr(tx_buf, dma),
-				 dma_unmap_len(tx_buf, len),
-				 DMA_TO_DEVICE);
-
-		/* clear tx_buf data */
-		tx_buf->skb = NULL;
-		dma_unmap_len_set(tx_buf, len, 0);
+		libie_tx_complete_buf(tx_buf, tx_q->dev, !!napi_budget, &ss);
 
 		/* unmap remaining buffers */
 		while (tx_desc != eop_desc) {
@@ -522,13 +513,8 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 			}
 
 			/* unmap any remaining paged data */
-			if (dma_unmap_len(tx_buf, len)) {
-				dma_unmap_page(tx_q->dev,
-					       dma_unmap_addr(tx_buf, dma),
-					       dma_unmap_len(tx_buf, len),
-					       DMA_TO_DEVICE);
-				dma_unmap_len_set(tx_buf, len, 0);
-			}
+			libie_tx_complete_buf(tx_buf, tx_q->dev, !!napi_budget,
+					      &ss);
 		}
 
 		/* update budget only if we did something */
@@ -548,11 +534,11 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 	ntc += tx_q->desc_count;
 	tx_q->next_to_clean = ntc;
 
-	*cleaned += total_pkts;
+	*cleaned += ss.packets;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_add(&tx_q->q_stats.tx.packets, total_pkts);
-	u64_stats_add(&tx_q->q_stats.tx.bytes, total_bytes);
+	u64_stats_add(&tx_q->q_stats.tx.packets, ss.packets);
+	u64_stats_add(&tx_q->q_stats.tx.bytes, ss.bytes);
 	u64_stats_update_end(&tx_q->stats_sync);
 
 	vport = tx_q->vport;
@@ -561,7 +547,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 
 	dont_wake = np->state != __IDPF_VPORT_UP ||
 		    !netif_carrier_ok(vport->netdev);
-	__netif_txq_completed_wake(nq, total_pkts, total_bytes,
+	__netif_txq_completed_wake(nq, ss.packets, ss.bytes,
 				   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
 				   dont_wake);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c44737e243b0..6fd9128e61d8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -54,39 +54,13 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	}
 }
 
-/**
- * idpf_tx_buf_rel - Release a Tx buffer
- * @tx_q: the queue that owns the buffer
- * @tx_buf: the buffer to free
- */
-static void idpf_tx_buf_rel(struct idpf_queue *tx_q, struct idpf_tx_buf *tx_buf)
-{
-	if (tx_buf->skb) {
-		if (dma_unmap_len(tx_buf, len))
-			dma_unmap_single(tx_q->dev,
-					 dma_unmap_addr(tx_buf, dma),
-					 dma_unmap_len(tx_buf, len),
-					 DMA_TO_DEVICE);
-		dev_kfree_skb_any(tx_buf->skb);
-	} else if (dma_unmap_len(tx_buf, len)) {
-		dma_unmap_page(tx_q->dev,
-			       dma_unmap_addr(tx_buf, dma),
-			       dma_unmap_len(tx_buf, len),
-			       DMA_TO_DEVICE);
-	}
-
-	tx_buf->next_to_watch = NULL;
-	tx_buf->skb = NULL;
-	tx_buf->compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
-	dma_unmap_len_set(tx_buf, len, 0);
-}
-
 /**
  * idpf_tx_buf_rel_all - Free any empty Tx buffers
  * @txq: queue to be cleaned
  */
 static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
 {
+	struct libie_sq_onstack_stats ss = { };
 	u16 i;
 
 	/* Buffers already cleared, nothing to do */
@@ -95,7 +69,7 @@ static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
 
 	/* Free all the Tx buffer sk_buffs */
 	for (i = 0; i < txq->desc_count; i++)
-		idpf_tx_buf_rel(txq, &txq->tx_buf[i]);
+		libie_tx_complete_buf(&txq->tx_buf[i], txq->dev, false, &ss);
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -1505,37 +1479,6 @@ static void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
 	wake_up(&vport->sw_marker_wq);
 }
 
-/**
- * idpf_tx_splitq_clean_hdr - Clean TX buffer resources for header portion of
- * packet
- * @tx_q: tx queue to clean buffer from
- * @tx_buf: buffer to be cleaned
- * @cleaned: pointer to stats struct to track cleaned packets/bytes
- * @napi_budget: Used to determine if we are in netpoll
- */
-static void idpf_tx_splitq_clean_hdr(struct idpf_queue *tx_q,
-				     struct idpf_tx_buf *tx_buf,
-				     struct idpf_cleaned_stats *cleaned,
-				     int napi_budget)
-{
-	napi_consume_skb(tx_buf->skb, napi_budget);
-
-	if (dma_unmap_len(tx_buf, len)) {
-		dma_unmap_single(tx_q->dev,
-				 dma_unmap_addr(tx_buf, dma),
-				 dma_unmap_len(tx_buf, len),
-				 DMA_TO_DEVICE);
-
-		dma_unmap_len_set(tx_buf, len, 0);
-	}
-
-	/* clear tx_buf data */
-	tx_buf->skb = NULL;
-
-	cleaned->bytes += tx_buf->bytecount;
-	cleaned->packets += tx_buf->gso_segs;
-}
-
 /**
  * idpf_tx_clean_stashed_bufs - clean bufs that were stored for
  * out of order completions
@@ -1557,16 +1500,8 @@ static void idpf_tx_clean_stashed_bufs(struct idpf_queue *txq, u16 compl_tag,
 		if (unlikely(stash->buf.compl_tag != (int)compl_tag))
 			continue;
 
-		if (stash->buf.skb) {
-			idpf_tx_splitq_clean_hdr(txq, &stash->buf, cleaned,
-						 budget);
-		} else if (dma_unmap_len(&stash->buf, len)) {
-			dma_unmap_page(txq->dev,
-				       dma_unmap_addr(&stash->buf, dma),
-				       dma_unmap_len(&stash->buf, len),
-				       DMA_TO_DEVICE);
-			dma_unmap_len_set(&stash->buf, len, 0);
-		}
+		libie_tx_complete_buf(&stash->buf, txq->dev, !!budget,
+				      cleaned);
 
 		/* Push shadow buf back onto stack */
 		idpf_buf_lifo_push(&txq->buf_stack, stash);
@@ -1599,6 +1534,7 @@ static int idpf_stash_flow_sch_buffers(struct idpf_queue *txq,
 	}
 
 	/* Store buffer params in shadow buffer */
+	stash->buf.type = tx_buf->type;
 	stash->buf.skb = tx_buf->skb;
 	stash->buf.bytecount = tx_buf->bytecount;
 	stash->buf.gso_segs = tx_buf->gso_segs;
@@ -1693,8 +1629,8 @@ static void idpf_tx_splitq_clean(struct idpf_queue *tx_q, u16 end,
 				}
 			}
 		} else {
-			idpf_tx_splitq_clean_hdr(tx_q, tx_buf, cleaned,
-						 napi_budget);
+			libie_tx_complete_buf(tx_buf, tx_q->dev, !!napi_budget,
+					      cleaned);
 
 			/* unmap remaining buffers */
 			while (tx_desc != eop_desc) {
@@ -1702,13 +1638,8 @@ static void idpf_tx_splitq_clean(struct idpf_queue *tx_q, u16 end,
 							      tx_desc, tx_buf);
 
 				/* unmap any remaining paged data */
-				if (dma_unmap_len(tx_buf, len)) {
-					dma_unmap_page(tx_q->dev,
-						       dma_unmap_addr(tx_buf, dma),
-						       dma_unmap_len(tx_buf, len),
-						       DMA_TO_DEVICE);
-					dma_unmap_len_set(tx_buf, len, 0);
-				}
+				libie_tx_complete_buf(tx_buf, tx_q->dev,
+						      !!napi_budget, cleaned);
 			}
 		}
 
@@ -1756,18 +1687,7 @@ static bool idpf_tx_clean_buf_ring(struct idpf_queue *txq, u16 compl_tag,
 	tx_buf = &txq->tx_buf[idx];
 
 	while (tx_buf->compl_tag == (int)compl_tag) {
-		if (tx_buf->skb) {
-			idpf_tx_splitq_clean_hdr(txq, tx_buf, cleaned, budget);
-		} else if (dma_unmap_len(tx_buf, len)) {
-			dma_unmap_page(txq->dev,
-				       dma_unmap_addr(tx_buf, dma),
-				       dma_unmap_len(tx_buf, len),
-				       DMA_TO_DEVICE);
-			dma_unmap_len_set(tx_buf, len, 0);
-		}
-
-		memset(tx_buf, 0, sizeof(struct idpf_tx_buf));
-		tx_buf->compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
+		libie_tx_complete_buf(tx_buf, txq->dev, !!budget, cleaned);
 
 		num_descs_cleaned++;
 		idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
@@ -2161,6 +2081,8 @@ unsigned int idpf_tx_desc_count_required(struct idpf_queue *txq,
 void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 idx)
 {
+	struct libie_sq_onstack_stats ss = { };
+
 	u64_stats_update_begin(&txq->stats_sync);
 	u64_stats_inc(&txq->q_stats.tx.dma_map_errs);
 	u64_stats_update_end(&txq->stats_sync);
@@ -2170,7 +2092,7 @@ void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
 		struct idpf_tx_buf *tx_buf;
 
 		tx_buf = &txq->tx_buf[idx];
-		idpf_tx_buf_rel(txq, tx_buf);
+		libie_tx_complete_buf(tx_buf, txq->dev, false, &ss);
 		if (tx_buf == first)
 			break;
 		if (idx == 0)
@@ -2227,6 +2149,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 			       struct idpf_tx_splitq_params *params,
 			       struct idpf_tx_buf *first)
 {
+	enum libie_tx_buf_type type = LIBIE_TX_BUF_SKB;
 	union idpf_tx_flex_desc *tx_desc;
 	unsigned int data_len, size;
 	struct idpf_tx_buf *tx_buf;
@@ -2259,6 +2182,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 		if (dma_mapping_error(tx_q->dev, dma))
 			return idpf_tx_dma_map_error(tx_q, skb, first, i);
 
+		tx_buf->type = type;
 		tx_buf->compl_tag = params->compl_tag;
 
 		/* record length, and DMA address */
@@ -2374,6 +2298,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 				       DMA_TO_DEVICE);
 
 		tx_buf = &tx_q->tx_buf[i];
+		type = LIBIE_TX_BUF_FRAG;
 	}
 
 	/* record SW timestamp if HW timestamp is not available */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 0bbc654a24b9..5975c6d029d7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -5,6 +5,7 @@
 #define _IDPF_TXRX_H_
 
 #include <linux/net/intel/libie/rx.h>
+#include <linux/net/intel/libie/tx.h>
 
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
@@ -165,42 +166,7 @@ union idpf_tx_flex_desc {
 	struct idpf_flex_tx_sched_desc flow; /* flow based scheduling */
 };
 
-/**
- * struct idpf_tx_buf
- * @next_to_watch: Next descriptor to clean
- * @skb: Pointer to the skb
- * @dma: DMA address
- * @len: DMA length
- * @bytecount: Number of bytes
- * @gso_segs: Number of GSO segments
- * @compl_tag: Splitq only, unique identifier for a buffer. Used to compare
- *	       with completion tag returned in buffer completion event.
- *	       Because the completion tag is expected to be the same in all
- *	       data descriptors for a given packet, and a single packet can
- *	       span multiple buffers, we need this field to track all
- *	       buffers associated with this completion tag independently of
- *	       the buf_id. The tag consists of a N bit buf_id and M upper
- *	       order "generation bits". See compl_tag_bufid_m and
- *	       compl_tag_gen_s in struct idpf_queue. We'll use a value of -1
- *	       to indicate the tag is not valid.
- * @ctx_entry: Singleq only. Used to indicate the corresponding entry
- *	       in the descriptor ring was used for a context descriptor and
- *	       this buffer entry should be skipped.
- */
-struct idpf_tx_buf {
-	void *next_to_watch;
-	struct sk_buff *skb;
-	DEFINE_DMA_UNMAP_ADDR(dma);
-	DEFINE_DMA_UNMAP_LEN(len);
-	unsigned int bytecount;
-	unsigned short gso_segs;
-
-	union {
-		int compl_tag;
-
-		bool ctx_entry;
-	};
-};
+#define idpf_tx_buf libie_tx_buffer
 
 struct idpf_tx_stash {
 	struct hlist_node hlist;
@@ -493,10 +459,7 @@ struct idpf_tx_queue_stats {
 	u64_stats_t dma_map_errs;
 };
 
-struct idpf_cleaned_stats {
-	u32 packets;
-	u32 bytes;
-};
+#define idpf_cleaned_stats libie_sq_onstack_stats
 
 union idpf_queue_stats {
 	struct idpf_rx_queue_stats rx;
-- 
2.43.0


