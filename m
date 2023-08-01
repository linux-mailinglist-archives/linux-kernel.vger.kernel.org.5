Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159276B48E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjHAMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjHAMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:15:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C81BCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:15:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so59672305e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690892153; x=1691496953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=uW3+z/FJ1yyrAcM1aXR3gh0niyVipdJ2upxPe3G1JH8SYp83XRj1Xmb/9K3iCNPnnX
         cKljFCCrz4LjonlGm4KwERur/A/ATgunBcFj0f134cmREG9S9z+AK7S13F1TYMvm2MaY
         jQ2rBx2m9EORDo7vnFVslXAB10ABjOaaB7kMMIg9nUDocGqKHfOPrdWh2BqZncVBjEzy
         qOrxD9kwyRK4zdTB4S256hxZ4eAoqjFJTwbJFl+e7K4C6/z1Xy1LmmMe+S5VLoIqhm0Z
         vADGmAkZHykoEQ4fl2v2lYBc30nX5WgIWtzfSRZDT+xsZJn50lzedDDxvmiLqNOzjiob
         ZlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892153; x=1691496953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5GSTRd7yWsW/2h2X+KrYHhvI8Ce18nIFifnprRO8h4=;
        b=RvYehCaFstab+ooYIpYY3Oxt3R/dhVJ5aJdoys8j3MMcbsX2dqOKGgBwo9WvQ2L9NY
         PiUaBbqvS09VickGiwY4N3ASwnCAVvFKg7KYjhs+Yx/mnER9jhJmcSwfd2uSA/MoOlPI
         hUegxUIB6jZx6Wwx8M4yHsFfsZri7vpiC8qVN7Xk7AvTESrVD2/QEYE+aBGNkyxPr19u
         yH9QNRWKdLYvFbiSBWuvEMHmFrD5XhMQOAB8Esrs79PS0zm/b4ufUaKOpaRYDLibYabl
         DcurDnavTrozGDu4uL5Ywi57UynR8TyX5hDfKRFTTZbaePtGIkBOyecLmT9rzB7Xunvm
         DcIQ==
X-Gm-Message-State: ABy/qLb0w4BJDCsW4tt/2V5o/NzKICAeJFiG5wNftN0xRxq5O/Qc35ts
        GoWhH17hedeeNLYF93jsEJ8uvg==
X-Google-Smtp-Source: APBJJlFahpxMFv0vloTflNwx+qChRjTLQTZaYj2SP3VPYhgtFfO0O6F0OOcI5GDps1zw/GKDBYskSg==
X-Received: by 2002:a5d:4ac2:0:b0:317:74ce:3e27 with SMTP id y2-20020a5d4ac2000000b0031774ce3e27mr2028948wrs.67.1690892153758;
        Tue, 01 Aug 2023 05:15:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm15874351wrq.115.2023.08.01.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 05:15:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 01 Aug 2023 14:15:47 +0200
Subject: [PATCH v5 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-topic-goodix-berlin-upstream-initial-v5-3-079252935593@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4476;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fvuZaiaDmAw7atVHwbHQLhUjO6UmtXJUopSvbqmyj84=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkyPd0ws0YwW2QzrE9dyOLQqekN+ir5uKYokiF9rjq
 ZaZdrhKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZMj3dAAKCRB33NvayMhJ0fpzD/
 97wAGdU2hqMDMeQ4u6tB3Sa8PP8TnhslBV91ZTVuU/jaoW6CWn+EmjglHuiMOdTqW0s8C6VCrp0vj5
 5g/fZV9pvC5HeeJUiyIN4txeKvsGTkqgcrD+pbw7ZAr7rGkjxSfa/Q2ecCfn7RFqnvfPExG3xbNuNH
 /c9accgNzsGr5vvhthKhtgtaauA8KrOQNCIj9+iw22EUsLzwCdfEMLY/hIZPmht2eok2Kw4sUSSpdm
 pQ1wUq4u/rna/EqLwvivppbf8zUVbTMhaEDA20Uj43QlbPO4MsfZb3UYjV9R5+yApzIFt5a7whUFAG
 XLpvaQlD1MsCzVrFBDl/dxi5zRn12t2lgPl1CmWI++UnTGH7w1K96LwfLL6LUEXZMy5SMM1t9xFhXb
 YYjpWPpAaR5xptplQ5ZrM5e96WrtXBJ0oRYN2aoDz3jQ35Fp4Ct90TI+1QLIWSQGmzAjpqXAfVdPlq
 KgyS2e3nMWsiPxz8oyey8c7WFFiU8n/h+MRTR/Jv8GH0gCIO7RJbH8qQGElTzinomyhyeYa01thMda
 OS4k7d/zBE5Xko0RjG2lHYmqqJbEglEXCe7SyYHVtcA71yk9xwLqfQHonCIbelXiuZPqxOxyUTg77D
 j3cKQM4/DeEa2VpxL52KE3tkWoMZp1ahCh92OfF1YvGMA+DkYGjLPqHAvk3Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

