Return-Path: <linux-kernel+bounces-37325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D583AE41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2135F1F231A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB30C7CF35;
	Wed, 24 Jan 2024 16:22:34 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9E7C094;
	Wed, 24 Jan 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113354; cv=none; b=FTB17m3VKTL11arhjN6EZ8uNeJZtvLqChNBn9j4jrITu+EnoVa2R5p4tlV9coAAvLmiCKDsAIlH3i0CcONaiwOEeXBi0P+1ZibjTl23MrtXHoXOus4frt8/pjEZP+p2RN/1ApMBZDU2pLee7r0epP5wOomGVH2InZbexqhVBFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113354; c=relaxed/simple;
	bh=TFu4AyGknFyGV9bta9ypoZFYCdDwc0WAWdjNP2wbiQw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=skIgQc8TfT7uxeB1GT0IMAuQ8Cr1TV0+2H+A/VWFvA10nroaQfc2rPQUDdHKascEtEY/UNw0ICF85/pou4RCx0nmwkE1zg15ReeAhUOTw4SjAhF242QV/rQVVu7ajuBXyZHyHEgpLOHWwPXUDMszjQnU3AJ2emc1xKDzuQY0c2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rSg12-0004Wm-0B;
	Wed, 24 Jan 2024 16:22:17 +0000
Date: Wed, 24 Jan 2024 16:22:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: set DMA coherent mask to get
 PPE working
Message-ID: <97e90925368b405f0974b9b15f1b7377c4a329ad.1706113251.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
total: 0 errors, 1 warnings, 0 checks, 11 lines checked

Set DMA coherent mask to 32-bit which makes PPE offloading engine start
working on BPi-R4 which got 4 GiB of RAM.

Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
Suggested-by: Elad Yifee <eladwf@users.github.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a6e91573f8dae..de123350bd46b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4761,7 +4761,10 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(36));
+		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(36));
+		if (!err)
+			err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+
 		if (err) {
 			dev_err(&pdev->dev, "Wrong DMA config\n");
 			return -EINVAL;
-- 
2.43.0


