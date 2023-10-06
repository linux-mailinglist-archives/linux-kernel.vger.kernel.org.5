Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1747BBC5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjJFQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJFQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:05:02 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610CB6;
        Fri,  6 Oct 2023 09:05:01 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 484C9100004;
        Fri,  6 Oct 2023 19:04:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 484C9100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1696608299;
        bh=1i5KLJDlmR04HZpxnNtNnrQF26X3njVdttX9GpsMovo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=rgEflgYctyEV6xGQzhHvWnPgVFXkKq4uQxP8p8BHhjVetRTivNaRlec2qBmaqhA2u
         8pXejWf5cvrv21tgnfwH9DKShFAGsk9xdjCrLGpjrRhOTelbnA7nMNtM8NTR2tX5ti
         udujrYd/alZn12TTPvFbfbbiDyEwmni2jYaPpTG7dgIOaAapI5cmZCqHx2MmWo3Vu6
         KRP02uv56Oow2T46/Nf35AHdbofWVX9X/6mJE/3IIyKbtmfSWXa3oNQj2rWEryM5Y0
         RcEqiDYRHQ1SGYoj9UKgC4O1NW4VM+c7C81eOX36cJgIcm+OAegXy6AXEdLCZxQp0R
         JmPN7ekdzctjw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri,  6 Oct 2023 19:04:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 6 Oct 2023 19:04:58 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>
CC:     <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>,
        Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 03/11] leds: aw200xx: support HWEN hardware control
Date:   Fri, 6 Oct 2023 19:04:29 +0300
Message-ID: <20231006160437.15627-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231006160437.15627-1-ddrokosov@salutedevices.com>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180438 [Oct 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/06 13:25:00 #22070343
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HWEN is hardware control, which is used for enable/disable aw200xx chip.
It's high active, internally pulled down to GND.

After HWEN pin set high the chip begins to load the OTP information,
which takes 200us to complete. About 200us wait time is needed for
internal oscillator startup and display SRAM initialization. After
display SRAM initialization, the registers in page1 to page5 can be
configured via i2c interface.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/leds/leds-aw200xx.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index 4c1e7caf8941..d92c082d4ab3 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/time.h>
 #include <linux/units.h>
@@ -116,6 +117,7 @@ struct aw200xx {
 	struct mutex mutex;
 	u32 num_leds;
 	u32 display_rows;
+	int hwen;
 	struct aw200xx_led leds[];
 };
 
@@ -358,6 +360,29 @@ static int aw200xx_chip_check(const struct aw200xx *const chip)
 	return 0;
 }
 
+static void aw200xx_enable(const struct aw200xx *const chip)
+{
+	if (!gpio_is_valid(chip->hwen))
+		return;
+
+	gpio_set_value(chip->hwen, 1);
+
+	/*
+	 * After HWEN pin set high the chip begins to load the OTP information,
+	 * which takes 200us to complete. About 200us wait time is needed for
+	 * internal oscillator startup and display SRAM initialization. After
+	 * display SRAM initialization, the registers in page1 to page5 can be
+	 * configured via i2c interface.
+	 */
+	usleep_range(400, 500);
+}
+
+static void aw200xx_disable(const struct aw200xx *const chip)
+{
+	if (gpio_is_valid(chip->hwen))
+		gpio_set_value(chip->hwen, 0);
+}
+
 static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 {
 	struct fwnode_handle *child;
@@ -445,6 +470,18 @@ static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
 	return aw200xx_set_imax(chip, min_uA);
 }
 
+static void aw200xx_probe_hwen(struct device *dev, struct aw200xx *chip)
+{
+	chip->hwen = of_get_named_gpio(dev->of_node, "awinic,hwen-gpio", 0);
+	if (gpio_is_valid(chip->hwen))
+		if (devm_gpio_request_one(dev, chip->hwen, GPIOF_OUT_INIT_HIGH,
+					  "AW200XX HWEN")) {
+			dev_warn(dev, "Can't request gpio %d, tag it invalid\n",
+				 chip->hwen);
+			chip->hwen = -EINVAL;
+		}
+}
+
 static const struct regmap_range_cfg aw200xx_ranges[] = {
 	{
 		.name = "aw200xx",
@@ -517,6 +554,10 @@ static int aw200xx_probe(struct i2c_client *client)
 	if (IS_ERR(chip->regmap))
 		return PTR_ERR(chip->regmap);
 
+	aw200xx_probe_hwen(&client->dev, chip);
+
+	aw200xx_enable(chip);
+
 	ret = aw200xx_chip_check(chip);
 	if (ret)
 		return ret;
@@ -537,6 +578,9 @@ static int aw200xx_probe(struct i2c_client *client)
 	ret = aw200xx_chip_init(chip);
 
 out_unlock:
+	if (ret)
+		aw200xx_disable(chip);
+
 	mutex_unlock(&chip->mutex);
 	return ret;
 }
@@ -546,6 +590,7 @@ static void aw200xx_remove(struct i2c_client *client)
 	struct aw200xx *chip = i2c_get_clientdata(client);
 
 	aw200xx_chip_reset(chip);
+	aw200xx_disable(chip);
 	mutex_destroy(&chip->mutex);
 }
 
-- 
2.36.0

