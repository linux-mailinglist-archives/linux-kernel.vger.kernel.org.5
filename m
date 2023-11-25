Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62C7F8C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjKYQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKYQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:37:15 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19022102;
        Sat, 25 Nov 2023 08:37:21 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APGRR3u000576;
        Sat, 25 Nov 2023 08:37:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=7tmkG0aI1txbuxYrmeLbYXWmRe/JkhuRiN6AadLW224=;
 b=DBSkmMGtevQ+FNQibs9OKXGIjI8s4OxdeupuFYRCX4rtyYWmth5RR39bJ06VV0AwnTT9
 JIWRfPngYchi0NFonMVM/FoQanM0jprONNFNKlswgi1twILHArgqPbC2TYGsdMfbG3Ex
 CtZcJlRwu8duA4SBNtpFQmg3VgaPy2xdYAri388KdImpjVjttUHX45n/C4PfJWckgk/X
 3Ah4eZilKPvjXPvu5gfC/LHVrBNK+0jcX2Ys5GQQKTYAb3Zu4cDL5tSGGqoKIytVidSd
 E9fyCDJM/3eYs0QJ6dIfhSsp6+XNzXBB1/hDDaFio1I45+XAeJ9L2cLGX2pc/sE8SYof Fg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ukhaugab5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 08:37:14 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 25 Nov
 2023 08:37:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 25 Nov 2023 08:37:11 -0800
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
        by maili.marvell.com (Postfix) with ESMTP id C6D305C68EA;
        Sat, 25 Nov 2023 08:37:08 -0800 (PST)
From:   Subbaraya Sundeep <sbhatta@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH net] octeontx2-pf: Restore TC ingress police rules when interface is up
Date:   Sat, 25 Nov 2023 22:06:57 +0530
Message-ID: <1700930217-5707-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BP6lt8wtjnEZ4mbJTMgQmRttvLU0eWyx
X-Proofpoint-GUID: BP6lt8wtjnEZ4mbJTMgQmRttvLU0eWyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_16,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TC ingress policer rules depends on interface receive queue
contexts since the bandwidth profiles are attached to RQ
contexts. When an interface is brought down all the queue
contexts are freed. This in turn frees bandwidth profiles in
hardware causing ingress police rules non-functional after
the interface is brought up. Fix this by applying all the ingress
police rules config to hardware in otx2_open. Also allow
adding ingress rules only when interface is running
since no contexts exist for the interface when it is down.

Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 120 ++++++++++++++++-----
 4 files changed, 102 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a4a258d..c1c99d7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -450,6 +450,9 @@ int cn10k_set_ipolicer_rate(struct otx2_nic *pfvf, u16 profile,
 	aq->prof.pebs_mantissa = 0;
 	aq->prof_mask.pebs_mantissa = 0xFF;
 
+	aq->prof.hl_en = 0;
+	aq->prof_mask.hl_en = 1;
+
 	/* Fill AQ info */
 	aq->qidx = profile;
 	aq->ctype = NIX_AQ_CTYPE_BANDPROF;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e7c69b5..0691030 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1070,6 +1070,8 @@ int otx2_init_tc(struct otx2_nic *nic);
 void otx2_shutdown_tc(struct otx2_nic *nic);
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data);
+void otx2_tc_apply_ingress_police_rules(struct otx2_nic *nic);
+
 /* CGX/RPM DMAC filters support */
 int otx2_dmacflt_get_max_cnt(struct otx2_nic *pf);
 int otx2_dmacflt_add(struct otx2_nic *pf, const u8 *mac, u32 bit_pos);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ba95ac9..d624be6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1870,6 +1870,8 @@ int otx2_open(struct net_device *netdev)
 	if (pf->flags & OTX2_FLAG_DMACFLTR_SUPPORT)
 		otx2_dmacflt_reinstall_flows(pf);
 
+	otx2_tc_apply_ingress_police_rules(pf);
+
 	err = otx2_rxtx_enable(pf, true);
 	/* If a mbox communication error happens at this point then interface
 	 * will end up in a state such that it is in down state but hardware
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 8a5e398..db1e0e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -47,6 +47,9 @@ struct otx2_tc_flow {
 	bool				is_act_police;
 	u32				prio;
 	struct npc_install_flow_req	req;
+	u64				rate;
+	u32				burst;
+	bool				is_pps;
 };
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
@@ -284,21 +287,10 @@ static int otx2_tc_egress_matchall_delete(struct otx2_nic *nic,
 	return err;
 }
 
-static int otx2_tc_act_set_police(struct otx2_nic *nic,
-				  struct otx2_tc_flow *node,
-				  struct flow_cls_offload *f,
-				  u64 rate, u32 burst, u32 mark,
-				  struct npc_install_flow_req *req, bool pps)
+static int otx2_tc_act_set_hw_police(struct otx2_nic *nic,
+				     struct otx2_tc_flow *node)
 {
-	struct netlink_ext_ack *extack = f->common.extack;
-	struct otx2_hw *hw = &nic->hw;
-	int rq_idx, rc;
-
-	rq_idx = find_first_zero_bit(&nic->rq_bmap, hw->rx_queues);
-	if (rq_idx >= hw->rx_queues) {
-		NL_SET_ERR_MSG_MOD(extack, "Police action rules exceeded");
-		return -EINVAL;
-	}
+	int rc;
 
 	mutex_lock(&nic->mbox.lock);
 
@@ -308,23 +300,17 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
 		return rc;
 	}
 
-	rc = cn10k_set_ipolicer_rate(nic, node->leaf_profile, burst, rate, pps);
+	rc = cn10k_set_ipolicer_rate(nic, node->leaf_profile,
+				     node->burst, node->rate, node->is_pps);
 	if (rc)
 		goto free_leaf;
 
-	rc = cn10k_map_unmap_rq_policer(nic, rq_idx, node->leaf_profile, true);
+	rc = cn10k_map_unmap_rq_policer(nic, node->rq, node->leaf_profile, true);
 	if (rc)
 		goto free_leaf;
 
 	mutex_unlock(&nic->mbox.lock);
 
-	req->match_id = mark & 0xFFFFULL;
-	req->index = rq_idx;
-	req->op = NIX_RX_ACTIONOP_UCAST;
-	set_bit(rq_idx, &nic->rq_bmap);
-	node->is_act_police = true;
-	node->rq = rq_idx;
-
 	return 0;
 
 free_leaf:
@@ -336,6 +322,39 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
 	return rc;
 }
 
+static int otx2_tc_act_set_police(struct otx2_nic *nic,
+				  struct otx2_tc_flow *node,
+				  struct flow_cls_offload *f,
+				  u64 rate, u32 burst, u32 mark,
+				  struct npc_install_flow_req *req, bool pps)
+{
+	struct netlink_ext_ack *extack = f->common.extack;
+	struct otx2_hw *hw = &nic->hw;
+	int rq_idx, rc;
+
+	rq_idx = find_first_zero_bit(&nic->rq_bmap, hw->rx_queues);
+	if (rq_idx >= hw->rx_queues) {
+		NL_SET_ERR_MSG_MOD(extack, "Police action rules exceeded");
+		return -EINVAL;
+	}
+
+	req->match_id = mark & 0xFFFFULL;
+	req->index = rq_idx;
+	req->op = NIX_RX_ACTIONOP_UCAST;
+
+	node->is_act_police = true;
+	node->rq = rq_idx;
+	node->burst = burst;
+	node->rate = rate;
+	node->is_pps = pps;
+
+	rc = otx2_tc_act_set_hw_police(nic, node);
+	if (!rc)
+		set_bit(rq_idx, &nic->rq_bmap);
+
+	return rc;
+}
+
 static int otx2_tc_parse_actions(struct otx2_nic *nic,
 				 struct flow_action *flow_action,
 				 struct npc_install_flow_req *req,
@@ -1044,6 +1063,11 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 	}
 
 	if (flow_node->is_act_police) {
+		__clear_bit(flow_node->rq, &nic->rq_bmap);
+
+		if (nic->flags & OTX2_FLAG_INTF_DOWN)
+			goto free_mcam_flow;
+
 		mutex_lock(&nic->mbox.lock);
 
 		err = cn10k_map_unmap_rq_policer(nic, flow_node->rq,
@@ -1059,11 +1083,10 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 				   "Unable to free leaf bandwidth profile(%d)\n",
 				   flow_node->leaf_profile);
 
-		__clear_bit(flow_node->rq, &nic->rq_bmap);
-
 		mutex_unlock(&nic->mbox.lock);
 	}
 
+free_mcam_flow:
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
 	kfree_rcu(flow_node, rcu);
@@ -1083,6 +1106,11 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
 
+	if (nic->flags & OTX2_FLAG_INTF_DOWN) {
+		NL_SET_ERR_MSG_MOD(extack, "Interface not initialized");
+		return -EINVAL;
+	}
+
 	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Free MCAM entry not available to add the flow");
@@ -1442,3 +1470,45 @@ void otx2_shutdown_tc(struct otx2_nic *nic)
 	otx2_destroy_tc_flow_list(nic);
 }
 EXPORT_SYMBOL(otx2_shutdown_tc);
+
+static void otx2_tc_config_ingress_rule(struct otx2_nic *nic,
+					struct otx2_tc_flow *node)
+{
+	struct npc_install_flow_req *req;
+
+	if (otx2_tc_act_set_hw_police(nic, node))
+		return;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
+	if (!req)
+		goto err;
+
+	memcpy(req, &node->req, sizeof(struct npc_install_flow_req));
+
+	if (otx2_sync_mbox_msg(&nic->mbox))
+		netdev_err(nic->netdev,
+			   "Failed to install MCAM flow entry for ingress rule");
+err:
+	mutex_unlock(&nic->mbox.lock);
+}
+
+void otx2_tc_apply_ingress_police_rules(struct otx2_nic *nic)
+{
+	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
+	struct otx2_tc_flow *node;
+
+	/* If any ingress policer rules exist for the interface then
+	 * apply those rules. Ingress policer rules depend on bandwidth
+	 * profiles linked to the receive queues. Since no receive queues
+	 * exist when interface is down, ingress policer rules are stored
+	 * and configured in hardware after all receive queues are allocated
+	 * in otx2_open.
+	 */
+	list_for_each_entry(node, &flow_cfg->flow_list_tc, list) {
+		if (node->is_act_police)
+			otx2_tc_config_ingress_rule(nic, node);
+	}
+}
+EXPORT_SYMBOL(otx2_tc_apply_ingress_police_rules);
-- 
2.7.4

