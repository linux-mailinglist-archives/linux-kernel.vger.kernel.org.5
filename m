Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109976895D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGaAZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaAZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:25:37 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73131A3;
        Sun, 30 Jul 2023 17:25:33 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQGip-0005ue-2B;
        Mon, 31 Jul 2023 00:25:16 +0000
Date:   Mon, 31 Jul 2023 01:24:22 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2] net: ethernet: mtk_eth_soc: support per-flow
 accounting on MT7988
Message-ID: <66032a4e2093ef82d2035966212c5a2ef2b6fdc9.1690762860.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NETSYS_V3 uses 64 bits for each counters while older SoCs were using
48 bits for each counter.
Support reading per-flow byte and package counters on NETSYS_V3.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: fix typo bytes_cnt_* -> byte_cnt_*

 drivers/net/ethernet/mediatek/mtk_eth_soc.c  |  1 +
 drivers/net/ethernet/mediatek/mtk_ppe.c      | 18 ++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_ppe_regs.h |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 05be702f19c5e..1b89f800f6dff 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5064,6 +5064,7 @@ static const struct mtk_soc_data mt7988_data = {
 	.version = 3,
 	.offload_version = 2,
 	.hash_offset = 4,
+	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma_v2),
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index bf1ecb0c1c109..dd2df32b29c3b 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -107,10 +107,20 @@ static int mtk_mib_entry_read(struct mtk_ppe *ppe, u16 index, u64 *bytes, u64 *p
 	cnt_r1 = readl(ppe->base + MTK_PPE_MIB_SER_R1);
 	cnt_r2 = readl(ppe->base + MTK_PPE_MIB_SER_R2);
 
-	byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
-	byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
-	pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
-	pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
+	if (mtk_is_netsys_v3_or_greater(ppe->eth)) {
+		/* 64 bit for each counter */
+		byte_cnt_low = cnt_r0;
+		byte_cnt_high = cnt_r1;
+		pkt_cnt_low = cnt_r2;
+		pkt_cnt_high = readl(ppe->base + MTK_PPE_MIB_SER_R3);
+	} else {
+		/* 48 bit for each counter */
+		byte_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R0_BYTE_CNT_LOW, cnt_r0);
+		byte_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R1_BYTE_CNT_HIGH, cnt_r1);
+		pkt_cnt_low = FIELD_GET(MTK_PPE_MIB_SER_R1_PKT_CNT_LOW, cnt_r1);
+		pkt_cnt_high = FIELD_GET(MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH, cnt_r2);
+	}
+
 	*bytes = ((u64)byte_cnt_high << 32) | byte_cnt_low;
 	*packets = (pkt_cnt_high << 16) | pkt_cnt_low;
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
index a2e61b3eb006d..3ce088eef0efd 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_regs.h
@@ -163,6 +163,8 @@ enum {
 #define MTK_PPE_MIB_SER_R2			0x348
 #define MTK_PPE_MIB_SER_R2_PKT_CNT_HIGH		GENMASK(23, 0)
 
+#define MTK_PPE_MIB_SER_R3			0x34c
+
 #define MTK_PPE_MIB_CACHE_CTL			0x350
 #define MTK_PPE_MIB_CACHE_CTL_EN		BIT(0)
 #define MTK_PPE_MIB_CACHE_CTL_FLUSH		BIT(2)
-- 
2.41.0

