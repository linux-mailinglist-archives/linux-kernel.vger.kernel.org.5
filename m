Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0415F7DE046
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjKALZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjKALZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:25:25 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1000F7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:25:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507ad511315so9641820e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698837918; x=1699442718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTLsGn0av/ptJmCJ6UISKnfoymHQRTy2A0oy+VGOqG4=;
        b=nPXH6SEK1yxfzcBt5J8FQ1MA4J5sYoECRYR8yPCSwiHt+RP3kBnkfS1890p1CurUEJ
         6QPg646A69GvnXiuO3o4v03zZaB6cA83E4MI51eceGA3vG/3gedOX8lIDpm/N54Dw1hP
         NaPi5Dgb6Vc4kxMpss1l5U5QQS/MbH8YeQH6cRjI3S/tEH+JCKG68fhG6kMLqc/i17SN
         AxTCID3oAFMTdAxTIZbz/xoZxW0nPIruKsZl0JzzeTNnVd//vMnrPaW0zigSV/YF8GME
         pJkvurkObhTF5pOk9aGZb4IK/PwkN6wZt1gkiTiCdpXspEuDSw0Me+J4+VVWY1v0Lbmq
         NZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837918; x=1699442718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTLsGn0av/ptJmCJ6UISKnfoymHQRTy2A0oy+VGOqG4=;
        b=ZkkR1SPUrcK8Q71D2vKr0XgKZhjply83KOwW9xwqIczmXeZfwfGiMvpiAWCLAXA9+K
         SxlNhIf3DOuQclbRKwwhnuhPZ5AYkQo90LuDiBUE8OYZWS/px+4DFpPERGixpsFUu89d
         QIGnp+bU0ezb6eeuriD2i1Clt3Zw/IcBd21mFFIzpM9n5DJ5PwKv6Ym84z0OC62kpN2F
         lbzxqri4IeaQ1thk+ecJ6BGHNiVJwT1LR/PSZN6ff4YAjmzFQVWp8O6T8Fuy3Pif7V1G
         97rBPkQCn3yH6CCnuE9HNI3VU/5kq6WJa9PIKAkTtcYAKKypocWeLXp1gA1xfq8I8Fgb
         U1ZA==
X-Gm-Message-State: AOJu0YyAWKX+oD19Ne8ySe3kGWZq1VvfUlREBkzXxw3g8Nvr6UkIMFdt
        VniRd/+PGBxjyvI9HkAW09TY9H3XBx4oHbPGIos=
X-Google-Smtp-Source: AGHT+IEt0cqw0WG0csCOEKOW8isjaA+Q2Oo+yjZZWzoSKz11mj6teGBsW7zTsp3VQwbBCu5UuHs/tg==
X-Received: by 2002:a19:2d45:0:b0:507:9a93:84df with SMTP id t5-20020a192d45000000b005079a9384dfmr10506678lft.25.1698837917926;
        Wed, 01 Nov 2023 04:25:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id f8-20020a0565123b0800b00502e2347ef0sm188744lfv.193.2023.11.01.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:25:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v6.7
Date:   Wed,  1 Nov 2023 12:25:16 +0100
Message-Id: <20231101112516.5623-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the pull-request with pmdomain updates for v6.7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 767881c470b3140c33795031c4e4d65572731c1c:

  pmdomain: imx: scu-pd: correct DMA2 channel (2023-10-05 00:28:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.7

for you to fetch changes up to 9e0cceadb7a5099c637e787191a9adbf9ec424cd:

  pmdomain: Merge branch fixes into next (2023-10-27 11:02:11 +0200)

----------------------------------------------------------------
 - Move Kconfig files into the pmdomain subsystem
 - Drop use of genpd's redundant ->opp_to_performance_state() callback
 - amlogic: Add support for the T7 power-domains controller
 - amlogic: Fix mask for the second NNA mem power-domain
 - bcm: Fixup ASB register read and comparison for bcm2835-power
 - imx: Fix device link problem for consumers of the pgc power-domain
 - mediatek: Add support for the MT8365 power domains
 - qcom: Add support for the rpmhpds for SC8380XP power-domains
 - qcom: Add support for the rpmhpds for SM8650 power-domains
 - qcom: Add support for the rpmhpd clocks for SM7150
 - qcom: Add support for the rpmpds for MSM8917 (families) power-domains
 - starfive: Add support for the JH7110 AON PMU

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: power: rpmpd: Add SC8380XP support
      pmdomain: qcom: rpmhpd: Add SC8380XP power domains

Alexandre Bailon (2):
      pmdomain: mediatek: Add support for WAY_EN operations
      pmdomain: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Changhuang Liang (6):
      dt-bindings: power: Add power-domain header for JH7110
      pmdomain: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
      pmdomain: starfive: Extract JH7110 pmu private operations
      pmdomain: starfive: Add JH7110 AON PMU support
      dt-bindings: power: Update prefixes for AON power domain
      pmdomain: starfive: Update prefixes for AON power domain

Danila Tikhonov (2):
      dt-bindings: power: qcom,rpmpd: Add SM7150
      pmdomain: qcom: rpmhpd: Add support for SM7150 rpmh clocks

Fabien Parent (2):
      dt-bindings: power: Add MT8365 power domains
      pmdomain: mediatek: Add support for MT8365

Julia Lawall (1):
      pmdomain: ti: add missing of_node_put

Justin Stitt (1):
      pmdomain: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast warning

Markus Schneider-Pargmann (4):
      pmdomain: mediatek: Move bools to a flags field
      pmdomain: mediatek: Split bus_prot_mask
      pmdomain: mediatek: Create bus protection operation functions
      pmdomain: mediatek: Unify configuration for infracfg and smi

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: check if the ASB register is equal to enable

Neil Armstrong (2):
      dt-bindings: power: qcom,rpmpd: document the SM8650 RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add SM8650 RPMh Power Domains

Otto Pflüger (3):
      dt-bindings: power: rpmpd: Add MSM8917, MSM8937 and QM215
      pmdomain: qcom: rpmpd: Add MSM8917 power domains
      pmdomain: qcom: rpmpd: Add QM215 power domains

Pengfei Li (1):
      pmdomain: imx: Make imx pgc power domain also set the fwnode

Rob Herring (2):
      pmdomain: starfive: Explicitly include correct DT includes
      pmdomain: Use device_get_match_data()

Sibi Sankar (1):
      dt-bindings: power: qcom,rpmhpd: Add GMXC PD index

Tomeu Vizoso (1):
      pmdomain: amlogic: Fix mask for the second NNA mem PD domain

Ulf Hansson (28):
      pmdomain: Merge the genpd_dt branch into the next branch
      pmdomain: Prepare to move Kconfig files into the pmdomain subsystem
      pmdomain: actions: Move Kconfig file to the pmdomain subsystem
      pmdomain: amlogic: Move Kconfig options to the pmdomain subsystem
      pmdomain: apple: Move Kconfig option to the pmdomain subsystem
      pmdomain: bcm: Move Kconfig options to the pmdomain subsystem
      pmdomain: imx: Move Kconfig options to the pmdomain subsystem
      pmdomain: mediatek: Move Kconfig options to the pmdomain subsystem
      pmdomain: qcom: Move Kconfig options to the pmdomain subsystem
      pmdomain: renesas: Move Kconfig options to the pmdomain subsystem
      pmdomain: rockchip: Move Kconfig option to the pmdomain subsystem
      pmdomain: samsung: Move Kconfig option to the pmdomain subsystem
      pmdomain: st: Add a Kconfig option for the ux500 power domain
      pmdomain: starfive: Move Kconfig file to the pmdomain subsystem
      pmdomain: sunxi: Move Kconfig option to the pmdomain subsystem
      pmdomain: tegra: Move Kconfig option to the pmdomain subsystem
      pmdomain: ti: Move and add Kconfig options to the pmdomain subsystem
      pmdomain: xilinx: Move Kconfig option to the pmdomain subsystem
      pmdomain: Merge branch genpd_dt into next
      pmdomain: Merge branch genpd_dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: qcom: cpr: Drop the ->opp_to_performance_state() callback
      pmdomain: qcom: rpmpd: Drop the ->opp_to_performance_state() callback
      pmdomain: qcom: rpmhpd: Drop the ->opp_to_performance_state() callback
      pmdomain: Merge branch genpd_dt into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch genpd_dt into next
      pmdomain: Merge branch fixes into next

xianwei.zhao (5):
      dt-bindings: power: add Amlogic T7 power domains
      pmdomain: amlogic: modify some power domains property
      pmdomain: amlogic: add driver to support power parent node
      pmdomain: amlogic: init power domain state
      pmdomain: amlogic: Add support for T7 power domains controller

 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |   3 +-
 .../bindings/power/mediatek,power-controller.yaml  |   6 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  82 +++----
 MAINTAINERS                                        |   6 +-
 drivers/Kconfig                                    |   2 +
 drivers/firmware/imx/Kconfig                       |   6 -
 drivers/pmdomain/Kconfig                           |  21 ++
 drivers/{soc => pmdomain}/actions/Kconfig          |   0
 drivers/pmdomain/actions/owl-sps.c                 |  16 +-
 drivers/pmdomain/amlogic/Kconfig                   |  39 ++++
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |   2 +-
 drivers/pmdomain/amlogic/meson-secure-pwrc.c       | 127 +++++++++--
 drivers/pmdomain/apple/Kconfig                     |  18 ++
 drivers/pmdomain/bcm/Kconfig                       |  42 ++++
 drivers/pmdomain/bcm/bcm2835-power.c               |   2 +-
 drivers/pmdomain/imx/Kconfig                       |  29 +++
 drivers/pmdomain/imx/gpc.c                         |   8 +-
 drivers/pmdomain/mediatek/Kconfig                  |  29 +++
 drivers/pmdomain/mediatek/mt6795-pm-domains.h      |  16 +-
 drivers/pmdomain/mediatek/mt8167-pm-domains.h      |  20 +-
 drivers/pmdomain/mediatek/mt8173-pm-domains.h      |  16 +-
 drivers/pmdomain/mediatek/mt8183-pm-domains.h      | 125 ++++++-----
 drivers/pmdomain/mediatek/mt8186-pm-domains.h      | 236 ++++++++++++---------
 drivers/pmdomain/mediatek/mt8188-pm-domains.h      | 223 ++++++++++++-------
 drivers/pmdomain/mediatek/mt8192-pm-domains.h      | 112 ++++++----
 drivers/pmdomain/mediatek/mt8195-pm-domains.h      | 199 ++++++++++-------
 drivers/pmdomain/mediatek/mt8365-pm-domains.h      | 197 +++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         | 157 +++++++++-----
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |  51 +++--
 drivers/pmdomain/qcom/Kconfig                      |  41 ++++
 drivers/pmdomain/qcom/cpr.c                        |   7 -
 drivers/pmdomain/qcom/rpmhpd.c                     |  83 +++++++-
 drivers/pmdomain/qcom/rpmpd.c                      |  98 ++++++++-
 drivers/pmdomain/renesas/Kconfig                   | 109 ++++++++++
 drivers/pmdomain/renesas/rmobile-sysc.c            |   2 +-
 drivers/pmdomain/rockchip/Kconfig                  |  16 ++
 drivers/pmdomain/rockchip/pm-domains.c             |  13 +-
 drivers/pmdomain/samsung/Kconfig                   |   8 +
 drivers/pmdomain/st/Kconfig                        |   5 +
 drivers/pmdomain/st/Makefile                       |   2 +-
 drivers/{soc => pmdomain}/starfive/Kconfig         |   4 +-
 drivers/pmdomain/starfive/jh71xx-pmu.c             | 139 +++++++++---
 drivers/pmdomain/sunxi/Kconfig                     |  10 +
 drivers/pmdomain/tegra/Kconfig                     |   6 +
 drivers/pmdomain/ti/Kconfig                        |  22 ++
 drivers/pmdomain/ti/Makefile                       |   2 +-
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |   8 +-
 drivers/pmdomain/xilinx/Kconfig                    |  10 +
 drivers/soc/Kconfig                                |   2 -
 drivers/soc/amlogic/Kconfig                        |  35 ---
 drivers/soc/apple/Kconfig                          |  13 --
 drivers/soc/bcm/Kconfig                            |  51 -----
 drivers/soc/imx/Kconfig                            |  19 --
 drivers/soc/mediatek/Kconfig                       |  23 --
 drivers/soc/qcom/Kconfig                           |  37 ----
 drivers/soc/renesas/Kconfig                        | 105 ---------
 drivers/soc/rockchip/Kconfig                       |  12 --
 drivers/soc/samsung/Kconfig                        |   4 -
 drivers/soc/sunxi/Kconfig                          |   9 -
 drivers/soc/tegra/Kconfig                          |   5 -
 drivers/soc/ti/Kconfig                             |  12 --
 drivers/soc/xilinx/Kconfig                         |   9 -
 include/dt-bindings/power/amlogic,t7-pwrc.h        |  63 ++++++
 include/dt-bindings/power/mediatek,mt8365-power.h  |  19 ++
 include/dt-bindings/power/qcom,rpmhpd.h            |   2 +
 include/dt-bindings/power/qcom-rpmpd.h             |  21 ++
 include/dt-bindings/power/starfive,jh7110-pmu.h    |   6 +-
 include/linux/soc/mediatek/infracfg.h              |  41 ++++
 68 files changed, 1938 insertions(+), 925 deletions(-)
 create mode 100644 drivers/pmdomain/Kconfig
 rename drivers/{soc => pmdomain}/actions/Kconfig (100%)
 create mode 100644 drivers/pmdomain/amlogic/Kconfig
 create mode 100644 drivers/pmdomain/apple/Kconfig
 create mode 100644 drivers/pmdomain/bcm/Kconfig
 create mode 100644 drivers/pmdomain/imx/Kconfig
 create mode 100644 drivers/pmdomain/mediatek/Kconfig
 create mode 100644 drivers/pmdomain/mediatek/mt8365-pm-domains.h
 create mode 100644 drivers/pmdomain/qcom/Kconfig
 create mode 100644 drivers/pmdomain/renesas/Kconfig
 create mode 100644 drivers/pmdomain/rockchip/Kconfig
 create mode 100644 drivers/pmdomain/samsung/Kconfig
 create mode 100644 drivers/pmdomain/st/Kconfig
 rename drivers/{soc => pmdomain}/starfive/Kconfig (84%)
 create mode 100644 drivers/pmdomain/sunxi/Kconfig
 create mode 100644 drivers/pmdomain/tegra/Kconfig
 create mode 100644 drivers/pmdomain/ti/Kconfig
 create mode 100644 drivers/pmdomain/xilinx/Kconfig
 create mode 100644 include/dt-bindings/power/amlogic,t7-pwrc.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
