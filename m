Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8B7B3928
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjI2Ru2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjI2R0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:17 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621F10E6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:04 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-57be7c28423so3990554eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008363; x=1696613163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8tOsTdNCR758g2TkITBHYwFeOLCEzbiJxAY3l1Z6tI=;
        b=thfGx90ZyAV4qGeI4PGwWim3bSeFpA7x7I42EZtvcWdmf2SmP5g/pUNelwQMPFqiDS
         KhVzs9Dc5OnhEenAfoIBQEX2xiM3918jrZdNDlAVnuBTFkJgqU0vlMNrqNKuGMU0wFIi
         ccZv4yyBGiz+ANIUT8qnseQnL4yxz6l2OmWCne/s1CMsD14PC2Fk86QjkmW9ZStrNay3
         zgRQwp4U/NapnlzNqcmmDbd8f0wL8y4clJTUeVXcIyODj0vyQOqAT0PSpOvNt14iamuB
         hazrlhNX9RjCEZZ0N1oqCz4ZVCMgrnC1bIke4wJ9m/Ygj1bgkvlUukK3+/XZVRdCYm6C
         4aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008363; x=1696613163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8tOsTdNCR758g2TkITBHYwFeOLCEzbiJxAY3l1Z6tI=;
        b=maZl8ZmVOar6m/H8MLiytyB0dmcbw+qgIUk3lKCak3+ceNPrfZA4wdBM01YCL7vOoO
         e+3+kYaD2gs/9Io8zy/Cbo5vHp0wylEFnxwDPGR3U1qu5yKcCZI6VmRUB1opBqaVhAPu
         Kp0fvM5xq/vKZEDX/Kd77gm+6SQw3W81+N/c31mJd65r6fZvLab4esCvgmP96dYVMMht
         vfeMtIB9gcbu/X7Hn4FnaITmnBEO/fPh1JhDIO7hqPJtL0rUj0DuuWXNsclD2UONEd7K
         tYHHJyRJb0wd1wpe/flG0lqNnZHVgxIDa2dbOTHJ3qDlkT7l/Oixgtr+ZaAcNOWPeNaF
         69ZA==
X-Gm-Message-State: AOJu0Yx+VIv4HmTM8ZkJ24Xy5ojyKyqrKGR7XBnFoR4+LwL5iVykwGW5
        /Jf2yaGF7zpYegfEZO9InUu4dg==
X-Google-Smtp-Source: AGHT+IFKkstfKXcO5xMemJdNL3U367KvkT+g1DFIIOWc+qD0Caqx+nKTVY4+5Z6xdKJDBTREYdFRtg==
X-Received: by 2002:a4a:ea28:0:b0:57b:eee7:4a40 with SMTP id y8-20020a4aea28000000b0057beee74a40mr5161496ood.7.1696008363143;
        Fri, 29 Sep 2023 10:26:03 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:26:02 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 18/27] staging: iio: resolver: ad2s1210: convert resolution to devicetree property
Date:   Fri, 29 Sep 2023 12:23:23 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-18-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

Selecting the resolution was implemented as the `bits` sysfs attribute.
However, the selection of the resolution depends on how the hardware
is wired and the specific application, so this is rather a job for
devicetree to describe.

A new devicetree property `adi,resolution` to specify the resolution
required for each chip is added and the `bits` sysfs attribute is
removed.

Since the resolution is now supplied by a devicetree property, the
resolution-gpios are now optional and we can allow for the case where
the resolution pins on the AD2S1210 are hard-wired instead of requiring
them to be connected to gpios.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Fixed multiline comment style.

 drivers/staging/iio/resolver/ad2s1210.c | 136 ++++++++++++++------------------
 1 file changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 6accb9e3db46..a0a426d0af19 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -63,6 +63,13 @@ enum ad2s1210_mode {
 	MOD_CONFIG = 0b11,
 };
 
+enum ad2s1210_resolution {
+	AD2S1210_RES_10 = 0b00,
+	AD2S1210_RES_12 = 0b01,
+	AD2S1210_RES_14 = 0b10,
+	AD2S1210_RES_16 = 0b11,
+};
+
 struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
@@ -70,13 +77,12 @@ struct ad2s1210_state {
 	struct gpio_desc *sample_gpio;
 	/** GPIO pins connected to A0 and A1 lines. */
 	struct gpio_descs *mode_gpios;
-	/** GPIO pins connected to RES0 and RES1 lines. */
-	struct gpio_descs *resolution_gpios;
 	/** Used to access config registers. */
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long clkin_hz;
-	u8 resolution;
+	/** The selected resolution */
+	enum ad2s1210_resolution resolution;
 	/** For reading raw sample value via SPI. */
 	__be16 sample __aligned(IIO_DMA_MINALIGN);
 	/** SPI transmit buffer. */
@@ -212,62 +218,6 @@ static int ad2s1210_reinit_excitation_frequency(struct ad2s1210_state *st,
 	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
 
-static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
-					 u8 resolution)
-{
-	struct gpio_descs *gpios = st->resolution_gpios;
-	DECLARE_BITMAP(bitmap, 2);
-
-	bitmap[0] = (resolution - 10) >> 1;
-
-	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
-				     bitmap);
-}
-
-static ssize_t ad2s1210_show_resolution(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%d\n", st->resolution);
-}
-
-static ssize_t ad2s1210_store_resolution(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char data;
-	unsigned char udata;
-	int ret;
-
-	ret = kstrtou8(buf, 10, &udata);
-	if (ret || udata < 10 || udata > 16) {
-		dev_err(dev, "ad2s1210: resolution out of range\n");
-		return -EINVAL;
-	}
-
-	data = (udata - 10) >> 1;
-
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_SET_RES, data);
-	if (ret < 0)
-		goto error_ret;
-
-	ret = ad2s1210_set_resolution_gpios(st, udata);
-	if (ret < 0)
-		goto error_ret;
-
-	st->resolution = udata;
-	ret = len;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
 /* read the fault register since last sample */
 static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -572,8 +522,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static IIO_DEVICE_ATTR(bits, 0644,
-		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
@@ -628,7 +576,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
@@ -650,15 +597,12 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
-	if (ret < 0)
-		return ret;
 
 	/* Use default config register value plus resolution from devicetree. */
 	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
 	data |= FIELD_PREP(AD2S1210_ENABLE_HYSTERESIS, 1);
 	data |= FIELD_PREP(AD2S1210_SET_ENRES, 0x3);
-	data |= FIELD_PREP(AD2S1210_SET_RES, (st->resolution - 10) >> 1);
+	data |= FIELD_PREP(AD2S1210_SET_RES, st->resolution);
 
 	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
@@ -698,6 +642,26 @@ static const struct iio_info ad2s1210_info = {
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 
+static int ad2s1210_setup_properties(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"failed to read assigned-resolution-bits property\n");
+
+	if (val < 10 || val > 16)
+		return dev_err_probe(dev, -EINVAL,
+				     "resolution out of range: %u\n", val);
+
+	st->resolution = (val - 10) >> 1;
+
+	return 0;
+}
+
 static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
@@ -719,6 +683,9 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
+	struct gpio_descs *resolution_gpios;
+	DECLARE_BITMAP(bitmap, 2);
+	int ret;
 
 	/* should not be sampling on startup */
 	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
@@ -736,16 +703,32 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 		return dev_err_probe(dev, -EINVAL,
 				     "requires exactly 2 mode-gpios\n");
 
-	/* both pins high means that we start with 16-bit resolution */
-	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(st->resolution_gpios))
-		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
+	/*
+	 * If resolution gpios are provided, they get set to the required
+	 * resolution, otherwise it is assumed the RES0 and RES1 pins are
+	 * hard-wired to match the resolution indicated in the devicetree.
+	 */
+	resolution_gpios = devm_gpiod_get_array_optional(dev, "resolution",
+							 GPIOD_ASIS);
+	if (IS_ERR(resolution_gpios))
+		return dev_err_probe(dev, PTR_ERR(resolution_gpios),
 				     "failed to request resolution GPIOs\n");
 
-	if (st->resolution_gpios->ndescs != 2)
-		return dev_err_probe(dev, -EINVAL,
-				     "requires exactly 2 resolution-gpios\n");
+	if (resolution_gpios) {
+		if (resolution_gpios->ndescs != 2)
+			return dev_err_probe(dev, -EINVAL,
+				      "requires exactly 2 resolution-gpios\n");
+
+		bitmap[0] = st->resolution;
+
+		ret = gpiod_set_array_value(resolution_gpios->ndescs,
+					    resolution_gpios->desc,
+					    resolution_gpios->info,
+					    bitmap);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to set resolution gpios\n");
+	}
 
 	return 0;
 }
@@ -809,7 +792,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->resolution = 12;
+
+	ret = ad2s1210_setup_properties(st);
+	if (ret < 0)
+		return ret;
 
 	ret = ad2s1210_setup_clocks(st);
 	if (ret < 0)

-- 
2.42.0

