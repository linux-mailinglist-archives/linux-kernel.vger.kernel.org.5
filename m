Return-Path: <linux-kernel+bounces-10247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C932681D1BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF102B244E6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555F03C48E;
	Sat, 23 Dec 2023 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr3C3IR6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0B3D96D;
	Sat, 23 Dec 2023 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300406; x=1734836406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IETM6DFCXtbBVRnZwslRqbFcq/erXvw6nPWBmZ/KIAA=;
  b=Tr3C3IR6LM0l4gtcTKsn2WHY6NfIUj2B0ozj7jmDrRmHG+M8E2ICOiZ7
   jlCFg2fIdcOZGDELHdA4D5IDu3NaCgoQyDHRE4mOCFCE9+YJ+B/9Mx+qg
   TPQUWN1WDJ3LyytudM1571Ur4oc58glIy1TCt4ay3J3zc0JA9gynrijeD
   FCj1sPpy75KTzwmYPdyuqSgVlwocVe9fofa5tW8eVHpeIS7ywFdObyb15
   VBdrAZqtVV8hZhMI/mhp2+HAa/0ZuMYGaujAiOAnOIWpU1XPsypx0BwEI
   YopjXmDo2m5/yq5YIwtdVgeWiGTuKL3rCLfJlDGhhQV1OUg+oo2JnfVzy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611090"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537678"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 19:00:01 -0800
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
Subject: [PATCH RFC net-next 31/34] idpf: add XSk pool initialization
Date: Sat, 23 Dec 2023 03:55:51 +0100
Message-ID: <20231223025554.2316836-32-aleksander.lobakin@intel.com>
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

Add functionality to setup an XSk buffer pool, including ability to
stop, reconfig and start only selected queues, not the whole device.
Pool DMA mapping is managed by libie.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile    |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h      |  13 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  14 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |   6 +
 drivers/net/ethernet/intel/idpf/idpf_xdp.c  |   5 +
 drivers/net/ethernet/intel/idpf/idpf_xsk.c  | 474 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_xsk.h  |  15 +
 7 files changed, 521 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xsk.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_xsk.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 4024781ff02b..f4bc1fd96092 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -18,3 +18,4 @@ idpf-y := \
 	idpf_vf_dev.o
 
 idpf-objs	+= idpf_xdp.o
+idpf-objs	+= idpf_xsk.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index d99ebd045c4e..f05ed84600fd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -464,6 +464,7 @@ struct idpf_rss_data {
  *		      ethtool
  * @num_req_rxq_desc: Number of user requested RX queue descriptors through
  *		      ethtool
+ * @af_xdp_zc_qps: Mask of queue pairs where the AF_XDP socket is established
  * @user_flags: User toggled config flags
  * @mac_filter_list: List of MAC filters
  *
@@ -480,6 +481,7 @@ struct idpf_vport_user_config_data {
 	struct bpf_prog *xdp_prog;
 	DECLARE_BITMAP(user_flags, __IDPF_USER_FLAGS_NBITS);
 	struct list_head mac_filter_list;
+	DECLARE_BITMAP(af_xdp_zc_qps, IDPF_LARGE_MAX_Q);
 };
 
 /**
@@ -959,6 +961,17 @@ static inline void idpf_vport_ctrl_unlock(struct net_device *netdev)
 	mutex_unlock(&np->adapter->vport_ctrl_lock);
 }
 
+/**
+ * idpf_vport_ctrl_is_locked - Check if vport control lock is taken
+ * @netdev: Network interface device structure
+ */
+static inline bool idpf_vport_ctrl_is_locked(struct net_device *netdev)
+{
+	struct idpf_netdev_priv *np = netdev_priv(netdev);
+
+	return mutex_is_locked(&np->adapter->vport_ctrl_lock);
+}
+
 void idpf_statistics_task(struct work_struct *work);
 void idpf_init_task(struct work_struct *work);
 void idpf_service_task(struct work_struct *work);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3dc21731df2f..e3f59bbe7c90 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -100,7 +100,7 @@ static void idpf_tx_buf_rel_all(struct idpf_queue *txq)
  *
  * Free all transmit software resources
  */
-static void idpf_tx_desc_rel(struct idpf_queue *txq, bool bufq)
+void idpf_tx_desc_rel(struct idpf_queue *txq, bool bufq)
 {
 	if (bufq)
 		idpf_tx_buf_rel_all(txq);
@@ -194,7 +194,7 @@ static int idpf_tx_buf_alloc_all(struct idpf_queue *tx_q)
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
+int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq)
 {
 	struct device *dev = tx_q->dev;
 	u32 desc_sz;
@@ -385,7 +385,7 @@ static void idpf_rx_buf_rel_all(struct idpf_queue *rxq)
  *
  * Free a specific rx queue resources
  */
-static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
+void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
 {
 	if (!rxq)
 		return;
@@ -649,8 +649,7 @@ static int idpf_rx_buf_alloc_all(struct idpf_queue *rxbufq)
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_bufs_init(struct idpf_queue *rxbufq,
-			     enum libie_rx_buf_type type)
+int idpf_rx_bufs_init(struct idpf_queue *rxbufq, enum libie_rx_buf_type type)
 {
 	struct libie_buf_queue bq = {
 		.truesize	= rxbufq->truesize,
@@ -730,7 +729,7 @@ int idpf_rx_bufs_init_all(struct idpf_vport *vport)
  *
  * Returns 0 on success, negative on failure
  */
-static int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model)
+int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model)
 {
 	struct device *dev = rxq->dev;
 
@@ -1870,7 +1869,8 @@ static void idpf_tx_finalize_complq(struct idpf_queue *complq, int ntc,
 
 		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
 			    np->state != __IDPF_VPORT_UP ||
-			    !netif_carrier_ok(tx_q->vport->netdev);
+			    !netif_carrier_ok(tx_q->vport->netdev) ||
+			    idpf_vport_ctrl_is_locked(tx_q->vport->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
 					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index f32d854fe850..be396f1e346a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -519,6 +519,7 @@ union idpf_queue_stats {
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
  * @desc_ring: Descriptor ring memory
+ * @xsk_pool: Pointer to a description of a buffer pool for AF_XDP socket
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @tx_min_pkt_len: Min supported packet length
  * @num_completions: Only relevant for TX completion queue. It tracks the
@@ -948,6 +949,11 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 void idpf_tx_handle_sw_marker(struct idpf_queue *tx_q);
+int idpf_rx_desc_alloc(struct idpf_queue *rxq, bool bufq, s32 q_model);
+void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model);
+int idpf_tx_desc_alloc(struct idpf_queue *tx_q, bool bufq);
+void idpf_tx_desc_rel(struct idpf_queue *txq, bool bufq);
+int idpf_rx_bufs_init(struct idpf_queue *rxbufq, enum libie_rx_buf_type type);
 
 /**
  * idpf_xdpq_update_tail - Updates the XDP Tx queue tail register
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xdp.c b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
index b4f096186302..c20c805583be 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_xdp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_xdp.c
@@ -3,6 +3,7 @@
 
 #include "idpf.h"
 #include "idpf_xdp.h"
+#include "idpf_xsk.h"
 
 static int idpf_rxq_for_each(const struct idpf_vport *vport,
 			     int (*fn)(struct idpf_queue *rxq, void *arg),
@@ -472,6 +473,10 @@ int idpf_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
 	case XDP_SETUP_PROG:
 		err = idpf_xdp_setup_prog(vport, xdp->prog, xdp->extack);
 		break;
+	case XDP_SETUP_XSK_POOL:
+		err = idpf_xsk_pool_setup(vport, xdp->xsk.pool,
+					  xdp->xsk.queue_id);
+		break;
 	default:
 		err = -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.c b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
new file mode 100644
index 000000000000..3017680fedb3
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Intel Corporation */
+
+#include  <linux/net/intel/libie/xsk.h>
+
+#include "idpf.h"
+#include "idpf_xsk.h"
+
+/**
+ * idpf_qp_cfg_qs - Configure all queues contained from a given array.
+ * @vport: vport structure
+ * @qs: an array of queues to configure
+ * @num_qs: number of queues in the 'qs' array
+ *
+ * Returns 0 in case of success, false otherwise.
+ */
+static int
+idpf_qp_cfg_qs(struct idpf_vport *vport, struct idpf_queue **qs, int num_qs)
+{
+	bool splitq = idpf_is_queue_model_split(vport->rxq_model);
+	int i, err;
+
+	for (i = 0; i < num_qs; i++) {
+		const struct idpf_bufq_set *sets;
+		struct idpf_queue *q = qs[i];
+		enum libie_rx_buf_type qt;
+		u32 ts;
+
+		switch (q->q_type) {
+		case VIRTCHNL2_QUEUE_TYPE_RX:
+			err = idpf_rx_desc_alloc(q, false, vport->rxq_model);
+			if (err) {
+				netdev_err(vport->netdev, "Could not allocate buffer for RX queue.\n");
+				break;
+			}
+			if (!splitq)
+				err = idpf_rx_bufs_init(q, LIBIE_RX_BUF_MTU);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+			err = idpf_rx_desc_alloc(q, true, vport->rxq_model);
+			if (err)
+				break;
+
+			sets = q->rxq_grp->splitq.bufq_sets;
+			qt = q->idx ? LIBIE_RX_BUF_SHORT : LIBIE_RX_BUF_MTU;
+			ts = q->idx ? sets[q->idx - 1].bufq.truesize >> 1 : 0;
+			q->truesize = ts;
+
+			err = idpf_rx_bufs_init(q, qt);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX:
+			err = idpf_tx_desc_alloc(q, true);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+			err = idpf_tx_desc_alloc(q, false);
+			break;
+		}
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * idpf_qp_clean_qs - Clean all queues contained from a given array.
+ * @vport: vport structure
+ * @qs: an array of queues to clean
+ * @num_qs: number of queues in the 'qs' array
+ */
+static void
+idpf_qp_clean_qs(struct idpf_vport *vport, struct idpf_queue **qs, int num_qs)
+{
+	for (u32 i = 0; i < num_qs; i++) {
+		struct idpf_queue *q = qs[i];
+
+		switch (q->q_type) {
+		case VIRTCHNL2_QUEUE_TYPE_RX:
+			idpf_rx_desc_rel(q, false, vport->rxq_model);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+			idpf_rx_desc_rel(q, true, vport->rxq_model);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX:
+			idpf_tx_desc_rel(q, true);
+			q->txq_grp->num_completions_pending = 0;
+			writel(q->next_to_use, q->tail);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+			idpf_tx_desc_rel(q, false);
+			q->num_completions = 0;
+			break;
+		}
+	}
+}
+
+/**
+ * idpf_qvec_ena_irq - Enable IRQ for given queue vector
+ * @q_vector: queue vector
+ */
+static void
+idpf_qvec_ena_irq(struct idpf_q_vector *q_vector)
+{
+	/* Write the default ITR values */
+	if (q_vector->num_rxq)
+		idpf_vport_intr_write_itr(q_vector, q_vector->rx_itr_value,
+					  false);
+	if (q_vector->num_txq)
+		idpf_vport_intr_write_itr(q_vector, q_vector->tx_itr_value,
+					  true);
+	if (q_vector->num_rxq || q_vector->num_txq)
+		idpf_vport_intr_update_itr_ena_irq(q_vector);
+}
+
+/**
+ * idpf_insert_txqs_from_grp - Insert all tx and buffer queues from txq group
+ *			       to a given array.
+ * @vport: vport structure
+ * @txq: pointer to a tx queue
+ * @qs: pointer to an element of array where tx queues should be inserted
+ *
+ * Returns the number of queues that has been inserted to an output 'qs'
+ * array.
+ * Note that the caller of this function must ensure that there is enough space
+ * in the 'qs' array to insert all the queues from the rx queue group.
+ */
+static int
+idpf_insert_txqs_from_grp(struct idpf_vport *vport,
+			  struct idpf_queue *txq,
+			  struct idpf_queue **qs)
+{
+	int qs_idx = 0;
+
+	if (!idpf_is_queue_model_split(vport->txq_model)) {
+		qs[qs_idx++] = txq;
+	} else {
+		struct idpf_txq_group *txq_grp = txq->txq_grp;
+		int i;
+
+		for (i = 0; i < txq_grp->num_txq; i++)
+			qs[qs_idx++] = txq_grp->txqs[i];
+
+		for (i = 0; i < IDPF_COMPLQ_PER_GROUP; i++)
+			qs[qs_idx++] = &txq_grp->complq[i];
+	}
+
+	return qs_idx;
+}
+
+/**
+ * idpf_insert_rxqs_from_grp - Insert all rx and buffer queues from rxq group
+ *			       to a given array.
+ * @vport: vport structure
+ * @rxq: pointer to a rx queue
+ * @qs: pointer to an element of array where rx queues should be inserted
+ *
+ * Returns the number of queues that has been inserted to an output 'qs'
+ * array.
+ * Note that the caller of this function must ensure that there is enough space
+ * in the 'qs' array to insert all the queues from the rx queue group.
+ */
+static int
+idpf_insert_rxqs_from_grp(struct idpf_vport *vport,
+			  struct idpf_queue *rxq,
+			  struct idpf_queue **qs)
+{
+	int qs_idx = 0;
+
+	if (!idpf_is_queue_model_split(vport->rxq_model)) {
+		qs[qs_idx++] = rxq;
+	} else {
+		struct idpf_rxq_group *rxq_grp = rxq->rxq_grp;
+		int i;
+
+		for (i = 0; i < rxq_grp->splitq.num_rxq_sets; i++)
+			qs[qs_idx++] = &rxq_grp->splitq.rxq_sets[i]->rxq;
+
+		for (i = 0; i < vport->num_bufqs_per_qgrp; i++)
+			qs[qs_idx++] = &rxq_grp->splitq.bufq_sets[i].bufq;
+	}
+
+	return qs_idx;
+}
+
+/**
+ * idpf_count_rxqs_in_grp - Returns the number of rx queues in rx queue group
+ *			    containing a given rx queue.
+ * @vport: vport structure
+ * @rxq: pointer to a rx queue
+ *
+ * Returns the number of rx queues in the rx queue group associated with
+ * a given rx queue. Or, in case of singleq mode, 1, because rx queues
+ * are not grouped.
+ */
+static int
+idpf_count_rxqs_in_grp(struct idpf_vport *vport, struct idpf_queue *rxq)
+{
+	if (!idpf_is_queue_model_split(vport->rxq_model))
+		return 1;
+
+	return rxq->rxq_grp->splitq.num_rxq_sets + vport->num_bufqs_per_qgrp;
+}
+
+/**
+ * idpf_count_txqs_in_grp - Returns the number of tx queues in tx queue group
+ *			    containing a given tx queue.
+ * @vport: vport structure
+ * @txq: pointer to a tx queue
+ *
+ * Returns the number of tx queues in the tx queue group associated with
+ * a given tx queue. Or, in case of singleq mode, 1, because tx queues
+ * are not grouped.
+ */
+static int
+idpf_count_txqs_in_grp(struct idpf_vport *vport, struct idpf_queue *txq)
+{
+	if (!idpf_is_queue_model_split(vport->txq_model))
+		return 1;
+
+	return txq->txq_grp->num_txq + IDPF_COMPLQ_PER_GROUP;
+}
+
+/**
+ * idpf_create_queue_list - Creates a list of queues associated with a given
+ *			    queue index.
+ * @vport: vport structure
+ * @q_idx: index of queue pair to establish XSK socket
+ * @num_qs: number of queues in returned array.
+ *
+ * Returns a pointer to a dynamically allocated array of pointers to all
+ * queues associated with a given queue index (q_idx).
+ * Please note that the caller is responsible to free the memory allocated
+ * by this function using 'kfree()'.
+ * NULL-pointer will be returned in case of error.
+ */
+static struct idpf_queue **
+idpf_create_queue_list(struct idpf_vport *vport, u16 q_idx, int *num_qs)
+{
+	struct idpf_queue *rxq, *txq, *xdpq = NULL;
+	struct idpf_queue **qs;
+	int qs_idx;
+
+	*num_qs = 0;
+
+	if (q_idx >= vport->num_rxq || q_idx >= vport->num_txq)
+		return NULL;
+
+	rxq = idpf_find_rxq(vport, q_idx);
+	txq = idpf_find_txq(vport, q_idx);
+
+	*num_qs += idpf_count_rxqs_in_grp(vport, rxq);
+	*num_qs += idpf_count_txqs_in_grp(vport, txq);
+
+	if (idpf_xdp_is_prog_ena(vport)) {
+		xdpq = vport->txqs[q_idx + vport->xdp_txq_offset];
+		*num_qs += idpf_count_txqs_in_grp(vport, xdpq);
+	}
+
+	qs = kcalloc(*num_qs, sizeof(*qs), GFP_KERNEL);
+	if (!qs)
+		return NULL;
+
+	qs_idx = 0;
+	qs_idx += idpf_insert_txqs_from_grp(vport, txq, &qs[qs_idx]);
+
+	if (xdpq)
+		qs_idx += idpf_insert_txqs_from_grp(vport, xdpq, &qs[qs_idx]);
+
+	qs_idx += idpf_insert_rxqs_from_grp(vport, rxq, &qs[qs_idx]);
+
+	if (*num_qs != qs_idx) {
+		kfree(qs);
+		*num_qs = 0;
+		qs = NULL;
+	}
+
+	return qs;
+}
+
+/**
+ * idpf_qp_dis - Disables queues associated with a queue pair
+ * @vport: vport structure
+ * @q_vector: interrupt vector mapped to a given queue pair
+ * @qs: array of pointers to queues to enable
+ * @num_qs: number of queues in 'qs' array
+ * @q_idx: index of queue pair to enable
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_qp_dis(struct idpf_vport *vport, struct idpf_q_vector *q_vector,
+		       struct idpf_queue **qs, int num_qs, u16 q_idx)
+{
+	int err = 0;
+
+	netif_stop_subqueue(vport->netdev, q_idx);
+
+	err = idpf_send_disable_vport_msg(vport);
+	if (err) {
+		netdev_err(vport->netdev, "Could not disable vport, error = %d\n",
+			   err);
+		goto err_send_msg;
+	}
+	err = idpf_send_disable_selected_queues_msg(vport, qs, num_qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not disable queues for index %d, error = %d\n",
+			   q_idx, err);
+		goto err_send_msg;
+	}
+
+	napi_disable(&q_vector->napi);
+	writel(0, q_vector->intr_reg.dyn_ctl);
+	idpf_qp_clean_qs(vport, qs, num_qs);
+
+	return 0;
+
+err_send_msg:
+	netif_start_subqueue(vport->netdev, q_idx);
+
+	return err;
+}
+
+/**
+ * idpf_qp_ena - Enables queues associated with a queue pair
+ * @vport: vport structure
+ * @q_vector: interrupt vector mapped to a given queue pair
+ * @qs: array of pointers to queues to enable
+ * @num_qs: number of queues in 'qs' array
+ * @q_idx: index of queue pair to enable
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_qp_ena(struct idpf_vport *vport, struct idpf_q_vector *q_vector,
+		       struct idpf_queue **qs, int num_qs, u16 q_idx)
+{
+	int err;
+
+	err = idpf_qp_cfg_qs(vport, qs, num_qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not initialize queues for index %d, error = %d\n",
+			   q_idx, err);
+		return err;
+	}
+
+	napi_enable(&q_vector->napi);
+	idpf_qvec_ena_irq(q_vector);
+
+	err = idpf_send_config_selected_queues_msg(vport, qs, num_qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not configure queues for index %d, error = %d\n",
+			   q_idx, err);
+		return err;
+	}
+
+	err = idpf_send_enable_selected_queues_msg(vport, qs, num_qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not enable queues for index %d, error = %d\n",
+			   q_idx, err);
+		return err;
+	}
+
+	err = idpf_send_enable_vport_msg(vport);
+	if (err) {
+		netdev_err(vport->netdev, "Could not enable vport, error = %d\n",
+			   err);
+		return err;
+	}
+
+	netif_start_subqueue(vport->netdev, q_idx);
+
+	return 0;
+}
+
+/**
+ * idpf_xsk_pool_disable - disables a BUFF POOL region
+ * @vport: vport to allocate the buffer pool on
+ * @qid: queue id
+ *
+ * Returns 0 on success, negative on error
+ */
+static int idpf_xsk_pool_disable(struct idpf_vport *vport, u16 qid)
+{
+	struct idpf_vport_user_config_data *cfg_data;
+
+	if (!vport->rxq_grps)
+		return -EINVAL;
+
+	cfg_data = &vport->adapter->vport_config[vport->idx]->user_config;
+
+	return libie_xsk_disable_pool(vport->netdev, qid,
+				      cfg_data->af_xdp_zc_qps);
+}
+/**
+ * idpf_xsk_pool_enable - enables a BUFF POOL region
+ * @vport: vport to allocate the buffer pool on
+ * @pool: pointer to a requested BUFF POOL region
+ * @qid: queue id
+ *
+ * Returns 0 on success, negative on error
+ */
+static int idpf_xsk_pool_enable(struct idpf_vport *vport, u16 qid)
+{
+	struct idpf_vport_user_config_data *cfg_data;
+
+	cfg_data = &vport->adapter->vport_config[vport->idx]->user_config;
+
+	return libie_xsk_enable_pool(vport->netdev, qid,
+				     cfg_data->af_xdp_zc_qps);
+}
+
+/**
+ * idpf_xsk_pool_setup - enable/disable a BUFF POOL region
+ * @vport: current vport of interest
+ * @pool: pointer to a requested BUFF POOL region
+ * @qid: queue id
+ *
+ * Returns 0 on success, negative on failure
+ */
+int idpf_xsk_pool_setup(struct idpf_vport *vport, struct xsk_buff_pool *pool,
+			u32 qid)
+{
+	bool if_running, pool_present = !!pool;
+	int err = 0, pool_failure = 0, num_qs;
+	struct idpf_q_vector *q_vector;
+	struct idpf_queue *rxq, **qs;
+
+	if_running = netif_running(vport->netdev) &&
+		     idpf_xdp_is_prog_ena(vport);
+
+	if (if_running) {
+		rxq = idpf_find_rxq(vport, qid);
+		q_vector = rxq->q_vector;
+
+		qs = idpf_create_queue_list(vport, qid, &num_qs);
+		if (!qs) {
+			err = -ENOMEM;
+			goto xsk_exit;
+		}
+
+		err = idpf_qp_dis(vport, q_vector, qs, num_qs, qid);
+		if (err) {
+			netdev_err(vport->netdev, "Cannot disable queues for XSK setup, error = %d\n",
+				   err);
+			goto xsk_pool_if_up;
+		}
+	}
+
+	pool_failure = pool_present ? idpf_xsk_pool_enable(vport, qid) :
+				      idpf_xsk_pool_disable(vport, qid);
+
+	if (!idpf_xdp_is_prog_ena(vport))
+		netdev_warn(vport->netdev, "RSS may schedule pkts to q occupied by AF XDP\n");
+
+xsk_pool_if_up:
+	if (if_running) {
+		err = idpf_qp_ena(vport, q_vector, qs, num_qs, qid);
+		if (!err && pool_present)
+			napi_schedule(&rxq->q_vector->napi);
+		else if (err)
+			netdev_err(vport->netdev,
+				   "Could not enable queues after XSK setup, error = %d\n",
+				   err);
+		kfree(qs);
+	}
+
+	if (pool_failure) {
+		netdev_err(vport->netdev, "Could not %sable BUFF POOL, error = %d\n",
+			   pool_present ? "en" : "dis", pool_failure);
+		err = pool_failure;
+	}
+
+xsk_exit:
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_xsk.h b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
new file mode 100644
index 000000000000..93705900f592
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_xsk.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2023 Intel Corporation */
+
+#ifndef _IDPF_XSK_H_
+#define _IDPF_XSK_H_
+
+#include <linux/types.h>
+
+struct idpf_vport;
+struct xsk_buff_pool;
+
+int idpf_xsk_pool_setup(struct idpf_vport *vport, struct xsk_buff_pool *pool,
+			u32 qid);
+
+#endif /* !_IDPF_XSK_H_ */
-- 
2.43.0


