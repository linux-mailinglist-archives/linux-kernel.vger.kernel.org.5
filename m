Return-Path: <linux-kernel+bounces-155966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2C8AFC14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE8CB25640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148EC5490B;
	Tue, 23 Apr 2024 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="l+nUddnX"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48818EA8;
	Tue, 23 Apr 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912080; cv=none; b=C7oIvdDgG5IBFXalcbHyO9rkYT0JfH1Wa9CxfxIsn7Mi6GCPFr2OlI34lSAXMduob4MjnUeP8T+XuDZSgEl9nqrFna5BtUBfElcKg+vcRHbd/aEllR0sIt/LU4m413IgFEsT4v1tKoszUVHnz7KhhEnsU9ieaObjp/r22ix9WVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912080; c=relaxed/simple;
	bh=9WFlEslTo17+AMX3ugsxbIxUCsN22DM+tnAYsHJ1wgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOMo5JyhR/ZbbwtT53WLDQmUo8YmADB6zBl7lJLjlIEcI6+RAq1XcLnZcR8zZv9Y+xfveUoTe1vo4/uBDqXUeXzrvjLa8/fM5tLgACbwb/zd+pu6gidN0ghHzbKl4RjudXqqG9yVSLlejpFTpB1F6MGlYuZbbzkko8vqH4WCQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=l+nUddnX; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 0E5CB47A5A;
	Tue, 23 Apr 2024 22:41:11 +0000 (UTC)
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
Subject: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and power it off during suspend
Date: Tue, 23 Apr 2024 18:33:05 -0400
Message-ID: <20240423223309.1468198-4-aren@peacevolution.org>
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
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713912072;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=Pocgw671NmVP3upSEXxvVD2OibWy7kumLvOzth5JeTg=;
	b=l+nUddnXDeq2ogq+5wgM2loG+Zhw9lbTkOdpiEms8CGYX47TIDLx5TnywJYBYr8tJVrN9f
	8Pem/UxHV78BEhybQuH9K5YyOFtNDmESnC3g4YfWLylccPCttb6Dl3OhrMQZXMEXaW/0bS
	ZNCp+zXZmDGGd5WHjWsxyyeXXmk0lQE=

From: Ondrej Jirman <megi@xff.cz>

VDD power input can be used to completely power off the chip during
system suspend. Do so if available.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v2:
     - always enable / disable regulators and rely on a dummy regulator if
       one isn't specified
     - replace usleep_range with fsleep
     - reorder includes so iio headers are last
     - add missing error handling to resume

 drivers/iio/light/stk3310.c | 49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7b71ad71d78d..a0547eeca3e3 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -117,6 +119,7 @@ struct stk3310_data {
 	struct regmap_field *reg_int_ps;
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
+	struct regulator *vdd_reg;
 };
 
 static const struct iio_event_spec stk3310_events[] = {
@@ -607,6 +610,10 @@ static int stk3310_probe(struct i2c_client *client)
 
 	mutex_init(&data->lock);
 
+	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg))
+		return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;
@@ -617,9 +624,17 @@ static int stk3310_probe(struct i2c_client *client)
 	indio_dev->channels = stk3310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
 
+	ret = regulator_enable(data->vdd_reg);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "regulator vdd enable failed\n");
+
+	/* we need a short delay to allow the chip time to power on */
+	fsleep(1000);
+
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
-		return ret;
+		goto err_vdd_disable;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -645,32 +660,60 @@ static int stk3310_probe(struct i2c_client *client)
 
 err_standby:
 	stk3310_set_state(data, STK3310_STATE_STANDBY);
+err_vdd_disable:
+	regulator_disable(data->vdd_reg);
 	return ret;
 }
 
 static void stk3310_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct stk3310_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
+	regulator_disable(data->vdd_reg);
 }
 
 static int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
-	return stk3310_set_state(data, STK3310_STATE_STANDBY);
+	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(data->regmap);
+	regulator_disable(data->vdd_reg);
+
+	return 0;
 }
 
 static int stk3310_resume(struct device *dev)
 {
-	u8 state = 0;
 	struct stk3310_data *data;
+	u8 state = 0;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+
+	ret = regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable regulator vdd\n");
+		return ret;
+	}
+
+	fsleep(1000);
+
+	ret = regcache_sync(data->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to restore registers: %d\n", ret);
+		return ret;
+	}
+
 	if (data->ps_enabled)
 		state |= STK3310_STATE_EN_PS;
 	if (data->als_enabled)
-- 
2.44.0


