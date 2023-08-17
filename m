Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5257C77F516
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350259AbjHQLZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350243AbjHQLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:24:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562CB2D61;
        Thu, 17 Aug 2023 04:24:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H40ZA2017037;
        Thu, 17 Aug 2023 04:24:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=iHGcBOaX18i6Je3c+sAdzzshK4Etjmz/2k1ZjKy/3m0=;
 b=LRsQKiLoah4OgnT7CfPst0JlyqLXh5L7AtBsyFRIXWscRq09g/Mi0BCUq0uzzSz6IZrz
 3H3loWT+QtS4hd1k3bE4jZ5tWEdSd0jJk73uTjMN191UuSKD/pg4P3tILKIJ0DJt4Cz1
 5dlL3Nmh/RJFplCMUUpHyuFFlk9YKrR8xNN40M75Lm+tHul5mkotPzsbUgUHKVQ/2EAV
 LN4RXT2pLqOHfjQ+4uPy1saQC/4ZCW705ORl4A+4QotCO8PtJrpOqWtZ6c2mI9BzUWHa
 DWrxRAlvNViUmv8UNyCiNgSr8VME918mVqvTX5a79+TiQ3qP8jQ/1cRlKA3Vjj5/If59 RA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sgptkwmg9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 04:24:38 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 04:24:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 17 Aug 2023 04:24:24 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 9F84E3F7054;
        Thu, 17 Aug 2023 04:24:19 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next Patch 3/5] octeontx2-af: Add validation of lmac
Date:   Thu, 17 Aug 2023 16:53:55 +0530
Message-ID: <20230817112357.25874-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817112357.25874-1-hkelam@marvell.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tAzLz5WmL6NR4zGbOjB0JFv3J8Nm7XTE
X-Proofpoint-GUID: tAzLz5WmL6NR4zGbOjB0JFv3J8Nm7XTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of new MAC blocks like CN10K RPM and CN10KB
RPM_USX, LMACs are noncontiguous. Though in most of the functions,
lmac validation checks exist but in few functions they are missing.
This patch adds the same.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 9392ef95a245..e06f77ad6106 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -232,6 +232,9 @@ int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
 	int index, id;
 	u64 cfg;
 
+	if (!lmac)
+		return -ENODEV;
+
 	/* access mac_ops to know csr_offset */
 	mac_ops = cgx_dev->mac_ops;
 
@@ -550,15 +553,16 @@ void cgx_lmac_promisc_config(int cgx_id, int lmac_id, bool enable)
 {
 	struct cgx *cgx = cgx_get_pdata(cgx_id);
 	struct lmac *lmac = lmac_pdata(lmac_id, cgx);
-	u16 max_dmac = lmac->mac_to_index_bmap.max;
 	struct mac_ops *mac_ops;
+	u16 max_dmac;
 	int index, i;
 	u64 cfg = 0;
 	int id;
 
-	if (!cgx)
+	if (!cgx || !lmac)
 		return;
 
+	max_dmac = lmac->mac_to_index_bmap.max;
 	id = get_sequence_id_of_lmac(cgx, lmac_id);
 
 	mac_ops = cgx->mac_ops;
@@ -731,7 +735,7 @@ int cgx_get_fec_stats(void *cgxd, int lmac_id, struct cgx_fec_stats_rsp *rsp)
 	int corr_reg, uncorr_reg;
 	struct cgx *cgx = cgxd;
 
-	if (!cgx || lmac_id >= cgx->lmac_count)
+	if (!is_lmac_valid(cgx, lmac_id))
 		return -ENODEV;
 
 	if (cgx->lmac_idmap[lmac_id]->link_info.fec == OTX2_FEC_NONE)
-- 
2.17.1

