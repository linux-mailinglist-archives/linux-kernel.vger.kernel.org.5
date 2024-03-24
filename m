Return-Path: <linux-kernel+bounces-113554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAF888541
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE8D1C24941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134221C4AF8;
	Sun, 24 Mar 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+3TP6jl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AC1C3A18;
	Sun, 24 Mar 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320357; cv=none; b=kRAz/0vNtgeIMxU71c8WvpzTkF1n2zOiiYq5SoaxfSn2ZDvACr+Ns/yrpkbq0HhiXfkuPrgYv/emOHKxmy9wgo+Nv1LWFLPTfGYgaIeRIjxqAcc+Y+1rRO2yKv4iy/aEupRUKvKye+hg+Bn3S6bQ6zQCxWM2rZ+3WLTCwesGDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320357; c=relaxed/simple;
	bh=8kKCXdsG1YuHVdxxCYC+5MupMtZMu+m8iBCDsAO3Pi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASdfylORbXL97RaWao1PwA8NzLjXUiPJ4q1XO4KoUmu7InndB7FAsj3wbW3PRewuxdC58hNKVN4HhMUOS1qLKfP2oMOzAI6J/pulL46hsbR6qLAe6bdM6Tt7d9Wz1J44rdnvScsdHK9o9Y+0XmpkMwN8D+xv3bn7ShsM1gKyFvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+3TP6jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079D9C433A6;
	Sun, 24 Mar 2024 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320356;
	bh=8kKCXdsG1YuHVdxxCYC+5MupMtZMu+m8iBCDsAO3Pi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+3TP6jlhFKamzFfH9E57JjClS8qBdC6IQiPBlQwADiKQ0RhVCMX/2cdWPVDGrXuR
	 /AG0y7fO4DEt/6HcwAH1kAmmFEkhe9nJ2j+6UT+SDEMg8ugfSUEFya93yAjXu/YE0S
	 J/Myi0IW+3x3NIixs+NiXq3Je4dP19pDBXFBi92RXZBwS/zlvXFpxo0i/BWdilm3UF
	 bFTVs1DN2ft1EgIB5QdFn/yyFDCcb0MJa9Jdax2kpaHNNi6YzRKQdygT50XCH8Hp07
	 KkwVnLdhtisrfVEE3xMh92vUNGK3mX06UXOcjGxAov2sQ2m+pXwefZYzSd2X8nFnWQ
	 GSDUmM9X/MvdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 663/715] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
Date: Sun, 24 Mar 2024 18:34:02 -0400
Message-ID: <20240324223455.1342824-664-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index de123350bd46b..caa13b9cedff0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -677,8 +677,7 @@ static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
 	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr_new = mcr_cur;
 	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
-		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_LINK |
-		   MAC_MCR_RX_FIFO_CLR_DIS;
+		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_RX_FIFO_CLR_DIS;
 
 	/* Only update control register when needed! */
 	if (mcr_new != mcr_cur)
@@ -694,7 +693,7 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 					   phylink_config);
 	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
+	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -803,7 +802,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
-	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN;
+	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
-- 
2.43.0


