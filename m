Return-Path: <linux-kernel+bounces-5417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C56818A83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06F1B217CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4800B1C2AE;
	Tue, 19 Dec 2023 14:54:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0A1C6B5;
	Tue, 19 Dec 2023 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 950F78132;
	Tue, 19 Dec 2023 22:54:03 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 22:54:03 +0800
Received: from localhost.localdomain (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 22:54:02 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker Chen
	<walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v8 0/3] Add timer driver for StarFive JH7110 RISC-V SoC
Date: Tue, 19 Dec 2023 22:53:59 +0800
Message-ID: <20231219145402.7879-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

This patch serises are to add timer driver for the StarFive JH7110
RISC-V SoC. The first patch adds documentation to describe device
tree bindings. The subsequent patch adds timer driver and support
JH7110 SoC. The last patch adds device node about timer in JH7110
dts.

This timer has four free-running 32 bit counters and runs in 24MHz
clock on StarFive JH7110 SoC. And each channel(counter) triggers
an interrupt when timeout. They support one-shot mode and=20
continuous-run mode.

This timer is used as global timer and register clockevent for each
CPU core after riscv-timer registration on the StarFive JH7110 SoC.

Changes since v7:
- Rebased on 6.7-rc6.
- Modified the Kconfig file and added selection in SOC_STARFIVE.
- Used the timer as a global timer and registered as clockevent
  for each CPU core.
- Dropped the timeout function in the interrupt handler callback.
- Changed the way in the functions of jh7110_timer_tick_resume() and
  jh7110_timer_resume().
- Dropped the registration of clocksource in the probe.

v7: https://lore.kernel.org/all/20231019053501.46899-1-xingyu.wu@starfive=
tech.com/

Changes since v6:=20
- Rebased on 6.6-rc6.
- Used sizeof() instead of the numbers of characters about names.
- Added devm_add_action_or_reset() to release the resets and=20
  clocksources in the case of remove or error in the probe.
- Added flags to check each clocksource is suceessfully registered and=20
  used in the release function.
- Dropped the variable of irq in the jh7110_clkevt struct.
- Dropped the wrappers and used enum definitions and writel() calls
  directly.

v6: https://lore.kernel.org/all/20231012081015.33121-1-xingyu.wu@starfive=
tech.com/

Changes since v5:=20
- Rebased on 6.6-rc5.
- Changed the number about characters of name.
- Made the clkevt->periodic to a local variable.
- Dropped the variables of device and base.
- Used clkevt->evt.irq directly and dropped the extra copy of irq.

V5: https://lore.kernel.org/all/20230907053742.250444-1-xingyu.wu@starfiv=
etech.com/

Changes since v4:=20
- Rebased on 6.5.
- Dropped the useless enum and used value directly when writing
  registers.
- Modified the description in Kconfig.
- Add the reviewed tag in patch 3.

v4: https://lore.kernel.org/all/20230814101603.166951-1-xingyu.wu@starfiv=
etech.com/

Changes since v3:=20
- Rebased on 6.5-rc6
- Dropped the useless enum names like 'JH7110_TIMER_CH_0'.
- Dropped the platform data about JH7110 and used the register offsets
  directly.
- Drroped the useless functions of clk_disable_unprepare().

v3: https://lore.kernel.org/all/20230627055313.252519-1-xingyu.wu@starfiv=
etech.com/

Changes since v2:=20
- Rebased on 6.4-rc7.
- Merged the header file into the c file.
- Renamed the functions from 'starfive_' to 'jh7110_'
- Used function 'clocksource_register_hz' instead of
  'clocksource_mmio_init'.

v2: https://lore.kernel.org/all/20230320135433.144832-1-xingyu.wu@starfiv=
etech.com/

Changes since v1:
- Added description about timer and modified properties' description
  in dt-bindings.
- Dropped the 'interrupt-names' and 'clock-frequency' in dt-bindings.
- Renamed the functions and added 'starfive_'
- Modified that the driver probe by platform bus.

v1: https://lore.kernel.org/all/20221223094801.181315-1-xingyu.wu@starfiv=
etech.com/

Xingyu Wu (3):
  dt-bindings: timer: Add timer for StarFive JH7110 SoC
  clocksource: Add JH7110 timer driver
  riscv: dts: jh7110: starfive: Add timer node

 .../bindings/timer/starfive,jh7110-timer.yaml |  96 +++++
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig.socs                       |   1 +
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  20 +
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-jh7110.c            | 360 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 8 files changed, 495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh71=
10-timer.yaml
 create mode 100644 drivers/clocksource/timer-jh7110.c

--=20
2.25.1


