Return-Path: <linux-kernel+bounces-116102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA8889942
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D933B2A7128
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF873A8FE2;
	Mon, 25 Mar 2024 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McPOlGbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2B1791FF;
	Sun, 24 Mar 2024 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323586; cv=none; b=GyuAkWjvdBEbYDi56PoMlqCzfD2/MpQ1VV11pFyVZQV/w+3dbhb5+cqD6uWooEwQiqJTEq1XYN2VTBf67fjUS9ffN+nW1WVdUXkXYrDq3PwxLvF5SnuUD6h4Y/wFxJHfGcY5TXVU5gXTNFKy0WjP9rlNMV7fTRZJ7YxUhX9mkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323586; c=relaxed/simple;
	bh=3PvprwhOCGenibaX4x5mcox1m9f8MXwYIxwZC7iVdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlDZF77J0v7xR8luSAlFUFtwp7cmVpWzY3Ylpq4l1Cf0P3mi6bAV91vpgnrWNW4B6wlGNOFQxpF1FKgUdPonXvFX8dnzVeKSn3lEk29PO3lxQPIuAMs/CkimImMVvz65hlSNqn13vX6iJnKbjX6yvxRO6UfSzD32CwR0GCUUxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McPOlGbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EFBC41679;
	Sun, 24 Mar 2024 23:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323586;
	bh=3PvprwhOCGenibaX4x5mcox1m9f8MXwYIxwZC7iVdEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McPOlGbBpa6f/2EkGssmRJhf+fZ2aWuNuWq9NV0m9Q+x5BLZbJ538ED6GVSlwCS9l
	 TrcxGnBVjsPigUszrP4gXi1QpkczXrNn7W7PzALczJHjn4LQ2Y2lb77tBkAV2pkJKi
	 cRsXlzIilvanuSMutO1QHTtVuy68h9dArpWeCz9lXBCZamI5VMplxcSq8fEaW8W5UG
	 aU2bP1bcZfvdu50RqD/Ln4SqCyaA4AjKEOI9OoEp6esUHBWIpECeDnlLThDSr1PXuD
	 VlkK7ZmK/tHCpo/7vM/liNFJ1O0We7HHoV9DyyK8jZ7Du6QFf37n3pX3cGMaBoD/iW
	 jtiw0HLPc/5wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 293/317] net: mtk_eth_soc: move MAC_MCR setting to mac_finish()
Date: Sun, 24 Mar 2024 19:34:33 -0400
Message-ID: <20240324233458.1352854-294-sashal@kernel.org>
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

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

[ Upstream commit 0e37ad71b2ff772009595002da2860999e98e14e ]

Move the setting of the MTK_MAC_MCR register from the end of mac_config
into the phylink mac_finish() method, to keep it as the very last write
that is done during configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f1b85ef15a99 ("net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 33 ++++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 139dfdb1e58bd..c9d9a082c9f83 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -223,8 +223,8 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 	struct mtk_mac *mac = container_of(config, struct mtk_mac,
 					   phylink_config);
 	struct mtk_eth *eth = mac->hw;
-	u32 mcr_cur, mcr_new, sid, i;
 	int val, ge_mode, err = 0;
+	u32 sid, i;
 
 	/* MT76x8 has no hardware settings between for the MAC */
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
@@ -359,6 +359,25 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		return;
 	}
 
+	return;
+
+err_phy:
+	dev_err(eth->dev, "%s: GMAC%d mode %s not supported!\n", __func__,
+		mac->id, phy_modes(state->interface));
+	return;
+
+init_err:
+	dev_err(eth->dev, "%s: GMAC%d mode %s err: %d!\n", __func__,
+		mac->id, phy_modes(state->interface), err);
+}
+
+static int mtk_mac_finish(struct phylink_config *config, unsigned int mode,
+			  phy_interface_t interface)
+{
+	struct mtk_mac *mac = container_of(config, struct mtk_mac,
+					   phylink_config);
+	u32 mcr_cur, mcr_new;
+
 	/* Setup gmac */
 	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
 	mcr_new = mcr_cur;
@@ -370,16 +389,7 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 	if (mcr_new != mcr_cur)
 		mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
 
-	return;
-
-err_phy:
-	dev_err(eth->dev, "%s: GMAC%d mode %s not supported!\n", __func__,
-		mac->id, phy_modes(state->interface));
-	return;
-
-init_err:
-	dev_err(eth->dev, "%s: GMAC%d mode %s err: %d!\n", __func__,
-		mac->id, phy_modes(state->interface), err);
+	return 0;
 }
 
 static void mtk_mac_pcs_get_state(struct phylink_config *config,
@@ -562,6 +572,7 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_pcs_get_state = mtk_mac_pcs_get_state,
 	.mac_an_restart = mtk_mac_an_restart,
 	.mac_config = mtk_mac_config,
+	.mac_finish = mtk_mac_finish,
 	.mac_link_down = mtk_mac_link_down,
 	.mac_link_up = mtk_mac_link_up,
 };
-- 
2.43.0


