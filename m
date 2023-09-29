Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632C47B38DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjI2R0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjI2R0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:13 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041F5CC3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57b706f604aso7021454eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008355; x=1696613155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TP9/9l8r7A/7YK4CeZUwHw6ehtttSEiRW2pyIK4E0Iw=;
        b=K6XJ0uLn9G1qxtN3ZoAvQ+IthAkxFKgPL6Daz7WP1BETxBSdPvndNxu63e8K2NanHb
         E1WBFOQ22711PdNUIQVmgWVjWMUdHM4+TFLtJwbW2fCdySCF2Buoq1KxtVKUsETW1vUO
         gO6G8Yahi9jh2M5GOXsWdJ8NY+EqJs5sX4HlcTFM0eFSX7ILd9qottc6S7yMPYZUEQ6F
         3K5Kota2p+THAWs9tkUO9VbULge/Ugt69D1WY68rWgmW5nfRIYbHDmv8dgI4mhftdzmO
         hzhREh5pqIKIAecgL9piYTkAZ+AAfEREScLuvoTtBBImwryjFmE8OjrFyqDGnoGYBpnl
         0Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008355; x=1696613155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP9/9l8r7A/7YK4CeZUwHw6ehtttSEiRW2pyIK4E0Iw=;
        b=oKFfL97MxPz8LEXD4xt8U2omDi1EQrEZ52hP/ChHjiGDDpccOvvcRaZnVlEikw7H4j
         OAn6WQixnbMpXbQjNN1u1vtjwQ2l8tvakj6AGDyRR5lGitW9T2DBGrYgHSFGfSuGlmwE
         7JeGFKlC9hHbbw0SbILO1K7lU0WH+G3VQEGpKAU05RxD3Y8vtsuDM/UDnAWlV6ScPHqO
         xg3Gd2iQRfrUWnuOtgTTYliylYIZvTmVQkm4PMC0xWto9ad4t8va+k2tsXUGTEiXaK1W
         VNS8soR0bUCPmToF+ThQyfii/WhUzXEnSbhhoHR4dDOloVD4Lj4wOR37ONBzxJZYb1aR
         9pRA==
X-Gm-Message-State: AOJu0YwZOd5cxurGxU+JAttzGRGNfTmC8r+QwjXkYj1ucRABI645XED0
        F8YrsZBtXmtOQ5hWCU8nabySUVLo9i9IQVG2pYHsCQ==
X-Google-Smtp-Source: AGHT+IEV6omc1a2r/pRn4nd4/1MmdF05dK/YzlDdSJixR5lzLDsnSoVpgKImTCnKRUYsCweCu9h34Q==
X-Received: by 2002:a4a:3948:0:b0:57b:3424:147f with SMTP id x8-20020a4a3948000000b0057b3424147fmr4627779oog.9.1696008355031;
        Fri, 29 Sep 2023 10:25:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:54 -0700 (PDT)
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
Subject: [PATCH v3 09/27] staging: iio: resolver: ad2s1210: use devicetree to get CLKIN rate
Date:   Fri, 29 Sep 2023 12:23:14 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-9-fa4364281745@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

From: David Lechner <dlechner@baylibre.com>

This removes the fclkin sysfs attribute and replaces it with getting
the CLKIN clock rate using the clk subsystem (i.e. from the devicetree).

CLKIN comes from an external oscillator that is connected directly to
the AD2S1210 chip, so users of the sysfs attributes should not need to
be concerned with this.

The fclkin field (the datasheet name) is renamed to clkin_hz to be more
obvious that it is a frequency in Hz.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Don't sort imports in this patch.
* Renamed fexcit to clkin_hz.
* Fixed ad2s1210_setup_clocks() being called in an earlier patch.

 drivers/staging/iio/resolver/Kconfig    |  1 +
 drivers/staging/iio/resolver/ad2s1210.c | 81 ++++++++++++---------------------
 2 files changed, 30 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6d1e2622e0b0..bebb35822c9e 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -7,6 +7,7 @@ menu "Resolver to digital converters"
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
+	depends on COMMON_CLK
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say yes here to build support for Analog Devices spi resolver
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index a710598a64f0..c8723b6f3a3b 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -3,7 +3,9 @@
  * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
+ * Copyright (c) 2023 BayLibre, SAS
  */
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -90,7 +92,8 @@ struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
-	unsigned int fclkin;
+	/** The external oscillator frequency in Hz. */
+	unsigned long clkin_hz;
 	unsigned int fexcit;
 	bool hysteresis;
 	u8 resolution;
@@ -165,7 +168,7 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 	int ret;
 	unsigned char fcw;
 
-	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->fclkin);
+	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->clkin_hz);
 	if (fcw < AD2S1210_MIN_FCW || fcw > AD2S1210_MAX_FCW) {
 		dev_err(&st->sdev->dev, "ad2s1210: FCW out of range\n");
 		return -ERANGE;
@@ -201,45 +204,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_show_fclkin(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%u\n", st->fclkin);
-}
-
-static ssize_t ad2s1210_store_fclkin(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned int fclkin;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &fclkin);
-	if (ret)
-		return ret;
-	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
-		dev_err(dev, "ad2s1210: fclkin out of range\n");
-		return -EINVAL;
-	}
-
-	mutex_lock(&st->lock);
-	st->fclkin = fclkin;
-
-	ret = ad2s1210_update_frequency_control_word(st);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_soft_reset(st);
-error_ret:
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
 static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -537,7 +501,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			*val2 = 95874;
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_ANGL_VEL:
-			*val = st->fclkin;
+			*val = st->clkin_hz;
 			*val2 = ad2s1210_velocity_scale[st->resolution];
 			return IIO_VAL_FRACTIONAL;
 		default:
@@ -549,8 +513,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(control, 0644,
@@ -599,7 +561,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
@@ -657,6 +618,24 @@ static const struct iio_info ad2s1210_info = {
 	.attrs = &ad2s1210_attribute_group,
 };
 
+static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	struct clk *clk;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	st->clkin_hz = clk_get_rate(clk);
+	if (st->clkin_hz < AD2S1210_MIN_CLKIN || st->clkin_hz > AD2S1210_MAX_CLKIN)
+		return dev_err_probe(dev, -EINVAL,
+				     "clock frequency out of range: %lu\n",
+				     st->clkin_hz);
+
+	return 0;
+}
+
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct spi_device *spi = st->sdev;
@@ -695,6 +674,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	st->resolution = 12;
 	st->fexcit = AD2S1210_DEF_EXCIT;
 
+	ret = ad2s1210_setup_clocks(st);
+	if (ret < 0)
+		return ret;
+
 	ret = ad2s1210_setup_gpios(st);
 	if (ret < 0)
 		return ret;
@@ -709,13 +692,7 @@ static int ad2s1210_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
-	st->fclkin = spi->max_speed_hz;
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id ad2s1210_of_match[] = {

-- 
2.42.0

