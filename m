Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6D7A666B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjISOTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjISOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:19:02 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAFBE;
        Tue, 19 Sep 2023 07:18:55 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JDb4HF026717;
        Tue, 19 Sep 2023 07:18:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=P5UlX3E1s+XY9LyEfHq8Mz6BYuAJueMM/PbIL+Q0jmA=;
 b=fDVXMCxNTAgj2govAGyClkvN/BcTsDEO2mKMLR+pVtJvFXSZW9asRGBkH56ULUoOdqMZ
 9BPIjtZo+9DHFgu5sYGvsvQzINaAcY4kxiyJzvmgAA2h5UyLmVurL14YHSa6AhRgyqM0
 YJTvJBWCxEULg1Ir6W8a6tODh3gCh9JvCCK1+hYWQFHkBPVKYQu7lY1y7gh1/0WMWLjA
 AwcGIiTOjMpoZawAhiQPjWBZaiILh/dGDkKvGHEs2HL57Mhyp75i7BgGI2doyP2IasWT
 JXo9mIvHRLdFHS27XTzXCKkRRFpyXTyFSMEwiW6dvRd4uJX0J/28eZgu3U0lQfX6b3Z0 DQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3t5bvkrrb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:18:40 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Sep
 2023 07:18:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 19 Sep 2023 07:18:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 25E2A3F709B;
        Tue, 19 Sep 2023 07:18:33 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-net Patchv2] octeontx2-pf: Tc flower offload support for MPLS
Date:   Tue, 19 Sep 2023 19:48:32 +0530
Message-ID: <20230919141832.5931-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ga6Sc3IeB3ZuBgF78npX5pKrxRYK0g9e
X-Proofpoint-ORIG-GUID: ga6Sc3IeB3ZuBgF78npX5pKrxRYK0g9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends flower offload support for MPLS protocol.
Due to hardware limitation, currently driver supports lse
depth up to 4.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
v2 * instead of magic number 0xffffff00 use appropriate mask OTX2_FLOWER_MASK_MPLS_NON_TTL

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  6 ++
 .../net/ethernet/marvell/octeontx2/af/npc.h   |  8 +++
 .../marvell/octeontx2/af/rvu_debugfs.c        | 52 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         | 46 ++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 55 +++++++++++++++++++
 5 files changed, 167 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index c5bd7747fc0e..6845556581c3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1473,6 +1473,12 @@ struct flow_msg {
 		u8 next_header;
 	};
 	__be16 vlan_itci;
+#define OTX2_FLOWER_MASK_MPLS_LB		GENMASK(31, 12)
+#define OTX2_FLOWER_MASK_MPLS_TC		GENMASK(11, 9)
+#define OTX2_FLOWER_MASK_MPLS_BOS		BIT(8)
+#define OTX2_FLOWER_MASK_MPLS_TTL		GENMASK(7, 0)
+#define OTX2_FLOWER_MASK_MPLS_NON_TTL		GENMASK(31, 8)
+	u32 mpls_lse[4];
 };

 struct npc_install_flow_req {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index de9fbd98dfb7..ab3e39eef2eb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -206,6 +206,14 @@ enum key_fields {
 	NPC_SPORT_SCTP,
 	NPC_DPORT_SCTP,
 	NPC_IPSEC_SPI,
+	NPC_MPLS1_LBTCBOS,
+	NPC_MPLS1_TTL,
+	NPC_MPLS2_LBTCBOS,
+	NPC_MPLS2_TTL,
+	NPC_MPLS3_LBTCBOS,
+	NPC_MPLS3_TTL,
+	NPC_MPLS4_LBTCBOS,
+	NPC_MPLS4_TTL,
 	NPC_HEADER_FIELDS_MAX,
 	NPC_CHAN = NPC_HEADER_FIELDS_MAX, /* Valid when Rx */
 	NPC_PF_FUNC, /* Valid when Tx */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index d30e84803481..e71c3da52cfd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2756,6 +2756,26 @@ static int rvu_dbg_npc_rx_miss_stats_display(struct seq_file *filp,

 RVU_DEBUG_SEQ_FOPS(npc_rx_miss_act, npc_rx_miss_stats_display, NULL);

+#define RVU_DBG_PRINT_MPLS_TTL(pkt, mask)                                                  \
+do {											   \
+	seq_printf(s, "%ld ", FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, pkt));                  \
+	seq_printf(s, "mask 0x%lx\n", FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, mask));         \
+} while (0)                                                                                \
+
+#define RVU_DBG_PRINT_MPLS_LBTCBOS(_pkt, _mask)                                            \
+do {										           \
+	typeof(_pkt) (pkt) = (_pkt);							   \
+	typeof(_mask) (mask) = (_mask);                                                    \
+	seq_printf(s, "%ld %ld %ld\n",                                        \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_LB, pkt),                               \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_TC, pkt),                               \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_BOS, pkt));                             \
+	seq_printf(s, "\tmask 0x%lx 0x%lx 0x%lx\n",                           \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_LB, mask),                              \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_TC, mask),                              \
+		   FIELD_GET(OTX2_FLOWER_MASK_MPLS_BOS, mask));                            \
+} while (0)                                                                                \
+
 static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 					struct rvu_npc_mcam_rule *rule)
 {
@@ -2836,6 +2856,38 @@ static void rvu_dbg_npc_mcam_show_flows(struct seq_file *s,
 			seq_printf(s, "0x%x ", ntohl(rule->packet.spi));
 			seq_printf(s, "mask 0x%x\n", ntohl(rule->mask.spi));
 			break;
+		case NPC_MPLS1_LBTCBOS:
+			RVU_DBG_PRINT_MPLS_LBTCBOS(rule->packet.mpls_lse[0],
+						   rule->mask.mpls_lse[0]);
+			break;
+		case NPC_MPLS1_TTL:
+			RVU_DBG_PRINT_MPLS_TTL(rule->packet.mpls_lse[0],
+					       rule->mask.mpls_lse[0]);
+			break;
+		case NPC_MPLS2_LBTCBOS:
+			RVU_DBG_PRINT_MPLS_LBTCBOS(rule->packet.mpls_lse[1],
+						   rule->mask.mpls_lse[1]);
+			break;
+		case NPC_MPLS2_TTL:
+			RVU_DBG_PRINT_MPLS_TTL(rule->packet.mpls_lse[1],
+					       rule->mask.mpls_lse[1]);
+			break;
+		case NPC_MPLS3_LBTCBOS:
+			RVU_DBG_PRINT_MPLS_LBTCBOS(rule->packet.mpls_lse[2],
+						   rule->mask.mpls_lse[2]);
+			break;
+		case NPC_MPLS3_TTL:
+			RVU_DBG_PRINT_MPLS_TTL(rule->packet.mpls_lse[2],
+					       rule->mask.mpls_lse[2]);
+			break;
+		case NPC_MPLS4_LBTCBOS:
+			RVU_DBG_PRINT_MPLS_LBTCBOS(rule->packet.mpls_lse[3],
+						   rule->mask.mpls_lse[3]);
+			break;
+		case NPC_MPLS4_TTL:
+			RVU_DBG_PRINT_MPLS_TTL(rule->packet.mpls_lse[3],
+					       rule->mask.mpls_lse[3]);
+			break;
 		default:
 			seq_puts(s, "\n");
 			break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 237f82082ebe..8c3c1a1e10a6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -43,6 +43,14 @@ static const char * const npc_flow_names[] = {
 	[NPC_DPORT_SCTP] = "sctp destination port",
 	[NPC_LXMB]	= "Mcast/Bcast header ",
 	[NPC_IPSEC_SPI] = "SPI ",
+	[NPC_MPLS1_LBTCBOS] = "lse depth 1 label tc bos",
+	[NPC_MPLS1_TTL]     = "lse depth 1 ttl",
+	[NPC_MPLS2_LBTCBOS] = "lse depth 2 label tc bos",
+	[NPC_MPLS2_TTL]     = "lse depth 2 ttl",
+	[NPC_MPLS3_LBTCBOS] = "lse depth 3 label tc bos",
+	[NPC_MPLS3_TTL]     = "lse depth 3 ttl",
+	[NPC_MPLS4_LBTCBOS] = "lse depth 4 label tc bos",
+	[NPC_MPLS4_TTL]     = "lse depth 4",
 	[NPC_UNKNOWN]	= "unknown",
 };

@@ -528,6 +536,14 @@ do {									       \

 	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LD, NPC_LT_LD_AH, 4, 4);
 	NPC_SCAN_HDR(NPC_IPSEC_SPI, NPC_LID_LE, NPC_LT_LE_ESP, 0, 4);
+	NPC_SCAN_HDR(NPC_MPLS1_LBTCBOS, NPC_LID_LC, NPC_LT_LC_MPLS, 0, 3);
+	NPC_SCAN_HDR(NPC_MPLS1_TTL, NPC_LID_LC, NPC_LT_LC_MPLS, 3, 1);
+	NPC_SCAN_HDR(NPC_MPLS2_LBTCBOS, NPC_LID_LC, NPC_LT_LC_MPLS, 4, 3);
+	NPC_SCAN_HDR(NPC_MPLS2_TTL, NPC_LID_LC, NPC_LT_LC_MPLS, 7, 1);
+	NPC_SCAN_HDR(NPC_MPLS3_LBTCBOS, NPC_LID_LC, NPC_LT_LC_MPLS, 8, 3);
+	NPC_SCAN_HDR(NPC_MPLS3_TTL, NPC_LID_LC, NPC_LT_LC_MPLS, 11, 1);
+	NPC_SCAN_HDR(NPC_MPLS4_LBTCBOS, NPC_LID_LC, NPC_LT_LC_MPLS, 12, 3);
+	NPC_SCAN_HDR(NPC_MPLS4_TTL, NPC_LID_LC, NPC_LT_LC_MPLS, 15, 1);

 	/* SMAC follows the DMAC(which is 6 bytes) */
 	NPC_SCAN_HDR(NPC_SMAC, NPC_LID_LA, la_ltype, la_start + 6, 6);
@@ -593,6 +609,11 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 	/* for L2M/L2B/L3M/L3B, check if the type is present in the key */
 	if (npc_check_field(rvu, blkaddr, NPC_LXMB, intf))
 		*features |= BIT_ULL(NPC_LXMB);
+
+	for (hdr = NPC_MPLS1_LBTCBOS; hdr <= NPC_MPLS4_TTL; hdr++) {
+		if (npc_check_field(rvu, blkaddr, hdr, intf))
+			*features |= BIT_ULL(hdr);
+	}
 }

 /* Scan key extraction profile and record how fields of our interest
@@ -959,6 +980,31 @@ do {									      \
 	NPC_WRITE_FLOW(NPC_INNER_VID, vlan_itci, ntohs(pkt->vlan_itci), 0,
 		       ntohs(mask->vlan_itci), 0);

+	NPC_WRITE_FLOW(NPC_MPLS1_LBTCBOS, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, pkt->mpls_lse[0]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, mask->mpls_lse[0]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS1_TTL, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, pkt->mpls_lse[0]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, mask->mpls_lse[0]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS2_LBTCBOS, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, pkt->mpls_lse[1]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, mask->mpls_lse[1]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS2_TTL, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, pkt->mpls_lse[1]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, mask->mpls_lse[1]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS3_LBTCBOS, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, pkt->mpls_lse[2]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, mask->mpls_lse[2]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS3_TTL, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, pkt->mpls_lse[2]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, mask->mpls_lse[2]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS4_LBTCBOS, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, pkt->mpls_lse[3]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_NON_TTL, mask->mpls_lse[3]), 0);
+	NPC_WRITE_FLOW(NPC_MPLS4_TTL, mpls_lse,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, pkt->mpls_lse[3]), 0,
+		       FIELD_GET(OTX2_FLOWER_MASK_MPLS_TTL, mask->mpls_lse[3]), 0);
+
 	NPC_WRITE_FLOW(NPC_IPFRAG_IPV6, next_header, pkt->next_header, 0,
 		       mask->next_header, 0);
 	npc_update_ipv6_flow(rvu, entry, features, pkt, mask, output, intf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index fab9d85bfb37..95e6a58ba087 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -27,6 +27,8 @@
 #define CN10K_TLX_BURST_MANTISSA	GENMASK_ULL(43, 29)
 #define CN10K_TLX_BURST_EXPONENT	GENMASK_ULL(47, 44)

+#define OTX2_UNSUPP_LSE_DEPTH		GENMASK(6, 4)
+
 struct otx2_tc_flow_stats {
 	u64 bytes;
 	u64 pkts;
@@ -519,6 +521,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS) |
 	      BIT(FLOW_DISSECTOR_KEY_IPSEC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_MPLS) |
 	      BIT_ULL(FLOW_DISSECTOR_KEY_IP))))  {
 		netdev_info(nic->netdev, "unsupported flow used key 0x%llx",
 			    dissector->used_keys);
@@ -738,6 +741,58 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		}
 	}

+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_MPLS)) {
+		struct flow_match_mpls match;
+		u8 bit;
+
+		flow_rule_match_mpls(rule, &match);
+
+		if (match.mask->used_lses & OTX2_UNSUPP_LSE_DEPTH) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "unsupported LSE depth for MPLS match offload");
+			return -EOPNOTSUPP;
+		}
+
+		for_each_set_bit(bit, (unsigned long *)&match.mask->used_lses,
+				 FLOW_DIS_MPLS_MAX)  {
+			/* check if any of the fields LABEL,TC,BOS are set */
+			if (*((u32 *)&match.mask->ls[bit]) &
+			    OTX2_FLOWER_MASK_MPLS_NON_TTL) {
+				/* Hardware will capture 4 byte MPLS header into two
+				 * fields NPC_MPLSX_LBTCBOS and NPC_MPLSX_TTL. Derive
+				 * the associated NPC key based on header index and offset.
+				 */
+
+				req->features |= BIT_ULL(NPC_MPLS1_LBTCBOS + 2 * bit);
+				flow_spec->mpls_lse[bit] =
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_LB,
+						   match.key->ls[bit].mpls_label) |
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_TC,
+						   match.key->ls[bit].mpls_tc) |
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_BOS,
+						   match.key->ls[bit].mpls_bos);
+
+				flow_mask->mpls_lse[bit] =
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_LB,
+						   match.mask->ls[bit].mpls_label) |
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_TC,
+						   match.mask->ls[bit].mpls_tc) |
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_BOS,
+						   match.mask->ls[bit].mpls_bos);
+			}
+
+			if (match.mask->ls[bit].mpls_ttl) {
+				req->features |= BIT_ULL(NPC_MPLS1_TTL + 2 * bit);
+				flow_spec->mpls_lse[bit] |=
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_TTL,
+						   match.key->ls[bit].mpls_ttl);
+				flow_mask->mpls_lse[bit] |=
+					FIELD_PREP(OTX2_FLOWER_MASK_MPLS_TTL,
+						   match.mask->ls[bit].mpls_ttl);
+			}
+		}
+	}
+
 	return otx2_tc_parse_actions(nic, &rule->action, req, f, node);
 }

--
2.17.1
