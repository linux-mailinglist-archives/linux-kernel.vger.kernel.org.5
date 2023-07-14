Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAB7541DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbjGNRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjGNRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:51:43 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039235B7;
        Fri, 14 Jul 2023 10:51:24 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-345d6dc271dso9717815ab.0;
        Fri, 14 Jul 2023 10:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357002; x=1691949002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f9hPpq/FXIH2pHQG9BDcclVOF3HlSLvSdnqDrW8SI0=;
        b=Jm/Iij8cFfdgf2PJr7ntOaY3gjcwNWbifeGjloE8C0NLPJpB7i00FUt7RBg5Nz86O9
         Y0I38BVhhYc3sZTFspKUPNW16z2fDKFC/w1PqaB2ZtPv7nh4qog24xaQEKkcZsezHnIe
         VQUbCpHQviLjI0DyUdjS/zwOLJg3mS42MD6t/YYkvsS76KiZX1rxIcfqxNrbkNW8kkV3
         9RoPte1q7kt1KIy7AA4l+FO6pT5B1Oae6la45Qgpt8iydlKm/N9gzN/mUnyHRSZO7NDC
         ShlUzOCWhdnvRDa88tc2TWmvVT3jwkAj35U+XXu2o0Y9HWpP0G/iO0lUGeuT2ccBxtgy
         66Yg==
X-Gm-Message-State: ABy/qLaVGn/2OYKeVwpihufJicj7ZYBcz/X6tdf/+hO2i/pJ2ToWi76G
        vGVYR9NlequlOA+rOkbwjQ==
X-Google-Smtp-Source: APBJJlEmRadOVoGt8KXkozByqFztIzgh8zxRONlCM8tFyXmfW6xPPXdHjET1RPuYiepJ5yWUm0smmA==
X-Received: by 2002:a92:d08c:0:b0:347:693a:a52b with SMTP id h12-20020a92d08c000000b00347693aa52bmr4722888ilh.6.1689357001812;
        Fri, 14 Jul 2023 10:50:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c13-20020a92dc8d000000b00345da2c4776sm2856766iln.81.2023.07.14.10.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:01 -0700 (PDT)
Received: (nullmailer pid 4063470 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] regulator: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:28 -0600
Message-Id: <20230714174930.4063320-1-robh@kernel.org>
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
 drivers/regulator/act8945a-regulator.c      | 2 +-
 drivers/regulator/atc260x-regulator.c       | 3 ++-
 drivers/regulator/axp20x-regulator.c        | 1 -
 drivers/regulator/cpcap-regulator.c         | 2 +-
 drivers/regulator/fan53555.c                | 2 +-
 drivers/regulator/fixed.c                   | 1 -
 drivers/regulator/ltc3589.c                 | 1 -
 drivers/regulator/max77826-regulator.c      | 1 -
 drivers/regulator/mp5416.c                  | 2 +-
 drivers/regulator/mp886x.c                  | 2 +-
 drivers/regulator/mpq7920.c                 | 1 -
 drivers/regulator/mt6315-regulator.c        | 2 +-
 drivers/regulator/mt6359-regulator.c        | 3 ++-
 drivers/regulator/mtk-dvfsrc-regulator.c    | 3 +--
 drivers/regulator/pbias-regulator.c         | 1 -
 drivers/regulator/pca9450-regulator.c       | 1 -
 drivers/regulator/pwm-regulator.c           | 2 +-
 drivers/regulator/qcom-rpmh-regulator.c     | 1 -
 drivers/regulator/qcom_smd-regulator.c      | 1 -
 drivers/regulator/qcom_usb_vbus-regulator.c | 1 -
 drivers/regulator/rk808-regulator.c         | 3 ++-
 drivers/regulator/rt5759-regulator.c        | 2 +-
 drivers/regulator/stm32-pwr.c               | 3 +--
 drivers/regulator/stm32-vrefbuf.c           | 2 +-
 drivers/regulator/sy8824x.c                 | 2 +-
 drivers/regulator/sy8827n.c                 | 2 +-
 drivers/regulator/tps6286x-regulator.c      | 2 +-
 drivers/regulator/tps6287x-regulator.c      | 2 +-
 drivers/regulator/tps65218-regulator.c      | 2 +-
 drivers/regulator/tps65219-regulator.c      | 2 +-
 drivers/regulator/tps6594-regulator.c       | 2 +-
 drivers/regulator/twl-regulator.c           | 1 -
 drivers/regulator/twl6030-regulator.c       | 1 -
 drivers/regulator/uniphier-regulator.c      | 2 +-
 drivers/regulator/vctrl-regulator.c         | 2 +-
 drivers/regulator/vexpress-regulator.c      | 3 ++-
 36 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index e26264529b74..24cbdd833863 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index 87e237d740bc..09fe51464090 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -7,7 +7,8 @@
 
 #include <linux/mfd/atc260x/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 810f90f3e2a1..c657820b0bbb 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -20,7 +20,6 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index 1fd79fb17303..6958d154442b 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -12,7 +12,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 289c06e09f47..48f312167e53 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -12,7 +12,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/param.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 364d1a2683b7..55130efae9b8 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -25,7 +25,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
 #include <linux/clk.h>
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index e9751c206d95..cf931b8c36dc 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max77826-regulator.c
index 3855f5e686d8..5590cdf615b7 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 3886b252fbe7..d068ac93d373 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -10,7 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index ede1b1e58002..9911be2e6bac 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -9,7 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index bf677c535edc..4926c229109b 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 8047081ea2f7..2608a6652d77 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2021 MediaTek Inc.
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index 3eb86ec21d08..5cf6448fb05f 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -2,12 +2,13 @@
 //
 // Copyright (c) 2021 MediaTek Inc.
 
+#include <linux/platform_device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mt6359/registers.h>
 #include <linux/mfd/mt6359p/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
index efca67207a5a..f1280d45265d 100644
--- a/drivers/regulator/mtk-dvfsrc-regulator.c
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -6,8 +6,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of_.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/soc/mediatek/mtk_dvfsrc.h>
diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 0c9873e9abdc..cd5a0d7e4455 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -25,7 +25,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 struct pbias_reg_info {
 	u32 enable;
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 91bfb7e026c9..2ab365d2749f 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index b64d99695b84..2aff6db748e2 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -10,11 +10,11 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pwm.h>
 #include <linux/gpio/consumer.h>
 
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index f3b280af0773..ec1b50721ec6 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -7,7 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 18189f35db68..f53ada076252 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -6,7 +6,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 57ec613f4a0a..cd94ed67621f 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -8,7 +8,6 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 460525ed006c..867a2cf243f6 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -17,9 +17,10 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/mfd/rk808.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/gpio/consumer.h>
diff --git a/drivers/regulator/rt5759-regulator.c b/drivers/regulator/rt5759-regulator.c
index 90555a9ef1b0..c2553dcee050 100644
--- a/drivers/regulator/rt5759-regulator.c
+++ b/drivers/regulator/rt5759-regulator.c
@@ -4,7 +4,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 4c60eddad60d..85b0102fb9b1 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -6,8 +6,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index f5ccc7dd309a..717144cbe0f9 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index d0703105c439..d49c0cba09fb 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -8,7 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
index 433959b43549..f11ff38b36c9 100644
--- a/drivers/regulator/sy8827n.c
+++ b/drivers/regulator/sy8827n.c
@@ -9,7 +9,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index b1c4b5120745..c06f6d1dc737 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -4,7 +4,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index b1c0963586ac..19a4a300a963 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -8,8 +8,8 @@
 
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 13985883e5f0..f44b5767099c 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -8,12 +8,12 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 8971b507a79a..b4065356392f 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -15,8 +15,8 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index d5a574ec6d12..25ef102c8270 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 3e724f5345de..5bacfcebf59a 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index f9c695f9bde8..6eed0f6e0adb 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 7e2785e10dc6..1d8304b88bd6 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -7,7 +7,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index 85dca90233f6..2796580a3a3c 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -10,7 +10,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/coupler.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index b545dbc70a4d..6687077e9a97 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -8,7 +8,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
-- 
2.40.1

