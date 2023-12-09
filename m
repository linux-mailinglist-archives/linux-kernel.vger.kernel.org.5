Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198C380B2D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjLIHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbjLIHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:33:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EAB171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 23:33:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33339d843b9so3024299f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702107230; x=1702712030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=OM+ey+6Of1S0t3vDuLkIA004OCVC5I0o06eS+Vnp26wqXWEYphM4pWGLwRzctO4qs0
         9RTgdmkqnYROFh5nBRaJqkSomtm/W4V9xunUGMmXqteAQs6POtHJFMbsv9F1UGHWi7YK
         DJf2K0SVjpapOfvi3HukQ1Ps4p2QNLPmEvR1Mkw5f8qO/lfYxvmatquvBu/L9McW+0+A
         atT7roEADBdSMVm5tgKIqHsGt51e1dt5kw+hVnMI2roWu+X6bxyt2skjVITu8jlIsSI7
         n7Ekq3yBLWWltdpvR9raW0G8dQ1yx7J4jtVIvaukVlNS08oGzRJc/oZRuwIpbrngcFqm
         Gp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702107230; x=1702712030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=wYOYFnk1N5oY2ngngX7mOjcR/5HkE5GhoCFMawk3V1Eqzh/wdyBFjK5VAyuLxUu5K9
         EZ47KpDARfYOBVfu+GHEOOeE6ozzLZ3A2sc1b7+aLtNjyTp5sXPUAc0fh8mVPws/Er+D
         cdUedJ2V1cOkxWae+kdPhLpY7HveloxFv5bl20T0Cmei2kvXICSBIlVZ1nTKfctN0AWM
         sxM9pSKi3vavyOqM3L0Y4vzJUQ79Oy7lZsOZ1FoP1yidumVWHk6CTUwF7DMYnUPJyyiw
         sUkKoYdXlUcZ+VvfaBQt1F4U/b1QxLPBOQMYiBbW50+numRvQF/v4qwKr5qjO+gGJbn/
         Liyw==
X-Gm-Message-State: AOJu0YzJQGFJcTmeD4DT802LGPPr4n2wXUPMaPkBTELFRUdUT3pbkS2w
        uN0f4gLI/j80GrsGlLhvbgMtTw==
X-Google-Smtp-Source: AGHT+IG1g7el614IqeggM4DbASQSyqoXGkXE4ZLoGAcKVtxNYKQ3vmK9lKp70def2ak1LwiETptpsg==
X-Received: by 2002:adf:cf11:0:b0:332:f8d2:63ff with SMTP id o17-20020adfcf11000000b00332f8d263ffmr620920wrj.46.1702107229548;
        Fri, 08 Dec 2023 23:33:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b003334520e49bsm3577803wrw.53.2023.12.08.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:33:49 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Sat, 09 Dec 2023 08:33:42 +0100
Subject: [PATCH v12 4/4] Input: goodix-berlin - add SPI support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-topic-goodix-berlin-upstream-initial-v12-4-eaffaeb53fb5@linaro.org>
References: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
In-Reply-To: <20231209-topic-goodix-berlin-upstream-initial-v12-0-eaffaeb53fb5@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBldBhYeBg5oDLVy4/ZhUtHKFUFS6TXFDhnBuOrcqVn
 ekoCTvOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXQYWAAKCRB33NvayMhJ0Q65D/
 wO3Izcir8gJfPF6ygHmFo0+WKsonOsOvhVxRpBjmV9RJ1KrfwlZGhjn2iYNQP2sjPdnnbLx57afs0l
 1se8K9VVaguflOpJkA9t11G10d970wN41ZVV9ftG2T8/YY//+BSpXUsEAN5pJtYgl4HoMNefDne5Q7
 kV+urofiBobUbKe0exfsz79lIhd2FD/46/SrjMryaY329O1dqhcD84RKkLyFn9SeEnEzSfa2ql5isU
 BrAdWFcGF16CckqZXad22Hj7QNeHknFVVRwqLLrUVZJiOitKIkQzpEELR+TgEHyqX+O8fRDZWs7MYh
 ++xTF1LWhxmjxGmd47tnx928XXrcS0TwXo60KngkJ4cKf3AR9UZLN/LFSSUoiHxYaro9a07nqUG8/j
 WTjysmyVWO1vIfZ5Axff7bamcHTL9butR+gmmevzSuACV0UpbyFr3b9k4zW5NCPd2/imPI98deiU2z
 5bsupf5JYTwL05k6vHkNjCDRkc7U7K/Tz9pObYXgv87cts0bbgpTszB1+fZcYI5tr4ra+mAYRL9Ozb
 MaFhVDHjgLAYYFex/h0nhDcK/T7lvFUX/oJ7Fjwll51tg+ZdiV4+Y+Gb7Mzl4jmTCiLbbrzJYXA9Ei
 1UcHeEk4dEtgfln6vR9FgIHuKmxOnoOeOOBNxAk5dlhCyvw5mTcK9HCeeISA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

