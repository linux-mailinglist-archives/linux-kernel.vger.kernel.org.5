Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313976B48F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjHAMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHAMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A31E19AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:15:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3110ab7110aso5723208f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690892155; x=1691496955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB4JTBbloeJlOrROqSHyOpiwaZu7mID8DECUoJEbjX8=;
        b=NYXCiB2zcVM8Qxs8ecgfX9+NlbuHqLqhg1XLDW7UO5ZNxusn8EogCTNN25O4yFaZPq
         NE3QcHfjs/dxkvib+JNjvmhuiHd68mfW3GJynW5cuOz43eHTt+iu+R5Bf4ukz0RAyI9b
         lODns+KP4dMke5heNjAu1i4wAVH+bDHa3FjznVb+uE1h6w7HOhMj9uq80svgRrkBch5u
         oAYVQ+Q6WBjIJZNZj3Plwd3VBAx+CI0sshBauRsYoT47mormEfsCjVeNUad6Mlwk2WW5
         VN5KJdwUEr5u3gx7jdqvYuk2mcqRE+mP6UF506PPftMww3KK0JCH2/CmJJjbTu8jEdkL
         rClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892155; x=1691496955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB4JTBbloeJlOrROqSHyOpiwaZu7mID8DECUoJEbjX8=;
        b=bP1cNnk3wJID7GQyEcDf5p8uHJk9J035bKzdFOFjst7/SydyHuHC1ygpiTZbS9582e
         7O3Te2Bt1lVJBX8Gd2tb9Y7Udgm9DwboZtJ6P0uX9Y8yonbAtJr36ui9dPCLAJywJTgw
         mtfwCPYTkO2NOYa5V012QQFKqoyleziM4yh84Cm94oDBHA+t1hGQuCL5TzjOVPpZxjBJ
         CbXENMw42cTcrgZgiEYrFZ/xCFh1hroEJHsKNBjBwHFzmrAh/LxF7dF+BNUNMCe8WgZa
         BLI7Zs8jxDmCf+bNiz9SfKWtJobUxp0n2aOOmT4C6Pkj1ltXxs1LDumeeDCiPzJqtrzQ
         TaaA==
X-Gm-Message-State: ABy/qLbkh1r4z0m/IYCnJxbccNP6F0K8w6K9T1/zro6mJ1WFz0erOR5n
        2TCgoyiPljARiiBTI6GriRAFVg==
X-Google-Smtp-Source: APBJJlFYRcwmM1zJ/Oxo9kEy79Dyjo4OHKnu+WG2NIj4CepOmQqRxMXYRh0Cs5Mg3zY0m7O9jK8jRw==
X-Received: by 2002:a05:6000:1012:b0:313:fbd0:9813 with SMTP id a18-20020a056000101200b00313fbd09813mr2309885wrx.28.1690892154900;
        Tue, 01 Aug 2023 05:15:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm15874351wrq.115.2023.08.01.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:15:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 01 Aug 2023 14:15:48 +0200
Subject: [PATCH v5 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-topic-goodix-berlin-upstream-initial-v5-4-079252935593@linaro.org>
References: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
In-Reply-To: <20230801-topic-goodix-berlin-upstream-initial-v5-0-079252935593@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8018;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Qt+npl8i2OE+s8j4Ze03++ftzJ+qPlUeps9Tw1QwAkg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkyPd0boa3ANgYf7mCgA9NtuidmxhmhgHz17YnxyTI
 suBo5Z2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMj3dAAKCRB33NvayMhJ0RblEA
 CnLxA/0cnyZcctBZcHCldZRk5OTCZW2u+fLSkmZK/e3n+3w0ublbmJWhOxZ/w/JXP6LFujc1wt5xf7
 W4dLl8bNvnU5fdZS3Q54u6pSCkO/8PFA36QCIFa1szf+4XSXfa6xlQDFafaYKZcXUdc9e4w4J3L+Zb
 L+ivkXtB/hxi268ECm8ShzFEZNsrriJQWqwWIen6NZOt4r+dMZdRhE+H5gIphuOBwKyYN7wN6YpBGW
 NVmlwxwf6+Mpwu3YXDSpKHbqN9HXhA9J4zDx3rjNfDUsFCQ9/ly1URDygPvJhb2pyOp+fclFFC5hPD
 E6UMGLS+pqSJ0ButAdY7+tbYyDFQQAL8OszNWzxBmsZGuPfGSjtwziX5985VBM1HNcZoT1Snoaglw3
 WotKXzkvWpUrEqgojurP+4DkRqCzn2EWIQiNLCjykQjvs21d0UrcDeWZFQfCP+fAafTWj2m+loypWt
 D+du67o4qxVPUSV25z2uTlUpf9TubsWLJ2TrrxZrv3RdBKO6y4dD6RuFn2IWvUsnjO03scNIDpc2Mi
 aymOpA/hLMV3gEF55rjCG6LD86mxulJTwjVZP02NEfO3GgmD+2yeh7bCJe//QJ+wYuPBRWUyXYDqij
 2oLY5KOW3sNpPMgt4Irw6XiN78uHf+2hlo9cXXP6Q5NdIlL8cZ393DmpIgMw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the new Goodix "Berlin" touchscreen ICs
over the SPI interface.

The driver doesn't use the regmap_spi code since the SPI messages
needs to be prefixed, thus this custom regmap code.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             |  14 +++
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/goodix_berlin_spi.c | 173 ++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cc7b88118158..c821fe3ee794 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -433,6 +433,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix_berlin_i2c.
 
+config TOUCHSCREEN_GOODIX_BERLIN_SPI
+	tristate "Goodix Berlin SPI touchscreen"
+	depends on SPI_MASTER
+	select REGMAP
+	select TOUCHSCREEN_GOODIX_BERLIN_CORE
+	help
+	  Say Y here if you have a Goodix Berlin IC connected to
+	  your system via SPI.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goodix_berlin_spi.
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 7ef677cf7a10..a81cb5aa21a5 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
new file mode 100644
index 000000000000..1f57c3592918
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_spi.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Berlin Touchscreen Driver
+ *
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <asm/unaligned.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "goodix_berlin.h"
+
+#define GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN	1
+#define GOODIX_BERLIN_REGISTER_WIDTH		4
+#define GOODIX_BERLIN_SPI_READ_DUMMY_LEN	3
+#define GOODIX_BERLIN_SPI_READ_PREFIX_LEN	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
+						 GOODIX_BERLIN_REGISTER_WIDTH + \
+						 GOODIX_BERLIN_SPI_READ_DUMMY_LEN)
+#define GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
+						 GOODIX_BERLIN_REGISTER_WIDTH)
+
+#define GOODIX_BERLIN_SPI_WRITE_FLAG		0xF0
+#define GOODIX_BERLIN_SPI_READ_FLAG		0xF1
+
+static int goodix_berlin_spi_read(void *context, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	struct spi_device *spi = context;
+	struct spi_transfer xfers;
+	struct spi_message spi_msg;
+	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
+	u8 *buf;
+	int error;
+
+	if (reg_size != GOODIX_BERLIN_REGISTER_WIDTH)
+		return -EINVAL;
+
+	buf = kzalloc(GOODIX_BERLIN_SPI_READ_PREFIX_LEN + val_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_message_init(&spi_msg);
+	memset(&xfers, 0, sizeof(xfers));
+
+	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
+	buf[0] = GOODIX_BERLIN_SPI_READ_FLAG;
+	put_unaligned_be32(*reg, buf + GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN);
+	memset(buf + GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + GOODIX_BERLIN_REGISTER_WIDTH,
+	       0xff, GOODIX_BERLIN_SPI_READ_DUMMY_LEN);
+
+	xfers.tx_buf = buf;
+	xfers.rx_buf = buf;
+	xfers.len = GOODIX_BERLIN_SPI_READ_PREFIX_LEN + val_size;
+	xfers.cs_change = 0;
+	spi_message_add_tail(&xfers, &spi_msg);
+
+	error = spi_sync(spi, &spi_msg);
+	if (error < 0)
+		dev_err(&spi->dev, "spi transfer error, %d", error);
+	else
+		memcpy(val_buf, buf + GOODIX_BERLIN_SPI_READ_PREFIX_LEN, val_size);
+
+	kfree(buf);
+	return error;
+}
+
+static int goodix_berlin_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	unsigned int len = count - GOODIX_BERLIN_REGISTER_WIDTH;
+	struct spi_device *spi = context;
+	struct spi_transfer xfers;
+	struct spi_message spi_msg;
+	const u32 *reg = data; /* reg is stored as native u32 at start of buffer */
+	u8 *buf;
+	int error;
+
+	buf = kzalloc(GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN + len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spi_message_init(&spi_msg);
+	memset(&xfers, 0, sizeof(xfers));
+
+	buf[0] = GOODIX_BERLIN_SPI_WRITE_FLAG;
+	put_unaligned_be32(*reg, buf + GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN);
+	memcpy(buf + GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN,
+	       data + GOODIX_BERLIN_REGISTER_WIDTH, len);
+
+	xfers.tx_buf = buf;
+	xfers.len = GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN + len;
+	xfers.cs_change = 0;
+	spi_message_add_tail(&xfers, &spi_msg);
+
+	error = spi_sync(spi, &spi_msg);
+	if (error < 0)
+		dev_err(&spi->dev, "spi transfer error, %d", error);
+
+	kfree(buf);
+	return error;
+}
+
+static const struct regmap_config goodix_berlin_spi_regmap_conf = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.read = goodix_berlin_spi_read,
+	.write = goodix_berlin_spi_write,
+};
+
+/* vendor & product left unassigned here, should probably be updated from fw info */
+static const struct input_id goodix_berlin_spi_input_id = {
+	.bustype = BUS_SPI,
+};
+
+static int goodix_berlin_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config regmap_config;
+	struct regmap *regmap;
+	size_t max_size;
+	int error = 0;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	error = spi_setup(spi);
+	if (error)
+		return error;
+
+	max_size = spi_max_transfer_size(spi);
+
+	regmap_config = goodix_berlin_spi_regmap_conf;
+	regmap_config.max_raw_read = max_size - GOODIX_BERLIN_SPI_READ_PREFIX_LEN;
+	regmap_config.max_raw_write = max_size - GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN;
+
+	regmap = devm_regmap_init(&spi->dev, NULL, spi, &regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return goodix_berlin_probe(&spi->dev, spi->irq,
+				   &goodix_berlin_spi_input_id, regmap);
+}
+
+static const struct spi_device_id goodix_berlin_spi_ids[] = {
+	{ "gt9916" },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
+
+static const struct of_device_id goodix_berlin_spi_of_match[] = {
+	{ .compatible = "goodix,gt9916", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
+
+static struct spi_driver goodix_berlin_spi_driver = {
+	.driver = {
+		.name = "goodix-berlin-spi",
+		.of_match_table = goodix_berlin_spi_of_match,
+		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
+	},
+	.probe = goodix_berlin_spi_probe,
+	.id_table = goodix_berlin_spi_ids,
+};
+module_spi_driver(goodix_berlin_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin SPI Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

