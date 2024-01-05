Return-Path: <linux-kernel+bounces-17822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EBD825335
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA791F23845
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA322D039;
	Fri,  5 Jan 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TMpxx2RU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9E2D601;
	Fri,  5 Jan 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4054bI95004588;
	Fri, 5 Jan 2024 04:02:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=6sU5GxlK76ndUKi2361U/O6LtYlGS3aaQIWSH2fN1ig=; b=TMp
	xx2RUTpG/hU58asUNkoyajWsG/kYsnkEKwzXwi7d0tUsvV0nNPBiMnjJWHBKqJRz
	Ucx51DqudNvCQYJbupawk94q2zZxv42t8MtCxCcAy9JKmQaaU/Ft4x5AHdtXEsEy
	JrBln33aCVzfk6g3+4ii/bss4O2ZoZo8x+cDysyg1E8sfKyRWwPuIvDbob0Z/f1g
	leidiNZt1pYr5OWRUh/DxyNs9pnUjh/dj1n/rPdkxMsoy83NoBNc6fmMrNQSM8Xm
	aHBWUKE9MQWJ+dBOig/BOPRF0sW/67fUr8y9GfPVkPUo9Sl/1i/mnO7pYwi1R3Dj
	L/PgOboyyxbwlJYXvfg==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3veaw014hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 04:02:53 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 04:02:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 5 Jan 2024 04:02:51 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 861A83F7091;
	Fri,  5 Jan 2024 04:02:48 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-pf: Add support for offload tc with skbedit mark action
Date: Fri, 5 Jan 2024 17:32:47 +0530
Message-ID: <20240105120247.14975-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: gXxI_aJTxv4kpC8oPZBqBj0QfnQQsdea
X-Proofpoint-ORIG-GUID: gXxI_aJTxv4kpC8oPZBqBj0QfnQQsdea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Support offloading of skbedit mark action.

For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
interface:

 # tc qdisc add dev eth2 ingress
 # tc filter add dev eth2 ingress protocol ip flower \
      dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c  |  2 ++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  2 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  |  3 +++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h  |  3 +++
 5 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index c75669c8fde7..6188921e9a20 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1183,6 +1183,8 @@ static int npc_update_rx_entry(struct rvu *rvu, struct rvu_pfvf *pfvf,
 			action.pf_func = target;
 			action.op = NIX_RX_ACTIONOP_UCAST;
 		}
+		if (req->match_id)
+			action.match_id = req->match_id;
 	}
 
 	entry->action = *(u64 *)&action;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 06910307085e..815ae13c371c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -363,6 +363,7 @@ struct otx2_flow_config {
 	struct list_head	flow_list;
 	u32			dmacflt_max_flows;
 	u16                     max_flows;
+	u16			mark_flows;
 	struct list_head	flow_list_tc;
 	bool			ntuple;
 };
@@ -465,6 +466,7 @@ struct otx2_nic {
 #define OTX2_FLAG_DMACFLTR_SUPPORT		BIT_ULL(14)
 #define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
 #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
+#define OTX2_FLAG_TC_MARK_ENABLED		BIT_ULL(17)
 	u64			flags;
 	u64			*cq_op_addr;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 4fd44b6eecea..fd1d78601811 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -511,7 +511,15 @@ static int otx2_tc_parse_actions(struct otx2_nic *nic,
 			nr_police++;
 			break;
 		case FLOW_ACTION_MARK:
+			if (act->mark & ~OTX2_RX_MATCH_ID_MASK) {
+				NL_SET_ERR_MSG_MOD(extack, "Bad flow mark, only 16 bit supported");
+				return -EOPNOTSUPP;
+			}
 			mark = act->mark;
+			req->match_id = mark & 0xFFFFULL;
+			req->op = NIX_RX_ACTION_DEFAULT;
+			nic->flags |= OTX2_FLAG_TC_MARK_ENABLED;
+			nic->flow_cfg->mark_flows++;
 			break;
 
 		case FLOW_ACTION_RX_QUEUE_MAPPING:
@@ -1173,6 +1181,11 @@ static int otx2_tc_del_flow(struct otx2_nic *nic,
 		return -EINVAL;
 	}
 
+	/* Disable TC MARK flag if they are no rules with skbedit mark action */
+	if (flow_node->req.match_id)
+		if (!(--flow_cfg->mark_flows))
+			nic->flags &= ~OTX2_FLAG_TC_MARK_ENABLED;
+
 	if (flow_node->is_act_police) {
 		__clear_bit(flow_node->rq, &nic->rq_bmap);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 4d519ea833b2..d3c9759c9f06 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -380,6 +380,9 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	if (pfvf->netdev->features & NETIF_F_RXCSUM)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
+		skb->mark = parse->match_id;
+
 	skb_mark_for_recycle(skb);
 
 	napi_gro_frags(napi);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index a82ffca8ce1b..3f1d2655ff77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -62,6 +62,9 @@
 #define CQ_OP_STAT_OP_ERR       63
 #define CQ_OP_STAT_CQ_ERR       46
 
+/* Packet mark mask */
+#define OTX2_RX_MATCH_ID_MASK 0x0000ffff
+
 struct queue_stats {
 	u64	bytes;
 	u64	pkts;
-- 
2.25.1


