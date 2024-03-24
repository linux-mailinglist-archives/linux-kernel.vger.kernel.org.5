Return-Path: <linux-kernel+bounces-116158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D48899CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D31D1C20E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445542827D4;
	Mon, 25 Mar 2024 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbz10e9J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351D17B513;
	Sun, 24 Mar 2024 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323726; cv=none; b=S3V5YVnVJuig5LzfyFrjWk1VqkWSB57u3jI7YdSt3rwBYUOVDUAZbVzv9KtGF5JGZReLjs8vuwo753JbvB6S3+8tfFInBOju6UoSh7cckzYkx4t4lCHOavE/DmTaot+pBSwT5YD7eSforNhml7NAlITbYGgUxa9qh2k4niTAxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323726; c=relaxed/simple;
	bh=CkgFxL9FgjAMNaLTaZvuR6d3RbTc8CUeahwUgaq3dA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzHs0gkZ+9W5R1rEo9Z0L6hbAFoc9ADYUDArkstXTFqna4Udm/e08LbN+WLRvagWfh4SBJyCQNn+vPXKONmka6KZmKpIwLX48EgBMo600OPUGbzU+4G43mOTi932oMBIDP3ILiIPMpa6O03sr8XG4tJ2dwkG+BlQtcSnEHV6ZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbz10e9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AD4C433F1;
	Sun, 24 Mar 2024 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323725;
	bh=CkgFxL9FgjAMNaLTaZvuR6d3RbTc8CUeahwUgaq3dA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbz10e9JoAp2H3rTMtvaaCNublGsmFvDANLwrmj3XzkKkzEkQdEIWCY4ouLgvWKIs
	 zKVkTuxLcn5qzxpZefWRwy8LzowStb8Aqo3ye5ORybinfiysL2WSNsnUzSEP5HFZbN
	 NGzi53/kxrBwdIHjIqnrlYenlcMtJ8rrPsiWkeIL4ENi56n3SfKESJyHgNiD6g5+t6
	 xOAoB7TPcmEAo6Vw6yZ/R9Jzix4qRZjFp53la/U33tpWRwpdrGNmteUnKzE1iVKfii
	 h5EZAXWxPqQnUGT/IihVzokRT5J75KL9dr7sAn1Gpk5E1xQWQ4fmdXJfHp/3CGKBGG
	 NR/jDNZo47WhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Pambor <tp@osasysteme.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/238] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sun, 24 Mar 2024 19:38:06 -0400
Message-ID: <20240324234027.1354210-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index dce87589b1120..14c5e082ccc8f 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -359,7 +359,7 @@ static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
-	int rgmii_delay;
+	int rgmii_delay = 0;
 	s32 rx_int_delay;
 	s32 tx_int_delay;
 	int err = 0;
@@ -369,30 +369,33 @@ static int dp83822_config_init(struct phy_device *phydev)
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


