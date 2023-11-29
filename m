Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7677FD56E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjK2LWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjK2LWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:03 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202ED10C2;
        Wed, 29 Nov 2023 03:22:10 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT5mUWY021197;
        Wed, 29 Nov 2023 03:22:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=goRdS9UMaJBeT5oWbOCmVW3K6Sjac2xOWln0Bp2z3kY=;
 b=AqYmxBs47KVWy0F4VBI7EWs78M5VEc73Rdn/h+4EdcKYzmjwjMKXOFA38K5BZwVM3jdf
 BlUtxq0MucMcaRBDFb7jL+4EMLOgI8MjYtRW0Jo2jphZhu750v+0imszfcx6fBEs6kDO
 +Xj9Nrh4l7A+HDF6Oi7uxRtM6xHJeS0Mvg8YdMALYiwRQKsypoJ+w72aXjzHHQ1TgSvh
 WuQFiSmTTjQRfyBBJynH4PZx5E6Gh8qq1s3ICQIptw1qjFREEvvXeABDsZLqx4PtUaiL
 tMvAe/cnUF4Zw+eDDABlgqrvK+T7RiJOI7OgWPjs6/TXxGcSj/YyGroBEDBNqEdoWiUC UQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3unn86b0rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Nov 2023 03:22:02 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 03:22:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 29 Nov 2023 03:22:00 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id A52B93F7043;
        Wed, 29 Nov 2023 03:21:56 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <pbhagavatula@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH] octeontx2-af: cn10k: Increase outstanding LMTST transactions
Date:   Wed, 29 Nov 2023 16:51:55 +0530
Message-ID: <20231129112155.9967-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jxezCW60v_vy7GIaYNQeW7MqtHlOe9Rv
X-Proofpoint-GUID: jxezCW60v_vy7GIaYNQeW7MqtHlOe9Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Currently the number of outstanding store transactions issued by AP as
a part of LMTST operation is set to 1 i.e default value.
This patch set to max supported value to increase the performance.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c       | 3 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h       | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 9 +++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 22c395c7d040..14bb91b98f97 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -935,6 +935,9 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	hw->total_vfs = (cfg >> 20) & 0xFFF;
 	hw->max_vfs_per_pf = (cfg >> 40) & 0xFF;
 
+	if (!is_rvu_otx2(rvu))
+		rvu_apr_block_cn10k_init(rvu);
+
 	/* Init NPA LF's bitmap */
 	block = &hw->block[BLKADDR_NPA];
 	if (!block->implemented)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index c4d999ef5ab4..6546cc489d7e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -940,6 +940,7 @@ void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw);
 
 /* CN10K RVU - LMT*/
 void rvu_reset_lmt_map_tbl(struct rvu *rvu, u16 pcifunc);
+void rvu_apr_block_cn10k_init(struct rvu *rvu);
 
 #ifdef CONFIG_DEBUG_FS
 void rvu_dbg_init(struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 0e74c5a2231e..93fedabfe31e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -559,3 +559,12 @@ void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw)
 	cfg |= BIT_ULL(1) | BIT_ULL(2);
 	rvu_write64(rvu, blkaddr, NIX_AF_CFG, cfg);
 }
+
+void rvu_apr_block_cn10k_init(struct rvu *rvu)
+{
+	u64 reg;
+
+	reg = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	reg |= 0xFULL << 35;
+	rvu_write64(rvu, BLKADDR_APR, APR_AF_LMT_CFG, reg);
+}
-- 
2.25.1

