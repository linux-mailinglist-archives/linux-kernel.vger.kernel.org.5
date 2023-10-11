Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DA7C536A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjJKMQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjJKMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:16:48 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC2F10C1;
        Wed, 11 Oct 2023 05:16:24 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B6VB5C020008;
        Wed, 11 Oct 2023 05:16:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=vvUXkaiiZfknT4SsbXoPsFtLl92LCmBy734wsXL2KWM=;
 b=Jtl8fwFFey/ZGSGnBUWc4dCf7NGhsZNC0hNSJYrYbnakFslu6Qj+ysjjqimF8k6pn8Cy
 1DbjeAz8sZnjwE2i7JlnyudIMuqGEsrLo3WEYneUIsWmKRPU9F9h6R/BRDHBkIPJUI7E
 7DeR9rqQlxmUsS7K3Br8y8XDU+Kb/dRdxD06LEJUVnYcf+aSm6e/r9lxWC17bXX8jRbP
 4ez3FtF0df5soDyi8no6hMOq496JpW1HcqLO81nabnGNVKtJtetfroFUTagfmmwy7776
 ILESH57ldLmeEyx9RDezVqg9t5acqfgjMq5JABg2lP9r32i6jc+71sbHT4HRcBVPHWCG UQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tnc2au3um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 05:16:01 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 11 Oct
 2023 05:16:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 11 Oct 2023 05:16:00 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.83])
        by maili.marvell.com (Postfix) with ESMTP id CD2945B6935;
        Wed, 11 Oct 2023 05:15:54 -0700 (PDT)
From:   Sai Krishna <saikrishnag@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <richardcochran@gmail.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>
CC:     Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH] octeontx2-af: Enable hardware timestamping for VFs
Date:   Wed, 11 Oct 2023 17:45:51 +0530
Message-ID: <20231011121551.1205211-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1OSmTFb2k_wQKgjkj6CPTjTwUkITLOPj
X-Proofpoint-ORIG-GUID: 1OSmTFb2k_wQKgjkj6CPTjTwUkITLOPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subbaraya Sundeep <sbhatta@marvell.com>

Currently for VFs, mailbox returns ENODEV error when hardware timestamping
enable is requested. This patch fixes this issue. Modified this patch to
return EPERM error for the PF/VFs which are not attached to CGX/RPM.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index f2b1edf1bb43..15a319684ed3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
 	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
 		return 0;
 
-	/* This msg is expected only from PFs that are mapped to CGX LMACs,
+	/* This msg is expected only from PF/VFs that are mapped to CGX/RPM LMACs,
 	 * if received from other PF/VF simply ACK, nothing to do.
 	 */
-	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
-	    !is_pf_cgxmapped(rvu, pf))
-		return -ENODEV;
+	if (!is_pf_cgxmapped(rvu, pf))
+		return -EPERM;
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 	cgxd = rvu_cgx_pdata(cgx_id, rvu);
-- 
2.25.1

