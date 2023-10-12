Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D257C780A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442540AbjJLUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442670AbjJLUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:45:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D96E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:45:55 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dd8304b980so814333fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697143555; x=1697748355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mmYQTwnq/ofc5mmsg/d6LMBWdP6YzfcA9Z3KEowYm3s=;
        b=DUEmJylwzO3k9UmqjTCyEfuTuUnTSnX2Koa5xeoY4IE2IhOi1Dgn0C/B6sfpIGF8l+
         amtx/eD7U9hFUcCnlOlZ5H6HS/KRFRtLUwDxjmWOus7HR/9Nb9YJl922Az/nvjbfPAM1
         XELr0XYeWXxm8+qZXxa/wu2rweUACfoSSJ8/1zSIpwbR2aMpbSHiRT8v7kBFBe9aPPnY
         M/l1oIAuS6UsON8pZ1aJjJcKgPV7vnvK/5oTcV8XNRT301aj8npAyt4Ud3lO1ZaXaGDK
         ieREcvGahAYYSL96ZGnQ2QbIz/ALKb+ivpJaT/RMRAHQHZCVjSIniYDnpTqeNOghzNxA
         gpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697143555; x=1697748355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmYQTwnq/ofc5mmsg/d6LMBWdP6YzfcA9Z3KEowYm3s=;
        b=JYems2e4A+z0X2mqgF7h0f0cgdyDLpfaKE99/PYPCNmCduBu/CH/jIoPk4ehi3j5dG
         kUX01HSGPE5C/T1okPtt7rgkcOcyd3wxB3ZIP1mDiqQr8jIO1WhId+mG23IlBBGeYtyF
         8+UMlxmlv3eWc3mN7Qs8egqNjXMmiIMmaL3OOnjwpaB5vL58rHFQ1YzQP6xRTk2SrmkN
         PWUhmkYDGc6KhLEgob1DvUW9Y+e9vuESibeBIIlCow7MqZxiVW0Zt3iIctBi9vJXDvH1
         1i6JOrPm/MLBCqv5xZG/bYStwfOz7zM8Jfvo8O8OTZlNRpgyPY9jGW+zTFp65EW84WEM
         F3Gw==
X-Gm-Message-State: AOJu0Yz7aAUg/Bc85eIIvwOpIrFSVQN8bsEnameme94SsS8bDs5Dc37Z
        vlOsT9Dy7+gecd4WoOc9rBlP7Q==
X-Google-Smtp-Source: AGHT+IF7kfh4GL/zfwZpEJsA3AD0dscmPz1SGRR51txqbUb9nPk/xMS4WYi+HAV9RWGvcdz7bHAikw==
X-Received: by 2002:a05:6870:23a0:b0:1be:dfdf:cb1 with SMTP id e32-20020a05687023a000b001bedfdf0cb1mr30935485oap.46.1697143554736;
        Thu, 12 Oct 2023 13:45:54 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k11-20020a056870f10b00b001d6e9bb67d2sm499056oac.7.2023.10.12.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:45:54 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH] iio: resolver: ad2s1210: add support for adi,fixed-mode
Date:   Thu, 12 Oct 2023 15:45:09 -0500
Message-ID: <20231012204509.3095010-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to use the AD2S1210 with hardwired mode pins (A0 and A1).
According to the devicetree bindings, in this case the adi,fixed-mode
property will specify which of the 3 possible modes the mode pins are
hardwired for and the gpio-modes property is not allowed.

This adds support for the case where the mode pins are hardwired for
config mode. In this configuration, the position and velocity must be read
from the config register.

The cases of hardwired position or velocity modes is not supported as
there would be no way to configure the device.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 193 +++++++++++++++++++++++++++-----
 1 file changed, 162 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 1bd1b950e7cc..e6d3f31d529f 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -141,7 +141,7 @@ struct ad2s1210_state {
 	struct spi_device *sdev;
 	/** GPIO pin connected to SAMPLE line. */
 	struct gpio_desc *sample_gpio;
-	/** GPIO pins connected to A0 and A1 lines. */
+	/** GPIO pins connected to A0 and A1 lines (optional). */
 	struct gpio_descs *mode_gpios;
 	/** Used to access config registers. */
 	struct regmap *regmap;
@@ -149,6 +149,8 @@ struct ad2s1210_state {
 	unsigned long clkin_hz;
 	/** Available raw hysteresis values based on resolution. */
 	int hysteresis_available[2];
+	/* adi,fixed-mode property - only valid when mode_gpios == NULL. */
+	enum ad2s1210_mode fixed_mode;
 	/** The selected resolution */
 	enum ad2s1210_resolution resolution;
 	/** Copy of fault register from the previous read. */
@@ -175,6 +177,9 @@ static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 	struct gpio_descs *gpios = st->mode_gpios;
 	DECLARE_BITMAP(bitmap, 2);
 
+	if (!gpios)
+		return mode == st->fixed_mode ? 0 : -EOPNOTSUPP;
+
 	bitmap[0] = mode;
 
 	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
@@ -276,7 +281,8 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	 * parity error. The fault register is read-only and the D7 bit means
 	 * something else there.
 	 */
-	if (reg != AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
+	if ((reg > AD2S1210_REG_VELOCITY_LSB && reg != AD2S1210_REG_FAULT)
+	     && st->rx[1] & AD2S1210_ADDRESS_DATA)
 		return -EBADMSG;
 
 	*val = st->rx[1];
@@ -437,6 +443,40 @@ static void ad2s1210_push_events(struct iio_dev *indio_dev,
 	st->prev_fault_flags = flags;
 }
 
+/**
+ * Reads position or velocity from the config registers.
+ *
+ * This is used when the mode gpios are not available.
+ *
+ * Must be called with the lock held.
+ *
+ * @param st The device state.
+ * @param val Pointer to hold the value read.
+ * @param msb_reg The register address of the MSB register.
+ * @param lsb_reg The register address of the LSB register.
+ * @return 0 on success, negative error code otherwise.
+ */
+static int ad2s1210_read_val_from_config(struct ad2s1210_state *st, __be16 *val,
+					 u8 msb_reg, u8 lsb_reg)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, msb_reg, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	((u8 *)val)[0] = reg_val;
+
+	ret = regmap_read(st->regmap, lsb_reg, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	((u8 *)val)[1] = reg_val;
+
+	return 0;
+}
+
 static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int *val)
@@ -450,21 +490,53 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
 	ad2s1210_toggle_sample_line(st);
 	timestamp = iio_get_time_ns(indio_dev);
 
-	switch (chan->type) {
-	case IIO_ANGL:
-		ret = ad2s1210_set_mode(st, MOD_POS);
-		break;
-	case IIO_ANGL_VEL:
-		ret = ad2s1210_set_mode(st, MOD_VEL);
-		break;
-	default:
-		return -EINVAL;
+	if (st->fixed_mode == MOD_CONFIG) {
+		unsigned int reg_val;
+
+		switch (chan->type) {
+		case IIO_ANGL:
+			ret = ad2s1210_read_val_from_config(st, &st->sample.raw,
+						AD2S1210_REG_POSITION_MSB,
+						AD2S1210_REG_POSITION_LSB);
+			if (ret < 0)
+				return ret;
+
+			break;
+		case IIO_ANGL_VEL:
+			ret = ad2s1210_read_val_from_config(st, &st->sample.raw,
+						AD2S1210_REG_VELOCITY_MSB,
+						AD2S1210_REG_VELOCITY_LSB);
+			if (ret < 0)
+				return ret;
+
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		st->sample.fault = reg_val;
+	} else {
+		switch (chan->type) {
+		case IIO_ANGL:
+			ret = ad2s1210_set_mode(st, MOD_POS);
+			break;
+		case IIO_ANGL_VEL:
+			ret = ad2s1210_set_mode(st, MOD_VEL);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (ret < 0)
+			return ret;
+
+		ret = spi_read(st->sdev, &st->sample, 3);
+		if (ret < 0)
+			return ret;
 	}
-	if (ret < 0)
-		return ret;
-	ret = spi_read(st->sdev, &st->sample, 3);
-	if (ret < 0)
-		return ret;
 
 	switch (chan->type) {
 	case IIO_ANGL:
@@ -1252,27 +1324,53 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
 	ad2s1210_toggle_sample_line(st);
 
 	if (test_bit(0, indio_dev->active_scan_mask)) {
-		ret = ad2s1210_set_mode(st, MOD_POS);
-		if (ret < 0)
-			goto error_ret;
-
-		ret = spi_read(st->sdev, &st->sample, 3);
-		if (ret < 0)
-			goto error_ret;
+		if (st->fixed_mode == MOD_CONFIG) {
+			ret = ad2s1210_read_val_from_config(st, &st->sample.raw,
+						AD2S1210_REG_POSITION_MSB,
+						AD2S1210_REG_POSITION_LSB);
+			if (ret < 0)
+				goto error_ret;
+		} else {
+			ret = ad2s1210_set_mode(st, MOD_POS);
+			if (ret < 0)
+				goto error_ret;
+
+			ret = spi_read(st->sdev, &st->sample, 3);
+			if (ret < 0)
+				goto error_ret;
+		}
 
 		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
 	}
 
 	if (test_bit(1, indio_dev->active_scan_mask)) {
-		ret = ad2s1210_set_mode(st, MOD_VEL);
-		if (ret < 0)
-			goto error_ret;
+		if (st->fixed_mode == MOD_CONFIG) {
+			ret = ad2s1210_read_val_from_config(st, &st->sample.raw,
+						AD2S1210_REG_VELOCITY_MSB,
+						AD2S1210_REG_VELOCITY_LSB);
+			if (ret < 0)
+				goto error_ret;
+		} else {
+			ret = ad2s1210_set_mode(st, MOD_VEL);
+			if (ret < 0)
+				goto error_ret;
+
+			ret = spi_read(st->sdev, &st->sample, 3);
+			if (ret < 0)
+				goto error_ret;
+		}
 
-		ret = spi_read(st->sdev, &st->sample, 3);
+		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
+	}
+
+	if (st->fixed_mode == MOD_CONFIG) {
+		unsigned int reg_val;
+
+		ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
 		if (ret < 0)
-			goto error_ret;
+			return ret;
 
-		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
+		st->sample.fault = reg_val;
 	}
 
 	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
@@ -1299,9 +1397,33 @@ static const struct iio_info ad2s1210_info = {
 static int ad2s1210_setup_properties(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
+	const char *str_val;
 	u32 val;
 	int ret;
 
+	ret = device_property_read_string(dev, "adi,fixed-mode", &str_val);
+	if (ret == -EINVAL)
+		st->fixed_mode = -1;
+	else if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"failed to read adi,fixed-mode property\n");
+	else {
+		if (strcmp(str_val, "position") == 0)
+			st->fixed_mode = MOD_POS;
+		else if (strcmp(str_val, "velocity") == 0)
+			st->fixed_mode = MOD_VEL;
+		else if (strcmp(str_val, "config") == 0)
+			st->fixed_mode = MOD_CONFIG;
+		else
+			return dev_err_probe(dev, -EINVAL,
+				"invalid adi,fixed-mode property value: %s\n",
+				str_val);
+
+		if (st->fixed_mode != MOD_CONFIG)
+			return dev_err_probe(dev, -EINVAL,
+				"only adi,fixed-mode=\"config\" is supported\n");
+	}
+
 	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
@@ -1357,12 +1479,21 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 				     "failed to request sample GPIO\n");
 
 	/* both pins high means that we start in config mode */
-	st->mode_gpios = devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
+	st->mode_gpios = devm_gpiod_get_array_optional(dev, "mode",
+						       GPIOD_OUT_HIGH);
 	if (IS_ERR(st->mode_gpios))
 		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
 				     "failed to request mode GPIOs\n");
 
-	if (st->mode_gpios->ndescs != 2)
+	if (!st->mode_gpios && st->fixed_mode == -1)
+		return dev_err_probe(dev, -EINVAL,
+			"must specify either adi,fixed-mode or mode-gpios\n");
+
+	if (st->mode_gpios && st->fixed_mode != -1)
+		return dev_err_probe(dev, -EINVAL,
+			"must specify only one of adi,fixed-mode or mode-gpios\n");
+
+	if (st->mode_gpios && st->mode_gpios->ndescs != 2)
 		return dev_err_probe(dev, -EINVAL,
 				     "requires exactly 2 mode-gpios\n");
 
-- 
2.42.0

