Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877937E15F0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKES67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKES66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:58:58 -0500
Received: from mx4.spacex.com (mx4.spacex.com [192.31.242.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719FDD;
        Sun,  5 Nov 2023 10:58:52 -0800 (PST)
Received: from pps.filterd (mx4.spacex.com [127.0.0.1])
        by mx4.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5IpUD7014252;
        Sun, 5 Nov 2023 10:58:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=dkim; bh=wdggvFhIJ3WirxQj8g6DOpnfSoVFhlM7e9Wii/BAzA8=;
 b=Y6SYV4FN58WUtiOLi8g6Vs3pzuvYpkrz60GTdpOztpVCnYyUjm/kC+xE3/voMSHlvLEe
 hB1JgWjIJyeQEFn6XAMxTAZc+qtrbYxdSeAIT4qdcUksCX9xbgGXe+1/HjQY7BxbjGb0
 Zynj9lWIvr/XieR9roKt37ZXfA8XEk07Zi3grIvUGGQVR2wj3Ry56TF8qRHGsZtboxSD
 +iXVZ1ujFMQ6ZgDRYWehQKFFNggTUpIk/35p5uCEVi/G4FBzYFS613bwJoggjAIhzLTv
 fOHOE6TZdiD0olB6/WxeSESyb8eJ9mJ6LDUJcevgZisnZLO5L+KmIQLl3fRNbc22oAOA 4Q== 
Received: from smtp.spacex.corp ([10.34.3.234])
        by mx4.spacex.com (PPS) with ESMTPS id 3u5kcm0xs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 05 Nov 2023 10:58:51 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 10:58:50 -0800
From:   <alexey.pakhunov@spacex.com>
To:     <mchan@broadcom.com>
CC:     <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siva.kallam@broadcom.com>,
        <prashant@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH v3] tg3: Fix the TX ring stall
Date:   Sun, 5 Nov 2023 10:58:28 -0800
Message-ID: <20231105185828.287004-1-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d2-n3.spacex.corp (10.34.3.235) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: UHPnHwj-J9DfWOVjemUIPmOc9bDnlggP
X-Proofpoint-GUID: UHPnHwj-J9DfWOVjemUIPmOc9bDnlggP
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311050164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

The TX ring maintained by the tg3 driver can end up in the state, when it
has packets queued for sending but the NIC hardware is not informed, so no
progress is made. This leads to a multi-second interruption in network
traffic followed by dev_watchdog() firing and resetting the queue.

The specific sequence of steps is:

1. tg3_start_xmit() is called at least once and queues packet(s) without
   updating tnapi->prodmbox (netdev_xmit_more() returns true)
2. tg3_start_xmit() is called with an SKB which causes tg3_tso_bug() to be
   called.
3. tg3_tso_bug() determines that the SKB is too large, ...

        if (unlikely(tg3_tx_avail(tnapi) <= frag_cnt_est)) {

   ... stops the queue, and returns NETDEV_TX_BUSY:

        netif_tx_stop_queue(txq);
        ...
        if (tg3_tx_avail(tnapi) <= frag_cnt_est)
                return NETDEV_TX_BUSY;

4. Since all tg3_tso_bug() call sites directly return, the code updating
   tnapi->prodmbox is skipped.

5. The queue is stuck now. tg3_start_xmit() is not called while the queue
   is stopped. The NIC is not processing new packets because
   tnapi->prodmbox wasn't updated. tg3_tx() is not called by
   tg3_poll_work() because the all TX descriptions that could be freed has
   been freed:

        /* run TX completion thread */
        if (tnapi->hw_status->idx[0].tx_consumer != tnapi->tx_cons) {
                tg3_tx(tnapi);

6. Eventually, dev_watchdog() fires triggering a reset of the queue.

This fix makes sure that the tnapi->prodmbox update happens regardless of
the reason tg3_start_xmit() returned.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
---
v3: Split "Fix the TX ring stall" into a standalone patch. No code changes from v2.
v2: https://lore.kernel.org/netdev/CACKFLi=ZLAb1Y92LwvqjOGPCuinka7qbHwDP2pkG4-_a7DMorQ@mail.gmail.com/T/#t
    - Sort the local variables in tg3_start_xmit() in the RCS order
v1: https://lore.kernel.org/netdev/20231101191858.2611154-1-alexey.pakhunov@spacex.com/T/#t
---
 drivers/net/ethernet/broadcom/tg3.c | 53 +++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..310f3323fba1 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6603,9 +6603,9 @@ static void tg3_tx(struct tg3_napi *tnapi)
 
 	tnapi->tx_cons = sw_idx;
 
-	/* Need to make the tx_cons update visible to tg3_start_xmit()
+	/* Need to make the tx_cons update visible to __tg3_start_xmit()
 	 * before checking for netif_queue_stopped().  Without the
-	 * memory barrier, there is a small possibility that tg3_start_xmit()
+	 * memory barrier, there is a small possibility that __tg3_start_xmit()
 	 * will miss it and cause the queue to be stopped forever.
 	 */
 	smp_mb();
@@ -7845,7 +7845,7 @@ static bool tg3_tso_bug_gso_check(struct tg3_napi *tnapi, struct sk_buff *skb)
 	return skb_shinfo(skb)->gso_segs < tnapi->tx_pending / 3;
 }
 
-static netdev_tx_t tg3_start_xmit(struct sk_buff *, struct net_device *);
+static netdev_tx_t __tg3_start_xmit(struct sk_buff *, struct net_device *);
 
 /* Use GSO to workaround all TSO packets that meet HW bug conditions
  * indicated in tg3_tx_frag_set()
@@ -7879,7 +7879,7 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-		tg3_start_xmit(seg, tp->dev);
+		__tg3_start_xmit(seg, tp->dev);
 	}
 
 tg3_tso_bug_end:
@@ -7889,7 +7889,7 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 }
 
 /* hard_start_xmit for all devices */
-static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t __tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct tg3 *tp = netdev_priv(dev);
 	u32 len, entry, base_flags, mss, vlan = 0;
@@ -8133,11 +8133,6 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			netif_tx_wake_queue(txq);
 	}
 
-	if (!netdev_xmit_more() || netif_xmit_stopped(txq)) {
-		/* Packets are ready, update Tx producer idx on card. */
-		tw32_tx_mbox(tnapi->prodmbox, entry);
-	}
-
 	return NETDEV_TX_OK;
 
 dma_error:
@@ -8150,6 +8145,42 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct netdev_queue *txq;
+	u16 skb_queue_mapping;
+	netdev_tx_t ret;
+
+	skb_queue_mapping = skb_get_queue_mapping(skb);
+	txq = netdev_get_tx_queue(dev, skb_queue_mapping);
+
+	ret = __tg3_start_xmit(skb, dev);
+
+	/* Notify the hardware that packets are ready by updating the TX ring
+	 * tail pointer. We respect netdev_xmit_more() thus avoiding poking
+	 * the hardware for every packet. To guarantee forward progress the TX
+	 * ring must be drained when it is full as indicated by
+	 * netif_xmit_stopped(). This needs to happen even when the current
+	 * skb was dropped or rejected with NETDEV_TX_BUSY. Otherwise packets
+	 * queued by previous __tg3_start_xmit() calls might get stuck in
+	 * the queue forever.
+	 */
+	if (!netdev_xmit_more() || netif_xmit_stopped(txq)) {
+		struct tg3_napi *tnapi;
+		struct tg3 *tp;
+
+		tp = netdev_priv(dev);
+		tnapi = &tp->napi[skb_queue_mapping];
+
+		if (tg3_flag(tp, ENABLE_TSS))
+			tnapi++;
+
+		tw32_tx_mbox(tnapi->prodmbox, tnapi->tx_prod);
+	}
+
+	return ret;
+}
+
 static void tg3_mac_loopback(struct tg3 *tp, bool enable)
 {
 	if (enable) {
@@ -17680,7 +17711,7 @@ static int tg3_init_one(struct pci_dev *pdev,
 	 * device behind the EPB cannot support DMA addresses > 40-bit.
 	 * On 64-bit systems with IOMMU, use 40-bit dma_mask.
 	 * On 64-bit systems without IOMMU, use 64-bit dma_mask and
-	 * do DMA address check in tg3_start_xmit().
+	 * do DMA address check in __tg3_start_xmit().
 	 */
 	if (tg3_flag(tp, IS_5788))
 		persist_dma_mask = dma_mask = DMA_BIT_MASK(32);

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
2.39.3

