Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362F7E1C61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjKFIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjKFIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:34:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A2D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:34:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so7085354a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699259644; x=1699864444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=l0dOYpJgyr7MpCXzr2PK6914ol0WKBP1Cy/zYU+e9rVir5zByr9LbyZI/386Ymvbpq
         +z/XKMbaNvb2veItYy5PITAPWdvhgwMuCmjXJuSSCihqessoY7V2aWRFrfP+mtCCBRlP
         MtvxQIbbKmXATVh5k06Tb1XYq+qYIK2gdKam0NogoE0EkRtvBYCjdtIlRBnd02hiZP5B
         QAyg7wT/u5zPInlPhXVaXvmo+NWgd7VMDy2gq72Dl6qGcWYLf8ZR0gH0WpHUc8c8c/Qn
         qbf+0fsJ0yjjrEmlziX6TyAe8akc4OKFEebLEn76xMHV8T/9r68EpoO4ec7vwuqoR/Cy
         1DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259644; x=1699864444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=CGYsQd8ohvOzrmJ/uUsSxSR6ero3So2eTw8zqrAvvVSiiNLaopi3JZt8JNaTra0uQQ
         IyM2WO5SvifRS0Zluxe/HCbrmoV8GRP13BZfMoKlcp7A3ueRpTH9pUYyxEy/hdjVfBXO
         qDD4kEFcCP+oi6b4Si+XweN4l31U70vsaBB9EsmJ7qIydqq9GocRFlVTPxQ/ZE+1CreY
         Bow0rNP/4das1JsyzDM0zRKuAp9LW8wlg6KxlqoFIR3DELuLtqB4ohdyEIQYZTmUthT4
         Jgg5IX+klDm8Q1RfHsf83RFXED6yQQkfOM3jugnXzzONdE8RZZigx7GAHtG34KEAM8B5
         qk8A==
X-Gm-Message-State: AOJu0Yw5OiBuUrRHSiSOihg3qaU6te8s7cZS9ZFyPoo2ettEhJHE/x5N
        zCok23vrBY+h1N1m0aTlRdgb9g==
X-Google-Smtp-Source: AGHT+IEH0+oVX58+uggKJ7R9Rqu8bdFhdAVwjxs0JsLvDyYFiK4op9g98SYsIi9Nm/DHVLmPUigpXw==
X-Received: by 2002:a17:907:26c5:b0:9e0:2319:16dc with SMTP id bp5-20020a17090726c500b009e0231916dcmr2466244ejc.73.1699259644042;
        Mon, 06 Nov 2023 00:34:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q24-20020a7bce98000000b0040648217f4fsm11132991wmj.39.2023.11.06.00.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:34:03 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 09:33:59 +0100
Subject: [PATCH v11 4/4] Input: goodix-berlin - add SPI support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-goodix-berlin-upstream-initial-v11-4-5c47e9707c03@linaro.org>
References: <20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org>
In-Reply-To: <20231106-topic-goodix-berlin-upstream-initial-v11-0-5c47e9707c03@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8067;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IRI86qOlgcP+lY+pewvMbMLCeQCDU17m1zaFOv0kod4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSKT2L/YIoIVQCfo/epBR8EfFUB+oHqLAeES4nTBl
 rRb/Y/6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUik9gAKCRB33NvayMhJ0WU9EA
 CD+XjwmhLu0Bi0k3zqpiosQTJr5WVPxuvvJiPf8pBfYKm0hi5Ae6gclEWUBkeY1hkMMzJQ53+p6/O0
 zNZ+bSX0e4RzSm0OcnCny33ueKV0+RomM8fikoJOW+JzRvYEmtwhrsRESWxLJbFIEr0ffh2MIJBsrP
 kWgHif1sDgdV+LjNWCHqaOvgpXi4MbEktlemUiGnx6BFmGMhuZi03NezTDImfLRgSYBv6g/H8PoEZW
 UajOM7EsK2OvW0hoadwLd8YVnJlPMu/Y3S9SPK0VvvZLV5pbo7mdXXgSDDAOyZKkFKIEk6FC7bvWOm
 GnvrRB1iPjj1589U4laOmL7x7HYkcPxWk3llxSDguA/oZrTOUTS5OYa1ZqMq8Mb9drdKmqTLfoDo3i
 gfL8FshdQl0MHwAgMi2AGXS+9TWTKYcz+RoEBzQlrvFRSoj5J2n4G/TDiMSE2v3/+GmIIqzRgY39LI
 LdcrKfNuRrSU+EUIiOJj9IkoffJq5zszATkR5zjIvcjNBpy+CYh9M+VbQErRusIubG+6IBb+VDHR4y
 Z/5zJFA+gfoXKGiWlYy/zR6KHkYanSzahg0SYu8l4ds09JWhA98nqTzRdT4+Uk+zhbEsPoBb68d8vB
 QMqhW9GiUWdgrs8SI/cnxgV2R309tltlNnTYwJahqjgJJOvU5XzpYOk4ey4Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/input/touchscreen/Kconfig             |  14 ++
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/goodix_berlin_spi.c | 177 ++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)

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
index 000000000000..502b143e9e05
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_spi.c
@@ -0,0 +1,177 @@
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
+	error = goodix_berlin_probe(&spi->dev, spi->irq,
+				    &goodix_berlin_spi_input_id, regmap);
+	if (error)
+		return error;
+
+	return 0;
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

