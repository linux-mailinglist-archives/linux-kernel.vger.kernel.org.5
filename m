Return-Path: <linux-kernel+bounces-10240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419B81D1AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3672E1C22A19
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE30374E3;
	Sat, 23 Dec 2023 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQuu/OFl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279E364CB;
	Sat, 23 Dec 2023 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300378; x=1734836378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Hl8jA0nkF3VRC2QZ5shDCjQ+QpnIc5D2V4s/YyOE+s=;
  b=ZQuu/OFlK7i3mgwG2XiHSoRpJ65clNjI4eU2Fz6yRSAXBx80CU2o0PbU
   PjcNDSHBbWCKrQmHetpeH7ovq0xxRVX2hAoOIWndOOlo3HSdbd2tQIMKD
   9s0EUBcoKd5eCcuRLaucJyxJoLbqrM0ReM3NDGchNZcNd4BXSwUMloRrO
   fzSXMWfHz3VFSb1E0x2vHUMn8MXG5k0iEXSbxTKg0KDfE6DfAEXHdnpLm
   QTNmi5yI4ANDE1MNypjMvvrO91sqY0uj4miKthU63fVwhgqdIKGwlc6Ep
   nPvJpO8187GQMv2poWHfeMlMSBJ8K4ADMau1v2rlq+QrtimVHWV5co2Jv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611025"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611025"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537622"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:34 -0800
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
Subject: [PATCH RFC net-next 24/34] idpf: add support for XDP on Rx
Date: Sat, 23 Dec 2023 03:55:44 +0100
Message-ID: <20231223025554.2316836-25-aleksander.lobakin@intel.com>
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

Use libie XDP infra to support running XDP program on Rx polling.
This includes all of the possible verdicts/actions.
XDP Tx queues are cleaned only in "lazy" mode when there are less than
1/4 free descriptors left on the ring. Some functions are oneliners
around libie's __always_inlines, so that the compiler could uninline
them when needed.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   6 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  10 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  55 ++++++++
 drivers/net/ethernet/intel/idpf/idpf_xdp.c  | 140 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xdp.h  |  20 ++-
 5 files changed, 227 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 01130e7c4d2e..a19704c4c421 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -840,6 +840,12 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->features |= dflt_features;
 	netdev->hw_features |= dflt_features | offloads;
 	netdev->hw_enc_features |= dflt_features | offloads;
+
+	if (idpf_is_queue_model_split(vport->rxq_model))
+		xdp_set_features_flag(netdev, NETDEV_XDP_ACT_BASIC |
+					      NETDEV_XDP_ACT_REDIRECT |
+					      NETDEV_XDP_ACT_RX_SG);
+
 	idpf_set_ethtool_ops(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index cbbb6bf85b19..99c9b889507b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1522,7 +1522,7 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
  * idpf_tx_handle_sw_marker - Handle queue marker packet
  * @tx_q: tx queue to handle software marker
  */
-static void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
+void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q)
 {
 	struct idpf_vport *vport = tx_q->vport;
 	int i;
@@ -3045,8 +3045,11 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 	int total_rx_bytes = 0, total_rx_pkts = 0;
 	struct idpf_queue *rx_bufq = NULL;
 	u16 ntc = rxq->next_to_clean;
+	struct libie_xdp_tx_bulk bq;
 	struct xdp_buff xdp;
 
+	libie_xdp_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
+			       rxq->xdpqs, rxq->num_xdp_txq);
 	libie_xdp_init_buff(&xdp, &rxq->xdp, &rxq->xdp_rxq);
 
 	/* Process Rx packets bounded by budget */
@@ -3161,6 +3164,9 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		total_rx_bytes += xdp_get_buff_len(&xdp);
 		total_rx_pkts++;
 
+		if (!idpf_xdp_run_prog(&xdp, &bq))
+			continue;
+
 		skb = xdp_build_skb_from_buff(&xdp);
 		if (unlikely(!skb)) {
 			xdp_return_buff(&xdp);
@@ -3182,7 +3188,9 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 	}
 
 	rxq->next_to_clean = ntc;
+
 	libie_xdp_save_buff(&rxq->xdp, &xdp);
+	idpf_xdp_finalize_rx(&bq);
 
 	u64_stats_update_begin(&rxq->stats_sync);
 	u64_stats_add(&rxq->q_stats.rx.packets, total_rx_pkts);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 318241020347..20f484712ac2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -135,6 +135,8 @@ do {								\
 	((++(txq)->compl_tag_cur_gen) >= (txq)->compl_tag_gen_max ? \
 	0 : (txq)->compl_tag_cur_gen)
 
+#define IDPF_QUEUE_QUARTER(Q)		((Q)->desc_count >> 2)
+
 #define IDPF_TXD_LAST_DESC_CMD (IDPF_TX_DESC_CMD_EOP | IDPF_TX_DESC_CMD_RS)
 
 #define IDPF_TX_FLAGS_TSO		BIT(0)
@@ -939,5 +941,58 @@ netdev_tx_t idpf_tx_singleq_start(struct sk_buff *skb,
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
+void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q);
+
+/**
+ * idpf_xdpq_update_tail - Updates the XDP Tx queue tail register
+ * @xdpq: XDP Tx queue
+ *
+ * This function updates the XDP Tx queue tail register.
+ */
+static inline void idpf_xdpq_update_tail(const struct idpf_queue *xdpq)
+{
+	/* Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.
+	 */
+	wmb();
+	writel_relaxed(xdpq->next_to_use, xdpq->tail);
+}
+
+/**
+ * idpf_set_rs_bit - set RS bit on last produced descriptor.
+ * @xdpq: XDP queue to produce the HW Tx descriptors on
+ *
+ * Returns the index of descriptor RS bit was set on (one behind current NTU).
+ */
+static inline void idpf_set_rs_bit(const struct idpf_queue *xdpq)
+{
+	int rs_idx = xdpq->next_to_use ? xdpq->next_to_use - 1 :
+					 xdpq->desc_count - 1;
+	union idpf_tx_flex_desc *tx_desc;
+
+	tx_desc = &xdpq->flex_tx[rs_idx];
+	tx_desc->q.qw1.cmd_dtype |= le16_encode_bits(IDPF_TXD_LAST_DESC_CMD,
+						     IDPF_FLEX_TXD_QW1_CMD_M);
+}
+
+/**
+ * idpf_xdp_tx_finalize - Bump XDP Tx tail and/or flush redirect map
+ * @xdpq: XDP Tx queue
+ *
+ * This function bumps XDP Tx tail and should be called when a batch of packets
+ * has been processed in the napi loop.
+ */
+static inline void idpf_xdp_tx_finalize(void *_xdpq, bool tail)
+{
+	struct idpf_queue *xdpq = _xdpq;
+
+	libie_xdp_sq_lock(&xdpq->xdp_lock);
+
+	idpf_set_rs_bit(xdpq);
+	if (tail)
+		idpf_xdpq_update_tail(xdpq);
+
+	libie_xdp_sq_unlock(&xdpq->xdp_lock);
+}
 
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.c b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
index 87d147e80047..b9952ebda4fb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xdp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
@@ -173,6 +173,146 @@ void idpf_vport_xdpq_put(const struct idpf_vport *vport)
 	cpus_read_unlock();
 }
 
+/**
+ * idpf_clean_xdp_irq - Reclaim a batch of TX resources from completed XDP_TX
+ * @xdpq: XDP Tx queue
+ *
+ * Returns number of cleaned descriptors.
+ */
+static u32 idpf_clean_xdp_irq(struct idpf_queue *xdpq)
+{
+	struct idpf_queue *complq = xdpq->txq_grp->complq, *txq;
+	struct idpf_splitq_4b_tx_compl_desc *last_rs_desc;
+	struct libie_sq_onstack_stats ss = { };
+	int complq_budget = complq->desc_count;
+	u32 tx_ntc = xdpq->next_to_clean;
+	u32 ntc = complq->next_to_clean;
+	u32 cnt = xdpq->desc_count;
+	u32 done_frames = 0, i = 0;
+	struct xdp_frame_bulk bq;
+	int head = tx_ntc;
+	bool gen_flag;
+
+	last_rs_desc = &complq->comp_4b[ntc];
+	gen_flag = test_bit(__IDPF_Q_GEN_CHK, complq->flags);
+
+	do {
+		int ctype = idpf_parse_compl_desc(last_rs_desc, complq,
+						  &txq, gen_flag);
+		if (likely(ctype == IDPF_TXD_COMPLT_RS)) {
+			head = le16_to_cpu(last_rs_desc->q_head_compl_tag.q_head);
+			goto fetch_next_desc;
+		}
+
+		switch (ctype) {
+		case IDPF_TXD_COMPLT_SW_MARKER:
+			idpf_tx_handle_sw_marker(xdpq);
+			break;
+		case -ENODATA:
+			goto exit_xdp_irq;
+		case -EINVAL:
+			break;
+		default:
+			dev_err(&xdpq->vport->adapter->pdev->dev,
+				"Unsupported completion type for XDP\n");
+			break;
+		}
+
+fetch_next_desc:
+		last_rs_desc++;
+		ntc++;
+		if (unlikely(ntc == complq->desc_count)) {
+			ntc = 0;
+			last_rs_desc = &complq->comp_4b[0];
+			gen_flag = !gen_flag;
+			change_bit(__IDPF_Q_GEN_CHK, complq->flags);
+		}
+		prefetch(last_rs_desc);
+		complq_budget--;
+	} while (likely(complq_budget));
+
+exit_xdp_irq:
+	complq->next_to_clean = ntc;
+	done_frames = head >= tx_ntc ? head - tx_ntc :
+				       head + cnt - tx_ntc;
+
+	xdp_frame_bulk_init(&bq);
+
+	for (i = 0; i < done_frames; i++) {
+		libie_xdp_complete_tx_buf(&xdpq->tx_buf[tx_ntc], xdpq->dev,
+					  true, &bq, &xdpq->xdp_tx_active,
+					  &ss);
+
+		if (unlikely(++tx_ntc == cnt))
+			tx_ntc = 0;
+	}
+
+	xdpq->next_to_clean = tx_ntc;
+
+	xdp_flush_frame_bulk(&bq);
+	libie_sq_napi_stats_add((struct libie_sq_stats *)&xdpq->q_stats.tx,
+				&ss);
+
+	return i;
+}
+
+static u32 idpf_xdp_tx_prep(void *_xdpq, struct libie_xdp_tx_queue *sq)
+{
+	struct idpf_queue *xdpq = _xdpq;
+	u32 free;
+
+	libie_xdp_sq_lock(&xdpq->xdp_lock);
+
+	free = IDPF_DESC_UNUSED(xdpq);
+	if (unlikely(free < IDPF_QUEUE_QUARTER(xdpq)))
+		free += idpf_clean_xdp_irq(xdpq);
+
+	*sq = (struct libie_xdp_tx_queue){
+		.dev		= xdpq->dev,
+		.tx_buf		= xdpq->tx_buf,
+		.desc_ring	= xdpq->desc_ring,
+		.xdp_lock	= &xdpq->xdp_lock,
+		.next_to_use	= &xdpq->next_to_use,
+		.desc_count	= xdpq->desc_count,
+		.xdp_tx_active	= &xdpq->xdp_tx_active,
+	};
+
+	return free;
+}
+
+static void idpf_xdp_tx_xmit(struct libie_xdp_tx_desc desc,
+			     const struct libie_xdp_tx_queue *sq)
+{
+	union idpf_tx_flex_desc *tx_desc = sq->desc_ring;
+	struct idpf_tx_splitq_params tx_params = {
+		.dtype		= IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2,
+		.eop_cmd	= IDPF_TX_DESC_CMD_EOP,
+	};
+
+	tx_desc = &tx_desc[*sq->next_to_use];
+	tx_desc->q.buf_addr = cpu_to_le64(desc.addr);
+
+	idpf_tx_splitq_build_desc(tx_desc, &tx_params,
+				  tx_params.eop_cmd | tx_params.offload.td_cmd,
+				  desc.len);
+}
+
+static bool idpf_xdp_tx_flush_bulk(struct libie_xdp_tx_bulk *bq)
+{
+	return libie_xdp_tx_flush_bulk(bq, idpf_xdp_tx_prep, idpf_xdp_tx_xmit);
+}
+
+void __idpf_xdp_finalize_rx(struct libie_xdp_tx_bulk *bq)
+{
+	libie_xdp_finalize_rx(bq, idpf_xdp_tx_flush_bulk,
+			      idpf_xdp_tx_finalize);
+}
+
+bool __idpf_xdp_run_prog(struct xdp_buff *xdp, struct libie_xdp_tx_bulk *bq)
+{
+	return libie_xdp_run_prog(xdp, bq, idpf_xdp_tx_flush_bulk);
+}
+
 /**
  * idpf_xdp_reconfig_queues - reconfigure queues after the XDP setup
  * @vport: vport to load or unload XDP for
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.h b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
index 1d102b1fd2ac..1f299c268ca5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xdp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
@@ -4,10 +4,9 @@
 #ifndef _IDPF_XDP_H_
 #define _IDPF_XDP_H_
 
-struct bpf_prog;
+#include <linux/net/intel/libie/xdp.h>
+
 struct idpf_vport;
-struct net_device;
-struct netdev_bpf;
 
 int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
 void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
@@ -17,6 +16,21 @@ void idpf_copy_xdp_prog_to_qs(const struct idpf_vport *vport,
 void idpf_vport_xdpq_get(const struct idpf_vport *vport);
 void idpf_vport_xdpq_put(const struct idpf_vport *vport);
 
+bool __idpf_xdp_run_prog(struct xdp_buff *xdp, struct libie_xdp_tx_bulk *bq);
+void __idpf_xdp_finalize_rx(struct libie_xdp_tx_bulk *bq);
+
+static inline bool idpf_xdp_run_prog(struct xdp_buff *xdp,
+				     struct libie_xdp_tx_bulk *bq)
+{
+	return bq->prog ? __idpf_xdp_run_prog(xdp, bq) : true;
+}
+
+static inline void idpf_xdp_finalize_rx(struct libie_xdp_tx_bulk *bq)
+{
+	if (bq->act_mask >= LIBIE_XDP_TX)
+		__idpf_xdp_finalize_rx(bq);
+}
+
 int idpf_xdp(struct net_device *netdev, struct netdev_bpf *xdp);
 
 #endif /* _IDPF_XDP_H_ */
-- 
2.43.0


