Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46B7BEC8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378658AbjJIVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjJIVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADF126
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:14:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B6C433CB;
        Mon,  9 Oct 2023 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886065;
        bh=5QUvp4Oe4S+8/M7XRwtWI4U8jTaK42sB+VYoWBEAtIw=;
        h=From:To:Cc:Subject:Date:From;
        b=c9G+6QJR2Xeuf52QNFB3Z8Ee/Xla3rDBdHZVYhGdO5S87X6mJBL1ytNYApnurUpGZ
         Bk9SRFpx7gMObodQO8oQeBB0akwVtn6hxWsCK5nQNPcsHtUPKSbqrS1z3wKc8gjEXW
         hooYipixyExEetaBA435bFOGksqVSVDoTULq0dnKdZ4e278vpij/U7pIvW1V9P28HQ
         CMQI+Yy7f9NcVU7zJR0DbJSPCm1aBuHu0CXPp5H5oUvej6cjfb7ok5fgySDGsS5QbM
         4anGA+qvc37voW3Mg8+5Nik2105u/CDWDvnJ26F/iOMrBm9Y5KJ3AuT44x/xxoOgQm
         K59hCpySPKfSw==
Received: (nullmailer pid 3245916 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Drop unnecessary of_match_device() calls
Date:   Mon,  9 Oct 2023 16:13:39 -0500
Message-ID: <20231009211356.3242037-9-robh@kernel.org>
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

If probe is reached, we've already matched the device and in the case of
DT matching, the struct device_node pointer will be set. Therefore, there
is no need to call of_match_device() in probe.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/regulator/da9210-regulator.c   | 12 +-----------
 drivers/regulator/max1586.c            |  9 +--------
 drivers/regulator/tps51632-regulator.c | 11 -----------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 252f74ab9bc0..02b85ca4a6fc 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -10,7 +10,7 @@
 #include <linux/irq.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regmap.h>
 
@@ -135,16 +135,6 @@ static int da9210_i2c_probe(struct i2c_client *i2c)
 	struct regulator_dev *rdev = NULL;
 	struct regulator_config config = { };
 	int error;
-	const struct of_device_id *match;
-
-	if (i2c->dev.of_node && !pdata) {
-		match = of_match_device(of_match_ptr(da9210_dt_ids),
-						&i2c->dev);
-		if (!match) {
-			dev_err(&i2c->dev, "Error: No device match found\n");
-			return -ENODEV;
-		}
-	}
 
 	chip = devm_kzalloc(&i2c->dev, sizeof(struct da9210), GFP_KERNEL);
 	if (!chip)
diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index 90aa5b723c03..0f133129252e 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -11,7 +11,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/slab.h>
 #include <linux/regulator/max1586.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/of_regulator.h>
 
 #define MAX1586_V3_MAX_VSEL 31
@@ -213,16 +213,9 @@ static int max1586_pmic_probe(struct i2c_client *client)
 	struct regulator_config config = { };
 	struct max1586_data *max1586;
 	int i, id, ret;
-	const struct of_device_id *match;
 
 	pdata = dev_get_platdata(&client->dev);
 	if (client->dev.of_node && !pdata) {
-		match = of_match_device(of_match_ptr(max1586_of_match),
-					&client->dev);
-		if (!match) {
-			dev_err(&client->dev, "Error: No device match found\n");
-			return -ENODEV;
-		}
 		ret = of_get_max1586_platform_data(&client->dev, &pdata_of);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index d8a856c1587a..5199e0437388 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -16,7 +16,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
@@ -255,16 +254,6 @@ static int tps51632_probe(struct i2c_client *client)
 	int ret;
 	struct regulator_config config = { };
 
-	if (client->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_device(of_match_ptr(tps51632_of_match),
-				&client->dev);
-		if (!match) {
-			dev_err(&client->dev, "Error: No device match found\n");
-			return -ENODEV;
-		}
-	}
-
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
 		return -ENOMEM;
-- 
2.42.0

