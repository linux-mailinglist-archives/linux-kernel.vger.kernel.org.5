Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424AE77B350
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjHNIHB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjHNIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:06:29 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5643610E5;
        Mon, 14 Aug 2023 01:06:22 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7107C24E211;
        Mon, 14 Aug 2023 16:06:20 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:06:20 +0800
Received: from ubuntu.localdomain (183.27.98.20) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 14 Aug
 2023 16:06:19 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] Add PWM-DAC audio support for StarFive JH7110 RISC-V SoC
Date:   Mon, 14 Aug 2023 16:06:15 +0800
Message-ID: <20230814080618.10036-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.20]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds PWM-DAC audio support for the StarFive JH7110 SoC.
The PWM-DAC module does not require a hardware codec, but a dummy codec is
needed for the driver. The dummy spdif codec driver, which is already
upstream, is compatible with the one which JH7110 PWM-DAC needed. So we
use it as the dummy codec driver for the JH7110 PWM-DAC module.

The third patch depends on tag next-20230809 in linux-next branch.

Changes since v2:
- Rebase on tag v6.5-rc6.
- Drop the component controls.
- Use dev_err_probe() instead of dev_err() in some cases.
- Add a new struct jh7110_pwmdac_cfg to save the configuration.
- Add a new function jh7110_pwmdac_init_params() to initialize the
  parameters.

Changes since v1:
- Rebase on tag v6.5-rc3.
- Drop patch 1 and 2.
- Drop the unneeded space and line in patch 3.
- Use the dummy spdif codec driver instead of adding a new one.
- Change "dai_link->stop_dma_first = 1" to
  "dai_link->trigger_stop = SND_SOC_TRIGGER_ORDER_LDC" in patch 4.
- Drop the unneeded "status = "okay;" in patch 5.
- Change some node names in patch 5.

---
v2: https://lore.kernel.org/all/20230731032829.127864-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20230626110909.38718-1-hal.feng@starfivetech.com/

Hal Feng (3):
  ASoC: dt-bindings: Add StarFive JH7110 PWM-DAC controller
  ASoC: starfive: Add JH7110 PWM-DAC driver
  riscv: dts: starfive: Add JH7110 PWM-DAC support

 .../sound/starfive,jh7110-pwmdac.yaml         |  76 +++
 MAINTAINERS                                   |   7 +
 .../jh7110-starfive-visionfive-2.dtsi         | 141 +++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 159 ++++++
 sound/soc/starfive/Kconfig                    |   9 +
 sound/soc/starfive/Makefile                   |   1 +
 sound/soc/starfive/jh7110_pwmdac.c            | 529 ++++++++++++++++++
 7 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac.yaml
 create mode 100644 sound/soc/starfive/jh7110_pwmdac.c


base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.38.1

