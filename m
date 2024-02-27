Return-Path: <linux-kernel+bounces-82975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D971868C79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86B62826DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086331384B0;
	Tue, 27 Feb 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BVrfdssO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632031369A2;
	Tue, 27 Feb 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026814; cv=none; b=QaLixcvkyZ6bX3oQ9Du+85Tsf4A3qJMyXGHZgdvWMNzxN9O+nRti09X011uWXz/mhdC4Uc7z4VJVD301NdIC0Fktqpt1A+HmknMeHlj/3AvfEoKEbcGpJwAzIUMs85r8UVzNDx49FHiNKpIeeLz+fuYnZJGwN0wBjunIuj0/tJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026814; c=relaxed/simple;
	bh=wEhydF0uAkZdVJjRAdGWXmqjpXqyXP1qcx0hncX2AaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQoUpVjYGC/FaE6NM/uwp7ha4rcwGkdcvbXJ2s/AwFj7y+1BC3f+agojDPH0r3e429JTIqPjLLB2skbSP7PvLUoiEJjTCVYZb1nJmPfBxAc58wbdjUy+LsjMJDURHw7roGrYvhde+NX+aCbhAA4r7Z7L3WkaCHL1cLSZTkoFRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BVrfdssO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B67441BF203;
	Tue, 27 Feb 2024 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DImN79hQFdqQ+Xbnqbaw0AlsT0SBJRI+BKdyo30mw/4=;
	b=BVrfdssOBrbkIODUzKD1+KhDBq7FT8u1tLb8wnnTm4a2+Nn+kyU8jFUS1Az33QCdkRfjKw
	jIIIZsY+8QqRXgx+7Iisi8pP0/g9j5o5EO5Vks3NOvJq7/Y2wn4Q2ppWA+x+K/lDgKJA98
	ZQ18RU4+OywqWsKqc7yFWLp6YcHABJqRsgS1Huc+A/njJkAl7v5J9DAxfY4yt7get/nyzj
	F/fN1PU4ClotmT8tgoSR5PhUYdml8orinEc3xwsZuhUMTcCbISukv239TDojCnJt+OWdcf
	944oZLQrLDYbzTZ9u9i/5Y37714BZk6nManBs93Hw7TC34W/CoAmZh5s/nO2tg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 4/6] net: phy: DP83640: Add EDPD management
Date: Tue, 27 Feb 2024 10:39:43 +0100
Message-ID: <20240227093945.21525-5-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The driver does not support enabling/disabling Energy Detect Power Down
(EDPD).
The PHY itself support EDPD.

Add missing part in the driver in order to have this support based on
ethtool {set,get}_phy_tunable functions.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/net/phy/dp83640.c     | 62 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/dp83640_reg.h |  4 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index c46c81ef0ad0..16c9fda50b19 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1531,6 +1531,66 @@ static void dp83640_remove(struct phy_device *phydev)
 	kfree(dp83640);
 }
 
+static int dp83640_get_edpd(struct phy_device *phydev, u16 *edpd)
+{
+	int val;
+
+	phy_write(phydev, PAGESEL, 0);
+	val = phy_read(phydev, EDCR);
+	if (val & ED_EN)
+		*edpd = 2000; /* 2 seconds */
+	else
+		*edpd = ETHTOOL_PHY_EDPD_DISABLE;
+
+	return 0;
+}
+
+static int dp83640_set_edpd(struct phy_device *phydev, u16 edpd)
+{
+	int val;
+
+	phy_write(phydev, PAGESEL, 0);
+	val = phy_read(phydev, EDCR);
+
+	switch (edpd) {
+	case ETHTOOL_PHY_EDPD_DFLT_TX_MSECS:
+	case 2000: /* 2 seconds */
+		val |= ED_EN;
+		break;
+	case ETHTOOL_PHY_EDPD_DISABLE:
+		val &= ~ED_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	phy_write(phydev, EDCR, val);
+
+	return 0;
+}
+
+static int dp83640_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_EDPD:
+		return dp83640_get_edpd(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dp83640_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_EDPD:
+		return dp83640_set_edpd(phydev, *(u16 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int dp83640_led_brightness_set(struct phy_device *phydev, u8 index,
 				      enum led_brightness brightness)
 {
@@ -1692,6 +1752,8 @@ static struct phy_driver dp83640_driver = {
 	.name		= "NatSemi DP83640",
 	/* PHY_BASIC_FEATURES */
 	.probe		= dp83640_probe,
+	.get_tunable    = dp83640_get_tunable,
+	.set_tunable    = dp83640_set_tunable,
 	.remove		= dp83640_remove,
 	.soft_reset	= dp83640_soft_reset,
 	.config_init	= dp83640_config_init,
diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
index 09dd2d2527c7..bf34d422d91e 100644
--- a/drivers/net/phy/dp83640_reg.h
+++ b/drivers/net/phy/dp83640_reg.h
@@ -9,6 +9,7 @@
 #define LEDCR                     0x0018 /* PHY Control Register */
 #define PHYCR                     0x0019 /* PHY Control Register */
 #define PHYCR2                    0x001c /* PHY Control Register 2 */
+#define EDCR                      0x001D /* Energy Detect Control Register */
 
 #define PAGE4                     0x0004
 #define PTP_CTL                   0x0014 /* PTP Control Register */
@@ -64,6 +65,9 @@
 /* Bit definitions for the PHYCR2 register */
 #define BC_WRITE                  (1<<11) /* Broadcast Write Enable */
 
+/* Bit definitions for the EDCR register */
+#define ED_EN		          BIT(15) /* Enable Energy Detect Mode */
+
 /* Bit definitions for the PTP_CTL register */
 #define TRIG_SEL_SHIFT            (10)    /* PTP Trigger Select */
 #define TRIG_SEL_MASK             (0x7)
-- 
2.43.0


