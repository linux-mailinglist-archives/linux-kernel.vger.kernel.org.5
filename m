Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C887BEC7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378643AbjJIVOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378657AbjJIVOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185892
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA74C433BA;
        Mon,  9 Oct 2023 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886054;
        bh=vXdS6prYg0vTMoJ0Kq07ybf3uIB5ClVyk/8JPboxWbw=;
        h=From:To:Cc:Subject:Date:From;
        b=JHKpR1bc8VPvT+UEgmag2buUjSi/GHDsQsHvcjdx79u5ZWj3+XSCMk6P4TVBPbFiB
         n7AbBWbC563JG5bET7La2D+8sDsf/mLr2kCt5wp7+MxFrcTeqt1eYdN2UOt9QC4SmH
         9iZ3pEQl/hxU2VxWiCI4jQaoHYFByCQDwpZbqUTUEoAOqvi3ZEI+/0ySoQqZHQ8pkh
         RcIJv+0RFFUebPjuZM+d8rvSG1UhxX1yyub3h6oJeOy0i5sfdtifSOzDVs6jQFEIMX
         pg8HBK2mQlTMcUaKUAhTc5L2gTab4eCcU4SgwvHXZI2lKJuKqej4Zv3bVMlgEqaQ7C
         COuH3DShT8mBw==
Received: (nullmailer pid 3245430 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: Use i2c_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:34 -0500
Message-ID: <20231009211356.3242037-4-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

