Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9DE775382
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjHIHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjHIHGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:06:01 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A981FCD;
        Wed,  9 Aug 2023 00:05:59 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378NlZGL005941;
        Wed, 9 Aug 2023 00:05:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=xslIp8z7hUP5iZF3SUe9yWaF9DhbTpnOAZfqCpddnlA=;
 b=fY9y5arFP3hqUcFmSbN7pxuV9CNTgZvSMcBft8w3y0KxEAxn7WtKG3jp/lNvZy9u/14c
 DIFxVvlq93Qin3BCI20QSxXEmGov0A0io5fjzuZ10j85G/TEumo/JZPXNuc2Hk8CX8Ki
 laBjn89qjUXVQYmesrao24DX6MzRmSWAnh38kruIF8/7MWeux/8zkyyl2nSbs6q2IILR
 V72ZGf/yx8qWmQeT5xmu5HIAC3wShGHx938hZODKXavCXPLTAjwQyJcfZm6lYk4yoC7I
 WX+FwnUf5MClrBmY6cpZeZgrI9R9pAJyFccRwppWlp7FMWUAd0N9o4ZbVC0M/CPhFKbE uQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntktrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 00:05:53 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 9 Aug
 2023 00:05:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 9 Aug 2023 00:05:51 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id AB2B43F705B;
        Wed,  9 Aug 2023 00:05:47 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH V2 2/4] octeontx2-pf: Fix PFC TX scheduler free
Date:   Wed, 9 Aug 2023 12:35:30 +0530
Message-ID: <20230809070532.3252464-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809070532.3252464-1-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SNEZr1FjhnZKxNW0jSorBKDAmC91V7db
X-Proofpoint-ORIG-GUID: SNEZr1FjhnZKxNW0jSorBKDAmC91V7db
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

During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
which caused free up all schedulers other than the PFC schedulers.
This patch fixes that to free only the PFC Tx schedulers.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 77c8f650f7ac..289371b8ce4f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
 
 	mutex_unlock(&pfvf->mbox.lock);
 }
+EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index d54edfa8fcc9..c75435bab411 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -125,19 +125,12 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
-	struct nix_txsch_free_req *free_req;
+	int lvl;
 
-	mutex_lock(&pfvf->mbox.lock);
 	/* free PFC TLx nodes */
-	free_req = otx2_mbox_alloc_msg_nix_txsch_free(&pfvf->mbox);
-	if (!free_req) {
-		mutex_unlock(&pfvf->mbox.lock);
-		return -ENOMEM;
-	}
-
-	free_req->flags = TXSCHQ_FREE_ALL;
-	otx2_sync_mbox_msg(&pfvf->mbox);
-	mutex_unlock(&pfvf->mbox.lock);
+	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+		otx2_txschq_free_one(pfvf, lvl,
+				     pfvf->pfc_schq_list[lvl][prio]);
 
 	pfvf->pfc_alloc_status[prio] = false;
 	return 0;
-- 
2.25.1

