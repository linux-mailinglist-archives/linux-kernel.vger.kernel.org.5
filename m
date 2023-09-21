Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073BC7A9880
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjIURs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIURsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:48:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D676AC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:31:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404fbfac998so14316905e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317454; x=1695922254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSzhqtQuH6rCmKnaqNrN1q0TijVTu8SKnjt98b8WvE0=;
        b=BWZ6pp8L5dlNJMOCLX7qz8iHI85oVrNy2iUdNc/Nsqs3j15b41EYuhd9OMYr3PMv+N
         TGHWZb1GV8ZgSLcnHJj9p/5iUqZKBPVQaKEv6Jinok8uEZAaUc2GC9niVP5Fy8oHFGID
         mHitnZDtImrKGGqmuB9bjSK+BPrYzwu/gtChlWCjahvToTPAWuzfDePZJK8COhHSdb2f
         lLEGyWi0S3DdTsXLr6c1IS1jEBSlUo05JWM8zYP0dK3/BzAEbmduqIbPFBZTDj6I/61D
         nwvjNgxkV/z/hyv3TTCm9+HCkXeJJ5R+bpsywmTuBSKDYhPq1+99i5jDnV3nUnH/JXrr
         snug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317454; x=1695922254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSzhqtQuH6rCmKnaqNrN1q0TijVTu8SKnjt98b8WvE0=;
        b=SPddoW1w4I4o5DuHn85pXIm0x8LWn+52X+xuzquiRTYm+Z86GOLIP+G1TUZNP2yi51
         6ZEKDn8dKxwYNvzosBM5r1sP3H4oAIGNE3dbXTdvKuZjV6jcOm9xEcBLPwxmUaVZQl8E
         iSjMaQgbANqigFq4csq6M6KVk0B3lzHMBHy7blfNCA+IFuMlO5vF1nvNr9CTwk2XoZpp
         PXeLgBC8p1lSk2TH4qBg4gaoymnqLm1godicWLRgujN7f6ecuTjI6m82e2uqeW7IvQnP
         nLOtdIuHZUqw372IOxktmbfefqlon41zVR3noojvImJCE14R+bKzN8LS92I7sPAHzvx1
         EDnQ==
X-Gm-Message-State: AOJu0YwUNRseqEcNHpZ5XcIJKO1YicJ1QAn1OK9GqgNHjJnFVCGG0dCc
        4LtuixbrBvRoJqzyMDvUj/LEObg+Ng65GPQd6WoIZO49
X-Google-Smtp-Source: AGHT+IFP4MOcE7E2V9WBBp93krIW5ELA1JqtXyr+E6QkCDPSXWbGg/ybS0qM51T45avLvC8CEMIykQ==
X-Received: by 2002:a1c:f204:0:b0:404:fc5c:15ed with SMTP id s4-20020a1cf204000000b00404fc5c15edmr4949109wmc.35.1695306167586;
        Thu, 21 Sep 2023 07:22:47 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:47 -0700 (PDT)
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
Subject: [v2 17/19] staging: iio: resolver: ad2s1210: convert resolution to devicetree property
Date:   Thu, 21 Sep 2023 09:19:45 -0500
Message-Id: <20230921141947.57784-20-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/staging/iio/resolver/ad2s1210.c | 136 +++++++++++-------------
 1 file changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 14bec2b20939..71f0913b7e2e 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -65,6 +65,13 @@ enum ad2s1210_mode {
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
@@ -72,13 +79,12 @@ struct ad2s1210_state {
 	struct gpio_desc *sample_gpio;
 	/** GPIO pins connected to A0 and A1 lines. */
 	struct gpio_descs *mode_gpios;
-	/** GPIO pins connected to RES0 and RES1 lines. */
-	struct gpio_descs *resolution_gpios;
 	/** Used to access config registers. */
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
-	u8 resolution;
+	/** The selected resolution */
+	enum ad2s1210_resolution resolution;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
 };
@@ -205,18 +211,6 @@ static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
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
 static ssize_t excitation_frequency_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -265,50 +259,6 @@ static ssize_t excitation_frequency_store(struct device *dev,
 	return ret;
 }
 
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
@@ -556,8 +506,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
-static IIO_DEVICE_ATTR(bits, 0644,
-		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
@@ -604,7 +552,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_excitation_frequency.dev_attr.attr,
-	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
@@ -626,12 +573,10 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
-	if (ret < 0)
-		return ret;
 
 	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;
-	data |= (st->resolution - 10) >> 1;
+	data |= st->resolution;
+
 	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
 		goto error_ret;
@@ -670,6 +615,26 @@ static const struct iio_info ad2s1210_info = {
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
@@ -691,6 +656,9 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
+	struct gpio_descs *resolution_gpios;
+	DECLARE_BITMAP(bitmap, 2);
+	int ret;
 
 	/* should not be sampling on startup */
 	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
@@ -708,16 +676,31 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 		return dev_err_probe(dev, -EINVAL,
 				     "requires exactly 2 mode-gpios\n");
 
-	/* both pins high means that we start with 16-bit resolution */
-	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(st->resolution_gpios))
-		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
+	/* If resolution gpios are provided, they get set to the required
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
@@ -782,7 +765,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 
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
2.34.1

