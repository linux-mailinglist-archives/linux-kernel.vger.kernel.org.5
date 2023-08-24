Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E807869CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjHXIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjHXIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:12:56 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CDD2703;
        Thu, 24 Aug 2023 01:11:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJp2KP006892;
        Thu, 24 Aug 2023 01:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=bzBEdiFZRb0jxcT/TEECbiAx7DDEP3WAKgANQVDaT9g=;
 b=VzXABoksa23kwDXJK8gC57e/OGwnBuPCwLM6HrHTcH7rH9e8Bt4O+G0FfPxHfjgMGXwf
 F5ixC88OC1NKtCUflCJPr6mlnvmd1nYOkBEUWJDpqHFPXhLJ1TUgzgr3lmrPifZNmCED
 ipC93IOdZD7DT+0quwbyU7a699rLRgxjPBVqe/wmOxXwEp3cJxBhpPeU8kOvk0iRuepr
 0LhPfU5hChKldc0+e+rN0V9a+Q5Opt7UBOf5sUiOs0U2AtMa5phE+Z5icaH7eq1QVSxq
 fqgzoXjtyroLn0pedhIdYUfYkphZMmQjm1bQ5SD5WvxsRq6XAL4TMJGEvdD7+oi+9PLb cA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3snrmcsv95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 01:10:59 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 24 Aug
 2023 01:10:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 24 Aug 2023 01:10:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id 3DA203F705F;
        Thu, 24 Aug 2023 01:10:52 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V4 3/3] cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
Date:   Thu, 24 Aug 2023 13:40:32 +0530
Message-ID: <20230824081032.436432-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230824081032.436432-1-sumang@marvell.com>
References: <20230824081032.436432-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MYFO0hS9uk6D5315y_lQ52pVFhQEx4CS
X-Proofpoint-ORIG-GUID: MYFO0hS9uk6D5315y_lQ52pVFhQEx4CS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_05,2023-08-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 6492749dd7c8..bfddbff7bcdf 100644
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
 
-- 
2.25.1

