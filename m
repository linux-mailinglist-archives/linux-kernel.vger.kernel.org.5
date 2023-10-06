Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C327BAFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjJFAwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJFAvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:51:32 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD930126
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 17:51:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4b9e09521so1035678a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696553478; x=1697158278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvy2ayD735MSl5ZTX0UlQERY4ZoXQRp7gkWExI7lVYw=;
        b=1U2OiZOkF5GlWMVZzavEG5oq8tliFyjyI6dj1iwtBkZvYR7qACJDjpxPL1RXTg0QDK
         7oeWTT5D1JPFihKbVj5cRkQ+kn6tezmNhT20J0CTEjd7R5Z7G9x3HTy08xne977b/P+A
         8/QozdsQ3xTX/99/DC3gIwahN2uIsy1msYln+up472wyZXZZsiHcrmAzjcxVf7a6mNdW
         7fjWCj9aR9+Nl7P8gJTflvXS7a/VusYuJdig/ARhUH9RzUOd5KOHPYvWQltV2KHXDmuB
         chPIvgEZv0l8pGODXJQ7Mz/bc0WB8zJDPjXCv2RVScKUxx7ymSYt0CYU7UdPwmt3O/+Q
         sX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696553478; x=1697158278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvy2ayD735MSl5ZTX0UlQERY4ZoXQRp7gkWExI7lVYw=;
        b=hwIURt5wFbI6qv4AvghLhQkqzEGr8Pg97AslIH0hwnRoIiTEQPCAom42ZY3u9Gw+v3
         8MaRy46v1sLbn1ISN84xBNS+Di5KECnrSM37FCAy+WkhVmMgZ1ryuV+JmG+4SLBdL3Op
         WOwBwDPJky1jc41i2O7AbrO9H3ME/B1+u9HMQEPItLLTJLMkoHn0wFsbOzuGBpnoK/tY
         o/QxnY+DMaElcEsXFa9f9xalDtW07eZgn8xz8lPcAeydAM0Pjjw59jiOmYF176UavN0v
         Gl/u3rICttMGZNMnIf+OOTdzHfKKO2HFSBNesmOmjcNb++WoritDka4pfNCKZUGG0d6m
         qifw==
X-Gm-Message-State: AOJu0YzJkgAM6sbzWATodoZjEu54I6s/Ue+ok7F+QJ7cyzVtUOuLfdWi
        eaOsHyuCOE3lrFO88bl2KKn8lA==
X-Google-Smtp-Source: AGHT+IHETgGeqGZSvktD/tKU7BzXYk2Is2jzn6GMo6B98IovaMoUy/6NXzQov+m+TDvrTga6TxDudg==
X-Received: by 2002:a05:6870:d188:b0:1d5:3fd3:390a with SMTP id a8-20020a056870d18800b001d53fd3390amr7418497oac.49.1696553477962;
        Thu, 05 Oct 2023 17:51:17 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id mo9-20020a056871320900b001dd0ff401edsm545072oac.51.2023.10.05.17.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 17:51:17 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 17/17] staging: iio: resolver: ad2s1210: simplify code with guard(mutex)
Date:   Thu,  5 Oct 2023 19:50:34 -0500
Message-ID: <20231005-ad2s1210-mainline-v4-17-ec00746840fc@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify the code and get rid of most of the gotos by using
guard(mutex) from cleanup.h.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: New patch in v4.

 drivers/staging/iio/resolver/ad2s1210.c | 157 ++++++++++----------------------
 1 file changed, 50 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c4e1bc22e8b0..c4e0ffa92dc2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -47,6 +47,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -404,11 +405,13 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 	s64 timestamp;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	gpiod_set_value(st->sample_gpio, 1);
 	timestamp = iio_get_time_ns(indio_dev);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
+	gpiod_set_value(st->sample_gpio, 0);
 
 	switch (chan->type) {
 	case IIO_ANGL:
@@ -418,14 +421,13 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 		ret = ad2s1210_set_mode(st, MOD_VEL);
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 	ret = spi_read(st->sdev, &st->sample, 3);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	switch (chan->type) {
 	case IIO_ANGL:
@@ -437,17 +439,11 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
 	ad2s1210_push_events(indio_dev, st->sample.fault, timestamp);
 
-error_ret:
-	gpiod_set_value(st->sample_gpio, 0);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
@@ -455,11 +451,9 @@ static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
 			       AD2S1210_ENABLE_HYSTERESIS);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -469,15 +463,10 @@ static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
 
 static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_ENABLE_HYSTERESIS,
-				 val ? AD2S1210_ENABLE_HYSTERESIS : 0);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				  AD2S1210_ENABLE_HYSTERESIS,
+				  val ? AD2S1210_ENABLE_HYSTERESIS : 0);
 }
 
 static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
@@ -485,11 +474,9 @@ static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
 			       AD2S1210_PHASE_LOCK_RANGE_44);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -509,7 +496,7 @@ static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
 static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
 					 int val, int val2)
 {
-	int deg, ret;
+	int deg;
 
 	/* convert radians to degrees - only two allowable values */
 	if (val == PHASE_44_DEG_TO_RAD_INT && val2 == PHASE_44_DEG_TO_RAD_MICRO)
@@ -520,12 +507,10 @@ static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
 	else
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_PHASE_LOCK_RANGE_44,
-				 deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
-	mutex_unlock(&st->lock);
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				  AD2S1210_PHASE_LOCK_RANGE_44,
+				  deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
 }
 
 /* map resolution to microradians/LSB for LOT registers */
@@ -542,10 +527,8 @@ static int ad2s1210_get_voltage_threshold(struct ad2s1210_state *st,
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, reg, &reg_val);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -557,15 +540,11 @@ static int ad2s1210_set_voltage_threshold(struct ad2s1210_state *st,
 					  unsigned int reg, int val)
 {
 	unsigned int reg_val;
-	int ret;
 
 	reg_val = val / THRESHOLD_MILLIVOLT_PER_LSB;
 
-	mutex_lock(&st->lock);
-	ret = regmap_write(st->regmap, reg, reg_val);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return regmap_write(st->regmap, reg, reg_val);
 }
 
 static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
@@ -574,10 +553,8 @@ static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -596,18 +573,18 @@ static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
 	if (val != 0)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	/*
 	 * We need to read both high and low registers first so we can preserve
 	 * the hysteresis.
 	 */
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	hysteresis = high_reg_val - low_reg_val;
 	high_reg_val = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
@@ -615,14 +592,9 @@ static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
 
 	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, high_reg_val);
 	if (ret < 0)
-		goto error_ret;
-
-	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
-
-error_ret:
-	mutex_unlock(&st->lock);
+		return ret;
 
-	return ret;
+	return regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
 }
 
 static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
@@ -631,16 +603,13 @@ static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
 	unsigned int high_reg_val, low_reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
-
-error_ret:
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -663,18 +632,14 @@ static int ad2s1210_set_lot_low_threshold(struct ad2s1210_state *st,
 
 	hysteresis = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
-	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
+	return regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
 			   reg_val - hysteresis);
-
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret;
 }
 
 static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
@@ -682,31 +647,23 @@ static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val
 	unsigned int reg_val;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &reg_val);
 	if (ret < 0)
-		goto error_ret;
+		return ret;
 
 	*val = reg_val * st->clkin_hz / (1 << 15);
-	ret = IIO_VAL_INT;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return IIO_VAL_INT;
 }
 
 static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st, int val)
 {
-	int ret;
-
 	if (val < AD2S1210_MIN_EXCIT || val > AD2S1210_MAX_EXCIT)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
-	ret = ad2s1210_reinit_excitation_frequency(st, val);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return ad2s1210_reinit_excitation_frequency(st, val);
 }
 
 static const int ad2s1210_velocity_scale[] = {
@@ -982,10 +939,8 @@ static ssize_t event_attr_voltage_reg_show(struct device *dev,
 	unsigned int value;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_read(st->regmap, iattr->address, &value);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -1005,11 +960,9 @@ static ssize_t event_attr_voltage_reg_store(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	ret = regmap_write(st->regmap, iattr->address,
 			   data / THRESHOLD_MILLIVOLT_PER_LSB);
-	mutex_unlock(&st->lock);
-
 	if (ret < 0)
 		return ret;
 
@@ -1083,7 +1036,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	unsigned int data;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	/* Use default config register value plus resolution from devicetree. */
 	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
@@ -1093,13 +1046,9 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 
 	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
-		goto error_ret;
-
-	ret = ad2s1210_reinit_excitation_frequency(st, AD2S1210_DEF_EXCIT);
+		return ret;
 
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
+	return ad2s1210_reinit_excitation_frequency(st, AD2S1210_DEF_EXCIT);
 }
 
 static int ad2s1210_read_label(struct iio_dev *indio_dev,
@@ -1243,18 +1192,13 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
 				       unsigned int *readval)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	if (readval)
-		ret = regmap_read(st->regmap, reg, readval);
-	else
-		ret = regmap_write(st->regmap, reg, writeval);
-
-	mutex_unlock(&st->lock);
+		return regmap_read(st->regmap, reg, readval);
 
-	return ret;
+	return regmap_write(st->regmap, reg, writeval);
 }
 
 static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
@@ -1265,7 +1209,7 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	size_t chan = 0;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	memset(&st->scan, 0, sizeof(st->scan));
 	gpiod_set_value(st->sample_gpio, 1);
@@ -1299,7 +1243,6 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 
 error_ret:
 	gpiod_set_value(st->sample_gpio, 0);
-	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.42.0

