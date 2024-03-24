Return-Path: <linux-kernel+bounces-115938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891988894E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131421F2F22C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E138E70E;
	Mon, 25 Mar 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUSX+/mq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5231487F8;
	Sun, 24 Mar 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322145; cv=none; b=Q8gs8hbHgvTpPAHNGNSJbqlzS9ecD35oxgFuZLNUT7GhVhBVEQX89W857OhCd0jPsBWpmRHO0WVcO+VfusOeHLcNYyuovN/7xqcWuQrceTkUmDAoCXxzpBEdcVG3Nyr02L1ZaWZl1IXUW0mA7n1Llf5f7WiegeJ4nPV29kOay7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322145; c=relaxed/simple;
	bh=2DvJvaZyFK9vHNgI+suBjYVyGIRaLvxgXFom/JoexWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oailKz4w+3cycjRxSh7yLrf7o2YRgmKsdMNfExFM9upmmBRYCpWxOJ9Cp4oK4UBcgkCIaqV59a1OVdKwaaIOk5C4XhHd8400QoewDxVxzC1Xq1oth+wO/iXGSlRJBghNQkwnaWw/Ti+8d5IfiKi0KX9D3qgbKhKtsm2Ps76H3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUSX+/mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88021C433F1;
	Sun, 24 Mar 2024 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322145;
	bh=2DvJvaZyFK9vHNgI+suBjYVyGIRaLvxgXFom/JoexWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qUSX+/mqpQJWjKOBmr71gAq83CcFFFocgCw/i+PCkuo1cd7LrDv2F68aJ99fN+Czi
	 BfcJXB1BGrklIhKWGKVmI9ajCqblEURgU8dwgvAVD1r8/fI89uL506uEIf+cwvhFIX
	 xcjqMB/9k5ChoRHZf6gI83rGm2qMIaxurhHBY33eaAiyJ1wZxWY0S66cEjFoP/BZgT
	 0mLYR9s0ERlnIIcP3IYlKfCMvQkf+nWsuOugi1qkzpB0R6V2XN5FuLa8PYnTdfOX52
	 hK+UpyolZCMKKMcoZUmvee4LOnZSkn+t6f4DROkcoUsTPp6bDD9H3Vs+uTnryJ1iKu
	 4/C6QbciGfv4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Pambor <tp@osasysteme.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 222/451] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sun, 24 Mar 2024 19:08:18 -0400
Message-ID: <20240324231207.1351418-223-sashal@kernel.org>
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

From: Tim Pambor <tp@osasysteme.de>

[ Upstream commit c8a5c731fd1223090af57da33838c671a7fc6a78 ]

The logic for enabling the TX clock shift is inverse of enabling the RX
clock shift. The TX clock shift is disabled when DP83822_TX_CLK_SHIFT is
set. Correct the current behavior and always write the delay configuration
to ensure consistent delay settings regardless of bootloader configuration.

Reference: https://www.ti.com/lit/ds/symlink/dp83822i.pdf p. 69

Fixes: 8095295292b5 ("net: phy: DP83822: Add setting the fixed internal delay")
Signed-off-by: Tim Pambor <tp@osasysteme.de>
Link: https://lore.kernel.org/r/20240305110608.104072-1-tp@osasysteme.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83822.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 267e6fd3d4448..57411ee1d8374 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -380,7 +380,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
-	int rgmii_delay;
+	int rgmii_delay = 0;
 	s32 rx_int_delay;
 	s32 tx_int_delay;
 	int err = 0;
@@ -390,30 +390,33 @@ static int dp83822_config_init(struct phy_device *phydev)
 		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      true);
 
-		if (rx_int_delay <= 0)
-			rgmii_delay = 0;
-		else
-			rgmii_delay = DP83822_RX_CLK_SHIFT;
+		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
+		if (rx_int_delay > 0)
+			rgmii_delay |= DP83822_RX_CLK_SHIFT;
 
 		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
 						      false);
+
+		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
 		if (tx_int_delay <= 0)
-			rgmii_delay &= ~DP83822_TX_CLK_SHIFT;
-		else
 			rgmii_delay |= DP83822_TX_CLK_SHIFT;
 
-		if (rgmii_delay) {
-			err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					       MII_DP83822_RCSR, rgmii_delay);
-			if (err)
-				return err;
-		}
+		err = phy_modify_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+				     DP83822_RX_CLK_SHIFT | DP83822_TX_CLK_SHIFT, rgmii_delay);
+		if (err)
+			return err;
+
+		err = phy_set_bits_mmd(phydev, DP83822_DEVADDR,
+				       MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
 
-		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+		if (err)
+			return err;
 	} else {
-		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
-					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+		err = phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					 MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+
+		if (err)
+			return err;
 	}
 
 	if (dp83822->fx_enabled) {
-- 
2.43.0


