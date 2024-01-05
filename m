Return-Path: <linux-kernel+bounces-17925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71A825532
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC17B2291E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D162E857;
	Fri,  5 Jan 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlgoingD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D92E82E;
	Fri,  5 Jan 2024 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso15859325e9.0;
        Fri, 05 Jan 2024 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464859; x=1705069659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXEnPVVp3wVpWIdG+9x/c6sHsvuF6chkE1VwFFekKRs=;
        b=ZlgoingDVW9Pc2seVNWPcTBNiKPx3+kJHn3FwRafCmiJf3txitXF/K1/6laIrOk41W
         HU6VM03mgSERHrXtkoLSBem2unDEi6Mz+zI5BY7agejQKAB45XGuqVGPhmvZOjjWu1mJ
         wL5uiGqu0Gcbk0y9+L9I+ZzslrQcElIPQFXeGDNEt6pfuTTCU25iTosWbOnUFIg1NWBb
         uj8tQU8zz9a1licNMnxEg+eqLd5PiQxZ81unyhBF5fByUD1uHnDl+nGlCt3cOdgPMK9E
         lbMjPgB6fl82f9+Xew5RQu69yzsqvhKGwXlWbc5KgAG9F7s/Jvm+YAmMZ8oDLom53UNq
         IY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464859; x=1705069659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXEnPVVp3wVpWIdG+9x/c6sHsvuF6chkE1VwFFekKRs=;
        b=BHSxVfrLyAez6n4qbxZzdshsha5/yo4erYFGSq8HP5k4TyLnl9lsnXMSkVXudZ8mCC
         m5ecgWL8toHJWUzVab4e65V704dskwWl50nsgF0hWI3skl922GuPone3b6ktnn5kiBXF
         xvaUu2kf/zrqQ4hpQxpxqXq8/HPMbm3VaOO6dhwouPUyT925IyeP7aQVh8fnsS5BgE6t
         Yk1hBsIyrqjoHj0CW/i2xlOhMKXcDCjHjfDvED6UJSOWpVq6cInJHa88CeEmJr1Ez6FQ
         v19w9UsIEzbrGHwqPeaogpmcr2srQLDK0Dj4z5AKKwjOABwjb/tIHg2gS+LrH4AFGzW0
         Cztg==
X-Gm-Message-State: AOJu0Yxre3rYsgefqb3WmBP6p/+g0rswV+zx4G2pDZzBsS8tQtgQaSYM
	bzdmKAHD9UWa6NB+MlDcBIQ=
X-Google-Smtp-Source: AGHT+IG7pcg+29dtvBdyWZYGeXqJXTDcFGVpu6uij+PRng82kSu7NQkSZjZPvOjfylF0xxr2uMjcvQ==
X-Received: by 2002:a05:600c:3f90:b0:40d:853b:7dc8 with SMTP id fs16-20020a05600c3f9000b0040d853b7dc8mr1159712wmb.15.1704464858999;
        Fri, 05 Jan 2024 06:27:38 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c190a00b0040d87100733sm1721901wmq.39.2024.01.05.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:27:38 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [net-next PATCH v9 3/5] net: phy: add support for PHY LEDs polarity modes
Date: Fri,  5 Jan 2024 15:27:15 +0100
Message-ID: <20240105142719.11042-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105142719.11042-1-ansuelsmth@gmail.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PHY LEDs polarity modes. Some PHY require LED to be set
to active low to be turned ON. Adds support for this by declaring
active-low property in DT.

PHY driver needs to declare .led_polarity_set() to configure LED
polarity modes. Function will pass the index with the LED index and a
bitmap with all the required modes to set.

Current supported modes are:
- active-low with the flag PHY_LED_ACTIVE_LOW. LED is set to active-low
  to turn it ON.
- inactive-high-impedance with the flag PHY_LED_INACTIVE_HIGH_IMPEDANCE.
  LED is set to high impedance to turn it OFF.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v9:
- Make LED probe fail if modes asked but not supported
- Fix wrong function description
Changes v5:
- Rework to LED modes bitmap
Changes v4:
- Drop for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 drivers/net/phy/phy_device.c | 16 ++++++++++++++++
 include/linux/phy.h          | 22 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1e595762afea..553be4f08a49 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3152,6 +3152,7 @@ static int of_phy_led(struct phy_device *phydev,
 	struct device *dev = &phydev->mdio.dev;
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
+	unsigned long modes = 0;
 	struct phy_led *phyled;
 	u32 index;
 	int err;
@@ -3169,6 +3170,21 @@ static int of_phy_led(struct phy_device *phydev,
 	if (index > U8_MAX)
 		return -EINVAL;
 
+	if (of_property_read_bool(led, "active-low"))
+		set_bit(PHY_LED_ACTIVE_LOW, &modes);
+	if (of_property_read_bool(led, "inactive-high-impedance"))
+		set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
+
+	if (modes) {
+		/* Return error if asked to set polarity modes but not supported */
+		if (!phydev->drv->led_polarity_set)
+			return -EINVAL;
+
+		err = phydev->drv->led_polarity_set(phydev, index, modes);
+		if (err)
+			return err;
+	}
+
 	phyled->index = index;
 	if (phydev->drv->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ac22b8e28a85..348209e71d8c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -860,6 +860,15 @@ struct phy_plca_status {
 	bool pst;
 };
 
+/* Modes for PHY LED configuration */
+enum phy_led_modes {
+	PHY_LED_ACTIVE_LOW = 0,
+	PHY_LED_INACTIVE_HIGH_IMPEDANCE = 1,
+
+	/* keep it last */
+	__PHY_LED_MODES_NUM,
+};
+
 /**
  * struct phy_led: An LED driven by the PHY
  *
@@ -1153,6 +1162,19 @@ struct phy_driver {
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
 
+	/**
+	 * @led_polarity_set: Set the LED polarity modes
+	 * @dev: PHY device which has the LED
+	 * @index: Which LED of the PHY device
+	 * @modes: bitmap of LED polarity modes
+	 *
+	 * Configure LED with all the required polarity modes in @modes
+	 * to make it correctly turn ON or OFF.
+	 *
+	 * Returns 0, or an error code.
+	 */
+	int (*led_polarity_set)(struct phy_device *dev, int index,
+				unsigned long modes);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.43.0


