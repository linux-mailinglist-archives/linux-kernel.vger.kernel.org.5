Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE2C77537F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjHIHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjHIHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:05:53 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738591724;
        Wed,  9 Aug 2023 00:05:53 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378Nol4U010112;
        Wed, 9 Aug 2023 00:05:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=XByIP5J2zsR9geHAsK/CerIO4PGvyKW3M+zGye7jZX0=;
 b=DMA0Y8138tLNr26BWCwVp0Tveh2Tz8ZisP4g6tDy7ErsYCmNa3mdJpdxIkZJVcMINgGm
 LDxC58Y53OcT2RuwZMMkJBbgu3uGAMkkvVBuEYH+t7EGFqFJ26IJeDA3Ydyps99LvQZL
 gplCB5MKDpbCSBBj+fe8aIp5pIfm1SiX+4oogFnDnOi35UdEds9UrJZ8yapP0gIYfprC
 bb+PeZzLCetxfPayeRKXiNaXHcukpQS3v8J6YrcbbDb2Trg/TOsx859o4LehgqdTGurf
 uXi7eyEgM5z7rCLxa87CscltQdwkDpQyVMdWU27QXXOqTD9rPbErrewhtgRx28us4Ce/ sA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntktqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 00:05:47 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 00:05:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 9 Aug 2023 00:05:45 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 8B93E3F7063;
        Wed,  9 Aug 2023 00:05:41 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 1/4] octeontx2-pf: Update PFC configuration
Date:   Wed, 9 Aug 2023 12:35:29 +0530
Message-ID: <20230809070532.3252464-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809070532.3252464-1-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: X-2YEcOpcqSjBkx7SU5DU7YcnW-nYC_z
X-Proofpoint-ORIG-GUID: X-2YEcOpcqSjBkx7SU5DU7YcnW-nYC_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now we are creating/deleting Tx schedulers when user is
setting PFC on/off. The problem is if we have a running traffic on
the interface and as we are updating the sq->smq mapping on the fly,
we might loose completion interrupt for some packets. As a result of
that a watchdog reset is hit from BQL.
This patch solves the issue by simply calling interface off/on APIs
which will reconfigure all the queues. We might loss the running traffic
momentarily but that should be fine.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index ccaf97bb1ce0..d54edfa8fcc9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -406,6 +406,7 @@ static int otx2_dcbnl_ieee_getpfc(struct net_device *dev, struct ieee_pfc *pfc)
 static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
 	struct otx2_nic *pfvf = netdev_priv(dev);
+	bool if_up = netif_running(dev);
 	int err;
 
 	/* Save PFC configuration to interface */
@@ -426,14 +427,9 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 	if (err)
 		return err;
 
-	/* Request Per channel Bpids */
-	if (pfc->pfc_en)
-		otx2_nix_config_bp(pfvf, true);
-
-	err = otx2_pfc_txschq_update(pfvf);
-	if (err) {
-		dev_err(pfvf->dev, "%s failed to update TX schedulers\n", __func__);
-		return err;
+	if (if_up) {
+		otx2_stop(dev);
+		otx2_open(dev);
 	}
 
 	return 0;
-- 
2.25.1

