Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6007D979B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjJ0MRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjJ0MRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:17:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72AD72;
        Fri, 27 Oct 2023 05:17:12 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39R5TxFL012574;
        Fri, 27 Oct 2023 05:17:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=3wc5P8WLQQ7TN5OjSZbRJnjfWuESLwFLz9t5HbnNk6k=;
 b=gr/C/a5jZ+yck+A+xeimVmQhZg4IavskP6U+b4FJuaqmextI4xv7a3A1UlewR+Vlnt25
 1VdqADFlf7Mx+lDvidVIWLWu+OMrt4kN3lOs83uxS0VI2HSWW+vX5JCosrZZIwizEmvs
 +Zo6LagVWCrmk5PwxeVhovuEbuROGpLNSlCxT1e8i3MGYCkoluEr1PIXH8OkCFKferOa
 mph0JZ0LWp1d2VXPJ/jkABHObu1dg/yRvDgOdtDpqOwqkZmb3N8oaBMGm2W6f8ipM5KU
 I6Shb7VwCQE5HsiN670jTrHpJaGJ4wezrK85fUtmZxY+RBZHz3vL7BtNukKe7b6Liwky lA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tywr83b4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 05:17:05 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 05:17:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 27 Oct 2023 05:17:04 -0700
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
        by maili.marvell.com (Postfix) with ESMTP id F0F4A3F709F;
        Fri, 27 Oct 2023 05:17:03 -0700 (PDT)
From:   Shinas Rasheed <srasheed@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next v3 4/4] octeon_ep: remove atomic variable usage in Tx data path
Date:   Fri, 27 Oct 2023 05:16:39 -0700
Message-ID: <20231027121639.2382565-5-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027121639.2382565-1-srasheed@marvell.com>
References: <20231027121639.2382565-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BuBXPUVKdo1UWaqUCkheC4Oau8gX-Xur
X-Proofpoint-ORIG-GUID: BuBXPUVKdo1UWaqUCkheC4Oau8gX-Xur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_10,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace atomic variable "instr_pending" which represents number of
posted tx instructions pending completion, with host_write_idx and
flush_index variables in the xmit and completion processing respectively.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3:
  - No changes.
V2: https://lore.kernel.org/all/20231024145119.2366588-5-srasheed@marvell.com/
  - No changes.
V1: https://lore.kernel.org/all/20231023114449.2362147-4-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_config.h | 1 +
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c   | 9 +++------
 drivers/net/ethernet/marvell/octeon_ep/octep_main.h   | 9 +++++++++
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c     | 5 +----
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h     | 3 ---
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
index ed8b1ace56b9..91cfa19c65b9 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_config.h
@@ -13,6 +13,7 @@
 #define OCTEP_64BYTE_INSTR  64
 
 /* Tx Queue: maximum descriptors per ring */
+/* This needs to be a power of 2 */
 #define OCTEP_IQ_MAX_DESCRIPTORS    1024
 /* Minimum input (Tx) requests to be enqueued to ring doorbell */
 #define OCTEP_DB_MIN                8
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 2d1bcdc589f3..974a34be9ffa 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -777,7 +777,7 @@ static int octep_stop(struct net_device *netdev)
  */
 static inline int octep_iq_full_check(struct octep_iq *iq)
 {
-	if (likely((iq->max_count - atomic_read(&iq->instr_pending)) >=
+	if (likely((IQ_INSTR_SPACE(iq)) >
 		   OCTEP_WAKE_QUEUE_THRESHOLD))
 		return 0;
 
@@ -794,7 +794,7 @@ static inline int octep_iq_full_check(struct octep_iq *iq)
 	/* check again and restart the queue, in case NAPI has just freed
 	 * enough Tx ring entries.
 	 */
-	if (unlikely((iq->max_count - atomic_read(&iq->instr_pending)) >=
+	if (unlikely(IQ_INSTR_SPACE(iq) >
 		     OCTEP_WAKE_QUEUE_THRESHOLD)) {
 		netif_start_subqueue(iq->netdev, iq->q_no);
 		iq->stats.restart_cnt++;
@@ -903,12 +903,9 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 	__netdev_tx_sent_queue(iq->netdev_q, skb->len, xmit_more);
 
 	skb_tx_timestamp(skb);
-	atomic_inc(&iq->instr_pending);
 	iq->fill_cnt++;
 	wi++;
-	if (wi == iq->max_count)
-		wi = 0;
-	iq->host_write_index = wi;
+	iq->host_write_index = wi & iq->ring_size_mask;
 
 	/* octep_iq_full_check stops the queue and returns
 	 * true if so, in case the queue has become full
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
index 6df902ebb7f3..c33e046b69a4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
@@ -40,6 +40,15 @@
 #define  OCTEP_OQ_INTR_RESEND_BIT  59
 
 #define  OCTEP_MMIO_REGIONS     3
+
+#define  IQ_INSTR_PENDING(iq)  ({ typeof(iq) iq__ = (iq); \
+				  ((iq__)->host_write_index - (iq__)->flush_index) & \
+				  (iq__)->ring_size_mask; \
+				})
+#define  IQ_INSTR_SPACE(iq)    ({ typeof(iq) iq_ = (iq); \
+				  (iq_)->max_count - IQ_INSTR_PENDING(iq_); \
+				})
+
 /* PCI address space mapping information.
  * Each of the 3 address spaces given by BAR0, BAR2 and BAR4 of
  * Octeon gets mapped to different physical address spaces in
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index d0adb82d65c3..06851b78aa28 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -21,7 +21,6 @@ static void octep_iq_reset_indices(struct octep_iq *iq)
 	iq->flush_index = 0;
 	iq->pkts_processed = 0;
 	iq->pkt_in_done = 0;
-	atomic_set(&iq->instr_pending, 0);
 }
 
 /**
@@ -82,7 +81,6 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	}
 
 	iq->pkts_processed += compl_pkts;
-	atomic_sub(compl_pkts, &iq->instr_pending);
 	iq->stats.instr_completed += compl_pkts;
 	iq->stats.bytes_sent += compl_bytes;
 	iq->stats.sgentry_sent += compl_sg;
@@ -91,7 +89,7 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
 
 	if (unlikely(__netif_subqueue_stopped(iq->netdev, iq->q_no)) &&
-	    ((iq->max_count - atomic_read(&iq->instr_pending)) >
+	    (IQ_INSTR_SPACE(iq) >
 	     OCTEP_WAKE_QUEUE_THRESHOLD))
 		netif_wake_subqueue(iq->netdev, iq->q_no);
 	return !budget;
@@ -144,7 +142,6 @@ static void octep_iq_free_pending(struct octep_iq *iq)
 		dev_kfree_skb_any(skb);
 	}
 
-	atomic_set(&iq->instr_pending, 0);
 	iq->flush_index = fi;
 	netdev_tx_reset_queue(netdev_get_tx_queue(iq->netdev, iq->q_no));
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 86c98b13fc44..1ba4ff65e54d 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -172,9 +172,6 @@ struct octep_iq {
 	/* Statistics for this input queue. */
 	struct octep_iq_stats stats;
 
-	/* This field keeps track of the instructions pending in this queue. */
-	atomic_t instr_pending;
-
 	/* Pointer to the Virtual Base addr of the input ring. */
 	struct octep_tx_desc_hw *desc_ring;
 
-- 
2.25.1

