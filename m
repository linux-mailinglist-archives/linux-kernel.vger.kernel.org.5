Return-Path: <linux-kernel+bounces-113785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8208B888E87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E522906F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9A14D29D;
	Sun, 24 Mar 2024 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR5ACJrl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9B1E4A20;
	Sun, 24 Mar 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320810; cv=none; b=SUSWw2FV1LIRuC9HocgrxLzXYCZK66WeYKxG03rNOnPIfmWE4M951slHxGyrkVc7mc410P7nAktpoLuTkmC+l84iZTvnWTtB69cSF5dg86M2bewWrRnGL+kabKkp59eKJVTIzogDJBENfRNiCXUZ1QX+gdTa0Jw5DMYJhO4SDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320810; c=relaxed/simple;
	bh=eHTqfpRH4w1jwSBCjC/7u/xx40HMa+l75jbyu7n46y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRIuIsgOQWy4iLZg5zlIoe50eZdWjwHq1kpt7OuM4Eq2QyeuTcF0UgStgeihDKVDzj9hWRBGI59UA9mzByVAu33vuvdiK4vtcNsuOEeAZTcALdMxtMCYlIWRMU4xXmyXZ5RE5dnwxb6pVeyfAnoVptsTvk/NIw6ih704rzWu2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR5ACJrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17934C433C7;
	Sun, 24 Mar 2024 22:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320809;
	bh=eHTqfpRH4w1jwSBCjC/7u/xx40HMa+l75jbyu7n46y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rR5ACJrlug4QZ36YQjO3B4dLoZ9SEI+g7m7wm5x67t4Xew1v7mylA8nXUDanRhoj/
	 jyspLp5WcT8/GvxGemcAG8I2uVp+5MT5WSX+qwkL4Ja/E4aOo1YSTRqhKN0DuuBjjd
	 GK67kfT/ECYsWIM0yEMAewCS4JmcTA4COi4FAxYUEjbN8KEpwy1UueEDXrhUK/HNGq
	 rJaQlJY5PKvyrXuVxYaVIC1Z1dE2nRhof7n5okd3yVZvWrOvPMWx+95p/5zdbr2rtT
	 GvDssX95fRVAGExHgtLxsjIZQdEvp5ibPPsVJO2huJQlz4UDaaAzbT/hgRFBmTtuDe
	 wyq4ZZBQFl9AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Pambor <tp@osasysteme.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 374/713] net: phy: dp83822: Fix RGMII TX delay configuration
Date: Sun, 24 Mar 2024 18:41:40 -0400
Message-ID: <20240324224720.1345309-375-sashal@kernel.org>
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
index b7cb71817780c..29e1cbea6dc0c 100644
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


