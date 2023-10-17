Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2F7CC108
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343729AbjJQKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJQKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:50:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6FF0;
        Tue, 17 Oct 2023 03:50:47 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H3JocE008487;
        Tue, 17 Oct 2023 03:50:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=LSRCKb8JzrEBoZi94vlE+OdKI7L0JbMMj1EiLEo1A7Y=;
 b=Dh8fbntqyrSq/Z6FSpfyxPkf5JOoWxVQvUH1mL/1n3Rxf1xJKqOdsMopN08ltP6oTOaL
 UXV01MHZKat1ddbJUWhkIhRVC6AE3hiFkTzhEDmGNN8a9GJWDqB2LUs88SjX/f/55fVE
 6hFCI3Q46VwzOu77MzfevwbsyFDbAJAk/nOs5bsBuFFTQFbmAV4IYWVorM/WWVSl4vhy
 dukIB4j7VTI6+Sl2SZxL9sbb5LtIogMeGTHV3c9WYLXFh2Bf3HBz1Hn9n+aIf0q8POHg
 FkilLeBC+/zvXwe+Vdcg6U4n4UJ18JTGUNb7qZF05ZB4o9PN+oFQ0Pgd7lga+Q+MPB6P aw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tsj8shjf3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 03:50:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 17 Oct
 2023 03:50:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 17 Oct 2023 03:50:32 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id CC9F45B6943;
        Tue, 17 Oct 2023 03:50:32 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <kuba@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <egallen@redhat.com>, <hgani@marvell.com>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <srasheed@marvell.com>,
        <sedara@marvell.com>, <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: [PATCH net v3] octeon_ep: update BQL sent bytes before ringing doorbell
Date:   Tue, 17 Oct 2023 03:50:30 -0700
Message-ID: <20231017105030.2310966-1-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7fydJ-HZjoIX1jq51LDFzlEZrCj4EjrU
X-Proofpoint-GUID: 7fydJ-HZjoIX1jq51LDFzlEZrCj4EjrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes Tx is completed immediately after doorbell is updated, which
causes Tx completion routing to update completion bytes before the
same packet bytes are updated in sent bytes in transmit function, hence
hitting BUG_ON() in dql_completed(). To avoid this, update BQL
sent bytes before ringing doorbell.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Update skb timestamp and host write index before memory barrier
V2: https://lore.kernel.org/all/20231012101706.2291551-1-srasheed@marvell.com/
  - Call netdev_tx_sent_queue before memory barrier
V1: https://lore.kernel.org/all/20231010115015.2279977-1-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index dbc518ff8276..5b46ca47c8e5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -715,20 +715,19 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
-	/* Flush the hw descriptor before writing to doorbell */
-	wmb();
-
-	/* Ring Doorbell to notify the NIC there is a new packet */
-	writel(1, iq->doorbell_reg);
+	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+	skb_tx_timestamp(skb);
 	atomic_inc(&iq->instr_pending);
 	wi++;
 	if (wi == iq->max_count)
 		wi = 0;
 	iq->host_write_index = wi;
+	/* Flush the hw descriptor before writing to doorbell */
+	wmb();
 
-	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+	/* Ring Doorbell to notify the NIC there is a new packet */
+	writel(1, iq->doorbell_reg);
 	iq->stats.instr_posted++;
-	skb_tx_timestamp(skb);
 	return NETDEV_TX_OK;
 
 dma_map_sg_err:
-- 
2.25.1

