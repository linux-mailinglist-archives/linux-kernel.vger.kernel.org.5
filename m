Return-Path: <linux-kernel+bounces-11356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A284581E516
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D0B21C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200634B5C3;
	Tue, 26 Dec 2023 05:39:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C44B12C;
	Tue, 26 Dec 2023 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id D0D2F24E269;
	Tue, 26 Dec 2023 13:39:02 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 26 Dec
 2023 13:39:02 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Tue, 26 Dec 2023 13:38:56 +0800
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: <kernel@esmil.dk>, <conor@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<emil.renner.berthing@canonical.com>, <hal.feng@starfivetech.com>,
	<xingyu.wu@starfivetech.com>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [RFC 00/16] Basic clock and reset support for StarFive JH8100 RISC-V SoC
Date: Tue, 26 Dec 2023 13:38:32 +0800
Message-ID: <20231226053848.25089-1-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

This patch series enabled basic clock & reset support for StarFive
JH8100 SoC.

This patch series depends on the Initial device tree support for
StarFive JH8100 SoC patch series which can be found at [1].

As it is recommended to refrain from merging fundamental patches like
Device Tree, Clock & Reset, and PINCTRL tested on FPGA/Emulator, into the
RISC-V Mainline, this patch series has been renamed to "RFC" patches. Yet=
,
thanks to the reviewers who have reviewed the patches at [2]. The changes
are captured below.

StarFive JH8100 shares a similar clock and reset design with JH7110.
To facilitate the reuse of the file and its functionalities, files
containing the 'jh71x0' naming convention are renamed to use the
'common' wording. Internal functions that contain the 'jh71x0'
naming convention are renamed to use 'starfive.' This is accomplished
through patches 1, 2, 3, and 4.

Patch 5 adds documentation to describe System (SYSCRG) Clock & Reset
binding.
Patch 6 adds SYSCRG clock driver.

patch 7 adds documentation to describe North-West (NWCRG) Clock & Reset
binding.
Patch 8 adds NWCRG clock driver.

patch 9 adds documentation to describe North-East (NECRG) Clock & Reset
binding.
Patch 10 adds NECRG clock driver.

patch 11 adds documentation to describe South-West (SWCRG) Clock & Reset
binding.
Patch 12 adds SWCRG clock driver.

patch 13 adds documentation to describe Always-On (AON) Clock & Reset
binding.
Patch 14 adds AON clock driver.

Patch 15 adds support for the auxiliary reset driver.

Patch 16 adds clocks and reset nodes to the JH8100 device tree.

Changes since [2]:
- Renamed the patch series to "RFC" patches.
- Added the "Reviewed-by" tag from Emil for patches 1, 2 3 & 4.
- Removed clk_ prefixes.
- Used 4 spaces for example indentation in dt-binding documentation.
- Used the same license in dt-binding.
- Moved number of clocks from binding to source file.
- Moved number of resets from binding ro source file.
- Removed the subfolder for new clock files.
- Followed the JH71xx files naming convention.
- Followed the JH71xx clock naming conventions.
- Followed the JH71xx resets naming conventions.
- Moved the PLL fixed clock from the source file to Device Tree.
- Dropped clk.dtsi and moved the clocks node to SoC.dtsi.

[1] https://lore.kernel.org/lkml/20231201121410.95298-1-jeeheng.sia@starf=
ivetech.com/
[2] https://lore.kernel.org/lkml/20231206115000.295825-1-jeeheng.sia@star=
fivetech.com/

Sia Jee Heng (16):
  reset: starfive: Rename file name "jh71x0" to "common"
  reset: starfive: Convert the word "jh71x0" to "starfive"
  clk: starfive: Rename file name "jh71x0" to "common"
  clk: starfive: Convert the word "jh71x0" to "starfive"
  dt-bindings: clock: Add StarFive JH8100 System clock and reset
    generator
  clk: starfive: Add JH8100 System clock generator driver
  dt-bindings: clock: Add StarFive JH8100 North-West clock and reset
    generator
  clk: starfive: Add JH8100 North-West clock generator driver
  dt-bindings: clock: Add StarFive JH8100 North-East clock and reset
    generator
  clk: starfive: Add JH8100 North-East clock generator driver
  dt-bindings: clock: Add StarFive JH8100 South-West clock and reset
    generator
  clk: starfive: Add JH8100 South-West clock generator driver
  dt-bindings: clock: Add StarFive JH8100 Always-On clock and reset
    generator
  clk: starfive: Add JH8100 Always-On clock generator driver
  reset: starfive: Add StarFive JH8100 reset driver
  riscv: dts: starfive: jh8100: Add clocks and resets nodes

 .../clock/starfive,jh8100-aoncrg.yaml         |  74 +++
 .../bindings/clock/starfive,jh8100-necrg.yaml | 153 +++++
 .../bindings/clock/starfive,jh8100-nwcrg.yaml | 119 ++++
 .../bindings/clock/starfive,jh8100-swcrg.yaml |  64 +++
 .../clock/starfive,jh8100-syscrg.yaml         |  77 +++
 MAINTAINERS                                   |  15 +
 arch/riscv/boot/dts/starfive/jh8100.dtsi      | 313 +++++++++++
 drivers/clk/starfive/Kconfig                  |  45 +-
 drivers/clk/starfive/Makefile                 |   8 +-
 drivers/clk/starfive/clk-starfive-common.c    | 327 +++++++++++
 drivers/clk/starfive/clk-starfive-common.h    | 130 +++++
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 127 ++---
 drivers/clk/starfive/clk-starfive-jh7100.c    | 503 ++++++++---------
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  62 +--
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  72 +--
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  94 ++--
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 523 +++++++++---------
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  74 +--
 drivers/clk/starfive/clk-starfive-jh7110.h    |   4 +-
 drivers/clk/starfive/clk-starfive-jh71x0.c    | 327 -----------
 drivers/clk/starfive/clk-starfive-jh71x0.h    | 123 ----
 .../clk/starfive/clk-starfive-jh8100-aon.c    | 256 +++++++++
 drivers/clk/starfive/clk-starfive-jh8100-ne.c | 499 +++++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100-nw.c | 237 ++++++++
 drivers/clk/starfive/clk-starfive-jh8100-sw.c | 134 +++++
 .../clk/starfive/clk-starfive-jh8100-sys.c    | 415 ++++++++++++++
 drivers/clk/starfive/clk-starfive-jh8100.h    |  11 +
 drivers/reset/starfive/Kconfig                |  14 +-
 drivers/reset/starfive/Makefile               |   4 +-
 ...rfive-jh71x0.c =3D> reset-starfive-common.c} |  68 +--
 .../reset/starfive/reset-starfive-common.h    |  14 +
 .../reset/starfive/reset-starfive-jh7100.c    |   4 +-
 .../reset/starfive/reset-starfive-jh7110.c    |   8 +-
 .../reset/starfive/reset-starfive-jh71x0.h    |  14 -
 .../reset/starfive/reset-starfive-jh8100.c    | 108 ++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 421 ++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   | 118 ++++
 ...rfive-jh71x0.h =3D> reset-starfive-common.h} |  10 +-
 38 files changed, 4327 insertions(+), 1242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-aoncrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-necrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-nwcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-swcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh81=
00-syscrg.yaml
 create mode 100644 drivers/clk/starfive/clk-starfive-common.c
 create mode 100644 drivers/clk/starfive/clk-starfive-common.h
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.c
 delete mode 100644 drivers/clk/starfive/clk-starfive-jh71x0.h
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-aon.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-ne.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-nw.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sw.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100-sys.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh8100.h
 rename drivers/reset/starfive/{reset-starfive-jh71x0.c =3D> reset-starfi=
ve-common.c} (55%)
 create mode 100644 drivers/reset/starfive/reset-starfive-common.h
 delete mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h
 create mode 100644 drivers/reset/starfive/reset-starfive-jh8100.c
 create mode 100644 include/dt-bindings/clock/starfive,jh8100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh8100-crg.h
 rename include/soc/starfive/{reset-starfive-jh71x0.h =3D> reset-starfive=
-common.h} (50%)

--=20
2.34.1


