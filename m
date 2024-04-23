Return-Path: <linux-kernel+bounces-155967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C558AFC13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB9A28291B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA5354909;
	Tue, 23 Apr 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="HSb11MRz"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC843E479;
	Tue, 23 Apr 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912081; cv=none; b=aLxc5CQUSMPhP4ZZdy9GSTFkYItj0i7mHDikoVkPvLnICcVKb3QyOU48VvGPdzXY8ruPlMuiS4MJEzae77fTGbdM3JvpdJCfRYAEZlXrUev51G0xi1HgsEX/6gm7GxpkrXFG2eG9N006KG6huL0fqyTwl+hZ5VaGoRAxG+THy2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912081; c=relaxed/simple;
	bh=W0pdx8BuK+xLmOs54GoilrUFme6kM+0J0JTKC9zdz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh3gvFe85MpeK84ow9nBPrFrHEsHQZRIQDB9Efm/NQ7AAz4opzxQX65Bg1zogbYMrj/CLR3j7WJ9/BW4GGue6bAHmyG+BIyKzs39ezhqEs3T3ghlKJKYfl5t5wqUDA3LqlA3A2uHkZIe9eUYHMvfU8fCADRYIRajVhZSv5AkThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=HSb11MRz; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 5C34F47A5C;
	Tue, 23 Apr 2024 22:41:12 +0000 (UTC)
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
Subject: [PATCH v2 3/6] iio: light: stk3310: Manage LED power supply
Date: Tue, 23 Apr 2024 18:33:06 -0400
Message-ID: <20240423223309.1468198-5-aren@peacevolution.org>
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
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713912073;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=HCCF9rxoV0qyxUrOixYZsFhioeAo5bm11hFlJpbzygM=;
	b=HSb11MRzuz/XBflQACsKZGFgXiRga8WQaXWlqiASFFQXdY5wHBP78NmzQyhYtY0p//6zPR
	iZ+ilr2ls1WGPFzTHmMP6dRe520CPj53L+dXo42q1afcEK6c3KxXTeyc1h2qN6lXuN8a+O
	BuHcQNYCWP6SYgM1y/h3XSmUimNUyJg=

The stk3310 and stk3310 chips have an input for power to the infrared
LED. Add support for managing it's state.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
 drivers/iio/light/stk3310.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a0547eeca3e3..ee1ac95dbc0e 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -120,6 +120,7 @@ struct stk3310_data {
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
 	struct regulator *vdd_reg;
+	struct regulator *led_reg;
 };
 
 static const struct iio_event_spec stk3310_events[] = {
@@ -614,6 +615,10 @@ static int stk3310_probe(struct i2c_client *client)
 	if (IS_ERR(data->vdd_reg))
 		return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");
 
+	data->led_reg = devm_regulator_get(&client->dev, "leda");
+	if (IS_ERR(data->led_reg))
+		return dev_err_probe(&client->dev, ret, "get regulator led failed\n");
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;
@@ -629,12 +634,18 @@ static int stk3310_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "regulator vdd enable failed\n");
 
+	ret = regulator_enable(data->led_reg);
+	if (ret) {
+		dev_err_probe(&client->dev, ret, "regulator led enable failed\n");
+		goto err_vdd_disable;
+	}
+
 	/* we need a short delay to allow the chip time to power on */
 	fsleep(1000);
 
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
-		goto err_vdd_disable;
+		goto err_led_disable;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -660,6 +671,8 @@ static int stk3310_probe(struct i2c_client *client)
 
 err_standby:
 	stk3310_set_state(data, STK3310_STATE_STANDBY);
+err_led_disable:
+	regulator_disable(data->led_reg);
 err_vdd_disable:
 	regulator_disable(data->vdd_reg);
 	return ret;
@@ -672,6 +685,7 @@ static void stk3310_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
+	regulator_disable(data->led_reg);
 	regulator_disable(data->vdd_reg);
 }
 
@@ -687,6 +701,7 @@ static int stk3310_suspend(struct device *dev)
 		return ret;
 
 	regcache_mark_dirty(data->regmap);
+	regulator_disable(data->led_reg);
 	regulator_disable(data->vdd_reg);
 
 	return 0;
@@ -706,6 +721,12 @@ static int stk3310_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = regulator_enable(data->led_reg);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable regulator led\n");
+		return ret;
+	}
+
 	fsleep(1000);
 
 	ret = regcache_sync(data->regmap);
-- 
2.44.0


