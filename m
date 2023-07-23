Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEEF75E521
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGWV7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGWV7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:59:33 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729DE70;
        Sun, 23 Jul 2023 14:59:07 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qNh6N-0005Rw-34;
        Sun, 23 Jul 2023 21:58:56 +0000
Date:   Sun, 23 Jul 2023 22:58:47 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Ungerer <gerg@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 5/9] net: ethernet: mtk_eth_soc: rely on
 MTK_MAX_DEVS and remove MTK_MAC_COUNT
Message-ID: <e986a507ff30385414f7d3e51195ad1b8bea02db.1690148927.git.daniel@makrotopia.org>
References: <cover.1690148927.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690148927.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Get rid of MTK_MAC_COUNT since it is a duplicated of MTK_MAX_DEVS.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 49 ++++++++++++---------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  1 -
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 206cffb0e5acf..67109a38df31a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -896,7 +896,7 @@ static void mtk_stats_update(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->mac[i] || !eth->mac[i]->hw_stats)
 			continue;
 		if (spin_trylock(&eth->mac[i]->hw_stats->stats_lock)) {
@@ -1401,7 +1401,7 @@ static int mtk_queue_stopped(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
 		if (netif_queue_stopped(eth->netdev[i]))
@@ -1415,7 +1415,7 @@ static void mtk_wake_queue(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
 		netif_tx_wake_all_queues(eth->netdev[i]);
@@ -1874,7 +1874,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			 !(trxd.rxd4 & RX_DMA_SPECIAL_TAG))
 			mac = RX_DMA_GET_SPORT(trxd.rxd4) - 1;
 
-		if (unlikely(mac < 0 || mac >= MTK_MAC_COUNT ||
+		if (unlikely(mac < 0 || mac >= MTK_MAX_DEVS ||
 			     !eth->netdev[mac]))
 			goto release_desc;
 
@@ -2911,7 +2911,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
 	const struct mtk_soc_data *soc = eth->soc;
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++)
+	for (i = 0; i < MTK_MAX_DEVS; i++)
 		if (eth->netdev[i])
 			netdev_reset_queue(eth->netdev[i]);
 	if (eth->scratch_ring) {
@@ -3065,8 +3065,13 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		return;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
-		u32 val = mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		u32 val;
+
+		if (!eth->netdev[i])
+			continue;
+
+		val = mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
 
 		/* default setup the forward port to send frame to PDMA */
 		val &= ~0xffff;
@@ -3076,7 +3081,7 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
 
 		val |= config;
 
-		if (eth->netdev[i] && netdev_uses_dsa(eth->netdev[i]))
+		if (netdev_uses_dsa(eth->netdev[i]))
 			val |= MTK_GDMA_SPECIAL_TAG;
 
 		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
@@ -3678,15 +3683,15 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	 * up with the more appropriate value when mtk_mac_config call is being
 	 * invoked.
 	 */
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		struct net_device *dev = eth->netdev[i];
 
-		mtk_w32(eth, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(i));
-		if (dev) {
-			struct mtk_mac *mac = netdev_priv(dev);
+		if (!dev)
+			continue;
 
-			mtk_set_mcr_max_rx(mac, dev->mtu + MTK_RX_ETH_HLEN);
-		}
+		mtk_w32(eth, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(i));
+		mtk_set_mcr_max_rx(netdev_priv(dev),
+				   dev->mtu + MTK_RX_ETH_HLEN);
 	}
 
 	/* Indicates CDM to parse the MTK special tag from CPU
@@ -3866,7 +3871,7 @@ static void mtk_pending_work(struct work_struct *work)
 	mtk_prepare_for_reset(eth);
 
 	/* stop all devices to make sure that dma is properly shut down */
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i] || !netif_running(eth->netdev[i]))
 			continue;
 
@@ -3882,8 +3887,8 @@ static void mtk_pending_work(struct work_struct *work)
 	mtk_hw_init(eth, true);
 
 	/* restart DMA and enable IRQs */
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
-		if (!test_bit(i, &restart))
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		if (!eth->netdev[i] || !test_bit(i, &restart))
 			continue;
 
 		if (mtk_open(eth->netdev[i])) {
@@ -3910,7 +3915,7 @@ static int mtk_free_dev(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
 		free_netdev(eth->netdev[i]);
@@ -3929,7 +3934,7 @@ static int mtk_unreg_dev(struct mtk_eth *eth)
 {
 	int i;
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		struct mtk_mac *mac;
 		if (!eth->netdev[i])
 			continue;
@@ -4231,7 +4236,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	}
 
 	id = be32_to_cpup(_id);
-	if (id >= MTK_MAC_COUNT) {
+	if (id >= MTK_MAX_DEVS) {
 		dev_err(eth->dev, "%d is not a valid mac id\n", id);
 		return -EINVAL;
 	}
@@ -4391,7 +4396,7 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 
 	rtnl_lock();
 
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		dev = eth->netdev[i];
 
 		if (!dev || !(dev->flags & IFF_UP))
@@ -4697,7 +4702,7 @@ static int mtk_remove(struct platform_device *pdev)
 	int i;
 
 	/* stop all devices to make sure that dma is properly shut down */
-	for (i = 0; i < MTK_MAC_COUNT; i++) {
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
 		if (!eth->netdev[i])
 			continue;
 		mtk_stop(eth->netdev[i]);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9623b909387a3..4dc5611f859b0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -33,7 +33,6 @@
 #define MTK_TX_DMA_BUF_LEN_V2	0xffff
 #define MTK_QDMA_RING_SIZE	2048
 #define MTK_DMA_SIZE		512
-#define MTK_MAC_COUNT		2
 #define MTK_RX_ETH_HLEN		(ETH_HLEN + ETH_FCS_LEN)
 #define MTK_RX_HLEN		(NET_SKB_PAD + MTK_RX_ETH_HLEN + NET_IP_ALIGN)
 #define MTK_DMA_DUMMY_DESC	0xffffffff
-- 
2.41.0
