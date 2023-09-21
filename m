Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B657A98DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjIURyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIURxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:53:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AA5B8F8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-532addba879so2647664a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317369; x=1695922169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoiF1sc5Yv1hjuRdgeGOkvi9X2NDURf5lh9dRaGmJUM=;
        b=w/y6pZynNzcpSeLIsCj9ynAqT8PQqmkBhda2jxXHRihnfZlMlFgLsgqltbjsKj/iut
         XdLHz5ezl1NIgJDXb6PwgPSHZSTu/SWNCpHnScDWy1zyIeAvhWClnD9PE69Z0/zbraip
         19oigA55j9xTKIm9RdCGUXnAn192kJ4S5o+5Y2Dyp8v2MARR/zDPYvEsIDUYbi6SH69x
         iyCSdDtawzugou/cbkq84XMLOgkqcoQ+wbb9MAMQ1Lc6Dpmecwp2yfzcRhEOiq9XPDy8
         moeINQb2csJUG6gBAYMzZnjPP9dgzcHWXCDe/fFcILlGPvefYHygEMf0VsE3Z6evn0o3
         Wq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317369; x=1695922169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoiF1sc5Yv1hjuRdgeGOkvi9X2NDURf5lh9dRaGmJUM=;
        b=gPTikhk6VX+EzxCKikz61aD998QGiWU08rCAEsrCNwr2GbJa0qcO7Vgec/roLEbKj2
         TInxnQ9B+HEez86NRxJCgMS0q67wbM2SBJmSZDMi5ZbAJSvK5fh3ZgP4yrp6UH8GGkgL
         tyZTkVNjPsLIAWJL8FYx3/IGwpNScpefgEHjraI5ohcdtQO8kvWwb5pmZ+sfEmVeLU0H
         tR5p9wQKdczcSmZ7lP80eTOM/q77aqLVbGx9tPSVz84sB5oQohVvM9p0kh12j59YucSt
         /vCDp0EAzu9z/gOqHg+FhdUuaoHQEHP+zo8xIM20708ysyUM3ClIyj33G31d0FVfqILz
         8YYQ==
X-Gm-Message-State: AOJu0YxzLjCSG478BNfBSWl4HsyV8LpwaHAGgi0pTcceY5bp9esxYVU7
        3FPJVHHHhTPOwXBEmUPeIWEawIc7jirb13FUw0DnTvX5
X-Google-Smtp-Source: AGHT+IFLAailNSfpLWCmoZinfeHn+u6645WDTA+4EEZgkEmo5Zeo7s9f1tFWyiN0QMRZgSvQMKO0kw==
X-Received: by 2002:adf:d0cc:0:b0:31f:ebb5:cd51 with SMTP id z12-20020adfd0cc000000b0031febb5cd51mr4695038wrh.33.1695306162905;
        Thu, 21 Sep 2023 07:22:42 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:42 -0700 (PDT)
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
Subject: [v2 12/19] staging: iio: resolver: ad2s1210: rework gpios
Date:   Thu, 21 Sep 2023 09:19:40 -0500
Message-Id: <20230921141947.57784-15-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

