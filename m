Return-Path: <linux-kernel+bounces-124520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269F891942
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D36B23F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE003145B14;
	Fri, 29 Mar 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSOfs2CY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECE145355;
	Fri, 29 Mar 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715290; cv=none; b=eEgerIYg8Qmj7mc2ec9ci59N82W37PiieIeBQOsRNuO5eywlP1r9D5Kknf8l2gzFq76auDAmcYXlwyg/6/9SBIbTKSCi1/S6NprBa4R0356Fxq+GHp48KNFVRjeG1e3sW7GV0R3nXtPs+PiiOhf144VLs1xgmPZFraZZWLIg18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715290; c=relaxed/simple;
	bh=02C3NL9QBauJ3N/1o7HGEfBjePGFIDjI3TvXXKYO+cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCs2jdOMz5j5nd3fxkRmTBiPATCE4cusvgv8F8MX+Lx8/H6ITfPtohOaW6riKP7MBq+6fAooun4J7x7NWrLrNNxN1ocs2jHJ7WdoKY92ClPefy2LsJXwAl5tDghtzDmYkFjrdQAu1zL84bwmErCA5+/l6D5l18krJQrXQqWb9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSOfs2CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2F1C43394;
	Fri, 29 Mar 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715289;
	bh=02C3NL9QBauJ3N/1o7HGEfBjePGFIDjI3TvXXKYO+cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSOfs2CYGUyoKNPSSclB+eZBQWhMN3KdY4F1/LibUL1GfLT4Ox1uqkxvT+tgss6IY
	 KMU0S6atMa+T/xTqBOxnr3tSteIlGGfA/j8NcjUokQxGe9c7KA+hz4xs07o7smiE+Z
	 4LpNXNleNLxfGrZ5kBXozcvLJQKW8Z9ZwbHQs7eugMDUfVxLXqIxv4v14Wntly5om0
	 XTr8X+tb9ydF3U11kLDyxAz/1I6/VWn6SGfu7gJQIkGHJiIV3C48Qb7Yrxvu1gKD9B
	 m7GrjlIL2vsegR78x9pJpFTkaZ+o54EEaaDQNHLJaQwaoaxuXVniiwFQYSKGIHxrNL
	 5AN49BJ4lgetQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	opendmb@gmail.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 39/68] net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
Date: Fri, 29 Mar 2024 08:25:35 -0400
Message-ID: <20240329122652.3082296-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit ee975351cf0c2a11cdf97eae58265c126cb32850 ]

Up until now we have managed not to have the mdio-bcm-unimac manage its
clock except during probe and suspend/resume. This works most of the
time, except where it does not.

With a fully modular build, we can get into a situation whereby the
GENET driver is fully registered, and so is the mdio-bcm-unimac driver,
however the Ethernet PHY driver is not yet, because it depends on a
resource that is not yet available (e.g.: GPIO provider). In that state,
the network device is not usable yet, and so to conserve power, the
GENET driver will have turned off its "main" clock which feeds its MDIO
controller.

When the PHY driver finally probes however, we make an access to the PHY
registers to e.g.: disable interrupts, and this causes a bus error
within the MDIO controller space because the MDIO controller clock(s)
are turned off.

To remedy that, we manage the clock around all of the I/O accesses to
the hardware which are done exclusively during read, write and clock
divider configuration.

This ensures that the register space is accessible, and this also
ensures that there are not unnecessarily elevated reference counts
keeping the clocks active when the network device is administratively
turned off. It would be the case with the previous way of managing the
clock.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/mdio/mdio-bcm-unimac.c            | 93 ++++++++++---------
 include/linux/platform_data/mdio-bcm-unimac.h |  3 +
 2 files changed, 53 insertions(+), 43 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 68f8ee0ec8baa..6fe08427fdd4a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -94,6 +94,10 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	int ret;
 	u32 cmd;
 
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
 	/* Prepare the read operation */
 	cmd = MDIO_RD | (phy_id << MDIO_PMD_SHIFT) | (reg << MDIO_REG_SHIFT);
 	unimac_mdio_writel(priv, cmd, MDIO_CMD);
@@ -103,7 +107,7 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 
 	ret = priv->wait_func(priv->wait_func_data);
 	if (ret)
-		return ret;
+		goto out;
 
 	cmd = unimac_mdio_readl(priv, MDIO_CMD);
 
@@ -112,10 +116,15 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	 * that condition here and ignore the MDIO controller read failure
 	 * indication.
 	 */
-	if (!(bus->phy_ignore_ta_mask & 1 << phy_id) && (cmd & MDIO_READ_FAIL))
-		return -EIO;
+	if (!(bus->phy_ignore_ta_mask & 1 << phy_id) && (cmd & MDIO_READ_FAIL)) {
+		ret = -EIO;
+		goto out;
+	}
 
-	return cmd & 0xffff;
+	ret = cmd & 0xffff;
+out:
+	clk_disable_unprepare(priv->clk);
+	return ret;
 }
 
 static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
@@ -123,6 +132,11 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
 {
 	struct unimac_mdio_priv *priv = bus->priv;
 	u32 cmd;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	/* Prepare the write operation */
 	cmd = MDIO_WR | (phy_id << MDIO_PMD_SHIFT) |
@@ -131,7 +145,10 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
 
 	unimac_mdio_start(priv);
 
-	return priv->wait_func(priv->wait_func_data);
+	ret = priv->wait_func(priv->wait_func_data);
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
 }
 
 /* Workaround for integrated BCM7xxx Gigabit PHYs which have a problem with
@@ -178,14 +195,19 @@ static int unimac_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
-static void unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
+static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 {
 	unsigned long rate;
 	u32 reg, div;
+	int ret;
 
 	/* Keep the hardware default values */
 	if (!priv->clk_freq)
-		return;
+		return 0;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	if (!priv->clk)
 		rate = 250000000;
@@ -195,7 +217,8 @@ static void unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
 		pr_warn("Incorrect MDIO clock frequency, ignoring\n");
-		return;
+		ret = 0;
+		goto out;
 	}
 
 	/* The MDIO clock is the reference clock (typically 250Mhz) divided by
@@ -205,6 +228,9 @@ static void unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	reg &= ~(MDIO_CLK_DIV_MASK << MDIO_CLK_DIV_SHIFT);
 	reg |= div << MDIO_CLK_DIV_SHIFT;
 	unimac_mdio_writel(priv, reg, MDIO_CFG);
+out:
+	clk_disable_unprepare(priv->clk);
+	return ret;
 }
 
 static int unimac_mdio_probe(struct platform_device *pdev)
@@ -235,24 +261,12 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
 	if (of_property_read_u32(np, "clock-frequency", &priv->clk_freq))
 		priv->clk_freq = 0;
 
-	unimac_mdio_clk_set(priv);
-
 	priv->mii_bus = mdiobus_alloc();
-	if (!priv->mii_bus) {
-		ret = -ENOMEM;
-		goto out_clk_disable;
-	}
+	if (!priv->mii_bus)
+		return -ENOMEM;
 
 	bus = priv->mii_bus;
 	bus->priv = priv;
@@ -261,17 +275,29 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		priv->wait_func = pdata->wait_func;
 		priv->wait_func_data = pdata->wait_func_data;
 		bus->phy_mask = ~pdata->phy_mask;
+		priv->clk = pdata->clk;
 	} else {
 		bus->name = "unimac MII bus";
 		priv->wait_func_data = priv;
 		priv->wait_func = unimac_mdio_poll;
+		priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	}
+
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
+		goto out_mdio_free;
 	}
+
 	bus->parent = &pdev->dev;
 	bus->read = unimac_mdio_read;
 	bus->write = unimac_mdio_write;
 	bus->reset = unimac_mdio_reset;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", pdev->name, pdev->id);
 
+	ret = unimac_mdio_clk_set(priv);
+	if (ret)
+		goto out_mdio_free;
+
 	ret = of_mdiobus_register(bus, np);
 	if (ret) {
 		dev_err(&pdev->dev, "MDIO bus registration failed\n");
@@ -286,8 +312,6 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 
 out_mdio_free:
 	mdiobus_free(bus);
-out_clk_disable:
-	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
@@ -297,34 +321,17 @@ static void unimac_mdio_remove(struct platform_device *pdev)
 
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
-	clk_disable_unprepare(priv->clk);
-}
-
-static int __maybe_unused unimac_mdio_suspend(struct device *d)
-{
-	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
-
-	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
-	int ret;
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
-
-	unimac_mdio_clk_set(priv);
-
-	return 0;
+	return unimac_mdio_clk_set(priv);
 }
 
 static SIMPLE_DEV_PM_OPS(unimac_mdio_pm_ops,
-			 unimac_mdio_suspend, unimac_mdio_resume);
+			 NULL, unimac_mdio_resume);
 
 static const struct of_device_id unimac_mdio_ids[] = {
 	{ .compatible = "brcm,asp-v2.1-mdio", },
diff --git a/include/linux/platform_data/mdio-bcm-unimac.h b/include/linux/platform_data/mdio-bcm-unimac.h
index 8a5f9f0b2c520..724e1f57b81ff 100644
--- a/include/linux/platform_data/mdio-bcm-unimac.h
+++ b/include/linux/platform_data/mdio-bcm-unimac.h
@@ -1,11 +1,14 @@
 #ifndef __MDIO_BCM_UNIMAC_PDATA_H
 #define __MDIO_BCM_UNIMAC_PDATA_H
 
+struct clk;
+
 struct unimac_mdio_pdata {
 	u32 phy_mask;
 	int (*wait_func)(void *data);
 	void *wait_func_data;
 	const char *bus_name;
+	struct clk *clk;
 };
 
 #define UNIMAC_MDIO_DRV_NAME	"unimac-mdio"
-- 
2.43.0


