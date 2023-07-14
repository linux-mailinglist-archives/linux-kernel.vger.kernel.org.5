Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3BE754141
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjGNRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjGNRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:47:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D72723;
        Fri, 14 Jul 2023 10:47:19 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78666994bc2so90174739f.0;
        Fri, 14 Jul 2023 10:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356782; x=1691948782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++9nzD/JzCF39gAGrMXF8Y6idYmLnfKSrYyS8JLIzsI=;
        b=DTTfBdEuUZdZzDp0iYaG8diJIbfEASUjHOL/Kk7veHlAQOLzFOfInoHJaoLwmCmDqT
         WLb/DzA/GrgRGcDWrFpnWg+5Ht9qWYflnv8CJZsOF/AsOFpVkKxN0L/yQmVSdfiIMSTn
         a945TesHTjHkObR9gNT+zOF15pDjIetXjqLKWlgr3xzLOEqmhOmzKMJo+0564dW/3x2v
         l+xb0g+HqbCV1L+oi9QGz2GGtQ15cXoLVSl2tstSfshqcQtnLVCIx7AWhkQIqbosKNJ0
         ue+U2YqibzeYKZOhQcIpl/084V3lvkmWC8f7gauE43ZzIO9FTsi8r77cY1FwK/VUfM0f
         QRMA==
X-Gm-Message-State: ABy/qLbqg+pwaE0tehB+kqyMWeEl1o3GBufCNT0ene1VEZ4kgPZzEKoA
        AMmMMqTMyQkQ5fevLxM6cw==
X-Google-Smtp-Source: APBJJlHG+t3WZVcyrkykKAdQOVqphOSCT5jQaGdMGeB11R0kRg+uJBi/VTvyTNrIijy8sN8Abne9kg==
X-Received: by 2002:a6b:f101:0:b0:787:1d0a:ce81 with SMTP id e1-20020a6bf101000000b007871d0ace81mr5974474iog.13.1689356782016;
        Fri, 14 Jul 2023 10:46:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ce16-20020a05660242d000b00785cd25010esm2654702iob.11.2023.07.14.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:46:21 -0700 (PDT)
Received: (nullmailer pid 4057372 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: [PATCH] hwmon: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:04 -0600
Message-Id: <20230714174607.4057185-1-robh@kernel.org>
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
 drivers/hwmon/ad7418.c           | 2 +-
 drivers/hwmon/ads7828.c          | 2 +-
 drivers/hwmon/adt7475.c          | 1 -
 drivers/hwmon/as370-hwmon.c      | 3 ++-
 drivers/hwmon/aspeed-pwm-tacho.c | 3 +--
 drivers/hwmon/g762.c             | 1 -
 drivers/hwmon/gxp-fan-ctrl.c     | 2 +-
 drivers/hwmon/ina2xx.c           | 1 -
 drivers/hwmon/lm63.c             | 2 +-
 drivers/hwmon/lm75.c             | 2 +-
 drivers/hwmon/lm85.c             | 2 +-
 drivers/hwmon/lm90.c             | 2 +-
 drivers/hwmon/lochnagar-hwmon.c  | 1 -
 drivers/hwmon/ltq-cputemp.c      | 3 ++-
 drivers/hwmon/max31730.c         | 1 -
 drivers/hwmon/max6621.c          | 2 +-
 drivers/hwmon/max6697.c          | 1 -
 drivers/hwmon/mcp3021.c          | 1 -
 drivers/hwmon/nsa320-hwmon.c     | 2 --
 drivers/hwmon/pmbus/dps920ab.c   | 2 +-
 drivers/hwmon/pmbus/ibm-cffps.c  | 2 +-
 drivers/hwmon/pmbus/ir38064.c    | 4 ++--
 drivers/hwmon/pmbus/max20730.c   | 2 +-
 drivers/hwmon/pmbus/mp5023.c     | 2 +-
 drivers/hwmon/pmbus/mpq7932.c    | 2 +-
 drivers/hwmon/pmbus/q54sj108a2.c | 2 +-
 drivers/hwmon/pmbus/tps53679.c   | 2 +-
 drivers/hwmon/pmbus/ucd9000.c    | 2 +-
 drivers/hwmon/pmbus/ucd9200.c    | 2 +-
 drivers/hwmon/sbtsi_temp.c       | 1 -
 drivers/hwmon/scpi-hwmon.c       | 2 +-
 drivers/hwmon/tmp421.c           | 2 +-
 drivers/hwmon/tmp464.c           | 2 +-
 drivers/hwmon/tps23861.c         | 2 +-
 drivers/hwmon/ultra45_env.c      | 3 ++-
 drivers/hwmon/vexpress-hwmon.c   | 1 -
 drivers/hwmon/w83773g.c          | 2 +-
 37 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
index ffe81e445010..bcea66eac82b 100644
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -16,7 +16,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 1932613ec095..e86894e35639 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_data/ads7828.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index c0ce88324ea6..5363254644da 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
diff --git a/drivers/hwmon/as370-hwmon.c b/drivers/hwmon/as370-hwmon.c
index fffbf385a57f..316454bd983d 100644
--- a/drivers/hwmon/as370-hwmon.c
+++ b/drivers/hwmon/as370-hwmon.c
@@ -11,7 +11,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #define CTRL		0x0
 #define  PD		BIT(0)
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index d11f674e3dc3..997df4b40509 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -12,8 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
index 1b6ff4712138..fad69ef56c75 100644
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -39,7 +39,6 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_data/g762.h>
 
 #define DRVNAME "g762"
diff --git a/drivers/hwmon/gxp-fan-ctrl.c b/drivers/hwmon/gxp-fan-ctrl.c
index 2e05bc2f627a..00e057050437 100644
--- a/drivers/hwmon/gxp-fan-ctrl.c
+++ b/drivers/hwmon/gxp-fan-ctrl.c
@@ -6,7 +6,7 @@
 #include <linux/hwmon.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #define OFS_FAN_INST	0 /* Is 0 because plreg base will be set at INST */
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index cfd7efef5cdf..a47973e2d606 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -31,7 +31,6 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/jiffies.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/util_macros.h>
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index 6972454eb4e0..562c94c7d831 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -33,7 +33,7 @@
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 72e634d1b857..72cdc405a3b0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -13,7 +13,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8540178f5b74..2a62ea7b25a9 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -12,7 +12,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 90101c236f35..b25ae8b7ec90 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -106,7 +106,7 @@
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
diff --git a/drivers/hwmon/lochnagar-hwmon.c b/drivers/hwmon/lochnagar-hwmon.c
index 6350904a8a8b..5202dddfd61e 100644
--- a/drivers/hwmon/lochnagar-hwmon.c
+++ b/drivers/hwmon/lochnagar-hwmon.c
@@ -16,7 +16,6 @@
 #include <linux/mfd/lochnagar2_regs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/hwmon/ltq-cputemp.c b/drivers/hwmon/ltq-cputemp.c
index 08e09a82acab..f7e4a4ca5239 100644
--- a/drivers/hwmon/ltq-cputemp.c
+++ b/drivers/hwmon/ltq-cputemp.c
@@ -9,8 +9,9 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
 
diff --git a/drivers/hwmon/max31730.c b/drivers/hwmon/max31730.c
index b1300ca9db1f..7d237db6e57c 100644
--- a/drivers/hwmon/max31730.c
+++ b/drivers/hwmon/max31730.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
index 7f709fd1af89..af7e62685898 100644
--- a/drivers/hwmon/max6621.c
+++ b/drivers/hwmon/max6621.c
@@ -12,7 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 #define MAX6621_DRV_NAME		"max6621"
diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 3a67778f111c..fe826fcf9990 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -15,7 +15,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 
 #include <linux/platform_data/max6697.h>
diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
index 127e15ff3e76..9814eaf24564 100644
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -20,7 +20,6 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 /* Vdd / reference voltage in millivolt */
 #define MCP3021_VDD_REF_MAX	5500
diff --git a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
index ebe6b031e56f..e26334469549 100644
--- a/drivers/hwmon/nsa320-hwmon.c
+++ b/drivers/hwmon/nsa320-hwmon.c
@@ -20,8 +20,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 /* Tests for error return values rely upon this value being < 0x80 */
diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
index f7ff3e4650b7..04e0d598a6e5 100644
--- a/drivers/hwmon/pmbus/dps920ab.c
+++ b/drivers/hwmon/pmbus/dps920ab.c
@@ -9,7 +9,7 @@
 #include <linux/debugfs.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 struct dps920ab_data {
diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index c791925b8907..5b11aacda4d2 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -13,7 +13,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 
 #include "pmbus.h"
diff --git a/drivers/hwmon/pmbus/ir38064.c b/drivers/hwmon/pmbus/ir38064.c
index 871c322d3d51..04185be3fdb6 100644
--- a/drivers/hwmon/pmbus/ir38064.c
+++ b/drivers/hwmon/pmbus/ir38064.c
@@ -6,7 +6,7 @@
  *
  * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
  * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
- *          
+ *
  * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
  * this driver does not currently support them.
  */
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/driver.h>
 #include "pmbus.h"
 
diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 7bcf27995033..6f99085c2c3b 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 #include <linux/util_macros.h>
 #include "pmbus.h"
diff --git a/drivers/hwmon/pmbus/mp5023.c b/drivers/hwmon/pmbus/mp5023.c
index c4c4324d2b74..21acb7fd9a1a 100644
--- a/drivers/hwmon/pmbus/mp5023.c
+++ b/drivers/hwmon/pmbus/mp5023.c
@@ -5,7 +5,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 static struct pmbus_driver_info mp5023_info = {
diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index 865d42edda1a..6c62f01da7c6 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pmbus.h>
 #include "pmbus.h"
 
diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
index b830f3b02bcc..a235c1cdf4fe 100644
--- a/drivers/hwmon/pmbus/q54sj108a2.c
+++ b/drivers/hwmon/pmbus/q54sj108a2.c
@@ -10,7 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 #define STORE_DEFAULT_ALL		0x11
diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index ef99005a3af5..e77b12f342b4 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "pmbus.h"
 
 enum chips {
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index c404d306e8f7..b1d1d4214e69 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index a82847945508..e4aad64b2d94 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -7,7 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index b79cece4ac9a..dd85cf89f008 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -13,7 +13,6 @@
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 
 /*
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 121e5e9f487f..a0d220609565 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -8,7 +8,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 3cde3916ab6d..10b66c9ce045 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -20,7 +20,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
diff --git a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
index 4b79c3f4d9fe..f58ca4c6acb6 100644
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 8fbbb29ae11d..d33ecbac00d6 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -14,7 +14,7 @@
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 #define TEMPERATURE			0x2c
diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index b23cff2e3d5d..3b580f229887 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -9,7 +9,8 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
diff --git a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
index 2ac5fb96bba4..d82a3b454d0e 100644
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -13,7 +13,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/vexpress.h>
 
diff --git a/drivers/hwmon/w83773g.c b/drivers/hwmon/w83773g.c
index 7f3615f5587c..045eea8378c2 100644
--- a/drivers/hwmon/w83773g.c
+++ b/drivers/hwmon/w83773g.c
@@ -12,7 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 
 /* W83773 has 3 channels */
-- 
2.40.1

