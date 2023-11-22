Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268E67F4508
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbjKVLmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbjKVLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:42:09 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365061A2;
        Wed, 22 Nov 2023 03:42:03 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALMG6QB014314;
        Wed, 22 Nov 2023 03:41:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=1pvUcaGJSmB2n0sOrjdv0qlWH7Qo0PGUliGurz2TBtA=;
 b=QMB34SoC266+9nz3TgbM2zZTGz+2cJAbUuj/2aQ2X9N41VZUxVgQ8QN1jRpJHQESio1M
 YwEFjXdakolJzWnSuuOY+wniqR8fh8cDKFfgjkl97LY3gJqAl8Pmvzo4Za3TRLEcjLwg
 GsqYDiEXLnMUYfkTLm7bmvAKtd4m5EMMCwDiUW5OzXq7WBb/njwdGyH+9ilEZGa5QmXc
 jOUjgSvrlQrl4u+lMH/SrKmsI82qSW0oBcDvWi5FN27i9IJ5BWqD3cqB9MEhEj6I+7ZY
 XvhI9JS/XWC3ZcP7hfB4SiY1M0a1McY5eSCUyUkcbYJ64qaid3QurjCtKOI8xqka3n/T lA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uh1jbb4h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 03:41:48 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 03:41:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 03:41:47 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 1D0083F7057;
        Wed, 22 Nov 2023 03:41:43 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: TC flower offload support for ICMP type and code
Date:   Wed, 22 Nov 2023 17:11:42 +0530
Message-ID: <20231122114142.11243-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TpgRdXwETJmfmMdUR0yQUWnDL2PbFfGF
X-Proofpoint-GUID: TpgRdXwETJmfmMdUR0yQUWnDL2PbFfGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_07,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds tc offload support for matching on ICMP type and code.

Example usage:
To enable adding tc ingress rules
        tc qdisc add dev eth0 ingress

TC rule drop the ICMP echo reply:
        tc filter add dev eth0 protocol ip parent ffff: \
        flower ip_proto icmp type 8 code 0 skip_sw action drop

TC rule to drop ICMPv6 echo reply:
        tc filter add dev eth0 protocol ipv6 parent ffff: flower \
        indev eth0 ip_proto icmpv6 type 128 code 0 action drop

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  2 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  2 ++
 .../marvell/octeontx2/af/rvu_debugfs.c        |  8 +++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 23 ++++++++++++++-----
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 14 +++++++++++
 5 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 6845556581c3..b4ced739ae44 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1479,6 +1479,8 @@ struct flow_msg {
 #define OTX2_FLOWER_MASK_MPLS_TTL		GENMASK(7, 0)
 #define OTX2_FLOWER_MASK_MPLS_NON_TTL		GENMASK(31, 8)
 	u32 mpls_lse[4];
+	u8 icmp_type;
+	u8 icmp_code;
 };
 
 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index ab3e39eef2eb..ffc0aa0a7b47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -214,6 +214,8 @@ enum key_fields {
 	NPC_MPLS3_TTL,
 	NPC_MPLS4_LBTCBOS,
 	NPC_MPLS4_TTL,
+	NPC_TYPE_ICMP,
+	NPC_CODE_ICMP,
 	NPC_HEADER_FIELDS_MAX,
 	NPC_CHAN = NPC_HEADER_FIELDS_MAX, /* Valid when Rx */
 	NPC_PF_FUNC, /* Valid when Tx */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index bd817ee88735..468b6561ed3f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2889,6 +2889,14 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			RVU_DBG_PRINT_MPLS_TTL(rule->packet.mpls_lse[3],
 					       rule->mask.mpls_lse[3]);
 			break;
+		case NPC_TYPE_ICMP:
+			seq_printf(s, "%d ", rule->packet.icmp_type);
+			seq_printf(s, "mask 0x%x\n", rule->mask.icmp_type);
+			break;
+		case NPC_CODE_ICMP:
+			seq_printf(s, "%d ", rule->packet.icmp_code);
+			seq_printf(s, "mask 0x%x\n", rule->mask.icmp_code);
+			break;
 		default:
 			seq_puts(s, "\n");
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 114e4ec21802..db8f151636af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -51,6 +51,8 @@ static const char * const npc_flow_names[] = {
 	[NPC_MPLS3_TTL]     = "lse depth 3 ttl",
 	[NPC_MPLS4_LBTCBOS] = "lse depth 4 label tc bos",
 	[NPC_MPLS4_TTL]     = "lse depth 4",
+	[NPC_TYPE_ICMP] = "icmp type",
+	[NPC_CODE_ICMP] = "icmp code",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
@@ -526,6 +528,8 @@ do {									       \
 	NPC_SCAN_HDR(NPC_DPORT_TCP, NPC_LID_LD, NPC_LT_LD_TCP, 2, 2);
 	NPC_SCAN_HDR(NPC_SPORT_SCTP, NPC_LID_LD, NPC_LT_LD_SCTP, 0, 2);
 	NPC_SCAN_HDR(NPC_DPORT_SCTP, NPC_LID_LD, NPC_LT_LD_SCTP, 2, 2);
+	NPC_SCAN_HDR(NPC_TYPE_ICMP, NPC_LID_LD, NPC_LT_LD_ICMP, 0, 1);
+	NPC_SCAN_HDR(NPC_CODE_ICMP, NPC_LID_LD, NPC_LT_LD_ICMP, 1, 1);
 	NPC_SCAN_HDR(NPC_ETYPE_ETHER, NPC_LID_LA, NPC_LT_LA_ETHER, 12, 2);
 	NPC_SCAN_HDR(NPC_ETYPE_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 4, 2);
 	NPC_SCAN_HDR(NPC_ETYPE_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 8, 2);
@@ -555,7 +559,7 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u64 *features = &mcam->rx_features;
-	u64 tcp_udp_sctp;
+	u64 proto_flags;
 	int hdr;
 
 	if (is_npc_intf_tx(intf))
@@ -566,18 +570,21 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 			*features |= BIT_ULL(hdr);
 	}
 
-	tcp_udp_sctp = BIT_ULL(NPC_SPORT_TCP) | BIT_ULL(NPC_SPORT_UDP) |
+	proto_flags = BIT_ULL(NPC_SPORT_TCP) | BIT_ULL(NPC_SPORT_UDP) |
 		       BIT_ULL(NPC_DPORT_TCP) | BIT_ULL(NPC_DPORT_UDP) |
-		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP);
+		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
+		       BIT_ULL(NPC_SPORT_SCTP) | BIT_ULL(NPC_DPORT_SCTP) |
+		       BIT_ULL(NPC_TYPE_ICMP) | BIT_ULL(NPC_CODE_ICMP);
 
 	/* for tcp/udp/sctp corresponding layer type should be in the key */
-	if (*features & tcp_udp_sctp) {
+	if (*features & proto_flags) {
 		if (!npc_check_field(rvu, blkaddr, NPC_LD, intf))
-			*features &= ~tcp_udp_sctp;
+			*features &= ~proto_flags;
 		else
 			*features |= BIT_ULL(NPC_IPPROTO_TCP) |
 				     BIT_ULL(NPC_IPPROTO_UDP) |
-				     BIT_ULL(NPC_IPPROTO_SCTP);
+				     BIT_ULL(NPC_IPPROTO_SCTP) |
+				     BIT_ULL(NPC_IPPROTO_ICMP);
 	}
 
 	/* for AH/ICMP/ICMPv6/, check if corresponding layer type is present in the key */
@@ -971,6 +978,10 @@ do {									      \
 		       ntohs(mask->sport), 0);
 	NPC_WRITE_FLOW(NPC_DPORT_SCTP, dport, ntohs(pkt->dport), 0,
 		       ntohs(mask->dport), 0);
+	NPC_WRITE_FLOW(NPC_TYPE_ICMP, icmp_type, pkt->icmp_type, 0,
+		       mask->icmp_type, 0);
+	NPC_WRITE_FLOW(NPC_CODE_ICMP, icmp_code, pkt->icmp_code, 0,
+		       mask->icmp_code, 0);
 
 	NPC_WRITE_FLOW(NPC_IPSEC_SPI, spi, ntohl(pkt->spi), 0,
 		       ntohl(mask->spi), 0);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 8a5e3987a482..10657a7559d7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -522,6 +522,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
 	      BIT(FLOW_DISSECTOR_KEY_IPSEC) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_MPLS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ICMP) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))))  {
 		netdev_info(nic->netdev, "unsupported flow used key 0x%llx",
 			    dissector->used_keys);
@@ -796,6 +797,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		}
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ICMP)) {
+		struct flow_match_icmp match;
+
+		flow_rule_match_icmp(rule, &match);
+
+		flow_spec->icmp_type = match.key->type;
+		flow_mask->icmp_type = match.mask->type;
+		req->features |= BIT_ULL(NPC_TYPE_ICMP);
+
+		flow_spec->icmp_code = match.key->code;
+		flow_mask->icmp_code = match.mask->code;
+		req->features |= BIT_ULL(NPC_CODE_ICMP);
+	}
 	return otx2_tc_parse_actions(nic, &rule->action, req, f, node);
 }
 
-- 
2.25.1

