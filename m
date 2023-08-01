Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031A676A86C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjHAFjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjHAFjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:39:15 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B26116;
        Mon, 31 Jul 2023 22:38:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3714lehG005896;
        Mon, 31 Jul 2023 22:38:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=VflmzOilfVBZ7dn5gD4nqAdvmMGS1KNl4DjPw/FtZ/k=;
 b=NnCssbCZ6s/m8hvUM9etlS8qTrOwuLRxY2Kh3KYpWdMVbgP860sg4uclQsExtU1RPAGA
 +H05LF5cznYTUCU6FRs0UxOV0auUEum9I623KZiCtne0Y6BIBUPTCFJfL7Idw5Ro5616
 cscm5HsdzUWOImvfBqpQoNIh768xjd4BgimjNMm3QhZQyy2y0yhil4VrvXDm6luflxVq
 zoY3FEvoJ14Dm9bKHrHtT6deM+icYd6zYTPsJRgZYsHv/xPR/Jf/FT3af6y0bnT1VB8d
 37CbHfqq66oU72FkrSfekvc8CcmebCwZI5uxCfTnppkMIv7WrButXCI/r58ncf28gBrh jw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k7hd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 22:38:38 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 22:38:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 22:38:35 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 65CC23F70C4;
        Mon, 31 Jul 2023 22:38:31 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <simon.horman@corigine.com>, <jesse.brandeburg@intel.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH V3 2/2] octeontx2-af: TC flower offload support for inner VLAN
Date:   Tue, 1 Aug 2023 11:08:13 +0530
Message-ID: <20230801053813.2857958-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801053813.2857958-1-sumang@marvell.com>
References: <20230801053813.2857958-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DYS6TqEQ5y5BqSLF-8sgCIflO4YsKRj1
X-Proofpoint-ORIG-GUID: DYS6TqEQ5y5BqSLF-8sgCIflO4YsKRj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the current TC flower offload support to enable filters matching
inner VLAN, and support offload of those filters to hardware.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  3 ++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  5 ++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 13 +++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 28 +++++++++++++++----
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index ed66c5989102..382764f39702 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1461,6 +1461,7 @@ struct flow_msg {
 		u8 ip_flag;
 		u8 next_header;
 	};
+	__be16 vlan_itci;
 };
 
 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 9beeead56d7b..5b6a1b941ccc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -184,6 +184,7 @@ enum key_fields {
 	NPC_VLAN_ETYPE_CTAG, /* 0x8100 */
 	NPC_VLAN_ETYPE_STAG, /* 0x88A8 */
 	NPC_OUTER_VID,
+	NPC_INNER_VID,
 	NPC_TOS,
 	NPC_IPFRAG_IPV4,
 	NPC_SIP_IPV4,
@@ -229,6 +230,8 @@ enum key_fields {
 	NPC_VLAN_TAG1,
 	/* outer vlan tci for double tagged frame */
 	NPC_VLAN_TAG2,
+	/* inner vlan tci for double tagged frame */
+	NPC_VLAN_TAG3,
 	/* other header fields programmed to extract but not of our interest */
 	NPC_UNKNOWN,
 	NPC_KEY_FIELDS_MAX,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3b26893efdf8..3d0825c0685a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2787,6 +2787,11 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "mask 0x%x\n",
 				   ntohs(rule->mask.vlan_tci));
 			break;
+		case NPC_INNER_VID:
+			seq_printf(s, "0x%x ", ntohs(rule->packet.vlan_itci));
+			seq_printf(s, "mask 0x%x\n",
+				   ntohs(rule->mask.vlan_itci));
+			break;
 		case NPC_TOS:
 			seq_printf(s, "%d ", rule->packet.tos);
 			seq_printf(s, "mask 0x%x\n", rule->mask.tos);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 9c365cc3e736..f2a7599aa9de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -20,6 +20,7 @@ static const char * const npc_flow_names[] = {
 	[NPC_VLAN_ETYPE_CTAG] = "vlan ether type ctag",
 	[NPC_VLAN_ETYPE_STAG] = "vlan ether type stag",
 	[NPC_OUTER_VID]	= "outer vlan id",
+	[NPC_INNER_VID]	= "inner vlan id",
 	[NPC_TOS]	= "tos",
 	[NPC_IPFRAG_IPV4] = "fragmented IPv4 header ",
 	[NPC_SIP_IPV4]	= "ipv4 source ip",
@@ -327,6 +328,8 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	 */
 	struct npc_key_field *vlan_tag1;
 	struct npc_key_field *vlan_tag2;
+	/* Inner VLAN TCI for double tagged frames */
+	struct npc_key_field *vlan_tag3;
 	u64 *features;
 	u8 start_lid;
 	int i;
@@ -349,6 +352,7 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 	etype_tag2 = &key_fields[NPC_ETYPE_TAG2];
 	vlan_tag1 = &key_fields[NPC_VLAN_TAG1];
 	vlan_tag2 = &key_fields[NPC_VLAN_TAG2];
+	vlan_tag3 = &key_fields[NPC_VLAN_TAG3];
 
 	/* if key profile programmed does not extract Ethertype at all */
 	if (!etype_ether->nr_kws && !etype_tag1->nr_kws && !etype_tag2->nr_kws) {
@@ -430,6 +434,12 @@ static void npc_handle_multi_layer_fields(struct rvu *rvu, int blkaddr, u8 intf)
 		goto done;
 	}
 	*features |= BIT_ULL(NPC_OUTER_VID);
+
+	/* If key profile extracts inner vlan tci */
+	if (vlan_tag3->nr_kws) {
+		key_fields[NPC_INNER_VID] = *vlan_tag3;
+		*features |= BIT_ULL(NPC_INNER_VID);
+	}
 done:
 	return;
 }
@@ -512,6 +522,7 @@ do {									       \
 	NPC_SCAN_HDR(NPC_ETYPE_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 8, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 2, 2);
+	NPC_SCAN_HDR(NPC_VLAN_TAG3, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 6, 2);
 	NPC_SCAN_HDR(NPC_DMAC, NPC_LID_LA, la_ltype, la_start, 6);
 	/* SMAC follows the DMAC(which is 6 bytes) */
 	NPC_SCAN_HDR(NPC_SMAC, NPC_LID_LA, la_ltype, la_start + 6, 6);
@@ -932,6 +943,8 @@ do {									      \
 
 	NPC_WRITE_FLOW(NPC_OUTER_VID, vlan_tci, ntohs(pkt->vlan_tci), 0,
 		       ntohs(mask->vlan_tci), 0);
+	NPC_WRITE_FLOW(NPC_INNER_VID, vlan_itci, ntohs(pkt->vlan_itci), 0,
+		       ntohs(mask->vlan_itci), 0);
 
 	NPC_WRITE_FLOW(NPC_IPFRAG_IPV6, next_header, pkt->next_header, 0,
 		       mask->next_header, 0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index f311fa6db7ce..01e114ac5d4e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -447,10 +447,11 @@ static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec
 	u16 vlan_tci, vlan_tci_mask;
 
 	if (is_inner)
-		return -EOPNOTSUPP;
+		flow_rule_match_cvlan(rule, &match);
+	else
+		flow_rule_match_vlan(rule, &match);
 
-	flow_rule_match_vlan(rule, &match);
-	if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
+	if (!eth_type_vlan(match.key->vlan_tpid)) {
 		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
 			   ntohs(match.key->vlan_tpid));
 		return -EOPNOTSUPP;
@@ -480,9 +481,15 @@ static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec
 		vlan_tci_mask = match.mask->vlan_id |
 				match.mask->vlan_dei << 12 |
 				match.mask->vlan_priority << 13;
-		flow_spec->vlan_tci = htons(vlan_tci);
-		flow_mask->vlan_tci = htons(vlan_tci_mask);
-		req->features |= BIT_ULL(NPC_OUTER_VID);
+		if (is_inner) {
+			flow_spec->vlan_itci = htons(vlan_tci);
+			flow_mask->vlan_itci = htons(vlan_tci_mask);
+			req->features |= BIT_ULL(NPC_INNER_VID);
+		} else {
+			flow_spec->vlan_tci = htons(vlan_tci);
+			flow_mask->vlan_tci = htons(vlan_tci_mask);
+			req->features |= BIT_ULL(NPC_OUTER_VID);
+		}
 	}
 
 	return 0;
@@ -507,6 +514,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
 	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
 	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
@@ -620,6 +628,14 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			return ret;
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN)) {
+		int ret;
+
+		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, true);
+		if (ret)
+			return ret;
+	}
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
 		struct flow_match_ipv4_addrs match;
 
-- 
2.25.1

