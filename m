Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7DC79CA77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjILIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjILIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:44:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41FF10C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40061928e5aso60915805e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694508255; x=1695113055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=Rcth8t4bXp6KhFFiZz3xP0riEt/e/CtCg3gdkFuJ0UdHAf6VB5LKURXlIvQ05vooop
         xOWHp8Xlb6/z1XEDRf8H7a9uKtSWNC6oW/bqSoIGLc6CEm5YNo8cuT6M9QYhsJCT05l3
         4eEHhHNnTjB9JJKCrj9WJg5ktAIVWRQfnDUvXXsPD/1JYsj2/afMQTpjvvwP+i6Lg5eY
         D0LSJthGVO/wvUsf9RAoNDzrFV8NobUuWBumyAdBomZDo4n1ItUueQN1sDHjzPw+JRXo
         i4wbA4mLNl6tjioXBHMU4kBzvdtEQOt8zqYliKm8JRUmyI/nZycYjk02tNOa0bVWXr7q
         GTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508255; x=1695113055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=gkoxmCNHbGXfVoz/i8MwPfsQB3Fe4RBT7L68e7g5LolJZ2cSxh+xoVceOUnszcBzXF
         q1i/8QDqkn7jjaW9X8tl0AhtTNMZmHfOMliBM3iIyOzqijRdIGpOFxjYKK5xo6uhobAq
         8COtrjFxNVv8jUwK6WAXHw6SJp473J96ibjf9/8Y2qDRA83XRuVADKAxOS4z5QeUPJ/l
         bdPOZPT2WsnXX7wju3gbkxdAfcFssUpjINnrD3cyO/ppwMLvLE8HkH/H/VUsy1lvn7k9
         dbhvjwWWPGsnR6MIJc7tDLzPdGH+XcmUgLA/fPepplG3J92v6Vmxa+GQ6HqNyQMlFdpu
         y8+A==
X-Gm-Message-State: AOJu0YxcDmxpTrBaYy6VV0C0RFazN7eg817POAppE9QDCKqQ4aPkEx9K
        YSn0xLGN0IwHFs1KpXLD7wZTxQ==
X-Google-Smtp-Source: AGHT+IFt3az1mwGhwDUC9Zob7Eq/COwGueGt1i1Wk2mpPrAlkG7N6mUPkTGqFF9NM/tDCZrj2PjYSQ==
X-Received: by 2002:a7b:cbd6:0:b0:401:b1c6:97e8 with SMTP id n22-20020a7bcbd6000000b00401b1c697e8mr9813892wmi.36.1694508255316;
        Tue, 12 Sep 2023 01:44:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe2bea77ccsm12301348wml.5.2023.09.12.01.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:44:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 12 Sep 2023 10:44:09 +0200
Subject: [PATCH v6 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-topic-goodix-berlin-upstream-initial-v6-3-b4ecfa49fb9d@linaro.org>
References: <20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org>
In-Reply-To: <20230912-topic-goodix-berlin-upstream-initial-v6-0-b4ecfa49fb9d@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fvuZaiaDmAw7atVHwbHQLhUjO6UmtXJUopSvbqmyj84=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlACTabbo/LqW9p+P0nS6fY0li5bfohl5Aak5P7BZM
 gfVwWJGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZQAk2gAKCRB33NvayMhJ0d3oEA
 C5Xy+znUA+pM51v0zdR5Xp6KDzsMC2Z520vt0nZB84HrdgLIJNqq8M60lPbSe9EqaSGr5kvM9KUVhP
 HkOeS/JY5G228YvMoH0HGDAXMswNhSzCSg0zs5rtekjJ/TWmQKiWW9YRp+h7gudmBHyfy7F++cfeP2
 PiQo9AXxWvGsq2e/+nUEbwY4Tc7ax+eT+c7VC5bYQ1izLMtQRqSgsQmlH/4QEFL6+Mw2JX3Nm9vEpA
 RfuNDS1DvhuDT7jlxUH5JCRj1XpWZmkWmLCAWK3SI8cibBby9IEGD9+7Kw1s/Dy+xYW/iDJ1bhmW8B
 0H17dm44lHUb2RTRfJ9jNpwOVoGx9AqAtBvaD3HJ8KXsWu0KVsUGw0zJBmFyXegO0swlqBPvQz41mj
 4cBTUPoDAZWJoHzNJYc7elQ5M+gYNTCjEI1f0aK0khPc8sfLwU3Oq1HoOySL3znCwmZX8pXePZ5R8T
 11Z+mL0sjtEWVW/wb49dnspUAqnhiNH/8b7PE6uDEAvUMY6cGciEyXMYyBGHUvsuak+pJ3l7HbMVS5
 K02P5FRP2pjdb/e+FEsm9GOF+tCnOw6qAoES9MM+xRQFwk+0EyhhO0FNoY7BvvIrLFyt34/auvGvZ2
 bRG9L/0PKYETTTrm+V0pGlp12DcfN+O9J+PFnr5gOCz1IY8vfFiMZFfWkY6Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

