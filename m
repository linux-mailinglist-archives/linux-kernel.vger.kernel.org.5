Return-Path: <linux-kernel+bounces-10236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A9581D1A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C721C22373
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430423172D;
	Sat, 23 Dec 2023 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0BxMYx9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018D2F508;
	Sat, 23 Dec 2023 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703300361; x=1734836361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bOZfZie5hng33Moek6x3lg0RS/bldLmOI4f+Of4coI=;
  b=G0BxMYx9gO1Ay9gxfHySlYiBUH1wNqtgzTWs47uCzw9p+4L4kNhzz+o3
   ayWJ7xjtSL7YOoVRyuvjnoUOOmnhco9yxqrdsYpBTUAITb2LAxaz43DWF
   OYymyifYfJ29wpgW9iGJ1uWJcDWj86JIxghRYtCKEkLcb/WauZCfLoHJk
   c9zCXfZ3hn+Ho5Wx5IHpomsxk0EZ+fhYs2iusPlcLi42BZCinOUM9GxQ5
   pHayul3PuuO4s6PM/+NnCu6cNcl0wRqYTuczbOx8iJF07XTkX5+JjkAKe
   I0/PsOsxCL//3bqPcn4Ht/dSgeQMB1ATdy6C7eFaEwL2ipve2LAYBf3kU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610986"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="386610986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 18:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="25537570"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:59:18 -0800
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
Subject: [PATCH RFC net-next 20/34] idpf: make complq cleaning dependent on scheduling mode
Date: Sat, 23 Dec 2023 03:55:40 +0100
Message-ID: <20231223025554.2316836-21-aleksander.lobakin@intel.com>
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

Extend completion queue cleaning function to support queue-based
scheduling mode needed for XDP queues.
Add 4-byte descriptor for queue-based scheduling mode and
perform some refactoring to extract the common code for
both scheduling modes.
Make the completion desc parsing function a static inline, as
we'll need it in a different file soon.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 203 ++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  44 ++++
 3 files changed, 166 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
index a5752dcab888..7f8fc9b61e90 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
@@ -184,13 +184,17 @@ struct idpf_base_tx_desc {
 	__le64 qw1; /* type_cmd_offset_bsz_l2tag1 */
 }; /* read used with buffer queues */
 
-struct idpf_splitq_tx_compl_desc {
+struct idpf_splitq_4b_tx_compl_desc {
 	/* qid=[10:0] comptype=[13:11] rsvd=[14] gen=[15] */
 	__le16 qid_comptype_gen;
 	union {
 		__le16 q_head; /* Queue head */
 		__le16 compl_tag; /* Completion tag */
 	} q_head_compl_tag;
+}; /* writeback used with completion queues */
+
+struct idpf_splitq_tx_compl_desc {
+	struct idpf_splitq_4b_tx_compl_desc common;
 	u8 ts[3];
 	u8 rsvd; /* Reserved */
 }; /* writeback used with completion queues */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 40b8d8b17827..1a79ec1fb838 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1722,8 +1722,8 @@ static bool idpf_tx_clean_buf_ring(struct idpf_queue *txq, u16 compl_tag,
 }
 
 /**
- * idpf_tx_handle_rs_completion - clean a single packet and all of its buffers
- * whether on the buffer ring or in the hash table
+ * idpf_tx_handle_rs_cmpl_qb - clean a single packet and all of its buffers
+ * whether the Tx queue is working in queue-based scheduling
  * @txq: Tx ring to clean
  * @desc: pointer to completion queue descriptor to extract completion
  * information from
@@ -1732,20 +1732,33 @@ static bool idpf_tx_clean_buf_ring(struct idpf_queue *txq, u16 compl_tag,
  *
  * Returns bytes/packets cleaned
  */
-static void idpf_tx_handle_rs_completion(struct idpf_queue *txq,
-					 struct idpf_splitq_tx_compl_desc *desc,
-					 struct idpf_cleaned_stats *cleaned,
-					 int budget)
+static void
+idpf_tx_handle_rs_cmpl_qb(struct idpf_queue *txq,
+			  const struct idpf_splitq_4b_tx_compl_desc *desc,
+			  struct idpf_cleaned_stats *cleaned, int budget)
 {
-	u16 compl_tag;
+	u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
 
-	if (!test_bit(__IDPF_Q_FLOW_SCH_EN, txq->flags)) {
-		u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
-
-		return idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
-	}
+	return idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
+}
 
-	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
+/**
+ * idpf_tx_handle_rs_cmpl_fb - clean a single packet and all of its buffers
+ * whether on the buffer ring or in the hash table (flow-based scheduling only)
+ * @txq: Tx ring to clean
+ * @desc: pointer to completion queue descriptor to extract completion
+ * information from
+ * @cleaned: pointer to stats struct to track cleaned packets/bytes
+ * @budget: Used to determine if we are in netpoll
+ *
+ * Returns bytes/packets cleaned
+ */
+static void
+idpf_tx_handle_rs_cmpl_fb(struct idpf_queue *txq,
+			  const struct idpf_splitq_4b_tx_compl_desc *desc,
+			  struct idpf_cleaned_stats *cleaned,int budget)
+{
+	u16 compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
 
 	/* If we didn't clean anything on the ring, this packet must be
 	 * in the hash table. Go clean it there.
@@ -1754,6 +1767,65 @@ static void idpf_tx_handle_rs_completion(struct idpf_queue *txq,
 		idpf_tx_clean_stashed_bufs(txq, compl_tag, cleaned, budget);
 }
 
+/**
+ * idpf_tx_finalize_complq - Finalize completion queue cleaning
+ * @complq: completion queue to finalize
+ * @ntc: next to complete index
+ * @gen_flag: current state of generation flag
+ * @cleaned: returns number of packets cleaned
+ */
+static void idpf_tx_finalize_complq(struct idpf_queue *complq, int ntc,
+				    bool gen_flag, int *cleaned)
+{
+	struct idpf_netdev_priv *np;
+	bool complq_ok = true;
+	int i;
+
+	/* Store the state of the complq to be used later in deciding if a
+	 * TXQ can be started again
+	 */
+	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
+		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
+		complq_ok = false;
+
+	np = netdev_priv(complq->vport->netdev);
+	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
+		struct idpf_queue *tx_q = complq->txq_grp->txqs[i];
+		struct netdev_queue *nq;
+		bool dont_wake;
+
+		/* We didn't clean anything on this queue, move along */
+		if (!tx_q->cleaned_bytes)
+			continue;
+
+		*cleaned += tx_q->cleaned_pkts;
+
+		/* Update BQL */
+		nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
+
+		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
+			    np->state != __IDPF_VPORT_UP ||
+			    !netif_carrier_ok(tx_q->vport->netdev);
+		/* Check if the TXQ needs to and can be restarted */
+		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
+					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
+					   dont_wake);
+
+		/* Reset cleaned stats for the next time this queue is
+		 * cleaned
+		 */
+		tx_q->cleaned_bytes = 0;
+		tx_q->cleaned_pkts = 0;
+	}
+
+	ntc += complq->desc_count;
+	complq->next_to_clean = ntc;
+	if (gen_flag)
+		set_bit(__IDPF_Q_GEN_CHK, complq->flags);
+	else
+		clear_bit(__IDPF_Q_GEN_CHK, complq->flags);
+}
+
 /**
  * idpf_tx_clean_complq - Reclaim resources on completion queue
  * @complq: Tx ring to clean
@@ -1765,61 +1837,55 @@ static void idpf_tx_handle_rs_completion(struct idpf_queue *txq,
 static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 				 int *cleaned)
 {
-	struct idpf_splitq_tx_compl_desc *tx_desc;
+	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
 	struct idpf_vport *vport = complq->vport;
 	s16 ntc = complq->next_to_clean;
-	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
-	bool complq_ok = true;
-	int i;
+	bool flow, gen_flag;
+	u32 pos = ntc;
+
+	flow = test_bit(__IDPF_Q_FLOW_SCH_EN, complq->flags);
+	gen_flag = test_bit(__IDPF_Q_GEN_CHK, complq->flags);
 
 	complq_budget = vport->compln_clean_budget;
-	tx_desc = &complq->comp[ntc];
+	tx_desc = flow ? &complq->comp[pos].common : &complq->comp_4b[pos];
 	ntc -= complq->desc_count;
 
 	do {
 		struct idpf_cleaned_stats cleaned_stats = { };
 		struct idpf_queue *tx_q;
-		int rel_tx_qid;
 		u16 hw_head;
-		u8 ctype;	/* completion type */
-		u16 gen;
-
-		/* if the descriptor isn't done, no work yet to do */
-		gen = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-		      IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
-		if (test_bit(__IDPF_Q_GEN_CHK, complq->flags) != gen)
-			break;
-
-		/* Find necessary info of TX queue to clean buffers */
-		rel_tx_qid = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			 IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
-		if (rel_tx_qid >= complq->txq_grp->num_txq ||
-		    !complq->txq_grp->txqs[rel_tx_qid]) {
-			dev_err(&complq->vport->adapter->pdev->dev,
-				"TxQ not found\n");
-			goto fetch_next_desc;
-		}
-		tx_q = complq->txq_grp->txqs[rel_tx_qid];
+		int ctype;
 
-		/* Determine completion type */
-		ctype = (le16_to_cpu(tx_desc->qid_comptype_gen) &
-			IDPF_TXD_COMPLQ_COMPL_TYPE_M) >>
-			IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+		ctype = idpf_parse_compl_desc(tx_desc, complq, &tx_q,
+					      gen_flag);
 		switch (ctype) {
 		case IDPF_TXD_COMPLT_RE:
+			if (unlikely(!flow))
+				goto fetch_next_desc;
+
 			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
 
 			idpf_tx_splitq_clean(tx_q, hw_head, budget,
 					     &cleaned_stats, true);
 			break;
 		case IDPF_TXD_COMPLT_RS:
-			idpf_tx_handle_rs_completion(tx_q, tx_desc,
-						     &cleaned_stats, budget);
+			if (flow)
+				idpf_tx_handle_rs_cmpl_fb(tx_q, tx_desc,
+							  &cleaned_stats,
+							  budget);
+			else
+				idpf_tx_handle_rs_cmpl_qb(tx_q, tx_desc,
+							  &cleaned_stats,
+							  budget);
 			break;
 		case IDPF_TXD_COMPLT_SW_MARKER:
 			idpf_tx_handle_sw_marker(tx_q);
 			break;
+		case -ENODATA:
+			goto exit_clean_complq;
+		case -EINVAL:
+			goto fetch_next_desc;
 		default:
 			dev_err(&tx_q->vport->adapter->pdev->dev,
 				"Unknown TX completion type: %d\n",
@@ -1836,59 +1902,24 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		u64_stats_update_end(&tx_q->stats_sync);
 
 fetch_next_desc:
-		tx_desc++;
+		pos++;
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = &complq->comp[0];
-			change_bit(__IDPF_Q_GEN_CHK, complq->flags);
+			pos = 0;
+			gen_flag = !gen_flag;
 		}
 
+		tx_desc = flow ? &complq->comp[pos].common :
+			  &complq->comp_4b[pos];
 		prefetch(tx_desc);
 
 		/* update budget accounting */
 		complq_budget--;
 	} while (likely(complq_budget));
 
-	/* Store the state of the complq to be used later in deciding if a
-	 * TXQ can be started again
-	 */
-	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
-		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
-		complq_ok = false;
-
-	np = netdev_priv(complq->vport->netdev);
-	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
-		struct idpf_queue *tx_q = complq->txq_grp->txqs[i];
-		struct netdev_queue *nq;
-		bool dont_wake;
-
-		/* We didn't clean anything on this queue, move along */
-		if (!tx_q->cleaned_bytes)
-			continue;
-
-		*cleaned += tx_q->cleaned_pkts;
-
-		/* Update BQL */
-		nq = netdev_get_tx_queue(tx_q->vport->netdev, tx_q->idx);
-
-		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
-			    np->state != __IDPF_VPORT_UP ||
-			    !netif_carrier_ok(tx_q->vport->netdev);
-		/* Check if the TXQ needs to and can be restarted */
-		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
-					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
-					   dont_wake);
-
-		/* Reset cleaned stats for the next time this queue is
-		 * cleaned
-		 */
-		tx_q->cleaned_bytes = 0;
-		tx_q->cleaned_pkts = 0;
-	}
-
-	ntc += complq->desc_count;
-	complq->next_to_clean = ntc;
+exit_clean_complq:
+	idpf_tx_finalize_complq(complq, ntc, gen_flag, cleaned);
 
 	return !!complq_budget;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 2584bd94363f..3e15ed779860 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -577,6 +577,7 @@ struct idpf_queue {
 		struct idpf_flex_tx_ctx_desc *flex_ctx;
 
 		struct idpf_splitq_tx_compl_desc *comp;
+		struct idpf_splitq_4b_tx_compl_desc *comp_4b;
 
 		void *desc_ring;
 	};
@@ -821,6 +822,49 @@ static inline void idpf_tx_splitq_build_desc(union idpf_tx_flex_desc *desc,
 		idpf_tx_splitq_build_flow_desc(desc, params, td_cmd, size);
 }
 
+/**
+ * idpf_parse_compl_desc - Parse the completion descriptor
+ * @desc: completion descriptor to be parsed
+ * @complq: completion queue containing the descriptor
+ * @txq: returns corresponding Tx queue for a given descriptor
+ * @gen_flag: current generation flag in the completion queue
+ *
+ * Returns completion type from descriptor or negative value in case of error:
+ * 	-ENODATA if there is no completion descriptor to be cleaned
+ * 	-EINVAL  if no Tx queue has been found for the completion queue
+ */
+static inline int
+idpf_parse_compl_desc(struct idpf_splitq_4b_tx_compl_desc *desc,
+		      struct idpf_queue *complq, struct idpf_queue **txq,
+		      bool gen_flag)
+{
+	int rel_tx_qid;
+	u8 ctype;	/* completion type */
+	u16 gen;
+
+	/* if the descriptor isn't done, no work yet to do */
+	gen = (le16_to_cpu(desc->qid_comptype_gen) &
+	      IDPF_TXD_COMPLQ_GEN_M) >> IDPF_TXD_COMPLQ_GEN_S;
+	if (gen_flag != gen)
+		return -ENODATA;
+
+	/* Find necessary info of TX queue to clean buffers */
+	rel_tx_qid = (le16_to_cpu(desc->qid_comptype_gen) &
+		 IDPF_TXD_COMPLQ_QID_M) >> IDPF_TXD_COMPLQ_QID_S;
+	if (rel_tx_qid >= complq->txq_grp->num_txq ||
+	    !complq->txq_grp->txqs[rel_tx_qid])
+		return -EINVAL;
+
+	*txq = complq->txq_grp->txqs[rel_tx_qid];
+
+	/* Determine completion type */
+	ctype = (le16_to_cpu(desc->qid_comptype_gen) &
+		IDPF_TXD_COMPLQ_COMPL_TYPE_M) >>
+		IDPF_TXD_COMPLQ_COMPL_TYPE_S;
+
+	return ctype;
+}
+
 /**
  * idpf_vport_intr_set_wb_on_itr - enable descriptor writeback on disabled interrupts
  * @q_vector: pointer to queue vector struct
-- 
2.43.0


