Return-Path: <linux-kernel+bounces-116047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003B889525
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23861C2F56A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5C2745F6;
	Mon, 25 Mar 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyqnZX7K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597217655C;
	Sun, 24 Mar 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323441; cv=none; b=gp5ALouMSvOkgoIWTeyFrF7GC/daLqFOPrUt+ulbia8Sv8lVKNRqCRNG3CE//qfXnMjGj68tRojJblgzcGQEEgL5IIq4Nk69pxJjOK7ATtS08P+6zSu8CFNc1LrLvUxRViCMJuhSbOjNFTby6hQ4GdizsI9bDkM+WrA7sGDTNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323441; c=relaxed/simple;
	bh=2DvJvaZyFK9vHNgI+suBjYVyGIRaLvxgXFom/JoexWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GazLwXScHDKIDHz7j61NJrSrLn496iXth7TYlYJQoO0snntQvcRjCaAM2zzqwm3yaF1wUVgwSnR1KWiU84MolSy/lr8J+UtfUc7AP514+pNA+hfa3uzBnKR+UiiWPOOfVfcaxeqUz8r0ijH7UBf4CTXOe15knSsDegfpK0Rwi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyqnZX7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A63C43394;
	Sun, 24 Mar 2024 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323439;
	bh=2DvJvaZyFK9vHNgI+suBjYVyGIRaLvxgXFom/JoexWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyqnZX7KW5XsUg9sQMS/CQv//0ixWYKCwJRkgqUeB6Sh1vEEIKEESbsj7YhQJIXm6
	 urENwlYyTuwJ4/oZymyR0NvG8uy9y8389Zgq8mNOLikK0kBNoQJlOPrbGlBufn/qUl
	 VOtZ3BXGyEwQyGE659LIUnWQp6qxHnn09W9M5E2Ysjm8W9Xp6Rk56GRmI3Qen/3ghH
	 Lzf2VXXzhg8VBLXxHMMXmAItKbfRYCKYWUAFzWgFZ/1i7Q7aGj/dMsXbjHTyj7uq/O
	 Q8HbaLhJ+IsIs+QSKNbOQbZi8EfGlkylH7OWNF37V4mmVsWfBXzwxlOTFGzN+el/wC
	 FYJhcS8uyTRyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Pambor <tp@osasysteme.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 142/317] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sun, 24 Mar 2024 19:32:02 -0400
Message-ID: <20240324233458.1352854-143-sashal@kernel.org>
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


