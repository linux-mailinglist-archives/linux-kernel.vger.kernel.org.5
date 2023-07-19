Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2382D7593CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGSLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGSLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:05:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C8186;
        Wed, 19 Jul 2023 04:05:42 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J9jrtu013032;
        Wed, 19 Jul 2023 04:05:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=nL8fpG9iocxNyRSI2y8KFYKeGEYWNd9e7mV45V49b7w=;
 b=erGqh7osu8HYZnMue4BYMOxGGIRsN9HweHZ5xqO2ef9zKuX+XLrSaJDP3jtqo44+KKX8
 +du/j57OEc0CFJMa9uH1RWkasx2jcPDFtw7t9V/SuJKYTcPhQAFDFg8rxxgEr+gEo6S/
 /2AydK/1ADFzJX6QceGbfUbNiXy4yf/5NzzcYtuznGzaY50lykVKcTM3HP6REfQ58JWh
 KrzsqQUARncZE73cd9hdwFiGY3xGJTErkoOveMoHG6SYPJN0kpvUAjkqrtC8yN+rgggN
 ypsV2gCnuKfJM/qZrdLT/M2fyJloAHGPETsE9ZMGp2NJPMHEg6Mg3i38aY649dJNpdMk eg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rwyc6jdya-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 04:05:29 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 04:05:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 19 Jul 2023 04:05:09 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 55AF93F7053;
        Wed, 19 Jul 2023 04:05:04 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>,
        <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <naveenm@marvell.com>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <maxtram95@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: [net-next PatchV4 3/4] octeontx2-pf: htb offload support for Round Robin scheduling
Date:   Wed, 19 Jul 2023 16:34:42 +0530
Message-ID: <20230719110443.15310-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719110443.15310-1-hkelam@marvell.com>
References: <20230719110443.15310-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: kYMaGcWDUxHgcFeTtuPI5lWtpg06s8TX
X-Proofpoint-ORIG-GUID: kYMaGcWDUxHgcFeTtuPI5lWtpg06s8TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_06,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Mamindlapalli <naveenm@marvell.com>

When multiple traffic flows reach Transmit level with the same
priority, with Round robin scheduling traffic flow with the highest
quantum value is picked. With this support, the user can add multiple
classes with the same priority and different quantum. This patch
does necessary changes to support the same.

Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../marvell/octeontx2/nic/otx2_common.h       |   1 +
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 280 +++++++++++++++---
 .../net/ethernet/marvell/octeontx2/nic/qos.h  |   5 +-
 4 files changed, 247 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..8cdd92dd9762 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -774,6 +774,7 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 				rsp->schq_list[lvl][schq];
 
 	pfvf->hw.txschq_link_cfg_lvl = rsp->link_cfg_lvl;
+	pfvf->hw.txschq_aggr_lvl_rr_prio = rsp->aggr_lvl_rr_prio;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ba8091131ec0..37d792f18809 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -224,6 +224,7 @@ struct otx2_hw {
 
 	/* NIX */
 	u8			txschq_link_cfg_lvl;
+	u8			txschq_aggr_lvl_rr_prio;
 	u16			txschq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16			matchall_ipolicer;
 	u32			dwrr_mtu;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 919cd01b7f02..1e77bbf5d22a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -20,6 +20,8 @@
 #define OTX2_QOS_DEFAULT_PRIO		0xF
 #define OTX2_QOS_INVALID_SQ		0xFFFF
 #define OTX2_QOS_INVALID_TXSCHQ_IDX	0xFFFF
+#define CN10K_MAX_RR_WEIGHT		GENMASK_ULL(13, 0)
+#define OTX2_MAX_RR_QUANTUM		GENMASK_ULL(23, 0)
 
 static void otx2_qos_update_tx_netdev_queues(struct otx2_nic *pfvf)
 {
@@ -66,11 +68,24 @@ static void otx2_qos_get_regaddr(struct otx2_qos_node *node,
 	}
 }
 
+static int otx2_qos_quantum_to_dwrr_weight(struct otx2_nic *pfvf, u32 quantum)
+{
+	u32 weight;
+
+	weight = quantum / pfvf->hw.dwrr_mtu;
+	if (quantum % pfvf->hw.dwrr_mtu)
+		weight += 1;
+
+	return weight;
+}
+
 static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
 				      struct otx2_qos_node *node,
 				      struct nix_txschq_config *cfg,
 				      int *num_regs)
 {
+	u32 rr_weight;
+	u32 quantum;
 	u64 maxrate;
 
 	otx2_qos_get_regaddr(node, cfg, *num_regs);
@@ -87,8 +102,17 @@ static void otx2_config_sched_shaping(struct otx2_nic *pfvf,
 		return;
 	}
 
-	/* configure priority  */
-	cfg->regval[*num_regs] = (node->schq - node->parent->prio_anchor) << 24;
+	/* configure priority/quantum  */
+	if (node->is_static) {
+		cfg->regval[*num_regs] =
+			(node->schq - node->parent->prio_anchor) << 24;
+	} else {
+		quantum = node->quantum ?
+			  node->quantum : pfvf->tx_max_pktlen;
+		rr_weight = otx2_qos_quantum_to_dwrr_weight(pfvf, quantum);
+		cfg->regval[*num_regs] = node->parent->child_dwrr_prio << 24 |
+					 rr_weight;
+	}
 	(*num_regs)++;
 
 	/* configure PIR */
@@ -196,9 +220,8 @@ static int otx2_qos_txschq_set_parent_topology(struct otx2_nic *pfvf,
 		cfg->reg[0] = NIX_AF_TL1X_TOPOLOGY(parent->schq);
 
 	cfg->regval[0] = (u64)parent->prio_anchor << 32;
-	if (parent->level == NIX_TXSCH_LVL_TL1)
-		cfg->regval[0] |= (u64)TXSCH_TL1_DFLT_RR_PRIO << 1;
-
+	cfg->regval[0] |= ((parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO) ?
+			    parent->child_dwrr_prio : 0)  << 1;
 	cfg->num_regs++;
 
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
@@ -384,10 +407,12 @@ otx2_qos_alloc_root(struct otx2_nic *pfvf)
 		return ERR_PTR(-ENOMEM);
 
 	node->parent = NULL;
-	if (!is_otx2_vf(pfvf->pcifunc))
+	if (!is_otx2_vf(pfvf->pcifunc)) {
 		node->level = NIX_TXSCH_LVL_TL1;
-	else
+	} else {
 		node->level = NIX_TXSCH_LVL_TL2;
+		node->child_dwrr_prio = OTX2_QOS_DEFAULT_PRIO;
+	}
 
 	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
 	node->classid = OTX2_QOS_ROOT_CLASSID;
@@ -444,6 +469,10 @@ static int otx2_qos_alloc_txschq_node(struct otx2_nic *pfvf,
 		txschq_node->rate = 0;
 		txschq_node->ceil = 0;
 		txschq_node->prio = 0;
+		txschq_node->quantum = 0;
+		txschq_node->is_static = true;
+		txschq_node->child_dwrr_prio = OTX2_QOS_DEFAULT_PRIO;
+		txschq_node->txschq_idx = OTX2_QOS_INVALID_TXSCHQ_IDX;
 
 		mutex_lock(&pfvf->qos.qos_lock);
 		list_add_tail(&txschq_node->list, &node->child_schq_list);
@@ -469,7 +498,7 @@ static struct otx2_qos_node *
 otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 			     struct otx2_qos_node *parent,
 			     u16 classid, u32 prio, u64 rate, u64 ceil,
-			     u16 qid)
+			     u32 quantum, u16 qid, bool static_cfg)
 {
 	struct otx2_qos_node *node;
 	int err;
@@ -486,7 +515,10 @@ otx2_qos_sw_create_leaf_node(struct otx2_nic *pfvf,
 	node->rate = otx2_convert_rate(rate);
 	node->ceil = otx2_convert_rate(ceil);
 	node->prio = prio;
-	node->is_static = true;
+	node->quantum = quantum;
+	node->is_static = static_cfg;
+	node->child_dwrr_prio = OTX2_QOS_DEFAULT_PRIO;
+	node->txschq_idx = OTX2_QOS_INVALID_TXSCHQ_IDX;
 
 	__set_bit(qid, pfvf->qos.qos_sq_bmap);
 
@@ -633,6 +665,7 @@ static int otx2_qos_txschq_alloc(struct otx2_nic *pfvf,
 	}
 
 	pfvf->qos.link_cfg_lvl = rsp->link_cfg_lvl;
+	pfvf->hw.txschq_aggr_lvl_rr_prio = rsp->aggr_lvl_rr_prio;
 
 out:
 	mutex_unlock(&mbox->lock);
@@ -1006,6 +1039,13 @@ static int otx2_qos_root_add(struct otx2_nic *pfvf, u16 htb_maj_id, u16 htb_defc
 		goto free_root_node;
 	}
 
+	/* Update TL1 RR PRIO */
+	if (root->level == NIX_TXSCH_LVL_TL1) {
+		root->child_dwrr_prio = pfvf->hw.txschq_aggr_lvl_rr_prio;
+		netdev_dbg(pfvf->netdev,
+			   "TL1 DWRR Priority %d\n", root->child_dwrr_prio);
+	}
+
 	if (!(pfvf->netdev->flags & IFF_UP) ||
 	    root->level == NIX_TXSCH_LVL_TL1) {
 		root->schq = new_cfg->schq_list[root->level][0];
@@ -1052,37 +1092,126 @@ static int otx2_qos_root_destroy(struct otx2_nic *pfvf)
 	return 0;
 }
 
+static int otx2_qos_validate_quantum(struct otx2_nic *pfvf, u32 quantum)
+{
+	u32 rr_weight = otx2_qos_quantum_to_dwrr_weight(pfvf, quantum);
+	int err = 0;
+
+	/* Max Round robin weight supported by octeontx2 and CN10K
+	 * is different. Validate accordingly
+	 */
+	if (is_dev_otx2(pfvf->pdev))
+		err = (rr_weight > OTX2_MAX_RR_QUANTUM) ? -EINVAL : 0;
+	else if	(rr_weight > CN10K_MAX_RR_WEIGHT)
+		err = -EINVAL;
+
+	return err;
+}
+
+static int otx2_qos_validate_dwrr_cfg(struct otx2_qos_node *parent,
+				      struct netlink_ext_ack *extack,
+				      struct otx2_nic *pfvf,
+				      u64 prio, u64 quantum)
+{
+	int err;
+
+	err = otx2_qos_validate_quantum(pfvf, quantum);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported quantum value");
+		return err;
+	}
+
+	if (parent->child_dwrr_prio == OTX2_QOS_DEFAULT_PRIO) {
+		parent->child_dwrr_prio = prio;
+	} else if (prio != parent->child_dwrr_prio) {
+		NL_SET_ERR_MSG_MOD(extack, "Only one DWRR group is allowed");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int otx2_qos_validate_configuration(struct otx2_qos_node *parent,
 					   struct netlink_ext_ack *extack,
 					   struct otx2_nic *pfvf,
-					   u64 prio)
+					   u64 prio, bool static_cfg)
 {
-	if (test_bit(prio, parent->prio_bmap)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Static priority child with same priority exists");
+	if (prio == parent->child_dwrr_prio && static_cfg) {
+		NL_SET_ERR_MSG_MOD(extack, "DWRR child group with same priority exists");
 		return -EEXIST;
 	}
 
-	if (prio == TXSCH_TL1_DFLT_RR_PRIO) {
+	if (static_cfg && test_bit(prio, parent->prio_bmap)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Priority is reserved for Round Robin");
-		return -EINVAL;
+				   "Static priority child with same priority exists");
+		return -EEXIST;
 	}
 
 	return 0;
 }
 
+static void otx2_reset_dwrr_prio(struct otx2_qos_node *parent, u64 prio)
+{
+	/* For PF, root node dwrr priority is static */
+	if (parent->level == NIX_TXSCH_LVL_TL1)
+		return;
+
+	if (parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO) {
+		parent->child_dwrr_prio = OTX2_QOS_DEFAULT_PRIO;
+		clear_bit(prio, parent->prio_bmap);
+	}
+}
+
+static bool is_qos_node_dwrr(struct otx2_qos_node *parent,
+			     struct otx2_nic *pfvf,
+			     u64 prio)
+{
+	struct otx2_qos_node *node;
+	bool ret = false;
+
+	if (parent->child_dwrr_prio == prio)
+		return true;
+
+	mutex_lock(&pfvf->qos.qos_lock);
+	list_for_each_entry(node, &parent->child_list, list) {
+		if (prio == node->prio) {
+			if (parent->child_dwrr_prio != OTX2_QOS_DEFAULT_PRIO &&
+			    parent->child_dwrr_prio != prio)
+				continue;
+
+			if (otx2_qos_validate_quantum(pfvf, node->quantum)) {
+				netdev_err(pfvf->netdev,
+					   "Unsupported quantum value for existing classid=0x%x quantum=%d prio=%d",
+					    node->classid, node->quantum,
+					    node->prio);
+				break;
+			}
+			/* mark old node as dwrr */
+			node->is_static = false;
+			parent->child_dwrr_cnt++;
+			parent->child_static_cnt--;
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&pfvf->qos.qos_lock);
+
+	return ret;
+}
+
 static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 				     u32 parent_classid, u64 rate, u64 ceil,
-				     u64 prio, struct netlink_ext_ack *extack)
+				     u64 prio, u32 quantum,
+				     struct netlink_ext_ack *extack)
 {
 	struct otx2_qos_cfg *old_cfg, *new_cfg;
 	struct otx2_qos_node *node, *parent;
 	int qid, ret, err;
+	bool static_cfg;
 
 	netdev_dbg(pfvf->netdev,
-		   "TC_HTB_LEAF_ALLOC_QUEUE: classid=0x%x parent_classid=0x%x rate=%lld ceil=%lld prio=%lld\n",
-		   classid, parent_classid, rate, ceil, prio);
+		   "TC_HTB_LEAF_ALLOC_QUEUE: classid=0x%x parent_classid=0x%x rate=%lld ceil=%lld prio=%lld quantum=%d\n",
+		   classid, parent_classid, rate, ceil, prio, quantum);
 
 	if (prio > OTX2_QOS_MAX_PRIO) {
 		NL_SET_ERR_MSG_MOD(extack, "Valid priority range 0 to 7");
@@ -1090,6 +1219,12 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 		goto out;
 	}
 
+	if (!quantum || quantum > INT_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid quantum, range 1 - 2147483647 bytes");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* get parent node */
 	parent = otx2_sw_node_find(pfvf, parent_classid);
 	if (!parent) {
@@ -1103,11 +1238,24 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 		goto out;
 	}
 
-	ret = otx2_qos_validate_configuration(parent, extack, pfvf, prio);
+	static_cfg = !is_qos_node_dwrr(parent, pfvf, prio);
+	ret = otx2_qos_validate_configuration(parent, extack, pfvf, prio,
+					      static_cfg);
 	if (ret)
 		goto out;
 
-	parent->child_static_cnt++;
+	if (!static_cfg) {
+		ret = otx2_qos_validate_dwrr_cfg(parent, extack, pfvf, prio,
+						 quantum);
+		if (ret)
+			goto out;
+	}
+
+	if (static_cfg)
+		parent->child_static_cnt++;
+	else
+		parent->child_dwrr_cnt++;
+
 	set_bit(prio, parent->prio_bmap);
 
 	/* read current txschq configuration */
@@ -1132,7 +1280,7 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 
 	/* allocate and initialize a new child node */
 	node = otx2_qos_sw_create_leaf_node(pfvf, parent, classid, prio, rate,
-					    ceil, qid);
+					    ceil, quantum, qid, static_cfg);
 	if (IS_ERR(node)) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to allocate leaf node");
 		ret = PTR_ERR(node);
@@ -1180,7 +1328,11 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 free_old_cfg:
 	kfree(old_cfg);
 reset_prio:
-	parent->child_static_cnt--;
+	if (static_cfg)
+		parent->child_static_cnt--;
+	else
+		parent->child_dwrr_cnt--;
+
 	clear_bit(prio, parent->prio_bmap);
 out:
 	return ret;
@@ -1188,10 +1340,11 @@ static int otx2_qos_leaf_alloc_queue(struct otx2_nic *pfvf, u16 classid,
 
 static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 				  u16 child_classid, u64 rate, u64 ceil, u64 prio,
-				  struct netlink_ext_ack *extack)
+				  u32 quantum, struct netlink_ext_ack *extack)
 {
 	struct otx2_qos_cfg *old_cfg, *new_cfg;
 	struct otx2_qos_node *node, *child;
+	bool static_cfg;
 	int ret, err;
 	u16 qid;
 
@@ -1205,6 +1358,12 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 		goto out;
 	}
 
+	if (!quantum || quantum > INT_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid quantum, range 1 - 2147483647 bytes");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* find node related to classid */
 	node = otx2_sw_node_find(pfvf, classid);
 	if (!node) {
@@ -1219,7 +1378,19 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 		goto out;
 	}
 
-	node->child_static_cnt++;
+	static_cfg = !is_qos_node_dwrr(node, pfvf, prio);
+	if (!static_cfg) {
+		ret = otx2_qos_validate_dwrr_cfg(node, extack, pfvf, prio,
+						 quantum);
+		if (ret)
+			goto out;
+	}
+
+	if (static_cfg)
+		node->child_static_cnt++;
+	else
+		node->child_dwrr_cnt++;
+
 	set_bit(prio, node->prio_bmap);
 
 	/* store the qid to assign to leaf node */
@@ -1242,7 +1413,8 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 
 	/* allocate and initialize a new child node */
 	child = otx2_qos_sw_create_leaf_node(pfvf, node, child_classid,
-					     prio, rate, ceil, qid);
+					     prio, rate, ceil, quantum,
+					     qid, static_cfg);
 	if (IS_ERR(child)) {
 		NL_SET_ERR_MSG_MOD(extack, "Unable to allocate leaf node");
 		ret = PTR_ERR(child);
@@ -1293,7 +1465,10 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 free_old_cfg:
 	kfree(old_cfg);
 reset_prio:
-	node->child_static_cnt--;
+	if (static_cfg)
+		node->child_static_cnt--;
+	else
+		node->child_dwrr_cnt--;
 	clear_bit(prio, node->prio_bmap);
 out:
 	return ret;
@@ -1303,6 +1478,7 @@ static int otx2_qos_leaf_del(struct otx2_nic *pfvf, u16 *classid,
 			     struct netlink_ext_ack *extack)
 {
 	struct otx2_qos_node *node, *parent;
+	int dwrr_del_node = false;
 	u64 prio;
 	u16 qid;
 
@@ -1318,17 +1494,28 @@ static int otx2_qos_leaf_del(struct otx2_nic *pfvf, u16 *classid,
 	prio   = node->prio;
 	qid    = node->qid;
 
+	if (!node->is_static)
+		dwrr_del_node = true;
+
 	otx2_qos_disable_sq(pfvf, node->qid);
 
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
-	parent->child_static_cnt--;
+	if (dwrr_del_node) {
+		parent->child_dwrr_cnt--;
+	} else {
+		parent->child_static_cnt--;
+		clear_bit(prio, parent->prio_bmap);
+	}
+
+	/* Reset DWRR priority if all dwrr nodes are deleted */
+	if (!parent->child_dwrr_cnt)
+		otx2_reset_dwrr_prio(parent, prio);
+
 	if (!parent->child_static_cnt)
 		parent->max_static_prio = 0;
 
-	clear_bit(prio, parent->prio_bmap);
-
 	return 0;
 }
 
@@ -1337,6 +1524,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 {
 	struct otx2_qos_node *node, *parent;
 	struct otx2_qos_cfg *new_cfg;
+	int dwrr_del_node = false;
 	u64 prio;
 	int err;
 	u16 qid;
@@ -1361,16 +1549,27 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 		return -ENOENT;
 	}
 
+	if (!node->is_static)
+		dwrr_del_node = true;
+
 	/* destroy the leaf node */
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
-	parent->child_static_cnt--;
+	if (dwrr_del_node) {
+		parent->child_dwrr_cnt--;
+	} else {
+		parent->child_static_cnt--;
+		clear_bit(prio, parent->prio_bmap);
+	}
+
+	/* Reset DWRR priority if all dwrr nodes are deleted */
+	if (!parent->child_dwrr_cnt)
+		otx2_reset_dwrr_prio(parent, prio);
+
 	if (!parent->child_static_cnt)
 		parent->max_static_prio = 0;
 
-	clear_bit(prio, parent->prio_bmap);
-
 	/* create downstream txschq entries to parent */
 	err = otx2_qos_alloc_txschq_node(pfvf, parent);
 	if (err) {
@@ -1422,10 +1621,12 @@ void otx2_qos_config_txschq(struct otx2_nic *pfvf)
 	if (!root)
 		return;
 
-	err = otx2_qos_txschq_config(pfvf, root);
-	if (err) {
-		netdev_err(pfvf->netdev, "Error update txschq configuration\n");
-		goto root_destroy;
+	if (root->level != NIX_TXSCH_LVL_TL1) {
+		err = otx2_qos_txschq_config(pfvf, root);
+		if (err) {
+			netdev_err(pfvf->netdev, "Error update txschq configuration\n");
+			goto root_destroy;
+		}
 	}
 
 	err = otx2_qos_txschq_push_cfg_tl(pfvf, root, NULL);
@@ -1458,7 +1659,8 @@ int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb)
 		res = otx2_qos_leaf_alloc_queue(pfvf, htb->classid,
 						htb->parent_classid,
 						htb->rate, htb->ceil,
-						htb->prio, htb->extack);
+						htb->prio, htb->quantum,
+						htb->extack);
 		if (res < 0)
 			return res;
 		htb->qid = res;
@@ -1467,7 +1669,7 @@ int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb)
 		return otx2_qos_leaf_to_inner(pfvf, htb->parent_classid,
 					      htb->classid, htb->rate,
 					      htb->ceil, htb->prio,
-					      htb->extack);
+					      htb->quantum, htb->extack);
 	case TC_HTB_LEAF_DEL:
 		return otx2_qos_leaf_del(pfvf, &htb->classid, htb->extack);
 	case TC_HTB_LEAF_DEL_LAST:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
index faa7c24675d1..221bd0438f60 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.h
@@ -60,12 +60,15 @@ struct otx2_qos_node {
 	u64 ceil;
 	u32 classid;
 	u32 prio;
-	u16 schq; /* hw txschq */
+	u32 quantum;
+	/* hw txschq */
+	u16 schq;
 	u16 qid;
 	u16 prio_anchor;
 	u16 max_static_prio;
 	u16 child_dwrr_cnt;
 	u16 child_static_cnt;
+	u16 child_dwrr_prio;
 	u16 txschq_idx;			/* txschq allocation index */
 	u8 level;
 	bool is_static;
-- 
2.17.1

