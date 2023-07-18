Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B07572E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGRElJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRElH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:41:07 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3421E55;
        Mon, 17 Jul 2023 21:41:04 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HJ0BGR005200;
        Mon, 17 Jul 2023 21:40:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=9rG9yUFRbvDIUne3eGiJL+3vzt+x6/iHku62Qy0PvCA=;
 b=FxU3Jxser49gFMZDv/PrtWCLHGNO0RbrfArVDKlS6sJd5P1LrtwhlM9X4Cui59mFGQdn
 G/sTdjwai8k10CqFOcYuzFgq1RjCtSNm6Tdj7YI6J0oQBl2j9IdF/eb7wIpHFRDIg1MR
 j1Pl1ILvt7TWGFKGOV1KYadQ1BfQt5u1qqWc56qs4fLKvGqMoxjZ03VL1n9xoTzmzuTG
 fYJySyzf0HIFTJihWARWoeYgTVokAFpkjRzhJEB2jKeR7c+cMDfH1S+gq+ullLQ0gFZu
 FZgXTM2xSBMza0gqeANnqETBNq+8AG7j2WnCtPnSRZv3FhnTSu317NV5WbaR0FmGxwqv Ww== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rvyhx4ctp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 21:40:57 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 21:40:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 17 Jul 2023 21:40:55 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 259C93F70A1;
        Mon, 17 Jul 2023 21:40:51 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH V3] octeontx2-af: Install TC filter rules in hardware based on priority
Date:   Tue, 18 Jul 2023 10:10:49 +0530
Message-ID: <20230718044049.2546328-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3CWOTmX2mSNM8UuU24KK27iBb4a_kDMW
X-Proofpoint-ORIG-GUID: 3CWOTmX2mSNM8UuU24KK27iBb4a_kDMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, hardware does not support installing tc filter
rules based on priority. This patch adds support to install
the hardware rules based on priority. The final hardware rules
will not be dependent on rule installation order, it will be strictly
priority based, same as software.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
v3 changes:
- Addressed minor review comments from Leon Romanovsky

v2 changes:
- Rebased the patch on top of current 'main' branch

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |   9 +-
 .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   1 +
 .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 313 +++++++++++++-----
 8 files changed, 248 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eba307eee2b2..ed66c5989102 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -235,7 +235,7 @@ M(NPC_GET_KEX_CFG,	  0x600c, npc_get_kex_cfg,			\
 M(NPC_INSTALL_FLOW,	  0x600d, npc_install_flow,			       \
 				  npc_install_flow_req, npc_install_flow_rsp)  \
 M(NPC_DELETE_FLOW,	  0x600e, npc_delete_flow,			\
-				  npc_delete_flow_req, msg_rsp)		\
+				  npc_delete_flow_req, npc_delete_flow_rsp)		\
 M(NPC_MCAM_READ_ENTRY,	  0x600f, npc_mcam_read_entry,			\
 				  npc_mcam_read_entry_req,		\
 				  npc_mcam_read_entry_rsp)		\
@@ -1491,6 +1491,8 @@ struct npc_install_flow_req {
 	u8  vtag0_op;
 	u16 vtag1_def;
 	u8  vtag1_op;
+	/* old counter value */
+	u16 cntr_val;
 };
 
 struct npc_install_flow_rsp {
@@ -1506,6 +1508,11 @@ struct npc_delete_flow_req {
 	u8 all; /* PF + VFs */
 };
 
+struct npc_delete_flow_rsp {
+	struct mbox_msghdr hdr;
+	u16 cntr_val;
+};
+
 struct npc_mcam_read_entry_req {
 	struct mbox_msghdr hdr;
 	u16 entry;	 /* MCAM entry to read */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 952319453701..9c365cc3e736 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1192,7 +1192,7 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 	write_req.enable_entry = (u8)enable;
 	/* if counter is available then clear and use it */
 	if (req->set_cntr && rule->has_cntr) {
-		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), 0x00);
+		rvu_write64(rvu, blkaddr, NPC_AF_MATCH_STATX(rule->cntr), req->cntr_val);
 		write_req.set_cntr = 1;
 		write_req.cntr = rule->cntr;
 	}
@@ -1407,12 +1407,13 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
 
 int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 				     struct npc_delete_flow_req *req,
-				     struct msg_rsp *rsp)
+				     struct npc_delete_flow_rsp *rsp)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_npc_mcam_rule *iter, *tmp;
 	u16 pcifunc = req->hdr.pcifunc;
 	struct list_head del_list;
+	int blkaddr;
 
 	INIT_LIST_HEAD(&del_list);
 
@@ -1428,6 +1429,10 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 				list_move_tail(&iter->list, &del_list);
 			/* single rule */
 			} else if (req->entry == iter->entry) {
+				blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+				if (blkaddr)
+					rsp->cntr_val = rvu_read64(rvu, blkaddr,
+								   NPC_AF_MATCH_STATX(iter->cntr));
 				list_move_tail(&iter->list, &del_list);
 				break;
 			}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index 592b317f4637..854045ed3b06 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -158,6 +158,7 @@ void rvu_switch_enable(struct rvu *rvu)
 	struct npc_mcam_alloc_entry_req alloc_req = { 0 };
 	struct npc_mcam_alloc_entry_rsp alloc_rsp = { 0 };
 	struct npc_delete_flow_req uninstall_req = { 0 };
+	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
 	struct npc_mcam_free_entry_req free_req = { 0 };
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct msg_rsp rsp;
@@ -197,7 +198,7 @@ void rvu_switch_enable(struct rvu *rvu)
 uninstall_rules:
 	uninstall_req.start = rswitch->start_entry;
 	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
-	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
+	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
 	kfree(rswitch->entry2pcifunc);
 free_entries:
 	free_req.all = 1;
@@ -209,6 +210,7 @@ void rvu_switch_enable(struct rvu *rvu)
 void rvu_switch_disable(struct rvu *rvu)
 {
 	struct npc_delete_flow_req uninstall_req = { 0 };
+	struct npc_delete_flow_rsp uninstall_rsp = { 0 };
 	struct npc_mcam_free_entry_req free_req = { 0 };
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -250,7 +252,7 @@ void rvu_switch_disable(struct rvu *rvu)
 	uninstall_req.start = rswitch->start_entry;
 	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
 	free_req.all = 1;
-	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &rsp);
+	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
 	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
 	rswitch->used_entries = 0;
 	kfree(rswitch->entry2pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index ba8091131ec0..67715fc906b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -360,13 +360,8 @@ struct otx2_flow_config {
 	struct list_head	flow_list;
 	u32			dmacflt_max_flows;
 	u16                     max_flows;
-};
-
-struct otx2_tc_info {
-	/* hash table to store TC offloaded flows */
-	struct rhashtable		flow_table;
-	struct rhashtable_params	flow_ht_params;
-	unsigned long			*tc_entries_bitmap;
+	struct list_head	flow_list_tc;
+	bool			ntuple;
 };
 
 struct dev_hw_ops {
@@ -491,7 +486,6 @@ struct otx2_nic {
 	/* NPC MCAM */
 	struct otx2_flow_config	*flow_cfg;
 	struct otx2_mac_table	*mac_table;
-	struct otx2_tc_info	tc_info;
 
 	u64			reset_count;
 	struct work_struct	reset_task;
@@ -1063,7 +1057,6 @@ int otx2_init_tc(struct otx2_nic *nic);
 void otx2_shutdown_tc(struct otx2_nic *nic);
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data);
-int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic);
 /* CGX/RPM DMAC filters support */
 int otx2_dmacflt_get_max_cnt(struct otx2_nic *pf);
 int otx2_dmacflt_add(struct otx2_nic *pf, const u8 *mac, u32 bit_pos);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 63ef7c41d18d..4e1130496573 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -41,7 +41,6 @@ static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
 		return 0;
 
 	otx2_alloc_mcam_entries(pfvf, ctx->val.vu16);
-	otx2_tc_alloc_ent_bitmap(pfvf);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index c47d91da32dc..9efcec549834 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -764,6 +764,7 @@ static int otx2_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *nfc)
 	struct otx2_nic *pfvf = netdev_priv(dev);
 	int ret = -EOPNOTSUPP;
 
+	pfvf->flow_cfg->ntuple = ntuple;
 	switch (nfc->cmd) {
 	case ETHTOOL_SRXFH:
 		ret = otx2_set_rss_hash_opts(pfvf, nfc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
index 2d7713a1a153..4762dbea64a1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
@@ -276,6 +276,7 @@ int otx2vf_mcam_flow_init(struct otx2_nic *pfvf)
 
 	flow_cfg = pfvf->flow_cfg;
 	INIT_LIST_HEAD(&flow_cfg->flow_list);
+	INIT_LIST_HEAD(&flow_cfg->flow_list_tc);
 	flow_cfg->max_flows = 0;
 
 	return 0;
@@ -298,6 +299,7 @@ int otx2_mcam_flow_init(struct otx2_nic *pf)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&pf->flow_cfg->flow_list);
+	INIT_LIST_HEAD(&pf->flow_cfg->flow_list_tc);
 
 	/* Allocate bare minimum number of MCAM entries needed for
 	 * unicast and ntuple filters.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5e56b6c3e60a..ab775c36c958 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -34,9 +34,8 @@ struct otx2_tc_flow_stats {
 };
 
 struct otx2_tc_flow {
-	struct rhash_head		node;
+	struct list_head		list;
 	unsigned long			cookie;
-	unsigned int			bitpos;
 	struct rcu_head			rcu;
 	struct otx2_tc_flow_stats	stats;
 	spinlock_t			lock; /* lock for stats */
@@ -44,31 +43,10 @@ struct otx2_tc_flow {
 	u16				entry;
 	u16				leaf_profile;
 	bool				is_act_police;
+	u32				prio;
+	struct npc_install_flow_req	req;
 };
 
-int otx2_tc_alloc_ent_bitmap(struct otx2_nic *nic)
-{
-	struct otx2_tc_info *tc = &nic->tc_info;
-
-	if (!nic->flow_cfg->max_flows)
-		return 0;
-
-	/* Max flows changed, free the existing bitmap */
-	kfree(tc->tc_entries_bitmap);
-
-	tc->tc_entries_bitmap =
-			kcalloc(BITS_TO_LONGS(nic->flow_cfg->max_flows),
-				sizeof(long), GFP_KERNEL);
-	if (!tc->tc_entries_bitmap) {
-		netdev_err(nic->netdev,
-			   "Unable to alloc TC flow entries bitmap\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(otx2_tc_alloc_ent_bitmap);
-
 static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 				      u32 *burst_exp, u32 *burst_mantissa)
 {
@@ -707,8 +685,117 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	return otx2_tc_parse_actions(nic, &rule->action, req, f, node);
 }
 
-static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
+static void otx2_destroy_tc_flow_list(struct otx2_nic *pfvf)
+{
+	struct otx2_flow_config *flow_cfg = pfvf->flow_cfg;
+	struct otx2_tc_flow *iter, *tmp;
+
+	if (!(pfvf->flags & OTX2_FLAG_MCAM_ENTRIES_ALLOC))
+		return;
+
+	list_for_each_entry_safe(iter, tmp, &flow_cfg->flow_list_tc, list) {
+		list_del(&iter->list);
+		kfree(iter);
+		flow_cfg->nr_flows--;
+	}
+}
+
+static struct otx2_tc_flow *otx2_tc_get_entry_by_cookie(struct otx2_flow_config *flow_cfg,
+							unsigned long cookie)
+{
+	struct otx2_tc_flow *tmp;
+
+	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
+		if (tmp->cookie == cookie)
+			return tmp;
+	}
+
+	return NULL;
+}
+
+static struct otx2_tc_flow *otx2_tc_get_entry_by_index(struct otx2_flow_config *flow_cfg,
+						       int index)
+{
+	struct otx2_tc_flow *tmp;
+	int i = 0;
+
+	list_for_each_entry(tmp, &flow_cfg->flow_list_tc, list) {
+		if (i == index)
+			return tmp;
+		i++;
+	}
+
+	return NULL;
+}
+
+static void otx2_tc_del_from_flow_list(struct otx2_flow_config *flow_cfg,
+				       struct otx2_tc_flow *node)
 {
+	struct list_head *pos, *n;
+	struct otx2_tc_flow *tmp;
+
+	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
+		tmp = list_entry(pos, struct otx2_tc_flow, list);
+		if (node == tmp) {
+			list_del(&node->list);
+			return;
+		}
+	}
+}
+
+static int otx2_tc_add_to_flow_list(struct otx2_flow_config *flow_cfg,
+				    struct otx2_tc_flow *node)
+{
+	struct list_head *pos, *n;
+	struct otx2_tc_flow *tmp;
+	int index = 0;
+
+	/* If the flow list is empty then add the new node */
+	if (list_empty(&flow_cfg->flow_list_tc)) {
+		list_add(&node->list, &flow_cfg->flow_list_tc);
+		return index;
+	}
+
+	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
+		tmp = list_entry(pos, struct otx2_tc_flow, list);
+		if (node->prio < tmp->prio)
+			break;
+		index++;
+	}
+
+	list_add(&node->list, pos->prev);
+	return index;
+}
+
+static int otx2_add_mcam_flow_entry(struct otx2_nic *nic, struct npc_install_flow_req *req)
+{
+	struct npc_install_flow_req *tmp_req;
+	int err;
+
+	mutex_lock(&nic->mbox.lock);
+	tmp_req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
+	if (!tmp_req) {
+		mutex_unlock(&nic->mbox.lock);
+		return -ENOMEM;
+	}
+
+	memcpy(tmp_req, req, sizeof(struct npc_install_flow_req));
+	/* Send message to AF */
+	err = otx2_sync_mbox_msg(&nic->mbox);
+	if (err) {
+		netdev_err(nic->netdev, "Failed to install MCAM flow entry %d\n",
+			   req->entry);
+		mutex_unlock(&nic->mbox.lock);
+		return -EFAULT;
+	}
+
+	mutex_unlock(&nic->mbox.lock);
+	return 0;
+}
+
+static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry, u16 *cntr_val)
+{
+	struct npc_delete_flow_rsp *rsp;
 	struct npc_delete_flow_req *req;
 	int err;
 
@@ -729,22 +816,106 @@ static int otx2_del_mcam_flow_entry(struct otx2_nic *nic, u16 entry)
 		mutex_unlock(&nic->mbox.lock);
 		return -EFAULT;
 	}
+
+	if (cntr_val) {
+		rsp = (struct npc_delete_flow_rsp *)otx2_mbox_get_rsp(&nic->mbox.mbox,
+								      0, &req->hdr);
+		*cntr_val = rsp->cntr_val;
+	}
+
 	mutex_unlock(&nic->mbox.lock);
+	return 0;
+}
+
+static int otx2_tc_update_mcam_table_del_req(struct otx2_nic *nic,
+					     struct otx2_flow_config *flow_cfg,
+					     struct otx2_tc_flow *node)
+{
+	struct list_head *pos, *n;
+	struct otx2_tc_flow *tmp;
+	int i = 0, index = 0;
+	u16 cntr_val;
+
+	/* Find and delete the entry from the list and re-install
+	 * all the entries from beginning to the index of the
+	 * deleted entry to higher mcam indexes.
+	 */
+	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
+		tmp = list_entry(pos, struct otx2_tc_flow, list);
+		if (node == tmp) {
+			list_del(&tmp->list);
+			break;
+		}
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		tmp->entry++;
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+		index++;
+	}
+
+	list_for_each_safe(pos, n, &flow_cfg->flow_list_tc) {
+		if (i == index)
+			break;
+
+		tmp = list_entry(pos, struct otx2_tc_flow, list);
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		i++;
+	}
 
 	return 0;
 }
 
+static int otx2_tc_update_mcam_table_add_req(struct otx2_nic *nic,
+					     struct otx2_flow_config *flow_cfg,
+					     struct otx2_tc_flow *node)
+{
+	int mcam_idx = flow_cfg->max_flows - flow_cfg->nr_flows - 1;
+	struct otx2_tc_flow *tmp;
+	int list_idx, i;
+	u16 cntr_val;
+
+	/* Find the index of the entry(list_idx) whose priority
+	 * is greater than the new entry and re-install all
+	 * the entries from beginning to list_idx to higher
+	 * mcam indexes.
+	 */
+	list_idx = otx2_tc_add_to_flow_list(flow_cfg, node);
+	for (i = 0; i < list_idx; i++) {
+		tmp = otx2_tc_get_entry_by_index(flow_cfg, i);
+		if (!tmp)
+			return -ENOMEM;
+
+		otx2_del_mcam_flow_entry(nic, tmp->entry, &cntr_val);
+		tmp->entry = flow_cfg->flow_ent[mcam_idx];
+		tmp->req.entry = tmp->entry;
+		tmp->req.cntr_val = cntr_val;
+		otx2_add_mcam_flow_entry(nic, &tmp->req);
+		mcam_idx++;
+	}
+
+	return mcam_idx;
+}
+
+static int otx2_tc_update_mcam_table(struct otx2_nic *nic,
+				     struct otx2_flow_config *flow_cfg,
+				     struct otx2_tc_flow *node,
+				     bool add_req)
+{
+	if (add_req)
+		return otx2_tc_update_mcam_table_add_req(nic, flow_cfg, node);
+
+	return otx2_tc_update_mcam_table_del_req(nic, flow_cfg, node);
+}
+
 static int otx2_tc_del_flow(struct otx2_nic *nic,
 			    struct flow_cls_offload *tc_flow_cmd)
 {
 	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
-	struct otx2_tc_info *tc_info = &nic->tc_info;
 	struct otx2_tc_flow *flow_node;
 	int err;
 
-	flow_node = rhashtable_lookup_fast(&tc_info->flow_table,
-					   &tc_flow_cmd->cookie,
-					   tc_info->flow_ht_params);
+	flow_node = otx2_tc_get_entry_by_cookie(flow_cfg, tc_flow_cmd->cookie);
 	if (!flow_node) {
 		netdev_err(nic->netdev, "tc flow not found for cookie 0x%lx\n",
 			   tc_flow_cmd->cookie);
@@ -772,16 +943,10 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		mutex_unlock(&nic->mbox.lock);
 	}
 
-	otx2_del_mcam_flow_entry(nic, flow_node->entry);
-
-	WARN_ON(rhashtable_remove_fast(&nic->tc_info.flow_table,
-				       &flow_node->node,
-				       nic->tc_info.flow_ht_params));
+	otx2_del_mcam_flow_entry(nic, flow_node->entry, NULL);
+	otx2_tc_update_mcam_table(nic, flow_cfg, flow_node, false);
 	kfree_rcu(flow_node, rcu);
-
-	clear_bit(flow_node->bitpos, tc_info->tc_entries_bitmap);
 	flow_cfg->nr_flows--;
-
 	return 0;
 }
 
@@ -790,15 +955,14 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 {
 	struct netlink_ext_ack *extack = tc_flow_cmd->common.extack;
 	struct otx2_flow_config *flow_cfg = nic->flow_cfg;
-	struct otx2_tc_info *tc_info = &nic->tc_info;
 	struct otx2_tc_flow *new_node, *old_node;
 	struct npc_install_flow_req *req, dummy;
-	int rc, err;
+	int rc, err, mcam_idx;
 
 	if (!(nic->flags & OTX2_FLAG_TC_FLOWER_SUPPORT))
 		return -ENOMEM;
 
-	if (bitmap_full(tc_info->tc_entries_bitmap, flow_cfg->max_flows)) {
+	if (flow_cfg->nr_flows == flow_cfg->max_flows) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Free MCAM entry not available to add the flow");
 		return -ENOMEM;
@@ -810,6 +974,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 		return -ENOMEM;
 	spin_lock_init(&new_node->lock);
 	new_node->cookie = tc_flow_cmd->cookie;
+	new_node->prio = tc_flow_cmd->common.prio;
 
 	memset(&dummy, 0, sizeof(struct npc_install_flow_req));
 
@@ -820,12 +985,11 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	}
 
 	/* If a flow exists with the same cookie, delete it */
-	old_node = rhashtable_lookup_fast(&tc_info->flow_table,
-					  &tc_flow_cmd->cookie,
-					  tc_info->flow_ht_params);
+	old_node = otx2_tc_get_entry_by_cookie(flow_cfg, tc_flow_cmd->cookie);
 	if (old_node)
 		otx2_tc_del_flow(nic, tc_flow_cmd);
 
+	mcam_idx = otx2_tc_update_mcam_table(nic, flow_cfg, new_node, true);
 	mutex_lock(&nic->mbox.lock);
 	req = otx2_mbox_alloc_msg_npc_install_flow(&nic->mbox);
 	if (!req) {
@@ -836,11 +1000,8 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 	memcpy(&dummy.hdr, &req->hdr, sizeof(struct mbox_msghdr));
 	memcpy(req, &dummy, sizeof(struct npc_install_flow_req));
-
-	new_node->bitpos = find_first_zero_bit(tc_info->tc_entries_bitmap,
-					       flow_cfg->max_flows);
 	req->channel = nic->hw.rx_chan_base;
-	req->entry = flow_cfg->flow_ent[flow_cfg->max_flows - new_node->bitpos - 1];
+	req->entry = flow_cfg->flow_ent[mcam_idx];
 	req->intf = NIX_INTF_RX;
 	req->set_cntr = 1;
 	new_node->entry = req->entry;
@@ -850,26 +1011,18 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 	if (rc) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed to install MCAM flow entry");
 		mutex_unlock(&nic->mbox.lock);
-		kfree_rcu(new_node, rcu);
 		goto free_leaf;
 	}
-	mutex_unlock(&nic->mbox.lock);
 
-	/* add new flow to flow-table */
-	rc = rhashtable_insert_fast(&nic->tc_info.flow_table, &new_node->node,
-				    nic->tc_info.flow_ht_params);
-	if (rc) {
-		otx2_del_mcam_flow_entry(nic, req->entry);
-		kfree_rcu(new_node, rcu);
-		goto free_leaf;
-	}
+	mutex_unlock(&nic->mbox.lock);
+	memcpy(&new_node->req, req, sizeof(struct npc_install_flow_req));
 
-	set_bit(new_node->bitpos, tc_info->tc_entries_bitmap);
 	flow_cfg->nr_flows++;
-
 	return 0;
 
 free_leaf:
+	otx2_tc_del_from_flow_list(flow_cfg, new_node);
+	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -896,16 +1049,13 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 static int otx2_tc_get_flow_stats(struct otx2_nic *nic,
 				  struct flow_cls_offload *tc_flow_cmd)
 {
-	struct otx2_tc_info *tc_info = &nic->tc_info;
 	struct npc_mcam_get_stats_req *req;
 	struct npc_mcam_get_stats_rsp *rsp;
 	struct otx2_tc_flow_stats *stats;
 	struct otx2_tc_flow *flow_node;
 	int err;
 
-	flow_node = rhashtable_lookup_fast(&tc_info->flow_table,
-					   &tc_flow_cmd->cookie,
-					   tc_info->flow_ht_params);
+	flow_node = otx2_tc_get_entry_by_cookie(nic->flow_cfg, tc_flow_cmd->cookie);
 	if (!flow_node) {
 		netdev_info(nic->netdev, "tc flow not found for cookie %lx",
 			    tc_flow_cmd->cookie);
@@ -1053,12 +1203,20 @@ static int otx2_setup_tc_block_ingress_cb(enum tc_setup_type type,
 					  void *type_data, void *cb_priv)
 {
 	struct otx2_nic *nic = cb_priv;
+	bool ntuple;
 
 	if (!tc_cls_can_offload_and_chain0(nic->netdev, type_data))
 		return -EOPNOTSUPP;
 
+	ntuple = nic->netdev->features & NETIF_F_NTUPLE;
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
+		if (ntuple) {
+			netdev_warn(nic->netdev,
+				    "Can't install TC flower offload rule when NTUPLE is active");
+			return -EOPNOTSUPP;
+		}
+
 		return otx2_setup_tc_cls_flower(nic, type_data);
 	case TC_SETUP_CLSMATCHALL:
 		return otx2_setup_tc_ingress_matchall(nic, type_data);
@@ -1143,18 +1301,8 @@ int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 }
 EXPORT_SYMBOL(otx2_setup_tc);
 
-static const struct rhashtable_params tc_flow_ht_params = {
-	.head_offset = offsetof(struct otx2_tc_flow, node),
-	.key_offset = offsetof(struct otx2_tc_flow, cookie),
-	.key_len = sizeof(((struct otx2_tc_flow *)0)->cookie),
-	.automatic_shrinking = true,
-};
-
 int otx2_init_tc(struct otx2_nic *nic)
 {
-	struct otx2_tc_info *tc = &nic->tc_info;
-	int err;
-
 	/* Exclude receive queue 0 being used for police action */
 	set_bit(0, &nic->rq_bmap);
 
@@ -1164,25 +1312,12 @@ int otx2_init_tc(struct otx2_nic *nic)
 		return -EINVAL;
 	}
 
-	err = otx2_tc_alloc_ent_bitmap(nic);
-	if (err)
-		return err;
-
-	tc->flow_ht_params = tc_flow_ht_params;
-	err = rhashtable_init(&tc->flow_table, &tc->flow_ht_params);
-	if (err) {
-		kfree(tc->tc_entries_bitmap);
-		tc->tc_entries_bitmap = NULL;
-	}
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(otx2_init_tc);
 
 void otx2_shutdown_tc(struct otx2_nic *nic)
 {
-	struct otx2_tc_info *tc = &nic->tc_info;
-
-	kfree(tc->tc_entries_bitmap);
-	rhashtable_destroy(&tc->flow_table);
+	otx2_destroy_tc_flow_list(nic);
 }
 EXPORT_SYMBOL(otx2_shutdown_tc);
-- 
2.25.1

