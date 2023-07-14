Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE03754110
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbjGNRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236458AbjGNRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:48:01 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441ECE4F;
        Fri, 14 Jul 2023 10:47:42 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso9621955ab.2;
        Fri, 14 Jul 2023 10:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356829; x=1691948829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5kyFLxcFf28C4xAlfiZC8aBDg3X1GkkexShGXOhf5Q=;
        b=apBiZkb/qMovIJHt8wf8E2fa6ZIMQ1rUlEF21JcKAyZ0paIAwVvzEDIAMidm+evptV
         QbIU1CEUionoZEdPDKhHdIYiteQya9iMINscnBzITCLPvKbiYzSLWO1ImiCEJhcZNgkY
         C+dkPC5OVg5+kTX+EUQttWsOI05Xd1fF7pqXiEUyQC8rj6yltBwmIcDQiRIYLjSYz0qb
         r9vpkOcfyqBPU935p2nXpey40zKBWHFQWIskzNZckDxDgK0lQATMkplmws2uu0vAUout
         l7Aem1ya0eGsuZnebcqRE7hOtwKFw7l3G2vl4fJ6B+N7Cf3RIddGc2COqe22uIMj0lco
         7RUg==
X-Gm-Message-State: ABy/qLabeskL6qFy9H5wWm6yxotmTclPelEBme9DlzQ2BLmBvNLy6qw8
        7L011XEPKM7SzKkNEDUkaQ==
X-Google-Smtp-Source: APBJJlGzW/bj6MXlxr0qrKz4Hhu7XzH+1onl+UixPsg/LSIkCxNFlpKp8c9aZSX7kZcWE0JPfiCpHA==
X-Received: by 2002:a05:6e02:1544:b0:348:4ab6:98cc with SMTP id j4-20020a056e02154400b003484ab698ccmr3137663ilu.14.1689356828681;
        Fri, 14 Jul 2023 10:47:08 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q16-20020a920510000000b00345a769de67sm2919502ile.15.2023.07.14.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:07 -0700 (PDT)
Received: (nullmailer pid 4058855 invoked by uid 1000);
        Fri, 14 Jul 2023 17:46:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Riku Voipio <riku.voipio@iki.fi>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:50 -0600
Message-Id: <20230714174651.4058753-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
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
 drivers/leds/leds-ariel.c         | 2 +-
 drivers/leds/leds-cpcap.c         | 2 +-
 drivers/leds/leds-cr0014114.c     | 2 +-
 drivers/leds/leds-is31fl32xx.c    | 1 -
 drivers/leds/leds-mlxreg.c        | 1 -
 drivers/leds/leds-pca9532.c       | 1 -
 drivers/leds/leds-pm8058.c        | 1 -
 drivers/leds/leds-pwm.c           | 2 +-
 drivers/leds/leds-spi-byte.c      | 2 +-
 drivers/leds/leds-syscon.c        | 3 +--
 drivers/leds/leds-ti-lmu-common.c | 2 +-
 drivers/leds/leds-tlc591xx.c      | 1 -
 drivers/leds/rgb/leds-qcom-lpg.c  | 1 -
 13 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-ariel.c b/drivers/leds/leds-ariel.c
index 49e1bddaa15e..dd319c7e385f 100644
--- a/drivers/leds/leds-ariel.c
+++ b/drivers/leds/leds-ariel.c
@@ -7,8 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/leds.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/of_platform.h>
 
 enum ec_index {
 	EC_BLUE_LED	= 0x01,
diff --git a/drivers/leds/leds-cpcap.c b/drivers/leds/leds-cpcap.c
index 7d41ce8c9bb1..87354f17644b 100644
--- a/drivers/leds/leds-cpcap.c
+++ b/drivers/leds/leds-cpcap.c
@@ -7,7 +7,7 @@
 #include <linux/mfd/motorola-cpcap.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index c87686bd7c18..b33bca397ea6 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -4,8 +4,8 @@
 
 #include <linux/delay.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
 
diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index 72cb56d305c4..b0a0be77bb33 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -15,7 +15,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 /* Used to indicate a device has no such register */
 #define IS31FL32XX_REG_NONE 0xFF
diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index b7855c93bd72..39210653acf7 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/leds.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_data/mlxreg.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index 8b5c62083e50..bf8bb8fc007c 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -18,7 +18,6 @@
 #include <linux/leds-pca9532.h>
 #include <linux/gpio/driver.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 /* m =  num_leds*/
 #define PCA9532_REG_INPUT(i)	((i) >> 3)
diff --git a/drivers/leds/leds-pm8058.c b/drivers/leds/leds-pm8058.c
index b9233f14b646..3f49a5181892 100644
--- a/drivers/leds/leds-pm8058.c
+++ b/drivers/leds/leds-pm8058.c
@@ -4,7 +4,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 29194cc382af..38624e5161d8 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/leds.h>
 #include <linux/err.h>
 #include <linux/pwm.h>
diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index 2c7ffc3c78e6..9d91f21842f2 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -30,7 +30,7 @@
 
 #include <linux/leds.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <uapi/linux/uleds.h>
diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
index e38abb5e60c1..360a376fa738 100644
--- a/drivers/leds/leds-syscon.c
+++ b/drivers/leds/leds-syscon.c
@@ -7,8 +7,7 @@
  */
 #include <linux/io.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
diff --git a/drivers/leds/leds-ti-lmu-common.c b/drivers/leds/leds-ti-lmu-common.c
index d7f10ad721ba..b2491666b5dc 100644
--- a/drivers/leds/leds-ti-lmu-common.c
+++ b/drivers/leds/leds-ti-lmu-common.c
@@ -7,7 +7,7 @@
 
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 
 #include <linux/leds-ti-lmu-common.h>
 
diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
index dfc6fb2b3e52..945e831ef4ac 100644
--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -8,7 +8,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 59581b3e25ca..fd7676aa243d 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -9,7 +9,6 @@
 #include <linux/led-class-multicolor.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
-- 
2.40.1

