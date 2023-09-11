Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3379A575
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjIKIG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjIKIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:06:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290CE4B;
        Mon, 11 Sep 2023 01:06:06 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B85qO92982463, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B85qO92982463
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:05:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Sep 2023 16:05:48 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:05:45 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <kuba@kernel.org>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net-next 1/2] r8152: remove queuing rx packets in driver
Date:   Mon, 11 Sep 2023 16:05:03 +0800
Message-ID: <20230911080504.5513-424-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911080504.5513-423-nic_swsd@realtek.com>
References: <20230911080504.5513-423-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.228.98]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original way would process all rx and queue the rx packets in the
driver. Now, the process would be broken if the budget is exhausted. And
the remained list would be queue back to rx_done for next schedule.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 52 ++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 332c853ca99b..62f121b462cb 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -871,7 +871,7 @@ struct r8152 {
 	struct tx_agg tx_info[RTL8152_MAX_TX];
 	struct list_head rx_info, rx_used;
 	struct list_head rx_done, tx_free;
-	struct sk_buff_head tx_queue, rx_queue;
+	struct sk_buff_head tx_queue;
 	spinlock_t rx_lock, tx_lock;
 	struct delayed_work schedule, hw_phy_work;
 	struct mii_if_info mii;
@@ -2031,7 +2031,6 @@ static int alloc_all_mem(struct r8152 *tp)
 	INIT_LIST_HEAD(&tp->tx_free);
 	INIT_LIST_HEAD(&tp->rx_done);
 	skb_queue_head_init(&tp->tx_queue);
-	skb_queue_head_init(&tp->rx_queue);
 	atomic_set(&tp->rx_count, 0);
 
 	for (i = 0; i < RTL8152_MAX_RX; i++) {
@@ -2431,24 +2430,6 @@ static int rx_bottom(struct r8152 *tp, int budget)
 	int ret = 0, work_done = 0;
 	struct napi_struct *napi = &tp->napi;
 
-	if (!skb_queue_empty(&tp->rx_queue)) {
-		while (work_done < budget) {
-			struct sk_buff *skb = __skb_dequeue(&tp->rx_queue);
-			struct net_device *netdev = tp->netdev;
-			struct net_device_stats *stats = &netdev->stats;
-			unsigned int pkt_len;
-
-			if (!skb)
-				break;
-
-			pkt_len = skb->len;
-			napi_gro_receive(napi, skb);
-			work_done++;
-			stats->rx_packets++;
-			stats->rx_bytes += pkt_len;
-		}
-	}
-
 	if (list_empty(&tp->rx_done))
 		goto out1;
 
@@ -2484,10 +2465,6 @@ static int rx_bottom(struct r8152 *tp, int budget)
 			unsigned int pkt_len, rx_frag_head_sz;
 			struct sk_buff *skb;
 
-			/* limit the skb numbers for rx_queue */
-			if (unlikely(skb_queue_len(&tp->rx_queue) >= 1000))
-				break;
-
 			pkt_len = le32_to_cpu(rx_desc->opts1) & RX_LEN_MASK;
 			if (pkt_len < ETH_ZLEN)
 				break;
@@ -2525,14 +2502,10 @@ static int rx_bottom(struct r8152 *tp, int budget)
 
 			skb->protocol = eth_type_trans(skb, netdev);
 			rtl_rx_vlan_tag(rx_desc, skb);
-			if (work_done < budget) {
-				work_done++;
-				stats->rx_packets++;
-				stats->rx_bytes += skb->len;
-				napi_gro_receive(napi, skb);
-			} else {
-				__skb_queue_tail(&tp->rx_queue, skb);
-			}
+			work_done++;
+			stats->rx_packets++;
+			stats->rx_bytes += skb->len;
+			napi_gro_receive(napi, skb);
 
 find_next_rx:
 			rx_data = rx_agg_align(rx_data + pkt_len + ETH_FCS_LEN);
@@ -2562,16 +2535,24 @@ static int rx_bottom(struct r8152 *tp, int budget)
 			urb->actual_length = 0;
 			list_add_tail(&agg->list, next);
 		}
+
+		/* Break if budget is exhausted. */
+		if (work_done >= budget)
+			break;
 	}
 
+	/* Splice the remained list back to rx_done */
 	if (!list_empty(&rx_queue)) {
 		spin_lock_irqsave(&tp->rx_lock, flags);
-		list_splice_tail(&rx_queue, &tp->rx_done);
+		list_splice(&rx_queue, &tp->rx_done);
 		spin_unlock_irqrestore(&tp->rx_lock, flags);
 	}
 
 out1:
-	return work_done;
+	if (work_done > budget)
+		return budget;
+	else
+		return work_done;
 }
 
 static void tx_bottom(struct r8152 *tp)
@@ -2989,9 +2970,6 @@ static int rtl_stop_rx(struct r8152 *tp)
 	list_splice(&tmp_list, &tp->rx_info);
 	spin_unlock_irqrestore(&tp->rx_lock, flags);
 
-	while (!skb_queue_empty(&tp->rx_queue))
-		dev_kfree_skb(__skb_dequeue(&tp->rx_queue));
-
 	return 0;
 }
 
-- 
2.41.0

