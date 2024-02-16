Return-Path: <linux-kernel+bounces-69193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232AB858594
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818ABB20A96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320751487D6;
	Fri, 16 Feb 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IH/yY4oR"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5C1350FC;
	Fri, 16 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108972; cv=none; b=Smdb7zEZnScd3onrjqVaXwmjMxum3qRuk65cvOoYUIfwUpuqXTdIcehQgcqtsUqvrMeQuRKfntRz2gIfYDpDvlP16Kt+4n/BC5A/CcXHMbHewNdHXZuhaADVOrXgDNmt5VWmUbSvtqVxAMOeQKYzRGEC2ZcqwNSnUrjDa7+olG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108972; c=relaxed/simple;
	bh=atI59ZlQl2UfZ0o6mIsOBAuc8zQwlqIYK/Qn+yb3SGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rt6OV6aFcmbxAfANa+e0cnZEfJlKy3+I+Mb/JXRJkqsXxmmJAfcoYUNZJFa5r3Kj6z7JeziZHBKuilgNVaOvXO7gI+WfxbctSojw2ZS57GBxSznfEaZfSdyTad74PtzTLr1kSOUpJjBCMpuY/PzjUi0q744Z4RbmQDU82kmXCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IH/yY4oR; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1A455C001CD0;
	Fri, 16 Feb 2024 10:42:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1A455C001CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708108964;
	bh=atI59ZlQl2UfZ0o6mIsOBAuc8zQwlqIYK/Qn+yb3SGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH/yY4oRCbR1PpdzdsKDbn7iEBADnVed9AQW/Ci5NmNGXoKqJxvmLJRD8Ay/jQYCo
	 bbNlFG9raduRNTvoaH/Vf6iERQW+qQ4rDTnj+GjWaLtZcgypZgES6iBUrj5HF5NqpI
	 1k0R1cE3f6wiTdgEotxg7AbBUDFwKVFrVdn5gWXc=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8430718041CAC6;
	Fri, 16 Feb 2024 10:42:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 1/3] net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
Date: Fri, 16 Feb 2024 10:42:35 -0800
Message-Id: <20240216184237.259954-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216184237.259954-1-florian.fainelli@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c            | 91 ++++++++++---------
 include/linux/platform_data/mdio-bcm-unimac.h |  3 +
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 68f8ee0ec8ba..0619e5d596d1 100644
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
@@ -261,17 +275,27 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		priv->wait_func = pdata->wait_func;
 		priv->wait_func_data = pdata->wait_func_data;
 		bus->phy_mask = ~pdata->phy_mask;
+		priv->clk = pdata->clk;
 	} else {
 		bus->name = "unimac MII bus";
 		priv->wait_func_data = priv;
 		priv->wait_func = unimac_mdio_poll;
+		priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	}
+
+	if (IS_ERR(priv->clk))
+		goto out_mdio_free;
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
@@ -286,8 +310,6 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 
 out_mdio_free:
 	mdiobus_free(bus);
-out_clk_disable:
-	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 
@@ -297,34 +319,17 @@ static void unimac_mdio_remove(struct platform_device *pdev)
 
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
index 8a5f9f0b2c52..724e1f57b81f 100644
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
2.34.1


