Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC5788523
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbjHYKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244510AbjHYKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:40:56 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B01700;
        Fri, 25 Aug 2023 03:40:54 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P3YEMh025590;
        Fri, 25 Aug 2023 03:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=iHGcBOaX18i6Je3c+sAdzzshK4Etjmz/2k1ZjKy/3m0=;
 b=ByUb8v8FmaL++29hzY0APYp0lC6SvsgvxEYQlPCkgNPjiqUgw3ZlQCkDMCpqak67QIKQ
 4D4McLgOfJjmWDMoDx6PHz0dLXEFMFDLB7l49hODkiw9p1WGSnU73147C5K5TpRxqoAd
 ZjsmoA0nFIXzD9Z/rHh3BRRPzR3Vu5S8jiyMmYveEKgPqcUxbEN8VeNPrqhWM0bz4Wyf
 51TF3rzP4533Sttq2SEaIFkXdJMS1LQ5aZMz/J6J26o9TDYxY1QV2SfoHFzLvVjg/Mge
 8MMjRAOu0Oxfr3Y4UciZoPXUPCbTRCeVWLhy2yEa2FydoNtAr6vN/zfZPIfzm0kJN9xi Bw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3spmgvs3p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 03:40:44 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 25 Aug
 2023 03:40:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 25 Aug 2023 03:40:42 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 5E3503F70AB;
        Fri, 25 Aug 2023 03:40:38 -0700 (PDT)
From:   Hariprasad Kelam <hkelam@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [net-next PatchV2 3/4] octeontx2-af: Add validation of lmac
Date:   Fri, 25 Aug 2023 16:10:21 +0530
Message-ID: <20230825104022.16288-4-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230825104022.16288-1-hkelam@marvell.com>
References: <20230825104022.16288-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: I_4eD2HHx4wqA-Xp5E79U8DMA3ty2uE6
X-Proofpoint-ORIG-GUID: I_4eD2HHx4wqA-Xp5E79U8DMA3ty2uE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

