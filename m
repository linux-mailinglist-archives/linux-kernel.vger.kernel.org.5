Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354E76C889
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjHBInO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjHBInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:43:07 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC1194;
        Wed,  2 Aug 2023 01:43:04 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E2A9924E199;
        Wed,  2 Aug 2023 16:43:02 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 16:43:02 +0800
Received: from localhost.localdomain (183.27.98.54) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 2 Aug
 2023 16:43:01 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Maxim Kochetkov" <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        "Xingyu Wu" <xingyu.wu@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v1 0/5] Add I2S support for the StarFive JH7110 SoC
Date:   Wed, 2 Aug 2023 16:42:56 +0800
Message-ID: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds I2S support for the StarFive JH7110 RISC-V
SoC based on Designware I2S controller. There has three I2S channels
(RX/TX0/TX1) on the JH7110 SoC, one of which is for record(RX) and
two for playback(TX).

The first patch adds the ops to get data from platform bus in the
I2S driver.
The second patch adds support for the StarFive JH7110 SoC in
the Designware I2S bindings.
The third patch adds support for the StarFive JH7110 SoC in
the Designware I2S driver. 
The fourth patch fixes the name of I2STX1 pinmux.
The last patch adds device node of I2S RX/TX0/TX1 in JH7110 dts.

This patch series is based on Linux-next which is merge clock,
syscon and dma nodes for the StarFive JH7110 SoC. And these
should be applied after the following patchset:
https://lore.kernel.org/all/20230724055440.100947-1-xingyu.wu@starfivetech.com/

The series has been tested and works normally on the VisionFive 2
board by plugging an audio expansion board.

Xingyu Wu (5):
  ASoC: dwc: Use ops to get platform data
  ASoC: dt-bindings: snps,designware-i2s: Add StarFive JH7110 SoC
    support
  ASoC: dwc: i2s: Add StarFive JH7110 SoC support
  riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
  riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1

 .../bindings/sound/snps,designware-i2s.yaml   | 101 +++++-
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h |   4 +-
 .../jh7110-starfive-visionfive-2.dtsi         |  58 ++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  65 ++++
 include/sound/designware_i2s.h                |   3 +
 sound/soc/dwc/dwc-i2s.c                       | 318 ++++++++++++++++--
 sound/soc/dwc/local.h                         |   1 +
 7 files changed, 523 insertions(+), 27 deletions(-)


base-commit: 0fee53365d051781156b75c6f6e6015757e71fd8
prerequisite-patch-id: 0159f09bb0a1ff711a00ae17ef5b12662c9c7d3d
-- 
2.25.1

