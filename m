Return-Path: <linux-kernel+bounces-115992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07198889914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B447728DC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0239A0BD;
	Mon, 25 Mar 2024 03:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMzuknSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF833238F1C;
	Sun, 24 Mar 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322330; cv=none; b=NnIJx5u7S8ofqDt3YZ28Zzj++WLpR5USdBGN7z+o7ptMpAUg9iH9yFvcwpMCWhy/tuOSqIn59h2WvFvQ87uVnUeCEDXtU/RTy9FrCeY1cgt85mmq7jqmOeIHuJDQffJDYY5meXDsm15P+YUpEOU0UaYeI1HgrVxrux7vBgr04kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322330; c=relaxed/simple;
	bh=ZFgXoB+8n6Zrm64r3QBen7eSSIdqIg53Ge4PVdKtACA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBjSFSlG1BTHRhffnut/ShjalukJgKhM1jJSFMKM8TEUeDQukeEEFTECuyKfMoF4k/21aDVQDydqY1sJw+9SgLL4siVAtW2m++2lXW9WC5qHepl34szFianVWp/sfkxBvT0rlg63KzrYGvbkWFS7aPsg7zneh3H94EUypasRTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMzuknSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD40C433A6;
	Sun, 24 Mar 2024 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322330;
	bh=ZFgXoB+8n6Zrm64r3QBen7eSSIdqIg53Ge4PVdKtACA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMzuknSKL+j+E6IpgSkaI8DOeNL/++6eu1Hpng/NDWKbENKALeBxCHDqlDF9RIlu8
	 dZmdRX12O5kkAxW5R7ooAYYHNav0LOdl+5KedkV2jx7i3cqaPFM10umkOeJLC+Orjb
	 STuqUIdjWewR2xe6kndM+sKoUf8Ff6B14A0pOx69+7v7W/e1eCV0zFKVFm9zwAkgIh
	 vUlaNlhwnqgHu8YT4AMfk6y4LjX2y+7JAtpORNrQpxM75j7As6AJKvAYkRyt+maxUo
	 /C+QQWqins5j+EtXryksxZ6wPxJUuRyntu6UXUsAalYQI4/Luim77oiY7e+4YfkLp2
	 aSQ7BYF84go/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 413/451] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
Date: Sun, 24 Mar 2024 19:11:29 -0400
Message-ID: <20240324231207.1351418-414-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 17e6ac4445afc..fecf3dd22dfaa 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -561,8 +561,7 @@ static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
 	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr_new = mcr_cur;
 	mcr_new |= MAC_MCR_IPG_CFG | MAC_MCR_FORCE_MODE |
-		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_FORCE_LINK |
-		   MAC_MCR_RX_FIFO_CLR_DIS;
+		   MAC_MCR_BACKOFF_EN | MAC_MCR_BACKPR_EN | MAC_MCR_RX_FIFO_CLR_DIS;
 
 	/* Only update control register when needed! */
 	if (mcr_new != mcr_cur)
@@ -610,7 +609,7 @@ static void mtk_mac_link_down(struct phylink_config *config, unsigned int mode,
 					   phylink_config);
 	u32 mcr = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 
-	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN);
+	mcr &= ~(MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK);
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
@@ -649,7 +648,7 @@ static void mtk_mac_link_up(struct phylink_config *config,
 	if (rx_pause)
 		mcr |= MAC_MCR_FORCE_RX_FC;
 
-	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN;
+	mcr |= MAC_MCR_TX_EN | MAC_MCR_RX_EN | MAC_MCR_FORCE_LINK;
 	mtk_w32(mac->hw, mcr, MTK_MAC_MCR(mac->id));
 }
 
-- 
2.43.0


