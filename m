Return-Path: <linux-kernel+bounces-155961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E68AFBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965331F23203
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262A2E633;
	Tue, 23 Apr 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="a4Lk9guU"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04518B04;
	Tue, 23 Apr 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912077; cv=none; b=UwZ1b+WNurT5gKanqZLQljUs3qEplGG0zZXCRaSPfNqLiqgdbVlbyyv0Y5JDDaBmVh7BC0LIw8EuZDF+zET9DSRZzSLFauu7AOUdj9LhV5DggaaURID8Jfkhbd82VnS4Q9nshbUGoYaZFxxcGba9Fneyd4Uv9Ph7GKU0PqVZH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912077; c=relaxed/simple;
	bh=P1hW2nR8B6iOhbYwXhr0Keb/5gFXWkQwEOZrik5q2G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf/zTjl1yptjtbXOGW0YOTFTeMCYwMnvwJ018tCFHZk3G/6OAJNo543ftM2OJIAOAMCA6yCTgWk+U0kwUeTE2zvtGkG+MRlgSJTzgU7RNEoyx5PXzq7NVq01776NbCo0vwugTNOCx3i7j6P33murF8kHyNg8zVHI8HBvESj2EIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=a4Lk9guU; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id A939547A5F;
	Tue, 23 Apr 2024 22:41:13 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: [PATCH v2 4/6] iio: light: stk3310: use dev_err_probe where possible
Date: Tue, 23 Apr 2024 18:33:07 -0400
Message-ID: <20240423223309.1468198-6-aren@peacevolution.org>
In-Reply-To: <20240423223309.1468198-2-aren@peacevolution.org>
References: <20240423223309.1468198-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ***
X-Spamd-Bar: +++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713912074;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=H5coa02/iaOjA9iqLxo1Oztbgi2cxOUrNasxJP7xbIE=;
	b=a4Lk9guU0NEdyN6/998Mxl90hggHJaHblk9XS8qF2T7129mcpApydDwPe+0VXsjTlWJt96
	Boedlc8cpdlMESLG7EeHzoycM2whNz/nKnNj9HlhQtaU7gomXRkM6GTCPvWVP8X6ZvXMXo
	uuxj5Up77P48MW4o7v7RTlNWHasx9uc=

Using dev_err_probe instead of dev_err and return makes the errors
easier to understand by including the error name, and saves a little
code.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Added in v2

 drivers/iio/light/stk3310.c | 44 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index ee1ac95dbc0e..c56c6298d292 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -60,10 +60,10 @@
 		data->reg_##name =					    \
 			devm_regmap_field_alloc(&client->dev, regmap,	    \
 				stk3310_reg_field_##name);		    \
-		if (IS_ERR(data->reg_##name)) {				    \
-			dev_err(&client->dev, "reg field alloc failed.\n"); \
-			return PTR_ERR(data->reg_##name);		    \
-		}							    \
+		if (IS_ERR(data->reg_##name))				    \
+			return dev_err_probe(&client->dev,		    \
+				PTR_ERR(data->reg_##name),		    \
+				"reg field alloc failed.\n");		    \
 	} while (0)
 
 static const struct reg_field stk3310_reg_field_state =
@@ -480,22 +480,20 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	if (chipid != STK3310_CHIP_ID_VAL &&
 	    chipid != STK3311_CHIP_ID_VAL &&
 	    chipid != STK3311X_CHIP_ID_VAL &&
-	    chipid != STK3335_CHIP_ID_VAL) {
-		dev_err(&client->dev, "invalid chip id: 0x%x\n", chipid);
-		return -ENODEV;
-	}
+	    chipid != STK3335_CHIP_ID_VAL)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "invalid chip id: 0x%x\n", chipid);
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to enable sensor");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "failed to enable sensor\n");
 
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
-		dev_err(&client->dev, "failed to enable interrupts!\n");
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable interrupts!\n");
 
 	return ret;
 }
@@ -530,10 +528,10 @@ static int stk3310_regmap_init(struct stk3310_data *data)
 
 	client = data->client;
 	regmap = devm_regmap_init_i2c(client, &stk3310_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "regmap initialization failed.\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "regmap initialization failed.\n");
+
 	data->regmap = regmap;
 
 	STK3310_REGFIELD(state);
@@ -597,10 +595,8 @@ static int stk3310_probe(struct i2c_client *client)
 	struct stk3310_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(&client->dev, -ENOMEM, "iio allocation failed!\n");
 
 	data = iio_priv(indio_dev);
 	data->client = client;
@@ -655,15 +651,15 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						STK3310_EVENT, indio_dev);
 		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
+			dev_err_probe(&client->dev, ret, "request irq %d failed\n",
+				      client->irq);
 			goto err_standby;
 		}
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
+		dev_err_probe(&client->dev, ret, "device_register failed\n");
 		goto err_standby;
 	}
 
-- 
2.44.0


