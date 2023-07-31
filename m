Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7127694FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGaLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjGaLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:35:07 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C810C1;
        Mon, 31 Jul 2023 04:35:03 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36UNIc32012062;
        Mon, 31 Jul 2023 04:34:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=rwYjoK+wb+CQ5fgWspTLi2yMGbffC5+/B4dizAAuhNw=;
 b=GqstEKni9UKRykTtmoidEyZjOMs53F//N5l0oKHSiGy5WGzP/yiiHt0EOfq78qbs5kvI
 x5u2zgpVsF0z+SAn6jHRBhMLbdv8RSSu08MrDRTb+jcQBxI0uoHx5WX55D7N5QPaQFUa
 cTMYIDAK8FmCzUpWejpZkLNpJjSn/j619bNEaXoKLLi7ZBBaSIBS9qq6gUi0IgejcixU
 kmwkGb68KJBeT6RXej2VYpI3M1YXXpeoi9ygBcMepVu9ReTSlHpsNCsG9nIy+njzzH/i
 BFYy1/xHX3fI56IV4pj7sSpZcJ0fppbZeAmB26770P8xLnFbFAZ3KEfeAodfQUSzMITM hg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s529k4qh3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 04:34:55 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 04:34:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 31 Jul 2023 04:34:51 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 0CAA43F70B7;
        Mon, 31 Jul 2023 04:34:46 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next 4/4] octeontx2-pf: TC flower offload support for SPI field
Date:   Mon, 31 Jul 2023 17:04:08 +0530
Message-ID: <20230731113408.2586913-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731113408.2586913-1-rkannoth@marvell.com>
References: <20230731113408.2586913-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lun4bGcLY4GP7CI685wcX9-dNilUlNqS
X-Proofpoint-ORIG-GUID: lun4bGcLY4GP7CI685wcX9-dNilUlNqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_05,2023-07-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver support to offload TC flower rules which matches
against SPI field of IPSEC packets (AH/ESP).

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 +++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  1 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  4 +++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 11 ++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 27 +++++++++++++++++++
 5 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index ed66c5989102..a8f3c8faf8af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1451,6 +1451,10 @@ struct flow_msg {
 		__be32 ip4dst;
 		__be32 ip6dst[4];
 	};
+	union {
+		__be32 spi;
+	};
+
 	u8 tos;
 	u8 ip_ver;
 	u8 ip_proto;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index 9beeead56d7b..534f20c0c5df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -204,6 +204,7 @@ enum key_fields {
 	NPC_DPORT_UDP,
 	NPC_SPORT_SCTP,
 	NPC_DPORT_SCTP,
+	NPC_IPSEC_SPI,
 	NPC_HEADER_FIELDS_MAX,
 	NPC_CHAN = NPC_HEADER_FIELDS_MAX, /* Valid when Rx */
 	NPC_PF_FUNC, /* Valid when Tx */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 3b26893efdf8..7cd33edca365 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2827,6 +2827,10 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "%d ", ntohs(rule->packet.dport));
 			seq_printf(s, "mask 0x%x\n", ntohs(rule->mask.dport));
 			break;
+		case NPC_IPSEC_SPI:
+			seq_printf(s, "0x%x ", ntohl(rule->packet.spi));
+			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.spi));
+			break;
 		default:
 			seq_puts(s, "\n");
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 9c365cc3e736..bb715e616fad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -41,6 +41,7 @@ static const char * const npc_flow_names[] = {
 	[NPC_SPORT_SCTP] = "sctp source port",
 	[NPC_DPORT_SCTP] = "sctp destination port",
 	[NPC_LXMB]	= "Mcast/Bcast header ",
+	[NPC_IPSEC_SPI] = "SPI ",
 	[NPC_UNKNOWN]	= "unknown",
 };
 
@@ -513,6 +514,10 @@ do {									       \
 	NPC_SCAN_HDR(NPC_VLAN_TAG1, NPC_LID_LB, NPC_LT_LB_CTAG, 2, 2);
 	NPC_SCAN_HDR(NPC_VLAN_TAG2, NPC_LID_LB, NPC_LT_LB_STAG_QINQ, 2, 2);
 	NPC_SCAN_HDR(NPC_DMAC, NPC_LID_LA, la_ltype, la_start, 6);
+
+	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LD, NPC_LT_LD_AH, 4, 4);
+	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LE, NPC_LT_LE_ESP, 0, 4);
+
 	/* SMAC follows the DMAC(which is 6 bytes) */
 	NPC_SCAN_HDR(NPC_SMAC, NPC_LID_LA, la_ltype, la_start + 6, 6);
 	/* PF_FUNC is 2 bytes at 0th byte of NPC_LT_LA_IH_NIX_ETHER */
@@ -564,6 +569,9 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
+	if (*features & (BIT_ULL(NPC_IPPROTO_AH) | BIT_ULL(NPC_IPPROTO_ESP)))
+		*features |= BIT_ULL(NPC_IPSEC_SPI);
+
 	/* for vlan ethertypes corresponding layer type should be in the key */
 	if (npc_check_field(rvu, blkaddr, NPC_LB, intf))
 		*features |= BIT_ULL(NPC_VLAN_ETYPE_CTAG) |
@@ -930,6 +938,9 @@ do {									      \
 	NPC_WRITE_FLOW(NPC_DPORT_SCTP, dport, ntohs(pkt->dport), 0,
 		       ntohs(mask->dport), 0);
 
+	NPC_WRITE_FLOW(NPC_IPSEC_SPI, spi, ntohl(pkt->spi), 0,
+		       ntohl(mask->spi), 0);
+
 	NPC_WRITE_FLOW(NPC_OUTER_VID, vlan_tci, ntohs(pkt->vlan_tci), 0,
 		       ntohs(mask->vlan_tci), 0);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5a44e9b96fc0..4bb511e3cbe5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -461,6 +461,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
+	      BIT(FLOW_DISSECTOR_KEY_IPSEC) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))))  {
 		netdev_info(nic->netdev, "unsupported flow used key 0x%llx",
 			    dissector->used_keys);
@@ -482,6 +483,8 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		     match.key->ip_proto != IPPROTO_UDP &&
 		     match.key->ip_proto != IPPROTO_SCTP &&
 		     match.key->ip_proto != IPPROTO_ICMP &&
+		     match.key->ip_proto != IPPROTO_ESP &&
+		     match.key->ip_proto != IPPROTO_AH &&
 		     match.key->ip_proto != IPPROTO_ICMPV6)) {
 			netdev_info(nic->netdev,
 				    "ip_proto=0x%x not supported\n",
@@ -501,6 +504,10 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 			req->features |= BIT_ULL(NPC_IPPROTO_ICMP);
 		else if (ip_proto == IPPROTO_ICMPV6)
 			req->features |= BIT_ULL(NPC_IPPROTO_ICMP6);
+		else if (ip_proto == IPPROTO_ESP)
+			req->features |= BIT_ULL(NPC_IPPROTO_ESP);
+		else if (ip_proto == IPPROTO_AH)
+			req->features |= BIT_ULL(NPC_IPPROTO_AH);
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
@@ -545,6 +552,26 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		}
 	}
 
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPSEC)) {
+		struct flow_match_ipsec match;
+
+		flow_rule_match_ipsec(rule, &match);
+		if (!match.mask->spi) {
+			NL_SET_ERR_MSG_MOD(extack, "spi index not specified");
+			return -EOPNOTSUPP;
+		}
+		if (ip_proto != IPPROTO_ESP &&
+		    ip_proto != IPPROTO_AH) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "SPI index is valid only for ESP/AH proto");
+			return -EOPNOTSUPP;
+		}
+
+		flow_spec->spi = match.key->spi;
+		flow_mask->spi = match.mask->spi;
+		req->features |= BIT_ULL(NPC_IPSEC_SPI);
+	}
+
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IP)) {
 		struct flow_match_ip match;
 
-- 
2.25.1

