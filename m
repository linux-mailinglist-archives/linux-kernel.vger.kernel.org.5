Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A758979DBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjILWLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjILWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:11:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCEE10D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:11:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501bd7711e8so10655301e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694556693; x=1695161493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9WNud3EFj9hP+Ib64sa3cl153WBgWactQ9q0INkhM=;
        b=oWsCnCe8kiS8YlA6uWBAtNzE7K7ELfgYQ9akRIhk3isHgAGZNvcdST+XSqnNYPMF/E
         8ksmJdbfT73S8UItlmJAg+l2XEq/sG8wrvTzfKdmUrGxD2XRcguzG6GCh1lATIoCpCJL
         83W2jWg2fmUOz1ojnJoWinI7WegVTPtvhLRXdsjXlS5MMhGeEez4tBNxPpXnhRsRf1cN
         6Qc5l9WYhZ6wsZ+QKu/Ewpi9i83Zp/aXSTG36+C4CP6KeG+EeD3F/3ss8bpon+WGpYRK
         PWeODb6XT5IGfEIKZt2SJh5LhY0JknPfAevj01Kd7cf1lv0QTmzkUTig8fpkLjPkdJWO
         xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556693; x=1695161493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9WNud3EFj9hP+Ib64sa3cl153WBgWactQ9q0INkhM=;
        b=o1kGgi1t0ZOPLFmIsyCnzGT23f2oa4cBexoDul3R/42PBVOxDdiGd1a39lqjtKoOYB
         dJjyQYlz5PdoBZ42C+FeVaDpLq/rS1ad0eBiF3fpjGo2WbsYZvMt9YXN0cveAB/Iw7ZA
         uHYfo2TOl8rOatgGO3wk58u2JFLOPGZAUgdtf9bISTeZ7qUbH2qwGNcsrIUbdDJDDhNs
         zQdIcG68nHFNP0g2Ym7MaNTM8ef9VUfOIX9bV4lBG0pTxLlqbjvvvwBda+CZg5WnsqDs
         oKkWW9OxDzzUTfhVNAAgi4MNAE0eo+OkW/Qzi6bQ8/pqkwykcOI4ImBLbS1A1revN8QJ
         VvtQ==
X-Gm-Message-State: AOJu0YxGd6sBPjTfxSknmfFEX8wzyA/LYd0+iDBr+gqZwXq5js9AjyS7
        ih2kGaFvN8Oir2NI3DNMkxqzOg==
X-Google-Smtp-Source: AGHT+IE8qZf2G7J17Kf4y0d0QIblBNJ3LTksVCuSYYMkMlHulsxtx1u0ah1I3hS10oifntiTYdF78w==
X-Received: by 2002:a19:6412:0:b0:4ff:87f6:6ee5 with SMTP id y18-20020a196412000000b004ff87f66ee5mr549106lfb.10.1694556692623;
        Tue, 12 Sep 2023 15:11:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m3-20020ac24243000000b004ff8d9ed368sm1897701lfl.258.2023.09.12.15.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:11:32 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: Rename the genpd subsystem to pmdomain
Date:   Wed, 13 Sep 2023 00:11:27 +0200
Message-Id: <20230912221127.487327-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been pointed out that naming a subsystem "genpd" isn't very
self-explanatory and the acronym itself that means Generic Power Domain, is
known only by a limited group of people.

In a way to improve the situation, let's rename the subsystem to pmdomain,
which ideally should indicate that this is about so called Power Domains or
"PM domains" as we often also use within the Linux Kernel terminology.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                                   | 22 +++++++++----------
 drivers/Makefile                              |  2 +-
 drivers/{genpd => pmdomain}/Makefile          |  0
 drivers/{genpd => pmdomain}/actions/Makefile  |  0
 .../actions/owl-sps-helper.c                  |  0
 drivers/{genpd => pmdomain}/actions/owl-sps.c |  0
 drivers/{genpd => pmdomain}/amlogic/Makefile  |  0
 .../amlogic/meson-ee-pwrc.c                   |  0
 .../amlogic/meson-gx-pwrc-vpu.c               |  0
 .../amlogic/meson-secure-pwrc.c               |  0
 drivers/{genpd => pmdomain}/apple/Makefile    |  0
 .../{genpd => pmdomain}/apple/pmgr-pwrstate.c |  0
 drivers/{genpd => pmdomain}/bcm/Makefile      |  0
 drivers/{genpd => pmdomain}/bcm/bcm-pmb.c     |  0
 .../{genpd => pmdomain}/bcm/bcm2835-power.c   |  0
 .../{genpd => pmdomain}/bcm/bcm63xx-power.c   |  0
 .../bcm/raspberrypi-power.c                   |  0
 drivers/{genpd => pmdomain}/imx/Makefile      |  0
 drivers/{genpd => pmdomain}/imx/gpc.c         |  0
 drivers/{genpd => pmdomain}/imx/gpcv2.c       |  0
 .../{genpd => pmdomain}/imx/imx8m-blk-ctrl.c  |  0
 .../{genpd => pmdomain}/imx/imx8mp-blk-ctrl.c |  0
 .../{genpd => pmdomain}/imx/imx93-blk-ctrl.c  |  0
 drivers/{genpd => pmdomain}/imx/imx93-pd.c    |  0
 drivers/{genpd => pmdomain}/imx/scu-pd.c      |  0
 drivers/{genpd => pmdomain}/mediatek/Makefile |  0
 .../mediatek/mt6795-pm-domains.h              |  0
 .../mediatek/mt8167-pm-domains.h              |  0
 .../mediatek/mt8173-pm-domains.h              |  0
 .../mediatek/mt8183-pm-domains.h              |  0
 .../mediatek/mt8186-pm-domains.h              |  0
 .../mediatek/mt8188-pm-domains.h              |  0
 .../mediatek/mt8192-pm-domains.h              |  0
 .../mediatek/mt8195-pm-domains.h              |  0
 .../mediatek/mtk-pm-domains.c                 |  0
 .../mediatek/mtk-pm-domains.h                 |  0
 .../{genpd => pmdomain}/mediatek/mtk-scpsys.c |  0
 drivers/{genpd => pmdomain}/qcom/Makefile     |  0
 drivers/{genpd => pmdomain}/qcom/cpr.c        |  0
 drivers/{genpd => pmdomain}/qcom/rpmhpd.c     |  0
 drivers/{genpd => pmdomain}/qcom/rpmpd.c      |  0
 drivers/{genpd => pmdomain}/renesas/Makefile  |  0
 .../renesas/r8a7742-sysc.c                    |  0
 .../renesas/r8a7743-sysc.c                    |  0
 .../renesas/r8a7745-sysc.c                    |  0
 .../renesas/r8a77470-sysc.c                   |  0
 .../renesas/r8a774a1-sysc.c                   |  0
 .../renesas/r8a774b1-sysc.c                   |  0
 .../renesas/r8a774c0-sysc.c                   |  0
 .../renesas/r8a774e1-sysc.c                   |  0
 .../renesas/r8a7779-sysc.c                    |  0
 .../renesas/r8a7790-sysc.c                    |  0
 .../renesas/r8a7791-sysc.c                    |  0
 .../renesas/r8a7792-sysc.c                    |  0
 .../renesas/r8a7794-sysc.c                    |  0
 .../renesas/r8a7795-sysc.c                    |  0
 .../renesas/r8a7796-sysc.c                    |  0
 .../renesas/r8a77965-sysc.c                   |  0
 .../renesas/r8a77970-sysc.c                   |  0
 .../renesas/r8a77980-sysc.c                   |  0
 .../renesas/r8a77990-sysc.c                   |  0
 .../renesas/r8a77995-sysc.c                   |  0
 .../renesas/r8a779a0-sysc.c                   |  0
 .../renesas/r8a779f0-sysc.c                   |  0
 .../renesas/r8a779g0-sysc.c                   |  0
 .../renesas/rcar-gen4-sysc.c                  |  0
 .../renesas/rcar-gen4-sysc.h                  |  0
 .../{genpd => pmdomain}/renesas/rcar-sysc.c   |  0
 .../{genpd => pmdomain}/renesas/rcar-sysc.h   |  0
 .../renesas/rmobile-sysc.c                    |  0
 drivers/{genpd => pmdomain}/rockchip/Makefile |  0
 .../{genpd => pmdomain}/rockchip/pm-domains.c |  0
 drivers/{genpd => pmdomain}/samsung/Makefile  |  0
 .../samsung/exynos-pm-domains.c               |  0
 drivers/{genpd => pmdomain}/st/Makefile       |  0
 .../st/ste-ux500-pm-domain.c                  |  0
 drivers/{genpd => pmdomain}/starfive/Makefile |  0
 .../{genpd => pmdomain}/starfive/jh71xx-pmu.c |  0
 drivers/{genpd => pmdomain}/sunxi/Makefile    |  0
 .../{genpd => pmdomain}/sunxi/sun20i-ppu.c    |  0
 drivers/{genpd => pmdomain}/tegra/Makefile    |  0
 .../tegra/powergate-bpmp.c                    |  0
 drivers/{genpd => pmdomain}/ti/Makefile       |  0
 drivers/{genpd => pmdomain}/ti/omap_prm.c     |  0
 .../ti/ti_sci_pm_domains.c                    |  0
 drivers/{genpd => pmdomain}/xilinx/Makefile   |  0
 .../xilinx/zynqmp-pm-domains.c                |  0
 87 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/{genpd => pmdomain}/Makefile (100%)
 rename drivers/{genpd => pmdomain}/actions/Makefile (100%)
 rename drivers/{genpd => pmdomain}/actions/owl-sps-helper.c (100%)
 rename drivers/{genpd => pmdomain}/actions/owl-sps.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/Makefile (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-secure-pwrc.c (100%)
 rename drivers/{genpd => pmdomain}/apple/Makefile (100%)
 rename drivers/{genpd => pmdomain}/apple/pmgr-pwrstate.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/Makefile (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm-pmb.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm2835-power.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm63xx-power.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/raspberrypi-power.c (100%)
 rename drivers/{genpd => pmdomain}/imx/Makefile (100%)
 rename drivers/{genpd => pmdomain}/imx/gpc.c (100%)
 rename drivers/{genpd => pmdomain}/imx/gpcv2.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx93-pd.c (100%)
 rename drivers/{genpd => pmdomain}/imx/scu-pd.c (100%)
 rename drivers/{genpd => pmdomain}/mediatek/Makefile (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-scpsys.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/Makefile (100%)
 rename drivers/{genpd => pmdomain}/qcom/cpr.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/rpmhpd.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/rpmpd.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/Makefile (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-sysc.h (100%)
 rename drivers/{genpd => pmdomain}/renesas/rmobile-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/rockchip/Makefile (100%)
 rename drivers/{genpd => pmdomain}/rockchip/pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/samsung/Makefile (100%)
 rename drivers/{genpd => pmdomain}/samsung/exynos-pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/st/Makefile (100%)
 rename drivers/{genpd => pmdomain}/st/ste-ux500-pm-domain.c (100%)
 rename drivers/{genpd => pmdomain}/starfive/Makefile (100%)
 rename drivers/{genpd => pmdomain}/starfive/jh71xx-pmu.c (100%)
 rename drivers/{genpd => pmdomain}/sunxi/Makefile (100%)
 rename drivers/{genpd => pmdomain}/sunxi/sun20i-ppu.c (100%)
 rename drivers/{genpd => pmdomain}/tegra/Makefile (100%)
 rename drivers/{genpd => pmdomain}/tegra/powergate-bpmp.c (100%)
 rename drivers/{genpd => pmdomain}/ti/Makefile (100%)
 rename drivers/{genpd => pmdomain}/ti/omap_prm.c (100%)
 rename drivers/{genpd => pmdomain}/ti/ti_sci_pm_domains.c (100%)
 rename drivers/{genpd => pmdomain}/xilinx/Makefile (100%)
 rename drivers/{genpd => pmdomain}/xilinx/zynqmp-pm-domains.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..4d9e7d42412f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1855,7 +1855,7 @@ F:	Documentation/devicetree/bindings/phy/amlogic*
 F:	arch/arm/boot/dts/amlogic/
 F:	arch/arm/mach-meson/
 F:	arch/arm64/boot/dts/amlogic/
-F:	drivers/genpd/amlogic/
+F:	drivers/pmdomain/amlogic/
 F:	drivers/mmc/host/meson*
 F:	drivers/phy/amlogic/
 F:	drivers/pinctrl/meson/
@@ -1918,7 +1918,7 @@ F:	drivers/bluetooth/hci_bcm4377.c
 F:	drivers/clk/clk-apple-nco.c
 F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
-F:	drivers/genpd/apple/
+F:	drivers/pmdomain/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
@@ -2435,7 +2435,7 @@ F:	arch/arm/mach-ux500/
 F:	drivers/clk/clk-nomadik.c
 F:	drivers/clocksource/clksrc-dbx500-prcmu.c
 F:	drivers/dma/ste_dma40*
-F:	drivers/genpd/st/ste-ux500-pm-domain.c
+F:	drivers/pmdomain/st/ste-ux500-pm-domain.c
 F:	drivers/hwspinlock/u8500_hsem.c
 F:	drivers/i2c/busses/i2c-nomadik.c
 F:	drivers/iio/adc/ab8500-gpadc.c
@@ -2598,7 +2598,7 @@ F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	arch/arm64/boot/dts/renesas/
 F:	arch/riscv/boot/dts/renesas/
-F:	drivers/genpd/renesas/
+F:	drivers/pmdomain/renesas/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 K:	\brenesas,
@@ -4026,7 +4026,7 @@ F:	arch/mips/kernel/*bmips*
 F:	drivers/irqchip/irq-bcm63*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
-F:	drivers/genpd/bcm/bcm63xx-power.c
+F:	drivers/pmdomain/bcm/bcm63xx-power.c
 F:	include/linux/bcm963xx_nvram.h
 F:	include/linux/bcm963xx_tag.h
 
@@ -4248,7 +4248,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/broadcom/stblinux.git
-F:	drivers/genpd/bcm/bcm-pmb.c
+F:	drivers/pmdomain/bcm/bcm-pmb.c
 F:	include/dt-bindings/soc/bcm-pmb.h
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
@@ -8729,7 +8729,7 @@ M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
-F:	drivers/genpd/
+F:	drivers/pmdomain/
 
 GENERIC RESISTIVE TOUCHSCREEN ADC DRIVER
 M:	Eugen Hristev <eugen.hristev@microchip.com>
@@ -17680,7 +17680,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
-F:	drivers/genpd/qcom/cpr.c
+F:	drivers/pmdomain/qcom/cpr.c
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
@@ -20514,7 +20514,7 @@ STARFIVE JH71XX PMU CONTROLLER DRIVER
 M:	Walker Chen <walker.chen@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/starfive*
-F:	drivers/genpd/starfive/jh71xx-pmu.c
+F:	drivers/pmdomain/starfive/jh71xx-pmu.c
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
 STARFIVE SOC DRIVERS
@@ -21339,7 +21339,7 @@ F:	drivers/irqchip/irq-ti-sci-inta.c
 F:	drivers/irqchip/irq-ti-sci-intr.c
 F:	drivers/reset/reset-ti-sci.c
 F:	drivers/soc/ti/ti_sci_inta_msi.c
-F:	drivers/genpd/ti/ti_sci_pm_domains.c
+F:	drivers/pmdomain/ti/ti_sci_pm_domains.c
 F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
@@ -21581,7 +21581,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-F:	drivers/genpd/ti/omap_prm.c
+F:	drivers/pmdomain/ti/omap_prm.c
 F:	drivers/soc/ti/*
 
 TI LM49xxx FAMILY ASoC CODEC DRIVERS
diff --git a/drivers/Makefile b/drivers/Makefile
index cb0afca2e4a0..1bec7819a837 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -46,7 +46,7 @@ obj-$(CONFIG_DMADEVICES)	+= dma/
 
 # SOC specific infrastructure drivers.
 obj-y				+= soc/
-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= genpd/
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= pmdomain/
 
 obj-y				+= virtio/
 obj-$(CONFIG_VDPA)		+= vdpa/
diff --git a/drivers/genpd/Makefile b/drivers/pmdomain/Makefile
similarity index 100%
rename from drivers/genpd/Makefile
rename to drivers/pmdomain/Makefile
diff --git a/drivers/genpd/actions/Makefile b/drivers/pmdomain/actions/Makefile
similarity index 100%
rename from drivers/genpd/actions/Makefile
rename to drivers/pmdomain/actions/Makefile
diff --git a/drivers/genpd/actions/owl-sps-helper.c b/drivers/pmdomain/actions/owl-sps-helper.c
similarity index 100%
rename from drivers/genpd/actions/owl-sps-helper.c
rename to drivers/pmdomain/actions/owl-sps-helper.c
diff --git a/drivers/genpd/actions/owl-sps.c b/drivers/pmdomain/actions/owl-sps.c
similarity index 100%
rename from drivers/genpd/actions/owl-sps.c
rename to drivers/pmdomain/actions/owl-sps.c
diff --git a/drivers/genpd/amlogic/Makefile b/drivers/pmdomain/amlogic/Makefile
similarity index 100%
rename from drivers/genpd/amlogic/Makefile
rename to drivers/pmdomain/amlogic/Makefile
diff --git a/drivers/genpd/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
similarity index 100%
rename from drivers/genpd/amlogic/meson-ee-pwrc.c
rename to drivers/pmdomain/amlogic/meson-ee-pwrc.c
diff --git a/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
similarity index 100%
rename from drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
rename to drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
diff --git a/drivers/genpd/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
similarity index 100%
rename from drivers/genpd/amlogic/meson-secure-pwrc.c
rename to drivers/pmdomain/amlogic/meson-secure-pwrc.c
diff --git a/drivers/genpd/apple/Makefile b/drivers/pmdomain/apple/Makefile
similarity index 100%
rename from drivers/genpd/apple/Makefile
rename to drivers/pmdomain/apple/Makefile
diff --git a/drivers/genpd/apple/pmgr-pwrstate.c b/drivers/pmdomain/apple/pmgr-pwrstate.c
similarity index 100%
rename from drivers/genpd/apple/pmgr-pwrstate.c
rename to drivers/pmdomain/apple/pmgr-pwrstate.c
diff --git a/drivers/genpd/bcm/Makefile b/drivers/pmdomain/bcm/Makefile
similarity index 100%
rename from drivers/genpd/bcm/Makefile
rename to drivers/pmdomain/bcm/Makefile
diff --git a/drivers/genpd/bcm/bcm-pmb.c b/drivers/pmdomain/bcm/bcm-pmb.c
similarity index 100%
rename from drivers/genpd/bcm/bcm-pmb.c
rename to drivers/pmdomain/bcm/bcm-pmb.c
diff --git a/drivers/genpd/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
similarity index 100%
rename from drivers/genpd/bcm/bcm2835-power.c
rename to drivers/pmdomain/bcm/bcm2835-power.c
diff --git a/drivers/genpd/bcm/bcm63xx-power.c b/drivers/pmdomain/bcm/bcm63xx-power.c
similarity index 100%
rename from drivers/genpd/bcm/bcm63xx-power.c
rename to drivers/pmdomain/bcm/bcm63xx-power.c
diff --git a/drivers/genpd/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
similarity index 100%
rename from drivers/genpd/bcm/raspberrypi-power.c
rename to drivers/pmdomain/bcm/raspberrypi-power.c
diff --git a/drivers/genpd/imx/Makefile b/drivers/pmdomain/imx/Makefile
similarity index 100%
rename from drivers/genpd/imx/Makefile
rename to drivers/pmdomain/imx/Makefile
diff --git a/drivers/genpd/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
similarity index 100%
rename from drivers/genpd/imx/gpc.c
rename to drivers/pmdomain/imx/gpc.c
diff --git a/drivers/genpd/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
similarity index 100%
rename from drivers/genpd/imx/gpcv2.c
rename to drivers/pmdomain/imx/gpcv2.c
diff --git a/drivers/genpd/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
similarity index 100%
rename from drivers/genpd/imx/imx8m-blk-ctrl.c
rename to drivers/pmdomain/imx/imx8m-blk-ctrl.c
diff --git a/drivers/genpd/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
similarity index 100%
rename from drivers/genpd/imx/imx8mp-blk-ctrl.c
rename to drivers/pmdomain/imx/imx8mp-blk-ctrl.c
diff --git a/drivers/genpd/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
similarity index 100%
rename from drivers/genpd/imx/imx93-blk-ctrl.c
rename to drivers/pmdomain/imx/imx93-blk-ctrl.c
diff --git a/drivers/genpd/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
similarity index 100%
rename from drivers/genpd/imx/imx93-pd.c
rename to drivers/pmdomain/imx/imx93-pd.c
diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
similarity index 100%
rename from drivers/genpd/imx/scu-pd.c
rename to drivers/pmdomain/imx/scu-pd.c
diff --git a/drivers/genpd/mediatek/Makefile b/drivers/pmdomain/mediatek/Makefile
similarity index 100%
rename from drivers/genpd/mediatek/Makefile
rename to drivers/pmdomain/mediatek/Makefile
diff --git a/drivers/genpd/mediatek/mt6795-pm-domains.h b/drivers/pmdomain/mediatek/mt6795-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt6795-pm-domains.h
rename to drivers/pmdomain/mediatek/mt6795-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8167-pm-domains.h b/drivers/pmdomain/mediatek/mt8167-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8167-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8167-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8173-pm-domains.h b/drivers/pmdomain/mediatek/mt8173-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8173-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8173-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8183-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8183-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8186-pm-domains.h b/drivers/pmdomain/mediatek/mt8186-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8186-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8186-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8188-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8188-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8192-pm-domains.h b/drivers/pmdomain/mediatek/mt8192-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8192-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8192-pm-domains.h
diff --git a/drivers/genpd/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mt8195-pm-domains.h
rename to drivers/pmdomain/mediatek/mt8195-pm-domains.h
diff --git a/drivers/genpd/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
similarity index 100%
rename from drivers/genpd/mediatek/mtk-pm-domains.c
rename to drivers/pmdomain/mediatek/mtk-pm-domains.c
diff --git a/drivers/genpd/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
similarity index 100%
rename from drivers/genpd/mediatek/mtk-pm-domains.h
rename to drivers/pmdomain/mediatek/mtk-pm-domains.h
diff --git a/drivers/genpd/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c
similarity index 100%
rename from drivers/genpd/mediatek/mtk-scpsys.c
rename to drivers/pmdomain/mediatek/mtk-scpsys.c
diff --git a/drivers/genpd/qcom/Makefile b/drivers/pmdomain/qcom/Makefile
similarity index 100%
rename from drivers/genpd/qcom/Makefile
rename to drivers/pmdomain/qcom/Makefile
diff --git a/drivers/genpd/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
similarity index 100%
rename from drivers/genpd/qcom/cpr.c
rename to drivers/pmdomain/qcom/cpr.c
diff --git a/drivers/genpd/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
similarity index 100%
rename from drivers/genpd/qcom/rpmhpd.c
rename to drivers/pmdomain/qcom/rpmhpd.c
diff --git a/drivers/genpd/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
similarity index 100%
rename from drivers/genpd/qcom/rpmpd.c
rename to drivers/pmdomain/qcom/rpmpd.c
diff --git a/drivers/genpd/renesas/Makefile b/drivers/pmdomain/renesas/Makefile
similarity index 100%
rename from drivers/genpd/renesas/Makefile
rename to drivers/pmdomain/renesas/Makefile
diff --git a/drivers/genpd/renesas/r8a7742-sysc.c b/drivers/pmdomain/renesas/r8a7742-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7742-sysc.c
rename to drivers/pmdomain/renesas/r8a7742-sysc.c
diff --git a/drivers/genpd/renesas/r8a7743-sysc.c b/drivers/pmdomain/renesas/r8a7743-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7743-sysc.c
rename to drivers/pmdomain/renesas/r8a7743-sysc.c
diff --git a/drivers/genpd/renesas/r8a7745-sysc.c b/drivers/pmdomain/renesas/r8a7745-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7745-sysc.c
rename to drivers/pmdomain/renesas/r8a7745-sysc.c
diff --git a/drivers/genpd/renesas/r8a77470-sysc.c b/drivers/pmdomain/renesas/r8a77470-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77470-sysc.c
rename to drivers/pmdomain/renesas/r8a77470-sysc.c
diff --git a/drivers/genpd/renesas/r8a774a1-sysc.c b/drivers/pmdomain/renesas/r8a774a1-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a774a1-sysc.c
rename to drivers/pmdomain/renesas/r8a774a1-sysc.c
diff --git a/drivers/genpd/renesas/r8a774b1-sysc.c b/drivers/pmdomain/renesas/r8a774b1-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a774b1-sysc.c
rename to drivers/pmdomain/renesas/r8a774b1-sysc.c
diff --git a/drivers/genpd/renesas/r8a774c0-sysc.c b/drivers/pmdomain/renesas/r8a774c0-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a774c0-sysc.c
rename to drivers/pmdomain/renesas/r8a774c0-sysc.c
diff --git a/drivers/genpd/renesas/r8a774e1-sysc.c b/drivers/pmdomain/renesas/r8a774e1-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a774e1-sysc.c
rename to drivers/pmdomain/renesas/r8a774e1-sysc.c
diff --git a/drivers/genpd/renesas/r8a7779-sysc.c b/drivers/pmdomain/renesas/r8a7779-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7779-sysc.c
rename to drivers/pmdomain/renesas/r8a7779-sysc.c
diff --git a/drivers/genpd/renesas/r8a7790-sysc.c b/drivers/pmdomain/renesas/r8a7790-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7790-sysc.c
rename to drivers/pmdomain/renesas/r8a7790-sysc.c
diff --git a/drivers/genpd/renesas/r8a7791-sysc.c b/drivers/pmdomain/renesas/r8a7791-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7791-sysc.c
rename to drivers/pmdomain/renesas/r8a7791-sysc.c
diff --git a/drivers/genpd/renesas/r8a7792-sysc.c b/drivers/pmdomain/renesas/r8a7792-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7792-sysc.c
rename to drivers/pmdomain/renesas/r8a7792-sysc.c
diff --git a/drivers/genpd/renesas/r8a7794-sysc.c b/drivers/pmdomain/renesas/r8a7794-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7794-sysc.c
rename to drivers/pmdomain/renesas/r8a7794-sysc.c
diff --git a/drivers/genpd/renesas/r8a7795-sysc.c b/drivers/pmdomain/renesas/r8a7795-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7795-sysc.c
rename to drivers/pmdomain/renesas/r8a7795-sysc.c
diff --git a/drivers/genpd/renesas/r8a7796-sysc.c b/drivers/pmdomain/renesas/r8a7796-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a7796-sysc.c
rename to drivers/pmdomain/renesas/r8a7796-sysc.c
diff --git a/drivers/genpd/renesas/r8a77965-sysc.c b/drivers/pmdomain/renesas/r8a77965-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77965-sysc.c
rename to drivers/pmdomain/renesas/r8a77965-sysc.c
diff --git a/drivers/genpd/renesas/r8a77970-sysc.c b/drivers/pmdomain/renesas/r8a77970-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77970-sysc.c
rename to drivers/pmdomain/renesas/r8a77970-sysc.c
diff --git a/drivers/genpd/renesas/r8a77980-sysc.c b/drivers/pmdomain/renesas/r8a77980-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77980-sysc.c
rename to drivers/pmdomain/renesas/r8a77980-sysc.c
diff --git a/drivers/genpd/renesas/r8a77990-sysc.c b/drivers/pmdomain/renesas/r8a77990-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77990-sysc.c
rename to drivers/pmdomain/renesas/r8a77990-sysc.c
diff --git a/drivers/genpd/renesas/r8a77995-sysc.c b/drivers/pmdomain/renesas/r8a77995-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a77995-sysc.c
rename to drivers/pmdomain/renesas/r8a77995-sysc.c
diff --git a/drivers/genpd/renesas/r8a779a0-sysc.c b/drivers/pmdomain/renesas/r8a779a0-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a779a0-sysc.c
rename to drivers/pmdomain/renesas/r8a779a0-sysc.c
diff --git a/drivers/genpd/renesas/r8a779f0-sysc.c b/drivers/pmdomain/renesas/r8a779f0-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a779f0-sysc.c
rename to drivers/pmdomain/renesas/r8a779f0-sysc.c
diff --git a/drivers/genpd/renesas/r8a779g0-sysc.c b/drivers/pmdomain/renesas/r8a779g0-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/r8a779g0-sysc.c
rename to drivers/pmdomain/renesas/r8a779g0-sysc.c
diff --git a/drivers/genpd/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/rcar-gen4-sysc.c
rename to drivers/pmdomain/renesas/rcar-gen4-sysc.c
diff --git a/drivers/genpd/renesas/rcar-gen4-sysc.h b/drivers/pmdomain/renesas/rcar-gen4-sysc.h
similarity index 100%
rename from drivers/genpd/renesas/rcar-gen4-sysc.h
rename to drivers/pmdomain/renesas/rcar-gen4-sysc.h
diff --git a/drivers/genpd/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/rcar-sysc.c
rename to drivers/pmdomain/renesas/rcar-sysc.c
diff --git a/drivers/genpd/renesas/rcar-sysc.h b/drivers/pmdomain/renesas/rcar-sysc.h
similarity index 100%
rename from drivers/genpd/renesas/rcar-sysc.h
rename to drivers/pmdomain/renesas/rcar-sysc.h
diff --git a/drivers/genpd/renesas/rmobile-sysc.c b/drivers/pmdomain/renesas/rmobile-sysc.c
similarity index 100%
rename from drivers/genpd/renesas/rmobile-sysc.c
rename to drivers/pmdomain/renesas/rmobile-sysc.c
diff --git a/drivers/genpd/rockchip/Makefile b/drivers/pmdomain/rockchip/Makefile
similarity index 100%
rename from drivers/genpd/rockchip/Makefile
rename to drivers/pmdomain/rockchip/Makefile
diff --git a/drivers/genpd/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
similarity index 100%
rename from drivers/genpd/rockchip/pm-domains.c
rename to drivers/pmdomain/rockchip/pm-domains.c
diff --git a/drivers/genpd/samsung/Makefile b/drivers/pmdomain/samsung/Makefile
similarity index 100%
rename from drivers/genpd/samsung/Makefile
rename to drivers/pmdomain/samsung/Makefile
diff --git a/drivers/genpd/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
similarity index 100%
rename from drivers/genpd/samsung/exynos-pm-domains.c
rename to drivers/pmdomain/samsung/exynos-pm-domains.c
diff --git a/drivers/genpd/st/Makefile b/drivers/pmdomain/st/Makefile
similarity index 100%
rename from drivers/genpd/st/Makefile
rename to drivers/pmdomain/st/Makefile
diff --git a/drivers/genpd/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
similarity index 100%
rename from drivers/genpd/st/ste-ux500-pm-domain.c
rename to drivers/pmdomain/st/ste-ux500-pm-domain.c
diff --git a/drivers/genpd/starfive/Makefile b/drivers/pmdomain/starfive/Makefile
similarity index 100%
rename from drivers/genpd/starfive/Makefile
rename to drivers/pmdomain/starfive/Makefile
diff --git a/drivers/genpd/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
similarity index 100%
rename from drivers/genpd/starfive/jh71xx-pmu.c
rename to drivers/pmdomain/starfive/jh71xx-pmu.c
diff --git a/drivers/genpd/sunxi/Makefile b/drivers/pmdomain/sunxi/Makefile
similarity index 100%
rename from drivers/genpd/sunxi/Makefile
rename to drivers/pmdomain/sunxi/Makefile
diff --git a/drivers/genpd/sunxi/sun20i-ppu.c b/drivers/pmdomain/sunxi/sun20i-ppu.c
similarity index 100%
rename from drivers/genpd/sunxi/sun20i-ppu.c
rename to drivers/pmdomain/sunxi/sun20i-ppu.c
diff --git a/drivers/genpd/tegra/Makefile b/drivers/pmdomain/tegra/Makefile
similarity index 100%
rename from drivers/genpd/tegra/Makefile
rename to drivers/pmdomain/tegra/Makefile
diff --git a/drivers/genpd/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
similarity index 100%
rename from drivers/genpd/tegra/powergate-bpmp.c
rename to drivers/pmdomain/tegra/powergate-bpmp.c
diff --git a/drivers/genpd/ti/Makefile b/drivers/pmdomain/ti/Makefile
similarity index 100%
rename from drivers/genpd/ti/Makefile
rename to drivers/pmdomain/ti/Makefile
diff --git a/drivers/genpd/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
similarity index 100%
rename from drivers/genpd/ti/omap_prm.c
rename to drivers/pmdomain/ti/omap_prm.c
diff --git a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
similarity index 100%
rename from drivers/genpd/ti/ti_sci_pm_domains.c
rename to drivers/pmdomain/ti/ti_sci_pm_domains.c
diff --git a/drivers/genpd/xilinx/Makefile b/drivers/pmdomain/xilinx/Makefile
similarity index 100%
rename from drivers/genpd/xilinx/Makefile
rename to drivers/pmdomain/xilinx/Makefile
diff --git a/drivers/genpd/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
similarity index 100%
rename from drivers/genpd/xilinx/zynqmp-pm-domains.c
rename to drivers/pmdomain/xilinx/zynqmp-pm-domains.c
-- 
2.34.1

