Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBFD7A2FAD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjIPLVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjIPLUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:20:49 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B3199
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:20:43 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44ea1f87427so1319066137.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694863243; x=1695468043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wx1mJktLlGi9doqDMud3XUtJkccHnYdBYJ5bUZM5krg=;
        b=hIekEfDRyXwiFgmVWmdC7uSfwFVVWQFOL4Pd7AuOgRzfYU60Srwu4r7zcJTbP5Wd26
         ebkX1QWYMc4XQNymRFWKtywynvhmwKcTDxBZBOkcxgJQAiWLzaXUoIS+Rk28rqlupMwZ
         2PIMEBN2VVSV3kOvKsqQMPd9MUz0e4/VBccYh4cmF6GBpwb/tz69RO6OMdwiQdFw6hk3
         hCILJay8ATk2PxuTNRxzyr6cgqQZJClY5ETJqaQZ4piCiYh44ho6fk/n2xJBYcevHSo4
         kPcymvwzb7TnKHXEIRi88JpJQhBTDe9Cvm9M4QUoK6s7QRIAKLxlv/DPF54e3qMXns8d
         8zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694863243; x=1695468043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wx1mJktLlGi9doqDMud3XUtJkccHnYdBYJ5bUZM5krg=;
        b=n3nR0/3OH9cw0IyxsiPD+kzbVOM2bL5yh5dB76mKetnrvkrg3VPYunYdv+Tce7yZ+b
         2fFT4XKCByYTwPVR9F2r9H4+BVCHfG5Vl7bG80gV+CPxxMI/FYENln1FFPU/advDcQpv
         EEtGnxETP4NYBfpjuKRNbyE16nD1l+I4IA4cYi1wP3gcBgw6Kv7wAC9Ay5N+Fpp2qy5U
         xBlMD6BBN3sgLaXv5rUT8RPcGoIqBCBnGhaK4FJyfqkEWvFsQNcbL/o5W7ZL6idEUpWm
         QMImW0XoLZFMRhLmw4zsNRvmUhBzCWDnPN1WgjsP+kZcL7qclTR66+VAYTHmMfvMXswZ
         Y7bA==
X-Gm-Message-State: AOJu0YyojfJKW2fC7nzNu2NoIBG1GVeT1/2S9Xk2f1NTMalfGbZltE4a
        V6gP0RCjNA7XmD870d+e6na9vd1BroEs+cT0oag=
X-Google-Smtp-Source: AGHT+IEgoVmh83TRBPeUNUgrx0amBFL2ejoRJfyxpKwAxPrVjxedOqhzlp3kd0dU9f0mWfGWK+zf4Q==
X-Received: by 2002:a05:6102:34d8:b0:450:c5e4:4869 with SMTP id a24-20020a05610234d800b00450c5e44869mr3639165vst.25.1694863242801;
        Sat, 16 Sep 2023 04:20:42 -0700 (PDT)
Received: from fedora.. (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id f30-20020ab0101e000000b004089cee1d28sm788352uab.1.2023.09.16.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 04:20:42 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RESEND PATCH] iio: addac: stx104: Add 8254 Counter/Timer support
Date:   Sat, 16 Sep 2023 07:20:31 -0400
Message-ID: <20230916112031.3634-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STX104 features an 8254 Counter/Timer chip providing three
counter/timers which can be used for frequency measurement, frequency
output, pulse width modulation, pulse width measurement, event count,
etc. The STX104 provides a register bank selection to bank select
between the 8254 Bank and the Indexed Register Array Bank; the Indexed
Register Array is not utilized by this driver, so the 8254 Bank is
selected unconditionally.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Looks like this was missed in the last merge cycle, so I'm resending it
now as requested. [^1]

[^1]: https://lore.kernel.org/all/ZJoO++gEMiDsZioz@fedora/

 drivers/iio/addac/Kconfig  |  1 +
 drivers/iio/addac/stx104.c | 61 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 877f9124803c..b2623881f0ec 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -38,6 +38,7 @@ config STX104
 	select REGMAP_MMIO
 	select GPIOLIB
 	select GPIO_REGMAP
+	select I8254
 	help
 	  Say yes here to build support for the Apex Embedded Systems STX104
 	  integrated analog PC/104 card.
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index d1f7ce033b46..6946a65512ca 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/regmap.h>
+#include <linux/i8254.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/isa.h>
@@ -55,6 +56,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 #define STX104_ADC_STATUS (STX104_AIO_BASE + 0x8)
 #define STX104_ADC_CONTROL (STX104_AIO_BASE + 0x9)
 #define STX104_ADC_CONFIGURATION (STX104_AIO_BASE + 0x11)
+#define STX104_I8254_BASE (STX104_AIO_BASE + 0x12)
 
 #define STX104_AIO_DATA_STRIDE 2
 #define STX104_DAC_OFFSET(_channel) (STX104_DAC_BASE + STX104_AIO_DATA_STRIDE * (_channel))
@@ -77,6 +79,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 /* ADC Configuration */
 #define STX104_GAIN GENMASK(1, 0)
 #define STX104_ADBU BIT(2)
+#define STX104_RBK GENMASK(7, 4)
 #define STX104_BIPOLAR 0
 #define STX104_GAIN_X1 0
 #define STX104_GAIN_X2 1
@@ -168,6 +171,32 @@ static const struct regmap_config dio_regmap_config = {
 	.io_port = true,
 };
 
+static const struct regmap_range pit_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x3),
+};
+static const struct regmap_range pit_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2),
+};
+static const struct regmap_access_table pit_wr_table = {
+	.yes_ranges = pit_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_wr_ranges),
+};
+static const struct regmap_access_table pit_rd_table = {
+	.yes_ranges = pit_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_rd_ranges),
+};
+
+static const struct regmap_config pit_regmap_config = {
+	.name = "i8254",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.reg_base = STX104_I8254_BASE,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &pit_wr_table,
+	.rd_table = &pit_rd_table,
+};
+
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -339,6 +368,21 @@ static const char *stx104_names[STX104_NGPIO] = {
 	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
 };
 
+static int bank_select_i8254(struct regmap *map)
+{
+	const u8 select_i8254[] = { 0x3, 0xB, 0xA };
+	size_t i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(select_i8254); i++) {
+		err = regmap_write_bits(map, STX104_ADC_CONFIGURATION, STX104_RBK, select_i8254[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int stx104_init_hw(struct stx104_iio *const priv)
 {
 	int err;
@@ -361,7 +405,7 @@ static int stx104_init_hw(struct stx104_iio *const priv)
 	if (err)
 		return err;
 
-	return 0;
+	return bank_select_i8254(priv->aio_ctl_map);
 }
 
 static int stx104_probe(struct device *dev, unsigned int id)
@@ -369,6 +413,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
 	struct gpio_regmap_config gpio_config;
+	struct i8254_regmap_config pit_config;
 	void __iomem *stx104_base;
 	struct regmap *aio_ctl_map;
 	struct regmap *aio_data_map;
@@ -406,6 +451,11 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return dev_err_probe(dev, PTR_ERR(dio_map),
 				     "Unable to initialize dio register map\n");
 
+	pit_config.map = devm_regmap_init_mmio(dev, stx104_base, &pit_regmap_config);
+	if (IS_ERR(pit_config.map))
+		return dev_err_probe(dev, PTR_ERR(pit_config.map),
+				     "Unable to initialize i8254 register map\n");
+
 	priv = iio_priv(indio_dev);
 	priv->aio_ctl_map = aio_ctl_map;
 	priv->aio_data_map = aio_data_map;
@@ -449,7 +499,13 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		.drvdata = dio_map,
 	};
 
-	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+	err = PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+	if (err)
+		return err;
+
+	pit_config.parent = dev;
+
+	return devm_i8254_regmap_register(dev, &pit_config);
 }
 
 static struct isa_driver stx104_driver = {
@@ -464,3 +520,4 @@ module_isa_driver(stx104_driver, num_stx104);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(I8254);

base-commit: 9dc03309fe9ba9f9b26a37b2dd4fa2d5111a1ccf
-- 
2.41.0

