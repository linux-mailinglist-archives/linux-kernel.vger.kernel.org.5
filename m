Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C5811A93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjLMRNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjLMRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:13:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82562112
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so70889975e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702487605; x=1703092405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=hX6BtFlNsUUCBB0i8bCvZMu4X7wMObrGy9LdpvXrch8K0+YJNanC7FLiKCczDgumh9
         hGL8BWCtWR5+RU9E4Bn4A+ElaHl0OnJxG+kqPtQpZLQpt7nroEQDUWP/Eid0He+ViV3W
         EcO19EHBaJngHQMq+mIGN5wYfSamAtxQh2xSeZR9JxB97Oi4RSR5O/KRAdwyNDRF+a81
         OHOQl929bB/TtzHHYubfEd0T7ekbiLxLop2mGZvH/Xz+Od1lkLHt4tyevk1+2ftIw0IV
         sI6zyWrGLLtphO0ew8CepCVFH/vaCSjaySWuPt7oBatdHwrmAIKegQ9HG4gXWb2matn4
         bRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487605; x=1703092405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxnVNSfczT25XAfpC4X+ICgFqABO9v8W+zLZSFvXeiM=;
        b=sLBHJ97J18VL/j6xo/rBxt98GUlBM+evD7rToev06uInyqUvj5aXzPM/ByFiVuyksK
         pspX7TgXXOj7ElqHJpUCS4C7nBUC5eB3XfQLCeTLhycRLtSW1arojQ+ejxXvsHXPfZDd
         KJmzCXptJ9mpIuOIlYFgadaKkEIAZjxR5MtvQRzgRzEmZcZJ4roIc1ICNc4WVVQkrTSp
         tX+v6BcnGcUI7VDTNhY1wsmR417g0SUDOGKVyzqKI1aEJXvbhHofnZaqr2V3/uRkycKo
         YtnBn+wOwolgItHGwLISWIOWhVyeVZhAxqmaMxcSFrJe0vEyHSRjorkfi+6LdeewUVVE
         wnTg==
X-Gm-Message-State: AOJu0YzUSdC7yWt+cVgUzKFpA2aWjc3r2b9OnlTlPkJhn+e9xhLVoM5Z
        4r7SOAFkS41xmQOtS6bgiWd3Dg==
X-Google-Smtp-Source: AGHT+IH1Dl/k4FwHknd8WNNERXzxdIk6D8+u0zwliSjifrDoKxzr6a7uVHIVoXTJdh3ZToafzMMAog==
X-Received: by 2002:a7b:cb95:0:b0:40c:1946:be03 with SMTP id m21-20020a7bcb95000000b0040c1946be03mr4836755wmi.111.1702487604922;
        Wed, 13 Dec 2023 09:13:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fs27-20020a05600c3f9b00b0040b36050f1bsm20711039wmb.44.2023.12.13.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 09:13:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 13 Dec 2023 18:13:18 +0100
Subject: [PATCH v13 4/4] Input: goodix-berlin - add SPI support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231213-topic-goodix-berlin-upstream-initial-v13-4-5d7a26a5eaa2@linaro.org>
References: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
In-Reply-To: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8067;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IRI86qOlgcP+lY+pewvMbMLCeQCDU17m1zaFOv0kod4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleeYvm2BQ9H2qKM6nS0xv74oPM4C33GxAOi+ExNtj
 8mdRKHmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXnmLwAKCRB33NvayMhJ0fTZD/
 0ZG9+BCUZUOLEafoYDv3lf0SVGpWUHaYlnxTJlOEhinj8XyDpYjKo+Ip+GtDYL9/JSQfZNjBjwcK8A
 lcFFgyJNT87qoO3YlvdK/w1WCkbr2IWV8N4oAnoBqyujlKIhabzvbsSjG12SLdYzZg56KDQofxPmHn
 KQyPCd+ZpKoR/zVBwTrW747Y+F9S8iVuKbWPVddiiuSSqsigiooH8v9sTiJweXdocBgQ7IjKf6Z4Pg
 ospue5EQSVHUWp1AgyPFJadiA5inG+iRY3rcJRHiecmP2v1YB8aY7iEjS1bR6FUWEX91x+zMBoAhf4
 n0dQ4eU969a1cPRjJawnGsFifxGJioSQ4kgVf2ZSsdJ1gn5s5XhX31ZIfT3R3/CkjqjxK3v8Fasxlx
 I2gOjwudIIGQlOK6Oc3pvj1+7tUwX+muVudZfWnpynnsWzEt84/B+iBN7N9eYegSNjmheJ3/iWgE1X
 5yEQCy2CdXEcIpFQ9+2on5L3Ch9aMFs2Mes0nnZY75B0rImaaSFmKuCuXLR/8iPZiL8BePgtixTQfR
 7XYVWqrMqoHaEKaI9TEEtcDchbRivuqum7vennT/x1k1Vrp0djzU3oRl/WAm5JfpeF64XZdA+lXS/r
 +htNOaIUoxo9aOb6aSItt1vzq5e5cjKtpqmELzcB0CrZp6blI3YuQ4W8VVwg==
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

