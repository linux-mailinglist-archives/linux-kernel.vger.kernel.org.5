Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F59800307
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377343AbjLAFdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAFdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:33:43 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A661703;
        Thu, 30 Nov 2023 21:33:48 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B12Fd3n032634;
        Thu, 30 Nov 2023 21:33:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=rP3Ji68hr4FNmt1jJp4/fePLt1PrNYK2+C381Tz68Ig=;
 b=TfiQN/AN5Bh6H+7zvuJ0pwy1UPrI7fYEcwuhFCGQsHFd48yWxzhqlNA6xGRUQ/yBXSdr
 TnU9bFiSy3GUONflrx16B/3S6A6qN7BJ0DuUTK7rUsYAtPQZy9fzicWvXokurphRxwKu
 yQ+H0V8rSwbZgrFWVns0yFJLSDvw7+URUevGczG+183CPaHqubpXyxCYx8NFed0wfBQo
 KC7FmwoEFFTD2JY6v9hgwE3h7YYKogQCaAkvJeAVoA+H3xMdNhVmJzKEEK5cOm/ARgAJ
 YBkyJhjXhulQpu596pSZ3QmzK/FgT/v95rrZtpG6xOgiV+oaECDxPgImUMtjd3qj3IXl NA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3updt6ed9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 21:33:40 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 30 Nov
 2023 21:33:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 30 Nov 2023 21:33:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id EC9133F706B;
        Thu, 30 Nov 2023 21:33:32 -0800 (PST)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <naveenm@marvell.com>
CC:     Suman Ghosh <sumang@marvell.com>
Subject: [net PATCH v3] octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing
Date:   Fri, 1 Dec 2023 11:03:30 +0530
Message-ID: <20231201053330.3903694-1-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Y_XrMjM9bgam5AieALxwAoa4r4282kvX
X-Proofpoint-ORIG-GUID: Y_XrMjM9bgam5AieALxwAoa4r4282kvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_03,2023-11-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Mamindlapalli <naveenm@marvell.com>

The current adaptive interrupt coalescing code updates only rx
packet stats for dim algorithm. This patch also updates tx packet
stats which will be useful when there is only tx traffic.
Also moved configuring hardware adaptive interrupt setting to
driver dim callback.

Fixes: 6e144b47f560 ("octeontx2-pf: Add support for adaptive interrupt coalescing")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
v3 changes:
- Updated signed-off-by signature.

v2 changes:
- Missed adding the fixes tag in v1. Added the same in v2.

 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  9 +++++++++
 .../marvell/octeontx2/nic/otx2_txrx.c         | 20 +++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ba95ac913274..6c0e0e2c235b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1685,6 +1685,14 @@ static void otx2_do_set_rx_mode(struct otx2_nic *pf)
 	mutex_unlock(&pf->mbox.lock);
 }
 
+static void otx2_set_irq_coalesce(struct otx2_nic *pfvf)
+{
+	int cint;
+
+	for (cint = 0; cint < pfvf->hw.cint_cnt; cint++)
+		otx2_config_irq_coalescing(pfvf, cint);
+}
+
 static void otx2_dim_work(struct work_struct *w)
 {
 	struct dim_cq_moder cur_moder;
@@ -1700,6 +1708,7 @@ static void otx2_dim_work(struct work_struct *w)
 		CQ_TIMER_THRESH_MAX : cur_moder.usec;
 	pfvf->hw.cq_ecount_wait = (cur_moder.pkts > NAPI_POLL_WEIGHT) ?
 		NAPI_POLL_WEIGHT : cur_moder.pkts;
+	otx2_set_irq_coalesce(pfvf);
 	dim->state = DIM_START_MEASURE;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 6ee15f3c25ed..4d519ea833b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -512,11 +512,18 @@ static void otx2_adjust_adaptive_coalese(struct otx2_nic *pfvf, struct otx2_cq_p
 {
 	struct dim_sample dim_sample;
 	u64 rx_frames, rx_bytes;
+	u64 tx_frames, tx_bytes;
 
 	rx_frames = OTX2_GET_RX_STATS(RX_BCAST) + OTX2_GET_RX_STATS(RX_MCAST) +
 		OTX2_GET_RX_STATS(RX_UCAST);
 	rx_bytes = OTX2_GET_RX_STATS(RX_OCTS);
-	dim_update_sample(pfvf->napi_events, rx_frames, rx_bytes, &dim_sample);
+	tx_bytes = OTX2_GET_TX_STATS(TX_OCTS);
+	tx_frames = OTX2_GET_TX_STATS(TX_UCAST);
+
+	dim_update_sample(pfvf->napi_events,
+			  rx_frames + tx_frames,
+			  rx_bytes + tx_bytes,
+			  &dim_sample);
 	net_dim(&cq_poll->dim, dim_sample);
 }
 
@@ -558,16 +565,9 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 		if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
 			return workdone;
 
-		/* Check for adaptive interrupt coalesce */
-		if (workdone != 0 &&
-		    ((pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED) ==
-		     OTX2_FLAG_ADPTV_INT_COAL_ENABLED)) {
-			/* Adjust irq coalese using net_dim */
+		/* Adjust irq coalese using net_dim */
+		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
 			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
-			/* Update irq coalescing */
-			for (i = 0; i < pfvf->hw.cint_cnt; i++)
-				otx2_config_irq_coalescing(pfvf, i);
-		}
 
 		if (unlikely(!filled_cnt)) {
 			struct refill_work *work;
-- 
2.25.1

