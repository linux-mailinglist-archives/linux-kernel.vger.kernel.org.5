Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330175414E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjGNRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjGNRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:49:17 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C14498;
        Fri, 14 Jul 2023 10:48:38 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7878e573827so25154639f.1;
        Fri, 14 Jul 2023 10:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356867; x=1691948867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICbIxBggvPk547FUGqro9NdXSvlGHtO2U3inKPVGuSA=;
        b=HR+eLlRch15aNvN9g5RA7jxJ+Q8NRVqpjjgdlmjCKQnGgi4SRmrHoWHqZBf8iNSupc
         QZWGqeZDY6wK3/7mfK9U0krhkmsydNcRCeuc043+TLYvnr23cLiJaOr+TUUovaWfbUuW
         xBswmjlZCd7cmeb2kq82zadH5AB+iqw0kNUkoAp6X5G1BWecb33SBWpAS6s5fLJm1lMG
         ogRf7osFhmc6xRQIzMmlNd0qiN6BPj0oFXTBKN3Tr6BNkQYr9Jubq/sGNJJ/vB6rXc0c
         hgJndKj31mQ5LG4yTfmoEdweMug4+vPxHOcvBhFFfkDYXwDcxmJVLVxI3ZkqKbjsdviH
         c/Cg==
X-Gm-Message-State: ABy/qLbMXcMIi8CRJzo2E4o4Pf11yEdYHTkyjZtdFFtWsxD7xDWtLrDp
        D7gE3rHfA0m71steNikynw==
X-Google-Smtp-Source: APBJJlGH+R2BvQ9KvHpHsm/o0CzXHFPiEpDs3Uvnbqu4igFL4eqNBHU2HeHkZDQCaxk3jV9V47ju2A==
X-Received: by 2002:a05:6602:19da:b0:786:ea57:22e2 with SMTP id ba26-20020a05660219da00b00786ea5722e2mr5915931iob.20.1689356867296;
        Fri, 14 Jul 2023 10:47:47 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f29-20020a02cadd000000b004290985a1efsm2769410jap.43.2023.07.14.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:46 -0700 (PDT)
Received: (nullmailer pid 4059973 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-actions@lists.infradead.org, chrome-platform@lists.linux.dev,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-mtd@lists.infradead.org
Subject: [PATCH] mfd: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:27 -0600
Message-Id: <20230714174731.4059811-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/ab8500-core.c           | 1 -
 drivers/mfd/acer-ec-a500.c          | 2 +-
 drivers/mfd/act8945a.c              | 2 +-
 drivers/mfd/altera-sysmgr.c         | 3 +--
 drivers/mfd/arizona-core.c          | 1 -
 drivers/mfd/atc260x-core.c          | 1 -
 drivers/mfd/bcm590xx.c              | 1 -
 drivers/mfd/cros_ec_dev.c           | 2 +-
 drivers/mfd/da9052-i2c.c            | 5 +----
 drivers/mfd/da9055-i2c.c            | 1 -
 drivers/mfd/da9062-core.c           | 2 +-
 drivers/mfd/hi655x-pmic.c           | 4 ++--
 drivers/mfd/iqs62x.c                | 2 +-
 drivers/mfd/lp873x.c                | 2 +-
 drivers/mfd/madera-i2c.c            | 1 -
 drivers/mfd/madera-spi.c            | 1 -
 drivers/mfd/max77620.c              | 1 -
 drivers/mfd/max77686.c              | 1 -
 drivers/mfd/max77843.c              | 2 +-
 drivers/mfd/max8907.c               | 1 -
 drivers/mfd/max8925-core.c          | 1 -
 drivers/mfd/max8997.c               | 1 -
 drivers/mfd/max8998.c               | 1 -
 drivers/mfd/mt6358-irq.c            | 5 ++---
 drivers/mfd/mt6397-core.c           | 5 +++--
 drivers/mfd/mt6397-irq.c            | 5 ++---
 drivers/mfd/palmas.c                | 3 ++-
 drivers/mfd/qcom-pm8008.c           | 2 +-
 drivers/mfd/rave-sp.c               | 2 +-
 drivers/mfd/rk8xx-core.c            | 2 +-
 drivers/mfd/rohm-bd71828.c          | 2 +-
 drivers/mfd/rohm-bd718x7.c          | 2 +-
 drivers/mfd/rohm-bd9576.c           | 2 +-
 drivers/mfd/rt5033.c                | 2 +-
 drivers/mfd/rz-mtu3.c               | 4 +++-
 drivers/mfd/sec-core.c              | 2 --
 drivers/mfd/sprd-sc27xx-spi.c       | 2 +-
 drivers/mfd/ssbi.c                  | 6 +++---
 drivers/mfd/stm32-lptimer.c         | 1 +
 drivers/mfd/stm32-timers.c          | 1 +
 drivers/mfd/sun4i-gpadc.c           | 4 ++--
 drivers/mfd/ti-lmu.c                | 1 -
 drivers/mfd/ti_am335x_tscadc.c      | 2 +-
 drivers/mfd/tps6507x.c              | 1 -
 drivers/mfd/tps65090.c              | 1 -
 drivers/mfd/tps65217.c              | 1 -
 drivers/mfd/tps65218.c              | 1 -
 drivers/mfd/tps6594-core.c          | 2 +-
 drivers/mfd/twl6040.c               | 2 --
 drivers/mfd/wm831x-core.c           | 3 +--
 drivers/mtd/chips/cfi_cmdset_0002.c | 3 +--
 51 files changed, 42 insertions(+), 66 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 9d9e9787d5e8..15c95828b09a 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -21,7 +21,6 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/dbx500-prcmu.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 /*
  * Interrupt register offsets
diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
index feb757e90dc3..79405835ff8e 100644
--- a/drivers/mfd/acer-ec-a500.c
+++ b/drivers/mfd/acer-ec-a500.c
@@ -9,7 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index 2406fcdff5f9..64876537f066 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -10,7 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 static const struct mfd_cell act8945a_devs[] = {
diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index af205813b281..0e52bd2ebd74 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -14,8 +14,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index c166fcd331f1..19a0adf8ce3d 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/mfd/atc260x-core.c b/drivers/mfd/atc260x-core.c
index 7c5de3ae776e..67473b58b03d 100644
--- a/drivers/mfd/atc260x-core.c
+++ b/drivers/mfd/atc260x-core.c
@@ -11,7 +11,6 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #define ATC260X_CHIP_REV_MAX	31
diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 9f39b46b87f4..92eede9a5e61 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 92f4dfccc3cc..79d393b602bf 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -10,7 +10,7 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/cros_ec_chardev.h>
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 541e2d47677e..fd000a21bcba 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -13,14 +13,11 @@
 #include <linux/mfd/core.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <linux/mfd/da9052/da9052.h>
 #include <linux/mfd/da9052/reg.h>
 
-#ifdef CONFIG_OF
-#include <linux/of.h>
-#include <linux/of_device.h>
-#endif
 
 /* I2C safe register check */
 static inline bool i2c_safe_reg(unsigned char reg)
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index bbaf4f07f274..9a5f51b60bad 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -11,7 +11,6 @@
 #include <linux/i2c.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <linux/mfd/da9055/core.h>
 
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 48f58b6f5629..45da007d3e70 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/irq.h>
 #include <linux/mfd/core.h>
diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index a58e42ddcd0c..e6c5bd50751e 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -16,7 +16,7 @@
 #include <linux/mfd/hi655x-pmic.h>
 #include <linux/module.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -163,7 +163,7 @@ MODULE_DEVICE_TABLE(of, hi655x_pmic_match);
 static struct platform_driver hi655x_pmic_driver = {
 	.driver	= {
 		.name =	"hi655x-pmic",
-		.of_match_table = of_match_ptr(hi655x_pmic_match),
+		.of_match_table = hi655x_pmic_match,
 	},
 	.probe  = hi655x_pmic_probe,
 	.remove = hi655x_pmic_remove,
diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index dfe9cb79e6a1..e03b4d38fbb0 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -27,7 +27,7 @@
 #include <linux/mfd/iqs62x.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index 6639f0fad4ea..de7ab7aed3c6 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -7,8 +7,8 @@
 
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/lp873x.h>
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index 0968aa9733ac..a404ea26bc79 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -10,7 +10,6 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/madera/core.h>
diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
index da84eb50e53a..ad07ebe29e59 100644
--- a/drivers/mfd/madera-spi.c
+++ b/drivers/mfd/madera-spi.c
@@ -9,7 +9,6 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 5811ed8f4840..e63e8e47d908 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -30,7 +30,6 @@
 #include <linux/mfd/max77620.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 01833086ca7d..91c286c4571c 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -20,7 +20,6 @@
 #include <linux/mfd/max77686-private.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 static const struct mfd_cell max77686_devs[] = {
 	{ .name = "max77686-pmic", },
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index b3689c13a14d..fcff0c498c0f 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/max77693-common.h>
 #include <linux/mfd/max77843-private.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 static const struct mfd_cell max77843_devs[] = {
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 78b5ee688dec..8bbe7979db91 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/max8907.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 0246bbe80354..105d79b91493 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/max8925.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 
 static const struct resource bk_resources[] = {
 	{ 0x84, 0x84, "mode control", IORESOURCE_REG, },
diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 94c09a5eab32..110bef71f208 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 33a3ec5464fb..4cc426a6c767 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -12,7 +12,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/mutex.h>
diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index 389756436af6..49830b526ee8 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -3,6 +3,8 @@
 // Copyright (c) 2020 MediaTek Inc.
 
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/mfd/mt6357/core.h>
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/core.h>
@@ -11,9 +13,6 @@
 #include <linux/mfd/mt6359/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index f6c1f80f94a4..4449dde05021 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -6,9 +6,10 @@
 
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mt6323/core.h>
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 72f923e47752..886745b5b607 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -3,10 +3,9 @@
 // Copyright (c) 2019 MediaTek Inc.
 
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index a36f12402987..6e562bab62e4 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -18,7 +18,8 @@
 #include <linux/err.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/palmas.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 static const struct regmap_config palmas_regmap_config[PALMAS_NUM_CLIENTS] = {
 	{
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 94a8cca1d955..3ac3742f438b 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -9,7 +9,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 545196c85b5c..da50eba10014 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -18,7 +18,7 @@
 #include <linux/mfd/rave-sp.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/sched.h>
 #include <linux/serdev.h>
 #include <asm/unaligned.h>
diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index e8fc9e2ab1d0..11a831e92da8 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -14,7 +14,7 @@
 #include <linux/mfd/rk808.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reboot.h>
 
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 93d80a79b901..594718f7e8e1 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -15,7 +15,7 @@
 #include <linux/mfd/rohm-bd71828.h>
 #include <linux/mfd/rohm-generic.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 0b58ecc78334..4798bdf27afb 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -14,7 +14,7 @@
 #include <linux/mfd/rohm-bd718x7.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index 645673322ec0..bceac7016740 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/rohm-bd957x.h>
 #include <linux/mfd/rohm-generic.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 67b0a228db24..7e23ab3d5842 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -10,9 +10,9 @@
  */
 
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/rt5033.h>
 #include <linux/mfd/rt5033-private.h>
diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index 04006f4aa702..47bf4469d093 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -11,7 +11,9 @@
 #include <linux/irq.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/rz-mtu3.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index d2f631901886..a6b0d7300b2d 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -10,8 +10,6 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 #include <linux/mutex.h>
diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index d21f32cc784d..81e517cdfb27 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -8,7 +8,7 @@
 #include <linux/module.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/sc27xx-pmic.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index dee89db3471d..b0b0be483dbf 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -14,12 +14,12 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/ssbi.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 
 /* SSBI 2.0 controller registers */
 #define SSBI2_CMD			0x0008
diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
index fa322f4412c8..b2704a9809c7 100644
--- a/drivers/mfd/stm32-lptimer.c
+++ b/drivers/mfd/stm32-lptimer.c
@@ -9,6 +9,7 @@
 #include <linux/mfd/stm32-lptimer.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #define STM32_LPTIM_MAX_REGISTER	0x3fc
 
diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
index 44ed2fce0319..5937c16b9fcf 100644
--- a/drivers/mfd/stm32-timers.c
+++ b/drivers/mfd/stm32-timers.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/stm32-timers.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 
 #define STM32_TIMERS_MAX_REGISTERS	0x3fc
diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index d1cbea27b136..3029d48e982c 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -8,8 +8,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/sun4i-gpadc.h>
diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 4f06adad7b5e..cfc9f88b9842 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/ti-lmu-register.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 
 struct ti_lmu_data {
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 07825cfd8aa8..8762732bc691 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -14,7 +14,7 @@
 #include <linux/mfd/core.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 9716bf703c7a..95dafb0e9f00 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6507x.h>
 
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index a35ad70755fb..9245e11219f3 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps65090.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 
 #define NUM_INT_REG 2
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 60599291b315..029ecc32f078 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 619bf7adb20c..11e4e52b56be 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -15,7 +15,6 @@
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index 15f314833207..0fb9c5cf213a 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -9,7 +9,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps6594.h>
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index d85675a4d9a8..9ce34dfd99b3 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -16,8 +16,6 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index e86b6a4896a6..e7e68929275e 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -15,8 +15,7 @@
 #include <linux/mfd/core.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/mfd/wm831x/core.h>
 #include <linux/mfd/wm831x/pdata.h>
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 153fb8d0008e..df589d9b4d70 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -32,7 +32,6 @@
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/cfi.h>
@@ -650,7 +649,7 @@ struct mtd_info *cfi_cmdset_0002(struct map_info *map, int primary)
 
 			/*
 			 * Valid primary extension versions are: 1.0, 1.1, 1.2, 1.3, 1.4, 1.5
-			 * see: http://cs.ozerki.net/zap/pub/axim-x5/docs/cfi_r20.pdf, page 19 
+			 * see: http://cs.ozerki.net/zap/pub/axim-x5/docs/cfi_r20.pdf, page 19
 			 *      http://www.spansion.com/Support/AppNotes/cfi_100_20011201.pdf
 			 *      http://www.spansion.com/Support/Datasheets/s29ws-p_00_a12_e.pdf
 			 *      http://www.spansion.com/Support/Datasheets/S29GL_128S_01GS_00_02_e.pdf
-- 
2.40.1

