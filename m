Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00223754E04
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGPJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGPJQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:16:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48175B3;
        Sun, 16 Jul 2023 02:16:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G72Ow8021300;
        Sun, 16 Jul 2023 02:16:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=JMjcmj3GAtg0PbK9U+OmxFqsRl972SPwaIqe4QJyic8=;
 b=Q0uhTG7LG8VFZOAdSXCOT4EFjKqv600oU4oUcOTSk4uBqIP+L07QLNd+iyYC/791DUxM
 +uXspEZd/Xv98zPmswR/77cItg9V5Rt3BzPPDacYKAf70+h7EWiKAsbPJ2BjmEW+uOmF
 ENPnpyg78hmi/k45A+b2gG0Ai436I1N+B4OB6ID2jSbZPlQwORY0XxY0lTO4kHEOgByS
 gpF1pR2vX/gsCDIsN2JHllOXDg+RwEv03hu9COGN8SMJkqEr8AxVshfDPyFAM8DkFWOh
 I0ThI9zCQ7q0JQrFjD5ch343nrHdEzV0uXPit1wF/C7VFKkcSeh3zhyLBvTnr/YBrhfM Zg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rutygskkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 02:16:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 16 Jul
 2023 02:16:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 16 Jul 2023 02:16:26 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id F22F93F7040;
        Sun, 16 Jul 2023 02:16:22 -0700 (PDT)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <ndabilpuram@marvell.com>
Subject: [net PATCH] octeontx2-af: Adjust Tx credits when MCS external bypass is disabled
Date:   Sun, 16 Jul 2023 14:46:21 +0530
Message-ID: <20230716091621.27844-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: r6OVoxcOUsMtZbvD4hAYCdNH2ZdBmP8B
X-Proofpoint-ORIG-GUID: r6OVoxcOUsMtZbvD4hAYCdNH2ZdBmP8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

When MCS external bypass is disabled, MCS returns additional
2 credits(32B) for every packet Tx'ed on LMAC. To account for
these extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
needs to be configured as otherwise NIX Tx credits would overflow
and will never be returned to idle state credit count
causing issues with credit control and MTU change.

This patch fixes the same by configuring CC_MCS_CNT at probe
time for MCS enabled SoC's

Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h    |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index eba307eee2b2..d78d72c0ca18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1914,7 +1914,7 @@ struct mcs_hw_info {
 	u8 tcam_entries;	/* RX/TX Tcam entries per mcs block */
 	u8 secy_entries;	/* RX/TX SECY entries per mcs block */
 	u8 sc_entries;		/* RX/TX SC CAM entries per mcs block */
-	u8 sa_entries;		/* PN table entries = SA entries */
+	u16 sa_entries;		/* PN table entries = SA entries */
 	u64 rsvd[16];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index c43f19dfbd74..d6effbe46208 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -1219,6 +1219,17 @@ struct mcs *mcs_get_pdata(int mcs_id)
 	return NULL;
 }
 
+bool is_mcs_bypass(int mcs_id)
+{
+	struct mcs *mcs_dev;
+
+	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
+		if (mcs_dev->mcs_id == mcs_id)
+			return mcs_dev->bypass;
+	}
+	return true;
+}
+
 void mcs_set_port_cfg(struct mcs *mcs, struct mcs_port_cfg_set_req *req)
 {
 	u64 val = 0;
@@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs *mcs, u8 bypass)
 	else
 		val &= ~BIT_ULL(6);
 	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
+	mcs->bypass = bypass;
 }
 
 static void mcs_global_cfg(struct mcs *mcs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
index 0f89dcb76465..ccd43c3f3460 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
@@ -149,6 +149,7 @@ struct mcs {
 	u16			num_vec;
 	void			*rvu;
 	u16			*tx_sa_active;
+	u8                      bypass;
 };
 
 struct mcs_ops {
@@ -206,6 +207,7 @@ void mcs_get_custom_tag_cfg(struct mcs *mcs, struct mcs_custom_tag_cfg_get_req *
 int mcs_alloc_ctrlpktrule(struct rsrc_bmap *rsrc, u16 *pf_map, u16 offset, u16 pcifunc);
 int mcs_free_ctrlpktrule(struct mcs *mcs, struct mcs_free_ctrl_pkt_rule_req *req);
 int mcs_ctrlpktrule_write(struct mcs *mcs, struct mcs_ctrl_pkt_rule_write_req *req);
+bool is_mcs_bypass(int mcs_id);
 
 /* CN10K-B APIs */
 void cn10kb_mcs_set_hw_capabilities(struct mcs *mcs);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e8e65fd7888d..1efa77a368ee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -343,6 +343,7 @@ struct nix_hw {
 	struct nix_txvlan txvlan;
 	struct nix_ipolicer *ipolicer;
 	u64    *tx_credits;
+	u64 cc_mcs_cnt;
 };
 
 /* RVU block's capabilities or functionality,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 04b0e885f9d2..63d6b6dbd8e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -12,6 +12,7 @@
 #include "rvu_reg.h"
 #include "rvu.h"
 #include "npc.h"
+#include "mcs.h"
 #include "cgx.h"
 #include "lmac_common.h"
 #include "rvu_npc_hash.h"
@@ -4371,6 +4372,12 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
 	}
 
+	/* Get MCS external bypass status for CN10K-B */
+	if (mcs_get_blkcnt() == 1) {
+		/* Adjust for 2 credits when external bypass is disabled */
+		nix_hw->cc_mcs_cnt = is_mcs_bypass(0) ? 0 : 2;
+	}
+
 	/* Set credits for Tx links assuming max packet length allowed.
 	 * This will be reconfigured based on MTU set for PF/VF.
 	 */
@@ -4394,6 +4401,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 			tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;
 			/* Enable credits and set credit pkt count to max allowed */
 			cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
+			cfg |= (nix_hw->cc_mcs_cnt << 32);
 
 			link = iter + slink;
 			nix_hw->tx_credits[link] = tx_credits;
-- 
2.25.1

