Return-Path: <linux-kernel+bounces-167105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B5C8BA493
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A28D1C22AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BCBE4F;
	Fri,  3 May 2024 00:32:54 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F88BEF;
	Fri,  3 May 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696373; cv=none; b=GtIQFkqZAbFDJa9+1c7uOU9lofq+4WnNY0mo+sOPVf2Pvh6R8KlLMlV+HicqB0UAnDppysVD7RB3nYcKvyrT47kRtzq372hfKJFe6VMUExIO5YPJ+wQcty5lDEEqsm8z6G2HJuOcCsMkJAX1LEPwROID4sEZCkukF2T+n/v6Z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696373; c=relaxed/simple;
	bh=SdCVeQJiT79EaxLVKjj2UoRsmDFDMTaLPUOwkaQzVCY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGvANPvyKhZ0J9cNPB5JMexrsSpqBrhqq0ab2OzSCodRkub5Ccn47k8xVZvIsUbroaHLz2hp6zZbjtWEDiaok42Ot31HNvY12FTPkywfM107AJw/4vzpUmdzu7MK4S4XsJVFX6LTtzYQwSQa0yFNkbVMVdXnEqqNojG3TfTvosw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s2gqz-000000005JV-39Cy;
	Fri, 03 May 2024 00:32:45 +0000
Date: Fri, 3 May 2024 01:32:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 2/2] net: ethernet: mediatek: use QDMA instead of ADMAv2
 on MT7981 and MT7986
Message-ID: <7815c0e3300563ec1d5a15d2080931461c5b2a9a.1714696206.git.daniel@makrotopia.org>
References: <5f5d8880a9ec6339688828d6f33bc95e99c16d81.1714696206.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f5d8880a9ec6339688828d6f33bc95e99c16d81.1714696206.git.daniel@makrotopia.org>

ADMA is plagued by RX hangs which can't easily detected and happen upon
receival of a corrupted package.
Use QDMA just like on netsys v1 which is also still present and usable, and
doesn't suffer from that problem.

Fixes: 197c9e9b17b11 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 46 ++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3eefb735ce19..d7d73295f0dc 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -110,16 +110,16 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.tx_irq_mask		= 0x461c,
 	.tx_irq_status		= 0x4618,
 	.pdma = {
-		.rx_ptr		= 0x6100,
-		.rx_cnt_cfg	= 0x6104,
-		.pcrx_ptr	= 0x6108,
-		.glo_cfg	= 0x6204,
-		.rst_idx	= 0x6208,
-		.delay_irq	= 0x620c,
-		.irq_status	= 0x6220,
-		.irq_mask	= 0x6228,
-		.adma_rx_dbg0	= 0x6238,
-		.int_grp	= 0x6250,
+		.rx_ptr		= 0x4100,
+		.rx_cnt_cfg	= 0x4104,
+		.pcrx_ptr	= 0x4108,
+		.glo_cfg	= 0x4204,
+		.rst_idx	= 0x4208,
+		.delay_irq	= 0x420c,
+		.irq_status	= 0x4220,
+		.irq_mask	= 0x4228,
+		.adma_rx_dbg0	= 0x4238,
+		.int_grp	= 0x4250,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
@@ -1107,7 +1107,7 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
 	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		rxd->rxd5 = READ_ONCE(dma_rxd->rxd5);
 		rxd->rxd6 = READ_ONCE(dma_rxd->rxd6);
 	}
@@ -2028,7 +2028,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			u32 val = RX_DMA_GET_SPORT_V2(trxd.rxd5);
 
 			switch (val) {
@@ -2140,7 +2140,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		skb->dev = netdev;
 		bytes += skb->len;
 
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			reason = FIELD_GET(MTK_RXD5_PPE_CPU_REASON, trxd.rxd5);
 			hash = trxd.rxd5 & MTK_RXD5_FOE_ENTRY;
 			if (hash != MTK_RXD5_FOE_ENTRY)
@@ -2690,7 +2690,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 		rxd->rxd3 = 0;
 		rxd->rxd4 = 0;
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			rxd->rxd5 = 0;
 			rxd->rxd6 = 0;
 			rxd->rxd7 = 0;
@@ -3893,7 +3893,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
 		mtk_w32(eth,  val | BIT(4), MTK_FE_GLO_MISC);
@@ -5169,11 +5169,11 @@ static const struct mtk_soc_data mt7981_data = {
 		.dma_len_offset = 8,
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma_v2),
-		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
-		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
-		.dma_len_offset = 8,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
 	},
 };
 
@@ -5195,11 +5195,11 @@ static const struct mtk_soc_data mt7986_data = {
 		.dma_len_offset = 8,
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma_v2),
-		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
-		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
-		.dma_len_offset = 8,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
 	},
 };
 
-- 
2.45.0

