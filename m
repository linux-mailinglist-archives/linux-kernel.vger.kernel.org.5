Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0C7610FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjGYKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjGYKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:35:01 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921A12E;
        Tue, 25 Jul 2023 03:35:00 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P0Wmqm019445;
        Tue, 25 Jul 2023 03:34:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=61/557pYAs+12TGw7apxERd4cIHa0ru1KSilQz+Glf0=;
 b=DRKAuQi46v3L430sESAVZp/Dp1NEFGGZrV4ET3gC+zm7ecw0n9j1iRsta1oHr8i5tz9S
 MfSo9UWZQ/0CUruRacZJmqu6rfRLJ3gcMsfhIwPShLOKWnsA4GSt6VGgF3nZf7Sq8HDC
 /zUtA/BOZSexFtrjbL4zeErERQIeSLoWOmGuvFZvEHPi3i0Cyw9+gtAmurEqfeEbUXn8
 0IfA/PY00tm7ShJvFOC6Jd/+4MEclXOMJ41XrL6Z5OmBGblzI9HVTQ4v5vo2BK1Pb3zz
 QiclaOWYt7U+oN/UxaSabFE3rEZehm8tOiAx5zKyZiWCKOPePosqk5BppK+St42SAoXi +Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s18r25nt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 03:34:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 25 Jul
 2023 03:34:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 25 Jul 2023 03:34:50 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 1F83E3F7040;
        Tue, 25 Jul 2023 03:34:45 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Tc flower offload support for inner VLAN
Date:   Tue, 25 Jul 2023 16:04:42 +0530
Message-ID: <20230725103442.2749183-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wR7hB1VLeLqG0xiG1cSeEjMYuInGTdGi
X-Proofpoint-ORIG-GUID: wR7hB1VLeLqG0xiG1cSeEjMYuInGTdGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_05,2023-07-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends current TC flower offload support to allow filters
involving inner VLAN matching, to be offloaded to HW.

Example command:
tc filter add dev eth2 protocol 802.1AD parent ffff: flower vlan_id 10
vlan_ethtype 802.1Q cvlan_id 20 skip_sw action drop

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/npc.h   |   3 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |   5 +
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 106 +++++++++++-------
 5 files changed, 90 insertions(+), 38 deletions(-)

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
index 1e6fc23eca4f..a102f6e63fb3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -439,6 +439,63 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 	return 0;
 }
 
+static int otx2_tc_process_vlan(struct otx2_nic *nic, struct flow_msg *flow_spec,
+				struct flow_msg *flow_mask, struct flow_rule *rule,
+				struct npc_install_flow_req *req, bool is_inner)
+{
+	struct flow_match_vlan match;
+	u16 vlan_tci, vlan_tci_mask;
+
+	if (!is_inner)
+		flow_rule_match_vlan(rule, &match);
+	else
+		flow_rule_match_cvlan(rule, &match);
+
+	if ((ntohs(match.key->vlan_tpid) != ETH_P_8021Q) &&
+	    (ntohs(match.key->vlan_tpid) != ETH_P_8021AD)) {
+		netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
+			   ntohs(match.key->vlan_tpid));
+		return -EOPNOTSUPP;
+	}
+
+	if (!match.mask->vlan_id) {
+		struct flow_action_entry *act;
+		int i;
+
+		flow_action_for_each(i, act, &rule->action) {
+			if (act->id == FLOW_ACTION_DROP) {
+				netdev_err(nic->netdev, "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
+					   ntohs(match.key->vlan_tpid), match.key->vlan_id);
+				return -EOPNOTSUPP;
+			}
+		}
+	}
+
+	if (match.mask->vlan_id ||
+	    match.mask->vlan_dei ||
+	    match.mask->vlan_priority) {
+		vlan_tci = match.key->vlan_id |
+			   match.key->vlan_dei << 12 |
+			   match.key->vlan_priority << 13;
+
+		vlan_tci_mask = match.mask->vlan_id |
+				match.mask->vlan_dei << 12 |
+				match.mask->vlan_priority << 13;
+
+		if (!is_inner) {
+			flow_spec->vlan_tci = htons(vlan_tci);
+			flow_mask->vlan_tci = htons(vlan_tci_mask);
+			req->features |= BIT_ULL(NPC_OUTER_VID);
+		} else {
+			flow_spec->vlan_itci = htons(vlan_tci);
+			flow_mask->vlan_itci = htons(vlan_tci_mask);
+			req->features |= BIT_ULL(NPC_INNER_VID);
+		}
+	}
+
+	return 0;
+}
+
 static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 				struct flow_cls_offload *f,
 				struct npc_install_flow_req *req)
@@ -458,6 +515,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT(FLOW_DISSECTOR_KEY_BASIC) |
 	      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_VLAN) |
+	      BIT(FLOW_DISSECTOR_KEY_CVLAN) |
 	      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT(FLOW_DISSECTOR_KEY_PORTS) |
@@ -564,47 +622,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
-		struct flow_match_vlan match;
-		u16 vlan_tci, vlan_tci_mask;
-
-		flow_rule_match_vlan(rule, &match);
-
-		if (ntohs(match.key->vlan_tpid) != ETH_P_8021Q) {
-			netdev_err(nic->netdev, "vlan tpid 0x%x not supported\n",
-				   ntohs(match.key->vlan_tpid));
-			return -EOPNOTSUPP;
-		}
+		int ret;
 
-		if (!match.mask->vlan_id) {
-			struct flow_action_entry *act;
-			int i;
-
-			flow_action_for_each(i, act, &rule->action) {
-				if (act->id == FLOW_ACTION_DROP) {
-					netdev_err(nic->netdev,
-						   "vlan tpid 0x%x with vlan_id %d is not supported for DROP rule.\n",
-						   ntohs(match.key->vlan_tpid),
-						   match.key->vlan_id);
-					return -EOPNOTSUPP;
-				}
-			}
-		}
-
-		if (match.mask->vlan_id ||
-		    match.mask->vlan_dei ||
-		    match.mask->vlan_priority) {
-			vlan_tci = match.key->vlan_id |
-				   match.key->vlan_dei << 12 |
-				   match.key->vlan_priority << 13;
+		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, false);
+		if (ret)
+			return ret;
+	}
 
-			vlan_tci_mask = match.mask->vlan_id |
-					match.mask->vlan_dei << 12 |
-					match.mask->vlan_priority << 13;
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CVLAN)) {
+		int ret;
 
-			flow_spec->vlan_tci = htons(vlan_tci);
-			flow_mask->vlan_tci = htons(vlan_tci_mask);
-			req->features |= BIT_ULL(NPC_OUTER_VID);
-		}
+		ret = otx2_tc_process_vlan(nic, flow_spec, flow_mask, rule, req, true);
+		if (ret)
+			return ret;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
-- 
2.25.1

