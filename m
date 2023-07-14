Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0807541DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjGNRvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjGNRv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:51:29 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15A3AB0;
        Fri, 14 Jul 2023 10:51:02 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7837329a00aso86183739f.2;
        Fri, 14 Jul 2023 10:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356979; x=1691948979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2bjrUW/w+bzQ76q35Yw5sXHUeVMi5XctZ0HXU4U2gs=;
        b=LPTyx0p5IES43Z0cKS8RRzqf82Dr2f61Z/8f3J2zAB/Z7XSC9Q/9BZ6GLGAqPwUeXl
         XahqTgaBloBKFr7pZDWvaKYZrVK00OSYjBI/WjE/I8y1fhuI9NMhTgEVGB5jKpKhPG39
         DMoqhaiGwhhP6svk65gT/Rr8YAU/ue1ZOQCyjKp4f4Gi8ziUzIJ0tcOALBQmVBy0k/NV
         gxftvFucUzqIyLuJCRPYNqGQA4LjQgD1rllYpHf49wrHxLXi8UrohM6T8hSTETS5wYD6
         2BUvwPQQQvag/8AlPhfxS1f7bNFcmOpiiYMDYNpB8xlSG/GG4TZfdd7aaYhONmQkAt18
         vyDg==
X-Gm-Message-State: ABy/qLajt6nURD3QL7oK5iiFwvhBHt6Zdd9E3aPUxG5cYRG4AsD5vQxq
        Dd+UeQd7FvYVuz5hZWCJWA==
X-Google-Smtp-Source: APBJJlEorJPPWROw+dhjzZQv7v0OK7+aU7bF8WgAffwXL3NuLdT/xpAzwIm1zA+Ou1on8pu0+XiYTA==
X-Received: by 2002:a92:dc04:0:b0:345:f28f:cc26 with SMTP id t4-20020a92dc04000000b00345f28fcc26mr5036001iln.24.1689356978723;
        Fri, 14 Jul 2023 10:49:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l10-20020a02cd8a000000b0042b149aeccdsm2790610jap.104.2023.07.14.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:38 -0700 (PDT)
Received: (nullmailer pid 4062696 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        Wells Lu <wellslutw@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-oxnas@groups.io, linux-rockchip@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: [PATCH] pinctrl: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:48:54 -0600
Message-Id: <20230714174901.4062397-1-robh@kernel.org>
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
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c               | 4 ++--
 drivers/pinctrl/bcm/pinctrl-nsp-gpio.c                 | 5 ++---
 drivers/pinctrl/freescale/pinctrl-imx.c                | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c          | 3 ++-
 drivers/pinctrl/freescale/pinctrl-imx23.c              | 3 ++-
 drivers/pinctrl/freescale/pinctrl-imx25.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx27.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx28.c              | 3 ++-
 drivers/pinctrl/freescale/pinctrl-imx35.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx50.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx51.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx53.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6dl.c             | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6q.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6sl.c             | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6sll.c            | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6sx.c             | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx6ul.c             | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx7d.c              | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c            | 5 ++---
 drivers/pinctrl/freescale/pinctrl-imx8dxl.c            | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx8mm.c             | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx8mq.c             | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx8qxp.c            | 3 ++-
 drivers/pinctrl/freescale/pinctrl-imx8ulp.c            | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imx93.c              | 4 ++--
 drivers/pinctrl/freescale/pinctrl-imxrt1050.c          | 2 +-
 drivers/pinctrl/freescale/pinctrl-imxrt1170.c          | 2 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c              | 4 ++--
 drivers/pinctrl/mediatek/pinctrl-mt2701.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt2712.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt6397.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8127.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8135.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8167.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8173.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8365.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8516.c              | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c          | 2 --
 drivers/pinctrl/meson/pinctrl-meson.c                  | 1 -
 drivers/pinctrl/mvebu/pinctrl-ac5.c                    | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-370.c             | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-375.c             | 1 -
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c            | 2 --
 drivers/pinctrl/mvebu/pinctrl-mvebu.c                  | 2 --
 drivers/pinctrl/nxp/pinctrl-s32cc.c                    | 2 +-
 drivers/pinctrl/nxp/pinctrl-s32g2.c                    | 2 +-
 drivers/pinctrl/pinctrl-axp209.c                       | 1 -
 drivers/pinctrl/pinctrl-k210.c                         | 2 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                      | 4 ++--
 drivers/pinctrl/pinctrl-ocelot.c                       | 4 +---
 drivers/pinctrl/pinctrl-oxnas.c                        | 1 -
 drivers/pinctrl/pinctrl-palmas.c                       | 1 -
 drivers/pinctrl/pinctrl-pic32.c                        | 1 -
 drivers/pinctrl/pinctrl-rockchip.c                     | 5 ++---
 drivers/pinctrl/pinctrl-single.c                       | 3 +--
 drivers/pinctrl/pinctrl-sx150x.c                       | 1 -
 drivers/pinctrl/pxa/pinctrl-pxa25x.c                   | 1 -
 drivers/pinctrl/pxa/pinctrl-pxa27x.c                   | 1 -
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c               | 3 ++-
 drivers/pinctrl/qcom/pinctrl-sdx75.c                   | 1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c               | 2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c                | 2 +-
 drivers/pinctrl/renesas/core.c                         | 1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c                 | 3 +--
 drivers/pinctrl/renesas/pinctrl-rza2.c                 | 3 ++-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                | 3 ++-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                | 3 ++-
 drivers/pinctrl/samsung/pinctrl-samsung.c              | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c              | 2 +-
 drivers/pinctrl/spear/pinctrl-spear1340.c              | 2 +-
 drivers/pinctrl/spear/pinctrl-spear300.c               | 2 +-
 drivers/pinctrl/spear/pinctrl-spear310.c               | 2 +-
 drivers/pinctrl/spear/pinctrl-spear320.c               | 2 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c                    | 1 -
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c | 5 +----
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c | 2 --
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c     | 1 -
 drivers/pinctrl/stm32/pinctrl-stm32.c                  | 3 +--
 drivers/pinctrl/sunplus/sppctl.c                       | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c          | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c           | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c             | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c          | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun5i.c                  | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c           | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c             | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c             | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c               | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c            | 1 -
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c              | 1 -
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c          | 1 -
 drivers/pinctrl/sunxi/pinctrl-sunxi.c                  | 3 ---
 drivers/pinctrl/tegra/pinctrl-tegra194.c               | 1 -
 107 files changed, 80 insertions(+), 145 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index cc3eb7409ab3..dcec671661e2 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -21,8 +21,8 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
index 5045a7e57f1d..e8a5ecd7fb3b 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-gpio.c
@@ -15,12 +15,11 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #include "../pinctrl-utils.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 93ffb5fc04e7..9bc16943014f 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -14,7 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 3726c0ac2560..90c696046b38 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx23.c b/drivers/pinctrl/freescale/pinctrl-imx23.c
index 144020764a4b..0404efbf2a86 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx23.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx23.c
@@ -6,7 +6,8 @@
 // Copyright 2012 Freescale Semiconductor, Inc.
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include "pinctrl-mxs.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx25.c b/drivers/pinctrl/freescale/pinctrl-imx25.c
index 51748da1668f..d2b0b6aad306 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx25.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx25.c
@@ -14,8 +14,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx27.c b/drivers/pinctrl/freescale/pinctrl-imx27.c
index 67e7105be4f3..1738df461235 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx27.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx27.c
@@ -9,8 +9,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx1.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx28.c b/drivers/pinctrl/freescale/pinctrl-imx28.c
index 13730dd193f1..eb847151713a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx28.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx28.c
@@ -6,7 +6,8 @@
 // Copyright 2012 Freescale Semiconductor, Inc.
 
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include "pinctrl-mxs.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx35.c b/drivers/pinctrl/freescale/pinctrl-imx35.c
index c8671ad5214c..1546517d8110 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx35.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx35.c
@@ -12,8 +12,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx50.c b/drivers/pinctrl/freescale/pinctrl-imx50.c
index a245b4011c00..9b044aee4f7c 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx50.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx50.c
@@ -9,8 +9,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx51.c b/drivers/pinctrl/freescale/pinctrl-imx51.c
index 307cf5fe4d15..e580c022bebe 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx51.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx51.c
@@ -10,8 +10,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx53.c b/drivers/pinctrl/freescale/pinctrl-imx53.c
index 02bf3bda69ac..1034192ab410 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx53.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx53.c
@@ -10,8 +10,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6dl.c b/drivers/pinctrl/freescale/pinctrl-imx6dl.c
index 2b6d5141a477..09542fdcd405 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6dl.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6dl.c
@@ -8,8 +8,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6q.c b/drivers/pinctrl/freescale/pinctrl-imx6q.c
index a7507def26a9..ae5cec74a3e8 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6q.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6q.c
@@ -10,8 +10,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6sl.c b/drivers/pinctrl/freescale/pinctrl-imx6sl.c
index 236f3bf120c2..3111f50263f6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6sl.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6sl.c
@@ -8,8 +8,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6sll.c b/drivers/pinctrl/freescale/pinctrl-imx6sll.c
index dfefcecbe072..72a7214811ab 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6sll.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6sll.c
@@ -7,8 +7,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6sx.c b/drivers/pinctrl/freescale/pinctrl-imx6sx.c
index b7b97c274dcc..aa76bc6d7402 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6sx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6sx.c
@@ -8,8 +8,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6ul.c b/drivers/pinctrl/freescale/pinctrl-imx6ul.c
index 3b8747482e36..9cb02444f8aa 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6ul.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6ul.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7d.c b/drivers/pinctrl/freescale/pinctrl-imx7d.c
index 4126387344cb..8acf2b73aefa 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7d.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7d.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
index 1915378d92b2..ba0ef1ea5722 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7ulp.c
@@ -8,9 +8,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8dxl.c b/drivers/pinctrl/freescale/pinctrl-imx8dxl.c
index f947b1d0d1aa..7dec709ebd9a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8dxl.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8dxl.c
@@ -8,10 +8,10 @@
 #include <linux/firmware/imx/sci.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 
 #include "pinctrl-imx.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mm.c b/drivers/pinctrl/freescale/pinctrl-imx8mm.c
index 39dc73281ce6..47d14902a01a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mm.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mm.c
@@ -6,7 +6,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8mq.c b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
index 3ed3c98bcedb..529eebe46298 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8mq.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8mq.c
@@ -8,10 +8,10 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 
 #include "pinctrl-imx.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8qxp.c b/drivers/pinctrl/freescale/pinctrl-imx8qxp.c
index 0a0acc0038d0..37ef3229231b 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8qxp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8qxp.c
@@ -10,10 +10,11 @@
 #include <linux/firmware/imx/sci.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 
 #include "pinctrl-imx.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx8ulp.c b/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
index f8572597a54e..2e86ca9fc7ac 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
@@ -6,10 +6,10 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 
 #include "pinctrl-imx.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx93.c b/drivers/pinctrl/freescale/pinctrl-imx93.c
index 91b3ee1e6fa9..5977dda3b759 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx93.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx93.c
@@ -6,10 +6,10 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
 
 #include "pinctrl-imx.h"
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imxrt1050.c b/drivers/pinctrl/freescale/pinctrl-imxrt1050.c
index def683839ebe..f6435227d4fb 100644
--- a/drivers/pinctrl/freescale/pinctrl-imxrt1050.c
+++ b/drivers/pinctrl/freescale/pinctrl-imxrt1050.c
@@ -6,7 +6,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imxrt1170.c b/drivers/pinctrl/freescale/pinctrl-imxrt1170.c
index 5da1545fde91..d8857f329e25 100644
--- a/drivers/pinctrl/freescale/pinctrl-imxrt1170.c
+++ b/drivers/pinctrl/freescale/pinctrl-imxrt1170.c
@@ -6,7 +6,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index 700e5a136814..76adcc5abdec 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -7,8 +7,8 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-imx.h"
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index b185538452a0..5fb377c1668b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -7,7 +7,6 @@
 #include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/regmap.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 730a496848dc..8a6daa0db54b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/regmap.h>
 #include <linux/pinctrl/pinconf-generic.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
index bc5c3dfcdc76..03d0f65d7bcc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/mfd/mt6397/core.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index e8772dcfe69e..f5030a9ea40b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/regmap.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index cdb0252071fb..77c6ac464e86 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/regmap.h>
 #include <dt-bindings/pinctrl/mt65xx.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8167.c b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
index 866da2c4a890..ba7f30c3296f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8167.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8167.c
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index 37d8cec1c3ce..455eec018f93 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/regmap.h>
 #include <linux/pinctrl/pinconf-generic.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 75a505035e96..1db04bbdb423 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index e929339dd2cb..950275c47122 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/pinctrl/mt65xx.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 665dec419e7c..74b15952b742 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -8,8 +8,6 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 530f3f934e19..524424ee6c4e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -43,7 +43,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-ac5.c b/drivers/pinctrl/mvebu/pinctrl-ac5.c
index 292633e61129..09ddfc434c6b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-ac5.c
+++ b/drivers/pinctrl/mvebu/pinctrl-ac5.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-mvebu.h"
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index d3195557a901..a50c2183e49a 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-mvebu.h"
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index e6aaa3708e58..64e2096a05e4 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-mvebu.h"
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 67c6751a6f06..1e1f3fdaba21 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -13,8 +13,6 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index 8e6aac4164df..84a119718f86 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -11,8 +11,6 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 3ae043b27463..7daff9f186cd 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 224a12ce70ed..440ff1879424 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-s32.h"
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index b3ba25435c34..9f5b3ab8e184 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -15,7 +15,6 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index 97920fb517bc..b6d1ed9ec9a3 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -7,7 +7,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/pinctrl-lpc18xx.c b/drivers/pinctrl/pinctrl-lpc18xx.c
index 13c041dd2ce0..0f5a7bed2f81 100644
--- a/drivers/pinctrl/pinctrl-lpc18xx.c
+++ b/drivers/pinctrl/pinctrl-lpc18xx.c
@@ -12,8 +12,8 @@
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 1dcbd0937ef5..f8ae2e974221 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -11,9 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/ocelot.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index fb10a8473ebe..2b2f36994323 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-palmas.c b/drivers/pinctrl/pinctrl-palmas.c
index fecc25d35d02..9e272f9deb4f 100644
--- a/drivers/pinctrl/pinctrl-palmas.c
+++ b/drivers/pinctrl/pinctrl-palmas.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/mfd/palmas.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index dad05294fa72..d0737ef926e3 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -11,7 +11,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 0276b52f3716..45e416f68e74 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -21,9 +21,8 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 0dabbcf68b9f..f056923ecc98 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -12,14 +12,13 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/seq_file.h>
 
diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 35faea8dfb0b..fef1ee7b7945 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -19,7 +19,6 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/gpio/driver.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa25x.c b/drivers/pinctrl/pxa/pinctrl-pxa25x.c
index 95640698422f..2a4842557bb2 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa25x.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa25x.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-pxa2xx.h"
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa27x.c b/drivers/pinctrl/pxa/pinctrl-pxa27x.c
index ff9302e4803a..b3acbaf8c85f 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa27x.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa27x.c
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-pxa2xx.h"
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index fdb6585a9234..417ba02b1afb 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -8,7 +8,8 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
 
 #include <linux/pinctrl/pinconf-generic.h>
diff --git a/drivers/pinctrl/qcom/pinctrl-sdx75.c b/drivers/pinctrl/qcom/pinctrl-sdx75.c
index 2ade7866dbc5..3cfe8c7f04df 100644
--- a/drivers/pinctrl/qcom/pinctrl-sdx75.c
+++ b/drivers/pinctrl/qcom/pinctrl-sdx75.c
@@ -5,7 +5,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include "pinctrl-msm.h"
 
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index dec1ffc49ffd..e0d43d076c01 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -7,7 +7,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index b5aed540f07e..985d1a0ee8f8 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -7,7 +7,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
diff --git a/drivers/pinctrl/renesas/core.c b/drivers/pinctrl/renesas/core.c
index 0c8d081da6a8..6e250a9225a4 100644
--- a/drivers/pinctrl/renesas/core.c
+++ b/drivers/pinctrl/renesas/core.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/psci.h>
diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
index 68c7af5d86bc..f43f1196fea8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -19,11 +19,10 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rza2.c b/drivers/pinctrl/renesas/pinctrl-rza2.c
index 40b1326a1077..0b454a31c4bd 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza2.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza2.c
@@ -14,8 +14,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
 
 #include "../core.h"
 #include "../pinmux.h"
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9511d920565e..87ca761a1aec 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -11,8 +11,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
index e5472293bc7f..dd2342b757be 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -14,7 +14,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
 
 #include <linux/pinctrl/consumer.h>
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 833e170e3d99..e54847040b4a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -20,7 +20,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irqdomain.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index 0180eb544f02..fb624a051e26 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -11,7 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "pinctrl-spear.h"
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 0ca961219b3b..48f068cf5e24 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -11,7 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "pinctrl-spear.h"
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index d53a04597cbe..7530252ef7bc 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -11,7 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "pinctrl-spear3xx.h"
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index 9d9facc4a6e4..c476e5478646 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -11,7 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "pinctrl-spear3xx.h"
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index e629e3035543..401477cfbf57 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -11,7 +11,7 @@
 
 #include <linux/err.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include "pinctrl-spear3xx.h"
 
diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index ca9659f4e4b1..ccdcc91c7fa5 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
index 8cf28aaed254..4bfe3aa57f8a 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-aon.c
@@ -10,11 +10,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
index bc279a39613f..20c85db1cd3a 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
@@ -13,8 +13,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 5fe729b4a03d..b9081805c8f6 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 4b97bd00191b..cbdb28358965 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -13,9 +13,8 @@
 #include <linux/irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 150996949ede..bb5ef391dbe4 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
index 9cc94be1046d..8e2aab542fcf 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun20i-d1.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 0c7c361ebac5..fa47fe36ee5b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
index b82ad135bf2a..6d121bec4445 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
index f682e0e4244d..df90c75fb3c5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
@@ -8,7 +8,6 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
index ef261eccda56..8693cd4877e1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64-r.c
@@ -21,7 +21,6 @@
  */
 
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
index 7b83d3755a0e..1c23ce9df52f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
index 96a350e70668..669793c6578e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h5.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
index 3aba0aec3d78..394476a35cad 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
index 3cc1121589c9..517118341316 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
index c39ea46046c2..d1f7cfa824c5 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
@@ -10,7 +10,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
index d6ca720ee8d8..73f012823a98 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i.c b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
index 27ec99e81c4c..06ecb121c827 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index 2486cdf345e1..c983243cd6fb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 82ffaf466892..82ac064931df 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 4fae12c905b7..de00d3ef5e82 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
index 402fd7d21e7b..f6b01a8a8977 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
index f043afa1aac5..f48f3e8cbe87 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
index 0cb6c1a970c9..c6a3ab3461ac 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t-r.c
@@ -24,7 +24,6 @@
  */
 
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index b5c1a8f363f3..fd1c65c0180c 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
index b795a199e240..45e1531697fb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3-r.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
index d1719a738c20..1c0823d50250 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
index ca85438e379a..49c9a0b6a0eb 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3s.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index f11cb5bba0f7..919b6a20af83 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index 0633a03d5e13..61137c7f09b6 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
index b8fc88a23cf4..bfc39cc3b3e3 100644
--- a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
@@ -25,7 +25,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "pinctrl-sunxi.h"
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 1dc1882cbdd7..096f1357850f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -18,10 +18,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_clk.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra194.c b/drivers/pinctrl/tegra/pinctrl-tegra194.c
index 69f58df62897..6d77954d286b 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra194.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra194.c
@@ -16,7 +16,6 @@
 
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-- 
2.40.1

