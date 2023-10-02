Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83F97B4BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjJBGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjJBGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:54:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE5BA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 23:54:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4060b623e64so16011615e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696229693; x=1696834493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=Tlrn/vYwuXInBZVAoirYIDlHxS5qQvGlzrblrEPbG+wxNX9m32ZzQTAwpjqOqze+Eo
         0S/oYSS1a8ItskZ8HkZdO/PZZbTRPAKh+onDCv6k0d4RU1MK2zmlEL8A0cyxCHZ3tqk3
         jJgUAPDHryL8UfgVeLq2xv/GER4kM6h/Zt6yX1OlvtPmDkYB9j2eZcePCULWMSduXcOM
         5f26Is1pSy2hhfeEI8cdov9YhZgfxIM//6BG/bewFrhLMMKzKQ+43toFVVvfNqfW6iGU
         j18Thk2e4/cDjV+YfuRs4AalVcqDozyvp6aASBWv7fnnuKtwnKqVg89FLb43JTZYgPVB
         MMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229693; x=1696834493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=nroTVXEb3UzG/cct759R5s1/2mAmEE4dqG5IXwo16MyOnZZgIS+cU8WYMGJeKaEKhg
         Sx8SpTIoLnwqlJdk/2BCIjKd+sXtaB9l9AMe0uDO/5zxcq94yY3/hxO1M5WEpOEzxGFu
         VMZIL/TBdu61XKD5XDeDrWohpwCEygjqXr033gN0S46YaJ6zncggPBpqIiuf84FKyJ/0
         Z97QHwKKNQLASO/CfO4prUjJClHaYUg4cYcyAkemlT4DDXyyeTgaEiLPFzBojGE2M+YJ
         rYKVH5E6W40KmEIvB8dV0a1mglmT0HAe6lzw/q8tCHVJI6UJpnZ8R7lVuAf9KtwG9JCB
         QtCQ==
X-Gm-Message-State: AOJu0YyQMthBfUdhtG7ZBPzW9TFTs8dtKQnG2SMyZ9e2u4WUqOmuHDXo
        tscKlCAT+VB1Id6J8UtB3lDIPg==
X-Google-Smtp-Source: AGHT+IHSFkYGe9ywnhVbfekeSOhRWU4gUzXtkUlO9vJNOEJdq5RthX09m2NrUsBGR4e1vxQxuHEOKQ==
X-Received: by 2002:a05:600c:1614:b0:401:c7ec:b930 with SMTP id m20-20020a05600c161400b00401c7ecb930mr9033273wmn.10.1696229693038;
        Sun, 01 Oct 2023 23:54:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b004063cced50bsm6601815wmi.23.2023.10.01.23.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 23:54:52 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 02 Oct 2023 08:54:46 +0200
Subject: [PATCH v7 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-topic-goodix-berlin-upstream-initial-v7-3-792fb91f5e88@linaro.org>
References: <20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org>
In-Reply-To: <20231002-topic-goodix-berlin-upstream-initial-v7-0-792fb91f5e88@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlGmk4tCyb25I35FtjvUenlxHQ8UL7bQWz4AcVVWsU
 vGcBx7uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRppOAAKCRB33NvayMhJ0XQxEA
 Chl5zW0Hi8HXH8SwInfIPW+Vi6Bib44xGgRAQAoj3+vQ059D/qHy4smy1OefWyNNwIoe6u2hOw0Dt6
 /he9t69hKb5BbWTFxHUnRX71x26/aVA9FTFl7YTJfZqLBWgC1J7P4QyIm+jloGtehnfIdQ7p8titKd
 WuFNz/BBySZ1WBJu64YueATtcdLbl5sniJX0Q+vs4FYuciei1lPgWHPx397oK8wOfWb0z9m6/zCByY
 3KabTvGXon0k0UBS3KHMdm8M8H8TbryLyBZQAFKq8nYQC4nZi139OH92b4RgYaYvM3n0G/1cXXKmGF
 5cNKqvNoX8WqpLHuBNOt6Sbg4AtBSiTjqZcLIGNhG8EGKvQpqkWDThcgo5dlyTLBZzwm05csQ42Sdl
 2mUJLHESSkvI7SgSQY8YT10feeiJJGWjJalzqi/MpLL7flnvuq7OiUgSO9cOovSX8gGCeyT4GCjHRs
 +DkfuxvallwDAPsS9xh9z/AE78RKSM7FjY/gd92FOzdKqi4AiJcQf+r9xtEmSQLEiSZ9QR5WXlOZJI
 /raYBWaQpyMVNpKq8q5AYaGmsbPjmjbESdiYnME3pmdux4m/yMlucltOqhvivK2aAwjzM0qlVsXAqs
 4Toq+I4GoCpMg14qEz9WuOW4COcQtQL1ySBtS3eeEgyGyvnoLdoQyQ3Kb18w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

