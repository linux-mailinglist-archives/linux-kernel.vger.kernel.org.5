Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B967D3521
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJWLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbjJWLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:45:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3610C;
        Mon, 23 Oct 2023 04:45:14 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39MMm3GN014345;
        Mon, 23 Oct 2023 04:45:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=R2i59IltX6G13d4qYq4yJKDDqV82Pei87fS6LmLOrQs=;
 b=M0JTptV0VgF0rTtqYxiWPCUZTBNpTGCb1P8Tjj/30YiyYS+jIh4i2D8D9g9lJTvAJd7O
 g4pEE0IiCNTTs9qviVKvm7vdD4XkIsEbgTo2Bv82l0X8wN4Ir4m1lFRF5t6M9Ii8chYh
 rP8A3sz2MikQDuxluHR8BDSrLxovruNI8EYNkhGSHMxF/+paVzqZyj/VVSEoKcZdHiL/
 OooFXCiJcrsFawMRZYVYDXSCgVan7O90PQCp+lSamrhUarfI5rGJDpjz6HRwE1of3hgT
 hKF0oE+8wopMGgMvD8KJwNbbUiSsF+KauhkB1PbH20Q6uL2kd0iyuGQeTKvO1VvOdY8W 2g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tvc0qp119-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 04:45:08 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 04:45:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 23 Oct 2023 04:45:07 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id 516BF3F70C4;
        Mon, 23 Oct 2023 04:45:07 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>,
        Shinas Rasheed <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next 2/3] octeon_ep: implement xmit_more in transmit
Date:   Mon, 23 Oct 2023 04:44:47 -0700
Message-ID: <20231023114449.2362147-3-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023114449.2362147-1-srasheed@marvell.com>
References: <20231023114449.2362147-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: v4wqu8SxedGL9TnnMBbQinpOVavg1BEf
X-Proofpoint-GUID: v4wqu8SxedGL9TnnMBbQinpOVavg1BEf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_10,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds xmit_more handling in tx datapath for octeon_ep pf.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
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
index bf1e376a4232..730443ba2f5b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -818,6 +818,7 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	struct octep_iq *iq;
 	skb_frag_t *frag;
 	u16 nr_frags, si;
+	int xmit_more;
 	u16 q_no, wi;
 
 	q_no = skb_get_queue_mapping(skb);
@@ -892,18 +893,28 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
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

