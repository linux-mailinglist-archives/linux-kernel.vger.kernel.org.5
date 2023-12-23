Return-Path: <linux-kernel+bounces-10245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F481D1B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0465BB229F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD75F3B7AC;
	Sat, 23 Dec 2023 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jm98ywo/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808073BB52;
	Sat, 23 Dec 2023 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300397; x=1734836397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=18x3JbWOZi2L2Q1g86gqflps74SQDh3HA4cpeRwIlJc=;
  b=jm98ywo/dHTzvZr0FhcxnuedAeyZIFPZ2c+AbBr0csz1FdTTt4DNKXQ2
   awyxONwMYVbZCUCVCHvFXZZjGyD2htLwvNVf6oxp7yvVdtpO6aMRwATiO
   UevZ34SwI5R4r4Is+7oO+E58VYhO4LBuLesUPDoruNhzCHcX0BLn2v8N/
   Y5ywU7wQH3OXQUdZvu7bvj1alW4ko9/jZvFRp56SXDCBxLrdsyy1bbKlW
   WiD/mj+GAATrNH1sgRew6F8az2Z9dT1VjIu1DctifevD69eknzs24QoMY
   AmfmZtkFiG07/NKDaVO8JMaIeuhFNNIUfqdEJs33aBZy4sCC35HtRP1eK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386611069"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386611069"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537658"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:53 -0800
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
Subject: [PATCH RFC net-next 29/34] idpf: add vc functions to manage selected queues
Date: Sat, 23 Dec 2023 03:55:49 +0100
Message-ID: <20231223025554.2316836-30-aleksander.lobakin@intel.com>
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

Implement VC functions dedicated to enabling, disabling and configuring
randomly selected queues.

Also, refactor the existing implementation to make the code more
modular. Introduce new generic functions for sending VC messages
consisting of chunks, in order to isolate the sending algorithm
and its implementation for specific VC messages.

Finally, rewrite the function for mapping queues to q_vectors using the
new modular approach to avoid copying the code that implements the VC
message sending algorithm.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |    9 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1085 +++++++++++------
 2 files changed, 693 insertions(+), 401 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 91f61060f500..a12c56f9f2ef 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -982,6 +982,15 @@ int idpf_vport_queue_ids_init(struct idpf_vport *vport);
 int idpf_queue_reg_init(struct idpf_vport *vport);
 int idpf_send_config_queues_msg(struct idpf_vport *vport);
 int idpf_send_enable_queues_msg(struct idpf_vport *vport);
+int idpf_send_enable_selected_queues_msg(struct idpf_vport *vport,
+					 struct idpf_queue **qs,
+					 int num_q);
+int idpf_send_disable_selected_queues_msg(struct idpf_vport *vport,
+					  struct idpf_queue **qs,
+					  int num_q);
+int idpf_send_config_selected_queues_msg(struct idpf_vport *vport,
+					 struct idpf_queue **qs,
+					 int num_q);
 int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 			       struct idpf_vport_max_q *max_q);
 int idpf_check_supported_desc_ids(struct idpf_vport *vport);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 49a96af52343..24df268ad49e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -748,26 +748,31 @@ static int idpf_wait_for_event(struct idpf_adapter *adapter,
 }
 
 /**
- * idpf_wait_for_marker_event - wait for software marker response
+ * idpf_wait_for_selected_marker_events - wait for software marker response
+ *					  for selected tx queues
  * @vport: virtual port data structure
+ * @qs: array of tx queues on which the function should wait for marker events
+ * @num_qs: number of queues contained in the 'qs' array
  *
  * Returns 0 success, negative on failure.
- **/
-static int idpf_wait_for_marker_event(struct idpf_vport *vport)
+ */
+static int idpf_wait_for_selected_marker_events(struct idpf_vport *vport,
+						struct idpf_queue **qs,
+						int num_qs)
 {
 	int event;
 	int i;
 
-	for (i = 0; i < vport->num_txq; i++)
-		set_bit(__IDPF_Q_SW_MARKER, vport->txqs[i]->flags);
+	for (i = 0; i < num_qs; i++)
+		set_bit(__IDPF_Q_SW_MARKER, qs[i]->flags);
 
 	event = wait_event_timeout(vport->sw_marker_wq,
 				   test_and_clear_bit(IDPF_VPORT_SW_MARKER,
 						      vport->flags),
 				   msecs_to_jiffies(500));
 
-	for (i = 0; i < vport->num_txq; i++)
-		clear_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
+	for (i = 0; i < num_qs; i++)
+		clear_bit(__IDPF_Q_POLL_MODE, qs[i]->flags);
 
 	if (event)
 		return 0;
@@ -777,6 +782,19 @@ static int idpf_wait_for_marker_event(struct idpf_vport *vport)
 	return -ETIMEDOUT;
 }
 
+/**
+ * idpf_wait_for_marker_event - wait for software marker response
+ * @vport: virtual port data structure
+ *
+ * Returns 0 success, negative on failure.
+ **/
+static int idpf_wait_for_marker_event(struct idpf_vport *vport)
+{
+	return idpf_wait_for_selected_marker_events(vport,
+						    vport->txqs,
+						    vport->num_txq);
+}
+
 /**
  * idpf_send_ver_msg - send virtchnl version message
  * @adapter: Driver specific private structure
@@ -1450,6 +1468,195 @@ int idpf_send_disable_vport_msg(struct idpf_vport *vport)
 	return err;
 }
 
+struct idpf_chunked_msg_params {
+	u32 op;
+	enum idpf_vport_vc_state state;
+	enum idpf_vport_vc_state err_check;
+	int timeout;
+	int config_sz;
+	int chunk_sz;
+	int (*prepare_msg)(struct idpf_vport *, u8 *, u8 *, int);
+	u32 num_chunks;
+	u8 *chunks;
+};
+
+/**
+ * idpf_send_chunked_msg - Send a VC message consisting of chunks.
+ * @vport: virtual port data structure
+ * @xn_params: parameters for this particular transaction including
+ * @prep_msg: pointer to the helper function for preparing the VC message
+ * @config_data_size: size of the message config data
+ * @num_chunks: number of chunks in the message
+ * @chunk_size: size of single message chunk
+ * @chunks: pointer to a buffer containig chunks of the message
+ *
+ * Helper function for preparing the message describing queues to be enabled
+ * or disabled.
+ * Returns the total size of the prepared message.
+ */
+static int idpf_send_chunked_msg(struct idpf_vport *vport,
+				 struct idpf_chunked_msg_params *params)
+{
+	u32 num_msgs, max_chunks, left_chunks, max_buf_sz;
+	u32 num_chunks = params->num_chunks;
+	int err = 0, i;
+	u8 *msg_buf;
+
+	max_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(params->config_sz,
+							params->chunk_sz),
+							params->num_chunks);
+	max_buf_sz = params->config_sz + max_chunks * params->chunk_sz;
+	num_msgs = DIV_ROUND_UP(params->num_chunks, max_chunks);
+
+	msg_buf = kzalloc(max_buf_sz, GFP_KERNEL);
+	if (!msg_buf) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	mutex_lock(&vport->vc_buf_lock);
+
+	left_chunks = num_chunks;
+	for (i = 0; i < num_msgs; i++) {
+		u8 *chunks = params->chunks;
+		int buf_sz, msg_size;
+		u8 *first_chunk;
+
+		num_chunks = min(max_chunks, left_chunks);
+		first_chunk = chunks + (i * params->chunk_sz * max_chunks);
+		msg_size = params->chunk_sz * num_chunks + params->config_sz;
+
+		buf_sz = params->prepare_msg(vport, msg_buf, first_chunk,
+					     num_chunks);
+		if (buf_sz != msg_size) {
+			err = -EINVAL;
+			goto msg_error;
+		}
+
+		err = idpf_send_mb_msg(vport->adapter, params->op,
+				       buf_sz, msg_buf);
+		if (err)
+			goto msg_error;
+
+		err = __idpf_wait_for_event(vport->adapter, vport,
+					    params->state, params->err_check,
+					    params->timeout);
+		if (err)
+			goto msg_error;
+
+		left_chunks -= num_chunks;
+	}
+
+	if (left_chunks != 0)
+		err = -EINVAL;
+msg_error:
+	mutex_unlock(&vport->vc_buf_lock);
+	kfree(msg_buf);
+error:
+	return err;
+}
+
+/**
+ * idpf_fill_txcomplq_config_chunk - Fill the chunk describing the tx queue.
+ * @vport: virtual port data structure
+ * @q: tx queue to be inserted into VC chunk
+ * @qi: pointer to the buffer containing the VC chunk
+ */
+static void idpf_fill_txcomplq_config_chunk(struct idpf_vport *vport,
+					    struct idpf_queue *q,
+					    struct virtchnl2_txq_info *qi)
+{
+	qi->queue_id = cpu_to_le32(q->q_id);
+	qi->model = cpu_to_le16(vport->txq_model);
+	qi->type = cpu_to_le32(q->q_type);
+	qi->ring_len = cpu_to_le16(q->desc_count);
+	qi->dma_ring_addr = cpu_to_le64(q->dma);
+
+	if (!idpf_is_queue_model_split(vport->txq_model))
+		return;
+
+	if (test_bit(__IDPF_Q_FLOW_SCH_EN, q->flags))
+		qi->sched_mode = cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_FLOW);
+	else
+		qi->sched_mode = cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_QUEUE);
+
+	if (q->q_type != VIRTCHNL2_QUEUE_TYPE_TX)
+		return;
+
+	qi->tx_compl_queue_id = cpu_to_le16(q->txq_grp->complq->q_id);
+	qi->relative_queue_id = cpu_to_le16(q->relative_q_id);
+}
+
+/**
+ * idpf_prepare_cfg_txqs_msg - Prepare message to configure selected tx queues.
+ * @vport: virtual port data structure
+ * @msg_buf: buffer containing the message
+ * @first_chunk: pointer to the first chunk describing the tx queue
+ * @num_chunks: number of chunks in the message
+ *
+ * Helper function for preparing the message describing configuration of
+ * tx queues.
+ * Returns the total size of the prepared message.
+ */
+static int idpf_prepare_cfg_txqs_msg(struct idpf_vport *vport,
+				     u8 *msg_buf, u8 *first_chunk,
+				     int num_chunks)
+{
+	int chunk_size = sizeof(struct virtchnl2_txq_info);
+	struct virtchnl2_config_tx_queues *ctq;
+
+	ctq = (struct virtchnl2_config_tx_queues *)msg_buf;
+	ctq->vport_id = cpu_to_le32(vport->vport_id);
+	ctq->num_qinfo = cpu_to_le16(num_chunks);
+
+	memcpy(ctq->qinfo, first_chunk, num_chunks * chunk_size);
+
+	return (chunk_size * num_chunks + sizeof(*ctq));
+}
+
+/**
+ * idpf_send_config_selected_tx_queues_msg - Send virtchnl config tx queues
+ * message for selected tx queues only.
+ * @vport: virtual port data structure
+ * @qs: array of tx queues to be configured
+ * @num_q: number of tx queues contained in 'qs' array
+ *
+ * Send config queues virtchnl message for queues contained in 'qs' array.
+ * The 'qs' array can contain tx queues (or completion queues) only.
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_send_config_selected_tx_queues_msg(struct idpf_vport *vport,
+						   struct idpf_queue **qs,
+						   int num_q)
+{
+	struct idpf_chunked_msg_params params = { };
+	struct virtchnl2_txq_info *qi;
+	int err, i;
+
+	qi = (struct virtchnl2_txq_info *)
+		kcalloc(num_q, sizeof(struct virtchnl2_txq_info), GFP_KERNEL);
+	if (!qi)
+		return -ENOMEM;
+
+	params.op = VIRTCHNL2_OP_CONFIG_TX_QUEUES;
+	params.state = IDPF_VC_CONFIG_TXQ;
+	params.err_check = IDPF_VC_CONFIG_TXQ_ERR;
+	params.timeout = IDPF_WAIT_FOR_EVENT_TIMEO;
+	params.config_sz = sizeof(struct virtchnl2_config_tx_queues);
+	params.chunk_sz = sizeof(struct virtchnl2_txq_info);
+	params.prepare_msg = &idpf_prepare_cfg_txqs_msg;
+	params.num_chunks = num_q;
+	params.chunks = (u8 *)qi;
+
+	for (i = 0; i < num_q; i++)
+		idpf_fill_txcomplq_config_chunk(vport, qs[i], &qi[i]);
+
+	err = idpf_send_chunked_msg(vport, &params);
+
+	kfree(qi);
+	return err;
+}
+
 /**
  * idpf_send_config_tx_queues_msg - Send virtchnl config tx queues message
  * @vport: virtual port data structure
@@ -1459,69 +1666,24 @@ int idpf_send_disable_vport_msg(struct idpf_vport *vport)
  */
 static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 {
-	struct virtchnl2_config_tx_queues *ctq;
-	u32 config_sz, chunk_sz, buf_sz;
-	int totqs, num_msgs, num_chunks;
-	struct virtchnl2_txq_info *qi;
-	int err = 0, i, k = 0;
+	int totqs, err = 0, i, k = 0;
+	struct idpf_queue **qs;
 
 	totqs = vport->num_txq + vport->num_complq;
-	qi = kcalloc(totqs, sizeof(struct virtchnl2_txq_info), GFP_KERNEL);
-	if (!qi)
+	qs = (struct idpf_queue **)kzalloc(totqs * sizeof(*qs), GFP_KERNEL);
+	if (!qs)
 		return -ENOMEM;
 
 	/* Populate the queue info buffer with all queue context info */
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
-		int j, sched_mode;
-
-		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			qi[k].queue_id =
-				cpu_to_le32(tx_qgrp->txqs[j]->q_id);
-			qi[k].model =
-				cpu_to_le16(vport->txq_model);
-			qi[k].type =
-				cpu_to_le32(tx_qgrp->txqs[j]->q_type);
-			qi[k].ring_len =
-				cpu_to_le16(tx_qgrp->txqs[j]->desc_count);
-			qi[k].dma_ring_addr =
-				cpu_to_le64(tx_qgrp->txqs[j]->dma);
-			if (idpf_is_queue_model_split(vport->txq_model)) {
-				struct idpf_queue *q = tx_qgrp->txqs[j];
-
-				qi[k].tx_compl_queue_id =
-					cpu_to_le16(tx_qgrp->complq->q_id);
-				qi[k].relative_queue_id =
-					cpu_to_le16(q->relative_q_id);
-
-				if (test_bit(__IDPF_Q_FLOW_SCH_EN, q->flags))
-					qi[k].sched_mode =
-					cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_FLOW);
-				else
-					qi[k].sched_mode =
-					cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_QUEUE);
-			} else {
-				qi[k].sched_mode =
-					cpu_to_le16(VIRTCHNL2_TXQ_SCHED_MODE_QUEUE);
-			}
-		}
-
-		if (!idpf_is_queue_model_split(vport->txq_model))
-			continue;
-
-		qi[k].queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
-		qi[k].model = cpu_to_le16(vport->txq_model);
-		qi[k].type = cpu_to_le32(tx_qgrp->complq->q_type);
-		qi[k].ring_len = cpu_to_le16(tx_qgrp->complq->desc_count);
-		qi[k].dma_ring_addr = cpu_to_le64(tx_qgrp->complq->dma);
+		int j;
 
-		if (test_bit(__IDPF_Q_FLOW_SCH_EN, tx_qgrp->complq->flags))
-			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_FLOW;
-		else
-			sched_mode = VIRTCHNL2_TXQ_SCHED_MODE_QUEUE;
-		qi[k].sched_mode = cpu_to_le16(sched_mode);
+		for (j = 0; j < tx_qgrp->num_txq; j++, k++)
+			qs[k] = tx_qgrp->txqs[j];
 
-		k++;
+		if (idpf_is_queue_model_split(vport->txq_model))
+			qs[k++] = tx_qgrp->complq;
 	}
 
 	/* Make sure accounting agrees */
@@ -1530,56 +1692,142 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
 		goto error;
 	}
 
-	/* Chunk up the queue contexts into multiple messages to avoid
-	 * sending a control queue message buffer that is too large
+	err = idpf_send_config_selected_tx_queues_msg(vport, qs, totqs);
+error:
+	kfree(qs);
+	return err;
+}
+
+/**
+ * idpf_fill_bufq_config_chunk - Fill the chunk describing the rx or buf queue.
+ * @vport: virtual port data structure
+ * @rxbufq: rx or buffer queue to be inserted into VC chunk
+ * @qi: pointer to the buffer containing the VC chunk
+ */
+static void idpf_fill_rxbufq_config_chunk(struct idpf_vport *vport,
+					  struct idpf_queue *q,
+					  struct virtchnl2_rxq_info *qi)
+{
+	const struct idpf_bufq_set *sets;
+
+	qi->queue_id = cpu_to_le32(q->q_id);
+	qi->model = cpu_to_le16(vport->rxq_model);
+	qi->type = cpu_to_le32(q->q_type);
+	qi->ring_len = cpu_to_le16(q->desc_count);
+	qi->dma_ring_addr = cpu_to_le64(q->dma);
+	qi->data_buffer_size = cpu_to_le32(q->rx_buf_size);
+	qi->rx_buffer_low_watermark =
+		cpu_to_le16(q->rx_buffer_low_watermark);
+	if (idpf_is_feature_ena(vport, NETIF_F_GRO_HW))
+		qi->qflags |= cpu_to_le16(VIRTCHNL2_RXQ_RSC);
+
+	if (q->q_type == VIRTCHNL2_QUEUE_TYPE_RX_BUFFER) {
+		qi->desc_ids = cpu_to_le64(VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M);
+		qi->buffer_notif_stride = q->rx_buf_stride;
+	}
+
+	if (q->q_type != VIRTCHNL2_QUEUE_TYPE_RX)
+		return;
+
+	qi->max_pkt_size = cpu_to_le32(q->rx_max_pkt_size);
+	qi->qflags |= cpu_to_le16(VIRTCHNL2_RX_DESC_SIZE_32BYTE);
+	qi->desc_ids = cpu_to_le64(q->rxdids);
+
+	if (!idpf_is_queue_model_split(vport->rxq_model))
+		return;
+
+	sets = q->rxq_grp->splitq.bufq_sets;
+
+	/* In splitq mode, RXQ buffer size should be set to that of the first
+	 * buffer queue associated with this RXQ.
 	 */
-	config_sz = sizeof(struct virtchnl2_config_tx_queues);
-	chunk_sz = sizeof(struct virtchnl2_txq_info);
+	q->rx_buf_size = sets[0].bufq.rx_buf_size;
+	qi->data_buffer_size = cpu_to_le32(q->rx_buf_size);
+
+	qi->rx_bufq1_id = cpu_to_le16(sets[0].bufq.q_id);
+	if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP) {
+		qi->bufq2_ena = IDPF_BUFQ2_ENA;
+		qi->rx_bufq2_id = cpu_to_le16(sets[1].bufq.q_id);
+	}
 
-	num_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(config_sz, chunk_sz),
-			   totqs);
-	num_msgs = DIV_ROUND_UP(totqs, num_chunks);
+	q->rx_hbuf_size = sets[0].bufq.rx_hbuf_size;
 
-	buf_sz = struct_size(ctq, qinfo, num_chunks);
-	ctq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!ctq) {
-		err = -ENOMEM;
-		goto error;
+	if (q->rx_hsplit_en) {
+		qi->qflags |= cpu_to_le16(VIRTCHNL2_RXQ_HDR_SPLIT);
+		qi->hdr_buffer_size = cpu_to_le16(q->rx_hbuf_size);
 	}
+}
 
-	mutex_lock(&vport->vc_buf_lock);
+/**
+ * idpf_prepare_cfg_rxqs_msg - Prepare message to configure selected rx queues.
+ * @vport: virtual port data structure
+ * @msg_buf: buffer containing the message
+ * @first_chunk: pointer to the first chunk describing the rx queue
+ * @num_chunks: number of chunks in the message
+ *
+ * Helper function for preparing the message describing configuration of
+ * rx queues.
+ * Returns the total size of the prepared message.
+ */
+static int idpf_prepare_cfg_rxqs_msg(struct idpf_vport *vport,
+				     u8 *msg_buf, u8 *first_chunk,
+				     int num_chunks)
+{
+	int chunk_size = sizeof(struct virtchnl2_rxq_info);
+	struct virtchnl2_config_rx_queues *crq;
 
-	for (i = 0, k = 0; i < num_msgs; i++) {
-		memset(ctq, 0, buf_sz);
-		ctq->vport_id = cpu_to_le32(vport->vport_id);
-		ctq->num_qinfo = cpu_to_le16(num_chunks);
-		memcpy(ctq->qinfo, &qi[k], chunk_sz * num_chunks);
-
-		err = idpf_send_mb_msg(vport->adapter,
-				       VIRTCHNL2_OP_CONFIG_TX_QUEUES,
-				       buf_sz, (u8 *)ctq);
-		if (err)
-			goto mbx_error;
+	crq = (struct virtchnl2_config_rx_queues *)msg_buf;
 
-		err = idpf_wait_for_event(vport->adapter, vport,
-					  IDPF_VC_CONFIG_TXQ,
-					  IDPF_VC_CONFIG_TXQ_ERR);
-		if (err)
-			goto mbx_error;
+	crq->vport_id = cpu_to_le32(vport->vport_id);
+	crq->num_qinfo = cpu_to_le16(num_chunks);
+
+	memcpy(crq->qinfo, first_chunk, num_chunks * chunk_size);
+
+	return (chunk_size * num_chunks + sizeof(*crq));
+}
 
-		k += num_chunks;
-		totqs -= num_chunks;
-		num_chunks = min(num_chunks, totqs);
-		/* Recalculate buffer size */
-		buf_sz = struct_size(ctq, qinfo, num_chunks);
+/**
+ * idpf_send_config_selected_rx_queues_msg - Send virtchnl config rx queues
+ * message for selected rx queues only.
+ * @vport: virtual port data structure
+ * @qs: array of rx queues to be configured
+ * @num_q: number of rx queues contained in 'qs' array
+ *
+ * Send config queues virtchnl message for queues contained in 'qs' array.
+ * The 'qs' array can contain rx queues (or buffer queues) only.
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_send_config_selected_rx_queues_msg(struct idpf_vport *vport,
+						   struct idpf_queue **qs,
+						   int num_q)
+{
+	struct idpf_chunked_msg_params params = { };
+	struct virtchnl2_rxq_info *qi;
+	int err, i;
+
+	qi = (struct virtchnl2_rxq_info *)
+		kcalloc(num_q, sizeof(struct virtchnl2_rxq_info), GFP_KERNEL);
+	if (!qi) {
+		err = -ENOMEM;
+		goto alloc_error;
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(ctq);
-error:
-	kfree(qi);
+	params.op = VIRTCHNL2_OP_CONFIG_RX_QUEUES;
+	params.state = IDPF_VC_CONFIG_RXQ;
+	params.err_check = IDPF_VC_CONFIG_RXQ_ERR;
+	params.timeout = IDPF_WAIT_FOR_EVENT_TIMEO;
+	params.config_sz = sizeof(struct virtchnl2_config_rx_queues);
+	params.chunk_sz = sizeof(struct virtchnl2_rxq_info);
+	params.prepare_msg = &idpf_prepare_cfg_rxqs_msg;
+	params.num_chunks = num_q;
+	params.chunks = (u8 *)qi;
 
+	for (i = 0; i < num_q; i++)
+		idpf_fill_rxbufq_config_chunk(vport, qs[i], &qi[i]);
+
+	err = idpf_send_chunked_msg(vport, &params);
+	kfree(qi);
+alloc_error:
 	return err;
 }
 
@@ -1592,43 +1840,25 @@ static int idpf_send_config_tx_queues_msg(struct idpf_vport *vport)
  */
 static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 {
-	struct virtchnl2_config_rx_queues *crq;
-	u32 config_sz, chunk_sz, buf_sz;
-	int totqs, num_msgs, num_chunks;
-	struct virtchnl2_rxq_info *qi;
-	int err = 0, i, k = 0;
+	int totqs, err = 0, i, k = 0;
+	struct idpf_queue **qs;
 
 	totqs = vport->num_rxq + vport->num_bufq;
-	qi = kcalloc(totqs, sizeof(struct virtchnl2_rxq_info), GFP_KERNEL);
-	if (!qi)
+	qs = (struct idpf_queue **)kzalloc(totqs * sizeof(*qs), GFP_KERNEL);
+	if (!qs)
 		return -ENOMEM;
 
 	/* Populate the queue info buffer with all queue context info */
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-		u16 num_rxq;
+		int num_rxq;
 		int j;
 
 		if (!idpf_is_queue_model_split(vport->rxq_model))
 			goto setup_rxqs;
 
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++) {
-			struct idpf_queue *bufq =
-				&rx_qgrp->splitq.bufq_sets[j].bufq;
-
-			qi[k].queue_id = cpu_to_le32(bufq->q_id);
-			qi[k].model = cpu_to_le16(vport->rxq_model);
-			qi[k].type = cpu_to_le32(bufq->q_type);
-			qi[k].desc_ids = cpu_to_le64(VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M);
-			qi[k].ring_len = cpu_to_le16(bufq->desc_count);
-			qi[k].dma_ring_addr = cpu_to_le64(bufq->dma);
-			qi[k].data_buffer_size = cpu_to_le32(bufq->rx_buf_size);
-			qi[k].buffer_notif_stride = bufq->rx_buf_stride;
-			qi[k].rx_buffer_low_watermark =
-				cpu_to_le16(bufq->rx_buffer_low_watermark);
-			if (idpf_is_feature_ena(vport, NETIF_F_GRO_HW))
-				qi[k].qflags |= cpu_to_le16(VIRTCHNL2_RXQ_RSC);
-		}
+		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++)
+			qs[k] = &rx_qgrp->splitq.bufq_sets[j].bufq;
 
 setup_rxqs:
 		if (idpf_is_queue_model_split(vport->rxq_model))
@@ -1636,56 +1866,11 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 		else
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
-		for (j = 0; j < num_rxq; j++, k++) {
-			const struct idpf_bufq_set *sets;
-			struct idpf_queue *rxq;
-
-			if (!idpf_is_queue_model_split(vport->rxq_model)) {
-				rxq = rx_qgrp->singleq.rxqs[j];
-				goto common_qi_fields;
-			}
-
-			rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
-			sets = rxq->rxq_grp->splitq.bufq_sets;
-
-			/* In splitq mode, RXQ buffer size should be
-			 * set to that of the first buffer queue
-			 * associated with this RXQ.
-			 */
-			rxq->rx_buf_size = sets[0].bufq.rx_buf_size;
-
-			qi[k].rx_bufq1_id = cpu_to_le16(sets[0].bufq.q_id);
-			if (vport->num_bufqs_per_qgrp > IDPF_SINGLE_BUFQ_PER_RXQ_GRP) {
-				qi[k].bufq2_ena = IDPF_BUFQ2_ENA;
-				qi[k].rx_bufq2_id =
-					cpu_to_le16(sets[1].bufq.q_id);
-			}
-			qi[k].rx_buffer_low_watermark =
-				cpu_to_le16(rxq->rx_buffer_low_watermark);
-			if (idpf_is_feature_ena(vport, NETIF_F_GRO_HW))
-				qi[k].qflags |= cpu_to_le16(VIRTCHNL2_RXQ_RSC);
-
-			rxq->rx_hbuf_size = sets[0].bufq.rx_hbuf_size;
-
-			if (rxq->rx_hsplit_en) {
-				qi[k].qflags |=
-					cpu_to_le16(VIRTCHNL2_RXQ_HDR_SPLIT);
-				qi[k].hdr_buffer_size =
-					cpu_to_le16(rxq->rx_hbuf_size);
-			}
-
-common_qi_fields:
-			qi[k].queue_id = cpu_to_le32(rxq->q_id);
-			qi[k].model = cpu_to_le16(vport->rxq_model);
-			qi[k].type = cpu_to_le32(rxq->q_type);
-			qi[k].ring_len = cpu_to_le16(rxq->desc_count);
-			qi[k].dma_ring_addr = cpu_to_le64(rxq->dma);
-			qi[k].max_pkt_size = cpu_to_le32(rxq->rx_max_pkt_size);
-			qi[k].data_buffer_size = cpu_to_le32(rxq->rx_buf_size);
-			qi[k].qflags |=
-				cpu_to_le16(VIRTCHNL2_RX_DESC_SIZE_32BYTE);
-			qi[k].desc_ids = cpu_to_le64(rxq->rxdids);
-		}
+		for (j = 0; j < num_rxq; j++, k++)
+			if (!idpf_is_queue_model_split(vport->rxq_model))
+				qs[k] = rx_qgrp->singleq.rxqs[j];
+			else
+				qs[k] = &rx_qgrp->splitq.rxq_sets[j]->rxq;
 	}
 
 	/* Make sure accounting agrees */
@@ -1694,56 +1879,94 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
 		goto error;
 	}
 
-	/* Chunk up the queue contexts into multiple messages to avoid
-	 * sending a control queue message buffer that is too large
-	 */
-	config_sz = sizeof(struct virtchnl2_config_rx_queues);
-	chunk_sz = sizeof(struct virtchnl2_rxq_info);
+	err = idpf_send_config_selected_rx_queues_msg(vport, qs, totqs);
 
-	num_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(config_sz, chunk_sz),
-			   totqs);
-	num_msgs = DIV_ROUND_UP(totqs, num_chunks);
+error:
+	kfree(qs);
+	return err;
+}
 
-	buf_sz = struct_size(crq, qinfo, num_chunks);
-	crq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!crq) {
-		err = -ENOMEM;
-		goto error;
-	}
+/**
+ * idpf_prepare_ena_dis_qs_msg - Prepare message to enable/disable selected
+ * queues.
+ * @vport: virtual port data structure
+ * @msg_buf: buffer containing the message
+ * @first_chunk: pointer to the first chunk describing the queue
+ * @num_chunks: number of chunks in the message
+ *
+ * Helper function for preparing the message describing queues to be enabled
+ * or disabled.
+ * Returns the total size of the prepared message.
+ */
+static int idpf_prepare_ena_dis_qs_msg(struct idpf_vport *vport,
+				       u8 *msg_buf, u8 *first_chunk,
+				       int num_chunks)
+{
+	int chunk_size = sizeof(struct virtchnl2_queue_chunk);
+	struct virtchnl2_del_ena_dis_queues *eq;
 
-	mutex_lock(&vport->vc_buf_lock);
+	eq = (struct virtchnl2_del_ena_dis_queues *)msg_buf;
 
-	for (i = 0, k = 0; i < num_msgs; i++) {
-		memset(crq, 0, buf_sz);
-		crq->vport_id = cpu_to_le32(vport->vport_id);
-		crq->num_qinfo = cpu_to_le16(num_chunks);
-		memcpy(crq->qinfo, &qi[k], chunk_sz * num_chunks);
-
-		err = idpf_send_mb_msg(vport->adapter,
-				       VIRTCHNL2_OP_CONFIG_RX_QUEUES,
-				       buf_sz, (u8 *)crq);
-		if (err)
-			goto mbx_error;
+	eq->vport_id = cpu_to_le32(vport->vport_id);
+	eq->chunks.num_chunks = cpu_to_le16(num_chunks);
 
-		err = idpf_wait_for_event(vport->adapter, vport,
-					  IDPF_VC_CONFIG_RXQ,
-					  IDPF_VC_CONFIG_RXQ_ERR);
-		if (err)
-			goto mbx_error;
+	memcpy(eq->chunks.chunks, first_chunk, num_chunks * chunk_size);
+
+	return (chunk_size * num_chunks + sizeof(*eq));
+}
+
+/**
+ * idpf_send_ena_dis_selected_qs_msg - Send virtchnl enable or disable
+ * queues message for selected queues only
+ * @vport: virtual port data structure
+ * @qs: array containing pointers to queues to be enabled/disabled
+ * @num_q: number of queues contained in 'qs' array.
+ * @ena: if true enable, false disable
+ *
+ * Send enable or disable queues virtchnl message for queues contained
+ * in 'qs' array.
+ * The 'qs' array can contain pointers to both rx and tx queues.
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_send_ena_dis_selected_qs_msg(struct idpf_vport *vport,
+					     struct idpf_queue **qs,
+					     int num_q,
+					     u32 vc_op)
+{
+	bool en = vc_op == VIRTCHNL2_OP_ENABLE_QUEUES;
+	struct idpf_chunked_msg_params params = { };
+	struct virtchnl2_queue_chunk *qc;
+	int err, i;
 
-		k += num_chunks;
-		totqs -= num_chunks;
-		num_chunks = min(num_chunks, totqs);
-		/* Recalculate buffer size */
-		buf_sz = struct_size(crq, qinfo, num_chunks);
+	qc = (struct virtchnl2_queue_chunk *)kzalloc(sizeof(*qc) * num_q,
+						     GFP_KERNEL);
+	if (!qc) {
+		err = -ENOMEM;
+		goto alloc_error;
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(crq);
-error:
-	kfree(qi);
+	params.op = vc_op;
+	params.state = en ? IDPF_VC_ENA_QUEUES : IDPF_VC_DIS_QUEUES;
+	params.err_check = en ? IDPF_VC_ENA_QUEUES_ERR : IDPF_VC_DIS_QUEUES_ERR;
+	params.timeout = en ? IDPF_WAIT_FOR_EVENT_TIMEO :
+			      IDPF_WAIT_FOR_EVENT_TIMEO_MIN;
+	params.config_sz = sizeof(struct virtchnl2_del_ena_dis_queues);
+	params.chunk_sz = sizeof(struct virtchnl2_queue_chunk);
+	params.prepare_msg = &idpf_prepare_ena_dis_qs_msg;
+	params.num_chunks = num_q;
+	params.chunks = (u8 *)qc;
+
+	for (i = 0; i < num_q; i++) {
+		struct idpf_queue *q = qs[i];
+
+		qc[i].start_queue_id = cpu_to_le32(q->q_id);
+		qc[i].type = cpu_to_le32(q->q_type);
+		qc[i].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
+	}
 
+	err = idpf_send_chunked_msg(vport, &params);
+	kfree(qc);
+alloc_error:
 	return err;
 }
 
@@ -1758,39 +1981,23 @@ static int idpf_send_config_rx_queues_msg(struct idpf_vport *vport)
  */
 static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 {
-	u32 num_msgs, num_chunks, num_txq, num_rxq, num_q;
-	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_del_ena_dis_queues *eq;
-	struct virtchnl2_queue_chunks *qcs;
-	struct virtchnl2_queue_chunk *qc;
-	u32 config_sz, chunk_sz, buf_sz;
-	int i, j, k = 0, err = 0;
-
-	/* validate virtchnl op */
-	switch (vc_op) {
-	case VIRTCHNL2_OP_ENABLE_QUEUES:
-	case VIRTCHNL2_OP_DISABLE_QUEUES:
-		break;
-	default:
-		return -EINVAL;
-	}
+	int num_txq, num_rxq, num_q, err = 0;
+	struct idpf_queue **qs;
+	int i, j, k = 0;
 
 	num_txq = vport->num_txq + vport->num_complq;
 	num_rxq = vport->num_rxq + vport->num_bufq;
 	num_q = num_txq + num_rxq;
-	buf_sz = sizeof(struct virtchnl2_queue_chunk) * num_q;
-	qc = kzalloc(buf_sz, GFP_KERNEL);
-	if (!qc)
+
+	qs = (struct idpf_queue **)kzalloc(num_q * sizeof(*qs), GFP_KERNEL);
+	if (!qs)
 		return -ENOMEM;
 
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
-		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			qc[k].type = cpu_to_le32(tx_qgrp->txqs[j]->q_type);
-			qc[k].start_queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-		}
+		for (j = 0; j < tx_qgrp->num_txq; j++, k++)
+			qs[k] = tx_qgrp->txqs[j];
 	}
 	if (vport->num_txq != k) {
 		err = -EINVAL;
@@ -1800,13 +2007,9 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 	if (!idpf_is_queue_model_split(vport->txq_model))
 		goto setup_rx;
 
-	for (i = 0; i < vport->num_txq_grp; i++, k++) {
-		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
+	for (i = 0; i < vport->num_txq_grp; i++, k++)
+		qs[k] = vport->txq_grps[i].complq;
 
-		qc[k].type = cpu_to_le32(tx_qgrp->complq->q_type);
-		qc[k].start_queue_id = cpu_to_le32(tx_qgrp->complq->q_id);
-		qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-	}
 	if (vport->num_complq != (k - vport->num_txq)) {
 		err = -EINVAL;
 		goto error;
@@ -1822,18 +2025,10 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 			num_rxq = rx_qgrp->singleq.num_rxq;
 
 		for (j = 0; j < num_rxq; j++, k++) {
-			if (idpf_is_queue_model_split(vport->rxq_model)) {
-				qc[k].start_queue_id =
-				cpu_to_le32(rx_qgrp->splitq.rxq_sets[j]->rxq.q_id);
-				qc[k].type =
-				cpu_to_le32(rx_qgrp->splitq.rxq_sets[j]->rxq.q_type);
-			} else {
-				qc[k].start_queue_id =
-				cpu_to_le32(rx_qgrp->singleq.rxqs[j]->q_id);
-				qc[k].type =
-				cpu_to_le32(rx_qgrp->singleq.rxqs[j]->q_type);
-			}
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
+			if (idpf_is_queue_model_split(vport->rxq_model))
+				qs[k] = &rx_qgrp->splitq.rxq_sets[j]->rxq;
+			else
+				qs[k] = rx_qgrp->singleq.rxqs[j];
 		}
 	}
 	if (vport->num_rxq != k - (vport->num_txq + vport->num_complq)) {
@@ -1847,14 +2042,8 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
 
-		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++) {
-			struct idpf_queue *q;
-
-			q = &rx_qgrp->splitq.bufq_sets[j].bufq;
-			qc[k].type = cpu_to_le32(q->q_type);
-			qc[k].start_queue_id = cpu_to_le32(q->q_id);
-			qc[k].num_queues = cpu_to_le32(IDPF_NUMQ_PER_CHUNK);
-		}
+		for (j = 0; j < vport->num_bufqs_per_qgrp; j++, k++)
+			qs[k] = &rx_qgrp->splitq.bufq_sets[j].bufq;
 	}
 	if (vport->num_bufq != k - (vport->num_txq +
 				    vport->num_complq +
@@ -1864,58 +2053,117 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
 	}
 
 send_msg:
-	/* Chunk up the queue info into multiple messages */
-	config_sz = sizeof(struct virtchnl2_del_ena_dis_queues);
-	chunk_sz = sizeof(struct virtchnl2_queue_chunk);
+	err = idpf_send_ena_dis_selected_qs_msg(vport, qs, num_q, vc_op);
+error:
+	kfree(qs);
+	return err;
+}
 
-	num_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(config_sz, chunk_sz),
-			   num_q);
-	num_msgs = DIV_ROUND_UP(num_q, num_chunks);
+/**
+ * idpf_prep_map_unmap_sel_queue_vector_msg - Prepare message to map or unmap
+ * selected queues to the interrupt vector.
+ * @vport: virtual port data structure
+ * @msg_buf: buffer containing the message
+ * @first_chunk: pointer to the first chunk describing the vector mapping
+ * @num_chunks: number of chunks in the message
+ *
+ * Helper function for preparing the message describing mapping queues to
+ * q_vectors.
+ * Returns the total size of the prepared message.
+ */
+static int
+idpf_prep_map_unmap_sel_queue_vector_msg(struct idpf_vport *vport,
+					 u8 *msg_buf, u8 *first_chunk,
+					 int num_chunks)
+{
+	int chunk_size = sizeof(struct virtchnl2_queue_vector);
+	struct virtchnl2_queue_vector_maps *vqvm;
 
-	buf_sz = struct_size(eq, chunks.chunks, num_chunks);
-	eq = kzalloc(buf_sz, GFP_KERNEL);
-	if (!eq) {
-		err = -ENOMEM;
-		goto error;
-	}
+	vqvm = (struct virtchnl2_queue_vector_maps *)msg_buf;
 
-	mutex_lock(&vport->vc_buf_lock);
+	vqvm->vport_id = cpu_to_le32(vport->vport_id);
+	vqvm->num_qv_maps = cpu_to_le16(num_chunks);
 
-	for (i = 0, k = 0; i < num_msgs; i++) {
-		memset(eq, 0, buf_sz);
-		eq->vport_id = cpu_to_le32(vport->vport_id);
-		eq->chunks.num_chunks = cpu_to_le16(num_chunks);
-		qcs = &eq->chunks;
-		memcpy(qcs->chunks, &qc[k], chunk_sz * num_chunks);
+	memcpy(vqvm->qv_maps, first_chunk, num_chunks * chunk_size);
 
-		err = idpf_send_mb_msg(adapter, vc_op, buf_sz, (u8 *)eq);
-		if (err)
-			goto mbx_error;
+	return chunk_size * num_chunks + sizeof(*vqvm);
+}
 
-		if (vc_op == VIRTCHNL2_OP_ENABLE_QUEUES)
-			err = idpf_wait_for_event(adapter, vport,
-						  IDPF_VC_ENA_QUEUES,
-						  IDPF_VC_ENA_QUEUES_ERR);
-		else
-			err = idpf_min_wait_for_event(adapter, vport,
-						      IDPF_VC_DIS_QUEUES,
-						      IDPF_VC_DIS_QUEUES_ERR);
-		if (err)
-			goto mbx_error;
+/**
+ * idpf_send_map_unmap_sel_queue_vector_msg - Send virtchnl map or unmap
+ * selected queue vector message
+ * @vport: virtual port data structure
+ * @qs: array of queues to be mapped/unmapped
+ * @num_q: number of queues in 'qs' array
+ * @map: true for map and false for unmap
+ *
+ * Send map or unmap queue vector virtchnl message for selected queues only.
+ * Returns 0 on success, negative on failure.
+ */
+static int idpf_send_map_unmap_sel_queue_vector_msg(struct idpf_vport *vport,
+						    struct idpf_queue **qs,
+						    int num_q,
+						    bool map)
+{
+	struct idpf_chunked_msg_params params = { };
+	struct virtchnl2_queue_vector *vqv;
+	int err, i;
 
-		k += num_chunks;
-		num_q -= num_chunks;
-		num_chunks = min(num_chunks, num_q);
-		/* Recalculate buffer size */
-		buf_sz = struct_size(eq, chunks.chunks, num_chunks);
+	vqv = (struct virtchnl2_queue_vector *)kzalloc(sizeof(*vqv) * num_q,
+						       GFP_KERNEL);
+	if (!vqv) {
+		err = -ENOMEM;
+		goto alloc_error;
 	}
 
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(eq);
-error:
-	kfree(qc);
+	params.op = map ? VIRTCHNL2_OP_MAP_QUEUE_VECTOR :
+			  VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR;
+	params.state = map ? IDPF_VC_MAP_IRQ : IDPF_VC_UNMAP_IRQ;
+	params.err_check = map ? IDPF_VC_MAP_IRQ_ERR : IDPF_VC_UNMAP_IRQ_ERR;
+	params.timeout = map ? IDPF_WAIT_FOR_EVENT_TIMEO :
+			       IDPF_WAIT_FOR_EVENT_TIMEO_MIN;
+	params.config_sz = sizeof(struct virtchnl2_queue_vector_maps);
+	params.chunk_sz = sizeof(struct virtchnl2_queue_vector);
+	params.prepare_msg = &idpf_prep_map_unmap_sel_queue_vector_msg;
+	params.num_chunks = num_q;
+	params.chunks = (u8 *)vqv;
+
+	for (i = 0; i < num_q; i++) {
+		const struct idpf_q_vector *vec;
+		struct idpf_queue *q = qs[i];
+		u32 vector_id, itr_idx;
+
+		vqv[i].queue_type = cpu_to_le32(q->q_type);
+		vqv[i].queue_id = cpu_to_le32(q->q_id);
+
+		if (q->q_type != VIRTCHNL2_QUEUE_TYPE_TX) {
+			vector_id = q->q_vector->v_idx;
+			itr_idx = q->q_vector->rx_itr_idx;
+
+			goto fill;
+		}
 
+		if (idpf_is_queue_model_split(vport->txq_model))
+			vec = q->txq_grp->complq->q_vector;
+		else
+			vec = q->q_vector;
+
+		if (vec) {
+			vector_id = vec->v_idx;
+			itr_idx = vec->tx_itr_idx;
+		} else {
+			vector_id = 0;
+			itr_idx = VIRTCHNL2_ITR_IDX_1;
+		}
+
+fill:
+		vqv[i].vector_id = cpu_to_le16(vector_id);
+		vqv[i].itr_idx = cpu_to_le32(itr_idx);
+	}
+
+	err = idpf_send_chunked_msg(vport, &params);
+	kfree(vqv);
+alloc_error:
 	return err;
 }
 
@@ -1930,46 +2178,21 @@ static int idpf_send_ena_dis_queues_msg(struct idpf_vport *vport, u32 vc_op)
  */
 int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 {
-	struct idpf_adapter *adapter = vport->adapter;
-	struct virtchnl2_queue_vector_maps *vqvm;
-	struct virtchnl2_queue_vector *vqv;
-	u32 config_sz, chunk_sz, buf_sz;
-	u32 num_msgs, num_chunks, num_q;
-	int i, j, k = 0, err = 0;
+	struct idpf_queue **qs;
+	int num_q, err = 0;
+	int i, j, k = 0;
 
 	num_q = vport->num_txq + vport->num_rxq;
 
-	buf_sz = sizeof(struct virtchnl2_queue_vector) * num_q;
-	vqv = kzalloc(buf_sz, GFP_KERNEL);
-	if (!vqv)
+	qs = (struct idpf_queue **)kzalloc(num_q * sizeof(*qs), GFP_KERNEL);
+	if (!qs)
 		return -ENOMEM;
 
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
-		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
-			const struct idpf_q_vector *vec;
-			u32 v_idx, tx_itr_idx;
-
-			vqv[k].queue_type = cpu_to_le32(tx_qgrp->txqs[j]->q_type);
-			vqv[k].queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
-
-			if (idpf_is_queue_model_split(vport->txq_model))
-				vec = tx_qgrp->complq->q_vector;
-			else
-				vec = tx_qgrp->txqs[j]->q_vector;
-
-			if (vec) {
-				v_idx = vec->v_idx;
-				tx_itr_idx = vec->tx_itr_idx;
-			} else {
-				v_idx = 0;
-				tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
-			}
-
-			vqv[k].vector_id = cpu_to_le16(v_idx);
-			vqv[k].itr_idx = cpu_to_le32(tx_itr_idx);
-		}
+		for (j = 0; j < tx_qgrp->num_txq; j++, k++)
+			qs[k] = tx_qgrp->txqs[j];
 	}
 
 	if (vport->num_txq != k) {
@@ -1979,7 +2202,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 
 	for (i = 0; i < vport->num_rxq_grp; i++) {
 		struct idpf_rxq_group *rx_qgrp = &vport->rxq_grps[i];
-		u16 num_rxq;
+		int num_rxq;
 
 		if (idpf_is_queue_model_split(vport->rxq_model))
 			num_rxq = rx_qgrp->splitq.num_rxq_sets;
@@ -1994,10 +2217,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 			else
 				rxq = rx_qgrp->singleq.rxqs[j];
 
-			vqv[k].queue_type = cpu_to_le32(rxq->q_type);
-			vqv[k].queue_id = cpu_to_le32(rxq->q_id);
-			vqv[k].vector_id = cpu_to_le16(rxq->q_vector->v_idx);
-			vqv[k].itr_idx = cpu_to_le32(rxq->q_vector->rx_itr_idx);
+			qs[k] = rxq;
 		}
 	}
 
@@ -2013,63 +2233,9 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		}
 	}
 
-	/* Chunk up the vector info into multiple messages */
-	config_sz = sizeof(struct virtchnl2_queue_vector_maps);
-	chunk_sz = sizeof(struct virtchnl2_queue_vector);
-
-	num_chunks = min_t(u32, IDPF_NUM_CHUNKS_PER_MSG(config_sz, chunk_sz),
-			   num_q);
-	num_msgs = DIV_ROUND_UP(num_q, num_chunks);
-
-	buf_sz = struct_size(vqvm, qv_maps, num_chunks);
-	vqvm = kzalloc(buf_sz, GFP_KERNEL);
-	if (!vqvm) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	mutex_lock(&vport->vc_buf_lock);
-
-	for (i = 0, k = 0; i < num_msgs; i++) {
-		memset(vqvm, 0, buf_sz);
-		vqvm->vport_id = cpu_to_le32(vport->vport_id);
-		vqvm->num_qv_maps = cpu_to_le16(num_chunks);
-		memcpy(vqvm->qv_maps, &vqv[k], chunk_sz * num_chunks);
-
-		if (map) {
-			err = idpf_send_mb_msg(adapter,
-					       VIRTCHNL2_OP_MAP_QUEUE_VECTOR,
-					       buf_sz, (u8 *)vqvm);
-			if (!err)
-				err = idpf_wait_for_event(adapter, vport,
-							  IDPF_VC_MAP_IRQ,
-							  IDPF_VC_MAP_IRQ_ERR);
-		} else {
-			err = idpf_send_mb_msg(adapter,
-					       VIRTCHNL2_OP_UNMAP_QUEUE_VECTOR,
-					       buf_sz, (u8 *)vqvm);
-			if (!err)
-				err =
-				idpf_min_wait_for_event(adapter, vport,
-							IDPF_VC_UNMAP_IRQ,
-							IDPF_VC_UNMAP_IRQ_ERR);
-		}
-		if (err)
-			goto mbx_error;
-
-		k += num_chunks;
-		num_q -= num_chunks;
-		num_chunks = min(num_chunks, num_q);
-		/* Recalculate buffer size */
-		buf_sz = struct_size(vqvm, qv_maps, num_chunks);
-	}
-
-mbx_error:
-	mutex_unlock(&vport->vc_buf_lock);
-	kfree(vqvm);
+	err = idpf_send_map_unmap_sel_queue_vector_msg(vport, qs, num_q, map);
 error:
-	kfree(vqv);
-
+	kfree(qs);
 	return err;
 }
 
@@ -2113,6 +2279,123 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 	return idpf_wait_for_marker_event(vport);
 }
 
+/**
+ * idpf_send_enable_selected_queues_msg - send enable queues virtchnl message
+ * for selected queues only
+ * @vport: Virtual port private data structure
+ * @qs: array containing queues to be enabled
+ * @num_q: number of queues in the 'qs' array
+ *
+ * Will send enable queues virtchnl message for queues contained in 'qs' table.
+ * Returns 0 on success, negative on failure.
+ */
+int idpf_send_enable_selected_queues_msg(struct idpf_vport *vport,
+					 struct idpf_queue **qs,
+					 int num_q)
+{
+	return idpf_send_ena_dis_selected_qs_msg(vport, qs, num_q,
+						 VIRTCHNL2_OP_ENABLE_QUEUES);
+}
+
+/**
+ * idpf_send_disable_selected_queues_msg - send disable queues virtchnl message
+ * for selected queues only
+ * @vport: Virtual port private data structure
+ * @qs: array containing queues to be disabled
+ * @num_q: number of queues in the 'qs' array
+ *
+ * Will send disable queues virtchnl message for queues contained in 'qs' table.
+ * Returns 0 on success, negative on failure.
+ */
+int idpf_send_disable_selected_queues_msg(struct idpf_vport *vport,
+					  struct idpf_queue **qs,
+					  int num_q)
+{
+	struct idpf_queue **tx_qs;
+	int err, i, tx_idx = 0;
+
+	err = idpf_send_ena_dis_selected_qs_msg(vport, qs, num_q,
+						VIRTCHNL2_OP_DISABLE_QUEUES);
+	if (err)
+		return err;
+
+	tx_qs = (struct idpf_queue **)kzalloc(num_q * sizeof(*qs), GFP_KERNEL);
+	if (!tx_qs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_q; i++) {
+		if (qs[i]->q_type == VIRTCHNL2_QUEUE_TYPE_TX) {
+			set_bit(__IDPF_Q_POLL_MODE, qs[i]->flags);
+			tx_qs[tx_idx++] = qs[i];
+		}
+
+		if (qs[i]->q_type == VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION)
+			napi_schedule(&qs[i]->q_vector->napi);
+	}
+
+	err = idpf_wait_for_selected_marker_events(vport, tx_qs, tx_idx);
+
+	kfree(tx_qs);
+	return err;
+}
+
+/**
+ * idpf_send_config_selected_queues_msg - Send virtchnl config queues message
+ * for selected queues only.
+ * @vport: virtual port data structure
+ * @qs: array of queues to be configured
+ * @num_q: number of queues contained in 'qs' array
+ *
+ * Send config queues virtchnl message for queues contained in 'qs' array.
+ * The 'qs' array can contain both RX or TX queues.
+ * Returns 0 on success, negative on failure.
+ */
+int idpf_send_config_selected_queues_msg(struct idpf_vport *vport,
+					 struct idpf_queue **qs,
+					 int num_q)
+{
+	int num_rxq = 0, num_txq = 0, i, err;
+	struct idpf_queue **txqs, **rxqs;
+
+	txqs = (struct idpf_queue **)kzalloc(num_q * sizeof(*qs), GFP_KERNEL);
+	if (!txqs)
+		return -ENOMEM;
+
+	rxqs = (struct idpf_queue **)kzalloc(num_q * sizeof(*qs), GFP_KERNEL);
+	if (!rxqs) {
+		err = -ENOMEM;
+		goto rxq_alloc_err;
+	}
+
+	for (i = 0; i < num_q; i++) {
+		struct idpf_queue *q = qs[i];
+
+		if (q->q_type == VIRTCHNL2_QUEUE_TYPE_TX ||
+		    q->q_type == VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION) {
+			txqs[num_txq] = q;
+			num_txq++;
+		}
+		else if (q->q_type == VIRTCHNL2_QUEUE_TYPE_RX ||
+			 q->q_type == VIRTCHNL2_QUEUE_TYPE_RX_BUFFER) {
+			rxqs[num_rxq] = q;
+			num_rxq++;
+		}
+	}
+
+	err = idpf_send_config_selected_tx_queues_msg(vport, txqs, num_txq);
+	if (err)
+		goto send_txq_err;
+
+	err = idpf_send_config_selected_rx_queues_msg(vport, rxqs, num_rxq);
+
+send_txq_err:
+	kfree(rxqs);
+rxq_alloc_err:
+	kfree(txqs);
+
+	return err;
+}
+
 /**
  * idpf_convert_reg_to_queue_chunks - Copy queue chunk information to the right
  * structure
-- 
2.43.0


