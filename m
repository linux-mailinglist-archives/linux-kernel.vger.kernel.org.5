Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666975412F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjGNRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjGNRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:49:10 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BB423C;
        Fri, 14 Jul 2023 10:48:26 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-78360b822abso87467039f.2;
        Fri, 14 Jul 2023 10:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356863; x=1691948863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws37MduKoZ6K8xKpYDUmo3zu7UbisfYB9fvzAAVlqfU=;
        b=lRrGZA6HXW4aZFe16n7xJ5hAq8yg4gG9D771SrmRmAuHDh7WH1tfVK+EL8HJH7zXtC
         vlCnOLFFSa/OrgQg5El+ACWWaVX3jyCQjulgcRCkMWc7DeF8RYa7Dr4Y1kdxe0VvoXXo
         KPeNDDttmzS7Yrt8N+DI5uLRGpshoaaogcuj/yUIOD2Vnxy3jUdEmhIofjW0yQbziGxx
         B8byakJ8b+UHS99TDO+Esdkxd43V3AbWnlvftnugTnJURLCKG4r2Bg+Nu42CZmkT2nJM
         zY/J42V138f1DZwnV/2ghJ//lgj4p3xM5zf+ceci66fNDl5LmXv/1CGctVKe4MaL9XPN
         8HyQ==
X-Gm-Message-State: ABy/qLZlbqCgo/4YNSrg++Yc9ytXxucQynU579SThK+98qhpUhOVSOLp
        AdJ/fKZJgWThXAvUEJA4Ug==
X-Google-Smtp-Source: APBJJlFFQ8o34m0x+b2BcDkHrd+gYnTS9IpTEgQAWqmgWHXwvhhVF5dvvgotkCgWFujK552QA+NMzQ==
X-Received: by 2002:a5e:c009:0:b0:783:5452:e343 with SMTP id u9-20020a5ec009000000b007835452e343mr5240574iol.14.1689356863024;
        Fri, 14 Jul 2023 10:47:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t9-20020a02ab89000000b0042af7792d7dsm2613615jan.97.2023.07.14.10.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:42 -0700 (PDT)
Received: (nullmailer pid 4059768 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michal Simek <michal.simek@amd.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: [PATCH] memory: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:16 -0600
Message-Id: <20230714174717.4059518-1-robh@kernel.org>
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
 drivers/memory/brcmstb_dpfe.c            | 3 +--
 drivers/memory/da8xx-ddrctl.c            | 1 -
 drivers/memory/fsl_ifc.c                 | 2 +-
 drivers/memory/jz4780-nemc.c             | 1 -
 drivers/memory/pl353-smc.c               | 1 +
 drivers/memory/renesas-rpc-if.c          | 1 -
 drivers/memory/samsung/exynos5422-dmc.c  | 2 +-
 drivers/memory/stm32-fmc2-ebi.c          | 2 ++
 drivers/memory/tegra/mc.c                | 2 +-
 drivers/memory/tegra/tegra124.c          | 2 +-
 drivers/memory/tegra/tegra186.c          | 3 ++-
 drivers/memory/tegra/tegra20.c           | 3 ++-
 drivers/memory/tegra/tegra210-emc-core.c | 4 ++--
 drivers/memory/tegra/tegra30-emc.c       | 2 +-
 drivers/memory/tegra/tegra30.c           | 2 +-
 15 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 9339f80b21c5..a7ab3d377206 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -32,8 +32,7 @@
 #include <linux/firmware.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #define DRVNAME			"brcmstb-dpfe"
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index 0ef8cc878b95..2bf34da85d22 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
diff --git a/drivers/memory/fsl_ifc.c b/drivers/memory/fsl_ifc.c
index 9e8d8e9c5ad8..2509e5152036 100644
--- a/drivers/memory/fsl_ifc.c
+++ b/drivers/memory/fsl_ifc.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/fsl_ifc.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 555f7ac3b7dd..e5a93e7da15f 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -12,7 +12,6 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
index d39ee7d06665..48540817e046 100644
--- a/drivers/memory/pl353-smc.c
+++ b/drivers/memory/pl353-smc.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 75fcba45ec1b..9695b2d3ae59 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index c491cd549644..6d019dbd721c 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index ffec26a99313..9015e8277dc8 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -7,8 +7,10 @@
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 4a750da1c12a..b3d72af80442 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index d780a84241fe..470b7dbab2c2 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/device.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/memory/tegra124-mc.h>
diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 7bb73f06fad3..533f85a4b2bd 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -7,7 +7,8 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 #include <soc/tegra/mc.h>
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index fcd7738fcb53..544bfd216a22 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -5,8 +5,9 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 
diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index ae5f982f861b..3300bde47c13 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -9,10 +9,10 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include <soc/tegra/fuse.h>
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index c91e9b7e2e01..9eae25c57ec6 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -22,7 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index 84316357513d..06f8b35e0a14 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/memory/tegra30-mc.h>
-- 
2.40.1

