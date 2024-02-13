Return-Path: <linux-kernel+bounces-64360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F17853D75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2C928271C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D72563510;
	Tue, 13 Feb 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBXDdLJf"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BDD6341B;
	Tue, 13 Feb 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860438; cv=none; b=go2dc2payptg96ISDYluG9pD6XSXBonzCJwvP3gwQILDqhLLN663lIneljlcP3MjGZiRpv6JPsNLAocRz/JRT7e9+ExYp9Yif7zJENkFWqmrxKzPRLjJIBLQyLZ1LRLWwVIyYrj8qiRA4to/afnrbEdRPK/BeD5N/gmp/DxgZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860438; c=relaxed/simple;
	bh=TTV3hCdYp8zmLN9u8rd4k02yWWJHTqp07hV2JU4mEPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BDDuvvYMvRB5mCn+8MLIBoakF9qD8BSwbEEuWWjtenDOszt7cRvKiaSNG7W7abPwdMq8TvjAtpKBzk/rfNmFVMpJG3JvlLww+MDxJImn4qGgWlf2FHz0nYOe32JXo51bZcZExF/mJ+2CT6JFxk85AWPSz9KV5uobgdA3/DJGTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBXDdLJf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d073b54359so71426911fa.0;
        Tue, 13 Feb 2024 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860434; x=1708465234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22OYUBeHLDk02R6s/5nnCTgcXdt4+AH9gPkoTxE03WU=;
        b=TBXDdLJfcSFcerYTJfzGH+FuYbleRdmCd8AUI6VQ0mfZUJ+RxG1YknebCRRyANkqDV
         fSYSpdgkEHuB2uGCLQIfM1WRh/mQ1ImQlvN91c8hV6OCAOkKDGZ5qvsDNB8IWjM7DpxU
         oKg/8GFCFD67W2z07v84rIi299szWjo6l+i/uXDB5x+NeSevaJJQG65ZJcZrLEZHQP2i
         +L7PmBH4DAXADPjsOGjW+p+T2zQF68gIO3Ql/1ZF3Bz/KER54/NfDxDf5ZmZ1RudsOlt
         iqwKGn8vn6A7tJN6MT/sOabha+7p02z+qV9edpdyrIvxC/tx3Rr/2q0WiVhiCGv/Dr3p
         uJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860434; x=1708465234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22OYUBeHLDk02R6s/5nnCTgcXdt4+AH9gPkoTxE03WU=;
        b=f+9JmsjbHWsDf80gLvkbCDq0PyKye+u8rK/T2At+MjSWFBHnWlg17s1WmdPddti5nS
         Cdt3to98nUil2khZMiIh8Ot5hmvZaq5aAdNnymKPtFIlsC6AKseY+pO9T+QLpXWX9kxx
         /JEn31wLBdIzQh9JN5OjWZrZiCQdSMJyGayt2zoD8Dn+vkmehl7wTY964zy03Fb9eHE0
         GMEPpMyvspHgOx/+em2AchYUssqTCf9cUu08E/wkcfH3yNb00WTu87kSB4io5tcxvSre
         /lvzP6aEz/+vfYkX5itqW1lw+rj+OdRknn0TvJ7ZAOmm5KKudb/+JlvIX8qrjJMV6i/W
         8ubw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Coz8G2i3GRv3HzxpgC/mmhUGQZEScQit/zEALXYfp7/2MmLJMp0vcD/8qqBc3dRpZ5r3/+HBY11dD7pztofLD7QBVvWcu/5dWDXHZUQpWEmcoMsYtHJoOHNa2UUcG74vhLMzCEM/83TGx7g7VpdyleNd+Dt0/5pVgTlcdxJTuMo=
X-Gm-Message-State: AOJu0Yy5nu9kFqy0T8STG812+moH/lrI+iOFte/5f0soFVsab9HiQqg2
	YZSwugDik2UnVuvyByzaOr0ETAezdjd/HhtnmOBgdgIqiT8UdCr6
X-Google-Smtp-Source: AGHT+IGidetQKhpKj04a/nj4O4QTfDyYIXsUAIWtuuUpS/JXAG3U2H8WNneLBRmANTuM1eF3hP9FLg==
X-Received: by 2002:a2e:87ce:0:b0:2d1:12bb:6613 with SMTP id v14-20020a2e87ce000000b002d112bb6613mr414351ljj.30.1707860434534;
        Tue, 13 Feb 2024 13:40:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd3FWo2iVNYKorPyBgJDq6gw67ZeLhGlu1dx3DMj4r0p98dJvGkxCpbn/uRrrnU7nBZv08ys8OOULm9d2KmwMnYcS6+93dbb6OxC7Y+d6oNgdD3R80c1DB0Aqo0Yq7z9C9sLARxClInPWAN6a3nc/w7RrJPHQDCtjWKsdeh1W6he1wwi3b/J+/cVNPejgyj0dDnYHi2kBK1Ia9W1nVpnajVIyrW7gDw/yaU93IHa7LWi111l94D6wBtDuikgeSFHbqf8NqshCYiHUuaoUn6tqES0Jl31lGYsP2vcf3lVuVU4LZ7lYQqtzcHisUccCQ8JNPtYxC3AhY3hFNh+EKqu4bvh0UcXRTgSkTtrcF3maEPqOfc+MOwDSASZT/L2SuvA3XiTPgDbsHOJvd0/hdQn3+hNoZxhIwWToRUS+HDnoAw+LkJX/KDQ==
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:34 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v6 net-next 08/14] net: phy: marvell-88q2xxx: add support for temperature sensor
Date: Tue, 13 Feb 2024 22:39:47 +0100
Message-Id: <20240213213955.178762-9-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
support for this sensor.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/Kconfig           |   1 +
 drivers/net/phy/marvell-88q2xxx.c | 146 ++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 9e2672800f0b..f21f46ea736b 100644
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


