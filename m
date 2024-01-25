Return-Path: <linux-kernel+bounces-39253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EBB83CD93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DA6B2522F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCEF13AA46;
	Thu, 25 Jan 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEVS9VG6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BC1386D5;
	Thu, 25 Jan 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215046; cv=none; b=SLvd2YjsGqAgTLFlnSh9vu3uwqTV0RBwDzNgxh1TnxUGz1Gl5xa4ep51Q0fs3Xeld15lTW5bMyVl23BP7YHg/cslVt9OctVTwdBgnMrd6RGKS73KbF6KnaQumQFXBiw7J3ivhYt1iZfI+LKF4OvFfr6xR8EWBRDcVXPqwfYJcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215046; c=relaxed/simple;
	bh=OY/CIaPBCKIjFDNlNL1iTCqE6gW8vC8FhQ1KzxBDIR0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksBvZb/aKW3fmZtJcMYD41C0XBlXyPHvvcQAvWfQbiEhXT/zL9v1u4KwSTjwepCepcU4930M3zCZsBzeq2KXAErOclptyT016UAsQ0vw60ZWd6SohlUPWBeKmHDNHkM+J8BT4nFUZFwprEHSwuHrlIRhE+jjg6s4eb2IwPAoJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEVS9VG6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40ed2333c8fso12029065e9.0;
        Thu, 25 Jan 2024 12:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215043; x=1706819843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYZjI2Tknpmm3tYZbjPO9Pae0r5NRRsVcbrpdnsJuFs=;
        b=KEVS9VG6ssFWWcbM/S/QJ/zuHtPN+x9+gEOcvYcs6wOZLWv3S1D5DryIuzzn5mj0IG
         SDzudM8svdkxX1GcYifBZSBMoPm8Np5xC/mdesnQAQ5BH/akyrZ8TKLk9jntyD8RLJkP
         /TkmsuFsoIfKpLvMhSxOFBPXzRq09l2lAOYbhfbk7P2gMma6NSv0MfY2AYuLDkVFmDxF
         k6F+8ObAuMKqGaqaB2rsawi+KBIxRJJWw4C55yci8zL1bQ2dijbeqRySL+M3HtVMMajR
         98QEsscQjJx5BOdRPrgF8OWOmYr+aKqQNhG6LJSmJieBBBwCfZTmUpdmy2ISQ2BYAra1
         rh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215043; x=1706819843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYZjI2Tknpmm3tYZbjPO9Pae0r5NRRsVcbrpdnsJuFs=;
        b=Jgep+sU9KXHjopA67IyCMp872woJ/l377pWH/PfcOVgeAbW89NnkYpXQordN6Agtk/
         zDhFFo7ogAK8E+oRZmAjxm//2Ps2xr4KL9VME9DGeOtx41coz/6Ev+wSn+CypOcyqpMZ
         w8VL1Be4kcuc3YZiZ8A67rfWc2lI5ZRcMcj1TrRnznwDmvmenJiP+hHz50wtk5lQO+4l
         zoRCBB9NweV0KOvobYMaQ6quSr6gpk76S0rF1BFsd3taBpsaXqjmjwMpv0vqia/3qAbm
         iXM11EJfMM/wkbCKct/Y1DZeTB8PeRGsYdj/ilJTbYIfR5L0Z0gCW3MsVrq7KAdS16Hi
         PWWg==
X-Gm-Message-State: AOJu0YzRz/7aNA6OExh+q3pjmCN/jNQQ4AsqdePg6Hb+cFj4lD5KD1N5
	HHRWhb0LFejrsFhtxu4+VuUKtOD9TCMuzRUh6wxpmqY5Gx4ydAv+
X-Google-Smtp-Source: AGHT+IE8WEhZK1nB9SZJbuut4HrFo2ARoCLSJoqMk6QZTFKuYSRozcLC3U1GRpZjIFCcaLB5kCj+IQ==
X-Received: by 2002:a05:600c:2112:b0:40e:4b49:9b0f with SMTP id u18-20020a05600c211200b0040e4b499b0fmr152473wml.239.1706215042819;
        Thu, 25 Jan 2024 12:37:22 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j32-20020a05600c1c2000b0040e813f1f31sm3817700wms.25.2024.01.25.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:37:22 -0800 (PST)
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
Subject: [net-next PATCH v10 3/5] net: phy: add support for PHY LEDs polarity modes
Date: Thu, 25 Jan 2024 21:36:59 +0100
Message-ID: <20240125203702.4552-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125203702.4552-1-ansuelsmth@gmail.com>
References: <20240125203702.4552-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v10:
- Add Review tag
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
index 3611ea64875e..dd778c7fde1d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3097,6 +3097,7 @@ static int of_phy_led(struct phy_device *phydev,
 	struct device *dev = &phydev->mdio.dev;
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
+	unsigned long modes = 0;
 	struct phy_led *phyled;
 	u32 index;
 	int err;
@@ -3114,6 +3115,21 @@ static int of_phy_led(struct phy_device *phydev,
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
index 684efaeca07c..c9994a59ca2e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -852,6 +852,15 @@ struct phy_plca_status {
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
@@ -1145,6 +1154,19 @@ struct phy_driver {
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


