Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E41754173
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjGNRxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbjGNRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:55 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17D3C21;
        Fri, 14 Jul 2023 10:52:24 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7836164a08aso89291239f.1;
        Fri, 14 Jul 2023 10:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357082; x=1691949082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dF4n+vEE17Qq7IimdaDehhBcYp03QjXAht/0wjN/cV4=;
        b=V5r2NlfzER6+7EC0qr0X3Br9Jt641f/62ioswaSjDEDQ7Y3IZMFXRPlYhwL4N7N/GV
         Xf4xfCb9QIcclmwjjhyvpXlaEfB4u9mmV2xJ5VhZoix3nLrJGr7zM9zb1nDhHNb3oy+6
         husehaZM5yVxDBkltWsHImhtrlmxep7aKdHCjRyBce91ICeFiMsqTjy1rlR5rLzDoQyf
         AxKul53K3P1Od0LQwYVH8T7FsrTO0slVlKWnrkVCy7xo6Y+2NbdIdsCFhQnjNcaniA0i
         /ydhIWW257ST+BL1A2uNsDLMGz5ZPPYDCpUcxFgvediaxwa6ufmJRmu1I7FaDP1koQqD
         i+7w==
X-Gm-Message-State: ABy/qLbMKY1R8N2VtYztrvfhnV6HkYpA6V16PvgrUKWRwHTalXAhP+29
        Vh1h2SVlTS/kHuA8t4OghQ==
X-Google-Smtp-Source: APBJJlFLGGnoSpdHLXPQqOC5AFwgGsTwxYgrStVtkh9c/1mRFbH+mCv+ucvO9R8FXklrZzo9AEm9Iw==
X-Received: by 2002:a6b:fb03:0:b0:783:572c:9caa with SMTP id h3-20020a6bfb03000000b00783572c9caamr5742918iog.0.1689357082545;
        Fri, 14 Jul 2023 10:51:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h2-20020a6bfb02000000b0078680780694sm2789173iog.34.2023.07.14.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:51:21 -0700 (PDT)
Received: (nullmailer pid 4065772 invoked by uid 1000);
        Fri, 14 Jul 2023 17:50:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] watchdog: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:50:38 -0600
Message-Id: <20230714175040.4065660-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
 drivers/watchdog/armada_37xx_wdt.c | 1 -
 drivers/watchdog/at91rm9200_wdt.c  | 3 +--
 drivers/watchdog/cpwd.c            | 2 +-
 drivers/watchdog/ftwdt010_wdt.c    | 6 ++----
 drivers/watchdog/imx2_wdt.c        | 3 +--
 drivers/watchdog/imx7ulp_wdt.c     | 1 -
 drivers/watchdog/meson_wdt.c       | 4 ++--
 drivers/watchdog/mtk_wdt.c         | 1 -
 drivers/watchdog/of_xilinx_wdt.c   | 3 +--
 drivers/watchdog/pic32-dmt.c       | 3 +--
 drivers/watchdog/pic32-wdt.c       | 3 +--
 drivers/watchdog/pika_wdt.c        | 2 +-
 drivers/watchdog/qcom-wdt.c        | 1 -
 drivers/watchdog/rave-sp-wdt.c     | 2 +-
 drivers/watchdog/riowd.c           | 2 +-
 drivers/watchdog/rza_wdt.c         | 4 ++--
 drivers/watchdog/rzg2l_wdt.c       | 2 +-
 drivers/watchdog/s3c2410_wdt.c     | 1 -
 drivers/watchdog/sama5d4_wdt.c     | 1 -
 drivers/watchdog/sbsa_gwdt.c       | 3 +--
 drivers/watchdog/starfive-wdt.c    | 3 ++-
 drivers/watchdog/stm32_iwdg.c      | 1 -
 drivers/watchdog/sunxi_wdt.c       | 1 -
 drivers/watchdog/xilinx_wwdt.c     | 4 ++--
 24 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/armada_37xx_wdt.c b/drivers/watchdog/armada_37xx_wdt.c
index e58652939f8a..8133a5d05647 100644
--- a/drivers/watchdog/armada_37xx_wdt.c
+++ b/drivers/watchdog/armada_37xx_wdt.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index d20ec27ba354..558015f08c7a 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/atmel-st.h>
 #include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
@@ -26,8 +27,6 @@
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
 #define WDT_MAX_TIME		256	/* seconds */
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 47250f9b68c7..901b94d456db 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -31,7 +31,7 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <asm/irq.h>
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index 442c5bf63ff4..28f5af752c10 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
@@ -221,20 +221,18 @@ static const struct dev_pm_ops ftwdt010_wdt_dev_pm_ops = {
 				ftwdt010_wdt_resume)
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id ftwdt010_wdt_match[] = {
 	{ .compatible = "faraday,ftwdt010" },
 	{ .compatible = "cortina,gemini-watchdog" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ftwdt010_wdt_match);
-#endif
 
 static struct platform_driver ftwdt010_wdt_driver = {
 	.probe		= ftwdt010_wdt_probe,
 	.driver		= {
 		.name	= "ftwdt010-wdt",
-		.of_match_table = of_match_ptr(ftwdt010_wdt_match),
+		.of_match_table = ftwdt010_wdt_match,
 		.pm = &ftwdt010_wdt_dev_pm_ops,
 	},
 };
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 6fcc3596103c..1a27665a2f53 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -26,8 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 7ca486794ba7..c703586c6e5f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 539feaa1f904..497496f64f55 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -11,11 +11,11 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a9c437598e7e..b2330b16b497 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -25,7 +25,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 2a079ca04aa3..05657dc1d36a 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -10,14 +10,13 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 
 /* Register offsets for the Wdt device */
 #define XWT_TWCSR0_OFFSET   0x0 /* Control/Status Register0 */
diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index bc4ccddc75a3..466b4a41411f 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -10,9 +10,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 6d1a00222991..4d7eaf290e1c 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -10,9 +10,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index a98abd0d3146..782b8c23d99c 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -23,8 +23,8 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #define DRV_NAME "PIKA-WDT"
 
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index d776474dcdf3..9e790f0c2096 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
-#include <linux/of_device.h>
 
 enum wdt_reg {
 	WDT_RST,
diff --git a/drivers/watchdog/rave-sp-wdt.c b/drivers/watchdog/rave-sp-wdt.c
index 2c95615b6354..5d1c2176d445 100644
--- a/drivers/watchdog/rave-sp-wdt.c
+++ b/drivers/watchdog/rave-sp-wdt.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/rave-sp.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index c04b383e1712..b293792a292a 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -14,7 +14,7 @@
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index fe6c2ed35e04..cb4901b3f777 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -9,9 +9,9 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d404953d0e0f..1741f98ca67c 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -11,7 +11,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 95416a9bdd4b..2bcc8faa7fa5 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index aeee934ca51b..71e8b5fbf51f 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index fd3cfdda4949..421ebcda62e6 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -43,10 +43,9 @@
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 8058fca4d05d..9e6db8e0164f 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -8,7 +8,8 @@
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index 570a71509d2a..fa5e70c4b93a 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 6cf82922d3fb..b85354a99582 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
diff --git a/drivers/watchdog/xilinx_wwdt.c b/drivers/watchdog/xilinx_wwdt.c
index 2585038d5575..1d998db41533 100644
--- a/drivers/watchdog/xilinx_wwdt.c
+++ b/drivers/watchdog/xilinx_wwdt.c
@@ -9,9 +9,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
 /* Max timeout is calculated at 100MHz source clock */
-- 
2.40.1

