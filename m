Return-Path: <linux-kernel+bounces-10248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B850681D1BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2363EB229E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAA3DB98;
	Sat, 23 Dec 2023 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf4oE3C3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3C3D984;
	Sat, 23 Dec 2023 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300410; x=1734836410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9m+hJARl+7l9gBAwp/JVuXNb4MiWER0ftpx5hz4sFLg=;
  b=Cf4oE3C3NZ15qE3PoyiWTz+LeMUB9SKZYFT8xAUYhEud2J1yw5jd2o/Y
   RM/CG08yvQA5wvd/g+8J7EuMGzzBLnpKRAhTdxvdHQz1sPfon8MtAylEn
   dvzeX9KFEHPmUL5JCssFBfpRbQPd4M8PTD58sHLlEw+Ti8M/lupoTd2J+
   L9qlk7y2/VSaV3OJBNBwVWcMV0Jbc6HHAuXMNXKXlgk2jk1xrdcPusRAm
   XoUv5jj/OqrkZQs7RnxtqNUM/0iA16RGne3Y3UJtIKbweGMkkwB/tGP7y
   1sgKGdrSgAX52dYKzYjSglrOAx2HXMtXC/mLtuikZ+IMpdADiEpYU5GqU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611098"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537683"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 19:00:06 -0800
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
Subject: [PATCH RFC net-next 32/34] idpf: implement Tx path for AF_XDP
Date: Sat, 23 Dec 2023 03:55:52 +0100
Message-ID: <20231223025554.2316836-33-aleksander.lobakin@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

Implement Tx handling for AF_XDP feature in zero-copy mode using
the libie XSk infra.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  44 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |   4 +
 drivers/net/ethernet/intel/idpf/idpf_xsk.c  | 318 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xsk.h  |   9 +
 4 files changed, 361 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e3f59bbe7c90..5ba880c2bedc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_xdp.h"
+#include "idpf_xsk.h"
 
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
@@ -55,30 +56,36 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	}
 }
 
-/**
- * idpf_tx_buf_rel_all - Free any empty Tx buffers
- * @txq: queue to be cleaned
- */
-static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
+static void idpf_tx_buf_clean(struct idpf_queue *txq)
 {
 	struct libie_sq_onstack_stats ss = { };
 	struct xdp_frame_bulk bq;
-	u16 i;
-
-	/* Buffers already cleared, nothing to do */
-	if (!txq->tx_buf)
-		return;
 
 	xdp_frame_bulk_init(&bq);
 	rcu_read_lock();
 
-	/* Free all the Tx buffer sk_buffs */
-	for (i = 0; i < txq->desc_count; i++)
+	for (u32 i = 0; i < txq->desc_count; i++)
 		libie_tx_complete_any(&txq->tx_buf[i], txq->dev, &bq,
 				      &txq->xdp_tx_active, &ss);
 
 	xdp_flush_frame_bulk(&bq);
 	rcu_read_unlock();
+}
+
+/**
+ * idpf_tx_buf_rel_all - Free any empty Tx buffers
+ * @txq: queue to be cleaned
+ */
+static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
+{
+	/* Buffers already cleared, nothing to do */
+	if (!txq->tx_buf)
+		return;
+
+	if (test_bit(__IDPF_Q_XSK, txq->flags))
+		idpf_xsk_clean_xdpq(txq);
+	else
+		idpf_tx_buf_clean(txq);
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -86,7 +93,7 @@ static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
 	if (!txq->buf_stack.bufs)
 		return;
 
-	for (i = 0; i < txq->buf_stack.size; i++)
+	for (u32 i = 0; i < txq->buf_stack.size; i++)
 		kfree(txq->buf_stack.bufs[i]);
 
 	kfree(txq->buf_stack.bufs);
@@ -105,6 +112,8 @@ void idpf_tx_desc_rel(struct idpf_queue *txq, bool bufq)
 	if (bufq)
 		idpf_tx_buf_rel_all(txq);
 
+	idpf_xsk_clear_queue(txq);
+
 	if (!txq->desc_ring)
 		return;
 
@@ -196,6 +205,7 @@ static int idpf_tx_buf_alloc_all(struct idpf_queue *tx_q)
  */
 int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
 {
+	enum virtchnl2_queue_type type;
 	struct device *dev = tx_q->dev;
 	u32 desc_sz;
 	int err;
@@ -228,6 +238,10 @@ int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
 	tx_q->next_to_clean = 0;
 	set_bit(__IDPF_Q_GEN_CHK, tx_q->flags);
 
+	type = bufq ? VIRTCHNL2_QUEUE_TYPE_TX :
+	       VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
+	idpf_xsk_setup_queue(tx_q, type);
+
 	return 0;
 
 err_alloc:
@@ -3802,7 +3816,9 @@ static bool idpf_tx_splitq_clean_all(struct idpf_q_vector *q_vec,
 	for (i = 0; i < num_txq; i++) {
 		struct idpf_queue *cq = q_vec->tx[i];
 
-		if (!test_bit(__IDPF_Q_XDP, cq->flags))
+		if (test_bit(__IDPF_Q_XSK, cq->flags))
+			clean_complete &= idpf_xmit_zc(cq);
+		else if (!test_bit(__IDPF_Q_XDP, cq->flags))
 			clean_complete &= idpf_tx_clean_complq(cq,
 							       budget_per_q,
 							       cleaned);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index be396f1e346a..d55ff6aaae2b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -313,6 +313,7 @@ struct idpf_ptype_state {
  * @__IDPF_Q_SW_MARKER: Used to indicate TX queue marker completions
  * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_FLAGS_NBITS: Must be last
+ * @__IDPF_Q_XSK: Queue used to handle the AF_XDP socket
  */
 enum idpf_queue_flags_t {
 	__IDPF_Q_GEN_CHK,
@@ -321,6 +322,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_SW_MARKER,
 	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_XDP,
+	__IDPF_Q_XSK,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -574,10 +576,12 @@ struct idpf_queue {
 	union {
 		struct page_pool *hdr_pp;
 		struct idpf_queue **xdpqs;
+		struct xsk_buff_pool *xsk_tx;
 	};
 	union {
 		struct page_pool *pp;
 		struct device *dev;
+		struct xsk_buff_pool *xsk_rx;
 	};
 	union {
 		union virtchnl2_rx_desc *rx;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.c b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
index 3017680fedb3..6f1870c05948 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xsk.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
@@ -6,6 +6,89 @@
 #include "idpf.h"
 #include "idpf_xsk.h"
 
+/**
+ * idpf_xsk_setup_queue - set xsk_pool pointer from netdev to the queue structure
+ * @q: queue to use
+ *
+ * Assigns pointer to xsk_pool field in queue struct if it is supported in
+ * netdev, NULL otherwise.
+ */
+void idpf_xsk_setup_queue(struct idpf_queue *q, enum virtchnl2_queue_type t)
+{
+	struct idpf_vport_user_config_data *cfg_data;
+	struct idpf_vport *vport = q->vport;
+	struct xsk_buff_pool *pool;
+	bool is_rx = false;
+	int qid;
+
+	__clear_bit(__IDPF_Q_XSK, q->flags);
+
+	if (!idpf_xdp_is_prog_ena(q->vport))
+		return;
+
+	switch (t) {
+	case VIRTCHNL2_QUEUE_TYPE_RX:
+		is_rx = true;
+		qid = q->idx;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+		is_rx = true;
+		qid = q->rxq_grp->splitq.rxq_sets[0]->rxq.idx;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_TX:
+		qid = q->idx - q->vport->xdp_txq_offset;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+		qid = q->txq_grp->txqs[0]->idx - q->vport->xdp_txq_offset;
+		break;
+	default:
+		return;
+	}
+
+	if (!is_rx && !test_bit(__IDPF_Q_XDP, q->flags))
+		return;
+
+	cfg_data = &vport->adapter->vport_config[vport->idx]->user_config;
+
+	if (!test_bit(qid, cfg_data->af_xdp_zc_qps))
+		return;
+
+	pool = xsk_get_pool_from_qid(q->vport->netdev, qid);
+
+	if (pool && is_rx && !xsk_buff_can_alloc(pool, 1))
+		return;
+
+	if (is_rx)
+		q->xsk_rx = pool;
+	else
+		q->xsk_tx = pool;
+
+	__set_bit(__IDPF_Q_XSK, q->flags);
+}
+
+void idpf_xsk_clear_queue(struct idpf_queue *q)
+{
+	struct device *dev;
+
+	if (!__test_and_clear_bit(__IDPF_Q_XSK, q->flags))
+		return;
+
+	switch (q->q_type) {
+	case VIRTCHNL2_QUEUE_TYPE_RX:
+	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+		dev = q->xsk_rx->dev;
+		q->xsk_rx = NULL;
+		q->dev = dev;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_TX:
+	case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+		dev = q->xsk_tx->dev;
+		q->xsk_tx = NULL;
+		q->dev = dev;
+		break;
+	}
+}
+
 /**
  * idpf_qp_cfg_qs - Configure all queues contained from a given array.
  * @vport: vport structure
@@ -95,6 +178,23 @@ idpf_qp_clean_qs(struct idpf_vport *vport, struct idpf_queue **qs, int num_qs)
 	}
 }
 
+/**
+ * idpf_trigger_sw_intr - trigger a software interrupt
+ * @hw: pointer to the HW structure
+ * @q_vector: interrupt vector to trigger the software interrupt for
+ */
+static void
+idpf_trigger_sw_intr(struct idpf_hw *hw, struct idpf_q_vector *q_vector)
+{
+	struct idpf_intr_reg *intr = &q_vector->intr_reg;
+	u32 val;
+
+	val = intr->dyn_ctl_intena_m | intr->dyn_ctl_itridx_m | /* set no itr*/
+	      intr->dyn_ctl_swint_trig_m |intr->dyn_ctl_sw_itridx_ena_m;
+
+	writel(val, intr->dyn_ctl);
+}
+
 /**
  * idpf_qvec_ena_irq - Enable IRQ for given queue vector
  * @q_vector: queue vector
@@ -472,3 +572,221 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct xsk_buff_pool *pool,
 xsk_exit:
 	return err;
 }
+
+/**
+ * idpf_xsk_clean_xdpq - Clean the XDP Tx queue and its buffer pool queues
+ * @xdpq: XDP_Tx queue
+ */
+void idpf_xsk_clean_xdpq(struct idpf_queue *xdpq)
+{
+	u32 ntc = xdpq->next_to_clean, ntu = xdpq->next_to_use;
+	struct device *dev = xdpq->xsk_tx->dev;
+	struct libie_sq_onstack_stats ss = { };
+	struct xdp_frame_bulk bq;
+	u32 xsk_frames = 0;
+
+	xdp_frame_bulk_init(&bq);
+	rcu_read_lock();
+
+	while (ntc != ntu) {
+		struct libie_tx_buffer *tx_buf = &xdpq->tx_buf[ntc];
+
+		if (tx_buf->type)
+			libie_xdp_complete_tx_buf(tx_buf, dev, false, &bq,
+						  &xdpq->xdp_tx_active, &ss);
+		else
+			xsk_frames++;
+
+		if (unlikely(++ntc >= xdpq->desc_count))
+			ntc = 0;
+	}
+
+	xdp_flush_frame_bulk(&bq);
+	rcu_read_unlock();
+
+	if (xsk_frames)
+		xsk_tx_completed(xdpq->xsk_tx, xsk_frames);
+}
+
+/**
+ * idpf_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
+ * @complq: completion queue associated with zero-copy Tx queue
+ */
+static u32 idpf_clean_xdp_irq_zc(struct idpf_queue *complq)
+{
+	struct idpf_splitq_4b_tx_compl_desc *last_rs_desc;
+	struct device *dev = complq->xsk_tx->dev;
+	struct libie_sq_onstack_stats ss = { };
+	int complq_budget = complq->desc_count;
+	u32 ntc = complq->next_to_clean;
+	struct idpf_queue *xdpq = NULL;
+	struct xdp_frame_bulk bq;
+	u32 done_frames = 0;
+	u32 xsk_frames = 0;
+	u32 tx_ntc, cnt;
+	bool gen_flag;
+	int head, i;
+
+	last_rs_desc = &complq->comp_4b[ntc];
+	gen_flag = test_bit(__IDPF_Q_GEN_CHK, complq->flags);
+
+	do {
+		int ctype = idpf_parse_compl_desc(last_rs_desc, complq,
+						  &xdpq, gen_flag);
+
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
+			goto clean_xdpq;
+		case -EINVAL:
+			goto fetch_next_desc;
+		default:
+			dev_err(&xdpq->vport->adapter->pdev->dev,
+				"Unsupported completion type for XSK\n");
+			goto fetch_next_desc;
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
+clean_xdpq:
+	complq->next_to_clean = ntc;
+
+	if (!xdpq)
+		return 0;
+
+	cnt = xdpq->desc_count;
+	tx_ntc = xdpq->next_to_clean;
+	done_frames = head >= tx_ntc ? head - tx_ntc :
+				       head + cnt - tx_ntc;
+	if (!done_frames)
+		return 0;
+
+	if (likely(!complq->xdp_tx_active))
+		goto xsk;
+
+	xdp_frame_bulk_init(&bq);
+
+	for (i = 0; i < done_frames; i++) {
+		struct libie_tx_buffer *tx_buf = &xdpq->tx_buf[tx_ntc];
+
+		if (tx_buf->type)
+			libie_xdp_complete_tx_buf(tx_buf, dev, true, &bq,
+						  &xdpq->xdp_tx_active,
+						  &ss);
+		else
+			xsk_frames++;
+
+		if (unlikely(++tx_ntc == cnt))
+			tx_ntc = 0;
+	}
+
+	xdp_flush_frame_bulk(&bq);
+
+xsk:
+	xdpq->next_to_clean += done_frames;
+	if (xdpq->next_to_clean >= cnt)
+		xdpq->next_to_clean -= cnt;
+
+	if (xsk_frames)
+		xsk_tx_completed(xdpq->xsk_tx, xsk_frames);
+
+	return done_frames;
+}
+
+/**
+ * idpf_xmit_pkt - produce a single HW Tx descriptor out of AF_XDP descriptor
+ * @xdpq: XDP queue to produce the HW Tx descriptor on
+ * @desc: AF_XDP descriptor to pull the DMA address and length from
+ * @total_bytes: bytes accumulator that will be used for stats update
+ */
+static void idpf_xsk_xmit_pkt(struct libie_xdp_tx_desc desc,
+			      const struct libie_xdp_tx_queue *sq)
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
+static u32 idpf_xsk_xmit_prep(void *_xdpq, struct libie_xdp_tx_queue *sq)
+{
+	struct idpf_queue *xdpq = _xdpq;
+
+	libie_xdp_sq_lock(&xdpq->xdp_lock);
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
+	return IDPF_DESC_UNUSED(xdpq);
+}
+
+/**
+ * idpf_xmit_xdpq_zc - take entries from XSK Tx queue and place them onto HW Tx queue
+ * @xdpq: XDP queue to produce the HW Tx descriptors on
+ *
+ * Returns true if there is no more work that needs to be done, false otherwise
+ */
+static bool idpf_xmit_xdpq_zc(struct idpf_queue *xdpq)
+{
+	u32 budget;
+
+	budget = IDPF_DESC_UNUSED(xdpq);
+	budget = min_t(u32, budget, IDPF_QUEUE_QUARTER(xdpq));
+
+	return libie_xsk_xmit_do_bulk(xdpq, xdpq->xsk_tx, budget,
+				      idpf_xsk_xmit_prep, idpf_xsk_xmit_pkt,
+				      idpf_xdp_tx_finalize);
+}
+
+/**
+ * idpf_xmit_zc - perform xmit from all XDP queues assigned to the completion queue
+ * @complq: Completion queue associated with one or more XDP queues
+ *
+ * Returns true if there is no more work that needs to be done, false otherwise
+ */
+bool idpf_xmit_zc(struct idpf_queue *complq)
+{
+	struct idpf_txq_group *xdpq_grp = complq->txq_grp;
+	bool result = true;
+	int i;
+
+	idpf_clean_xdp_irq_zc(complq);
+
+	for (i = 0; i < xdpq_grp->num_txq; i++)
+		result &= idpf_xmit_xdpq_zc(xdpq_grp->txqs[i]);
+
+	return result;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.h b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
index 93705900f592..777d6ab7891d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xsk.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
@@ -6,9 +6,18 @@
 
 #include <linux/types.h>
 
+enum virtchnl2_queue_type;
+
+struct idpf_queue;
 struct idpf_vport;
 struct xsk_buff_pool;
 
+void idpf_xsk_setup_queue(struct idpf_queue *q, enum virtchnl2_queue_type t);
+void idpf_xsk_clear_queue(struct idpf_queue *q);
+
+void idpf_xsk_clean_xdpq(struct idpf_queue *xdpq);
+bool idpf_xmit_zc(struct idpf_queue *complq);
+
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct xsk_buff_pool *pool,
 			u32 qid);
 
-- 
2.43.0


