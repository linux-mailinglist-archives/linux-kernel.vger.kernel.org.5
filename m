Return-Path: <linux-kernel+bounces-116103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132A889948
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D41C2FD68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0AF3A8FF4;
	Mon, 25 Mar 2024 03:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBkrxt/F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD1179209;
	Sun, 24 Mar 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323588; cv=none; b=TFdl28205EA+zhW6YJ5UzQF4dTky0nF3j9QpWCSJr5Kt8Cush8XLQIZ55Q3Jq3AjWhxdMA9e1OiFN/Kn+IyrH4QLvt7k9L7fVNF2VPqWgx/mEMLaoMxxdSdLgzaPQzGQNmRRc+c6In+i89zAUdK00Y1IVPc0WeqjIZHOcpL35SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323588; c=relaxed/simple;
	bh=mLe7etEiwquXUByGhvEO3SZkbsEnc4tMVWqbzkIk/eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CARb/aaP6YzaA2DEZLtmpxxg3qiOho9ERVUldprNJ5ercW7iebEFbAdiCAmLjIvajA1w3b8ZqbKIu2CFXhhtHUWgzpYijPKs3ghEAIkBGN0IadUhzjt3Yx0VcWko4r7ai4DMdZF41sf4sy3WwyuKqdWFPeMR95aVAZWMhC63heo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBkrxt/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA7CC43394;
	Sun, 24 Mar 2024 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323587;
	bh=mLe7etEiwquXUByGhvEO3SZkbsEnc4tMVWqbzkIk/eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBkrxt/FKhQux0iOfn9bPuh49wUYC1ipoB/Oo7g447mU7qsI8tPolMQrLTFv1Q/ye
	 W6ARVLDEUZBlVUpTQN7RnsFXyx7dJCxLSjiwn1rp4nM0g6/0u10NOyQ6yubf+6xfm9
	 LBkvFBDrnGM+5EuigesIP8yIAp+SEX6eS29uKrZud9aQtBAQ8Oh1ty8om2VGkKnPJD
	 Cv1+fZZAcoNMHT8meFfGaNZYD0muVGonssEQmLw00pXzjGB8wPmLIW7+JdzoLLKult
	 pMgfbdZo/q6nXEUKLp1QTLp+2+uZznaO0aj4SSCz9TZe/YQ9xADSCECIdt/0RViN8y
	 kFsnQHd19VlGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 294/317] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
Date: Sun, 24 Mar 2024 19:34:34 -0400
Message-ID: <20240324233458.1352854-295-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index c9d9a082c9f83..711acc6059a4f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -382,8 +382,7 @@ static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
 	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr_new = mcr_cur;
 	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
-		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_LINK |
-		   MAC_MCR_RX_FIFO_CLR_DIS;
+		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_RX_FIFO_CLR_DIS;
 
 	/* Only update control register when needed! */
 	if (mcr_new != mcr_cur)
@@ -439,7 +438,7 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 					   phylink_config);
 	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
+	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -477,7 +476,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
-	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN;
+	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
-- 
2.43.0


