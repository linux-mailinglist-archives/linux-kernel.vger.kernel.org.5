Return-Path: <linux-kernel+bounces-146493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093788A6605
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35861F237FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A64156240;
	Tue, 16 Apr 2024 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="r4letyF+"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6A136E28;
	Tue, 16 Apr 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255830; cv=none; b=dRgWUSRg5n0RDsKQuFQ11PIZ6Ns0tCGSPBvzV4nDWghTYf2j38LbZwLrbPJ8qLwu8Ez/KIeiDpHC1ZAypnpfoUYm/AL4euh62TQ7U8yMZ1MNmZLrneRUquPzPyc8vqCU0fH5X/EOVZr/QXsgD+2x3S1j0A+EZawW23RL78sdH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255830; c=relaxed/simple;
	bh=mA03cO4LovaIc9VAo9uUmVXN8roU720mR2vgTU68njk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=us+ossXAhl2ADdKRBuy7nga4PHoVceKyOHJWtVyXi1zqncUgDzWwOPXAqDXNbwNxxnmsuWVzTS+9dHd7e35rYycqh9NKoG4DU5icvn1E3ktvMrDzEO+1UzV/SgRpd0X/gP6+ZToxBng/LSIITylNAeb1DPJSM8CAlT39kBFqxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=r4letyF+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/VyoMxOp0tW/NwNVczKS098fiaFyK3/sT1s9b3x3XYI=; b=r4letyF+3ZYFtek1hQzgsvF+Q1
	TZPJwWvDX4IWFreyQeiWVVfAAuLqXHAEKxzdzbXzDSwN/vys6h/EiWXZY3ICQpv+Z6Y4UYMvzxm/5
	byKiVtR9YhXAgPR5YO4HKIvW6HqX45HlL8pvsMY1pS3RD3wuiEu8Y8kf3/4D878UnBak=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rwe6F-001ifE-0A;
	Tue, 16 Apr 2024 10:23:31 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix WED + wifi reset
Date: Tue, 16 Apr 2024 10:23:29 +0200
Message-ID: <20240416082330.82564-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The WLAN + WED reset sequence relies on being able to receive interrupts from
the card, in order to synchronize individual steps with the firmware.
When WED is stopped, leave interrupts running and rely on the driver turning
off unwanted ones.
WED DMA also needs to be disabled before resetting.

Fixes: f78cd9c783e0 ("net: ethernet: mtk_wed: update mtk_wed_stop")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index c895e265ae0e..61334a71058c 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1074,13 +1074,13 @@ mtk_wed_dma_disable(struct mtk_wed_device *dev)
 static void
 mtk_wed_stop(struct mtk_wed_device *dev)
 {
+	mtk_wed_dma_disable(dev);
 	mtk_wed_set_ext_int(dev, false);
 
 	wed_w32(dev, MTK_WED_WPDMA_INT_TRIGGER, 0);
 	wed_w32(dev, MTK_WED_WDMA_INT_TRIGGER, 0);
 	wdma_w32(dev, MTK_WDMA_INT_MASK, 0);
 	wdma_w32(dev, MTK_WDMA_INT_GRP2, 0);
-	wed_w32(dev, MTK_WED_WPDMA_INT_MASK, 0);
 
 	if (!mtk_wed_get_rx_capa(dev))
 		return;
@@ -1093,7 +1093,6 @@ static void
 mtk_wed_deinit(struct mtk_wed_device *dev)
 {
 	mtk_wed_stop(dev);
-	mtk_wed_dma_disable(dev);
 
 	wed_clr(dev, MTK_WED_CTRL,
 		MTK_WED_CTRL_WDMA_INT_AGENT_EN |
@@ -2605,9 +2604,6 @@ mtk_wed_irq_get(struct mtk_wed_device *dev, u32 mask)
 static void
 mtk_wed_irq_set_mask(struct mtk_wed_device *dev, u32 mask)
 {
-	if (!dev->running)
-		return;
-
 	mtk_wed_set_ext_int(dev, !!mask);
 	wed_w32(dev, MTK_WED_INT_MASK, mask);
 }
-- 
2.44.0


