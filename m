Return-Path: <linux-kernel+bounces-10597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4060B81D6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 23:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DE51C2110A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB9200BF;
	Sat, 23 Dec 2023 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="rq/Wl09B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244A179A9;
	Sat, 23 Dec 2023 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NpY3EimOAO7fdKupobvAOCqbFhsZ6eizQExlx9KlQYE=; b=rq/Wl09BjslAj82DLo/FVvQuft
	mRUWIegLkCGz44P8oMlovQ/F3f3IEcn75Qy6NJt+AIRbt5Lcr3tD0ZLRymlgY6xCYFdb3jOoNS6Tw
	DjgaXKWW4E9Ip4rntf8lFStcPkil+Svsw47G1Xqn0YIXWGCcv8MR2e5xIObvpYo/2/LFquZYOSNOe
	asMNVHj7M5OBVUGI63K0nwgufPn92MW+j+mBUxZkmA5FIr4ert/qF/6Qp+HFDirM/gwK6jNYrFOYD
	xLcUtfhYitO795tnJH92CPSWt2cMqvreTsgCKsw7cE26AokolCZ8kv5clNnq0PTPIvFCKb1IZD5Ok
	kTmSb1SQ==;
Received: from p200301077700c3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7700:c300:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEK-007f7c-OD; Sat, 23 Dec 2023 23:12:24 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rHAEK-003FaH-0i;
	Sat, 23 Dec 2023 23:12:24 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	rydberg@bitmath.org,
	andreas@kemnade.info,
	linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com,
	u.kleine-koenig@pengutronix.de,
	heiko@sntech.de,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/4] Input: zforce_ts: Accept standard touchscreen properties
Date: Sat, 23 Dec 2023 23:12:12 +0100
Message-Id: <20231223221213.774868-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223221213.774868-1-andreas@kemnade.info>
References: <20231223221213.774868-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only driver-specific properties were accepted, change it
to use the now-available standard properties.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/input/touchscreen/zforce_ts.c | 36 +++++++++++++--------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 5be5112845e1e..f4397497bbe94 100644
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


