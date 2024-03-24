Return-Path: <linux-kernel+bounces-115566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF0889C69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D64293D26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816472DC9A3;
	Mon, 25 Mar 2024 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRZ+6A0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554D1F23E8;
	Sun, 24 Mar 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321104; cv=none; b=r5xvcJwS/AKwxiJ/Wo+8Rfck4nuYYVX9NrUv1jyUDO7w++e3cANfk9Q1qU7ziNo3wHXMhGN0Q7bupiwNXtrmXymW6bl1TmvPziOrg9s7AMnpwZmGjpjFd9NyiiOUMTD15MAwCYwg56T+qDhwlUe1WD7L8UhT++Tx0dgLatSmRfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321104; c=relaxed/simple;
	bh=BZgmDLd5CDQduRA26abkoxL+t5neX5ePidXSOkpF1Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJrOWhKdW2dyOFNFLPPWW+ce7kauPyqRpfTPwHLIkcs8qhfVPjMkh5SXaQ78r0+avKGGHRI21037aRYEk+uApqomzYcCk0yiCQ5Tdhzp7cfVwqlLfOR0Psd9+BItrKMuKAkQWKQVUgizU/8FwOM0ZQEXfwk5wQ9ovGk7pvqKdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRZ+6A0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4929EC43399;
	Sun, 24 Mar 2024 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321103;
	bh=BZgmDLd5CDQduRA26abkoxL+t5neX5ePidXSOkpF1Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRZ+6A0MxSRfT7fYSlFKvVEP9sy4XJPhSDF4Lf5MP6l1/Wifz5nUPkel9NzEmQj42
	 pyarGwtTLbRywBusjIrlJb89HYvmNDj1z0j1EMkmpIYVo8sIVH+8sOwUM2lXbQEfy5
	 E0FGSRl05kfC23ijXELJl3kdgQiC0NIJtVmP3bE3+Fj4+JdjYbwfMw38bp+DV4vcKg
	 PV43FFgNQx15ZCFUraVFqQfxoZ1aVlF+nOsnFC7ItyPf54fLjpZkp5czMIZ9p0barL
	 OI9dfW1d7P+829eGz3kr+hIyehUmRezn6o7Lyt6vtVuALp1i9fF8eZeaMlC5pjHqc+
	 zBYU2nHqXs9qA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Mason-cw Chang <Mason-cw.Chang@mediatek.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 665/713] net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
Date: Sun, 24 Mar 2024 18:46:31 -0400
Message-ID: <20240324224720.1345309-666-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index d2c039f830195..a1231203ecf3d 100644
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


