Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B89803645
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjLDOUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345047AbjLDOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:20:22 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6CA9;
        Mon,  4 Dec 2023 06:20:27 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CxpN6022056;
        Mon, 4 Dec 2023 06:20:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=b73DVrXn6ak7fqgTHQnpyL4JKRxZ4EwAz3xP4X5tgp8=;
 b=IZHYVg3SM0uU/0QWq6llBOHq29soD/av3MTRPoEWZoBQ8o8rlxwB3+iyfOLk92/kddDu
 gYhDmkF9uEzr/P6iwkzG+drpdStm8S1NFUQqJpyVCWaucztvxt0cZcgTm2t3Qm1nOXaa
 F4crWe/w7Ct8e8nkOolF6xrxhTyOrh/b4CdvY/u3TRiKel8glTu6n8O5lxyR+Nc+f8pV
 NNWf/qLGI00AFuxikloItuXGjsKmgn5Hh/kBQgmTpsY1LzCqoRxGeY0h6wJcI6nElWUk
 Qs/1+4EbYNJfj8NNCBb23SvUf+y+xESDUgmIRBQtsTrjWVKpc2HCUQo7HF8KL3P7c2om ww== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ur2tvde9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 06:20:19 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 06:20:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 06:20:17 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 32D223F709D;
        Mon,  4 Dec 2023 06:20:12 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <horms@kernel.org>,
        <wojciech.drewek@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v6 2/2] octeontx2-pf: TC flower offload support for mirror
Date:   Mon, 4 Dec 2023 19:49:56 +0530
Message-ID: <20231204141956.3956942-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204141956.3956942-1-sumang@marvell.com>
References: <20231204141956.3956942-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WjWFm3xhfrqFMZYvn8FyOsoMS4d7Ovxp
X-Proofpoint-GUID: WjWFm3xhfrqFMZYvn8FyOsoMS4d7Ovxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends TC flower offload support for mirroring ingress
traffic to a different PF/VF. Below is an example command,

'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
skip_sw action mirred ingress mirror dev eth2'

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 113 +++++++++++++++++-
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 757806be48a2..0750fdcbcfd3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -29,6 +29,8 @@
 
 #define OTX2_UNSUPP_LSE_DEPTH		GENMASK(6, 4)
 
+#define MCAST_INVALID_GRP		(-1U)
+
 struct otx2_tc_flow_stats {
 	u64 bytes;
 	u64 pkts;
@@ -50,6 +52,7 @@ struct otx2_tc_flow {
 	u64				rate;
 	u32				burst;
 	bool				is_pps;
+	u32				mcast_grp_idx;
 };
 
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
@@ -355,22 +358,96 @@ static int otx2_tc_act_set_police(struct otx2_nic *nic,
 	return rc;
 }
 
+static int otx2_tc_update_mcast(struct otx2_nic *nic,
+				struct npc_install_flow_req *req,
+				struct netlink_ext_ack *extack,
+				struct otx2_tc_flow *node,
+				struct nix_mcast_grp_update_req *ureq,
+				u8 num_intf)
+{
+	struct nix_mcast_grp_update_req *grp_update_req;
+	struct nix_mcast_grp_create_req *creq;
+	struct nix_mcast_grp_create_rsp *crsp;
+	u32 grp_index;
+	int rc;
+
+	mutex_lock(&nic->mbox.lock);
+	creq = otx2_mbox_alloc_msg_nix_mcast_grp_create(&nic->mbox);
+	if (!creq) {
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	creq->dir = NIX_MCAST_INGRESS;
+	/* Send message to AF */
+	rc = otx2_sync_mbox_msg(&nic->mbox);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to create multicast group");
+		goto error;
+	}
+
+	crsp = (struct nix_mcast_grp_create_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+			0,
+			&creq->hdr);
+	if (IS_ERR(crsp)) {
+		rc = PTR_ERR(crsp);
+		goto error;
+	}
+
+	grp_index = crsp->mcast_grp_idx;
+	grp_update_req = otx2_mbox_alloc_msg_nix_mcast_grp_update(&nic->mbox);
+	if (!grp_update_req) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to update multicast group");
+		rc = -ENOMEM;
+		goto error;
+	}
+
+	ureq->op = NIX_MCAST_OP_ADD_ENTRY;
+	ureq->mcast_grp_idx = grp_index;
+	ureq->num_mce_entry = num_intf;
+	ureq->pcifunc[0] = nic->pcifunc;
+	ureq->channel[0] = nic->hw.tx_chan_base;
+
+	ureq->dest_type[0] = NIX_RX_RSS;
+	ureq->rq_rss_index[0] = 0;
+	memcpy(&ureq->hdr, &grp_update_req->hdr, sizeof(struct mbox_msghdr));
+	memcpy(grp_update_req, ureq, sizeof(struct nix_mcast_grp_update_req));
+
+	/* Send message to AF */
+	rc = otx2_sync_mbox_msg(&nic->mbox);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to update multicast group");
+		goto error;
+	}
+
+	mutex_unlock(&nic->mbox.lock);
+	req->op = NIX_RX_ACTIONOP_MCAST;
+	req->index = grp_index;
+	node->mcast_grp_idx = grp_index;
+	return 0;
+
+error:
+	mutex_unlock(&nic->mbox.lock);
+	return rc;
+}
+
 static int otx2_tc_parse_actions(struct otx2_nic *nic,
 				 struct flow_action *flow_action,
 				 struct npc_install_flow_req *req,
 				 struct flow_cls_offload *f,
 				 struct otx2_tc_flow *node)
 {
+	struct nix_mcast_grp_update_req dummy_grp_update_req = { 0 };
 	struct netlink_ext_ack *extack = f->common.extack;
+	bool pps = false, mcast = false;
 	struct flow_action_entry *act;
 	struct net_device *target;
 	struct otx2_nic *priv;
 	u32 burst, mark = 0;
 	u8 nr_police = 0;
-	bool pps = false;
+	u8 num_intf = 1;
+	int err, i;
 	u64 rate;
-	int err;
-	int i;
 
 	if (!flow_action_has_entries(flow_action)) {
 		NL_SET_ERR_MSG_MOD(extack, "no tc actions specified");
@@ -442,11 +519,30 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 			req->index = act->rx_queue;
 			break;
 
+		case FLOW_ACTION_MIRRED_INGRESS:
+			target = act->dev;
+			priv = netdev_priv(target);
+			dummy_grp_update_req.pcifunc[num_intf] = priv->pcifunc;
+			dummy_grp_update_req.channel[num_intf] = priv->hw.tx_chan_base;
+			dummy_grp_update_req.dest_type[num_intf] = NIX_RX_RSS;
+			dummy_grp_update_req.rq_rss_index[num_intf] = 0;
+			mcast = true;
+			num_intf++;
+			break;
+
 		default:
 			return -EOPNOTSUPP;
 		}
 	}
 
+	if (mcast) {
+		err = otx2_tc_update_mcast(nic, req, extack, node,
+					   &dummy_grp_update_req,
+					   num_intf);
+		if (err)
+			return err;
+	}
+
 	if (nr_police > 1) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "rate limit police offload requires a single action");
@@ -1066,6 +1162,7 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 			    struct flow_cls_offload *tc_flow_cmd)
 {
 	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
+	struct nix_mcast_grp_destroy_req *grp_destroy_req;
 	struct otx2_tc_flow *flow_node;
 	int err;
 
@@ -1101,6 +1198,15 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 	}
 
 free_mcam_flow:
+	/* Remove the multicast/mirror related nodes */
+	if (flow_node->mcast_grp_idx != MCAST_INVALID_GRP) {
+		mutex_lock(&nic->mbox.lock);
+		grp_destroy_req = otx2_mbox_alloc_msg_nix_mcast_grp_destroy(&nic->mbox);
+		grp_destroy_req->mcast_grp_idx = flow_node->mcast_grp_idx;
+		otx2_sync_mbox_msg(&nic->mbox);
+		mutex_unlock(&nic->mbox.lock);
+	}
+
 	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
 	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
 	kfree_rcu(flow_node, rcu);
@@ -1138,6 +1244,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	spin_lock_init(&new_node->lock);
 	new_node->cookie = tc_flow_cmd->cookie;
 	new_node->prio = tc_flow_cmd->common.prio;
+	new_node->mcast_grp_idx = MCAST_INVALID_GRP;
 
 	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
 
-- 
2.25.1

