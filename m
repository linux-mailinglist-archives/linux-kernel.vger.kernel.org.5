Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8603799ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbjIJPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjIJPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:22:18 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7392B1BD;
        Sun, 10 Sep 2023 08:22:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="175582258"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2023 00:22:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 70EF54006C6A;
        Mon, 11 Sep 2023 00:22:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] media: i2c: adv7180: Extend match support for OF tables
Date:   Sun, 10 Sep 2023 16:21:59 +0100
Message-Id: <20230910152200.56086-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910152200.56086-1-biju.das.jz@bp.renesas.com>
References: <20230910152200.56086-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has an OF match table, still, it uses an ID lookup table for
retrieving match data. Currently, the driver is working on the
assumption that an I2C device registered via OF will always match a
legacy I2C device ID. The correct approach is to have an OF device ID
table using i2c_get_match_data() if the devices are registered via OF/ID.

Unify the OF/ID table by using struct adv7180_chip_info as match data for
both these tables and replace the ID lookup table for the match data by
i2c_get_match_data().

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/adv7180.c | 60 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 99ba925e8ec8..fc4f29e74e05 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -1395,7 +1395,6 @@ static int init_device(struct adv7180_state *state)
 
 static int adv7180_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device_node *np = client->dev.of_node;
 	struct adv7180_state *state;
 	struct v4l2_subdev *sd;
@@ -1411,7 +1410,7 @@ static int adv7180_probe(struct i2c_client *client)
 
 	state->client = client;
 	state->field = V4L2_FIELD_ALTERNATE;
-	state->chip_info = (struct adv7180_chip_info *)id->driver_data;
+	state->chip_info = i2c_get_match_data(client);
 
 	state->pwdn_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
 						   GPIOD_OUT_HIGH);
@@ -1536,22 +1535,6 @@ static void adv7180_remove(struct i2c_client *client)
 	mutex_destroy(&state->mutex);
 }
 
-static const struct i2c_device_id adv7180_id[] = {
-	{ "adv7180", (kernel_ulong_t)&adv7180_info },
-	{ "adv7180cp", (kernel_ulong_t)&adv7180_info },
-	{ "adv7180st", (kernel_ulong_t)&adv7180_info },
-	{ "adv7182", (kernel_ulong_t)&adv7182_info },
-	{ "adv7280", (kernel_ulong_t)&adv7280_info },
-	{ "adv7280-m", (kernel_ulong_t)&adv7280_m_info },
-	{ "adv7281", (kernel_ulong_t)&adv7281_info },
-	{ "adv7281-m", (kernel_ulong_t)&adv7281_m_info },
-	{ "adv7281-ma", (kernel_ulong_t)&adv7281_ma_info },
-	{ "adv7282", (kernel_ulong_t)&adv7282_info },
-	{ "adv7282-m", (kernel_ulong_t)&adv7282_m_info },
-	{},
-};
-MODULE_DEVICE_TABLE(i2c, adv7180_id);
-
 #ifdef CONFIG_PM_SLEEP
 static int adv7180_suspend(struct device *dev)
 {
@@ -1585,22 +1568,37 @@ static SIMPLE_DEV_PM_OPS(adv7180_pm_ops, adv7180_suspend, adv7180_resume);
 #define ADV7180_PM_OPS NULL
 #endif
 
+static const struct i2c_device_id adv7180_id[] = {
+	{ "adv7180", (kernel_ulong_t)&adv7180_info },
+	{ "adv7180cp", (kernel_ulong_t)&adv7180_info },
+	{ "adv7180st", (kernel_ulong_t)&adv7180_info },
+	{ "adv7182", (kernel_ulong_t)&adv7182_info },
+	{ "adv7280", (kernel_ulong_t)&adv7280_info },
+	{ "adv7280-m", (kernel_ulong_t)&adv7280_m_info },
+	{ "adv7281", (kernel_ulong_t)&adv7281_info },
+	{ "adv7281-m", (kernel_ulong_t)&adv7281_m_info },
+	{ "adv7281-ma", (kernel_ulong_t)&adv7281_ma_info },
+	{ "adv7282", (kernel_ulong_t)&adv7282_info },
+	{ "adv7282-m", (kernel_ulong_t)&adv7282_m_info },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adv7180_id);
+
 #ifdef CONFIG_OF
 static const struct of_device_id adv7180_of_id[] = {
-	{ .compatible = "adi,adv7180", },
-	{ .compatible = "adi,adv7180cp", },
-	{ .compatible = "adi,adv7180st", },
-	{ .compatible = "adi,adv7182", },
-	{ .compatible = "adi,adv7280", },
-	{ .compatible = "adi,adv7280-m", },
-	{ .compatible = "adi,adv7281", },
-	{ .compatible = "adi,adv7281-m", },
-	{ .compatible = "adi,adv7281-ma", },
-	{ .compatible = "adi,adv7282", },
-	{ .compatible = "adi,adv7282-m", },
-	{ },
+	{ .compatible = "adi,adv7180", &adv7180_info },
+	{ .compatible = "adi,adv7180cp", &adv7180_info },
+	{ .compatible = "adi,adv7180st", &adv7180_info },
+	{ .compatible = "adi,adv7182", &adv7182_info },
+	{ .compatible = "adi,adv7280", &adv7280_info },
+	{ .compatible = "adi,adv7280-m", &adv7280_m_info },
+	{ .compatible = "adi,adv7281", &adv7281_info },
+	{ .compatible = "adi,adv7281-m", &adv7281_m_info },
+	{ .compatible = "adi,adv7281-ma", &adv7281_ma_info },
+	{ .compatible = "adi,adv7282", &adv7282_info },
+	{ .compatible = "adi,adv7282-m", &adv7282_m_info },
+	{}
 };
-
 MODULE_DEVICE_TABLE(of, adv7180_of_id);
 #endif
 
-- 
2.25.1

