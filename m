Return-Path: <linux-kernel+bounces-155301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A8C8AE88B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC741F25207
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EAD139CED;
	Tue, 23 Apr 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNanTu9i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F081350E3;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=gjqEfhzPfhcsIoswOTzdvrnQekAkgiSnkH+EbE+yNyUyw4JctdqNs/nZyn8d0xgmKvYgFLLiab2K04I9xyNLrsS+OZLmvMGdWXoxbY4HyUoVMbxjStBTxtyVLqFU4ytt8EHEtQ4E86h2bi+b0ILTBxA5ESBpbKBsNqeS3JC5TcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=pcEsfnawp+PoMGDaKV0gMQ+xLb4cPIiASt03YhZ7TRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw2mriE531PAEuRXF2ZuWwyz5nk/qmzX5K+d5hQxX92+iFjDJR73pboXAT9MZ467kx0fk1NOqk1lUT9pN2ObRNjeBMPiAPADyxHTMfweu+luiBoDNnmxpjt6vrwLdGgbvC438RQ1ApSGdpfftuQAphlUGsLIkjEt5VNJZgDPMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNanTu9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F93C32783;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=pcEsfnawp+PoMGDaKV0gMQ+xLb4cPIiASt03YhZ7TRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNanTu9ihAD9kpVS7rVPwGmda32PPpxbYwPDCvrSYnGBYqlKnJ+/p8sbuFE2cgfT2
	 JsWHebg1pmYi5GxnnXbyiV1EIzoTjvg7hDX/PTqWncjC/gUgfjkLS0RWBdpnt7E5v6
	 IdXsb4XJ6Xg6vdAvayk786j9NUuX3VTJ/e5gvzp1yMIdALY16oTOZ3Fh/I5urQO1lw
	 AVDWl/37y4dvraAJJrJGxrWcqbdx3ALage51cyO7IdzXDmj7gP3g52j8jb8/WKMNu6
	 jI+bCy4s0p9yRNjFi7OWQq5+bQaCHmFnf78Q3p54LkKT8b63VHB39EQXwQc0nAOmRd
	 zjn8tSfWx8v1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Km-1SYI;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 4/6] HID: i2c-hid: elan: fix reset suspend current leakage
Date: Tue, 23 Apr 2024 15:46:09 +0200
Message-ID: <20240423134611.31979-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Elan eKTH5015M touch controller found on the Lenovo ThinkPad X13s
shares the VCC33 supply with other peripherals that may remain powered
during suspend (e.g. when enabled as wakeup sources).

The reset line is also wired so that it can be left deasserted when the
supply is off.

This is important as it avoids holding the controller in reset for
extended periods of time when it remains powered, which can lead to
increased power consumption, and also avoids leaking current through the
X13s reset circuitry during suspend (and after driver unbind).

Use the new 'no-reset-on-power-off' devicetree property to determine
when reset needs to be asserted on power down.

Notably this also avoids wasting power on machine variants without a
touchscreen for which the driver would otherwise exit probe with reset
asserted.

Fixes: bd3cba00dcc6 ("HID: i2c-hid: elan: Add support for Elan eKTH6915 i2c-hid touchscreens")
Cc: stable@vger.kernel.org	# 6.0
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 37 ++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 5b91fb106cfc..8a905027d5e9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -31,6 +31,7 @@ struct i2c_hid_of_elan {
 	struct regulator *vcc33;
 	struct regulator *vccio;
 	struct gpio_desc *reset_gpio;
+	bool no_reset_on_power_off;
 	const struct elan_i2c_hid_chip_data *chip_data;
 };
 
@@ -40,17 +41,17 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		container_of(ops, struct i2c_hid_of_elan, ops);
 	int ret;
 
+	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+
 	if (ihid_elan->vcc33) {
 		ret = regulator_enable(ihid_elan->vcc33);
 		if (ret)
-			return ret;
+			goto err_deassert_reset;
 	}
 
 	ret = regulator_enable(ihid_elan->vccio);
-	if (ret) {
-		regulator_disable(ihid_elan->vcc33);
-		return ret;
-	}
+	if (ret)
+		goto err_disable_vcc33;
 
 	if (ihid_elan->chip_data->post_power_delay_ms)
 		msleep(ihid_elan->chip_data->post_power_delay_ms);
@@ -60,6 +61,15 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *ops)
 		msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms);
 
 	return 0;
+
+err_disable_vcc33:
+	if (ihid_elan->vcc33)
+		regulator_disable(ihid_elan->vcc33);
+err_deassert_reset:
+	if (ihid_elan->no_reset_on_power_off)
+		gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);
+
+	return ret;
 }
 
 static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
@@ -67,7 +77,14 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *ops)
 	struct i2c_hid_of_elan *ihid_elan =
 		container_of(ops, struct i2c_hid_of_elan, ops);
 
-	gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+	/*
+	 * Do not assert reset when the hardware allows for it to remain
+	 * deasserted regardless of the state of the (shared) power supply to
+	 * avoid wasting power when the supply is left on.
+	 */
+	if (!ihid_elan->no_reset_on_power_off)
+		gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
+
 	if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
 		msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms);
 
@@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
 	ihid_elan->ops.power_up = elan_i2c_hid_power_up;
 	ihid_elan->ops.power_down = elan_i2c_hid_power_down;
 
-	/* Start out with reset asserted */
-	ihid_elan->reset_gpio =
-		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	ihid_elan->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
+							GPIOD_ASIS);
 	if (IS_ERR(ihid_elan->reset_gpio))
 		return PTR_ERR(ihid_elan->reset_gpio);
 
+	ihid_elan->no_reset_on_power_off = of_property_read_bool(client->dev.of_node,
+						"no-reset-on-power-off");
+
 	ihid_elan->vccio = devm_regulator_get(&client->dev, "vccio");
 	if (IS_ERR(ihid_elan->vccio))
 		return PTR_ERR(ihid_elan->vccio);
-- 
2.43.2


