Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954617F4B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjKVPlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjKVPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:40:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF14310DA;
        Wed, 22 Nov 2023 07:35:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20313C43397;
        Wed, 22 Nov 2023 15:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667358;
        bh=05oVsOammWJjU2f3xcyYTcJ1kqfdtStNDvXduEMBc3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hr3voHqMOfYAtp0CxsGPmr1nqqFns3udY0sEhzhvGcuWBNPUI+cliMcuEFv8t1Wsy
         Y651z3WUuE1HmHPFhLaZVrUKJ6UOfdnV9MQFoSZClELnhk4NPOxmDGWlLgVQSAyFzU
         iEGToJy99s6RbBEe7uNp9VNe22G8NCo/28kw4dc5mHKPGZvZhOP5lSmZRR2oqvlndu
         6UWjZ/B8POq11UOEIL5reDfuKZL5WN4prIzFGIXogrQ/3WqqDZSNLSlgvhkxMaRl4m
         Zl6dE6bplHJjpzYouv3UEUfLuAR4c+tEgu95iBPfOxHxp0wQ0F6+wDR3DlQsFmyNn+
         +vsdzL8VzU5hA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Pakhunov <alexey.pakhunov@spacex.com>,
        Vincent Wong <vincent.wong2@spacex.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, pavan.chebbi@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/7] tg3: Move the [rt]x_dropped counters to tg3_napi
Date:   Wed, 22 Nov 2023 10:35:32 -0500
Message-ID: <20231122153541.853179-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153541.853179-1-sashal@kernel.org>
References: <20231122153541.853179-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.201
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 907d1bdb8b2cc0357d03a1c34d2a08d9943760b1 ]

This change moves [rt]x_dropped counters to tg3_napi so that they can be
updated by a single writer, race-free.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-1-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 38 +++++++++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h |  4 +--
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 5647833303a44..a2c6c204fe9d4 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6864,7 +6864,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -8161,7 +8161,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9340,7 +9340,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9361,6 +9361,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
 		/* And make sure the next sample is new data */
 		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
+
+		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i) {
+			struct tg3_napi *tnapi = &tp->napi[i];
+
+			tnapi->rx_dropped = 0;
+			tnapi->tx_dropped = 0;
+		}
 	}
 
 	return err;
@@ -11915,6 +11922,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11961,8 +11971,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 	stats->rx_missed_errors = old_stats->rx_missed_errors +
 		get_stat64(&hw_stats->rx_discards);
 
-	stats->rx_dropped = tp->rx_dropped;
-	stats->tx_dropped = tp->tx_dropped;
+	/* Aggregate per-queue counters. The per-queue counters are updated
+	 * by a single writer, race-free. The result computed by this loop
+	 * might not be 100% accurate (counters can be updated in the middle of
+	 * the loop) but the next tg3_get_nstats() will recompute the current
+	 * value so it is acceptable.
+	 *
+	 * Note that these counters wrap around at 4G on 32bit machines.
+	 */
+	rx_dropped = (unsigned long)(old_stats->rx_dropped);
+	tx_dropped = (unsigned long)(old_stats->tx_dropped);
+
+	for (i = 0; i < tp->irq_cnt; i++) {
+		struct tg3_napi *tnapi = &tp->napi[i];
+
+		rx_dropped += tnapi->rx_dropped;
+		tx_dropped += tnapi->tx_dropped;
+	}
+
+	stats->rx_dropped = rx_dropped;
+	stats->tx_dropped = tx_dropped;
 }
 
 static int tg3_get_regs_len(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 1000c894064f0..8d753f8c5b065 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3018,6 +3018,7 @@ struct tg3_napi {
 	u16				*rx_rcb_prod_idx;
 	struct tg3_rx_prodring_set	prodring;
 	struct tg3_rx_buffer_desc	*rx_rcb;
+	unsigned long			rx_dropped;
 
 	u32				tx_prod	____cacheline_aligned;
 	u32				tx_cons;
@@ -3026,6 +3027,7 @@ struct tg3_napi {
 	u32				prodmbox;
 	struct tg3_tx_buffer_desc	*tx_ring;
 	struct tg3_tx_ring_info		*tx_buffers;
+	unsigned long			tx_dropped;
 
 	dma_addr_t			status_mapping;
 	dma_addr_t			rx_rcb_mapping;
@@ -3219,8 +3221,6 @@ struct tg3 {
 
 
 	/* begin "everything else" cacheline(s) section */
-	unsigned long			rx_dropped;
-	unsigned long			tx_dropped;
 	struct rtnl_link_stats64	net_stats_prev;
 	struct tg3_ethtool_stats	estats_prev;
 
-- 
2.42.0

