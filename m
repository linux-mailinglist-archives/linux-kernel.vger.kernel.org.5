Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21CE7CCE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbjJQUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbjJQUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:36:11 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23210B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:36:09 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57b8cebf57dso3228439eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574968; x=1698179768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp4asLkwGRPLkOyqnoVQPynyhlSBf1G6TTRiIz+Q35E=;
        b=EB8IjxUMQ+P3m9ZqyaYY0KJmWAZ8PhBxyzyBD8pNtmbjIp5SUEi/LLUHHjmkf6/FE2
         y2ljBbJ2E7pRLr+Icp9Iy8O+P00GsTdwHrRMCQpFxZTvPdIm3PMEDhd59gWMZxxq+Qh6
         T8PKbUoscNopx8eXoR36IXgcr+pq3WeaNhXCLyoMIj3JqD+TGezhGz+Y5FZRWLDnjB5a
         GAF2tPKWYhOXqv+MtM+iA6nX22Yva8BDkxniKNRPZozWtttRRJvWRINOMWAsMcvYJGtH
         6YJX6QOItVn0a+aL8MCnzD8ww0CySdwAktxA7uioNcfSLPlwWGxuBboqYf8Qn0tv/X5o
         H0Ww==
X-Gm-Message-State: AOJu0YxGKa8in63mrL+Z7geKIFKrrphXybf0tI+butQ2viPUoKW/EZwY
        O6GNobcFWK7bpkdXnL2UHy7EpMYKpw==
X-Google-Smtp-Source: AGHT+IEezwMTNEPD4DSjhEu2EwxSfeDkwNI2CPWTrVrAjZmiYfEpmdvo2gdCkXjEyWFy5VbqArEy+w==
X-Received: by 2002:a05:6820:b0c:b0:581:f2de:25f8 with SMTP id df12-20020a0568200b0c00b00581f2de25f8mr263162oob.0.1697574968502;
        Tue, 17 Oct 2023 13:36:08 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dk24-20020a4aee98000000b00573f5173a57sm373692oob.23.2023.10.17.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:36:07 -0700 (PDT)
Received: (nullmailer pid 2700987 invoked by uid 1000);
        Tue, 17 Oct 2023 20:36:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mfd: Use i2c_get_match_data()
Date:   Tue, 17 Oct 2023 15:36:02 -0500
Message-ID: <20231017203603.2700864-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred i2c_get_match_data() instead of of_match_device() and
i2c driver_data to get the driver match data. With this, adjust the
includes to explicitly include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/lochnagar-i2c.c |  9 ++-------
 drivers/mfd/lp87565.c       |  9 +++------
 drivers/mfd/max14577.c      | 14 +++-----------
 drivers/mfd/rn5t618.c       | 11 ++---------
 drivers/mfd/wm831x-i2c.c    | 16 ++++------------
 drivers/mfd/wm8994-core.c   | 11 +----------
 6 files changed, 15 insertions(+), 55 deletions(-)

diff --git a/drivers/mfd/lochnagar-i2c.c b/drivers/mfd/lochnagar-i2c.c
index 59092f839d65..0b76fcccd0bd 100644
--- a/drivers/mfd/lochnagar-i2c.c
+++ b/drivers/mfd/lochnagar-i2c.c
@@ -15,8 +15,8 @@
 #include <linux/i2c.h>
 #include <linux/lockdep.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 
@@ -270,7 +270,6 @@ static int lochnagar_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	const struct lochnagar_config *config = NULL;
-	const struct of_device_id *of_id;
 	struct lochnagar *lochnagar;
 	struct gpio_desc *reset, *present;
 	unsigned int val;
@@ -282,11 +281,7 @@ static int lochnagar_i2c_probe(struct i2c_client *i2c)
 	if (!lochnagar)
 		return -ENOMEM;
 
-	of_id = of_match_device(lochnagar_of_match, dev);
-	if (!of_id)
-		return -EINVAL;
-
-	config = of_id->data;
+	config = i2c_get_match_data(i2c);
 
 	lochnagar->dev = dev;
 	mutex_init(&lochnagar->analogue_config_lock);
diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 1b7f8349911d..08c62ddfb4f5 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -6,10 +6,11 @@
  */
 
 #include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/lp87565.h>
@@ -46,7 +47,6 @@ MODULE_DEVICE_TABLE(of, of_lp87565_match_table);
 static int lp87565_probe(struct i2c_client *client)
 {
 	struct lp87565 *lp87565;
-	const struct of_device_id *of_id;
 	int ret;
 	unsigned int otpid;
 
@@ -89,10 +89,7 @@ static int lp87565_probe(struct i2c_client *client)
 	}
 
 	lp87565->rev = otpid & LP87565_OTP_REV_OTP_ID;
-
-	of_id = of_match_device(of_lp87565_match_table, &client->dev);
-	if (of_id)
-		lp87565->dev_type = (uintptr_t)of_id->data;
+	lp87565->dev_type = (uintptr_t)i2c_get_match_data(client);
 
 	i2c_set_clientdata(client, lp87565);
 
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 1f4f5002595c..8f7472c76009 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -9,9 +9,10 @@
 // This driver is based on max8997.c
 
 #include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/max14577.h>
 #include <linux/mfd/max14577-private.h>
@@ -357,7 +358,6 @@ static void max77836_remove(struct max14577 *max14577)
 
 static int max14577_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct max14577 *max14577;
 	struct max14577_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct device_node *np = i2c->dev.of_node;
@@ -397,15 +397,7 @@ static int max14577_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	if (np) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(max14577_dt_match, &i2c->dev);
-		if (of_id)
-			max14577->dev_type = (uintptr_t)of_id->data;
-	} else {
-		max14577->dev_type = id->driver_data;
-	}
+	max14577->dev_type = (enum maxim_device_type)i2c_get_match_data(i2c);
 
 	max14577_print_dev_type(max14577);
 
diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 0fe616b2db8e..7336e6d8a001 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/rn5t618.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
@@ -179,22 +179,15 @@ MODULE_DEVICE_TABLE(of, rn5t618_of_match);
 
 static int rn5t618_i2c_probe(struct i2c_client *i2c)
 {
-	const struct of_device_id *of_id;
 	struct rn5t618 *priv;
 	int ret;
 
-	of_id = of_match_device(rn5t618_of_match, &i2c->dev);
-	if (!of_id) {
-		dev_err(&i2c->dev, "Failed to find matching DT ID\n");
-		return -EINVAL;
-	}
-
 	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, priv);
-	priv->variant = (long)of_id->data;
+	priv->variant = (long)i2c_get_match_data(i2c);
 	priv->irq = i2c->irq;
 	priv->dev = &i2c->dev;
 
diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
index 694ddbbf0372..9bee007f9c99 100644
--- a/drivers/mfd/wm831x-i2c.c
+++ b/drivers/mfd/wm831x-i2c.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/wm831x/core.h>
@@ -23,22 +22,15 @@
 
 static int wm831x_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct wm831x_pdata *pdata = dev_get_platdata(&i2c->dev);
-	const struct of_device_id *of_id;
 	struct wm831x *wm831x;
 	enum wm831x_parent type;
 	int ret;
 
-	if (i2c->dev.of_node) {
-		of_id = of_match_device(wm831x_of_match, &i2c->dev);
-		if (!of_id) {
-			dev_err(&i2c->dev, "Failed to match device\n");
-			return -ENODEV;
-		}
-		type = (uintptr_t)of_id->data;
-	} else {
-		type = (enum wm831x_parent)id->driver_data;
+	type = (uintptr_t)i2c_get_match_data(i2c);
+	if (!type) {
+		dev_err(&i2c->dev, "Failed to match device\n");
+		return -ENODEV;
 	}
 
 	wm831x = devm_kzalloc(&i2c->dev, sizeof(struct wm831x), GFP_KERNEL);
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index aba7af688175..d5ac066f9db4 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/mfd/core.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -612,8 +611,6 @@ MODULE_DEVICE_TABLE(of, wm8994_of_match);
 
 static int wm8994_i2c_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
-	const struct of_device_id *of_id;
 	struct wm8994 *wm8994;
 	int ret;
 
@@ -625,13 +622,7 @@ static int wm8994_i2c_probe(struct i2c_client *i2c)
 	wm8994->dev = &i2c->dev;
 	wm8994->irq = i2c->irq;
 
-	if (i2c->dev.of_node) {
-		of_id = of_match_device(wm8994_of_match, &i2c->dev);
-		if (of_id)
-			wm8994->type = (uintptr_t)of_id->data;
-	} else {
-		wm8994->type = id->driver_data;
-	}
+	wm8994->type = (enum wm8994_type)i2c_get_match_data(i2c);
 
 	wm8994->regmap = devm_regmap_init_i2c(i2c, &wm8994_base_regmap_config);
 	if (IS_ERR(wm8994->regmap)) {
-- 
2.42.0

