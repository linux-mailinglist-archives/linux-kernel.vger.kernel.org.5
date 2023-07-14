Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C493575418E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjGNRwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjGNRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5A35A9;
        Fri, 14 Jul 2023 10:51:56 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so9691275ab.2;
        Fri, 14 Jul 2023 10:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356967; x=1691948967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhnvM9gixJIVMpRuI188FUpVFikttdi1fELDz+40xxo=;
        b=Zc6xNUENVqvHeTm4U/sC2bPBHFbc6gy+ymQ9KN8W63K/Tyk96DSDBApr2Z0AlJqL/U
         qTN+JpwT4rh/Xso4t4uUmMzhKqz2VYhuCXYL5FDBWwCVPyq54IKMXqwx9f3QfGwoNMKh
         +57dadkkDCxjoNTmRZzgUlhKfLPYHKQ/ZzxlzPGpeSubLekFVvic7z0QgXbleWXCIEw+
         7gE/qC/fpaLszfWkqIiuTk47NzprtTJrotxycuEWFbcI9WS2FgmIwJVqH69Mm3csVB3A
         2KooKAz/9PpFSOFlBe1RF3XCkK04PAlfGQFr+cPqQiSHfTArxg9XAfa8be95KLEGwE1w
         24jg==
X-Gm-Message-State: ABy/qLZqkeemywqxSvX1QWs4IogORXaCQmDaFTQw0YiswI7k2ziYPI4F
        Z6LEretdEPE6O4SusdNpfg==
X-Google-Smtp-Source: APBJJlFh6RzBTn97GyDHCLrzfUOzaI6U5n6O355tArHJ1Cl54zjAGWC4PSZzgdrU82ofGimkiOYsMg==
X-Received: by 2002:a92:60c:0:b0:345:cf3f:2fd with SMTP id x12-20020a92060c000000b00345cf3f02fdmr5243543ilg.13.1689356966826;
        Fri, 14 Jul 2023 10:49:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b003460b697bc0sm2883862ilq.59.2023.07.14.10.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:26 -0700 (PDT)
Received: (nullmailer pid 4062354 invoked by uid 1000);
        Fri, 14 Jul 2023 17:48:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH] pwm: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:48:50 -0600
Message-Id: <20230714174852.4062251-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/pwm/core.c               | 1 +
 drivers/pwm/pwm-apple.c          | 1 +
 drivers/pwm/pwm-atmel-hlcdc.c    | 1 +
 drivers/pwm/pwm-atmel-tcb.c      | 3 +--
 drivers/pwm/pwm-atmel.c          | 1 -
 drivers/pwm/pwm-berlin.c         | 1 +
 drivers/pwm/pwm-cros-ec.c        | 1 +
 drivers/pwm/pwm-fsl-ftm.c        | 3 +--
 drivers/pwm/pwm-hibvt.c          | 2 +-
 drivers/pwm/pwm-imx1.c           | 1 -
 drivers/pwm/pwm-jz4740.c         | 2 +-
 drivers/pwm/pwm-lp3943.c         | 1 +
 drivers/pwm/pwm-lpc18xx-sct.c    | 1 +
 drivers/pwm/pwm-mediatek.c       | 1 -
 drivers/pwm/pwm-meson.c          | 1 -
 drivers/pwm/pwm-microchip-core.c | 2 +-
 drivers/pwm/pwm-mtk-disp.c       | 1 -
 drivers/pwm/pwm-pxa.c            | 1 +
 drivers/pwm/pwm-sifive.c         | 1 +
 drivers/pwm/pwm-sl28cpld.c       | 1 +
 drivers/pwm/pwm-sprd.c           | 1 +
 drivers/pwm/pwm-sun4i.c          | 1 -
 drivers/pwm/pwm-sunplus.c        | 1 +
 drivers/pwm/pwm-tegra.c          | 1 -
 drivers/pwm/pwm-tiecap.c         | 2 +-
 drivers/pwm/pwm-tiehrpwm.c       | 2 +-
 drivers/pwm/pwm-visconti.c       | 2 +-
 drivers/pwm/pwm-vt8500.c         | 5 +----
 28 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9..d37617c60eae 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pwm.h>
 #include <linux/radix-tree.h>
 #include <linux/list.h>
diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index a38a62edd713..8e7d67fb5fbe 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -12,6 +12,7 @@
  * - When APPLE_PWM_CTRL is set to 0, the output is constant low
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 96a709a9d49a..3c42061e721a 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/mfd/atmel-hlcdc.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 4a116dc44f6e..563162d660d8 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -19,8 +19,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <soc/at91/atmel_tcb.h>
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 5f7d286871cf..4b243c0e8490 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 0c5992a046b2..0971c666afd1 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 74e863aa1d8d..7f7e4e892930 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 5caadbd6194e..b7c6045c5d08 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -11,8 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index b95df1a96127..f7ba6fe9a349 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/reset.h>
diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index 1f2eb1c8ff6c..0651983bed19 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3b7067f6cd0d..ef1293f2a897 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -15,7 +15,7 @@
 #include <linux/mfd/ingenic-tcu.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 35675e4058c6..a931d3f7a3fc 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/mfd/lp3943.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index b9bf5b366f4b..9ff6311bd472 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 7a51d210a877..6adb0ed01906 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 22f54db3ae8e..25519cddc2a9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -37,7 +37,6 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index 8750b57684a9..e7525c98105e 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -37,7 +37,7 @@
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 2401b6733241..a83bd6e18b07 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 762429d5647f..c8314053bcb0 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -15,6 +15,7 @@
  *   input clock (PWMCR_SD is set) and the output is driven to inactive.
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index ae49d67ab2b1..3743b2de4597 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -13,6 +13,7 @@
  */
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index e64900ad4ba1..d497e87f5e03 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -38,6 +38,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index d43a6fa3f4e0..1499c8c1fe37 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/math64.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a8790a8fc53e..c84fcf1a13dc 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -17,7 +17,6 @@
 #include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/reset.h>
diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index d6ebe9f03b35..7705c7b86c3a 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5810abf66e2a..a169a34e0778 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -41,7 +41,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pm_opp.h>
 #include <linux/pwm.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 109449956307..8c94b266c1b2 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -12,7 +12,7 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 /* ECAP registers and bits definitions */
 #define CAP1			0x08
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index bb3959ace6b4..ecbfd7e954ec 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -12,7 +12,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 /* EHRPWM registers and bits definitions */
 
diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index e3fb79b3e2a7..7f7591a2384c 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index d2c48fd98706..6d46db51daac 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -18,10 +19,6 @@
 
 #include <asm/div64.h>
 
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
-
 /*
  * SoC architecture allocates register space for 4 PWMs but only
  * 2 are currently implemented.
-- 
2.40.1

