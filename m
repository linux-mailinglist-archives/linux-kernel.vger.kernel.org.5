Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168875B718
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGTSuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGTSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:50:06 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC1C173A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:50:01 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48137084a66so518993e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689879001; x=1690483801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9QzZvgjwr3E8Gyd9Qnq7CW2HMig9hbl1hb3MeCt/Hc=;
        b=fUgz3LRjaGYQPcFhJy1jW0oD1wY9Wv4176AE1zS3NrgBr2NUWmG7AvzA33rcr1hsyN
         K9rjLAC1QNEiLtlE4a1QD2CtVAIaGAvNjCaA2CVSf9ga1eteLBBTGXLkgvp7dID04nS7
         FEWCoTakWHVhQCqdDUVhjMSuLYKqGT13lnJEbUqoNMefgj/nnjvBmwWLzGDIWlAL9BOt
         SdFtGw9xr6IoXENdbS1JTZFK+CceVh/WfD0jtGQTULavtLLGCylXp2o/vZa2aOvFVaAw
         prd5NMZctFnYiEc0WyinuHL0GSjnc7y7LaMVVu1irIlH71b1r7JD9udSQTjYiJ3XpIwT
         iCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879001; x=1690483801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9QzZvgjwr3E8Gyd9Qnq7CW2HMig9hbl1hb3MeCt/Hc=;
        b=Mg1PCRgWNcbOVmGbS2t5ocn/o59zBDjitZK7wYKQdR/Gcqa/T0eSIIrhx/9w4k1dkW
         YnpO3GsgEbqDOkSCieQLgM7C4P/faRgJGRyB22/+6ASy+xNmSjvKP1aDzkJPChlw/LJI
         GEhU76JpG70W8eiJmzuVC/nVrxx1tYbHujRfNkCriG76CP9mkwlv6+5kQlk52Ae5ueQu
         CwUpEXyBkGg119gLFgA3lI+JawsrqjtjMaElG1b0v4nbjY8ngaUMEJBJ9Zs3Iki3O2m1
         4hn+NTVraF/PrBDAva0/Xne6rGzEKwdntSWtuf0fmwuTrEasBpSxow4qzMIxkRPthKuQ
         WWfw==
X-Gm-Message-State: ABy/qLYGzJ3FBAum14QMO6mpNn8y2lS81iKlNm+qYWGzsiaj+ZTA1Eyt
        VrDa/LcsUnKTJA5f8bG7X4Uy2A==
X-Google-Smtp-Source: APBJJlHP1fTNcL7sDTNwB0AIo/L4BNLRXl9sBgQwl9cZAx0q0u2j1SdUpMMY0FZawzaJmUkveMaGgQ==
X-Received: by 2002:a1f:c116:0:b0:471:17be:ba8d with SMTP id r22-20020a1fc116000000b0047117beba8dmr7269818vkf.3.1689879000829;
        Thu, 20 Jul 2023 11:50:00 -0700 (PDT)
Received: from localhost.localdomain (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id h7-20020a0561220b6700b0047dbd48bc44sm238059vkf.17.2023.07.20.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:50:00 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RESEND PATCH 2/2] iio: addac: stx104: Add 8254 Counter/Timer support
Date:   Thu, 20 Jul 2023 14:49:44 -0400
Message-ID: <c73869c2b26db05303902f80ca86316b155c4832.1689878150.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689878150.git.william.gray@linaro.org>
References: <cover.1689878150.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
-- 
2.41.0

