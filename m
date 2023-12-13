Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72111810F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378727AbjLMLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378616AbjLMLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:13:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2CB0;
        Wed, 13 Dec 2023 03:13:37 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c317723a8so58052795e9.3;
        Wed, 13 Dec 2023 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702466016; x=1703070816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3zKCeCRkldFKgWiWSKXv43mAIMprUIreQLunV+AG6M=;
        b=IPW21o2FDwKdvk4PY75RmpLcnLjIdrLmnt3ejPUD2a0hzpV/yunFmOnw21tqVWS5ko
         R3/+2SKmLYbIB8hfbgF+w0VcI45oSYO+PKKAm3wNqB94n3kDi8+gFvp/8JSTAjbtVCUM
         cAERAv+LXGBqlp06TavW+/kk7jppSiY3Z51p7+a+RAWdJOV7ppK0RPhDw/bEf01LjfCF
         QiZlLHVnxX6KMvI22rzF9L8HCr4dZzhf2FKiHSGpgXaR7jxdzx3gwiGVPfpDtoGfp1NM
         hevo7m1/1+tgqtTDbcdMAVei7db2BR3Q6vzCj7V7MYEhilm4WX2iWA0CKnGVWa7BRS+K
         aApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702466016; x=1703070816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3zKCeCRkldFKgWiWSKXv43mAIMprUIreQLunV+AG6M=;
        b=bdUy8R7a7eGKET6JZPa2CsWS7d728IuYIgIuH+4XNi4rPG45DR7oWQ6URIAxG78J2l
         Q4jJVgA8T3Esota+cyKp9b/uRW2hzqLUuImOYpZwQloBd4d5mP4ical+VXwMz93TBDyY
         ft6VtO3qxbOH2zZLEi9YjdeVfkX9b+CKgkfbsv7eHupgVz7V41bvY9/JO1KdECngBJTM
         btXyNOIE4scQyihFbBt5raNM/aGULTtmBBbJIGT5iuc+q61KhKuaX++hctx3znGJHBO+
         5K88m2PwoeanzPDsb9BoX6rsL9t9g8cjp339PslqlfW2WHXVa9hHtHEm1n/wEhvQePP9
         4xXA==
X-Gm-Message-State: AOJu0YxozQ03ybdd58StBWgoSsO+sGsuSD8/aqORDfO6ym7Mo8gg2Nkx
        og9gn0Q8YBZoldV4cDMAhCc=
X-Google-Smtp-Source: AGHT+IFmjUcxlJV7nVqHKgM6Rw4FHKWyvXxORWOouigwe4TobMBzL9ED0gS4J25FX5HEvMyZ18fUxg==
X-Received: by 2002:a05:600c:4749:b0:40c:31e6:cae3 with SMTP id w9-20020a05600c474900b0040c31e6cae3mr3821510wmo.115.1702466015371;
        Wed, 13 Dec 2023 03:13:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm12388301wmb.46.2023.12.13.03.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:13:35 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH v3 2/4] net: phy: add support for PHY LEDs active-low
Date:   Wed, 13 Dec 2023 12:13:20 +0100
Message-Id: <20231213111322.6152-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213111322.6152-1-ansuelsmth@gmail.com>
References: <20231213111322.6152-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PHY LEDs active-low. Some PHY require LED to be set to
active low to be turned on. Adds support for this by declaring
active-low property in DT.

Active-low can be defined in 2 different way:
- In leds node to apply the active low setting globally for every LED.
- In each led to apply the active low setting per LED (if supported).

PHY driver needs to declare .led_polarity_set() to configure LED
polarity. Index will be -1 if the option is set globally or will
indicate the LED to apply the polarity settings. Function finally pass a
bool to indicate if LED has to be set active low.

.led_polarity_set() is called for both leds node and for each led
subnode. PHY driver will ignore the additional call based on the passed
index value if global setting or per LED setting is supported.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
 include/linux/phy.h          | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d8e9335d415c..a9f5d250abff 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3093,6 +3093,7 @@ static int of_phy_led(struct phy_device *phydev,
 	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
 	struct phy_led *phyled;
+	bool active_low;
 	u32 index;
 	int err;
 
@@ -3109,6 +3110,13 @@ static int of_phy_led(struct phy_device *phydev,
 	if (index > U8_MAX)
 		return -EINVAL;
 
+	active_low = of_property_read_bool(led, "active-low");
+	if (phydev->drv->led_polarity_set) {
+		err = phydev->drv->led_polarity_set(phydev, index, active_low);
+		if (err)
+			return err;
+	}
+
 	phyled->index = index;
 	if (phydev->drv->led_brightness_set)
 		cdev->brightness_set_blocking = phy_led_set_brightness;
@@ -3145,6 +3153,7 @@ static int of_phy_leds(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
 	struct device_node *leds, *led;
+	bool active_low;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
@@ -3157,6 +3166,15 @@ static int of_phy_leds(struct phy_device *phydev)
 	if (!leds)
 		return 0;
 
+	active_low = of_property_read_bool(leds, "active-low");
+	if (phydev->drv->led_polarity_set) {
+		err = phydev->drv->led_polarity_set(phydev, -1, active_low);
+		if (err) {
+			of_node_put(leds);
+			return err;
+		}
+	}
+
 	for_each_available_child_of_node(leds, led) {
 		err = of_phy_led(phydev, led);
 		if (err) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6e7ebcc50b85..cbdebf174361 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1145,6 +1145,21 @@ struct phy_driver {
 	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
 				  unsigned long *rules);
 
+	/**
+	 * @led_polarity_set: Set the LED polarity if active low
+	 * @dev: PHY device which has the LED
+	 * @index: Which LED of the PHY device or -1
+	 * @active_low: LED needs to be set low to turn on
+	 *
+	 * Set the PHY to require the LED low to turn on.
+	 * index can be the LED of the PHY device or -1 whether the
+	 * LED polatiry is global and applied to every LED or polarity
+	 * is set per LED.
+	 *
+	 * Returns 0, or an error code.
+	 */
+	int (*led_polarity_set)(struct phy_device *dev, int index,
+				bool active_low);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.40.1

