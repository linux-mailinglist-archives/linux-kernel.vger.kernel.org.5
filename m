Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2E7D3A51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjJWPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjJWPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:03:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A70D78
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so44851151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698073434; x=1698678234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tid5p5CbwnFew1OoFmZZ3rTS9lA993ke+t72lpp1p7Y=;
        b=Oyd9zGSJxa3DBMR/PFVU17TdcOyvbb+zHHRoVl4/an8vufXPinmAwR7mL9ej3V04kG
         GAY0IDAahGSlrxO03ohrH0o+TerydIfhrW8hgefyizH/EExSx48Wh3YFQOH0DGnwBj3l
         FWDHILzqBru678YNsdlJBMfW2zNGrdXx/KeCxt2BhRGuk/GBNONL2Y9d1d7iTlJY1EZw
         nIZ38V+Hb0WN4UoDHgmSM9Z/3vxf7ID7z+9BeGAQX7EG4qppkMkH/hIo9dj/eEWOqO75
         avC2Ev9O2f3gXNvBYQ/RU7l2I9JnedktnBw7kSg11NhODnGu1KkJFcIQaze8HLc2THE5
         KMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698073434; x=1698678234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tid5p5CbwnFew1OoFmZZ3rTS9lA993ke+t72lpp1p7Y=;
        b=AsntswSbfx59MIpK8+epCYPwXD7a8Rp7vY7JYQFT9mEhTnJpGriu7YowxR1CQ6qO2R
         pKJhVEE0x0I1Bd+NEt4Hf3sD0EWo7LW8gcVRL9MbWv6BtsCu+aAtktlgivG88+58wv7j
         XcSECDwDK3MtEbU6UWl5VRbotBCl+wVRW/uouqXvmtPfuSohprLwzSVZGzIsiV0KV+9K
         aAPkrflqamb2sDs7ZbtQZVQ10kSgZdQ2h1pjkP7sMhIRXEfTc5wcpOgDgxN9EluZsgxC
         WgkOUxUXoOD6D7QQ74LhynmRt/DlgI1PHpWg3UGOkaIov1n5XZStKbpdAmKHbspBh5at
         vrIw==
X-Gm-Message-State: AOJu0YwRfCvBtajbjgkq45FOPeY0U0U7sLFSFa8tlDFaloTnAJBgx529
        EIFsPJ2WU1/+W+NX1yycRpRmFw==
X-Google-Smtp-Source: AGHT+IFYipqnYVMc+dXRB8284ojY/kaYRgOeUGtLVaMAT6s3DVLfJpJqcGgWssNKNCISPjnH3WIt9A==
X-Received: by 2002:a2e:8698:0:b0:2c4:feef:852 with SMTP id l24-20020a2e8698000000b002c4feef0852mr6337269lji.32.1698073433779;
        Mon, 23 Oct 2023 08:03:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b0040586360a36sm14235016wmg.17.2023.10.23.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 08:03:53 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Oct 2023 17:03:47 +0200
Subject: [PATCH v10 3/4] Input: goodix-berlin - add I2C support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-topic-goodix-berlin-upstream-initial-v10-3-88eec2e51c0b@linaro.org>
References: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
In-Reply-To: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4539;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/29OxaflwzQer1E/gOu8Bz3LG+5phtsz3jcz094am9k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNotUh6GD6N/wKjhsph9KLWVx8cc0ILFqr5Zo3VPL
 lrQ9ZaiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTaLVAAKCRB33NvayMhJ0bKxD/
 92wk8POiJlNWDBc1WFHN4z3shorDsqvZEEp1vCUpq6yN3K8bTaTDGBSv/jfc6Kcvg1c5AJ18bV505S
 ZncYaU9P+fKH2dyhs1oGHJ6AwnHYDPpoNOpcxyZYlGsAZxdF9py+fcur6aR1E7/m19TjMSQGMeP1+4
 PXRuPoGXNbO3fpEnc65DAd9FHowXnOuaS1sXz3td0N7CTrbFJzf4uefaVVd3RvrUyQMsf12HZlnRAh
 vI17MOLDT39W5TT1y/WScHVC8x8p+wVvAxL8YeJHdrCDPStH1XS0TQ2M45WqhjydiPNkU/Q/BmoG2I
 s5Pv4UXkO5cg/QysmH2zKvR4pgU4CTvUE70jbn5143eSjiNziHioqsni1i15R8JChwjMJDyqasDKh2
 T1Z0Al8HN9bsiX2RKPT61gskhUPRpoCgHVFdCVgYXe2V8NBs5ULTpYaiiwkI7RPupQmfaLIpNDlswd
 cRIe63ciRRw7yEzmvYqY6FdoGEVZ9FevOYgzOBz7yXAIr0kl+s/SmcsxzayOezj+pwzA5EfV61mYsS
 IYJwXQbKnVhmrNPPblL/WYqmLDVGEK+cyhfqMQX4uJe1UjpoYVCehkR9ZFOy5BAzHe7qajPGZSOs9x
 JWb+Om6EqC+6CmLgqfrPVmlCH6ETRnEQ+kJnUSZftkrLCfxRkQUlijFSQFhw==
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
 drivers/input/touchscreen/Kconfig             | 14 +++++
 drivers/input/touchscreen/Makefile            |  1 +
 drivers/input/touchscreen/goodix_berlin_i2c.c | 74 +++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

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
index 000000000000..4d5bcc101569
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
@@ -0,0 +1,74 @@
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
+	int error;
+
+	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	error = goodix_berlin_probe(&client->dev, client->irq,
+				    &goodix_berlin_i2c_input_id, regmap);
+	if (error)
+		return error;
+
+	return 0;
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

