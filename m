Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867A7EB11F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjKNNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKNNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:45:58 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3411B5;
        Tue, 14 Nov 2023 05:45:54 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEBtemi021217;
        Tue, 14 Nov 2023 05:45:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=WpPrQvBv581xH9Q+hoN7ujJTdwZUV8kAtI0vdK7h3Wc=;
 b=BJv6ol9yJ1GUe/HUSTPU/BzR0VL8RdYvnkiyUbutI343tqmy1c2MWaAbHKYQh6ubo38V
 BGf9jHiBahCjKkVFRbwkFm3xk7tu99bmXatKlxk5hD9rEW9lr/f2DXKPTmKCwJDdvCOa
 XhUZ7LfknP+rvgDkmWw2NGOrRpz3K0kffQMatO/1Lt0Bw15ZEyMjYoDdZAmRP+kikNk7
 UFpXUmi1pN295lLiwvTBl9ZnKZzWEC9fLJLB2AKotJRZZ3F/al0gB5KUVN92X9u4SVQy
 Nr2v8IDyRvhuQq0AUkL48gOojohDScpvWvm71RclP7J0xIuLBLBIBBk+AtITufZBKIVr Sw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uc5vmgufs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 05:45:47 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 14 Nov
 2023 05:45:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 14 Nov 2023 05:45:45 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 8E8DE3F705B;
        Tue, 14 Nov 2023 05:45:44 -0800 (PST)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3 RESEND 3/4] octeon_ep: implement xmit_more in transmit
Date:   Tue, 14 Nov 2023 05:45:34 -0800
Message-ID: <20231114134535.2455051-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114134535.2455051-1-srasheed@marvell.com>
References: <20231114134535.2455051-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BGQfsUGJJ1-YWqAUjqoYfpiHj6_hAfl9
X-Proofpoint-GUID: BGQfsUGJJ1-YWqAUjqoYfpiHj6_hAfl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add xmit_more handling in tx datapath for octeon_ep pf.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - Stop returning NETDEV_TX_BUSY when ring is full in xmit_patch.
    Change to inspect early if next packet can fit in ring instead of
    current packet, and stop queue if not.
  - Add smp_mb between stopping tx queue and checking if tx queue has
    free entries again, in queue full check function to let reflect
    IQ process completions that might have happened on other cpus.
V2: https://lore.kernel.org/all/20231024145119.2366588-4-srasheed@marvell.com/
  - Updated changelog to have imperative tone.
V1: https://lore.kernel.org/all/20231023114449.2362147-3-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_config.h |  2 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 36 ++++++++++++++-----
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index 1622a6ebf036..ed8b1ace56b9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -15,7 +15,7 @@
 /* Tx Queue: maximum descriptors per ring */
 #define OCTEP_IQ_MAX_DESCRIPTORS    1024
 /* Minimum input (Tx) requests to be enqueued to ring doorbell */
-#define OCTEP_DB_MIN                1
+#define OCTEP_DB_MIN                8
 /* Packet threshold for Tx queue interrupt */
 #define OCTEP_IQ_INTR_THRESHOLD     0x0
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 1c02304677c9..2d1bcdc589f3 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -784,6 +784,13 @@ static inline int octep_iq_full_check(struct octep_iq *iq)
 	/* Stop the queue if unable to send */
 	netif_stop_subqueue(iq->netdev, iq->q_no);
 
+	/* Allow for pending updates in write index
+	 * from iq_process_completion in other cpus
+	 * to reflect, in case queue gets free
+	 * entries.
+	 */
+	smp_mb();
+
 	/* check again and restart the queue, in case NAPI has just freed
 	 * enough Tx ring entries.
 	 */
@@ -818,6 +825,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	struct octep_iq *iq;
 	skb_frag_t *frag;
 	u16 nr_frags, si;
+	int xmit_more;
 	u16 q_no, wi;
 
 	if (skb_put_padto(skb, ETH_ZLEN))
@@ -830,10 +838,6 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	}
 
 	iq = oct->iq[q_no];
-	if (octep_iq_full_check(iq)) {
-		iq->stats.tx_busy++;
-		return NETDEV_TX_BUSY;
-	}
 
 	shinfo = skb_shinfo(skb);
 	nr_frags = shinfo->nr_frags;
@@ -894,19 +898,33 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 		hw_desc->dptr = tx_buffer->sglist_dma;
 	}
 
-	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+	xmit_more = netdev_xmit_more();
+
+	__netdev_tx_sent_queue(iq->netdev_q, skb->len, xmit_more);
+
 	skb_tx_timestamp(skb);
 	atomic_inc(&iq->instr_pending);
+	iq->fill_cnt++;
 	wi++;
 	if (wi == iq->max_count)
 		wi = 0;
 	iq->host_write_index = wi;
+
+	/* octep_iq_full_check stops the queue and returns
+	 * true if so, in case the queue has become full
+	 * by inserting current packet. If so, we can
+	 * go ahead and ring doorbell.
+	 */
+	if (!octep_iq_full_check(iq) && xmit_more &&
+	    iq->fill_cnt < iq->fill_threshold)
+		return NETDEV_TX_OK;
+
 	/* Flush the hw descriptor before writing to doorbell */
 	wmb();
-
-	/* Ring Doorbell to notify the NIC there is a new packet */
-	writel(1, iq->doorbell_reg);
-	iq->stats.instr_posted++;
+	/* Ring Doorbell to notify the NIC of new packets */
+	writel(iq->fill_cnt, iq->doorbell_reg);
+	iq->stats.instr_posted += iq->fill_cnt;
+	iq->fill_cnt = 0;
 	return NETDEV_TX_OK;
 
 dma_map_sg_err:
-- 
2.25.1

