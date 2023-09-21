Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF37AA134
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIUU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjIUU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:43 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E599AECC5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:06:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32008e339adso1260792f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695319571; x=1695924371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoiF1sc5Yv1hjuRdgeGOkvi9X2NDURf5lh9dRaGmJUM=;
        b=oELGhuowt3RAg1V+VVLrU/8nFUATbP/7CT9ycBfnw8mhtBh89EjnxJVZ29Si1lCz+0
         v0JNxBH/QhTRwwYruxWGnPZuWAfyqT/lAp08yDi+rnuHjVRHMrdJiu9tOpCCQuEHGH/H
         639iJZ5p3EibmV72VazbHjm0lH5AD7yofcw1eRAFTujCN4MOXCoZFm4jEL+gG1eMe21U
         XbWdeAHH9fOExOuZvW9mg0ijn3H0fhfjSjoD7pS5EVUWKUGpF6I+kXzZ0GTAZWMvDi1f
         r+iL2533c6wMTO4A/eo2YmQmdpGf6RTY1ojox4VRVgdhoROIef0F/Fzadp66GBqh9+Sy
         50kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319571; x=1695924371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoiF1sc5Yv1hjuRdgeGOkvi9X2NDURf5lh9dRaGmJUM=;
        b=MwVKh6lS/lQyIZyckI9Kh/WFb1b2DTslqVU07i6zVkgNTADUA10Ov6Uaw3NYwkVTu6
         tr2mSsTImMCL3HVUDHpQJz/iPtL+2Vl54mAawVSLsfjQeRZaBCdi9HMt6oH7XorHt/ag
         aGOr73WukoTffJz/z8YVg8bZAvId4ZJofLFBlXvhcgID/Ip1fZQtIjerEoXMLWrj/IS0
         nd46AyIFABJnLmxqdo5Z/rdUtiTRn6EOhOQOp2TTgwk4ZULpwoBD5no5Xs89j6x6DD+P
         60LftmGHC0aUlUVuO9eJOJ+8f0E0iQsaLbXZ1xQdpj4wmlBKxg8VyuYKptj2d9zNUL4E
         erUQ==
X-Gm-Message-State: AOJu0YzD71Cu+41OrNidLXudJIGWybEyOD6AM1l3xtEDLPcW64c01LX2
        aTYeClSUXCDrtRUeDKFLsFC7s5oBmMXrWHU1KR1wtazS
X-Google-Smtp-Source: AGHT+IFCUopE97lC+mXLOTM0jAVuUZKw4B0mX0fpS6Q9N1Bhfhwc3q0b7TASwl4gdJoses0AW6P78Q==
X-Received: by 2002:a05:600c:22ce:b0:401:b493:f7c1 with SMTP id 14-20020a05600c22ce00b00401b493f7c1mr5204399wmg.35.1695307463044;
        Thu, 21 Sep 2023 07:44:23 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:22 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 12/19] staging: iio: resolver: ad2s1210: rework gpios
Date:   Thu, 21 Sep 2023 09:43:53 -0500
Message-Id: <20230921144400.62380-13-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove "adi," prefix from gpio names.
- Sample gpio is now expected to be active low.
- Convert A0 and A1 gpios to "mode-gpios" gpio array.
- Convert RES0 and RES1 gpios to "resolution-gpios" gpio array.
- Remove extraneous lookup tables.
- Remove unused mode field from state struct.
- Swap argument order of ad2s1210_set_mode() while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 162 ++++++++++++------------
 1 file changed, 84 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 223cc4702188..7a1069d948eb 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -60,39 +60,21 @@
 #define AD2S1210_DEF_EXCIT	10000
 
 enum ad2s1210_mode {
-	MOD_POS = 0,
-	MOD_VEL,
-	MOD_CONFIG,
-	MOD_RESERVED,
+	MOD_POS = 0b00,
+	MOD_VEL = 0b01,
+	MOD_RESERVED = 0b10,
+	MOD_CONFIG = 0b11,
 };
 
-enum ad2s1210_gpios {
-	AD2S1210_SAMPLE,
-	AD2S1210_A0,
-	AD2S1210_A1,
-	AD2S1210_RES0,
-	AD2S1210_RES1,
-};
-
-struct ad2s1210_gpio {
-	const char *name;
-	unsigned long flags;
-};
-
-static const struct ad2s1210_gpio gpios[] = {
-	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_OUT_LOW },
-	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_OUT_LOW },
-};
-
-static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
-
 struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
-	struct gpio_desc *gpios[5];
+	/** GPIO pin connected to SAMPLE line. */
+	struct gpio_desc *sample_gpio;
+	/** GPIO pins connected to A0 and A1 lines. */
+	struct gpio_descs *mode_gpios;
+	/** GPIO pins connected to RES0 and RES1 lines. */
+	struct gpio_descs *resolution_gpios;
 	/** Used to access config registers. */
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
@@ -100,23 +82,19 @@ struct ad2s1210_state {
 	unsigned int fexcit;
 	bool hysteresis;
 	u8 resolution;
-	enum ad2s1210_mode mode;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
 };
 
-static const int ad2s1210_mode_vals[4][2] = {
-	[MOD_POS] = { 0, 0 },
-	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 1 },
-};
-
-static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
-				     struct ad2s1210_state *st)
+static int ad2s1210_set_mode(struct ad2s1210_state *st, enum ad2s1210_mode mode)
 {
-	gpiod_set_value(st->gpios[AD2S1210_A0], ad2s1210_mode_vals[mode][0]);
-	gpiod_set_value(st->gpios[AD2S1210_A1], ad2s1210_mode_vals[mode][1]);
-	st->mode = mode;
+	struct gpio_descs *gpios = st->mode_gpios;
+	DECLARE_BITMAP(bitmap, 2);
+
+	bitmap[0] = mode;
+
+	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
+				     bitmap);
 }
 
 /*
@@ -141,6 +119,7 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
 			.tx_buf = &st->tx[1],
 		},
 	};
+	int ret;
 
 	/* values can only be 7 bits, the MSB indicates an address */
 	if (val & ~0x7F)
@@ -149,7 +128,9 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
 	st->tx[0] = reg;
 	st->tx[1] = val;
 
-	ad2s1210_set_mode(MOD_CONFIG, st);
+	ret = ad2s1210_set_mode(st, MOD_CONFIG);
+	if (ret < 0)
+		return ret;
 
 	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 }
@@ -178,7 +159,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
 	};
 	int ret;
 
-	ad2s1210_set_mode(MOD_CONFIG, st);
+	ret = ad2s1210_set_mode(st, MOD_CONFIG);
+	if (ret < 0)
+		return ret;
+
 	st->tx[0] = reg;
 	/* Must be valid register address here otherwise this could write data.
 	 * It doesn't matter which one.
@@ -215,16 +199,16 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
 }
 
-static const int ad2s1210_res_pins[4][2] = {
-	{ 0, 0 }, {0, 1}, {1, 0}, {1, 1}
-};
-
-static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
+static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
+					 u8 resolution)
 {
-	gpiod_set_value(st->gpios[AD2S1210_RES0],
-			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
-	gpiod_set_value(st->gpios[AD2S1210_RES1],
-			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
+	struct gpio_descs *gpios = st->resolution_gpios;
+	DECLARE_BITMAP(bitmap, 2);
+
+	bitmap[0] = (resolution - 10) >> 1;
+
+	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
+				     bitmap);
 }
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
@@ -301,10 +285,13 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 	if (ret < 0)
 		goto error_ret;
 
-	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
-	ad2s1210_set_resolution_pin(st);
+	ret = ad2s1210_set_resolution_gpios(st, udata);
+	if (ret < 0)
+		goto error_ret;
+
+	st->resolution = udata;
 	ret = len;
+
 error_ret:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -335,15 +322,19 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
+
+	gpiod_set_value(st->sample_gpio, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
+	gpiod_set_value(st->sample_gpio, 0);
+
 	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
 	if (ret < 0)
 		goto error_ret;
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
-	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
+
+	gpiod_set_value(st->sample_gpio, 1);
+	gpiod_set_value(st->sample_gpio, 0);
+
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -404,16 +395,16 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
+		gpiod_set_value(st->sample_gpio, 1);
 		/* delay (6 * tck + 20) nano seconds */
 		udelay(1);
 
 		switch (chan->type) {
 		case IIO_ANGL:
-			ad2s1210_set_mode(MOD_POS, st);
+			ret = ad2s1210_set_mode(st, MOD_POS);
 			break;
 		case IIO_ANGL_VEL:
-			ad2s1210_set_mode(MOD_VEL, st);
+			ret = ad2s1210_set_mode(st, MOD_VEL);
 			break;
 		default:
 			ret = -EINVAL;
@@ -440,7 +431,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		}
 
 error_info_raw:
-		gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
+		gpiod_set_value(st->sample_gpio, 0);
 		/* delay (2 * tck + 20) nano seconds */
 		udelay(1);
 		mutex_unlock(&st->lock);
@@ -542,7 +533,9 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ad2s1210_set_resolution_pin(st);
+	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
+	if (ret < 0)
+		return ret;
 
 	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;
 	data |= (st->resolution - 10) >> 1;
@@ -604,20 +597,34 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	struct spi_device *spi = st->sdev;
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
-		st->gpios[i] = devm_gpiod_get(&spi->dev, gpios[i].name,
-					      gpios[i].flags);
-		if (IS_ERR(st->gpios[i])) {
-			ret = PTR_ERR(st->gpios[i]);
-			dev_err(&spi->dev,
-				"ad2s1210: failed to request %s GPIO: %d\n",
-				gpios[i].name, ret);
-			return ret;
-		}
-	}
+	struct device *dev = &st->sdev->dev;
+
+	/* should not be sampling on startup */
+	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
+	if (IS_ERR(st->sample_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->sample_gpio),
+				     "failed to request sample GPIO\n");
+
+	/* both pins high means that we start in config mode */
+	st->mode_gpios = devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->mode_gpios))
+		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
+				     "failed to request mode GPIOs\n");
+
+	if (st->mode_gpios->ndescs != 2)
+		return dev_err_probe(dev, -EINVAL,
+				     "requires exactly 2 mode-gpios\n");
+
+	/* both pins high means that we start with 16-bit resolution */
+	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(st->resolution_gpios))
+		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
+				     "failed to request resolution GPIOs\n");
+
+	if (st->resolution_gpios->ndescs != 2)
+		return dev_err_probe(dev, -EINVAL,
+				     "requires exactly 2 resolution-gpios\n");
 
 	return 0;
 }
@@ -683,7 +690,6 @@ static int ad2s1210_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 	st->hysteresis = true;
-	st->mode = MOD_CONFIG;
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
-- 
2.34.1

