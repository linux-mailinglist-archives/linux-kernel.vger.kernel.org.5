Return-Path: <linux-kernel+bounces-64074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E28539D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D4A1F21B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE706088D;
	Tue, 13 Feb 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVCpOeOJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668F605BF;
	Tue, 13 Feb 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848683; cv=none; b=FK3WZ2idIAVDQjtU/UYdN9i+S/DzFMDQ1zOcUmCgLPC4IWsr78wID1MggacrBR50lcrFzgmxc3Cmj6GEEaz8ly8M17erUVOJHg2mklfYJ8Y30hqwStz6ox7PqKTNdY9R+UEC/rwDYMB2t4NocQJfshIB7QSzTeWdua5mGTNMm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848683; c=relaxed/simple;
	bh=z7yc8ubB/vZV64kloK8lXbtup7nKhGNU94YCpHImetg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieRb6eNbmsrdwwJLV69mPDrjJssw4VFuLNSmfvCNGH925Wa4R7fm1TzHX6AfeBI+5vD8rWyg0BlzePwJxU80E0mAMShdczQ+gZp7LW6+SCsV8kbegUXB7CI8PMCOoXUTR4Rzm2l9AKnWgSKG9k/M/ftza0iGauF8lfSJnu1F5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVCpOeOJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso585120f8f.2;
        Tue, 13 Feb 2024 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848680; x=1708453480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGnOlkHlcmiaaGm8mpXRkLoxVLEhp4gbuwkrUsWlruk=;
        b=iVCpOeOJYnI/p7IFPzQsd5G3fJL4DyyAGTAamclqW1LinrpW3cSzjlpArQzni5vzS2
         h4mqGalVGk1LoDvN64e4FzxWJkzutjZCRzqMN34vJDqvIGYCqTqtx7Gr3O8DYpaHLiq6
         G/WOKsuVitfmzW7tGfnivMtlRh1p288hn1pyW6YurRe26pIiB49aB7m+Zv6jREOYrF3Z
         0IkiW5mG+EqOBu1yDizgu0QrtCgVk6qpT29/84Lw2AYEmBMf3vu73O8JB3fL9xhg4X1X
         2Zum84kn9G7eZC01BzeTOrtxZWyi4rM7j0MbxQrKs9RNHyW+LrSadPl1EL0J5yRlhCyb
         V4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848680; x=1708453480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGnOlkHlcmiaaGm8mpXRkLoxVLEhp4gbuwkrUsWlruk=;
        b=J8gAUG4sdrJsGZsSPNCTDzxf8piOnwV3LL/A/2hLNGEnCrkE8IB6lObt3LG53pu9Q5
         +LvN0qgm0SSup+OQsiOJtAegiIWV+Cxndt3/Xw20tfd7ViHOPdwlqgR9i7SUI1zI0IHY
         KYF9jIW4cz1VoH2BCX4mqkBdmAMUKM1BQ0kIeP/gSkBniAiMh97iaLhql6z1ex1ACIp1
         uUu836R+tmDnpEpyBOLHCkJzY92I3vZcFcGmknHJMu3NoYTETUMNp4xzHSdoPINEglRm
         VCReH7oYsAnU02H/t9XG76xPYK0XElmRZd5YkC4+/GB2y8rGT3XzXVlwPezVOJO4xJ2n
         GRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5e3PujxcMtsGBd/2fKzNUEYvUMuXCmASbpzgl/TOs+/hLFjsi++GNZdDpbP2fJZccxQNJR0aJ4jwQpIBgq0hV1j9n4ARgwRh2NwUo0Q4dudlozM6vl4uJ+57f306jVpmHqWDj
X-Gm-Message-State: AOJu0Yxx/KmofxNKEKNSHfiFVRPvZCfZSke1wo/CBrG3X2W1b4fP8Fzy
	0/nmXxAD+OTKPs4nf45fdQddNnVKPZqWndnA8hBULGO97rEO2tsl
X-Google-Smtp-Source: AGHT+IH0Wfb4NYMHF6Me4X8gZ7PFvnccsjKF/h3zuG3Fp/BzuBCLcOIg0HlSVAS/Lf9WXyhlhvDOzA==
X-Received: by 2002:adf:f243:0:b0:33b:87a0:3af with SMTP id b3-20020adff243000000b0033b87a003afmr62711wrp.67.1707848679726;
        Tue, 13 Feb 2024 10:24:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1xAdmbdWA6FIvaSei+6mwuYoMW2I5RHChPSEh5spao2QLXHAwer/qSSf0IIyzsAK9ySzRRrn33fogZLcxb6sULs1EVTvyvEd9YIvX4tvZh8gzTLx8KFccICeCLD4F37fz5+9UdGn1uEjjXUcCZWze13SbZGeYrCdlGKR6s3VXvi9w5hg/deNeYucSD7v7zUQ9+lgCDKa9HePMmpZUh/PveJgqPdrCb+Pookzq++VtsjeSFyOyO0Fmo1OAfoKLZDQUNWvvG2uVRnDIx2cPBHQSRFKrjwBeP84/GeU2fKgQ8O3e33xssNea4/Iwdg0S6TjLToolOaPf7NI05mHTyeJ9LQmlrgQTTjSYq5fE7mGAi5mG29WaqqAxfNEtCMS4XhhtEZydGn0=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bs25-20020a056000071900b0033b45bdb2a1sm10347974wrb.4.2024.02.13.10.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:24:39 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 1/2] net: phy: aquantia: setup interface protocols for AQR112
Date: Tue, 13 Feb 2024 19:24:11 +0100
Message-ID: <20240213182415.17223-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213182415.17223-1-ansuelsmth@gmail.com>
References: <20240213182415.17223-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aquantia Gen3 PHYs require additional regs to be set to correctly work
and communicate with the MAC.

For each rate, the startup rate needs to be set and the required global
cfg needs to be set.

The global cfg are per Rate and require different configuration based on
the requested interface mode.

Some FW might apply the correct values by default but some OEM might
provide generic FW that require additional fixup at runtime as the FW
doesn't correctly provison the PHY for the attached MAC interface mode.

The default values are taken from various source and SDK and all use the
same values for SGMII, 2500BASEX, 10GBASER and USXGMII.

One common problem that this handle is case where the FW provision for
10BASER but USXGMII is actually requested, hance runtime fixup is
required.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/aquantia/aquantia.h      |  17 ++++
 drivers/net/phy/aquantia/aquantia_main.c | 110 +++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 1c19ae74ad2b..019528c536c7 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -39,6 +39,15 @@
 #define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK	GENMASK(15, 0)
 #define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK, (u16)(x))
 
+#define VEND1_GLOBAL_STARTUP_RATE		0x031a
+#define   VEND1_GLOBAL_STARTUP_RATE_MASK	GENMASK(3, 0)
+#define   VEND1_GLOBAL_STARTUP_RATE_LOW_POWER	0
+#define   VEND1_GLOBAL_STARTUP_RATE_100M	1
+#define   VEND1_GLOBAL_STARTUP_RATE_1G		2
+#define   VEND1_GLOBAL_STARTUP_RATE_10G		3
+#define   VEND1_GLOBAL_STARTUP_RATE_2_5G	4
+#define   VEND1_GLOBAL_STARTUP_RATE_5G		5
+
 /* The following registers all have similar layouts; first the registers... */
 #define VEND1_GLOBAL_CFG_10M			0x0310
 #define VEND1_GLOBAL_CFG_100M			0x031b
@@ -52,6 +61,14 @@
 #define VEND1_GLOBAL_CFG_SERDES_MODE_SGMII	3
 #define VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII	4
 #define VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G	6
+/* Enable System Interface Autonegotiation */
+#define VEND1_GLOBAL_CFG_AUTONEG_EN		BIT(3)
+/* Enable System Interface Training */
+#define VEND1_GLOBAL_CFG_TRAINING_EN		BIT(4)
+/* Reset System Interface For Every Transition */
+#define VEND1_GLOBAL_CFG_RESET_ON_TRANSITION_EN	BIT(5)
+/* Keep SERDES Silent During Transition */
+#define VEND1_GLOBAL_CFG_SERDES_SILENCE_EN	BIT(6)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT		GENMASK(8, 7)
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_NONE	0
 #define VEND1_GLOBAL_CFG_RATE_ADAPT_USX		1
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 97a2fafa15ca..6ee1a134bc60 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -746,6 +746,114 @@ static int aqr107_probe(struct phy_device *phydev)
 	return aqr_hwmon_probe(phydev);
 }
 
+static int aqr112_setup_interface_protocols(struct phy_device *phydev)
+{
+	phy_interface_t iface = phydev->interface;
+	u16 startup_rate, global_cfg_val;
+	int i, ret;
+
+	/* Default global cfg are taken from Aquantia UBoot Source and various
+	 * source and all makes use of the following reference values.
+	 */
+	switch (iface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		startup_rate = VEND1_GLOBAL_STARTUP_RATE_1G;
+		global_cfg_val = FIELD_PREP(VEND1_GLOBAL_CFG_SERDES_MODE,
+					    VEND1_GLOBAL_CFG_SERDES_MODE_SGMII) |
+				 VEND1_GLOBAL_CFG_AUTONEG_EN |
+				 VEND1_GLOBAL_CFG_SERDES_SILENCE_EN;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		startup_rate = VEND1_GLOBAL_STARTUP_RATE_2_5G;
+		global_cfg_val = FIELD_PREP(VEND1_GLOBAL_CFG_SERDES_MODE,
+					    VEND1_GLOBAL_CFG_SERDES_MODE_OCSGMII) |
+				 VEND1_GLOBAL_CFG_SERDES_SILENCE_EN |
+				 FIELD_PREP(VEND1_GLOBAL_CFG_RATE_ADAPT,
+					    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE);
+		break;
+	case PHY_INTERFACE_MODE_5GBASER:
+		startup_rate = VEND1_GLOBAL_STARTUP_RATE_5G;
+		global_cfg_val = FIELD_PREP(VEND1_GLOBAL_CFG_SERDES_MODE,
+					    VEND1_GLOBAL_CFG_SERDES_MODE_XFI5G) |
+				 FIELD_PREP(VEND1_GLOBAL_CFG_RATE_ADAPT,
+					    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE);
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_USXGMII:
+		startup_rate = VEND1_GLOBAL_STARTUP_RATE_10G;
+		global_cfg_val = FIELD_PREP(VEND1_GLOBAL_CFG_SERDES_MODE,
+					    VEND1_GLOBAL_CFG_SERDES_MODE_XFI);
+		if (iface == PHY_INTERFACE_MODE_USXGMII)
+			global_cfg_val |= FIELD_PREP(VEND1_GLOBAL_CFG_RATE_ADAPT,
+						    VEND1_GLOBAL_CFG_RATE_ADAPT_USX);
+		else
+			global_cfg_val |= FIELD_PREP(VEND1_GLOBAL_CFG_RATE_ADAPT,
+						    VEND1_GLOBAL_CFG_RATE_ADAPT_PAUSE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set PHY in low power mode so we can configure protocols */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_SC,
+			       VEND1_GLOBAL_SC_LOW_POWER);
+	if (ret)
+		return ret;
+
+	/* Some dalay is needed to put the chip in low-power */
+	mdelay(10);
+
+	/* Setup the SERDES interface link startup rate */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_STARTUP_RATE,
+			    FIELD_PREP(VEND1_GLOBAL_STARTUP_RATE_MASK, startup_rate));
+	if (ret)
+		return ret;
+
+	/* Walk the media-speed configuration registers to setup host-side
+	 * serdes modes that may be used by the PHY depending on the
+	 * negotiated media speed.
+	 */
+	for (i = 0; i < ARRAY_SIZE(aqr_global_cfg_regs); i++) {
+		u16 reg = aqr_global_cfg_regs[i];
+		int val;
+
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND1, reg);
+		if (val < 0)
+			return val;
+
+		/* If global_cfg is 0, rate is not supported by FW */
+		if (!val)
+			continue;
+
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, reg,
+				    global_cfg_val);
+		if (ret)
+			return ret;
+	}
+
+	/* set PHY out of low power mode */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_SC,
+				 VEND1_GLOBAL_SC_LOW_POWER);
+	if (ret)
+		return ret;
+
+	/* Some dalay is needed to put the chip out of low-power */
+	mdelay(10);
+
+	return 0;
+}
+
+static int aqr112_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = aqr112_setup_interface_protocols(phydev);
+	if (ret)
+		return ret;
+
+	return aqr107_fill_interface_modes(phydev);
+}
+
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -831,6 +939,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR112),
 	.name		= "Aquantia AQR112",
 	.probe		= aqr107_probe,
+	.config_init	= aqr112_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
@@ -849,6 +958,7 @@ static struct phy_driver aqr_driver[] = {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR412),
 	.name		= "Aquantia AQR412",
 	.probe		= aqr107_probe,
+	.config_init	= aqr112_config_init,
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-- 
2.43.0


