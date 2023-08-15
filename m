Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3955377D293
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbjHOS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjHOS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:56:56 -0400
X-Greylist: delayed 1563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 11:56:26 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB92127;
        Tue, 15 Aug 2023 11:56:26 -0700 (PDT)
Received: from p200300ccff31d1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff31:d100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qVynp-002fC7-AB; Tue, 15 Aug 2023 20:30:01 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qVyno-000tJC-2x;
        Tue, 15 Aug 2023 20:30:00 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 3/4] Input: zforce_ts: Accept standard touchscreen properties
Date:   Tue, 15 Aug 2023 20:29:47 +0200
Message-Id: <20230815182948.212575-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815182948.212575-1-andreas@kemnade.info>
References: <20230815182948.212575-1-andreas@kemnade.info>
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

Only driver-specific properties were accepted, change it
to use the now-available standard properties.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/touchscreen/zforce_ts.c | 36 +++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 5be5112845e1..f4397497bbe9 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/sysfs.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/platform_data/zforce_ts.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
@@ -106,6 +107,7 @@ struct zforce_point {
 struct zforce_ts {
 	struct i2c_client	*client;
 	struct input_dev	*input;
+	struct touchscreen_properties prop;
 	const struct zforce_ts_platdata *pdata;
 	char			phys[32];
 
@@ -266,7 +268,6 @@ static int zforce_setconfig(struct zforce_ts *ts, char b1)
 static int zforce_start(struct zforce_ts *ts)
 {
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = ts->pdata;
 	int ret;
 
 	dev_dbg(&client->dev, "starting device\n");
@@ -277,7 +278,7 @@ static int zforce_start(struct zforce_ts *ts)
 		return ret;
 	}
 
-	ret = zforce_resolution(ts, pdata->x_max, pdata->y_max);
+	ret = zforce_resolution(ts, ts->prop.max_x, ts->prop.max_y);
 	if (ret) {
 		dev_err(&client->dev, "Unable to set resolution, %d\n", ret);
 		goto error;
@@ -337,7 +338,6 @@ static int zforce_stop(struct zforce_ts *ts)
 static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 {
 	struct i2c_client *client = ts->client;
-	const struct zforce_ts_platdata *pdata = ts->pdata;
 	struct zforce_point point;
 	int count, i, num = 0;
 
@@ -355,8 +355,8 @@ static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 		point.coord_y =
 			payload[9 * i + 4] << 8 | payload[9 * i + 3];
 
-		if (point.coord_x > pdata->x_max ||
-		    point.coord_y > pdata->y_max) {
+		if (point.coord_x > ts->prop.max_x ||
+		    point.coord_y > ts->prop.max_y) {
 			dev_warn(&client->dev, "coordinates (%d,%d) invalid\n",
 				point.coord_x, point.coord_y);
 			point.coord_x = point.coord_y = 0;
@@ -390,10 +390,11 @@ static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 						point.state != STATE_UP);
 
 		if (point.state != STATE_UP) {
-			input_report_abs(ts->input, ABS_MT_POSITION_X,
-					 point.coord_x);
-			input_report_abs(ts->input, ABS_MT_POSITION_Y,
-					 point.coord_y);
+			touchscreen_report_pos(ts->input,
+					       &ts->prop,
+					       point.coord_x,
+					       point.coord_y,
+					       true);
 			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
 					 point.area_major);
 			input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
@@ -719,15 +720,8 @@ static struct zforce_ts_platdata *zforce_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
-		dev_err(dev, "failed to get x-size property\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	if (of_property_read_u32(np, "y-size", &pdata->y_max)) {
-		dev_err(dev, "failed to get y-size property\n");
-		return ERR_PTR(-EINVAL);
-	}
+	of_property_read_u32(np, "x-size", &pdata->x_max);
+	of_property_read_u32(np, "y-size", &pdata->y_max);
 
 	return pdata;
 }
@@ -856,6 +850,12 @@ static int zforce_probe(struct i2c_client *client)
 	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
 			     pdata->y_max, 0, 0);
 
+	touchscreen_parse_properties(input_dev, true, &ts->prop);
+	if (ts->prop.max_x == 0 || ts->prop.max_y == 0) {
+		dev_err(&client->dev, "no size specified\n");
+		return -EINVAL;
+	}
+
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
 			     ZFORCE_MAX_AREA, 0, 0);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
-- 
2.39.2

