Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89F810987
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjLMFd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjLMFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:33:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41476D5;
        Tue, 12 Dec 2023 21:34:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b7418bea02so150576339f.0;
        Tue, 12 Dec 2023 21:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702445641; x=1703050441; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/JrKjOoGP7gnAW/2hayVFApp9MtzrX02np9XSoQbBs=;
        b=nqxEpvmbdAaM7gL4kpfKkOUHlndgYXx4lwB3BiFV0QEnuf6rD800HSN+spbX4O8Dko
         qItMtd3+ySu1292uNg0zIFXuLCjwse69XcNGSkmOEIDtNQX0YGOep0zhMS2Ct++PiONb
         pu9mtBtuma2v2BvkpiSo+vuBh2b1VcufFgzTss1++eWUikjaLTEv/1MyM4pv/O0kd+Bh
         yv+7J14VmV8d9POG/1ylL8DpIBNvyJzOrlB106V3Hwcrl1/H9YYOVsFqB6VYE0vyo31R
         AS1emi/fk26BwaXmjtbLCC5ocbrigt6bledUV2kLGrRiMsOvfZsvmHWNmV+BqVyvVMHY
         fTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702445641; x=1703050441;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/JrKjOoGP7gnAW/2hayVFApp9MtzrX02np9XSoQbBs=;
        b=F+We7PnLwOgdKm+gbhb/RyAXbOWHsc/0jhp3Oo1X7e94yL49x0txWc3OAsdxgIKHio
         OL/Ru2NDYYOIOmoRaf4d5hMpynAIp0Mt/8do+3/NdvEcIGfz7i7qH6dJ3YeHBaMyrIgJ
         SbuGfodIXSLkht2WczRo6db14ZxsSinIzD8Osft99+wwhuTFF9G/CVkwqAX5UdrgxVaD
         zugC8h/RgVEf/vTR4zv1kF26uR5xcmwqpQICeyy86I9soCOpCPP7joeyhfnqtMkf9zZg
         7YqzeyOb+B+q0jUDeLib4WUsMVrfPYz7SdNoNkOZO6X6OiNNuxMUFwSIoagJDBgEnVfj
         OEJw==
X-Gm-Message-State: AOJu0Yz8IwJNOvLaUheWqbIRd2xsryflOe/gylWCPtozx05uMEJXgqTV
        Ibo17Yfz/Mypt5TAXodXjnXbsUMIm1pxdw==
X-Google-Smtp-Source: AGHT+IEtxE/Z4iLLZWF+/OhcY31GjYgq9y16doBw1qYzS4Jx0WCAy5u3ieDQHXcjk1RfpXpiVsq9OQ==
X-Received: by 2002:a92:c565:0:b0:35d:69c8:8d61 with SMTP id b5-20020a92c565000000b0035d69c88d61mr11925470ilj.14.1702445641069;
        Tue, 12 Dec 2023 21:34:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:96c1:256f:67e0:c0db])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902bd8500b001c9d011581dsm9534384pls.164.2023.12.12.21.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 21:34:00 -0800 (PST)
Date:   Tue, 12 Dec 2023 21:33:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Jiri Valek - 2N <jiriv@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cap11xx - stop using chip ID when configuring it
Message-ID: <ZXlCRsnOu_L8xeTC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct cap11xx_hw_model is supposed to describe the chip capabilities,
however later code changes introduced checks against chip ID.

Introduce new capabilities in cap11xx_hw_model and use them when applying
chip configuration, and remove the enum for chip ID. While at it, rename
no_gain to has_gain to match the rest of the new capabilities.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cap11xx.c | 125 +++++++++++++++++--------------
 1 file changed, 70 insertions(+), 55 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index ebcbc00d2059..c85bb0ca0e39 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -86,7 +86,6 @@ struct cap11xx_priv {
 	struct device *dev;
 	struct input_dev *idev;
 	const struct cap11xx_hw_model *model;
-	u8 id;
 
 	struct cap11xx_led *leds;
 	int num_leds;
@@ -104,27 +103,10 @@ struct cap11xx_hw_model {
 	u8 product_id;
 	unsigned int num_channels;
 	unsigned int num_leds;
-	bool no_gain;
-};
-
-enum {
-	CAP1106,
-	CAP1126,
-	CAP1188,
-	CAP1203,
-	CAP1206,
-	CAP1293,
-	CAP1298
-};
-
-static const struct cap11xx_hw_model cap11xx_devices[] = {
-	[CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0, .no_gain = false },
-	[CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2, .no_gain = false },
-	[CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8, .no_gain = false },
-	[CAP1203] = { .product_id = 0x6d, .num_channels = 3, .num_leds = 0, .no_gain = true },
-	[CAP1206] = { .product_id = 0x67, .num_channels = 6, .num_leds = 0, .no_gain = true },
-	[CAP1293] = { .product_id = 0x6f, .num_channels = 3, .num_leds = 0, .no_gain = false },
-	[CAP1298] = { .product_id = 0x71, .num_channels = 8, .num_leds = 0, .no_gain = false },
+	bool has_gain;
+	bool has_irq_config;
+	bool has_sensitivity_control;
+	bool has_signal_guard;
 };
 
 static const struct reg_default cap11xx_reg_defaults[] = {
@@ -227,7 +209,7 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	}
 
 	if (!of_property_read_u32(node, "microchip,sensor-gain", &u32_val)) {
-		if (priv->model->no_gain) {
+		if (!priv->model->has_gain) {
 			dev_warn(dev,
 				 "This model doesn't support 'sensor-gain'\n");
 		} else if (is_power_of_2(u32_val) && u32_val <= 8) {
@@ -246,9 +228,7 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	}
 
 	if (of_property_read_bool(node, "microchip,irq-active-high")) {
-		if (priv->id == CAP1106 ||
-		    priv->id == CAP1126 ||
-		    priv->id == CAP1188) {
+		if (priv->model->has_irq_config) {
 			error = regmap_update_bits(priv->regmap,
 						   CAP11XX_REG_CONFIG2,
 						   CAP11XX_REG_CONFIG2_ALT_POL,
@@ -299,7 +279,7 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	if (!of_property_read_u32_array(node, "microchip,calib-sensitivity",
 					priv->calib_sensitivities,
 					priv->model->num_channels)) {
-		if (priv->id == CAP1293 || priv->id == CAP1298) {
+		if (priv->model->has_sensitivity_control) {
 			for (i = 0; i < priv->model->num_channels; i++) {
 				if (!is_power_of_2(priv->calib_sensitivities[i]) ||
 				    priv->calib_sensitivities[i] > 4) {
@@ -314,7 +294,7 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 			if (error)
 				return error;
 
-			if (priv->id == CAP1298) {
+			if (priv->model->num_channels > 4) {
 				error = cap11xx_write_calib_sens_config_2(priv);
 				if (error)
 					return error;
@@ -336,7 +316,7 @@ static int cap11xx_init_keys(struct cap11xx_priv *priv)
 	}
 
 	if (priv->signal_guard_inputs_mask) {
-		if (priv->id == CAP1293 || priv->id == CAP1298) {
+		if (priv->model->has_signal_guard) {
 			error = regmap_write(priv->regmap,
 					     CAP11XX_REG_SIGNAL_GUARD_ENABLE,
 					     priv->signal_guard_inputs_mask);
@@ -511,20 +491,16 @@ static int cap11xx_init_leds(struct device *dev,
 
 static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c_client);
+	const struct i2c_device_id *id;
+	const struct cap11xx_hw_model *cap;
 	struct device *dev = &i2c_client->dev;
 	struct cap11xx_priv *priv;
-	const struct cap11xx_hw_model *cap;
 	int i, error;
 	unsigned int val, rev;
 
-	if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
-		dev_err(dev, "Invalid device ID %lu\n", id->driver_data);
-		return -EINVAL;
-	}
-
-	cap = &cap11xx_devices[id->driver_data];
-	if (!cap || !cap->num_channels) {
+	id = i2c_client_get_device_id(i2c_client);
+	cap = i2c_get_match_data(i2c_client);
+	if (!id || !cap || !cap->num_channels) {
 		dev_err(dev, "Invalid device configuration\n");
 		return -EINVAL;
 	}
@@ -569,7 +545,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 			 id->name, rev);
 
 	priv->model = cap;
-	priv->id = id->driver_data;
 
 	dev_info(dev, "CAP11XX device detected, model %s, revision 0x%02x\n",
 		 id->name, rev);
@@ -630,27 +605,67 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
 	return 0;
 }
 
+static const struct cap11xx_hw_model cap1106_model = {
+	.product_id = 0x55, .num_channels = 6, .num_leds = 0,
+	.has_gain = true,
+	.has_irq_config = true,
+};
+
+static const struct cap11xx_hw_model cap1126_model = {
+	.product_id = 0x53, .num_channels = 6, .num_leds = 2,
+	.has_gain = true,
+	.has_irq_config = true,
+};
+
+static const struct cap11xx_hw_model cap1188_model = {
+	.product_id = 0x50, .num_channels = 8, .num_leds = 8,
+	.has_gain = true,
+	.has_irq_config = true,
+};
+
+static const struct cap11xx_hw_model cap1203_model = {
+	.product_id = 0x6d, .num_channels = 3, .num_leds = 0,
+};
+
+static const struct cap11xx_hw_model cap1206_model = {
+	.product_id = 0x67, .num_channels = 6, .num_leds = 0,
+};
+
+static const struct cap11xx_hw_model cap1293_model = {
+	.product_id = 0x6f, .num_channels = 3, .num_leds = 0,
+	.has_gain = true,
+	.has_sensitivity_control = true,
+	.has_signal_guard = true,
+};
+
+static const struct cap11xx_hw_model cap1298_model = {
+	.product_id = 0x71, .num_channels = 8, .num_leds = 0,
+	.has_gain = true,
+	.has_sensitivity_control = true,
+	.has_signal_guard = true,
+};
+
 static const struct of_device_id cap11xx_dt_ids[] = {
-	{ .compatible = "microchip,cap1106", },
-	{ .compatible = "microchip,cap1126", },
-	{ .compatible = "microchip,cap1188", },
-	{ .compatible = "microchip,cap1203", },
-	{ .compatible = "microchip,cap1206", },
-	{ .compatible = "microchip,cap1293", },
-	{ .compatible = "microchip,cap1298", },
-	{}
+	{ .compatible = "microchip,cap1106", .data = &cap1106_model },
+	{ .compatible = "microchip,cap1126", .data = &cap1126_model },
+	{ .compatible = "microchip,cap1188", .data = &cap1188_model },
+	{ .compatible = "microchip,cap1203", .data = &cap1203_model },
+	{ .compatible = "microchip,cap1206", .data = &cap1206_model },
+	{ .compatible = "microchip,cap1293", .data = &cap1293_model },
+	{ .compatible = "microchip,cap1298", .data = &cap1298_model },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cap11xx_dt_ids);
 
 static const struct i2c_device_id cap11xx_i2c_ids[] = {
-	{ "cap1106", CAP1106 },
-	{ "cap1126", CAP1126 },
-	{ "cap1188", CAP1188 },
-	{ "cap1203", CAP1203 },
-	{ "cap1206", CAP1206 },
-	{ "cap1293", CAP1293 },
-	{ "cap1298", CAP1298 },
-	{}
+	{ "cap1106", (kernel_ulong_t)&cap1106_model },
+	{ "cap1126", (kernel_ulong_t)&cap1126_model },
+	{ "cap1188", (kernel_ulong_t)&cap1188_model },
+	{ "cap1203", (kernel_ulong_t)&cap1203_model },
+	{ "cap1206", (kernel_ulong_t)&cap1206_model },
+	{ "cap1293", (kernel_ulong_t)&cap1293_model },
+	{ "cap1298", (kernel_ulong_t)&cap1298_model },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
 
-- 
2.43.0.472.g3155946c3a-goog


-- 
Dmitry
