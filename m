Return-Path: <linux-kernel+bounces-144316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6168A4488
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807A41F214E3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7E8136647;
	Sun, 14 Apr 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="apJvp2ux"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24003135A6C;
	Sun, 14 Apr 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713117475; cv=none; b=n/BWkzI+YnI59nnmkQpC8VhPip1OnZJ37KKynyX9we3lLP8207IyHwSRYbDbQc/fmz0DLjC9Pa7M7IMuayK/PmLMEgwsWhzqaaT2DMc9LcQeR7WqgCUwvaE0tWezPxRCqQLYbnJvnHmhhFR3eiXDaowtbijrgnaCt7fH1QNwHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713117475; c=relaxed/simple;
	bh=zIGUlsMmzRHbKuN0yC5dPYIwHXfnj1BUrSe5Hnhm/Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPr72lv0YXZXG91mY7YDmeRUWc4puZ77CUsMM6GPj7lIWFtml8iYDZRlPCKLpyd42HSGTkSjKX5Nrur4HAXWNi9Vo/D+O6hoQDanGNZvJGtGmrqNvyOVRI652rferM1m4oZnpdmmhcPsYkDSEP5sTo6HebyKcQxVrXZCsY+hgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=apJvp2ux; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D8FB347965;
	Sun, 14 Apr 2024 17:57:51 +0000 (UTC)
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
Subject: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power it off during suspend
Date: Sun, 14 Apr 2024 13:57:14 -0400
Message-ID: <20240414175716.958831-2-aren@peacevolution.org>
In-Reply-To: <20240414175716.958831-1-aren@peacevolution.org>
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
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
	s=dkim; t=1713117473;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=ZKSgSZr/52jxxhOzrlt61t9DbIznbduvvmE0nk+D74c=;
	b=apJvp2uxLX++fTOkwbVsX7C+kB+jPyIlrIE4AdtpWE3L5VYuZbvakkgCW2Z5U65LZ42tyD
	XrGjA6nmS3WSOdjT3wxoIvvicMTgUnI0NDNxrxT5csega06OKL83o4eFE3aTrb8/+THORg
	81m+ubmpuFGWceJWeE5c90HOWbL0+KE=

From: Ondrej Jirman <megi@xff.cz>

VDD power input can be used to completely power off the chip during
system suspend. Do so if available.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
 drivers/iio/light/stk3310.c | 56 +++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 7b71ad71d78d..bfa090538df7 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -16,6 +16,7 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/regulator/consumer.h>
 
 #define STK3310_REG_STATE			0x00
 #define STK3310_REG_PSCTRL			0x01
@@ -117,6 +118,7 @@ struct stk3310_data {
 	struct regmap_field *reg_int_ps;
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
+	struct regulator *vdd_reg;
 };
 
 static const struct iio_event_spec stk3310_events[] = {
@@ -607,6 +609,16 @@ static int stk3310_probe(struct i2c_client *client)
 
 	mutex_init(&data->lock);
 
+	data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		ret = PTR_ERR(data->vdd_reg);
+		if (ret == -ENODEV)
+			data->vdd_reg = NULL;
+		else
+			return dev_err_probe(&client->dev, ret,
+					     "get regulator vdd failed\n");
+	}
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;
@@ -617,9 +629,18 @@ static int stk3310_probe(struct i2c_client *client)
 	indio_dev->channels = stk3310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
 
+	if (data->vdd_reg) {
+		ret = regulator_enable(data->vdd_reg);
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "regulator vdd enable failed\n");
+
+		usleep_range(1000, 2000);
+	}
+
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
-		return ret;
+		goto err_vdd_disable;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
@@ -645,32 +666,61 @@ static int stk3310_probe(struct i2c_client *client)
 
 err_standby:
 	stk3310_set_state(data, STK3310_STATE_STANDBY);
+err_vdd_disable:
+	if (data->vdd_reg)
+		regulator_disable(data->vdd_reg);
 	return ret;
 }
 
 static void stk3310_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct stk3310_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
+	if (data->vdd_reg)
+		regulator_disable(data->vdd_reg);
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
+	if (data->vdd_reg) {
+		regcache_mark_dirty(data->regmap);
+		regulator_disable(data->vdd_reg);
+	}
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
+	if (data->vdd_reg) {
+		ret = regulator_enable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "Failed to re-enable regulator vdd\n");
+			return ret;
+		}
+
+		usleep_range(1000, 2000);
+		regcache_sync(data->regmap);
+	}
+
 	if (data->ps_enabled)
 		state |= STK3310_STATE_EN_PS;
 	if (data->als_enabled)
-- 
2.44.0


