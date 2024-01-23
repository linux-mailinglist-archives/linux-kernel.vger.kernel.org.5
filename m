Return-Path: <linux-kernel+bounces-35898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0DB839864
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3712921B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5351292E8;
	Tue, 23 Jan 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OUKLTV+o"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAF1292C5;
	Tue, 23 Jan 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035632; cv=none; b=CHpw76+VUdrj7Lgh1o/NcqDvvDEBDNIV8SD6aJUd65MHTWrS37ZUBIrrl/dxnF0mbZDNlIyIaXVGtdWVGm75DxH14w3RYijdFTa3rvPY5vHyizPKci9rkQaY91enr96lQV5jdOPGPaum8hjiduBQSJIjPhc+MUAjrlBepL/KSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035632; c=relaxed/simple;
	bh=OBy0Gs0hGY7eoskCvIqEi7s0T8oE2LNmrnYjmoqoCL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nxOEI0KNPjHz4b8jTENvdgai+hhuTI3bHDdOvON7gkmPaTX4xJCxRA6s9sh2Nd0ooj+mNfPhBC0Q+EpTefXB56VnLkxtEo7X+xJ4Ty9SGuM+z3sqY/3H2XkbsCqmXr2ufoYh0scpzM+AHMmht5xg+bCqazme3klcOjZqW9Gvnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OUKLTV+o; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3289C0005;
	Tue, 23 Jan 2024 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706035621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZZTN+4WOEwC2zxeNXM5kkaE+QAyM6nWS3mfKqvd7ec4=;
	b=OUKLTV+ot9z9SHvcDA2SRrM5cXYUz7L7O8f2Zx3fdY9/FySIQkIJ/pEWaa5W+TfbKdVxvj
	VPaHVcKp7oJeHVA/eLA1+YMUBOyS9v93HV+ug1pSk6DeUce/hWcOnsMQ/Cd0toOVyavWjn
	tujVqa13gb6OTtIP/uJgUKvvqFn1ATBCEvjYK0PGZv1pXuBCdyIfJswIg5PmJ+Q6fG3FU5
	S/j1EUSzGKggMDjkWay92dPtBIvpOkXzB1eZ0f0tm8Rr/ZF3cwEj5ty8DuxYd10cqm/NBI
	vRbLIytuMJwIjdVf3LDH9b87qVaJ7nJdsmUGya+ze4+0a5RGzbXQDNS7X+Weyg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v3 00/17] Add support for Mobileye EyeQ5 system controller
Date: Tue, 23 Jan 2024 19:46:45 +0100
Message-Id: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJYJsGUC/3WOyw6CMBBFf4V0bU2n5VFc+R/GBS1TaQRqCiESw
 r9bcIEYXcziTuacuRPp0FvsyCmaiMfBdta1IYhDRHRVtDektgyZcMYFhKGNqkeq6zuVmcZE8xg
 MkyScPzwa+1xVl2vIle1658fVPMCyfUtAsE0yAGVUpsoA5FkJAs/Kub627VG7ZrH+QZRAlpSpy
 hUWPxEO8guJ49A3BiYNS3fIUnbgW0HOsw+UB7QIv1QqtJDM7NF5nl+mAg1TQwEAAA==
To: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

The goal of this series is to add clk, reset and pinctrl support for the
Mobileye EyeQ5 platform [0]. Control of those is grouped inside a
system controller block called "OLB".

About clocks, we replaced the 10 fixed clocks from the initial platform
support series [0] by 10 read-only fixed-factor PLLs provided by our
clock driver. We also provide one table-based divider clock for OSPI.
Two PLLs (for GIC timer & UARTs) are required at of_clk_init() so those
are registered first, the rest comes at platform device probe.

Resets are split in three domains, all dealt with by the same device.
They have some behavior differences:
 - We busy-wait on the first two for hardware LBIST reasons (logic
   built-in self-test).
 - Domains 0 & 2 work in a bit-per-reset fashion while domain 1 works in
   a register-per-reset fashion.

Pin control is about controlling bias, drive strength and muxing. The
latter allows two functions per pin; the first function is always GPIO
while the second one is pin-dependent. There exists two banks, each
handled in a separate driver instance. Each pin maps to one pin group.
That makes pin & group indexes the same, simplifying logic.

This series inherits from the clk V2 [1], reset V1 [2] and pinctrl V1
[3]. Those were unified to simplify handling of dt-bindings. It is
based on the series "[PATCH v6 00/15] Add support for the Mobileye
EyeQ5 SoC" [0] rebased onto v6.8-rc1.

Here is the patch list, split by subsystems:

 - clk:
    - [PATCH V3 01/17] clk: fixed-factor: add optional accuracy support
    - [PATCH V3 02/17] clk: fixed-factor: add fwname-based constructor functions
    - [PATCH V3 05/17] dt-bindings: clock: mobileye,eyeq5-clk: add bindings
    - [PATCH V3 08/17] clk: eyeq5: add platform driver

 - pinctrl:
    - [PATCH V3 03/17] dt-bindings: pinctrl: allow pin controller device without unit address
    - [PATCH V3 07/17] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
    - [PATCH V3 10/17] pinctrl: eyeq5: add platform driver

 - MIPS: (note: dependent on the [0] series)
    - [PATCH V3 04/17] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
    - [PATCH V3 11/17] MIPS: mobileye: eyeq5: rename olb@e00000 to system-controller@e00000
    - [PATCH V3 12/17] MIPS: mobileye: eyeq5: remove reg-io-width property from OLB syscon
    - [PATCH V3 13/17] MIPS: mobileye: eyeq5: use OLB clocks controller
    - [PATCH V3 14/17] MIPS: mobileye: eyeq5: add OLB reset controller node
    - [PATCH V3 15/17] MIPS: mobileye: eyeq5: add reset properties to uarts
    - [PATCH V3 16/17] MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux function nodes
    - [PATCH V3 17/17] MIPS: mobileye: eyeq5: add pinctrl properties to UART nodes

 - reset:
    - [PATCH V3 06/17] dt-bindings: reset: mobileye,eyeq5-reset: add bindings
    - [PATCH V3 09/17] reset: eyeq5: add platform driver

Thanks to Krzysztof, Rob & Stephen for the previous feedback!

Have a nice day,
Théo Lebrun

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/lkml/20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com/
[2]: https://lore.kernel.org/lkml/20231218-mbly-reset-v1-0-b4688b916213@bootlin.com/
[3]: https://lore.kernel.org/lkml/20231218-mbly-pinctrl-v1-0-2f7d366c2051@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v3:
- Unified the three series into one.
- clk: split driver into two for clocks registered at of_clk_init() and
  clocks registered at platform device probe.
- reset/bindings: drop reset dt-bindings header & add comment in driver
  to document known valid resets in each domain.
- pinctrl/bindings: fix pinctrl.yaml to allow non unit addresses for pin
  controller devices.
- all/bindings: remove possibility to use `mobileye,olb` phandle to get
  syscon. All three drivers use their parent node as syscon/regmap.
- MIPS/bindings: fix bindings for OLB. Have single example in parent,
  removing all examples in child.
- all: drop the "probed" logs.
- Link to v2: https://lore.kernel.org/r/20231227-mbly-clk-v2-0-a05db63c380f@bootlin.com

Changes in v2:
- Drop [PATCH 1/5] that was taken by Stephen for clk-next.
- Add accuracy support to fixed-factor that is enabled with a flag.
  Register prototypes were added to exploit this feature.
- Add fw_name support to fixed-factor. This allows pointing to parent
  clocks using the value in `clock-names` in the DT. Register
  prototypes were added for that.
- Bindings were modified to be less dumb: a binding was added for OLB
  and the clock-controller is a child property of it. Removed the
  possibility of pointing to OLB using a phandle. $nodename is the
  generic `clock-controller` and not custom `clocks`. Fix dt-bindings
  examples.
- Fix commit message for the driver patch. Add details, remove useless
  fluff.
- Squash both driver commits together.
- Declare a platform_driver instead of using CLK_OF_DECLARE_DRIVER. This
  also means using `dev_*` for logging, removing `pr_fmt`. We add a
  pointer to device in the private structure.
- Use fixed-factor instead of fixed-rate for PLLs. We don't grab a
  reference to the parent clk, instead using newly added fixed-factor
  register prototypes and fwname.
- NULL is not an error when registering PLLs anymore.
- Now checking the return value of of_clk_add_hw_provider for errors.
- Fix includes.
- Remove defensive conditional at start of eq5c_pll_parse_registers.
- Rename clk_hw_to_ospi_priv to clk_to_priv to avoid confusion: it is
  not part of the clk_hw_* family of symbols.
- Fix negative returns in eq5c_ospi_div_set_rate. It was a typo
  highlighted by Stephen Boyd.
- Declare eq5c_ospi_div_ops as static.
- In devicetree, move the OLB node prior to the UARTs, as platform
  device probe scheduling is dependent on devicetree ordering. This is
  required to declare the driver as a platform driver, else it
  CLK_OF_DECLARE_DRIVER is required.
- In device, create a core0-timer-clk fixed clock to feed to the GIC
  timer. It requires a clock earlier than platform bus type init.
- Link to v1: https://lore.kernel.org/r/20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com

---
Théo Lebrun (17):
      clk: fixed-factor: add optional accuracy support
      clk: fixed-factor: add fwname-based constructor functions
      dt-bindings: pinctrl: allow pin controller device without unit address
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      dt-bindings: reset: mobileye,eyeq5-reset: add bindings
      dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
      clk: eyeq5: add platform driver
      reset: eyeq5: add platform driver
      pinctrl: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: rename olb@e00000 to system-controller@e00000
      MIPS: mobileye: eyeq5: remove reg-io-width property from OLB syscon
      MIPS: mobileye: eyeq5: use OLB clocks controller
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add reset properties to uarts
      MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux function nodes
      MIPS: mobileye: eyeq5: add pinctrl properties to UART nodes

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  41 ++
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   |  77 +++
 .../devicetree/bindings/pinctrl/pinctrl.yaml       |  18 +-
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  32 ++
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  77 +++
 MAINTAINERS                                        |   8 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 128 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  37 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 414 ++++++++++++++
 drivers/clk/clk-fixed-factor.c                     | 103 +++-
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 595 +++++++++++++++++++++
 drivers/reset/Kconfig                              |  12 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq5.c                        | 383 +++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  22 +
 include/linux/clk-provider.h                       |  26 +-
 21 files changed, 1995 insertions(+), 61 deletions(-)
---
base-commit: 84f23245916391a55be31e37e48cea4da085b100
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


