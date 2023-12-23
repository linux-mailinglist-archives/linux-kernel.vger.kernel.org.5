Return-Path: <linux-kernel+bounces-10237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F5E81D1A7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E001F2416F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA533CF9;
	Sat, 23 Dec 2023 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdC0eYAI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C733CF4;
	Sat, 23 Dec 2023 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300365; x=1734836365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqmmrXO5N7W2qFb+zJKFXhMZxR89GgPDo7wFTIL1NWs=;
  b=FdC0eYAInVPrIrREm8Tktv911B60rNANIp6gjYIrxKE2XJvBdVbho4af
   zqCl2fXTxFGDILbh/+bRQt96s1PaGOb22Egj0GlDOISAwIH/WZDHZUO7o
   XOO2yNLReLr5NF5dqOAfMieAalKBvZxEx6BACHONjGyySbW0hJfVTCM8d
   f81RGimZw82I25BPmb18g1tM59LF4+Y5vlgGw//Z64D3rkgKuln4HbE7j
   rBDpwwMoPwQVJv03sDkPZTpkdlpfmrIgWLcncPNrUL2BqG0PEt5uk8o0i
   nRLycR7HCaJFN/XPjgtpLlET7e/z2bwhGEUepBrwwyEC6Ls7o7obGa5Ap
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610997"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610997"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537588"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:21 -0800
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
Subject: [PATCH RFC net-next 21/34] idpf: prepare structures to support xdp
Date: Sat, 23 Dec 2023 03:55:41 +0100
Message-ID: <20231223025554.2316836-22-aleksander.lobakin@intel.com>
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

Extend basic structures of the driver (e.g. 'idpf_vport', 'idpf_queue',
'idpf_vport_user_config_data') by adding members necessary to support XDP.
Add extra XDP Tx queues needed to support XDP_TX and XDP_REDIRECT actions
without interfering a regular Tx traffic.
Also add functions dedicated to support XDP initialization for Rx and
Tx queues and call those functions from the existing algorithms of
queues configuration.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   2 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  23 +++
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  25 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 122 ++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  24 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  36 +++--
 drivers/net/ethernet/intel/idpf/idpf_xdp.c    | 147 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xdp.h    |  15 ++
 9 files changed, 375 insertions(+), 25 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xdp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xdp.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 6844ead2f3ac..4024781ff02b 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -16,3 +16,5 @@ idpf-y := \
 	idpf_txrx.o		\
 	idpf_virtchnl.o 	\
 	idpf_vf_dev.o
+
+idpf-objs	+= idpf_xdp.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 596ece7df26a..76df52b797d9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -376,6 +376,14 @@ struct idpf_vport {
 	struct idpf_queue **txqs;
 	bool crc_enable;
 
+	bool xdpq_share;
+	u16 num_xdp_txq;
+	u16 num_xdp_rxq;
+	u16 num_xdp_complq;
+	u16 xdp_txq_offset;
+	u16 xdp_rxq_offset;
+	u16 xdp_complq_offset;
+
 	u16 num_rxq;
 	u16 num_bufq;
 	u32 rxq_desc_count;
@@ -465,8 +473,11 @@ struct idpf_vport_user_config_data {
 	struct idpf_rss_data rss_data;
 	u16 num_req_tx_qs;
 	u16 num_req_rx_qs;
+	u16 num_req_xdp_qs;
 	u32 num_req_txq_desc;
 	u32 num_req_rxq_desc;
+	/* Duplicated in queue structure for performance reasons */
+	struct bpf_prog *xdp_prog;
 	DECLARE_BITMAP(user_flags, __IDPF_USER_FLAGS_NBITS);
 	struct list_head mac_filter_list;
 };
@@ -685,6 +696,18 @@ static inline int idpf_is_queue_model_split(u16 q_model)
 	return q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
+/**
+ * idpf_xdp_is_prog_ena - check if there is an XDP program on adapter
+ * @vport: vport to check
+ */
+static inline bool idpf_xdp_is_prog_ena(const struct idpf_vport *vport)
+{
+	if (!vport->adapter)
+		return false;
+
+	return !!vport->adapter->vport_config[vport->idx]->user_config.xdp_prog;
+}
+
 #define idpf_is_cap_ena(adapter, field, flag) \
 	idpf_is_capability_ena(adapter, false, field, flag)
 #define idpf_is_cap_ena_all(adapter, field, flag) \
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index da7963f27bd8..0d192417205d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -186,9 +186,11 @@ static void idpf_get_channels(struct net_device *netdev,
 {
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_vport_config *vport_config;
+	const struct idpf_vport *vport;
 	u16 num_txq, num_rxq;
 	u16 combined;
 
+	vport = idpf_netdev_to_vport(netdev);
 	vport_config = np->adapter->vport_config[np->vport_idx];
 
 	num_txq = vport_config->user_config.num_req_tx_qs;
@@ -202,8 +204,8 @@ static void idpf_get_channels(struct net_device *netdev,
 	ch->max_rx = vport_config->max_q.max_rxq;
 	ch->max_tx = vport_config->max_q.max_txq;
 
-	ch->max_other = IDPF_MAX_MBXQ;
-	ch->other_count = IDPF_MAX_MBXQ;
+	ch->max_other = IDPF_MAX_MBXQ + vport->num_xdp_txq;
+	ch->other_count = IDPF_MAX_MBXQ + vport->num_xdp_txq;
 
 	ch->combined_count = combined;
 	ch->rx_count = num_rxq - combined;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5fea2fd957eb..c3fb20197725 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_xdp.h"
 
 static const struct net_device_ops idpf_netdev_ops_splitq;
 static const struct net_device_ops idpf_netdev_ops_singleq;
@@ -912,6 +913,7 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_remove_features(vport);
 
 	vport->link_up = false;
+	idpf_xdp_rxq_info_deinit_all(vport);
 	idpf_vport_intr_deinit(vport);
 	idpf_vport_intr_rel(vport);
 	idpf_vport_queues_rel(vport);
@@ -1299,13 +1301,18 @@ static void idpf_restore_features(struct idpf_vport *vport)
  */
 static int idpf_set_real_num_queues(struct idpf_vport *vport)
 {
-	int err;
+	int num_txq, err;
 
 	err = netif_set_real_num_rx_queues(vport->netdev, vport->num_rxq);
 	if (err)
 		return err;
 
-	return netif_set_real_num_tx_queues(vport->netdev, vport->num_txq);
+	if (idpf_xdp_is_prog_ena(vport))
+		num_txq = vport->num_txq - vport->num_xdp_txq;
+	else
+		num_txq = vport->num_txq;
+
+	return netif_set_real_num_tx_queues(vport->netdev, num_txq);
 }
 
 /**
@@ -1418,18 +1425,26 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 
 	idpf_rx_init_buf_tail(vport);
 
+	err = idpf_xdp_rxq_info_init_all(vport);
+	if (err) {
+		netdev_err(vport->netdev,
+			   "Failed to initialize XDP RxQ info for vport %u: %pe\n",
+			   vport->vport_id, ERR_PTR(err));
+		goto intr_deinit;
+	}
+
 	err = idpf_send_config_queues_msg(vport);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to configure queues for vport %u, %d\n",
 			vport->vport_id, err);
-		goto intr_deinit;
+		goto rxq_deinit;
 	}
 
 	err = idpf_send_map_unmap_queue_vector_msg(vport, true);
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to map queue vectors for vport %u: %d\n",
 			vport->vport_id, err);
-		goto intr_deinit;
+		goto rxq_deinit;
 	}
 
 	err = idpf_send_enable_queues_msg(vport);
@@ -1477,6 +1492,8 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 	idpf_send_disable_queues_msg(vport);
 unmap_queue_vectors:
 	idpf_send_map_unmap_queue_vector_msg(vport, false);
+rxq_deinit:
+	idpf_xdp_rxq_info_deinit_all(vport);
 intr_deinit:
 	idpf_vport_intr_deinit(vport);
 intr_rel:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1a79ec1fb838..d4a9f4c36b63 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2023 Intel Corporation */
 
 #include "idpf.h"
+#include "idpf_xdp.h"
 
 /**
  * idpf_buf_lifo_push - push a buffer pointer onto stack
@@ -61,15 +62,23 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
 {
 	struct libie_sq_onstack_stats ss = { };
+	struct xdp_frame_bulk bq;
 	u16 i;
 
 	/* Buffers already cleared, nothing to do */
 	if (!txq->tx_buf)
 		return;
 
+	xdp_frame_bulk_init(&bq);
+	rcu_read_lock();
+
 	/* Free all the Tx buffer sk_buffs */
 	for (i = 0; i < txq->desc_count; i++)
-		libie_tx_complete_buf(&txq->tx_buf[i], txq->dev, false, &ss);
+		libie_tx_complete_any(&txq->tx_buf[i], txq->dev, &bq,
+				      &txq->xdp_tx_active, &ss);
+
+	xdp_flush_frame_bulk(&bq);
+	rcu_read_unlock();
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -469,6 +478,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_queue *rxq)
 	struct libie_buf_queue bq = {
 		.count		= rxq->desc_count,
 		.type		= LIBIE_RX_BUF_HDR,
+		.xdp		= idpf_xdp_is_prog_ena(rxq->vport),
 	};
 	struct libie_rx_buffer *hdr_buf;
 	int ret;
@@ -647,6 +657,7 @@ static int idpf_rx_bufs_init(struct idpf_queue *rxbufq,
 		.count		= rxbufq->desc_count,
 		.type		= type,
 		.hsplit		= rxbufq->rx_hsplit_en,
+		.xdp		= idpf_xdp_is_prog_ena(rxbufq->vport),
 	};
 	int ret;
 
@@ -917,6 +928,7 @@ static void idpf_vport_queue_grp_rel_all(struct idpf_vport *vport)
  */
 void idpf_vport_queues_rel(struct idpf_vport *vport)
 {
+	idpf_vport_xdpq_put(vport);
 	idpf_tx_desc_rel_all(vport);
 	idpf_rx_desc_rel_all(vport);
 	idpf_vport_queue_grp_rel_all(vport);
@@ -984,6 +996,27 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 	if (idpf_is_queue_model_split(vport->rxq_model))
 		vport->num_bufq = le16_to_cpu(vport_msg->num_rx_bufq);
 
+	vport->num_xdp_rxq = 0;
+	vport->xdp_rxq_offset = 0;
+
+	if (idpf_xdp_is_prog_ena(vport)) {
+		vport->xdp_txq_offset = config_data->num_req_tx_qs;
+		vport->num_xdp_txq = le16_to_cpu(vport_msg->num_tx_q) -
+				     vport->xdp_txq_offset;
+		vport->xdpq_share = libie_xdp_sq_shared(vport->num_xdp_txq);
+	} else {
+		vport->xdp_txq_offset = 0;
+		vport->num_xdp_txq = 0;
+		vport->xdpq_share = 0;
+	}
+
+	if (idpf_is_queue_model_split(vport->txq_model)) {
+		vport->num_xdp_complq = vport->num_xdp_txq;
+		vport->xdp_complq_offset = vport->xdp_txq_offset;
+	}
+
+	config_data->num_req_xdp_qs = vport->num_xdp_txq;
+
 	/* Adjust number of buffer queues per Rx queue group. */
 	if (!idpf_is_queue_model_split(vport->rxq_model)) {
 		vport->num_bufqs_per_qgrp = 0;
@@ -1055,9 +1088,10 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 	int dflt_splitq_txq_grps = 0, dflt_singleq_txqs = 0;
 	int dflt_splitq_rxq_grps = 0, dflt_singleq_rxqs = 0;
 	u16 num_req_tx_qs = 0, num_req_rx_qs = 0;
+	struct idpf_vport_user_config_data *user;
 	struct idpf_vport_config *vport_config;
 	u16 num_txq_grps, num_rxq_grps;
-	u32 num_qs;
+	u32 num_qs, num_xdpq;
 
 	vport_config = adapter->vport_config[vport_idx];
 	if (vport_config) {
@@ -1105,6 +1139,29 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 		vport_msg->num_rx_bufq = 0;
 	}
 
+	if (!vport_config)
+		return 0;
+
+	user = &vport_config->user_config;
+	user->num_req_rx_qs = le16_to_cpu(vport_msg->num_rx_q);
+	user->num_req_tx_qs = le16_to_cpu(vport_msg->num_tx_q);
+
+	if (vport_config->user_config.xdp_prog)
+		/* As we now know new number of Rx and Tx queues, we can
+		 * request additional Tx queues for XDP.
+		 */
+		num_xdpq = libie_xdp_get_sq_num(user->num_req_rx_qs,
+						user->num_req_tx_qs,
+						IDPF_LARGE_MAX_Q);
+	else
+		num_xdpq = 0;
+
+	user->num_req_xdp_qs = num_xdpq;
+
+	vport_msg->num_tx_q = cpu_to_le16(user->num_req_tx_qs + num_xdpq);
+	if (idpf_is_queue_model_split(le16_to_cpu(vport_msg->txq_model)))
+		vport_msg->num_tx_complq = vport_msg->num_tx_q;
+
 	return 0;
 }
 
@@ -1446,6 +1503,8 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
 	if (err)
 		goto err_out;
 
+	idpf_vport_xdpq_get(vport);
+
 	return 0;
 
 err_out:
@@ -3791,9 +3850,15 @@ static bool idpf_tx_splitq_clean_all(struct idpf_q_vector *q_vec,
 		return true;
 
 	budget_per_q = DIV_ROUND_UP(budget, num_txq);
-	for (i = 0; i < num_txq; i++)
-		clean_complete &= idpf_tx_clean_complq(q_vec->tx[i],
-						       budget_per_q, cleaned);
+
+	for (i = 0; i < num_txq; i++) {
+		struct idpf_queue *cq = q_vec->tx[i];
+
+		if (!test_bit(__IDPF_Q_XDP, cq->flags))
+			clean_complete &= idpf_tx_clean_complq(cq,
+							       budget_per_q,
+							       cleaned);
+	}
 
 	return clean_complete;
 }
@@ -3893,13 +3958,22 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
  */
 static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 {
+	bool is_xdp_prog_ena = idpf_xdp_is_prog_ena(vport);
 	u16 num_txq_grp = vport->num_txq_grp;
 	int i, j, qv_idx, bufq_vidx = 0;
 	struct idpf_rxq_group *rx_qgrp;
 	struct idpf_txq_group *tx_qgrp;
 	struct idpf_queue *q, *bufq;
+	int num_active_rxq;
 	u16 q_index;
 
+	/* XDP Tx queues are handled within Rx loop, correct num_txq_grp so
+	 * that it stores number of regular Tx queue groups. This way when we
+	 * later assign Tx to qvector, we go only through regular Tx queues.
+	 */
+	if (is_xdp_prog_ena && idpf_is_queue_model_split(vport->txq_model))
+		num_txq_grp = vport->xdp_txq_offset;
+
 	for (i = 0, qv_idx = 0; i < vport->num_rxq_grp; i++) {
 		u16 num_rxq;
 
@@ -3909,6 +3983,8 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 		else
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
+		num_active_rxq = num_rxq - vport->num_xdp_rxq;
+
 		for (j = 0; j < num_rxq; j++) {
 			if (qv_idx >= vport->num_q_vectors)
 				qv_idx = 0;
@@ -3921,6 +3997,30 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 			q_index = q->q_vector->num_rxq;
 			q->q_vector->rx[q_index] = q;
 			q->q_vector->num_rxq++;
+
+			/* Do not setup XDP Tx queues for dummy Rx queues. */
+			if (j >= num_active_rxq)
+				goto skip_xdp_txq_config;
+
+			if (is_xdp_prog_ena) {
+				if (idpf_is_queue_model_split(vport->txq_model)) {
+					tx_qgrp = &vport->txq_grps[i + vport->xdp_txq_offset];
+					q = tx_qgrp->complq;
+					q->q_vector = &vport->q_vectors[qv_idx];
+					q_index = q->q_vector->num_txq;
+					q->q_vector->tx[q_index] = q;
+					q->q_vector->num_txq++;
+				} else {
+					tx_qgrp = &vport->txq_grps[i];
+					q = tx_qgrp->txqs[j + vport->xdp_txq_offset];
+					q->q_vector = &vport->q_vectors[qv_idx];
+					q_index = q->q_vector->num_txq;
+					q->q_vector->tx[q_index] = q;
+					q->q_vector->num_txq++;
+				}
+			}
+
+skip_xdp_txq_config:
 			qv_idx++;
 		}
 
@@ -3954,6 +4054,9 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 			q->q_vector->num_txq++;
 			qv_idx++;
 		} else {
+			num_txq = is_xdp_prog_ena ? tx_qgrp->num_txq - vport->xdp_txq_offset
+						  : tx_qgrp->num_txq;
+
 			for (j = 0; j < num_txq; j++) {
 				if (qv_idx >= vport->num_q_vectors)
 					qv_idx = 0;
@@ -4175,6 +4278,15 @@ static void idpf_fill_dflt_rss_lut(struct idpf_vport *vport)
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
 
+	/* When we use this code for legacy devices (e.g. in AVF driver), some
+	 * Rx queues may not be used because we would not be able to create XDP
+	 * Tx queues for them. In such a case do not add their queue IDs to the
+	 * RSS LUT by setting the number of active Rx queues to XDP Tx queues
+	 * count.
+	 */
+	if (idpf_xdp_is_prog_ena(vport))
+		num_active_rxq -= vport->num_xdp_rxq;
+
 	for (i = 0; i < rss_data->rss_lut_size; i++) {
 		rss_data->rss_lut[i] = i % num_active_rxq;
 		rss_data->cached_lut[i] = rss_data->rss_lut[i];
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 3e15ed779860..b1c30795f376 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -4,8 +4,7 @@
 #ifndef _IDPF_TXRX_H_
 #define _IDPF_TXRX_H_
 
-#include <linux/net/intel/libie/rx.h>
-#include <linux/net/intel/libie/tx.h>
+#include <linux/net/intel/libie/xdp.h>
 
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
@@ -319,6 +318,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_FLOW_SCH_EN,
 	__IDPF_Q_SW_MARKER,
 	__IDPF_Q_POLL_MODE,
+	__IDPF_Q_XDP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -554,13 +554,20 @@ struct idpf_queue {
 	};
 	void __iomem *tail;
 	union {
-		struct idpf_tx_buf *tx_buf;
+		struct {
+			struct idpf_tx_buf *tx_buf;
+			struct libie_xdp_sq_lock xdp_lock;
+		};
+		u32 num_xdp_txq;
 		struct {
 			struct libie_rx_buffer *hdr_buf;
 			struct idpf_rx_buf *buf;
 		} rx_buf;
 	};
-	struct page_pool *hdr_pp;
+	union {
+		struct page_pool *hdr_pp;
+		struct idpf_queue **xdpqs;
+	};
 	union {
 		struct page_pool *pp;
 		struct device *dev;
@@ -582,7 +589,10 @@ struct idpf_queue {
 		void *desc_ring;
 	};
 
-	u32 hdr_truesize;
+	union {
+		u32 hdr_truesize;
+		u32 xdp_tx_active;
+	};
 	u32 truesize;
 	u16 idx;
 	u16 q_type;
@@ -627,8 +637,12 @@ struct idpf_queue {
 	union {
 		/* Rx */
 		struct {
+			struct xdp_rxq_info xdp_rxq;
+
+			struct bpf_prog __rcu *xdp_prog;
 			struct sk_buff *skb;
 		};
+
 		/* Tx */
 		struct {
 			u16 compl_tag_bufid_m;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 5c3d7c3534af..59b8bbebead7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1947,20 +1947,27 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
 		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
+			const struct idpf_q_vector *vec;
+			u32 v_idx, tx_itr_idx;
+
 			vqv[k].queue_type = cpu_to_le32(tx_qgrp->txqs[j]->q_type);
 			vqv[k].queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
 
-			if (idpf_is_queue_model_split(vport->txq_model)) {
-				vqv[k].vector_id =
-				cpu_to_le16(tx_qgrp->complq->q_vector->v_idx);
-				vqv[k].itr_idx =
-				cpu_to_le32(tx_qgrp->complq->q_vector->tx_itr_idx);
+			if (idpf_is_queue_model_split(vport->txq_model))
+				vec = tx_qgrp->complq->q_vector;
+			else
+				vec = tx_qgrp->txqs[j]->q_vector;
+
+			if (vec) {
+				v_idx = vec->v_idx;
+				tx_itr_idx = vec->tx_itr_idx;
 			} else {
-				vqv[k].vector_id =
-				cpu_to_le16(tx_qgrp->txqs[j]->q_vector->v_idx);
-				vqv[k].itr_idx =
-				cpu_to_le32(tx_qgrp->txqs[j]->q_vector->tx_itr_idx);
+				v_idx = 0;
+				tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
 			}
+
+			vqv[k].vector_id = cpu_to_le16(v_idx);
+			vqv[k].itr_idx = cpu_to_le32(tx_itr_idx);
 		}
 	}
 
@@ -3253,6 +3260,17 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
 	vec_info.default_vport = vport->default_vport;
 	vec_info.index = vport->idx;
 
+	/* Additional XDP Tx queues share the q_vector with regular Tx and Rx
+	 * queues to which they are assigned. Also, XDP shall request additional
+	 * Tx queues via VIRTCHNL. Therefore, to avoid exceeding over
+	 * "vport->q_vector_idxs array", do not request empty q_vectors
+	 * for XDP Tx queues.
+	 */
+	if (idpf_xdp_is_prog_ena(vport))
+		vec_info.num_req_vecs = max_t(u16,
+					      vport->num_txq - vport->num_xdp_txq,
+					      vport->num_rxq);
+
 	num_alloc_vecs = idpf_req_rel_vector_indexes(vport->adapter,
 						     vport->q_vector_idxs,
 						     &vec_info);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.c b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
new file mode 100644
index 000000000000..29b2fe68c7eb
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Intel Corporation */
+
+#include "idpf.h"
+#include "idpf_xdp.h"
+
+static int idpf_rxq_for_each(const struct idpf_vport *vport,
+			     int (*fn)(struct idpf_queue *rxq, void *arg),
+			     void *arg)
+{
+	bool splitq = idpf_is_queue_model_split(vport->rxq_model);
+
+	for (u32 i = 0; i < vport->num_rxq_grp; i++) {
+		const struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
+		u32 num_rxq;
+
+		if (splitq)
+			num_rxq = rx_qgrp->splitq.num_rxq_sets;
+		else
+			num_rxq = rx_qgrp->singleq.num_rxq;
+
+		for (u32 j = 0; j < num_rxq; j++) {
+			struct idpf_queue *q;
+			int err;
+
+			if (splitq)
+				q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
+			else
+				q = rx_qgrp->singleq.rxqs[j];
+
+			err = fn(q, arg);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * idpf_xdp_rxq_info_init - Setup XDP RxQ info for a given Rx queue
+ * @rxq: Rx queue for which the resources are setup
+ * @splitq: flag indicating if the HW works in split queue mode
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int idpf_xdp_rxq_info_init(struct idpf_queue *rxq, void *arg)
+{
+	const struct idpf_vport *vport = rxq->vport;
+	const struct page_pool *pp;
+	int err;
+
+	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
+				 rxq->q_vector->napi.napi_id,
+				 rxq->rx_buf_size);
+	if (err)
+		return err;
+
+	pp = arg ? rxq->rxq_grp->splitq.bufq_sets[0].bufq.pp : rxq->pp;
+	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
+
+	rxq->xdpqs = &vport->txqs[vport->xdp_txq_offset];
+	rxq->num_xdp_txq = vport->num_xdp_txq;
+
+	return 0;
+}
+
+/**
+ * idpf_xdp_rxq_info_init_all - initialize RxQ info for all Rx queues in vport
+ * @vport: vport to setup the info
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport)
+{
+	void *arg;
+
+	arg = (void *)(size_t)idpf_is_queue_model_split(vport->rxq_model);
+
+	return idpf_rxq_for_each(vport, idpf_xdp_rxq_info_init, arg);
+}
+
+/**
+ * idpf_xdp_rxq_info_deinit - Deinit XDP RxQ info for a given Rx queue
+ * @rxq: Rx queue for which the resources are destroyed
+ */
+static int idpf_xdp_rxq_info_deinit(struct idpf_queue *rxq, void *arg)
+{
+	rxq->xdpqs = NULL;
+	rxq->num_xdp_txq = 0;
+
+	xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
+	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+	return 0;
+}
+
+/**
+ * idpf_xdp_rxq_info_deinit_all - deinit RxQ info for all Rx queues in vport
+ * @vport: vport to setup the info
+ */
+void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
+{
+	idpf_rxq_for_each(vport, idpf_xdp_rxq_info_deinit, NULL);
+}
+
+void idpf_vport_xdpq_get(const struct idpf_vport *vport)
+{
+	if (!idpf_xdp_is_prog_ena(vport))
+		return;
+
+	cpus_read_lock();
+
+	for (u32 j = vport->xdp_txq_offset; j < vport->num_txq; j++) {
+		struct idpf_queue *xdpq = vport->txqs[j];
+
+		__clear_bit(__IDPF_Q_FLOW_SCH_EN, xdpq->flags);
+		__clear_bit(__IDPF_Q_FLOW_SCH_EN,
+			    xdpq->txq_grp->complq->flags);
+		__set_bit(__IDPF_Q_XDP, xdpq->flags);
+		__set_bit(__IDPF_Q_XDP, xdpq->txq_grp->complq->flags);
+
+		libie_xdp_sq_get(&xdpq->xdp_lock, vport->netdev,
+				 vport->xdpq_share);
+	}
+
+	cpus_read_unlock();
+}
+
+void idpf_vport_xdpq_put(const struct idpf_vport *vport)
+{
+	if (!idpf_xdp_is_prog_ena(vport))
+		return;
+
+	cpus_read_lock();
+
+	for (u32 j = vport->xdp_txq_offset; j < vport->num_txq; j++) {
+		struct idpf_queue *xdpq = vport->txqs[j];
+
+		if (!__test_and_clear_bit(__IDPF_Q_XDP, xdpq->flags))
+			continue;
+
+		libie_xdp_sq_put(&xdpq->xdp_lock, vport->netdev);
+	}
+
+	cpus_read_unlock();
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.h b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
new file mode 100644
index 000000000000..16b30caaac3f
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IDPF_XDP_H_
+#define _IDPF_XDP_H_
+
+struct idpf_vport;
+
+int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
+void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
+
+void idpf_vport_xdpq_get(const struct idpf_vport *vport);
+void idpf_vport_xdpq_put(const struct idpf_vport *vport);
+
+#endif /* _IDPF_XDP_H_ */
-- 
2.43.0


