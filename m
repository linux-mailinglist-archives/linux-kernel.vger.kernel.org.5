Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87311809C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjLHG4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjLHG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:56:27 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF07172C;
        Thu,  7 Dec 2023 22:56:32 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B84BRcg017039;
        Thu, 7 Dec 2023 22:56:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=j40vAbxbC9C9HLlER4a3cYonqK/INrKGkTJhBdoOE+Q=;
 b=B/ZkAX6NaT1FBRq2iSRiSFR+6/nvq0UJ3NJ3kr3JQbPUTfqQ4OCEsHsb1hCjnTPEZlyO
 JT9U8RU8MgHuUsEOLTK7rA1fngHrf8BCIB0u4NZbXzM0bzHn49KWFaVMmLSQ089ZDyHC
 cumJs5wqP8fZV4PDp5ang1/8aqApzMMpkpFlwh6Ll6hPsXTYSSvLRbkDSXaO6kW5Mac3
 qT3DgVU8x08/jqSi/Y1TGzV2m0lf/cRp57tjGidBVIG/Zafi1PPHvrElT/ncLX2tMdN/
 fZfN5BJyssWDx7cXve8yz3E4B9WMOA3fcZeOK6Jx9dPAPDP7HqJMkcuMzee18lXWb9ns FA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uu8qecnd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 22:56:26 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 22:56:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 22:56:24 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id EA0CE3F70AA;
        Thu,  7 Dec 2023 22:56:20 -0800 (PST)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net 2/2] octeontx2-af: Update RSS algorithm index
Date:   Fri, 8 Dec 2023 12:26:10 +0530
Message-ID: <20231208065610.16086-3-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231208065610.16086-1-hkelam@marvell.com>
References: <20231208065610.16086-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: vA2OjqBjrypEWDePL_qGrGcxm1Nu1hHX
X-Proofpoint-ORIG-GUID: vA2OjqBjrypEWDePL_qGrGcxm1Nu1hHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RSS flow algorithm is not set up correctly for promiscuous or all
multi MCAM entries. This has an impact on flow distribution.

This patch fixes the issue by updating flow algorithm index in above
mentioned MCAM entries.

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 55 +++++++++++++++----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index f65805860c8d..0bcf3e559280 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -671,6 +671,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	int blkaddr, ucast_idx, index;
 	struct nix_rx_action action = { 0 };
 	u64 relaxed_mask;
+	u8 flow_key_alg;
 
 	if (!hw->cap.nix_rx_multicast && is_cgx_vf(rvu, pcifunc))
 		return;
@@ -701,6 +702,8 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 		action.op = NIX_RX_ACTIONOP_UCAST;
 	}
 
+	flow_key_alg = action.flow_key_alg;
+
 	/* RX_ACTION set to MCAST for CGX PF's */
 	if (hw->cap.nix_rx_multicast && pfvf->use_mce_list &&
 	    is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc))) {
@@ -740,7 +743,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	req.vf = pcifunc;
 	req.index = action.index;
 	req.match_id = action.match_id;
-	req.flow_key_alg = action.flow_key_alg;
+	req.flow_key_alg = flow_key_alg;
 
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
@@ -854,6 +857,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	u8 mac_addr[ETH_ALEN] = { 0 };
 	struct nix_rx_action action = { 0 };
 	struct rvu_pfvf *pfvf;
+	u8 flow_key_alg;
 	u16 vf_func;
 
 	/* Only CGX PF/VF can add allmulticast entry */
@@ -888,6 +892,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 		*(u64 *)&action = npc_get_mcam_action(rvu, mcam,
 							blkaddr, ucast_idx);
 
+	flow_key_alg = action.flow_key_alg;
 	if (action.op != NIX_RX_ACTIONOP_RSS) {
 		*(u64 *)&action = 0;
 		action.op = NIX_RX_ACTIONOP_UCAST;
@@ -924,7 +929,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	req.vf = pcifunc | vf_func;
 	req.index = action.index;
 	req.match_id = action.match_id;
-	req.flow_key_alg = action.flow_key_alg;
+	req.flow_key_alg = flow_key_alg;
 
 	rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
 }
@@ -990,11 +995,38 @@ static void npc_update_vf_flow_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	mutex_unlock(&mcam->lock);
 }
 
+static void npc_update_rx_action_with_alg_idx(struct rvu *rvu, struct nix_rx_action action,
+					      struct rvu_pfvf *pfvf, int mcam_index, int blkaddr,
+					      int alg_idx)
+
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	struct rvu_hwinfo *hw = rvu->hw;
+	int bank, op_rss;
+
+	if (!is_mcam_entry_enabled(rvu, mcam, blkaddr, mcam_index))
+		return;
+
+	op_rss = (!hw->cap.nix_rx_multicast || !pfvf->use_mce_list);
+
+	bank = npc_get_bank(mcam, mcam_index);
+	mcam_index &= (mcam->banksize - 1);
+
+	/* If Rx action is MCAST update only RSS algorithm index */
+	if (!op_rss) {
+		*(u64 *)&action = rvu_read64(rvu, blkaddr,
+				NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank));
+
+		action.flow_key_alg = alg_idx;
+	}
+	rvu_write64(rvu, blkaddr,
+		    NPC_AF_MCAMEX_BANKX_ACTION(mcam_index, bank), *(u64 *)&action);
+}
+
 void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    int group, int alg_idx, int mcam_index)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct rvu_hwinfo *hw = rvu->hw;
 	struct nix_rx_action action;
 	int blkaddr, index, bank;
 	struct rvu_pfvf *pfvf;
@@ -1050,15 +1082,16 @@ void rvu_npc_update_flowkey_alg_idx(struct rvu *rvu, u16 pcifunc, int nixlf,
 	/* If PF's promiscuous entry is enabled,
 	 * Set RSS action for that entry as well
 	 */
-	if ((!hw->cap.nix_rx_multicast || !pfvf->use_mce_list) &&
-	    is_mcam_entry_enabled(rvu, mcam, blkaddr, index)) {
-		bank = npc_get_bank(mcam, index);
-		index &= (mcam->banksize - 1);
+	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
+					  alg_idx);
 
-		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_ACTION(index, bank),
-			    *(u64 *)&action);
-	}
+	index = npc_get_nixlf_mcam_index(mcam, pcifunc,
+					 nixlf, NIXLF_ALLMULTI_ENTRY);
+	/* If PF's allmulti  entry is enabled,
+	 * Set RSS action for that entry as well
+	 */
+	npc_update_rx_action_with_alg_idx(rvu, action, pfvf, index, blkaddr,
+					  alg_idx);
 }
 
 void npc_enadis_default_mce_entry(struct rvu *rvu, u16 pcifunc,
-- 
2.17.1

