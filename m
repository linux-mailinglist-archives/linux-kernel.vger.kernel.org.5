Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F57799EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346716AbjIJPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIJPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 11:00:48 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A36C1B5;
        Sun, 10 Sep 2023 08:00:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,241,1688396400"; 
   d="scan'208";a="175581412"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Sep 2023 00:00:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.9])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 25C7740065DB;
        Mon, 11 Sep 2023 00:00:39 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] media: i2c: ov7670: Extend match support for OF tables
Date:   Sun, 10 Sep 2023 16:00:32 +0100
Message-Id: <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
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

Unify the OF/ID table by using struct ov7670_devtype as match data for
both these tables and replace the ID lookup table for the match data by
i2c_get_match_data().

Split the array ov7670_devdata[] as individual variables, and
make lines shorter by referring to e.g. &ov7670_devdata instead of
&ov7670_devdata[MODEL_OV7670].

Drop enum ov7670_model as there is no user.

While at it, remove the trailing comma in the terminator entry for the OF
table making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov7670.c | 47 ++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 2f55491ef571..644457e6993d 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -186,11 +186,6 @@ MODULE_PARM_DESC(debug, "Debug level (0-1)");
 #define REG_HAECC7	0xaa	/* Hist AEC/AGC control 7 */
 #define REG_BD60MAX	0xab	/* 60hz banding step limit */
 
-enum ov7670_model {
-	MODEL_OV7670 = 0,
-	MODEL_OV7675,
-};
-
 struct ov7670_win_size {
 	int	width;
 	int	height;
@@ -1774,21 +1769,6 @@ static const struct v4l2_subdev_internal_ops ov7670_subdev_internal_ops = {
 
 /* ----------------------------------------------------------------------- */
 
-static const struct ov7670_devtype ov7670_devdata[] = {
-	[MODEL_OV7670] = {
-		.win_sizes = ov7670_win_sizes,
-		.n_win_sizes = ARRAY_SIZE(ov7670_win_sizes),
-		.set_framerate = ov7670_set_framerate_legacy,
-		.get_framerate = ov7670_get_framerate_legacy,
-	},
-	[MODEL_OV7675] = {
-		.win_sizes = ov7675_win_sizes,
-		.n_win_sizes = ARRAY_SIZE(ov7675_win_sizes),
-		.set_framerate = ov7675_set_framerate,
-		.get_framerate = ov7675_get_framerate,
-	},
-};
-
 static int ov7670_init_gpio(struct i2c_client *client, struct ov7670_info *info)
 {
 	info->pwdn_gpio = devm_gpiod_get_optional(&client->dev, "powerdown",
@@ -1849,7 +1829,6 @@ static int ov7670_parse_dt(struct device *dev,
 
 static int ov7670_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct v4l2_fract tpf;
 	struct v4l2_subdev *sd;
 	struct ov7670_info *info;
@@ -1923,7 +1902,7 @@ static int ov7670_probe(struct i2c_client *client)
 	v4l_info(client, "chip found @ 0x%02x (%s)\n",
 			client->addr << 1, client->adapter->name);
 
-	info->devtype = &ov7670_devdata[id->driver_data];
+	info->devtype = i2c_get_match_data(client);
 	info->fmt = &ov7670_formats[0];
 	info->wsize = &info->devtype->win_sizes[0];
 
@@ -2013,17 +1992,31 @@ static void ov7670_remove(struct i2c_client *client)
 	media_entity_cleanup(&info->sd.entity);
 }
 
+static const struct ov7670_devtype ov7670_devdata = {
+	.win_sizes = ov7670_win_sizes,
+	.n_win_sizes = ARRAY_SIZE(ov7670_win_sizes),
+	.set_framerate = ov7670_set_framerate_legacy,
+	.get_framerate = ov7670_get_framerate_legacy,
+};
+
+static const struct ov7670_devtype ov7675_devdata = {
+	.win_sizes = ov7675_win_sizes,
+	.n_win_sizes = ARRAY_SIZE(ov7675_win_sizes),
+	.set_framerate = ov7675_set_framerate,
+	.get_framerate = ov7675_get_framerate,
+};
+
 static const struct i2c_device_id ov7670_id[] = {
-	{ "ov7670", MODEL_OV7670 },
-	{ "ov7675", MODEL_OV7675 },
-	{ }
+	{ "ov7670", (kernel_ulong_t)&ov7670_devdata },
+	{ "ov7675", (kernel_ulong_t)&ov7675_devdata },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, ov7670_id);
 
 #if IS_ENABLED(CONFIG_OF)
 static const struct of_device_id ov7670_of_match[] = {
-	{ .compatible = "ovti,ov7670", },
-	{ /* sentinel */ },
+	{ .compatible = "ovti,ov7670", &ov7670_devdata },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ov7670_of_match);
 #endif
-- 
2.25.1

