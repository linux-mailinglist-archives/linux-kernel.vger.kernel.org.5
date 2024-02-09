Return-Path: <linux-kernel+bounces-59462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E77C84F76A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938B9B27E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43926EB5C;
	Fri,  9 Feb 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JGWfCzfE"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A36BB2E;
	Fri,  9 Feb 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489114; cv=none; b=r8JQVYtPJLKO6LhGMDLUKdnsA9ONPWXHWuBmM3w8S4Wp95LTJGhnYKXJE7ZkhUgBvITwwqQmksn2GKOO3bON6m82UE2dvaBoheEGyKvj3smgpmVP/X6z321w8quS3LD85i264DlPEUOs6NX05WGWiFln2lL41gCZ2quwb/fc9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489114; c=relaxed/simple;
	bh=ao/AD/6GwvaAu3QiBYLYkv+MfQBmmm3Bfect6QuJc5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tusmVXHu7bhVxgZ8D16PRQT68E3LdnSyYyAZEWAjfLdR8hrma70zEqHXFqUOFsP4y3js7KGXDN7e3Xkmfyv++h2SM00/dgWxMW2eM/XPyxJzVl2tQGFHSFGx2L3r6S/rkCnaHt8aQMUcXI3717pBHcs3nvhClcw0youOv1tPHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JGWfCzfE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD38324000C;
	Fri,  9 Feb 2024 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707489103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kCufz0x48a5QasACZUhgnaHVopb6QsPF5Jq3cbjpfyU=;
	b=JGWfCzfEaMdR2zfg2npmYONPToFlvY4ingSPkiS4P9nGgBI/3RGYTqw1qMrbxiOHzgLcc2
	/AarJDbG1hzpxo9N5QtCjk0OewAMmfEqZb9IjuYzDenO8YwkS8UHQ9SlL3+yuaV1srIIWy
	QAbbP3dwrlp3/NQxxjdYXm879udsaUFMHeeBXoFSvLmvbJ6EdLqqDnlSOiXPjIrbcozdGQ
	ss1bYDvOexvC0xtZ6B36kdCFXrwxmoqQ1WZufI1CUVfutaHxtsK1DKIjM+CgrOSmplTAHl
	N+H+5W8eCF/d1edH9kmD2sZYjKo9a4gzcO/6GeqHfcIBVpPiUuFV95S+0XOisQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v5 00/13] Add support for Mobileye EyeQ5 system controller
Date: Fri, 09 Feb 2024 15:31:36 +0100
Message-Id: <20240209-mbly-clk-v5-0-f094ee5e918a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEg3xmUC/3XQ3U7DIBgG4FtZOBbz/VBKPfI+jAflzxG7YtqFu
 Cy9d+mMWef0gIOP8Ly8cBZzmFKYxdPuLKZQ0pzyWIfmYSfcvh/fgky+zoKAGOuSBzucpBvepWl
 daBwpjGBEPf4xhZg+L1Evr3Xep/mYp9MlueC6+x2CDNeQghKk0TYidq1HDs825+OQxkeXD2vqP
 8RygMZr29nQ/0kIzS+iVO2rEEwEfUPWsoWuBYnaDaVK+3qX1ezYQLyn/EMV4PaDClfKHVlAsIY
 M3lO1oYwbqtY3Og/QIHjdwy1dluUL96iFcLkBAAA=
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

The parent is v6.8-rc3 with the "[PATCH v7 00/14] Add support for the
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

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  52 ++
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  44 ++
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
 20 files changed, 2009 insertions(+), 56 deletions(-)
---
base-commit: 5f3aed503cf2152eb19cc210d74fdd8a1ef7226f
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


