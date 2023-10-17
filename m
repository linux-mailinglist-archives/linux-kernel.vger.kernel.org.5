Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEEC7CCE27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjJQUfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:35:33 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F1192
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:35:31 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c63117a659so3729426a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574931; x=1698179731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7r4zvpxf0zoLFhu7nkZPQCVPha50v5M0zuANIOxnVjs=;
        b=XKVseqAwqdeTCRVLjbP4ZAd51SNehjtWSNjxVfAX93qK8RE1PafyyhL4wD6aaWhzak
         oCQ0YTLA3aUS8Hxj344ukr9Qqg/bK8te9lpYizmRc5enJlwQ4tjAI2hUg6/vygfzRiuw
         PCbxILziEncSdQLNNPxJ52XkAdVmj7H6BfuYnBShnxtzl3ppv3GS0gzxzchFy7zYjqa8
         MW1O0WwL22IA7m2mHa+5k3AXox7V+4Z6gwxz45oyyOwRlgjsIGyuTUERKaSaBP/Bm4sI
         0zcyOXZ3tvfGnV2TJFtusdS0h1aCAMe0XNiqHeNoZ0XH59A4KSFIySknbfll0yrgJ0iP
         CK/Q==
X-Gm-Message-State: AOJu0YwKu2PFr6kd9H2PFtGO1IaLB0BY34VqgqnYAThKnLvrdKf1rakg
        mFFugC+3n/n9+PnkZLNwfIaFVxFaQQ==
X-Google-Smtp-Source: AGHT+IE3cbcCJaHWKJqkD81Maam0MuUwRIqlVBfGKhyTN1NupdMiboYj1cNsLT2/5g78BnOs4c9GZw==
X-Received: by 2002:a9d:6858:0:b0:6bc:bd1a:26d with SMTP id c24-20020a9d6858000000b006bcbd1a026dmr3379663oto.15.1697574930932;
        Tue, 17 Oct 2023 13:35:30 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d19-20020a9d72d3000000b006b96aee5195sm389500otk.11.2023.10.17.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:35:30 -0700 (PDT)
Received: (nullmailer pid 2700205 invoked by uid 1000);
        Tue, 17 Oct 2023 20:35:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] regulator: Drop unnecessary of_match_device() calls
Date:   Tue, 17 Oct 2023 15:35:06 -0500
Message-ID: <20231017203507.2699826-1-robh@kernel.org>
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

