Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CB7CAA83
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPNya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjJPNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:54:29 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E651FA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:54:26 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1e19cb7829bso2867804fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697464466; x=1698069266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qb3nQOmS4eBZNe2aGjgDsQO1OOhOOIU5vu95mwm6m0=;
        b=oN5UaAHdYMEQR3FpmIEUj1EbL7N0U9fH4G20+5ydgpdeZHK+tMn9aCuX4vys0n+GWs
         p2gm+CSjGl5mixsLF74olRP20dxV0ri8Ib+sv4ttwKGW0LhWUwd1Mji4bPcI4oaYf6qN
         /9BwIvybCB2yljexNk975NnY4wxpLgTrg1L/DmdbKHiWBd7Lu0MGSK6dCYk/Y3JMd9ue
         IZLCVC8hIuri2OYjheVc4KC0D+Vr8JKw4IjqmbGXolRBvheJKIHmdCwvZgLtmTzj2uGx
         JxH5Bkbu7V2EIVHOAYF/QqYDHSrEq5At+duvwIpmeaFW0dx3wzGaLQaM/gYKf2MSpElv
         ZB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464466; x=1698069266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Qb3nQOmS4eBZNe2aGjgDsQO1OOhOOIU5vu95mwm6m0=;
        b=bm/yHvtWrwaHCJrhnXGw7Fi5CB0nSnkduYqEV8QY+tmo2HLgpEfPxWrJlMlS60Ymqq
         AilnpCJWaaJrXUIj+dvacsHX7ufESphCHRSNTvb+szqd+J7MQbLUUnhEb9eg40H+Vj+1
         1Qk5uAot9VPeE0bfl6qtuKmYgsRi0ZaXECWmUJkyyTsJoOQRc9UhyyNHdUarjGXRai/j
         wgcoRgzSWvHwoK2QTBHNWA6AcRPcMlx4qDj3pSv/69yJkVua0NvQMGfDUG9cx8W4IBMY
         BngBLqZUX7+/8Rx2fCmwacYf2Cb0QN0mil2s61KgkEBX0FcPMMdFzMiNmxu0N7Lpb5xl
         lYEw==
X-Gm-Message-State: AOJu0Yx9wOxPE87D8fYvrytSjhgidQUUtNTMl9hInfINzRe90nJ156Ou
        sFqhHgSESazo7cFf8a4Fi7J/NQ==
X-Google-Smtp-Source: AGHT+IGn/zbm67yt24jOBp3UnbWNqU++gqXQkXqM8yQc7GC5LM7vsd+4eOC6ozXxrtctNkl7n5c3Ow==
X-Received: by 2002:a05:6870:582:b0:1dc:723d:b8d0 with SMTP id m2-20020a056870058200b001dc723db8d0mr41487601oap.27.1697464465724;
        Mon, 16 Oct 2023 06:54:25 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id zh38-20020a0568716ba600b001e9888ab4e7sm2014399oab.5.2023.10.16.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:54:25 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: resolver: ad2s1210: add support for adi,fixed-mode
Date:   Mon, 16 Oct 2023 08:54:22 -0500
Message-ID: <20231016135423.16808-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
config mode. In this configuration, the position and value must be read
from the config register.

The case of hardwired position or velocity mode is not supported as
there would be no way to configure the device.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Use regmap_bulk_read() instead of new local function.
* Simplify adi,fixed-mode property error checking.

 drivers/iio/resolver/ad2s1210.c | 150 +++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 1bd1b950e7cc..7f688bfe2172 100644
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
@@ -450,21 +456,53 @@ static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
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
+			ret = regmap_bulk_read(st->regmap,
+					       AD2S1210_REG_POSITION_MSB,
+					       &st->sample.raw, 2);
+			if (ret < 0)
+				return ret;
+
+			break;
+		case IIO_ANGL_VEL:
+			ret = regmap_bulk_read(st->regmap,
+					       AD2S1210_REG_VELOCITY_MSB,
+					       &st->sample.raw, 2);
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
@@ -1252,27 +1290,53 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
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
+			ret = regmap_bulk_read(st->regmap,
+					       AD2S1210_REG_POSITION_MSB,
+					       &st->sample.raw, 2);
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
+			ret = regmap_bulk_read(st->regmap,
+					       AD2S1210_REG_VELOCITY_MSB,
+					       &st->sample.raw, 2);
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
@@ -1299,9 +1363,24 @@ static const struct iio_info ad2s1210_info = {
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
+		if (strcmp(str_val, "config"))
+			return dev_err_probe(dev, -EINVAL,
+				"only adi,fixed-mode=\"config\" is supported\n");
+
+		st->fixed_mode = MOD_CONFIG;
+	}
+
 	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
 	if (ret < 0)
 		return dev_err_probe(dev, ret,
@@ -1357,12 +1436,21 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
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

