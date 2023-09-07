Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE79767B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbjIGQKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjIGQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:10:28 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9A07687;
        Thu,  7 Sep 2023 09:05:34 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1782924E287;
        Thu,  7 Sep 2023 13:43:04 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Sep
 2023 13:43:04 +0800
Received: from localhost.localdomain (113.72.144.73) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 7 Sep
 2023 13:43:03 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v5 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Date:   Thu, 7 Sep 2023 13:37:39 +0800
Message-ID: <20230907053742.250444-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.73]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch serises are to add timer driver for the StarFive JH7110
RISC-V SoC. The first patch adds documentation to describe device
tree bindings. The subsequent patch adds timer driver and support
JH7110 SoC. The last patch adds device node about timer in JH7110
dts.

This timer has four free-running 32 bit counters and runs in 24MHz
clock on StarFive JH7110 SoC. And each channel(counter) triggers
an interrupt when timeout. They support one-shot mode and 
continuous-run mode.

Changes since v4:
- Rebased on 6.5.
- Dropped the useless enum and used value directly when writing
  registers.
- Modified the description in Kconfig.
- Add the reviewed tag in patch 3.

v4: https://lore.kernel.org/all/20230814101603.166951-1-xingyu.wu@starfivetech.com/

Changes since v3: 
- Rebased on 6.5-rc6
- Dropped the useless enum names like 'JH7110_TIMER_CH_0'.
- Dropped the platform data about JH7110 and used the register offsets
  directly.
- Drroped the useless functions of clk_disable_unprepare().

v3: https://lore.kernel.org/all/20230627055313.252519-1-xingyu.wu@starfivetech.com/

Changes since v2: 
- Rebased on 6.4-rc7.
- Merged the header file into the c file.
- Renamed the functions from 'starfive_' to 'jh7110_'
- Used function 'clocksource_register_hz' instead of
  'clocksource_mmio_init'.

v2: https://lore.kernel.org/all/20230320135433.144832-1-xingyu.wu@starfivetech.com/

Changes since v1: 
- Added description about timer and modified properties' description
  in dt-bindings.
- Dropped the 'interrupt-names' and 'clock-frequency' in dt-bindings.
- Renamed the functions and added 'starfive_'
- Modified that the driver probe by platform bus.

v1: https://lore.kernel.org/all/20221223094801.181315-1-xingyu.wu@starfivetech.com/

Xingyu Wu (3):
  dt-bindings: timer: Add timer for StarFive JH7110 SoC
  clocksource: Add JH7110 timer driver
  riscv: dts: jh7110: starfive: Add timer node

 .../bindings/timer/starfive,jh7110-timer.yaml |  96 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-jh7110.c            | 400 ++++++++++++++++++
 6 files changed, 535 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
 create mode 100644 drivers/clocksource/timer-jh7110.c

-- 
2.25.1

