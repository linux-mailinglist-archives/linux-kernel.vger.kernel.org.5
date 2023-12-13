Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D1811C89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442183AbjLMSLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442145AbjLMSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:10:59 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7820DAF;
        Wed, 13 Dec 2023 10:11:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDBPTkC007464;
        Wed, 13 Dec 2023 10:10:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=pfpt0220; bh=9Hj0KLnB
        Ueycwyof1iA+0mLw8fTdl+oosoVSFW+ctGw=; b=YiSd5hZC0q3ooM0Me1HLmyAk
        rirR/TQIaDNsdEgmu+3kAY4uAl7dseWWMIzd5xBFE31X8Fw/1MtVFpvu+BgoTaei
        DeZQh0KfKhc3DrkW1cp6YhlGmmkwIrFjJo8tM50ktSBfgwRRBisc5sAKI0VBS6fy
        3Kg8WcDz3+AvLEbVJ0LEggNXDwHnLPxsDOvnGUh8BSBlAQJS/t91SvDsBTfl0MN5
        oc3BRAB5YMWCw8DgI0mSpunKn7ToYXMeH/VNnNm5FxbDaALSVjt8Ge2jeGtXmyfp
        NKVdmKyoKRiqI3xMhLvFLOsk5JnokyzRtYsItCj9WSG80aCwVrJ6EvbycxhXHw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uybqmhtb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 10:10:53 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Dec
 2023 10:10:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 13 Dec 2023 10:10:51 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id A62733F708C;
        Wed, 13 Dec 2023 10:10:47 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>, <sbhatta@marvell.com>,
        <jerinj@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH] octeontx2-pf: Fix graceful exit during PFC configuration failure
Date:   Wed, 13 Dec 2023 23:40:44 +0530
Message-ID: <20231213181044.103943-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VdTMhOCCxuJki73Q6snNOiZI0IHMJ3KY
X-Proofpoint-ORIG-GUID: VdTMhOCCxuJki73Q6snNOiZI0IHMJ3KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PFC configuration failure the code was not handling a graceful
exit. This patch fixes the same and add proper code for a graceful exit.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index bfddbff7bcdf..28fb643d2917 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -399,9 +399,10 @@ static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
 	struct otx2_nic *pfvf = netdev_priv(dev);
+	u8 old_pfc_en;
 	int err;
 
-	/* Save PFC configuration to interface */
+	old_pfc_en = pfvf->pfc_en;
 	pfvf->pfc_en = pfc->pfc_en;
 
 	if (pfvf->hw.tx_queues >= NIX_PF_PFC_PRIO_MAX)
@@ -411,13 +412,17 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 	 * supported by the tx queue configuration
 	 */
 	err = otx2_check_pfc_config(pfvf);
-	if (err)
+	if (err) {
+		pfvf->pfc_en = old_pfc_en;
 		return err;
+	}
 
 process_pfc:
 	err = otx2_config_priority_flow_ctrl(pfvf);
-	if (err)
+	if (err) {
+		pfvf->pfc_en = old_pfc_en;
 		return err;
+	}
 
 	/* Request Per channel Bpids */
 	if (pfc->pfc_en)
@@ -425,6 +430,12 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 
 	err = otx2_pfc_txschq_update(pfvf);
 	if (err) {
+		if (pfc->pfc_en)
+			otx2_nix_config_bp(pfvf, false);
+
+		otx2_pfc_txschq_stop(pfvf);
+		pfvf->pfc_en = old_pfc_en;
+		otx2_config_priority_flow_ctrl(pfvf);
 		dev_err(pfvf->dev, "%s failed to update TX schedulers\n", __func__);
 		return err;
 	}
-- 
2.25.1

