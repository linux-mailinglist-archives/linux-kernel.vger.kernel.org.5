Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEB97B3927
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjI2R00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjI2R0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:26:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D31CC7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so8157087a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696008356; x=1696613156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1fLFhvAvCLt9FeuapFN2MCx0BBCh3HJRQ9JlJc1Gac=;
        b=g9yaGIS6vBjp/4r8WVn/slyTAnoyeKFDeTCIdix2eMvv0+R8TINsUpaT8pHrMGDqGC
         3cTog2MDw+9FtB6jDVqkjBwczH7zg5XrhRt1uSvpbV7gYuhsZkTrEOloWI7tLE5G6/IM
         28OgBb58KvtEHEWnoDhZvR9J6NYZD3kb+dO6EjpnF/ene0QYrxslyFaIQhCWmTdskz2y
         pUUu9Gqx+wmmNXWn2wDLuXIW9Q81lyb5LX/Y1Y004imItxhx6VRae/zPJyM9oIgKe6z1
         l/JuYJn8871g08tHCw4fzZgBeJ5fftJmSAVUbSBbNzqfuIZhoeVGlyxaSMSnRo1YOVEe
         3rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008356; x=1696613156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1fLFhvAvCLt9FeuapFN2MCx0BBCh3HJRQ9JlJc1Gac=;
        b=A1FiY74ytu6dpDYUQ/fgYEF0tcNuHXAnR3LrQPgWBKBST8n093wj7jz3fsNil2wE3p
         K1dLXa1BMpgZwQr5jx39ULor5hzuboBv45t0qHgzOcblaF43q5s58qnog2olka4CSKjP
         CMobGNHsSpTcRUDsIVEP6F3zo+XgKv2EP4RlXt6dHzRy4+eDpDJwG9LaT6koiRYraYi+
         fvtwQGJkugxeo4UzceYIxBYpTPbWQm8n2dVZb8itap7XY2UQctZuURuV8Dt6w7rNBK47
         wTipnzs6D0Sa8LQkw41oJ3IztHbaVTXvNFfATxCGnzbmS9V9hyU40PnAYZm+/J850QjE
         Un9Q==
X-Gm-Message-State: AOJu0Yy+NYcYWnRUqOrseoa6vrZ5YXVMqfC+l5/jIEw0FYtPpLAfdUsh
        P4jZH95U2Z6QD6uofl399gqtwQ==
X-Google-Smtp-Source: AGHT+IHMcnqbKaDTt6uivtIpVlrWpwNLWzFA3iMJ7cfs4ow/e+4CIxMXN8XvUCIJ2mpQbTQh+veZ3A==
X-Received: by 2002:a05:6830:1e25:b0:6be:fe1e:c13 with SMTP id t5-20020a0568301e2500b006befe1e0c13mr5058291otr.0.1696008356003;
        Fri, 29 Sep 2023 10:25:56 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f128-20020a4a5886000000b0057bb326cad4sm2272915oob.33.2023.09.29.10.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:25:55 -0700 (PDT)
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
Subject: [PATCH v3 10/27] staging: iio: resolver: ad2s1210: use regmap for config registers
Date:   Fri, 29 Sep 2023 12:23:15 -0500
Message-ID: <20230929-ad2s1210-mainline-v3-10-fa4364281745@baylibre.com>
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

This makes use of the regmap API to read and write the configuration
registers. This simplifies code quite a bit and makes it safer
(previously, it was easy to write a bad value to the config registers
which causes the chip to lock up and need to be reset).

This chip has multiple modes of operation. In normal mode, we do not use
regmap since there is no addressing - data is just bitshifted out during
the SPI read. In config mode, we use regmap since it requires writing
the address (with read/write flag) before reading and writing.

We don't use the lock provided by the regmap because we need to also
synchronize with the normal mode SPI reads and with the various GPIOs.

There is also a quirk when reading registers (other than the fault
register). If the address/data bit is set in the value read, then it
indicates there is a configuration parity error and the data is not
valid. Previously, this was checked in a few places, but not
consistently. Now, we always check it in the regmap read function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* Expanded description in commit message.
* Fixed multiline comment style.
* Replaced use of AD2S1210_DEF_CONTROL with FIELD_PREP().
* Removed unrelated `if (reg < 0)` change.

 drivers/staging/iio/resolver/ad2s1210.c | 259 +++++++++++++++++++-------------
 1 file changed, 155 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c8723b6f3a3b..0663a51d04ad 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2010-2010 Analog Devices Inc.
  * Copyright (c) 2023 BayLibre, SAS
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -12,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
@@ -22,21 +25,17 @@
 
 #define DRV_NAME "ad2s1210"
 
-#define AD2S1210_DEF_CONTROL		0x7E
-
-#define AD2S1210_MSB_IS_HIGH		0x80
-#define AD2S1210_MSB_IS_LOW		0x7F
-#define AD2S1210_PHASE_LOCK_RANGE_44	0x20
-#define AD2S1210_ENABLE_HYSTERESIS	0x10
-#define AD2S1210_SET_ENRES1		0x08
-#define AD2S1210_SET_ENRES0		0x04
-#define AD2S1210_SET_RES1		0x02
-#define AD2S1210_SET_RES0		0x01
-
-#define AD2S1210_SET_RESOLUTION		(AD2S1210_SET_RES1 | AD2S1210_SET_RES0)
-
-#define AD2S1210_REG_POSITION		0x80
-#define AD2S1210_REG_VELOCITY		0x82
+/* control register flags */
+#define AD2S1210_ADDRESS_DATA		BIT(7)
+#define AD2S1210_PHASE_LOCK_RANGE_44	BIT(5)
+#define AD2S1210_ENABLE_HYSTERESIS	BIT(4)
+#define AD2S1210_SET_ENRES		GENMASK(3, 2)
+#define AD2S1210_SET_RES		GENMASK(1, 0)
+
+#define AD2S1210_REG_POSITION_MSB	0x80
+#define AD2S1210_REG_POSITION_LSB	0x81
+#define AD2S1210_REG_VELOCITY_MSB	0x82
+#define AD2S1210_REG_VELOCITY_LSB	0x83
 #define AD2S1210_REG_LOS_THRD		0x88
 #define AD2S1210_REG_DOS_OVR_THRD	0x89
 #define AD2S1210_REG_DOS_MIS_THRD	0x8A
@@ -92,6 +91,8 @@ struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
 	struct gpio_desc *gpios[5];
+	/** Used to access config registers. */
+	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long clkin_hz;
 	unsigned int fexcit;
@@ -120,24 +121,51 @@ static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
 	st->mode = mode;
 }
 
-/* write 1 bytes (address or data) to the chip */
-static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
+/*
+ * Writes the given data to the given register address.
+ *
+ * If the mode is configurable, the device will first be placed in
+ * configuration mode.
+ */
+static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
+				     unsigned int val)
 {
-	int ret;
+	struct ad2s1210_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.len = 1,
+			.rx_buf = &st->rx[0],
+			.tx_buf = &st->tx[0],
+			.cs_change = 1,
+		}, {
+			.len = 1,
+			.rx_buf = &st->rx[1],
+			.tx_buf = &st->tx[1],
+		},
+	};
+
+	/* values can only be 7 bits, the MSB indicates an address */
+	if (val & ~0x7F)
+		return -EINVAL;
+
+	st->tx[0] = reg;
+	st->tx[1] = val;
 
 	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = data;
-	ret = spi_write(st->sdev, st->tx, 1);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 }
 
-/* read value from one of the registers */
-static int ad2s1210_config_read(struct ad2s1210_state *st,
-				unsigned char address)
+/*
+ * Reads value from one of the registers.
+ *
+ * If the mode is configurable, the device will first be placed in
+ * configuration mode.
+ */
+static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
+				    unsigned int *val)
 {
+	struct ad2s1210_state *st = context;
 	struct spi_transfer xfers[] = {
 		{
 			.len = 1,
@@ -150,22 +178,36 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
 			.tx_buf = &st->tx[1],
 		},
 	};
-	int ret = 0;
+	int ret;
 
 	ad2s1210_set_mode(MOD_CONFIG, st);
-	st->tx[0] = address | AD2S1210_MSB_IS_HIGH;
+	st->tx[0] = reg;
+	/*
+	 * Must be valid register address here otherwise this could write data.
+	 * It doesn't matter which one.
+	 */
 	st->tx[1] = AD2S1210_REG_FAULT;
-	ret = spi_sync_transfer(st->sdev, xfers, 2);
+
+	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
 	if (ret < 0)
 		return ret;
 
-	return st->rx[1];
+	/*
+	 * If the D7 bit is set on any read/write register, it indicates a
+	 * parity error. The fault register is read-only and the D7 bit means
+	 * something else there.
+	 */
+	if (reg != AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
+		return -EBADMSG;
+
+	*val = st->rx[1];
+
+	return 0;
 }
 
 static inline
 int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 {
-	int ret;
 	unsigned char fcw;
 
 	fcw = (unsigned char)(st->fexcit * (1 << 15) / st->clkin_hz);
@@ -174,11 +216,7 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
 		return -ERANGE;
 	}
 
-	ret = ad2s1210_config_write(st, AD2S1210_REG_EXCIT_FREQ);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, fcw);
+	return regmap_write(st->regmap, AD2S1210_REG_EXCIT_FREQ, fcw);
 }
 
 static const int ad2s1210_res_pins[4][2] = {
@@ -195,13 +233,7 @@ static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
 
 static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 {
-	int ret;
-
-	ret = ad2s1210_config_write(st, AD2S1210_REG_SOFT_RESET);
-	if (ret < 0)
-		return ret;
-
-	return ad2s1210_config_write(st, 0x0);
+	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
 
 static ssize_t ad2s1210_show_fexcit(struct device *dev,
@@ -246,12 +278,13 @@ static ssize_t ad2s1210_show_control(struct device *dev,
 				     char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
+	ret = regmap_read(st->regmap, AD2S1210_REG_CONTROL, &value);
 	mutex_unlock(&st->lock);
-	return ret < 0 ? ret : sprintf(buf, "0x%x\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "0x%x\n", value);
 }
 
 static ssize_t ad2s1210_store_control(struct device *dev,
@@ -268,25 +301,13 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = udata & AD2S1210_MSB_IS_LOW;
-	ret = ad2s1210_config_write(st, data);
+	data = udata & ~AD2S1210_ADDRESS_DATA;
+	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
 		goto error_ret;
 
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev,
-			"ad2s1210: write control register fail\n");
-		goto error_ret;
-	}
 	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
 	ad2s1210_set_resolution_pin(st);
 	ret = len;
 	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
@@ -319,30 +340,17 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 		dev_err(dev, "ad2s1210: resolution out of range\n");
 		return -EINVAL;
 	}
+
+	data = (udata - 10) >> 1;
+
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = ret;
-	data &= ~AD2S1210_SET_RESOLUTION;
-	data |= (udata - 10) >> 1;
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
+	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
+				 AD2S1210_SET_RES, data);
 	if (ret < 0)
 		goto error_ret;
-	data = ret;
-	if (data & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
-		dev_err(dev, "ad2s1210: setting resolution fail\n");
-		goto error_ret;
-	}
+
 	st->resolution =
-		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
 	ad2s1210_set_resolution_pin(st);
 	ret = len;
 error_ret:
@@ -355,13 +363,14 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
+	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
 	mutex_unlock(&st->lock);
 
-	return ret < 0 ? ret : sprintf(buf, "0x%02x\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "0x%02x\n", value);
 }
 
 static ssize_t ad2s1210_clear_fault(struct device *dev,
@@ -370,6 +379,7 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 				    size_t len)
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -377,7 +387,7 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
-	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
+	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
 	if (ret < 0)
 		goto error_ret;
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
@@ -394,13 +404,14 @@ static ssize_t ad2s1210_show_reg(struct device *dev,
 {
 	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	unsigned int value;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_read(st, iattr->address);
+	ret = regmap_read(st->regmap, iattr->address, &value);
 	mutex_unlock(&st->lock);
 
-	return ret < 0 ? ret : sprintf(buf, "%d\n", ret);
+	return ret < 0 ? ret : sprintf(buf, "%d\n", value);
 }
 
 static ssize_t ad2s1210_store_reg(struct device *dev,
@@ -415,12 +426,9 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
 	ret = kstrtou8(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
+
 	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, iattr->address);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
-error_ret:
+	ret = regmap_write(st->regmap, iattr->address, data);
 	mutex_unlock(&st->lock);
 	return ret < 0 ? ret : len;
 }
@@ -587,22 +595,15 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	mutex_lock(&st->lock);
 	ad2s1210_set_resolution_pin(st);
 
-	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
-	data = AD2S1210_DEF_CONTROL & ~(AD2S1210_SET_RESOLUTION);
-	data |= (st->resolution - 10) >> 1;
-	ret = ad2s1210_config_write(st, data);
-	if (ret < 0)
-		goto error_ret;
-	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
-	if (ret < 0)
-		goto error_ret;
+	/* Use default config register value plus resolution from devicetree. */
+	data = FIELD_PREP(AD2S1210_PHASE_LOCK_RANGE_44, 1);
+	data |= FIELD_PREP(AD2S1210_ENABLE_HYSTERESIS, 1);
+	data |= FIELD_PREP(AD2S1210_SET_ENRES, 0x3);
+	data |= FIELD_PREP(AD2S1210_SET_RES, (st->resolution - 10) >> 1);
 
-	if (ret & AD2S1210_MSB_IS_HIGH) {
-		ret = -EIO;
+	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
+	if (ret < 0)
 		goto error_ret;
-	}
 
 	ret = ad2s1210_update_frequency_control_word(st);
 	if (ret < 0)
@@ -656,6 +657,52 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 	return 0;
 }
 
+static const struct regmap_range ad2s1210_regmap_readable_ranges[] = {
+	regmap_reg_range(AD2S1210_REG_POSITION_MSB, AD2S1210_REG_VELOCITY_LSB),
+	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
+	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
+	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
+};
+
+static const struct regmap_access_table ad2s1210_regmap_rd_table = {
+	.yes_ranges = ad2s1210_regmap_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_readable_ranges),
+};
+
+static const struct regmap_range ad2s1210_regmap_writeable_ranges[] = {
+	regmap_reg_range(AD2S1210_REG_LOS_THRD, AD2S1210_REG_LOT_LOW_THRD),
+	regmap_reg_range(AD2S1210_REG_EXCIT_FREQ, AD2S1210_REG_CONTROL),
+	regmap_reg_range(AD2S1210_REG_SOFT_RESET, AD2S1210_REG_SOFT_RESET),
+	regmap_reg_range(AD2S1210_REG_FAULT, AD2S1210_REG_FAULT),
+};
+
+static const struct regmap_access_table ad2s1210_regmap_wr_table = {
+	.yes_ranges = ad2s1210_regmap_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad2s1210_regmap_writeable_ranges),
+};
+
+static int ad2s1210_setup_regmap(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	const struct regmap_config config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+		.disable_locking = true,
+		.reg_read = ad2s1210_regmap_reg_read,
+		.reg_write = ad2s1210_regmap_reg_write,
+		.rd_table = &ad2s1210_regmap_rd_table,
+		.wr_table = &ad2s1210_regmap_wr_table,
+		.can_sleep = true,
+	};
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "failed to allocate register map\n");
+
+	return 0;
+}
+
 static int ad2s1210_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -682,6 +729,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = ad2s1210_setup_regmap(st);
+	if (ret < 0)
+		return ret;
+
 	ret = ad2s1210_initial(st);
 	if (ret < 0)
 		return ret;

-- 
2.42.0

