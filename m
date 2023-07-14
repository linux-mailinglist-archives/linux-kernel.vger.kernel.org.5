Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4147540A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjGNRle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjGNRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:41:20 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73F3A94;
        Fri, 14 Jul 2023 10:41:01 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3464c774f23so9739975ab.1;
        Fri, 14 Jul 2023 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356460; x=1691948460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nF64AgviBwnTvGXpFHPhLphTeIuPzPi+rOMKEmbw+I=;
        b=hmdFlUJUy2lDh5SshmHnFf8ioB/CXF7l9OKcrlYLJfnfBs1mRaN9tB2k2E3ZAWrQvF
         6TAWDqVff/23ZfF4CDfLOwltIXbwRWXvDO4EgZmmY9XbTY0DNa4nPV1zvc2saSDI2TdM
         t1bXJC0HD8Yx7TBzZ7zWRd8RTA7ShUDofBsTrIXefM8BHhnXGYNAf4jMvGnb0cU+Wiub
         FP6QHacs9Obmi8Tc9lIrx/ghVGiFSm5fsSCAENdwXoQ7j13LIRl6RIQpbKeO79wL9a9k
         l4qo5JfO12v5J9pzEx5WuiOy8dikZnOtq93Af2eQurqSOBwRKevMuwBu2FaYpVJ7VAB6
         oUKA==
X-Gm-Message-State: ABy/qLYjWjatIfZXSJUaWM9SW9KG9TFanj1xrjeJlyuYW8d9jjpyatI/
        MVj+VpsVLp6HaE4+VFdUlg==
X-Google-Smtp-Source: APBJJlH9NaBuTChDzkbkQxSnB0XE9piLIFxIY23t7ZsfCjG193zwK2iuYIz72I1BFGKnh4wMIAevAg==
X-Received: by 2002:a92:d6ca:0:b0:345:cdbe:833c with SMTP id z10-20020a92d6ca000000b00345cdbe833cmr4917548ilp.28.1689356460193;
        Fri, 14 Jul 2023 10:41:00 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q16-20020a056e02079000b00345d5a3748csm2850148ils.63.2023.07.14.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:59 -0700 (PDT)
Received: (nullmailer pid 4041019 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] ata: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:50 -0600
Message-Id: <20230714174052.4040857-1-robh@kernel.org>
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
 drivers/ata/ahci_ceva.c        | 2 +-
 drivers/ata/ahci_dwc.c         | 2 +-
 drivers/ata/ahci_mtk.c         | 1 +
 drivers/ata/ahci_mvebu.c       | 2 +-
 drivers/ata/ahci_qoriq.c       | 2 --
 drivers/ata/ahci_seattle.c     | 1 -
 drivers/ata/ahci_sunxi.c       | 2 +-
 drivers/ata/ahci_tegra.c       | 2 +-
 drivers/ata/libahci_platform.c | 1 +
 drivers/ata/pata_ftide010.c    | 3 +--
 drivers/ata/pata_mpc52xx.c     | 3 ++-
 drivers/ata/sata_dwc_460ex.c   | 3 +--
 drivers/ata/sata_fsl.c         | 6 +++---
 drivers/ata/sata_gemini.c      | 3 +--
 drivers/ata/sata_highbank.c    | 2 +-
 drivers/ata/sata_rcar.c        | 2 +-
 16 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index c2b6be083af4..64f7f7d6ba84 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include "ahci.h"
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 9604a2f6ed48..ed263de3fd70 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -15,7 +15,7 @@
 #include <linux/log2.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 5083fb6c4927..adc851cd5578 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -11,6 +11,7 @@
 #include <linux/libata.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 764501518582..f3187351e8a6 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/mbus.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include "ahci.h"
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 3d01b118c9a1..7bb9ad40605e 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -12,9 +12,7 @@
 #include <linux/pm.h>
 #include <linux/ahci_platform.h>
 #include <linux/device.h>
-#include <linux/of_address.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include "ahci.h"
diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 2c32d58c6ae7..adb33afee2b9 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -12,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 04531fa95e40..58b2683954dd 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -13,8 +13,8 @@
 #include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include "ahci.h"
diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 21c20793e517..223b60a7c8c7 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -12,7 +12,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 9a8d43f54adc..581704e61f28 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -20,6 +20,7 @@
 #include <linux/ahci_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/reset.h>
 #include "ahci.h"
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 6f6734c09b11..9409fbd48c5a 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -14,8 +14,7 @@
 #include <linux/module.h>
 #include <linux/libata.h>
 #include <linux/bitops.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include "sata_gemini.h"
 
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 66c9dea4ea6e..56fad9a5bc65 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -19,9 +19,10 @@
 #include <linux/gfp.h>
 #include <linux/delay.h>
 #include <linux/libata.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 
 #include <asm/cacheflush.h>
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index fabdd1e380f9..d699c5f35153 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -18,9 +18,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
 #include <linux/libata.h>
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index ccd99b9aa9ff..16415eb09302 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -12,6 +12,9 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -19,9 +22,6 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
 #include <asm/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 
 static unsigned int intr_coalescing_count;
 module_param(intr_coalescing_count, int, S_IRUGO);
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index c42cc9bbbc4e..ca56d43df149 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -12,8 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/delay.h>
 #include <linux/reset.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index d6b324d03e59..7a6d41b7a02d 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 34790f15c1b8..d4e40cf4c371 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/ata.h>
 #include <linux/libata.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
-- 
2.40.1

