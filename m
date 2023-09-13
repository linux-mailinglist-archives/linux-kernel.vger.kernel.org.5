Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD779E264
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjIMImV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbjIMImT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:42:19 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7506910C0;
        Wed, 13 Sep 2023 01:42:15 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKesBK014882;
        Wed, 13 Sep 2023 01:42:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=NUevUetpd87fHFVlXkqG1gYoA4+HNk0VhI7PisrEu00=;
 b=KCMfuNfWxplSvCcILvtIOAsipS4tPpfle/xqyTUYY/im419LK9pcwU6FkdRGQqf3ffNm
 fvnBy9XjL/IoZjs/cOudhrmWsU/TrxDoemkaAqZ+i4Zs35Xkuj+7Cgs+YQKEFliKm/vI
 Is0BrCg6x8jbeil2gaiJzsWFdhpZ7v1eToozsnNhi5r1tef+wqea0INknYYxx2T9pp49
 CMH56kuT8JgGNNm5DKAkQXjQaLya5IROewOL0i8Q+3XnSUGRoMyp18ArpMdIKhxEkFZx
 Llx9jpd2MGdmZKrCiJuQbmEQY8+GWbPhRdDaD0PtcRLAC5H0L9+01GDXbEf2XfHrfPTz sg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3t2y84t293-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 01:42:05 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Sep
 2023 01:42:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 13 Sep 2023 01:42:03 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 6787A3F707F;
        Wed, 13 Sep 2023 01:42:03 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <srasheed@marvell.com>
CC:     <aayarekar@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <egallen@redhat.com>, <hgani@marvell.com>,
        <horms@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <sburla@marvell.com>, <sedara@marvell.com>, <vburru@marvell.com>,
        <vimleshk@marvell.com>
Subject: [net PATCH v2] octeon_ep: fix tx dma unmap len values in SG
Date:   Wed, 13 Sep 2023 01:41:56 -0700
Message-ID: <20230913084156.2147106-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <PH0PR18MB47346CADA6D087CB1BF2234CC7F0A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47346CADA6D087CB1BF2234CC7F0A@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Juqmh0BqqHsvmTlZu-fWJZ_vI7OnMgJF
X-Proofpoint-ORIG-GUID: Juqmh0BqqHsvmTlZu-fWJZ_vI7OnMgJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lengths of SG pointers are kept in the following order in
the SG entries in hardware.
 63      48|47     32|31     16|15       0
 -----------------------------------------
 |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
 -----------------------------------------
 |                Ptr 0                  |
 -----------------------------------------
 |                Ptr 1                  |
 -----------------------------------------
 |                Ptr 2                  |
 -----------------------------------------
 |                Ptr 3                  |
 -----------------------------------------
Dma pointers have to be unmapped based on their
respective lengths given in this format.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
 .../net/ethernet/marvell/octeon_ep/octep_main.c  |  8 ++++----
 .../net/ethernet/marvell/octeon_ep/octep_tx.c    |  8 ++++----
 .../net/ethernet/marvell/octeon_ep/octep_tx.h    | 16 +++++++++++++++-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 4424de2ffd70..dbc518ff8276 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -734,13 +734,13 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 dma_map_sg_err:
 	if (si > 0) {
 		dma_unmap_single(iq->dev, sglist[0].dma_ptr[0],
-				 sglist[0].len[0], DMA_TO_DEVICE);
-		sglist[0].len[0] = 0;
+				 sglist[0].len[3], DMA_TO_DEVICE);
+		sglist[0].len[3] = 0;
 	}
 	while (si > 1) {
 		dma_unmap_page(iq->dev, sglist[si >> 2].dma_ptr[si & 3],
-			       sglist[si >> 2].len[si & 3], DMA_TO_DEVICE);
-		sglist[si >> 2].len[si & 3] = 0;
+			       sglist[si >> 2].len[3 - (si & 3)], DMA_TO_DEVICE);
+		sglist[si >> 2].len[3 - (si & 3)] = 0;
 		si--;
 	}
 	tx_buffer->gather = 0;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 5a520d37bea0..d0adb82d65c3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -69,12 +69,12 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 		compl_sg++;
 
 		dma_unmap_single(iq->dev, tx_buffer->sglist[0].dma_ptr[0],
-				 tx_buffer->sglist[0].len[0], DMA_TO_DEVICE);
+				 tx_buffer->sglist[0].len[3], DMA_TO_DEVICE);
 
 		i = 1; /* entry 0 is main skb, unmapped above */
 		while (frags--) {
 			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
-				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
 			i++;
 		}
 
@@ -131,13 +131,13 @@ static void octep_iq_free_pending(struct octep_iq *iq)
 
 		dma_unmap_single(iq->dev,
 				 tx_buffer->sglist[0].dma_ptr[0],
-				 tx_buffer->sglist[0].len[0],
+				 tx_buffer->sglist[0].len[3],
 				 DMA_TO_DEVICE);
 
 		i = 1; /* entry 0 is main skb, unmapped above */
 		while (frags--) {
 			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
-				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
 			i++;
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 2ef57980eb47..21e75ff9f5e7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -17,7 +17,21 @@
 #define TX_BUFTYPE_NET_SG        2
 #define NUM_TX_BUFTYPES          3
 
-/* Hardware format for Scatter/Gather list */
+/* Hardware format for Scatter/Gather list
+ *
+ * 63      48|47     32|31     16|15       0
+ * -----------------------------------------
+ * |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
+ * -----------------------------------------
+ * |                Ptr 0                  |
+ * -----------------------------------------
+ * |                Ptr 1                  |
+ * -----------------------------------------
+ * |                Ptr 2                  |
+ * -----------------------------------------
+ * |                Ptr 3                  |
+ * -----------------------------------------
+ */
 struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
-- 
2.25.1

