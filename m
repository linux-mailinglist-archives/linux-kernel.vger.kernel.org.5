Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01BC7A997E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjIUSP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjIUSPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:15:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AB4F938
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5041335fb9cso2098797e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316517; x=1695921317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phvZq4VpwSFX4vyqlS17/uN/agj73xAJlQboMqH0z3o=;
        b=2/w3DQTsFoE8IXVo9XvxrUBOP0vOKq3/Sd8VnK0Hz2RqkTqQAyNj0y68tmNEfowjak
         ZoNsGqeCVsRLyxEx6rUnU7iWOwHle3SGScIb1ZtPsZxHr5tGcMB/WFlkIoVhItM6lHqF
         7mMP6XnWKnubvv1qBqNpnDpDISd7BqkfWIzETAOOx2aNZvMp7ali3Rwq4jFHqan+s4/o
         7GnxqdDTfpfDqjk2s4HUsQjfZrC9s0KvK4gjEZdNAjJCtrIgwV6Px0+k+gV50Xcj0I0+
         6KlOcDHzhNBO3d4OZLd3P5s/W3FWc63EdUYC13btf8IYlS+ESERwND9I5DpjS/RyCTR8
         /hoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316517; x=1695921317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phvZq4VpwSFX4vyqlS17/uN/agj73xAJlQboMqH0z3o=;
        b=nT5xfYcmY0pXys1BN/IlBTjyxRyCWZ7bq3248jtlV/OsUd3Yal4veIb9EFJlCK+CUC
         R3drd48CoN3L0DP381LMsancXvAsRbwIeoGstzq1ZzVjVqnFRf38WelDcvnmdksHMv8W
         D1OgXIEXgg9eOwhHnBMP1l/1n/+JN9rgHDZ2/6ACH4WasjYGlTJgnh/f4oBgFjiAtpv5
         Ph4Nj5jl68H2/J25MhdCJRVeUDeYZ56RtFEpo6kvODyqLWMSsX+xaJAirtwQFUrAQypU
         HL1/l6tJUXWjnn0WbRSeQGEorrmbJtGGHP7eBIpugKrrnc6XXEmHe4TQNpk9CqQflFrJ
         cAYQ==
X-Gm-Message-State: AOJu0Yw0DTVUhe99tcP1/TsHrvkQsLQbBOn6sCqB2pfNZEAL74uk4z0+
        De87JVyrL/dkCKrbZOgQ1j1jInMcyvpWYkqxFDmKxHVQ
X-Google-Smtp-Source: AGHT+IFPxpl1mL31xHJRVnXCLfFPLtUCE+7JOw2swmApi7DrJQIpgim9CNysuQqHjc696HN9aqGOFA==
X-Received: by 2002:adf:fdc3:0:b0:321:6388:bccb with SMTP id i3-20020adffdc3000000b003216388bccbmr4781473wrs.21.1695306159013;
        Thu, 21 Sep 2023 07:22:39 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:38 -0700 (PDT)
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
Subject: [v2 08/19] staging: iio: resolver: ad2s1210: use devicetree to get fclkin
Date:   Thu, 21 Sep 2023 09:19:36 -0500
Message-Id: <20230921141947.57784-11-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
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

This removes the fclkin sysfs attribute and replaces it with getting
the fclkin clock rate using the clk subsystem (i.e. from the
devicetree).

The fclkin clock comes from an external oscillator that is connected
directly to the AD2S1210 chip, so users of the sysfs attributes should
not need to be concerned with this.

Also sort includes while we are touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/Kconfig    |  1 +
 drivers/staging/iio/resolver/ad2s1210.c | 76 +++++++++----------------
 2 files changed, 28 insertions(+), 49 deletions(-)

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
index 95d43b241a75..153ac7704ad7 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -5,16 +5,17 @@
  * Copyright (c) 2010-2010 Analog Devices Inc.
  * Copyright (C) 2023 BayLibre, SAS
  */
-#include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sysfs.h>
-#include <linux/delay.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -91,7 +92,8 @@ struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
-	unsigned int fclkin;
+	/** The external oscillator frequency in Hz. */
+	unsigned long fclkin;
 	unsigned int fexcit;
 	bool hysteresis;
 	u8 resolution;
@@ -198,45 +200,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
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
@@ -546,8 +509,6 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, 0644,
-		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
 static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
 static IIO_DEVICE_ATTR(control, 0644,
@@ -596,7 +557,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
@@ -654,6 +614,24 @@ static const struct iio_info ad2s1210_info = {
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
+	st->fclkin = clk_get_rate(clk);
+	if (st->fclkin < AD2S1210_MIN_CLKIN || st->fclkin > AD2S1210_MAX_CLKIN)
+		return dev_err_probe(dev, -EINVAL,
+				     "clock frequency out of range: %lu\n",
+				     st->fclkin);
+
+	return 0;
+}
+
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct spi_device *spi = st->sdev;
-- 
2.34.1

