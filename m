Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA29775384
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjHIHG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjHIHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:06:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8CE1FD0;
        Wed,  9 Aug 2023 00:06:11 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378NmsFo006766;
        Wed, 9 Aug 2023 00:06:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=r8ZJyNLWSASQSaMSVD7WpeYshElAlIsWDG+yRst7Bbo=;
 b=Eg5IuL/+lTh6f41l+MVtY++IELXPN8487L62DJfFoSSVJu5PPkHfzSLQqU7cAEj0SaD1
 F4EqoSvRb7klcP/hy90I1g1r3aKkBr4Qsqg0ST3zubeZrVv/8sfoFtrMR/xsxU63diBT
 tBvMhGHc/FE4tAR+RzqFPW0u4WysQ1A4S9fEAtxW7nFqBguZrT8Zh83wO4tmh+PHw8kS
 2ITj5PF/+HEGhCXxKIjh6BdFLnUfLisZbVrzrqfqSik27plVKYdwA0nZZD2fJzoSVu1o
 PqYAAbRg9P3vP6jUTWqjKXROBGuVIGo+duWf+IC2bqTBr6mYDUMumQRilgDfsXJ9GzhC bw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntkts7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 00:06:05 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 00:06:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 9 Aug 2023 00:06:03 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id AD39F3F705B;
        Wed,  9 Aug 2023 00:05:59 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 4/4] octeonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
Date:   Wed, 9 Aug 2023 12:35:32 +0530
Message-ID: <20230809070532.3252464-5-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809070532.3252464-1-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iFtJTPx0V8xZL0ALAVcAjPGq7-CkP_TP
X-Proofpoint-ORIG-GUID: iFtJTPx0V8xZL0ALAVcAjPGq7-CkP_TP
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

MAC (CGX or RPM) asserts backpressure at TL3 or TL2 node of the egress
hierarchical scheduler tree depending on link level config done. If
there are multiple PFC priorities enabled at a time and for all such
flows to backoff, each priority will have to assert backpressure at
different TL3/TL2 scheduler nodes and these flows will need to submit
egress pkts to these nodes.

Current PFC configuration has an issue where in only one backpressure
scheduler node is being allocated which is resulting in only one PFC
priority to work. This patch fixes this issue.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index c75435bab411..048ee015c085 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -70,7 +70,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 	 * link config level. These rest of the scheduler can be
 	 * same as hw.txschq_list.
 	 */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		req->schq[lvl] = 1;
 
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
@@ -83,7 +83,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 		return PTR_ERR(rsp);
 
 	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++) {
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++) {
 		if (!rsp->schq[lvl])
 			return -ENOSPC;
 
@@ -128,7 +128,7 @@ static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 	int lvl;
 
 	/* free PFC TLx nodes */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		otx2_txschq_free_one(pfvf, lvl,
 				     pfvf->pfc_schq_list[lvl][prio]);
 
@@ -400,9 +400,11 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 {
 	struct otx2_nic *pfvf = netdev_priv(dev);
 	bool if_up = netif_running(dev);
+	u8 prev_pfc_en;
 	int err;
 
 	/* Save PFC configuration to interface */
+	prev_pfc_en = pfvf->pfc_en;
 	pfvf->pfc_en = pfc->pfc_en;
 
 	if (pfvf->hw.tx_queues >= NIX_PF_PFC_PRIO_MAX)
@@ -421,7 +423,9 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 		return err;
 
 	if (if_up) {
+		pfvf->pfc_en = prev_pfc_en;
 		otx2_stop(dev);
+		pfvf->pfc_en = pfc->pfc_en;
 		otx2_open(dev);
 	}
 
-- 
2.25.1

