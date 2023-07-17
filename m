Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14A755989
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGQCar convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Jul 2023 22:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGQCaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:30:46 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6012B;
        Sun, 16 Jul 2023 19:30:44 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 74F4424E2A5;
        Mon, 17 Jul 2023 10:30:42 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 10:30:42 +0800
Received: from localhost.localdomain (113.72.147.86) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 10:30:41 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "William Qiu" <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v7 0/7] Add PLL clocks driver and syscon for StarFive JH7110 SoC
Date:   Mon, 17 Jul 2023 10:30:33 +0800
Message-ID: <20230717023040.78860-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
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

This patch serises are to add PLL clocks driver and providers by writing
and reading syscon registers for the StarFive JH7110 RISC-V SoC. And add 
documentation and nodes to describe StarFive System Controller(syscon)
Registers. This patch serises are based on Linux 6.4.

PLLs are high speed, low jitter frequency synthesizers in JH7110.
Each PLL clock works in integer mode or fraction mode by some dividers,
and the dividers are set in several syscon registers.
The formula for calculating frequency is: 
Fvco = Fref * (NI + NF) / M / Q1

The first patch adds docunmentation to describe PLL clock bindings,
and the second patch adds documentation to decribe syscon registers.
The patch 3 modifies the SYSCRG bindings and adds PLL clock inputs.
The patch 4 adds driver to support PLL clocks for JH7110.
The patch 5 modifies the system clock driver and can select the PLL clock
source from PLL clocks driver. And the patch 6 adds the 
stg/sys/aon syscon nodes for JH7110 SoC. The last patch modifies the 
syscrg node in JH7110 dts file.

Changes since v6:
- Rebased on Linux 6.5-rc2.
- Patch 1 added the 'the' in front of 'JH7110' and changed the PLL clock
  names from 'JH7110_CLK_PLL?_OUT' to 'JH7110_PLLCLK_PLL?_OUT' in the
  binding of PLL.
- Patch 2 modified the value of 'reg' in example to fix the error.
- Patch 4 and 7 changed the PLL clock names from 'JH7110_CLK_PLL?_OUT'
  to 'JH7110_PLLCLK_PLL?_OUT' in the driver and dts.
- Patch 5 added clk_put() and a better way to detect if the pll
  references are specified in the device tree or not.

v6: https://lore.kernel.org/all/20230704064610.292603-1-xingyu.wu@starfivetech.com/

Changes since v5: 
- Rebased on Linux 6.4.
- Patch 1 fixed some grammatical mistake.
- Patch 2 added the selection about properties from different syscon
  modules and madethe example completed.
- Patch 3 dropped the 'optional' PLL clocks.

v5: https://lore.kernel.org/all/20230613125852.211636-1-xingyu.wu@starfivetech.com/

Changes since v4: 
- Rebased on Linux 6.4-rc6.
- Patch 2 dropped the example node about sys-syscon.
- Patch 3 used PLL clocks as one of optional items in SYSCRG bindings.
- Patch 4 used the patch instead about PLL clocks driver from Emil.
- Patch 5 retained the fixed factor PLL clocks as the optional source
  about PLL clocks in SYSCRG clock driver.
- Patch 6 added the child node clock-controller as the complete
  sys-syscon node and patch 7 dropped this part.

v4: https://lore.kernel.org/all/20230512022036.97987-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Rebased on Linux 6.4-rc1.
- Dropped the 'power-controller' property and used 'power-domain-cells'
  instead in syscon binding.
- Used the data by of_device_id to get the syscon registers'
  configuration include offset, mask and shift.

v3: https://lore.kernel.org/all/20230414024157.53203-1-xingyu.wu@starfivetech.com/

Changes since v2: 
- Rebased on latest JH7110 basic clock drivers.
- Added the complete documentation to describe syscon register.
- Added syscon node in JH7110 dts file.
- Modified the clock rate selection to match the closest rate in
  PLL driver when setting rate.

v2: https://lore.kernel.org/all/20230316030514.137427-1-xingyu.wu@starfivetech.com/

Changes since v1:
- Changed PLL clock node to be child of syscon node in dts.
- Modifed the definitions and names of function in PLL clock driver.
- Added commit to update syscon and syscrg dt-bindings.

v1: https://lore.kernel.org/all/20230221141147.303642-1-xingyu.wu@starfivetech.com/

William Qiu (2):
  dt-bindings: soc: starfive: Add StarFive syscon module
  riscv: dts: starfive: jh7110: Add syscon nodes

Xingyu Wu (5):
  dt-bindings: clock: Add StarFive JH7110 PLL clock generator
  dt-bindings: clock: jh7110-syscrg: Add PLL clock inputs
  clk: starfive: Add StarFive JH7110 PLL clock driver
  clk: starfive: jh7110-sys: Add PLL clocks source from DTS
  riscv: dts: starfive: jh7110: Add PLL clocks source in SYSCRG node

 .../bindings/clock/starfive,jh7110-pll.yaml   |  46 ++
 .../clock/starfive,jh7110-syscrg.yaml         |  18 +-
 .../soc/starfive/starfive,jh7110-syscon.yaml  |  93 ++++
 MAINTAINERS                                   |  13 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  30 +-
 drivers/clk/starfive/Kconfig                  |   9 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-pll.c    | 507 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  66 ++-
 .../dt-bindings/clock/starfive,jh7110-crg.h   |   6 +
 10 files changed, 763 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c

-- 
2.25.1

