Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9180867C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378990AbjLGLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjLGLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:13:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682310C7;
        Thu,  7 Dec 2023 03:13:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33349b3f99aso793160f8f.0;
        Thu, 07 Dec 2023 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701947611; x=1702552411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q04tsDqW57p+9vja5pX6TrNQSbK8g1Bln9Plrgyuq6U=;
        b=kM4dzzm1Q96yJPfi5/n3CtcsgGRfqZae3BPdExx52Qs7Jy8wEgJeV9F7Efk17iHEIq
         ba+bz10FfUmU30qJciqp/czI1Ycq3gbGsqZIGgcXB7PB2wILPJzdLgk4kBp/Nu8PYaKT
         d+xI36+MCvDUZerHvRU8FtNVabrcys5ZHPrK3tx0OWgW1Cs0qGNx4fm6afm8qaAYZgfO
         kn8i7HNS+7CKoZT/OtNrvUnGL/XKTBdimkYPmHpYjyZnSHlah2T6VtYwzzKBY53PFJ/I
         g7objuiZENH11jUa2q/S2lSlBQaB5igRP/K4CqxofzNkX5IR0aI45jP3PxJxsgKQ4BTR
         HTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947611; x=1702552411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q04tsDqW57p+9vja5pX6TrNQSbK8g1Bln9Plrgyuq6U=;
        b=L5FWGl+vgdQCMnLphqBdvoo0gzCwWIjvvG3kP3eZ30qPjOExNZEpM5/dzZEp8+USYj
         uhrl0luCrjhjXxXpbZJw4DihrIzK+pDPRHlcIudcIAoAoogRbLYFP+4x6crU5Ya5KVnY
         zEll7psa7tCJADla5JTa3HVUXQWSbQp5L4jCEsXmi0unVrxb6qGJnB1TckTWasqpN81v
         jiDd/br2pw2XysxJFvQ75uMktMfe2MjYErRxMxz9nmKvXbMazQMET7jmx8c8TbPcbQFV
         LrlbkQANoHhbibbrnauQB2LhtsczPJJ9DbFASoanyPM5QAItvQJvjhPMf4P/R1MTtlgx
         RF+A==
X-Gm-Message-State: AOJu0YxWMcT1veqyYk6aOf9/qCk5GT/97hL9WOSaOR8Sx8UzS4ckK1gG
        25L465Ael18/jZvMAPK0bLk=
X-Google-Smtp-Source: AGHT+IGIblJChk3/pL0IMI6XnShQv+MynmhlcXWEswXA1HuxUjijixn0Wu0k1c5gVDlynwzhuQkODQ==
X-Received: by 2002:a05:6000:1946:b0:332:d504:c131 with SMTP id e6-20020a056000194600b00332d504c131mr1266173wry.44.1701947611659;
        Thu, 07 Dec 2023 03:13:31 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:5036:93fe:290b:56de])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b003333541a5bdsm1166096wrv.80.2023.12.07.03.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 03:13:29 -0800 (PST)
From:   Stefan Eichenberger <eichest@gmail.com>
To:     nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, linus.walleij@linaro.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 2/2] Input: atmel_mxt_ts - support poweroff in suspend
Date:   Thu,  7 Dec 2023 12:13:00 +0100
Message-Id: <20231207111300.80581-3-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207111300.80581-1-eichest@gmail.com>
References: <20231207111300.80581-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add a new device tree property to indicate that the device should be
powered off in suspend mode. We have a shared regulator that powers the
display, a USB hub and some other peripherals. The maxtouch doesn't
normally disable the regulator in suspend mode, so our extra peripherals
stay powered on. This is not desirable as it consumes more power. With
this patch we add the option to disable the regulator in suspend mode
for the maxtouch and accept the longer initialisation time.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 72 ++++++++++++++++++------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 20094b9899f0..7caa0d317d30 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -317,6 +317,7 @@ struct mxt_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *wake_gpio;
 	bool use_retrigen_workaround;
+	bool poweroff_in_suspend;
 
 	/* Cached parameters from object table */
 	u16 T5_address;
@@ -2799,15 +2800,18 @@ static int mxt_configure_objects(struct mxt_data *data,
 			dev_warn(dev, "Error %d updating config\n", error);
 	}
 
-	if (data->multitouch) {
-		error = mxt_initialize_input_device(data);
-		if (error)
-			return error;
-	} else {
-		dev_warn(dev, "No touch object detected\n");
-	}
+	/* If input device is not already registered */
+	if (!data->input_dev) {
+		if (data->multitouch) {
+			error = mxt_initialize_input_device(data);
+			if (error)
+				return error;
+		} else {
+			dev_warn(dev, "No touch object detected\n");
+		}
 
-	mxt_debug_init(data);
+		mxt_debug_init(data);
+	}
 
 	return 0;
 }
@@ -3328,6 +3332,8 @@ static int mxt_probe(struct i2c_client *client)
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
+	data->poweroff_in_suspend = device_property_read_bool(&client->dev,
+							       "atmel,poweroff-in-suspend");
 	/*
 	 * Controllers like mXT1386 have a dedicated WAKE line that could be
 	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
@@ -3390,12 +3396,21 @@ static int mxt_suspend(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	mutex_lock(&input_dev->mutex);
+	if (!device_may_wakeup(dev) && data->poweroff_in_suspend) {
+		if (data->reset_gpio)
+			gpiod_set_value(data->reset_gpio, 1);
 
-	if (input_device_enabled(input_dev))
-		mxt_stop(data);
+		regulator_bulk_disable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		data->T44_address = 0;
+	} else {
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_stop(data);
 
-	mutex_unlock(&input_dev->mutex);
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	disable_irq(data->irq);
 
@@ -3411,14 +3426,37 @@ static int mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
-	enable_irq(data->irq);
+	if (!device_may_wakeup(dev) && data->poweroff_in_suspend) {
+		int ret;
 
-	mutex_lock(&input_dev->mutex);
+		ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				data->regulators);
+		if (ret) {
+			dev_err(dev, "failed to enable regulators: %d\n",
+					ret);
+			return ret;
+		}
+		msleep(MXT_BACKUP_TIME);
 
-	if (input_device_enabled(input_dev))
-		mxt_start(data);
+		if (data->reset_gpio) {
+			/* Wait a while and then de-assert the RESET GPIO line */
+			msleep(MXT_RESET_GPIO_TIME);
+			gpiod_set_value(data->reset_gpio, 0);
+			msleep(MXT_RESET_INVALID_CHG);
+		}
 
-	mutex_unlock(&input_dev->mutex);
+		/* This also enables the irq again */
+		mxt_initialize(data);
+	} else {
+		enable_irq(data->irq);
+
+		mutex_lock(&input_dev->mutex);
+
+		if (input_device_enabled(input_dev))
+			mxt_start(data);
+
+		mutex_unlock(&input_dev->mutex);
+	}
 
 	return 0;
 }
-- 
2.40.1

