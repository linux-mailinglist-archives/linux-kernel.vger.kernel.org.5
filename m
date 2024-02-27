Return-Path: <linux-kernel+bounces-82979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3EA868C86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2F32821FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A013A24C;
	Tue, 27 Feb 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kWckHP8S"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5521369B5;
	Tue, 27 Feb 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026817; cv=none; b=BkbLQhPNx7YrrqbRFUFQTQpUqh+OlrvQeceDCUUn+S3wLMyb4txRUzxH8VPsdyjh3pFhBoq9i9iomNt+RVeyK+85ZhqmELWY1AiisvxvPYjELxpOAdK/KNGFqiK+mWQ0/TRyqOQeAnn/mlt/ExQLlA7blQcT3Yfvukq+CO3Ohs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026817; c=relaxed/simple;
	bh=NYYmMCzH7vimTij6Ubq0mii2fz8ZW2rnD23U4YlBxqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiZpqu8U7I66rJ9EUqdn9XMPULXLZ62agEprEpUtGIg6s2F9CZ0LzUFfFLb1pLoC8sklR9CPxj9DOGRDG5qtxu33Pr9n5XZfvlaUr2wNCoI8HKMke1yyK3EimU43UWxDKMlyLzCN/oMK+HcMxE+UB1zfwr1gnH/OQ9DGi1eLKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kWckHP8S; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5C61B1BF216;
	Tue, 27 Feb 2024 09:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxjHn9p9H9NJifATQZkPfSnDEUUsarNIhRN6DP6TGhI=;
	b=kWckHP8S+V229WSbjHSvoQVhZZJSxhIo6Cx4XFA6WBbIsuRM/rwpU8e2qqTX3IHOSbtaFY
	XubWCr0zR3q6P5yS/iInceHN8S1Gott/NkhiIpu+AFeqdyH+/ltf7QKq7hUWyscU2xQo4K
	TWNpsuhPRJ5jA7LuRV+avRLzdZwpOqTf1/tutTEG6s8GNU7THV/Eaizpnq5PEjaMD/qSMf
	LS6ZcWGFGUic4J8E/KIsZBbLTN7pIjQOTdRTeYtSDtitd7gtNRZtYbEPwVOLr9a9/RKE4V
	zdrXckJSWqMwjW8tJl60uZ7roThGxnfTxLTImMqdLuQnQvjQOF5YACgwtkxG1g==
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
Subject: [PATCH v2 5/6] net: phy: DP83640: Explicitly disabling PHY Control Frames
Date: Tue, 27 Feb 2024 10:39:44 +0100
Message-ID: <20240227093945.21525-6-bastien.curutchet@bootlin.com>
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

The PHY offers a PHY control frame feature that allows to access PHY
registers through the MAC transmit data interface. This functionality
is not handled by the driver but can be enabled via hardware strap or
register access.

Disable the feature in config_init() to save some latency on MII packets.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/net/phy/dp83640.c     | 6 ++++++
 drivers/net/phy/dp83640_reg.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 16c9fda50b19..b371dea23937 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1120,6 +1120,7 @@ static int dp83640_config_init(struct phy_device *phydev)
 {
 	struct dp83640_private *dp83640 = phydev->priv;
 	struct dp83640_clock *clock = dp83640->clock;
+	int val;
 
 	if (clock->chosen && !list_empty(&clock->phylist))
 		recalibrate(clock);
@@ -1135,6 +1136,11 @@ static int dp83640_config_init(struct phy_device *phydev)
 	ext_write(0, phydev, PAGE4, PTP_CTL, PTP_ENABLE);
 	mutex_unlock(&clock->extreg_lock);
 
+	/* Disable unused PHY control frames */
+	phy_write(phydev, PAGESEL, 0);
+	val = phy_read(phydev, PCFCR) & ~PCF_EN;
+	phy_write(phydev, PCFCR, val);
+
 	return 0;
 }
 
diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
index bf34d422d91e..b5adb8958c08 100644
--- a/drivers/net/phy/dp83640_reg.h
+++ b/drivers/net/phy/dp83640_reg.h
@@ -10,6 +10,7 @@
 #define PHYCR                     0x0019 /* PHY Control Register */
 #define PHYCR2                    0x001c /* PHY Control Register 2 */
 #define EDCR                      0x001D /* Energy Detect Control Register */
+#define PCFCR                     0x001F /* PHY Control Frames Control Register */
 
 #define PAGE4                     0x0004
 #define PTP_CTL                   0x0014 /* PTP Control Register */
@@ -68,6 +69,9 @@
 /* Bit definitions for the EDCR register */
 #define ED_EN		          BIT(15) /* Enable Energy Detect Mode */
 
+/* Bit definitions for the PCFCR register */
+#define PCF_EN                    BIT(0)  /* Enable PHY Control Frames */
+
 /* Bit definitions for the PTP_CTL register */
 #define TRIG_SEL_SHIFT            (10)    /* PTP Trigger Select */
 #define TRIG_SEL_MASK             (0x7)
-- 
2.43.0


