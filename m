Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3880497B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjLEFwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEFwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:52:47 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B45111;
        Mon,  4 Dec 2023 21:52:53 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4NxDbq021864;
        Mon, 4 Dec 2023 21:52:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=gz+tVJfqr9b4cJ1PIAhfd0qQhpx4IETkTf+nnLO9rVE=;
 b=JncF3LfUPAOwZii74e1W4YDfiNEWzsbYXxqOHKPBKIcNKgSnSMLCQM5PlJ6NBNpT+odW
 oHNIac6mQ3O+pe1oOJt+LoXMNq4qdcsB/nwb8VA6Y4FZ6/HgtAYDa+Ew7fqIOl2BG3Io
 efJmA6I/2EbGmpXf4J0ayNke+tq/R4SCb3B/M4wLTN37saf3luJCNSE8MZ/DZbev8stm
 l8u633EmUWSIiJ6TFLWFdM01mjTIxTOr+6fMJpGx2ixH2kIpsbXgmdw+2X7WckFJnXlk
 yaKujh9ms2oj2RojPz2fofLkOJV8+G4hdaUyyxJ8yd/iAKrdZHf1tsho/+OPMQvombI/ Rg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3usrx3gv2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 21:52:47 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 21:52:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 21:52:46 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 5338C3F708E;
        Mon,  4 Dec 2023 21:52:42 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next v2 PATCH] octeontx2-af: cn10k: Increase outstanding LMTST transactions
Date:   Tue, 5 Dec 2023 11:22:41 +0530
Message-ID: <20231205055241.26355-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: hhgGwmqkIge8U7rlBUQwGEd6qemZecI8
X-Proofpoint-ORIG-GUID: hhgGwmqkIge8U7rlBUQwGEd6qemZecI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v1-v2:
 used FIELD_PREP marco.


 drivers/net/ethernet/marvell/octeontx2/af/rvu.c       | 3 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h       | 1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 9 +++++++++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h   | 2 ++
 4 files changed, 15 insertions(+)

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
index 0e74c5a2231e..7fa98aeb3663 100644
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
+	reg |=	FIELD_PREP(LMTST_THROTTLE_MASK, LMTST_WR_PEND_MAX);
+	rvu_write64(rvu, BLKADDR_APR, APR_AF_LMT_CFG, reg);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index b42e631e52d0..189f0eafd5ff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -733,5 +733,7 @@
 #define APR_LMT_MAP_ENT_DIS_SCH_CMP_SHIFT	23
 #define APR_LMT_MAP_ENT_SCH_ENA_SHIFT		22
 #define APR_LMT_MAP_ENT_DIS_LINE_PREF_SHIFT	21
+#define LMTST_THROTTLE_MASK		GENMASK_ULL(38, 35)
+#define LMTST_WR_PEND_MAX		15
 
 #endif /* RVU_REG_H */
-- 
2.25.1

