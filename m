Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF487B6478
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbjJCIjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjJCIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:38:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95032C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:38:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40652e5718cso6376465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696322323; x=1696927123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=xiMTQyxRvKaRfW7Kk/XCvDuxcbfI61r05PdIEqQ5a8k1WV7UzzlPgnJ8xE5zH2Uvli
         W0A23kuwbbbyRzPNFR9BFkc5Hs8GAyQhzYVnH5jrv1KI2hFbCJAm0isvf1nBKyzVeULr
         E0YWiergMJuYU4u7sjTpbQKMIi4kjaybl9E4jwsc0hll3OclhqGCwFCbEYOONTrsEYkc
         5q9HiGJTl9qQ/CTajxlnoOOswbXnHjgPNQWTXbDKktppsnR8Xb/24ghNEvh2kLb0/Jse
         v9cyO1yW9DwbV8VPDwUu+33JnJSqPLGw9YVshY0wVEnBd1B6z8rnkLNGZxfH66Gyl9Ek
         tqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322323; x=1696927123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=gC/EuT8Oaj0W4LobwJacGzJBZRcN2cj3wS0XWtFVxOnSU0DCtnRUp85hHaEWCGoF94
         KZFO5LHwV8dFdgwK6bxJJSK9RLj94YFeOXv3sF3Q5YdC6qNCTGiaxqc+5QlHDFKJTS/x
         E2QeNbYip9GPyHH2uQOAEnd1CfyIm/29uxHXz1oJc0Y3PvnO666TCls3afpeIrxqo2GA
         /LMEq85/dZj65Bx2e/bLzHkKdgxEdjQ5QvIoiQVB0b0PQ7BDaD/ebpQB3sGqDTPmTp9l
         wbnt4NUe7WJBSof/+5oKRaQYUMTPNLZzVSTGg54JiqXSUMoIBJ2Goe95orfh85naXrbb
         tUBw==
X-Gm-Message-State: AOJu0Yw1qNR/PPwhNJieIEZ0Z58QuLsYemY/Ng1d6UF3GRFr7iRlkfLn
        BlozTV+gAZTzpmBJH9/JICmNlQ==
X-Google-Smtp-Source: AGHT+IFIji0759tS3lMN8bexgB+AHQHcRcUxf5XRSNWKA64Eg0yeGvnaBTSRSX8dvLsp5K+fUmOfMQ==
X-Received: by 2002:a1c:771a:0:b0:402:8c7e:ba5 with SMTP id t26-20020a1c771a000000b004028c7e0ba5mr10395118wmi.18.1696322323050;
        Tue, 03 Oct 2023 01:38:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b00405323d47fdsm733597wml.21.2023.10.03.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:38:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 03 Oct 2023 10:38:35 +0200
Subject: [PATCH v8 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-topic-goodix-berlin-upstream-initial-v8-3-171606102ed6@linaro.org>
References: <20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org>
In-Reply-To: <20231003-topic-goodix-berlin-upstream-initial-v8-0-171606102ed6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fvuZaiaDmAw7atVHwbHQLhUjO6UmtXJUopSvbqmyj84=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlG9MOjvmvnjAISGQLwuRR98vT4mFmmLEHe7kUBhhh
 lzRtFOaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRvTDgAKCRB33NvayMhJ0WSHD/
 0VRF/I4wWZu71kVZ7ryIG9R/yaQEYjZFClZhLX5hmRSVr+3vMFT/XzuDV6i+UhE0O703+qeglVP13K
 23K07H2tPbEVrbsOBzLajMBgP4dMmJ8XpchFEWaSdkj971C0TkhwIHfm2G8U+yMSfoqzy/52gSh3Fu
 kfWsLDUFbURS1FIj/ov6A/3R/jSX0w6lLeR6ksmgZ66rSNtCR/CSdXK9NJpoPo1U3kdccZqh76yvy/
 pTlor3HopKpuBHBezQ7F3yYTtGHe8TYjvuOzpB0JuQAk6q/KZ49yUEPXrQR1P0SEkvV3y8wOLVYpAj
 v09xwQPpowbi0GGYgyAr4n4gQEb1xfcit1Zqks0Wh2yMASAQCM6ES52bkA4Fck4xU0/7QXOzaB4il7
 XKs6GeHZ6t3fHdkZSKGgigiRdkyKXJx3ZqCj+cd1TzHjmmMlwCBoVVnEH+J3+58IQWoUmO6Cqep4Os
 zv1eamGu0ogrAKdnBTyYV4jMtqO8dXHpHBjiusenjxfBdRAfEnBn6pQjC3MOlo20SiZEPy9G/1Elvv
 HKrxAkDmPLFuvPsFd9YQbEszhGdKKgg8RQsCrHxvshFLH5ElxJ5jDHKxeH7PUntaZHVkK0l1vW1iCH
 cXS1VFSJwB82cFIad7GYJnDb9Pvi0sbOP11BSdisTCllVwvzgz0F9GiWwNuw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the new Goodix "Berlin" touchscreen ICs
over the I2C interface.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Reviewed-by: Jeff LaBundy <jeff@labundy.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig             | 14 ++++++
 drivers/input/touchscreen/Makefile            |  1 +
 drivers/input/touchscreen/goodix_berlin_i2c.c | 69 +++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 950da599ae1a..cc7b88118158 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -419,6 +419,20 @@ config TOUCHSCREEN_GOODIX
 config TOUCHSCREEN_GOODIX_BERLIN_CORE
 	tristate
 
+config TOUCHSCREEN_GOODIX_BERLIN_I2C
+	tristate "Goodix Berlin I2C touchscreen"
+	depends on I2C
+	select REGMAP_I2C
+	select TOUCHSCREEN_GOODIX_BERLIN_CORE
+	help
+	  Say Y here if you have a Goodix Berlin IC connected to
+	  your system via I2C.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called goodix_berlin_i2c.
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 2e2f3e70cd2c..7ef677cf7a10 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
new file mode 100644
index 000000000000..6407b2258eb1
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Berlin Touchscreen Driver
+ *
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "goodix_berlin.h"
+
+#define I2C_MAX_TRANSFER_SIZE		256
+
+static const struct regmap_config goodix_berlin_i2c_regmap_conf = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
+	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
+};
+
+/* vendor & product left unassigned here, should probably be updated from fw info */
+static const struct input_id goodix_berlin_i2c_input_id = {
+	.bustype = BUS_I2C,
+};
+
+static int goodix_berlin_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return goodix_berlin_probe(&client->dev, client->irq,
+				   &goodix_berlin_i2c_input_id, regmap);
+}
+
+static const struct i2c_device_id goodix_berlin_i2c_id[] = {
+	{ "gt9916", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
+
+static const struct of_device_id goodix_berlin_i2c_of_match[] = {
+	{ .compatible = "goodix,gt9916", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
+
+static struct i2c_driver goodix_berlin_i2c_driver = {
+	.driver = {
+		.name = "goodix-berlin-i2c",
+		.of_match_table = goodix_berlin_i2c_of_match,
+		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
+	},
+	.probe = goodix_berlin_i2c_probe,
+	.id_table = goodix_berlin_i2c_id,
+};
+module_i2c_driver(goodix_berlin_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin I2C Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

