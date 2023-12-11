Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121780DAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjLKTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjLKTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:23:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45274C2;
        Mon, 11 Dec 2023 11:23:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3331752d2b9so3372723f8f.3;
        Mon, 11 Dec 2023 11:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322629; x=1702927429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYjdgCjBy1xjm4sq4b9MMKYSKuGQZYYU7V1q9tmiNVY=;
        b=iyRODSwHj+iNxEJoXBB09Gp+sMj2d1nsu1voEj16V554A7qEIP6FGYYqKdyM9xXeVU
         eB6y/983sQXCTPF/2EveRpA/Wg2aE816tKjGeqtYviJvC5mF03yHHiC5JH6F5Gb8E3oE
         o1CuwV10oWJzXC3kpisgVq769mnxMQSBhW6o0JegkwsqK/GsFI7SuehEjOafkVFKiPIc
         v3MJzAXzPqDauwfQ3iBm4kz4cHRjlx+Dq/Q2pOqTQgeAsYYIoBLN9rlg6ws2eB8fTgYY
         4vUTKGQ09jjin5Kqtkan2OFCwo/V3unbzDb9pbfy5se9bPBaPeXul+r7QTj6dNlw/+xG
         lxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322629; x=1702927429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYjdgCjBy1xjm4sq4b9MMKYSKuGQZYYU7V1q9tmiNVY=;
        b=gL9iGcwEBhWqC6TjFHGh+6goZ+Y/3D4qs1vbyf/sfDGt9N84wlYSa1wU3bROt/3m28
         miz7uN45QRvO0OOVcVFstRq05EsG/7EgGcr0pE5nOmJrPrA8ftMLfj7s4Hk1JqvQCUhh
         LyB9e0Y4kcy6ifOb3EuW/tY8DyvlJEj08K1GvEt1GKLrcPPFPYHI3YvD7H0efqqOl7p7
         h3ycU2IQpe1s5Dsl+CZgUf1DX4vglKO56RsV4tr44h0VvYNlTMKYAX8lzqqSJnmv7cu+
         AExR8qnXwnlVV0d5cgm39u6F6B3Af5YUc30g7hr4ghRBrZPVy3T3PZuT78Mmqlc+g2Af
         5FRg==
X-Gm-Message-State: AOJu0YyiMwUFRl1pLjsRaSNytpAFP5oFPGoaquowb1wPu1Z9ggTIfrQa
        AIzmBbQ0ObPWa5tt9LDVOTg=
X-Google-Smtp-Source: AGHT+IErC/unZPo5UcQrreZvu9jhxCd5GdZE+uC3hpS1AMZTVYN5pCWLuq6a2T7oisJT3dEeFtl4dg==
X-Received: by 2002:adf:ebc4:0:b0:333:2fd2:8146 with SMTP id v4-20020adfebc4000000b003332fd28146mr3226090wrn.99.1702322628469;
        Mon, 11 Dec 2023 11:23:48 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id d16-20020a5d4f90000000b0033349bccac6sm9325197wru.1.2023.12.11.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:23:48 -0800 (PST)
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
Subject: [net-next RFC PATCH v2 2/4] net: phy: add support for PHY LEDs active-low
Date:   Mon, 11 Dec 2023 20:23:16 +0100
Message-Id: <20231211192318.16450-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211192318.16450-1-ansuelsmth@gmail.com>
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

