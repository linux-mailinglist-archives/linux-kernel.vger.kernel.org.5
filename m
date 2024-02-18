Return-Path: <linux-kernel+bounces-70266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F172859568
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD37B22682
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9B111BB;
	Sun, 18 Feb 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr50yw7W"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4B200AE;
	Sun, 18 Feb 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243105; cv=none; b=BXC/uYA34rkOVgFnrRTJkgRD25rT44yXRl4r/clpy3K69LgmpVkqDSb1aK+pYrjTGd8v+zIBGc1vIHW4Mu7LLnUNSDXaKEhxvUTJ/Gu1X7YCeXrAkF59dk9k+Rb+7AHZP+eHj+AAh3LjVKITF0MXLeHEQe4vreWNs8e7t1Y3w78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243105; c=relaxed/simple;
	bh=LCJqQmp8EvzXP2okag81gJ1d/9Sz9Vw//mEsG+70Wkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZi2uqu9BCXSRGV0R2i9diwgLdBI8AhAPMi31Ru6y9XzUwEAr89N+RmcffbgQApki5NDtIIsFSmSXD6231LOfkKccxuWVKkvivpDh4AZg6TNVfIj0Zzj5dcjdE8O1m1JAkE+POkGnSDPtW3M9vtwIhdQDVOiJKxX2ptxmENJ+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr50yw7W; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso4451502a12.2;
        Sat, 17 Feb 2024 23:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243102; x=1708847902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xvjQdKQSLTDb6d/SX3Ag359hpRipFeHv0DDcAaw9Sg=;
        b=Fr50yw7WQiMX7LbxO1lRCrnLgEPC60k9tABP6ih8ZM4zSrFirBVVOah2xYMyQz8P7L
         KjVjILP+PZN21q/azN6ZOccwzNW+bR5HdZIh5kB/BMI6qQN22Jkl5/jqur+Te+bZd75E
         4u5rc5DivY8qvgTZMPXlan/Ql/OxrNhoDqXfkUZ85C5PEsSGkpIICxZAEIZy254oZwAM
         3UuEKstAWko266bckpvY+cNHQTEMXhLmuAYHcWGbKOSiRe7pnr02Ro3hTp4uGZE+mWWj
         TPKWP312Wcf3EcRauUcTDgcTAPFelZZ48MiK3AWghG5Dk/6FLM5PMyfuGEq7rE6PQG7t
         lPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243102; x=1708847902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xvjQdKQSLTDb6d/SX3Ag359hpRipFeHv0DDcAaw9Sg=;
        b=GBVdW7flRVTO1fzlmNHY8scm+GyiLKrOTWD61TEmOOjWunXoq95kmDHcHLZqOLQ3CI
         QD5MdFixf3ZR+11TyCLBynFdkXNoVnVgkFv/z+bWhAV7blB6899N/RHgByijd75yLYsE
         Etgz2mAwooQDx8Qkzly5JHWxAjlBewAt7upsx5t6rsFanEI1bpiynuPt1hDCMiV6HSbz
         Yk5emFYrgQB8ghbSYFS9gLtM39y+q0Vm9htvof2ouFFJu5yYrczl3YYKMAk38djejwTa
         O7bygjUOI9UP3geM1Peb6EJz0kg5C8x3fIN5BsNepJfbJNx/87pmqcATTGpYOFko6Y//
         azLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7bxYg4GDwZP9Xl4rKH9tI9QlORt/1Krd28eYB6aNupPoXxCdMriOVGRGw3owBDCHHtgsMPtReVzecUB7C15jEwZ8LyJDGyFllJCrfdzu3s256mJJEcsQW4EOSVG/IvlKBBVNVvKZPujy3wIzeWam+B2IgDNATQ8BttfHnSGx+ec0=
X-Gm-Message-State: AOJu0Ywx2a1+5eNISJ/gbQmQqAzzeei365SzpMB90XSwJgyTh5G65itv
	NhN6e0oSwZyW4ITBdMldQRTiJGE1qqEyuaRH+L5g14dPX8fd94gZ
X-Google-Smtp-Source: AGHT+IHolR8m3UWhhMdTlFrzlT0ejUIXeg/98gHaJ4tjsdt1SS4ZBd1Gwlkku5RG/IPu8WTWL04DuA==
X-Received: by 2002:a17:906:35da:b0:a3e:4baa:9ba4 with SMTP id p26-20020a17090635da00b00a3e4baa9ba4mr1239767ejb.58.1708243101828;
        Sat, 17 Feb 2024 23:58:21 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:21 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v7 net-next 08/14] net: phy: marvell-88q2xxx: add support for temperature sensor
Date: Sun, 18 Feb 2024 08:57:45 +0100
Message-Id: <20240218075753.18067-9-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
support for this sensor.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/Kconfig           |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 146 ++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index e261e58bf158..1df0595c5ba9 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -232,6 +232,7 @@ config MARVELL_10G_PHY
 
 config MARVELL_88Q2XXX_PHY
 	tristate "Marvell 88Q2XXX PHY"
+	depends on HWMON || HWMON=n
 	help
 	  Support for the Marvell 88Q2XXX 100/1000BASE-T1 Automotive Ethernet
 	  PHYs.
diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 8b8275552014..2ca1b47e8f8f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -9,6 +9,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/marvell_phy.h>
 #include <linux/phy.h>
+#include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
 
@@ -37,6 +38,18 @@
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
 #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
 
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN		0x0080
+
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR2			32834
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK		0xc000
+
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3			32835
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK	0xff00
+#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK		0x00ff
+
 #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
 #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
@@ -493,6 +506,138 @@ static int mv88q2xxx_resume(struct phy_device *phydev)
 				  MDIO_CTRL1_LPOWER);
 }
 
+#if IS_ENABLED(CONFIG_HWMON)
+static const struct hwmon_channel_info * const mv88q2xxx_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_ALARM),
+	NULL
+};
+
+static umode_t mv88q2xxx_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	case hwmon_temp_max:
+		return 0644;
+	case hwmon_temp_alarm:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int mv88q2xxx_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *val)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK, ret);
+		*val = (ret - 75) * 1000;
+		return 0;
+	case hwmon_temp_max:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
+				ret);
+		*val = (ret - 75) * 1000;
+		return 0;
+	case hwmon_temp_alarm:
+		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
+				   MDIO_MMD_PCS_MV_TEMP_SENSOR1);
+		if (ret < 0)
+			return ret;
+
+		*val = !!(ret & MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mv88q2xxx_hwmon_write(struct device *dev,
+				 enum hwmon_sensor_types type, u32 attr,
+				 int channel, long val)
+{
+	struct phy_device *phydev = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		clamp_val(val, -75000, 180000);
+		val = (val / 1000) + 75;
+		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
+				 val);
+		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				      MDIO_MMD_PCS_MV_TEMP_SENSOR3,
+				      MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
+				      val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops mv88q2xxx_hwmon_hwmon_ops = {
+	.is_visible = mv88q2xxx_hwmon_is_visible,
+	.read = mv88q2xxx_hwmon_read,
+	.write = mv88q2xxx_hwmon_write,
+};
+
+static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
+	.ops = &mv88q2xxx_hwmon_hwmon_ops,
+	.info = mv88q2xxx_hwmon_info,
+};
+
+static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct device *hwmon;
+	char *hwmon_name;
+	int ret;
+
+	/* Enable temperature sense */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
+	if (IS_ERR(hwmon_name))
+		return PTR_ERR(hwmon_name);
+
+	hwmon = devm_hwmon_device_register_with_info(dev,
+						     hwmon_name,
+						     phydev,
+						     &mv88q2xxx_hwmon_chip_info,
+						     NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon);
+}
+
+#else
+static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif
+
+static int mv88q2xxx_probe(struct phy_device *phydev)
+{
+	return mv88q2xxx_hwmon_probe(phydev);
+}
+
 static int mv88q222x_soft_reset(struct phy_device *phydev)
 {
 	int ret;
@@ -587,6 +732,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_88Q2220_REVB0),
 		.name			= "mv88q2220",
+		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
 		.config_aneg		= mv88q222x_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
-- 
2.39.2


