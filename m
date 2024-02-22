Return-Path: <linux-kernel+bounces-76339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B342485F5CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FCD1C235E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AA44C6B;
	Thu, 22 Feb 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N8pQdRn/"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E803F9EF;
	Thu, 22 Feb 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597891; cv=none; b=olKKAmiex/ga8/KRODBj1uDVQ3FfKEEuwCFZedyP78TU7R4UHDL/izP7vovlzf8vuD0z5D1R31UEWSAUKq1Xmpl2XNRRzurTTYgL34d+zIiEPEZ54/0UcCDAsTGWEdYw8TbY/ADOGVGdiLFDYJ0+d1ztjeo88mxyB7hIGGnqkLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597891; c=relaxed/simple;
	bh=6e8t3ifHPLtPmBHbfdKNgpyW1ydO5nrnXft3+pBt3j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp1nFbr6ZoBb2Wznun1Hl3Nv35Gf4Fb+zAaqDuf4J+jOpl9O5uQxGwcNPKYaU6zYIb1Y3j3l5iN39FArGiJU2KbTJfwEJjMi559yWWjX5ADSObwwYwg4JxVMLdJ53s5E6cOu/bplBDw+GmL2fQ+8kA58O9zyElBuFE03YTVkAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N8pQdRn/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A74BFF802;
	Thu, 22 Feb 2024 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708597888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j152Eq5lSDHkvM0B06uWbtq1OGz2o/iHiAPq8//XBw=;
	b=N8pQdRn/TolXDmnev8WosBnFCkiIHNQwA8OhF5TnqmBlQ4BMTSIEghWdSNjMe8LwWQLEdu
	sqNTehKHDa4mq/pFhWf5IOTO0JlaL2AgAZebPk/9UYettCMLur9OSkvWEo2ehN7EnKvAsn
	4BIqwMMoS/aoYJQFTaPPIJ1ofgpq+7aZ0E0GsQIppVyberN98r/FUxfN9lbsRKcj0YBDCF
	fEYEu7+oqEZsfU5KxtD64AyMzJEDiNRYWGs0ugdiPegFf4FkSDEfh7ylaBle8F4DiXdMx9
	j4nlYmt1FCWVXQCOdMLYuQuTxCL3Fd+jrjMVgkoMkX4g0ocJ8jg2gJbE0N8w5A==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH net-next 3/3] net: phy: dp83826: support configuring RMII master/slave operation mode
Date: Thu, 22 Feb 2024 11:31:17 +0100
Message-Id: <20240222103117.526955-4-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
References: <20240222103117.526955-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

The TI DP83826 PHY can operate between two RMII modes:
	- master mode (PHY operates from a 25MHz clock reference)
        - slave mode (PHY operates from a 50MHz clock reference)

By default, the operation mode is configured by hardware straps.

Add support to configure the operation mode from within the driver.

Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 drivers/net/phy/dp83822.c | 43 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 2d8275e59dcc..edc39ae4c241 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -101,6 +101,7 @@
 
 /* RCSR bits */
 #define DP83822_RMII_MODE_EN	BIT(5)
+#define DP83822_RMII_MODE_SEL	BIT(7)
 #define DP83822_RGMII_MODE_EN	BIT(9)
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
@@ -495,21 +496,53 @@ static int dp83822_config_init(struct phy_device *phydev)
 	return dp8382x_disable_wol(phydev);
 }
 
+static int dp83826_config_rmii_mode(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	const char *of_val;
+	int ret;
+
+	if (!device_property_read_string(dev, "ti,rmii-mode", &of_val)) {
+		if (strcmp(of_val, "master") == 0) {
+			ret = phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+						 DP83822_RMII_MODE_SEL);
+		} else if (strcmp(of_val, "slave") == 0) {
+			ret = phy_set_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
+					       DP83822_RMII_MODE_SEL);
+		} else {
+			phydev_err(phydev, "Invalid value for ti,rmii-mode property (%s)\n",
+				   of_val);
+			ret = -EINVAL;
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dp83826_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
 	u16 val, mask;
 	int ret;
 
-	if (phydev->interface == PHY_INTERFACE_MODE_RMII)
+	if (phydev->interface == PHY_INTERFACE_MODE_RMII) {
 		ret = phy_set_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
 				       DP83822_RMII_MODE_EN);
-	else
+		if (ret)
+			return ret;
+
+		ret = dp83826_config_rmii_mode(phydev);
+		if (ret)
+			return ret;
+	} else {
 		ret = phy_clear_bits_mmd(phydev, DP83822_DEVADDR, MII_DP83822_RCSR,
 					 DP83822_RMII_MODE_EN);
-
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	if (dp83822->cfg_dac_minus != DP83826_CFG_DAC_MINUS_DEFAULT) {
 		val = FIELD_PREP(DP83826_VOD_CFG1_MINUS_MDI_MASK, dp83822->cfg_dac_minus) |
-- 
2.34.1


