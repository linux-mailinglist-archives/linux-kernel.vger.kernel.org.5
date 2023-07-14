Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5A7541A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbjGNRxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjGNRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4DA3AA7;
        Fri, 14 Jul 2023 10:52:10 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so9694305ab.2;
        Fri, 14 Jul 2023 10:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357008; x=1691949008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTGowGQ+gnh0je21trugV/Og1PbGM9FG4W2OVva7pw0=;
        b=Ys4yjOcgt2qumz/dhRxxQfgYoebGIMOjiaQv299JXdxoGBiu63+ALwLCF189N16ISf
         Q3dN08BYAyrnsivcT/4GjMidJNE2eH4F4zb4r2IzVsff9m/jhFhdpqEAy05qh2Rc5hiB
         wRDsbwI9/frLRguHhlR5Q52FJfIsz42sgrcfei679pQllyitXjBDyS/yxYiJIz+eavu+
         M3G+I4A7lxykU7z/S44gXZDQa3TYKg7hrKUcqbTFiKChCTX1+3d6QOiB5atVTyINg2PV
         RQG8M0E1ujlsjffJcciHG9rOMI11VVGeKrHPDDFXBco1CyQqXJW/fDMOxD7Kw4OJVMWi
         5G2g==
X-Gm-Message-State: ABy/qLZaGQwDMlGpc+aIyBQeDx9WS/2FAaB9T5g7ajNeySvAlRvpjxBz
        tJB1cjPS3OceQLDQGPNEhg==
X-Google-Smtp-Source: APBJJlEhOhChoEvuUEdONUTP5S4YdsfARFzKRecNc/9FDDY+IbgGFDh0FTj4W3Ikt2N9GuNQT2V8ig==
X-Received: by 2002:a92:d181:0:b0:346:3920:5df2 with SMTP id z1-20020a92d181000000b0034639205df2mr4814067ilz.21.1689357007895;
        Fri, 14 Jul 2023 10:50:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c4-20020a02a404000000b0042b3e04510asm2694786jal.98.2023.07.14.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:07 -0700 (PDT)
Received: (nullmailer pid 4063785 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] reset: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:37 -0600
Message-Id: <20230714174939.4063667-1-robh@kernel.org>
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
 drivers/reset/hisilicon/hi6220_reset.c | 1 -
 drivers/reset/hisilicon/reset-hi3660.c | 2 +-
 drivers/reset/reset-imx7.c             | 2 +-
 drivers/reset/reset-intel-gw.c         | 2 +-
 drivers/reset/reset-k210.c             | 1 -
 drivers/reset/reset-meson-audio-arb.c  | 3 ++-
 drivers/reset/reset-meson.c            | 1 -
 drivers/reset/reset-microchip-sparx5.c | 3 ++-
 drivers/reset/reset-mpfs.c             | 1 +
 drivers/reset/reset-qcom-aoss.c        | 2 +-
 drivers/reset/reset-qcom-pdc.c         | 2 +-
 drivers/reset/reset-simple.c           | 1 -
 drivers/reset/reset-uniphier-glue.c    | 2 +-
 drivers/reset/reset-uniphier.c         | 1 -
 drivers/reset/reset-zynqmp.c           | 1 -
 15 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 5ca145b64e63..8d1fce18ded7 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
index 965f5ceba7d8..087f28e326ee 100644
--- a/drivers/reset/hisilicon/reset-hi3660.c
+++ b/drivers/reset/hisilicon/reset-hi3660.c
@@ -6,7 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index d2408725eb2c..dd01fe11c5cb 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -9,7 +9,7 @@
 
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/regmap.h>
diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
index effc177db80a..a5a01388ae7f 100644
--- a/drivers/reset/reset-intel-gw.c
+++ b/drivers/reset/reset-intel-gw.c
@@ -6,7 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
index 1b6e03522b40..b62a2fd44e4e 100644
--- a/drivers/reset/reset-k210.c
+++ b/drivers/reset/reset-k210.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Western Digital Corporation or its affiliates.
  */
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/delay.h>
diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 6a3f6a6a3bbf..7e46dbc04998 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -5,7 +5,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 13878ca2779d..89ac99789a3c 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -14,7 +14,6 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/of_device.h>
 
 #define BITS_PER_REG	32
 
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index ead25942061d..636e85c388b0 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -7,9 +7,10 @@
  * https://github.com/microchip-ung/sparx-5_reginfo
  */
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index e71ab73092ab..7f3fb2d472f4 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -9,6 +9,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
diff --git a/drivers/reset/reset-qcom-aoss.c b/drivers/reset/reset-qcom-aoss.c
index 9333b923dda0..f52e90e36194 100644
--- a/drivers/reset/reset-qcom-aoss.c
+++ b/drivers/reset/reset-qcom-aoss.c
@@ -8,7 +8,7 @@
 #include <linux/reset-controller.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 
 struct qcom_aoss_reset_map {
diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
index f22bb49a4ac8..a3aae3f902e6 100644
--- a/drivers/reset/reset-qcom-pdc.c
+++ b/drivers/reset/reset-qcom-pdc.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 361a68314265..7ea5adbf2097 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -16,7 +16,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/reset/reset-simple.h>
diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 15abac9fc72c..38aa953855aa 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -6,7 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset/reset-simple.h>
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
index ff7580f38056..79c43c204d46 100644
--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -7,7 +7,6 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index 59dc0ff9af9e..f0f64ad3472b 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -9,7 +9,6 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/firmware/xlnx-zynqmp.h>
-#include <linux/of_device.h>
 
 #define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START)
 #define ZYNQMP_RESET_ID ZYNQMP_PM_RESET_START
-- 
2.40.1

