Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8311C754153
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjGNRuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjGNRte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:49:34 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E035B5;
        Fri, 14 Jul 2023 10:48:58 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-345d6dc271dso9709185ab.0;
        Fri, 14 Jul 2023 10:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356885; x=1691948885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7MnX9EU5DUHE5XRnhL3IlecGwH7oD185TOyFZlX8UQ=;
        b=lzPRGTxxc0Ow3gFUxK8TQj4umRhUpafayS8u3/t5Dq8AGpkhteOU1V9E/1xVIcj/nP
         GgwVWhI5ML4bqY91YWsqqZsCnynWkOAoMJO5Rs574tzVM9aaEZhl7OBx6lgLkdyfbSDX
         XM/dBGPoEUvbSX6SgsTgDtYkR6M3nBgoxXML4sme7HDM4gzzd+6vP074R1uyeV+myipc
         AlIqdU8q7wfLmNXbhPw41mgsmtRpi9M67257hFh2p0CMzOiAmyw//TquBgLYTDSj6Cn3
         tITuWCYQyLCMZzrcRENdGJr1mueruTuas5U94s72c+E+WWGXgkd00d9myGE2vACChR7c
         DbWg==
X-Gm-Message-State: ABy/qLbOt1GRZipflYXYsL360sKOduB7FliEqdNIswe1coOUw/EiyQsb
        tgMrTYkgczkJHmsZfku6uQ==
X-Google-Smtp-Source: APBJJlF4o1MgPuSLnn/Qb5HrydHiexRpoGJKh/EJm02M6MDOXHTh9K4jdGuB1CSsRAAQSRbmMkUHaA==
X-Received: by 2002:a92:c506:0:b0:347:733c:a55a with SMTP id r6-20020a92c506000000b00347733ca55amr4527148ilg.18.1689356885560;
        Fri, 14 Jul 2023 10:48:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b25-20020a05663801b900b0042b3a328ee0sm2683036jaq.166.2023.07.14.10.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:48:04 -0700 (PDT)
Received: (nullmailer pid 4060565 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Liang Yang <liang.yang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michal Simek <michal.simek@amd.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] mtd: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:47:49 -0600
Message-Id: <20230714174751.4060439-1-robh@kernel.org>
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
 drivers/mtd/devices/mchp23k256.c                | 2 +-
 drivers/mtd/devices/mchp48l640.c                | 2 +-
 drivers/mtd/devices/mtd_dataflash.c             | 1 -
 drivers/mtd/maps/physmap-bt1-rom.c              | 1 -
 drivers/mtd/maps/physmap-gemini.c               | 2 +-
 drivers/mtd/maps/physmap-ixp4xx.c               | 2 +-
 drivers/mtd/maps/physmap-ixp4xx.h               | 1 +
 drivers/mtd/maps/physmap-versatile.c            | 2 +-
 drivers/mtd/maps/sun_uflash.c                   | 2 +-
 drivers/mtd/nand/ecc-mxic.c                     | 2 +-
 drivers/mtd/nand/ecc.c                          | 2 +-
 drivers/mtd/nand/onenand/onenand_omap2.c        | 2 +-
 drivers/mtd/nand/raw/ams-delta.c                | 2 +-
 drivers/mtd/nand/raw/davinci_nand.c             | 1 -
 drivers/mtd/nand/raw/denali_dt.c                | 1 -
 drivers/mtd/nand/raw/fsl_ifc_nand.c             | 1 +
 drivers/mtd/nand/raw/fsl_upm.c                  | 3 ++-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c      | 2 +-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c      | 1 +
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 1 -
 drivers/mtd/nand/raw/marvell_nand.c             | 3 ++-
 drivers/mtd/nand/raw/meson_nand.c               | 1 -
 drivers/mtd/nand/raw/mpc5121_nfc.c              | 4 ++--
 drivers/mtd/nand/raw/mtk_nand.c                 | 1 -
 drivers/mtd/nand/raw/mxc_nand.c                 | 1 -
 drivers/mtd/nand/raw/ndfc.c                     | 3 ++-
 drivers/mtd/nand/raw/omap2.c                    | 2 +-
 drivers/mtd/nand/raw/pl35x-nand-controller.c    | 4 +---
 drivers/mtd/nand/raw/qcom_nandc.c               | 2 +-
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 1 -
 drivers/mtd/nand/raw/s3c2410.c                  | 1 -
 drivers/mtd/nand/raw/sh_flctl.c                 | 1 -
 drivers/mtd/nand/raw/socrates_nand.c            | 3 ++-
 drivers/mtd/nand/raw/sunxi_nand.c               | 1 -
 drivers/mtd/nand/raw/xway_nand.c                | 3 ++-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c     | 1 -
 36 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index 3a6ea7a6a30c..d533475fda15 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -15,7 +15,7 @@
 #include <linux/sizes.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #define MAX_CMD_SIZE		4
 
diff --git a/drivers/mtd/devices/mchp48l640.c b/drivers/mtd/devices/mchp48l640.c
index 40cd5041174c..f576e6a890e8 100644
--- a/drivers/mtd/devices/mchp48l640.c
+++ b/drivers/mtd/devices/mchp48l640.c
@@ -22,7 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 struct mchp48_caps {
 	unsigned int size;
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 1d3b2a94581f..0c1b93303618 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/math64.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
diff --git a/drivers/mtd/maps/physmap-bt1-rom.c b/drivers/mtd/maps/physmap-bt1-rom.c
index 58782cfaf71c..60dccc48f99e 100644
--- a/drivers/mtd/maps/physmap-bt1-rom.c
+++ b/drivers/mtd/maps/physmap-bt1-rom.c
@@ -14,7 +14,6 @@
 #include <linux/mtd/xip.h>
 #include <linux/mux/consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/drivers/mtd/maps/physmap-gemini.c b/drivers/mtd/maps/physmap-gemini.c
index d4a46e159d38..9d3b4bf84a1a 100644
--- a/drivers/mtd/maps/physmap-gemini.c
+++ b/drivers/mtd/maps/physmap-gemini.c
@@ -8,10 +8,10 @@
  */
 #include <linux/export.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/xip.h>
 #include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/drivers/mtd/maps/physmap-ixp4xx.c b/drivers/mtd/maps/physmap-ixp4xx.c
index 6a054229a8a0..c561468f95f6 100644
--- a/drivers/mtd/maps/physmap-ixp4xx.c
+++ b/drivers/mtd/maps/physmap-ixp4xx.c
@@ -11,7 +11,7 @@
  */
 #include <linux/export.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/xip.h>
 #include "physmap-ixp4xx.h"
diff --git a/drivers/mtd/maps/physmap-ixp4xx.h b/drivers/mtd/maps/physmap-ixp4xx.h
index b0fc49b7f3ed..46824c57e58a 100644
--- a/drivers/mtd/maps/physmap-ixp4xx.h
+++ b/drivers/mtd/maps/physmap-ixp4xx.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/mtd/map.h>
 
 #ifdef CONFIG_MTD_PHYSMAP_IXP4XX
diff --git a/drivers/mtd/maps/physmap-versatile.c b/drivers/mtd/maps/physmap-versatile.c
index a1b8b7b25f88..8e15d514c82d 100644
--- a/drivers/mtd/maps/physmap-versatile.c
+++ b/drivers/mtd/maps/physmap-versatile.c
@@ -9,9 +9,9 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/mtd/map.h>
 #include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/bitops.h>
 #include "physmap-versatile.h"
diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index 860b19f77090..2bfdf1b7e18a 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -14,7 +14,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <asm/prom.h>
 #include <linux/uaccess.h>
diff --git a/drivers/mtd/nand/ecc-mxic.c b/drivers/mtd/nand/ecc-mxic.c
index 22a760e6024e..47e10945b8d2 100644
--- a/drivers/mtd/nand/ecc-mxic.c
+++ b/drivers/mtd/nand/ecc-mxic.c
@@ -18,7 +18,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/nand-ecc-mxic.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 5250764cedee..8f996e8d61b8 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -95,9 +95,9 @@
 
 #include <linux/module.h>
 #include <linux/mtd/nand.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_platform.h>
 
 static LIST_HEAD(on_host_hw_engines);
diff --git a/drivers/mtd/nand/onenand/onenand_omap2.c b/drivers/mtd/nand/onenand/onenand_omap2.c
index ff7af98604df..7db53b59605d 100644
--- a/drivers/mtd/nand/onenand/onenand_omap2.c
+++ b/drivers/mtd/nand/onenand/onenand_omap2.c
@@ -13,7 +13,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/omap-gpmc.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index fa621ffa6490..919816a7aca7 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -22,7 +22,7 @@
 #include <linux/mtd/nand-gpio.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 
diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 415d6aaa8255..e75d81cf8c21 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -18,7 +18,6 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/slab.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
 
 #include <linux/platform_data/mtd-davinci.h>
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 915047e3fbc2..edac8749bb93 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 
diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index fa537fee6701..20bb1e0cb5eb 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
diff --git a/drivers/mtd/nand/raw/fsl_upm.c b/drivers/mtd/nand/raw/fsl_upm.c
index 086426139173..5bf73efe42e7 100644
--- a/drivers/mtd/nand/raw/fsl_upm.c
+++ b/drivers/mtd/nand/raw/fsl_upm.c
@@ -13,7 +13,8 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/mtd.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <asm/fsl_lbc.h>
diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 500e7a28d2e4..e71ad2fcec23 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma/mxs-dma.h>
 #include "gpmi-nand.h"
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index 9054559e52dd..525c34c281b6 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
index b9f135297aa0..6748226b8bd1 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 30c15e4e1cc0..7d0204ea305b 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -77,9 +77,10 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index d3faf8086631..ef821b43b3d4 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/sched/task_stack.h>
 
 #define NFC_REG_CMD		0x00
diff --git a/drivers/mtd/nand/raw/mpc5121_nfc.c b/drivers/mtd/nand/raw/mpc5121_nfc.c
index ab05ee65702c..6e8e790f84e7 100644
--- a/drivers/mtd/nand/raw/mpc5121_nfc.c
+++ b/drivers/mtd/nand/raw/mpc5121_nfc.c
@@ -21,10 +21,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/mpc5121.h>
 
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index b2fa6b2074ab..b6eb8cb6b5e9 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -16,7 +16,6 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mtd/nand-ecc-mtk.h>
 
 /* NAND controller register definition */
diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 3d4b2e8294ea..0cd98d5714fc 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -20,7 +20,6 @@
 #include <linux/irq.h>
 #include <linux/completion.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #define DRIVER_NAME "mxc_nand"
 
diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index 57f3db32122d..3bb32a7c6d67 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -22,8 +22,9 @@
 #include <linux/mtd/ndfc.h>
 #include <linux/slab.h>
 #include <linux/mtd/mtd.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 
 #define NDFC_MAX_CS    4
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index db22b3af16d8..e057c03a197d 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -22,7 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 #include <linux/platform_data/elm.h>
 
diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 28b7bd7e22eb..8da5fee321b5 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -23,9 +23,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 72d6168d8a1b..df245353b12b 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2016, The Linux Foundation. All rights reserved.
  */
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/dma/qcom_adm.h>
@@ -12,7 +13,6 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/delay.h>
 #include <linux/dma/qcom_bam_dma.h>
 
diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 2312e27362cb..0ec03ffb4846 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -15,7 +15,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
index ac80aaf5b4e3..3d3d5c9814ff 100644
--- a/drivers/mtd/nand/raw/s3c2410.c
+++ b/drivers/mtd/nand/raw/s3c2410.c
@@ -26,7 +26,6 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 63bf20c41719..08211e96ce64 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
diff --git a/drivers/mtd/nand/raw/socrates_nand.c b/drivers/mtd/nand/raw/socrates_nand.c
index a8b720ffe9e8..76d50eb9f1db 100644
--- a/drivers/mtd/nand/raw/socrates_nand.c
+++ b/drivers/mtd/nand/raw/socrates_nand.c
@@ -8,8 +8,9 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 
 #define FPGA_NAND_CMD_MASK		(0x7 << 28)
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 9884304634f6..c6cd7713bee7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -19,7 +19,6 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 6b1e2a2bba15..51d802a165ed 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -7,7 +7,8 @@
 
 #include <linux/mtd/rawnand.h>
 #include <linux/of_gpio.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <lantiq_soc.h>
 
diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
index 794c7b7d5c92..337e83bf3362 100644
--- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
@@ -17,7 +17,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
-- 
2.40.1

