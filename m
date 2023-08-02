Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038076C66C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjHBHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjHBHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:20:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C94198B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:20:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f38692b3so6265355b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690960823; x=1691565623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5ftHAQDjcyj/Z4+kE7V/9JWCccuDvgK9YYpIpkaD7s=;
        b=uJpsdXjUnG64+/qe2oDpEE5YmeJqxRG3Tegc++iaB/POJ6UVm++74TtzNqbeYV/wzL
         tNIfj6inHajfNMbAbbGMho7JlYJJXJSRixg9rMIkrJuI8lb5lZfi8p8LC6KDhkOBg87I
         xZKfQP5WMmaHVYl9QDxOQAeNJrAQNtKbNHYoOHqZivPczHMQzW2mwSTjMVTdhXhaYe/G
         AaXrk8qlKVxlE1I6OVrGNzPcgoFuJuMBxjFflko61b0Jemef3hP5dg4kgDJJCiMSoyzv
         zkfczF5Ine5sp09FwiI8Hgf/zcNInaKWlPpOiGR6wW6dzfKjlgWmzp58lNZ7I+UhPAC2
         shbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960823; x=1691565623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5ftHAQDjcyj/Z4+kE7V/9JWCccuDvgK9YYpIpkaD7s=;
        b=IdkJgApEdB3xYVZn3wulwwVmr3q5DZbiqqJllJEibjBnU6yEyrRxd/oDjFtECZJeC1
         93i/g8d7BZ0cmpzjX9GpBIzzTMVu8HfvZv52+CBz/nWn2Y1CGenV0FYsuHcepfmUP9Z7
         SkeYLsBeMPBhyc0YIOIY78ENnWfexrbERrGeXnXID/CLd8UVspDqYqb+Ae/hWOFjRcyx
         kMdxD52Kvcn4jMZ87ZD32n8HCy6llV+TwnQmkWNYPmQtssLsG2NgTXJ8V+8F/XW9gBQ/
         hjnE+QQ8A8M6Gu3RWwVsfXhxf1KLFrED6zhcC3l24QMVc+nh54tS9OYAmHmVgiayeJKM
         +fxw==
X-Gm-Message-State: ABy/qLYYjocVxR7Gq7gR9k2w+yOzLk4PJU60QmLznct1vmTpl/AcKwN5
        rXDio4tflGQPEmK6Y1XGSVr5ng==
X-Google-Smtp-Source: APBJJlH6UAADSMCFbOqshd7InChK686drg58bZe8DPWhwbaR5xmoEtTvsuelbk0sFRfbXhBu0f6kIw==
X-Received: by 2002:a05:6a21:3397:b0:132:bdba:5518 with SMTP id yy23-20020a056a21339700b00132bdba5518mr19854934pzb.54.1690960823400;
        Wed, 02 Aug 2023 00:20:23 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id fe12-20020a056a002f0c00b00684ca1b45b9sm10732543pfb.149.2023.08.02.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:20:22 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v6 2/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Wed,  2 Aug 2023 15:19:47 +0800
Message-Id: <20230802071947.1683318-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t is a TDDI IC (Touch with Display Driver). The
datasheet specifies there should be 60ms between touch SDA
sleep and panel RESX. Doug's series[1] allows panels and
touchscreens to power on/off together, so we can add the 65 ms
delay in i2c_hid_core_suspend before panel_unprepare.

Because ili9882t touchscrgeen is a panel follower, and
needs to use vccio-supply instead of vcc33-supply, so set
it NULL to ili9882t_chip_data, then not use vcc33 regulator.

[1]: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 50 ++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 029045d9661c..31abab57ad44 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -18,9 +18,11 @@
 #include "i2c-hid.h"
 
 struct elan_i2c_hid_chip_data {
-	unsigned int post_gpio_reset_delay_ms;
+	unsigned int post_gpio_reset_on_delay_ms;
+	unsigned int post_gpio_reset_off_delay_ms;
 	unsigned int post_power_delay_ms;
 	u16 hid_descriptor_address;
+	const char *main_supply_name;
 };
 
 struct i2c_hid_of_elan {
@@ -38,9 +40,11 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 	int ret;
 
-	ret = regulator_enable(ihid_elan->vcc33);
-	if (ret)
-		return ret;
+	if (ihid_elan->vcc33) {
+		ret = regulator_enable(ihid_elan->vcc33);
+		if (ret)
+			return ret;
+	}
 
 	ret = regulator_enable(ihid_elan->vccio);
 	if (ret) {
@@ -52,8 +56,8 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
-	if (ihid_elan->chip_data->post_gpio_reset_delay_ms)
-		msleep(ihid_elan->chip_data->post_gpio_reset_delay_ms);
+	if (ihid_elan->chip_data->post_gpio_reset_on_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
 }
@@ -64,8 +68,12 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
 	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
+		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
+
 	regulator_disable(ihid_elan->vccio);
-	regulator_disable(ihid_elan->vcc33);
+	if (ihid_elan->vcc33)
+		regulator_disable(ihid_elan->vcc33);
 }
 
 static int i2c_hid_of_elan_probe(struct i2c_client *client)
@@ -89,24 +97,42 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 	if (IS_ERR(ihid_elan->vccio))
 		return PTR_ERR(ihid_elan->vccio);
 
-	ihid_elan->vcc33 = devm_regulator_get(&client->dev, "vcc33");
-	if (IS_ERR(ihid_elan->vcc33))
-		return PTR_ERR(ihid_elan->vcc33);
-
 	ihid_elan->chip_data = device_get_match_data(&client->dev);
 
+	if (ihid_elan->chip_data->main_supply_name) {
+		ihid_elan->vcc33 = devm_regulator_get(&client->dev,
+						      ihid_elan->chip_data->main_supply_name);
+		if (IS_ERR(ihid_elan->vcc33))
+			return PTR_ERR(ihid_elan->vcc33);
+	}
+
 	return i2c_hid_core_probe(client, &ihid_elan->ops,
 				  ihid_elan->chip_data->hid_descriptor_address, 0);
 }
 
 static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.post_power_delay_ms = 1,
-	.post_gpio_reset_delay_ms = 300,
+	.post_gpio_reset_on_delay_ms = 300,
+	.hid_descriptor_address = 0x0001,
+	.main_supply_name = "vcc33",
+};
+
+static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
+	.post_power_delay_ms = 1,
+	.post_gpio_reset_on_delay_ms = 200,
+	.post_gpio_reset_off_delay_ms = 65,
 	.hid_descriptor_address = 0x0001,
+	/*
+	 * this touchscreen is tightly integrated with the panel and assumes
+	 * that the relevant power rails (other than the IO rail) have already
+	 * been turned on by the panel driver because we're a panel follower.
+	 */
+	.main_supply_name = NULL,
 };
 
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.25.1

