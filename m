Return-Path: <linux-kernel+bounces-114446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE4888A83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E846B28D416
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D3179973;
	Sun, 24 Mar 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOvOhti1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5521EB6A;
	Sun, 24 Mar 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321867; cv=none; b=fE+vVa1iumi1/CbXqKkZVl9RY2BMZbAnLZEUrRPSuCKIEjeCwLCoviiZYyuiBb4f8OiSt8mrBETASTIPiBWnQj+4xfFlxWgw9BcL/MAafADSByH991fatO2287YPAmuqroV5qC+7eFr/0RZ2XTi2E5ruXr4//j4lTPEaBEmEaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321867; c=relaxed/simple;
	bh=xFmalPXUyHMT43mu7SXxOmvSLtPz1Qdb9JEokr5nNvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH+RgznJlXRR8M4ORSuc1qPGIMmcK9kJYYb4hWJvpzhxGdfpQDdRC6MP7H+OhG6q3BoZvjlRZAavv8EhS3XuhS5iOTfKbbeCdGQP3Ruad9qh91ZiAOwmeMf86yonX7gQ7mCLcQki4ElU1H3p38LoqAAvwlFuhEmVcFyZgh8A/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOvOhti1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C5C433A6;
	Sun, 24 Mar 2024 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321866;
	bh=xFmalPXUyHMT43mu7SXxOmvSLtPz1Qdb9JEokr5nNvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOvOhti1vKTROUOiKturLVtueoU52kQRZPjh8/CjeQ+dZmRGWyCUOb+Wh6pyH3vV3
	 r4eMpVLK5A0RdOz164oR0L9GVcRstUXTlylHfMS34syJPAqObeum08sWLog+jRA7sr
	 6atSB6AtWg/fjGM6ShkJNzQdkG4s/D4IdSqnbdtCYiDC50f1zIfm2ebsLE6Pyto9Ee
	 2hCfdv4a3HFwfZUUsRl8DMvS/z6Sx/lKBzfzcwwuNR646a9mjXvt69B/qZxJe0JIvo
	 Hsb5yziLJ2ui4LnXDP+OS/1yFLvCX0Tccn2SAB6xB/4FTIu923K4hlPY8jVvF+GJa1
	 xHSDlylkN3iVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 594/638] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
Date: Sun, 24 Mar 2024 19:00:31 -0400
Message-ID: <20240324230116.1348576-595-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit f1b85ef15a99f06ed48871ce933d591127d2dcc0 ]

Clearing bit MAC_MCR_FORCE_LINK which forces the link down too early
can result in MAC ending up in a broken/blocked state.

Fix this by handling this bit in the .mac_link_up and .mac_link_down
calls instead of in .mac_finish.

Fixes: b8fc9f30821e ("net: ethernet: mediatek: Add basic PHYLINK support")
Suggested-by: Mason-cw Chang <Mason-cw.Chang@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 73ea1e22b1fa2..bdc424123ee6c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -676,8 +676,7 @@ static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
 	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr_new = mcr_cur;
 	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
-		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_LINK |
-		   MAC_MCR_RX_FIFO_CLR_DIS;
+		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_RX_FIFO_CLR_DIS;
 
 	/* Only update control register when needed! */
 	if (mcr_new != mcr_cur)
@@ -693,7 +692,7 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 					   phylink_config);
 	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
+	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -802,7 +801,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
-	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN;
+	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
-- 
2.43.0


