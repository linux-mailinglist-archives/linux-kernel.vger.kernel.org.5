Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22779E451
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239580AbjIMJzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjIMJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:54:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4C1BD4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:54:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so114607431fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694598884; x=1695203684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDbjl8V8942DBH9vHu9kycouHiWPdzm6gV+T3L4Gzxk=;
        b=MFvHT+hXCQbBkHpK4kwOvWUI3XoNVwXI4ANWAwQj7lY74YSMpXXC499riel5z9q+WY
         94dO8L08j+HCjbG+YSgSubpO50JK0w/Nl+QLtdcdKq59t2F5SyqI63TOYFow8o0vPce2
         zOujEhXraq/r8x2Ds2xkZAdftnyczZ+sVBBgyMRLlPD/8WFWb4+XfJl0ceMMVFXNghqj
         sjIGVAKFbs5yHeyDViRqbwM9EeCj0PpxQohcCBNIpbY4Aw8BANs5Qt1xVKjrgCK1xozP
         cMrbfsVvj3/BC9FsmQB0YAHizJERT8o9QK5PgTYGwNfOJRFzEnOg8DQ0K2Zt1fBLUbWn
         qk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598884; x=1695203684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDbjl8V8942DBH9vHu9kycouHiWPdzm6gV+T3L4Gzxk=;
        b=Sog0M8kmr2Oko60bZU1mfvBsi5hc6KS7mY0GW9xoZD/jI37M3bURyZOUYE2rpZ/b8o
         n2sJpyt9CeKic7k10eys/sGR9IJ0ondKQOcx4nyG6oAArUoPBkPeshXFUWXLjaHUIZFg
         n00ylVUtdYA6UNisVy/+AKlRRUOqrm4HRd1vvzrnFp5x1rCDGpX/rCyKNHNbBuPNeS5L
         bUwQaZ490UDjIv5oYvJfhqZuWk99ZtT4ZmLymKA4AL/J/f0/4KKnon2hEZoz/XrDCN3b
         uhjLN26GS5ytK6SHaDoLpQoUQdnnBWRyeWY85JDQB+8JTDfp9O8Ymx52mEZ+Mx9wEfFY
         5APQ==
X-Gm-Message-State: AOJu0Yyd/A6t1dqUJ7GUNpi2xjpoS8o8pD1OEddtjGiAPZKCOJuY5ixf
        fDMRhUZU8/1pzUVW1tvh46vmMg==
X-Google-Smtp-Source: AGHT+IH2nRC+2JfOVz070MXQwDyRlu+ueL/ZxHMDNksSKQUsRtO1qO5yqtSEQ2mpyDye2bbxPWTOxw==
X-Received: by 2002:a2e:a1d0:0:b0:2bc:db5a:9546 with SMTP id c16-20020a2ea1d0000000b002bcdb5a9546mr1637206ljm.7.1694598883855;
        Wed, 13 Sep 2023 02:54:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9c50000000b002b6ad323248sm2321196ljj.10.2023.09.13.02.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:54:43 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [GIT PULL] pmdomain (was genpd) updates for v6.6-rc2
Date:   Wed, 13 Sep 2023 11:54:41 +0200
Message-Id: <20230913095441.535328-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As discussed on LKML, using "genpd" as the name of a subsystem isn't very
self-explanatory and the acronym itself that means Generic PM Domain, is known
only by a limited group of people.

The suggestion to improve the situation is to rename the subsystem to
"pmdomain", which there seems to be a good consensus around using too. Ideally
it should indicate that its purpose is to manage Power Domains or "PM domains"
as we often also use within the Linux Kernel terminology.

The pull request contains only one commit, for the above.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.6-rc1

for you to fetch changes up to e2ad626f8f409899baf1bf192d0533a851128b19:

  pmdomain: Rename the genpd subsystem to pmdomain (2023-09-13 11:09:21 +0200)

----------------------------------------------------------------
This pull-request renames the genpd subsystem to pmdomain.

Ideally "pmdomain" should give a better hint of the purpose of the
subsystem.

----------------------------------------------------------------
Ulf Hansson (1):
      pmdomain: Rename the genpd subsystem to pmdomain

 MAINTAINERS                                        | 22 +++++++++++-----------
 drivers/Makefile                                   |  2 +-
 drivers/{genpd => pmdomain}/Makefile               |  0
 drivers/{genpd => pmdomain}/actions/Makefile       |  0
 .../{genpd => pmdomain}/actions/owl-sps-helper.c   |  0
 drivers/{genpd => pmdomain}/actions/owl-sps.c      |  0
 drivers/{genpd => pmdomain}/amlogic/Makefile       |  0
 .../{genpd => pmdomain}/amlogic/meson-ee-pwrc.c    |  0
 .../amlogic/meson-gx-pwrc-vpu.c                    |  0
 .../amlogic/meson-secure-pwrc.c                    |  0
 drivers/{genpd => pmdomain}/apple/Makefile         |  0
 drivers/{genpd => pmdomain}/apple/pmgr-pwrstate.c  |  0
 drivers/{genpd => pmdomain}/bcm/Makefile           |  0
 drivers/{genpd => pmdomain}/bcm/bcm-pmb.c          |  0
 drivers/{genpd => pmdomain}/bcm/bcm2835-power.c    |  0
 drivers/{genpd => pmdomain}/bcm/bcm63xx-power.c    |  0
 .../{genpd => pmdomain}/bcm/raspberrypi-power.c    |  0
 drivers/{genpd => pmdomain}/imx/Makefile           |  0
 drivers/{genpd => pmdomain}/imx/gpc.c              |  0
 drivers/{genpd => pmdomain}/imx/gpcv2.c            |  0
 drivers/{genpd => pmdomain}/imx/imx8m-blk-ctrl.c   |  0
 drivers/{genpd => pmdomain}/imx/imx8mp-blk-ctrl.c  |  0
 drivers/{genpd => pmdomain}/imx/imx93-blk-ctrl.c   |  0
 drivers/{genpd => pmdomain}/imx/imx93-pd.c         |  0
 drivers/{genpd => pmdomain}/imx/scu-pd.c           |  0
 drivers/{genpd => pmdomain}/mediatek/Makefile      |  0
 .../mediatek/mt6795-pm-domains.h                   |  0
 .../mediatek/mt8167-pm-domains.h                   |  0
 .../mediatek/mt8173-pm-domains.h                   |  0
 .../mediatek/mt8183-pm-domains.h                   |  0
 .../mediatek/mt8186-pm-domains.h                   |  0
 .../mediatek/mt8188-pm-domains.h                   |  0
 .../mediatek/mt8192-pm-domains.h                   |  0
 .../mediatek/mt8195-pm-domains.h                   |  0
 .../{genpd => pmdomain}/mediatek/mtk-pm-domains.c  |  0
 .../{genpd => pmdomain}/mediatek/mtk-pm-domains.h  |  0
 drivers/{genpd => pmdomain}/mediatek/mtk-scpsys.c  |  0
 drivers/{genpd => pmdomain}/qcom/Makefile          |  0
 drivers/{genpd => pmdomain}/qcom/cpr.c             |  0
 drivers/{genpd => pmdomain}/qcom/rpmhpd.c          |  0
 drivers/{genpd => pmdomain}/qcom/rpmpd.c           |  0
 drivers/{genpd => pmdomain}/renesas/Makefile       |  0
 drivers/{genpd => pmdomain}/renesas/r8a7742-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7743-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7745-sysc.c |  0
 .../{genpd => pmdomain}/renesas/r8a77470-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a774a1-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a774b1-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a774c0-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a774e1-sysc.c    |  0
 drivers/{genpd => pmdomain}/renesas/r8a7779-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7790-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7791-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7792-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7794-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7795-sysc.c |  0
 drivers/{genpd => pmdomain}/renesas/r8a7796-sysc.c |  0
 .../{genpd => pmdomain}/renesas/r8a77965-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a77970-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a77980-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a77990-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a77995-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a779a0-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a779f0-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/r8a779g0-sysc.c    |  0
 .../{genpd => pmdomain}/renesas/rcar-gen4-sysc.c   |  0
 .../{genpd => pmdomain}/renesas/rcar-gen4-sysc.h   |  0
 drivers/{genpd => pmdomain}/renesas/rcar-sysc.c    |  0
 drivers/{genpd => pmdomain}/renesas/rcar-sysc.h    |  0
 drivers/{genpd => pmdomain}/renesas/rmobile-sysc.c |  0
 drivers/{genpd => pmdomain}/rockchip/Makefile      |  0
 drivers/{genpd => pmdomain}/rockchip/pm-domains.c  |  0
 drivers/{genpd => pmdomain}/samsung/Makefile       |  0
 .../samsung/exynos-pm-domains.c                    |  0
 drivers/{genpd => pmdomain}/st/Makefile            |  0
 .../{genpd => pmdomain}/st/ste-ux500-pm-domain.c   |  0
 drivers/{genpd => pmdomain}/starfive/Makefile      |  0
 drivers/{genpd => pmdomain}/starfive/jh71xx-pmu.c  |  0
 drivers/{genpd => pmdomain}/sunxi/Makefile         |  0
 drivers/{genpd => pmdomain}/sunxi/sun20i-ppu.c     |  0
 drivers/{genpd => pmdomain}/tegra/Makefile         |  0
 drivers/{genpd => pmdomain}/tegra/powergate-bpmp.c |  0
 drivers/{genpd => pmdomain}/ti/Makefile            |  0
 drivers/{genpd => pmdomain}/ti/omap_prm.c          |  0
 drivers/{genpd => pmdomain}/ti/ti_sci_pm_domains.c |  0
 drivers/{genpd => pmdomain}/xilinx/Makefile        |  0
 .../{genpd => pmdomain}/xilinx/zynqmp-pm-domains.c |  0
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
