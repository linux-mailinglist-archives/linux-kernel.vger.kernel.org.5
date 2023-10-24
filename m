Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687A87D5462
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjJXOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343702AbjJXOvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:51:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CF10DE;
        Tue, 24 Oct 2023 07:51:47 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O2K86x021789;
        Tue, 24 Oct 2023 07:51:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=IFVG9SilRa/MRmDVoe+eoB8mh3aaZAJsY4D9VWbLWRY=;
 b=XZ4fo5pu4Iyhq9lENnD7mEUGIwtO6FA315CaIMiVhS41u1jA1RhoM08VNt1rUCIhXcYq
 VkZuc8FJuITBW86hlMBb5hnFefTWFc4A6wRbXqnxiBcX/3DZqkpPW29xhD3s/MtrUo6O
 3bovB0Ew3qCw0NUUMBocCUdD/T5pomVxHF3/Rl8xq3wz43jkhqfrzH6I98VhFYEApVyt
 wJVmxdqNYbR4tzJjRyrfkDEIfoTrLF9Q9kz6evUyp9Gu0FvqFCaB7/ZVe6bPcYX2c0Wr
 RiGcQLWiBcV5lzfXPng0OYV8XziLPMJIHPzg3/1227AjK5YgdxmoMWbENby0nEoTl5p+ +g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tx523tpqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 07:51:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 24 Oct
 2023 07:51:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 24 Oct 2023 07:51:40 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 072183F7076;
        Tue, 24 Oct 2023 07:51:39 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in transmit
Date:   Tue, 24 Oct 2023 07:51:18 -0700
Message-ID: <20231024145119.2366588-4-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231024145119.2366588-1-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QXrlSMIZs2y_ZRI-5Y15kpvMRNfBDlk9
X-Proofpoint-ORIG-GUID: QXrlSMIZs2y_ZRI-5Y15kpvMRNfBDlk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_15,2023-10-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add xmit_more handling in tx datapath for octeon_ep pf.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Updated changelog to have imperative tone.
V1: https://lore.kernel.org/all/20231023114449.2362147-3-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_config.h |  2 +-
 .../ethernet/marvell/octeon_ep/octep_main.c   | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

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
index 1c02304677c9..1a88a6bf0598 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -818,6 +818,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	struct octep_iq *iq;
 	skb_frag_t *frag;
 	u16 nr_frags, si;
+	int xmit_more;
 	u16 q_no, wi;
 
 	if (skb_put_padto(skb, ETH_ZLEN))
@@ -895,18 +896,28 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	}
 
 	netdev_tx_sent_queue(iq->netdev_q, skb->len);
+
+	xmit_more = netdev_xmit_more();
+
 	skb_tx_timestamp(skb);
 	atomic_inc(&iq->instr_pending);
+	iq->fill_cnt++;
 	wi++;
 	if (wi == iq->max_count)
 		wi = 0;
 	iq->host_write_index = wi;
+	if (xmit_more &&
+	    (atomic_read(&iq->instr_pending) <
+	     (iq->max_count - OCTEP_WAKE_QUEUE_THRESHOLD)) &&
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

