Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14A7541D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbjGNRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjGNRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B03A8D;
        Fri, 14 Jul 2023 10:52:04 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3461053677eso4990685ab.0;
        Fri, 14 Jul 2023 10:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357005; x=1691949005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwCfU5WdD2qSYTQMQGy0dzM6oIrsx8xs5THb/i6kQQc=;
        b=QNLCP8S9w5oNPwTe6RPtxDGNIgJQy2wWDywq8VPUCugGIG9IsyDnQaT4OELaAnY4KR
         deqbzKh7+dLGIDqxmmrQKPOeIfArV1waCZBo28LYrQ6zy7UrYV1yU5fCOI4QhG0wwyEu
         UhHVOu9K8B8D7CkzlQWyVbAa/bV4LWy1om5yE+Acrne7++429zQnGsb7TwNMEITuYpPR
         UAGGuPXj9FcpRuuHrZMF3yGdxP/96oYBBJbTBhgoreTxiPRB9XlVbYW6KTrMr8G48O64
         u0N4BoblfKOZTib7bedIPuQzL6y4mAJGVc5rWr+5oMkzcC9+bPcs59xnH60AjCUnRZfB
         OfyA==
X-Gm-Message-State: ABy/qLaG0Ghl4gsL4tvAFkMG15zZcdz1nQLRIXvA0LUak1T3exYDnZaC
        OcnSTl0yWIl9vWejyA34AA==
X-Google-Smtp-Source: APBJJlHuVoGJd3Eb6ztj+BZZHs7Ndt2Tbx3Jci+Y4GS+NdnMT8srmnrhevTc373DmIoUwldv2+CL8Q==
X-Received: by 2002:a92:7101:0:b0:345:873d:1102 with SMTP id m1-20020a927101000000b00345873d1102mr1778149ilc.15.1689357004836;
        Fri, 14 Jul 2023 10:50:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h7-20020a0566380f8700b00428737ce527sm2681636jal.63.2023.07.14.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:03 -0700 (PDT)
Received: (nullmailer pid 4063110 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
Subject: [PATCH] power: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:17 -0600
Message-Id: <20230714174919.4062992-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
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
 drivers/power/reset/as3722-poweroff.c            | 1 -
 drivers/power/reset/brcm-kona-reset.c            | 4 ++--
 drivers/power/reset/gpio-poweroff.c              | 3 ++-
 drivers/power/reset/gpio-restart.c               | 3 ++-
 drivers/power/reset/keystone-reset.c             | 3 ++-
 drivers/power/reset/ocelot-reset.c               | 4 ++--
 drivers/power/reset/odroid-go-ultra-poweroff.c   | 3 ++-
 drivers/power/reset/oxnas-restart.c              | 2 --
 drivers/power/reset/st-poweroff.c                | 2 +-
 drivers/power/reset/syscon-poweroff.c            | 3 +--
 drivers/power/reset/syscon-reboot.c              | 3 +--
 drivers/power/reset/xgene-reboot.c               | 2 +-
 drivers/power/supply/axp20x_ac_power.c           | 1 -
 drivers/power/supply/axp20x_battery.c            | 1 -
 drivers/power/supply/axp20x_usb_power.c          | 1 -
 drivers/power/supply/cpcap-battery.c             | 2 +-
 drivers/power/supply/da9150-charger.c            | 2 --
 drivers/power/supply/da9150-fg.c                 | 1 -
 drivers/power/supply/lego_ev3_battery.c          | 2 +-
 drivers/power/supply/ltc2941-battery-gauge.c     | 2 +-
 drivers/power/supply/ltc4162-l-charger.c         | 2 +-
 drivers/power/supply/max14656_charger_detector.c | 2 +-
 drivers/power/supply/max17040_battery.c          | 2 +-
 drivers/power/supply/max8903_charger.c           | 1 -
 drivers/power/supply/rn5t618_power.c             | 1 -
 drivers/power/supply/rt5033_charger.c            | 2 +-
 drivers/power/supply/rt9455_charger.c            | 3 +--
 drivers/power/supply/sbs-battery.c               | 2 +-
 drivers/power/supply/tps65090-charger.c          | 2 +-
 drivers/power/supply/tps65217_charger.c          | 1 -
 drivers/power/supply/twl4030_charger.c           | 1 +
 31 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index 80edff1a556f..829e0dba2fda 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -10,7 +10,6 @@
 #include <linux/mfd/as3722.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/power/reset/brcm-kona-reset.c b/drivers/power/reset/brcm-kona-reset.c
index 3de024e3ceb7..64e241c77f83 100644
--- a/drivers/power/reset/brcm-kona-reset.c
+++ b/drivers/power/reset/brcm-kona-reset.c
@@ -2,8 +2,8 @@
 // Copyright (C) 2016 Broadcom
 
 #include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 
 #define RSTMGR_REG_WR_ACCESS_OFFSET	0
diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 84b3c3528afa..b28f24da1b3c 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -11,8 +11,9 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_platform.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 
 #define DEFAULT_TIMEOUT_MS 3000
diff --git a/drivers/power/reset/gpio-restart.c b/drivers/power/reset/gpio-restart.c
index a479d3536eb1..5f09c26456f0 100644
--- a/drivers/power/reset/gpio-restart.c
+++ b/drivers/power/reset/gpio-restart.c
@@ -12,8 +12,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 struct gpio_restart {
 	struct gpio_desc *reset_gpio;
diff --git a/drivers/power/reset/keystone-reset.c b/drivers/power/reset/keystone-reset.c
index 83a4e1c9bf94..dbc4ff61cd74 100644
--- a/drivers/power/reset/keystone-reset.c
+++ b/drivers/power/reset/keystone-reset.c
@@ -10,10 +10,11 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #define RSTYPE_RG			0x0
 #define RSCTRL_RG			0x4
diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/ocelot-reset.c
index 8caa90cb58fc..44c7730086e4 100644
--- a/drivers/power/reset/ocelot-reset.c
+++ b/drivers/power/reset/ocelot-reset.c
@@ -8,10 +8,10 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/power/reset/odroid-go-ultra-poweroff.c b/drivers/power/reset/odroid-go-ultra-poweroff.c
index f46271da4e8e..9cac7aef77f0 100644
--- a/drivers/power/reset/odroid-go-ultra-poweroff.c
+++ b/drivers/power/reset/odroid-go-ultra-poweroff.c
@@ -4,7 +4,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/mfd/rk808.h>
 #include <linux/regmap.h>
 #include <linux/module.h>
diff --git a/drivers/power/reset/oxnas-restart.c b/drivers/power/reset/oxnas-restart.c
index 13090bec058a..dd321caa28b6 100644
--- a/drivers/power/reset/oxnas-restart.c
+++ b/drivers/power/reset/oxnas-restart.c
@@ -13,8 +13,6 @@
 #include <linux/io.h>
 #include <linux/notifier.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/reset/st-poweroff.c b/drivers/power/reset/st-poweroff.c
index 5ccaacffab54..56ba21873882 100644
--- a/drivers/power/reset/st-poweroff.c
+++ b/drivers/power/reset/st-poweroff.c
@@ -9,7 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reboot.h>
diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index ed58bdf41e27..430d440d55c6 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -10,8 +10,7 @@
 #include <linux/io.h>
 #include <linux/notifier.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 45e34e6885f7..4d622c19bc48 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -9,8 +9,7 @@
 #include <linux/io.h>
 #include <linux/notifier.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 0b0d2fd2bd0c..3260bd93158e 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -13,7 +13,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 57e50208d537..19a118633115 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -13,7 +13,6 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/power_supply.h>
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 9106077c0dbb..6ac5c80cfda2 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -22,7 +22,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 51c3f9b6458d..bde17406c130 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/power_supply.h>
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index d98d9244e394..5dd76c0ac98d 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -15,7 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/reboot.h>
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index a87aeaea38e1..27f897067aa3 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -11,8 +11,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/notifier.h>
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 8c5e2c49d6c1..652c1f213af1 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index ccb00be38e2c..9085de0ae1b2 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -20,7 +20,7 @@
 #include <linux/iio/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index cad39a8f829d..a1ddc4b060ce 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -11,7 +11,7 @@
 #include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/swab.h>
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index ec5b4a20ad43..f0eace731480 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -6,7 +6,7 @@
 
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/i2c.h>
diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index fbdf12cf64eb..89f2af72dfcd 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -14,8 +14,8 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
 #include <linux/devm-helpers.h>
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 22ea7de47a53..ff42db672899 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -15,7 +15,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/power_supply.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/power/supply/max8903_charger.c b/drivers/power/supply/max8903_charger.c
index 54d50b55fbae..e65d0141f260 100644
--- a/drivers/power/supply/max8903_charger.c
+++ b/drivers/power/supply/max8903_charger.c
@@ -10,7 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/power_supply.h>
 #include <linux/platform_device.h>
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index a5e09ac78a50..ebea3522a2ac 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mfd/rn5t618.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
index 5218dfbf5e1b..c0c516f22c66 100644
--- a/drivers/power/supply/rt5033_charger.c
+++ b/drivers/power/supply/rt5033_charger.c
@@ -6,8 +6,8 @@
  * Author: Beomho Seo <beomho.seo@samsung.com>
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index ff4dcf77c788..c345a77f9f78 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -8,8 +8,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/of_irq.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/i2c.h>
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 62a354e01204..cdfc8466d129 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/power/sbs-battery.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index 0990b2fa6cd8..f96c705e0a9f 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index a4bc9f2a10bc..96341cbde4fa 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/power_supply.h>
 
 #include <linux/mfd/core.h>
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 7adfd69fe649..e78d061d8d32 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/twl.h>
-- 
2.40.1

