Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832A3804BC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346376AbjLEIEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbjLEIEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:04:48 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24213182;
        Tue,  5 Dec 2023 00:04:53 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B56OiaW010820;
        Tue, 5 Dec 2023 00:04:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=4/EJjnZQiTFxwclrmIru9Na3yETFt2PBTXVIDWgANy8=;
 b=L1joF3jucX9h61VhEQfxnCVPLJu8mjkGxM44O/68LKNJwFyPoe5zz2RWYqxKtE696SE7
 DJ+aboV8jDFR7Oyx+j2KST1CsoRNw2DuBYzl4CcVCUsAILsNXvzKDDFXI8nocWxPPdDF
 Yq2EWlBOR7bFkBfGU2wHvErXawKaCCyQ/CLSlKtPai+6HIcXNmbKmXKFzOjCFLEQEEwb
 Ikrjb+5+7riyNRl/N32XnZxDL5yS+8rwunMdLJYMWk9cxNGuFfKTvXdBvbyyeqw58rTV
 tOAlcPh3QUle+ZyIysthjzpCpQ+FhlJfRj9rwLyrDlTXS1gz3UVkqzc0UiyUDm35oQj4 Zw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ur4yrrq4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 00:04:46 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Dec
 2023 00:04:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Dec 2023 00:04:43 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 4EE133F70A9;
        Tue,  5 Dec 2023 00:04:40 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net v4 PATCH 1/5] octeontx2-af: Adjust Tx credits when MCS external bypass is disabled
Date:   Tue, 5 Dec 2023 13:34:30 +0530
Message-ID: <20231205080434.27604-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231205080434.27604-1-gakula@marvell.com>
References: <20231205080434.27604-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: zPJpKYa0quyVhPdgOiiNuY1z453BKYbc
X-Proofpoint-ORIG-GUID: zPJpKYa0quyVhPdgOiiNuY1z453BKYbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
v3-v4:
 Used FIELD_PREP macro and proper data types.

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c    | 14 +++++++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mcs.h    |  2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  8 ++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |  1 +
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index c43f19dfbd74..bd87507cf8ea 100644
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
@@ -1436,7 +1447,7 @@ static int mcs_x2p_calibration(struct mcs *mcs)
 	return err;
 }
 
-static void mcs_set_external_bypass(struct mcs *mcs, u8 bypass)
+static void mcs_set_external_bypass(struct mcs *mcs, bool bypass)
 {
 	u64 val;
 
@@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs *mcs, u8 bypass)
 	else
 		val &= ~BIT_ULL(6);
 	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
+	mcs->bypass = bypass;
 }
 
 static void mcs_global_cfg(struct mcs *mcs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
index 0f89dcb76465..f927cc61dfd2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.h
@@ -149,6 +149,7 @@ struct mcs {
 	u16			num_vec;
 	void			*rvu;
 	u16			*tx_sa_active;
+	bool                      bypass;
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
index c4d999ef5ab4..cce2806aaa50 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -345,6 +345,7 @@ struct nix_hw {
 	struct nix_txvlan txvlan;
 	struct nix_ipolicer *ipolicer;
 	u64    *tx_credits;
+	u8	cc_mcs_cnt;
 };
 
 /* RVU block's capabilities or functionality,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index c112c71ff576..4227ebb4a758 100644
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
@@ -4389,6 +4390,12 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
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
@@ -4412,6 +4419,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 			tx_credits = (lmac_fifo_len - lmac_max_frs) / 16;
 			/* Enable credits and set credit pkt count to max allowed */
 			cfg =  (tx_credits << 12) | (0x1FF << 2) | BIT_ULL(1);
+			cfg |= FIELD_PREP(NIX_AF_LINKX_MCS_CNT_MASK, nix_hw->cc_mcs_cnt);
 
 			link = iter + slink;
 			nix_hw->tx_credits[link] = tx_credits;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index b42e631e52d0..18c1c9f361cc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -437,6 +437,7 @@
 
 #define NIX_AF_LINKX_BASE_MASK		GENMASK_ULL(11, 0)
 #define NIX_AF_LINKX_RANGE_MASK		GENMASK_ULL(19, 16)
+#define NIX_AF_LINKX_MCS_CNT_MASK	GENMASK_ULL(33, 32)
 
 /* SSO */
 #define SSO_AF_CONST			(0x1000)
-- 
2.25.1

