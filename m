Return-Path: <linux-kernel+bounces-61729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692885161B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5500DB24970
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D83D972;
	Mon, 12 Feb 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RVKrwa2k"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A83D54C;
	Mon, 12 Feb 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745479; cv=none; b=UfI02ibDlEZ1qOonwhLVN5z1Uyumjp+SAbgY4QHlVU8h0zfmcBxu0MR2rAJCia4cdT4OLpoQPKqCfy1EZVWnlmA5ChCfUOlWJcIqSxhArDKTR27fcbsENEUko/O0pDuutip8Bh13YNjDucdO38KCwk8kTONQhYr82NcAAHDimGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745479; c=relaxed/simple;
	bh=HzBkXRWHw2jlv/7jyejhECz3JcmKua6KfKfsp9G1iSY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WARr2Ji9cITZqxzrcT3pimvnCA8je9msuMAkzeDKJYpF+2zt9cjOxcTW48f7hrUvj0R2wX0+ywQBJpTMIqUNOBR6EYJePzSk7i9qdTZR43qxZdkrpf2R8c4MtnhiN9i1tXrZgVCvHASpzWG+h7IBk7qbkWMuFJxYcwWpizAgrao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RVKrwa2k; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21EB0FF807;
	Mon, 12 Feb 2024 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707745474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3LR/iRsthMQwI5kZqt1MBMvWucAmDB7IZnKA4trslL0=;
	b=RVKrwa2k1fbaLYzDPN5qX0wDz93nmxN99JLufGyUEDMC3A1Rd1NoE3jTz5FUkgRbh13f2b
	1Pp1OxlB4yatVTBg8YGj0iJB/iWc7xULYUou2pFfzUkFN9n3LX314U7DYc9R06l54gN+lM
	8zZIKI/CxFLr8qEMYgkn5BLc94E+ss/tEQbXztlPpNGnRqDBUbSxeLoVR6zRWUCUeGr5qM
	OUW5tQ4PBmoyWl6Cc+oTqxnLBB9VdbCZj8qJHCLYvR1SF9PHqSM+3ugZ0s2BTWYUXGvVkg
	zVGsetUT2hFXD0KFOLEaQ3hP/0pp/KPma3WkEHJReUwbqGO6LxqDFP8kS/fy4w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v6 00/13] Add support for Mobileye EyeQ5 system controller
Date: Mon, 12 Feb 2024 14:44:31 +0100
Message-Id: <20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMAgymUC/3XQzU7DMAwH8FeZcibIdj6a7MR7oB2a1GERW4vaq
 WKa+u6kQ6gdhUMOjvL7x/ZNDNxnHsR+dxM9j3nIXVsK+7QT8Vi3byxzU2pBQArLkedwusp4epe
 uimwiaUzgRHn+0XPKn/eo10Opj3m4dP31njzifPsdggqWkBElSGdDQvRVg4pfQtddTrl9jt15T
 v2HBMVgGht84PpPQuh+Ea1LvxrBJbAPZG52pKVBompFqdC6/BWsispB2lL1QzXgekGjKlR5CoA
 QHDncUr2iCldUzzPGBsAgNLaGLTULJfAragpN4DWzYY/ucT2HaZq+ACoxkP/0AQAA
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Herring <robh@kernel.org>
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
while the second one is pin-dependent. There exists two banks, both
handled by a single driver instance. Each pin maps to one pin group.
That makes pin & group indexes the same, simplifying logic.

The patch adding the system-controller dt-bindings ("dt-bindings: soc:
mobileye: add EyeQ5 OLB system controller") is dependent on the three
controllers dt-bindings:
 - dt-bindings: clock: mobileye,eyeq5-clk: add bindings
 - dt-bindings: reset: mobileye,eyeq5-reset: add bindings
 - dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings

The parent is v6.8-rc4 with the "[PATCH v7 00/14] Add support for the
Mobileye EyeQ5 SoC" series [0] rebased on top.

Here is the patch list, split by subsystems:

- clk:
   [PATCH v5 01/13] clk: fixed-factor: add optional accuracy support
   [PATCH v5 02/13] clk: fixed-factor: add fwname-based constructor functions
   [PATCH v5 03/13] dt-bindings: clock: mobileye,eyeq5-clk: add bindings
   [PATCH v5 07/13] clk: eyeq5: add platform driver, and init routine at of_clk_init()
- pinctrl:
   [PATCH v5 05/13] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
   [PATCH v5 09/13] pinctrl: eyeq5: add platform driver
- reset:
   [PATCH v5 04/13] dt-bindings: reset: mobileye,eyeq5-reset: add bindings
   [PATCH v5 08/13] reset: eyeq5: add platform driver
- MIPS: (note: dependent on the [0] series)
   [PATCH v5 06/13] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
   [PATCH v5 10/13] MIPS: mobileye: eyeq5: add OLB syscon node
   [PATCH v5 11/13] MIPS: mobileye: eyeq5: use OLB clocks controller node
   [PATCH v5 12/13] MIPS: mobileye: eyeq5: add OLB reset controller node
   [PATCH v5 13/13] MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

Thanks all for the previous feedback!

Have a nice day,
Théo Lebrun

[0]: https://lore.kernel.org/lkml/20240205153503.574468-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v6:
- bindings/clk: remove minItems in reg.
- bindings/reset: remove minItems in reg.
- bindings/syscon: unify quotes (use single quotes everywhere).
- bindings: apply three Reviewed-By tags from Krzysztof.
- Rebased onto v6.8-rc5. No related changes. Tested on EyeQ5 hardware.
- Link to v5: https://lore.kernel.org/r/20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com

Changes in v5:
- pinctrl: fix pin/offset distinction, add eq5p_pin_to_offset() helper,
  rename eq5p_pin_offset_to_bank() to eq5p_pin_to_bank(), rename
  eq5p_readl_bit() to eq5p_test_bit(), remove old <linux/mfd/syscon.h>
  include, add defensive check in eq5p_test_bit().
- dt-bindings/MIPS: OLB example (dt-bindings) and devicetree: fix
  ordering of nodes and properties, fix register casing.
- dt-bindings: add pin group node example to OLB dt-bindings.
- MIPS: squashed "MIPS: mobileye: eyeq5: add reset properties to UARTs"
  into "MIPS: mobileye: eyeq5: add OLB reset controller node".
- MIPS: squashed "MIPS: mobileye: eyeq5: add pinctrl properties to UART
  nodes" into "MIPS: mobileye: eyeq5: add pinctrl node & pinmux
  function nodes".
- MIPS: rebased onto V7 of [0], meaning we now introduce the OLB syscon
  node in DT in this series rather than modifying it.
- Apply Reviewed-by from Rob onto "dt-bindings: pinctrl:
  mobileye,eyeq5-pinctrl: add bindings".
- dt-bindings: Drop "dt-bindings: pinctrl: allow pin controller device
  without unit address".
- dt-bindings: I did NOT apply Krzysztof's Reviewed-By trailers from v3
  as I am not sure he acked the changes made in V4.
- Link to v4: https://lore.kernel.org/r/20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com

Changes in v4:
- Have the three drivers access MMIO directly rather than through the
  syscon & regmap.
- pinctrl: Make the pin controller handle both banks using a single
  instance.
- pinctrl/dt-bindings: Add if/else for each function, to strictly define
  possible functions.
- clk: Changing to direct MMIO means we can use
  clk_hw_register_divider_table_parent_hw() for the OSPI table-based
  divider clock.
- Use builtin_platform_driver() for platform driver registering instead
  of manual initcalls.
- reset: follow Philipp & Krzysztof's feedback:
  - Use container_of() to get private struct.
  - Use '_withlock' suffix instead of the underscore prefix.
  - Use udelay() instead of the non-standard __udelay().
  - Remove useless checks.
  - Use mutex guards.
  - Remove the ->reset() implementation.
  - Use devres variants for kzalloc() and reset_controller_register().
- Other small changes following feedback from reviewers. dt-bindings
  whitespace for pinctrl.yaml, fix pinctrl driver dt-bindings
  description, improve clk driver commit header, etc.
- Link to v3: https://lore.kernel.org/r/20240123-mbly-clk-v3-0-392b010b8281@bootlin.com

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
Théo Lebrun (13):
      clk: fixed-factor: add optional accuracy support
      clk: fixed-factor: add fwname-based constructor functions
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      dt-bindings: reset: mobileye,eyeq5-reset: add bindings
      dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      clk: eyeq5: add platform driver, and init routine at of_clk_init()
      reset: eyeq5: add platform driver
      pinctrl: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: add OLB syscon node
      MIPS: mobileye: eyeq5: use OLB clocks controller node
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  51 ++
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  43 ++
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  94 ++++
 MAINTAINERS                                        |   8 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 125 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  42 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 289 ++++++++++
 drivers/clk/clk-fixed-factor.c                     | 103 +++-
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 581 +++++++++++++++++++++
 drivers/reset/Kconfig                              |  12 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq5.c                        | 342 ++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  22 +
 include/linux/clk-provider.h                       |  26 +-
 20 files changed, 2007 insertions(+), 56 deletions(-)
---
base-commit: fe17164b560a24c66be4a00ff8ecc14fca04aea7
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


