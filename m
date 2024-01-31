Return-Path: <linux-kernel+bounces-46787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DAF844438
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C7A1C26630
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC5812C536;
	Wed, 31 Jan 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e4fj9jwM"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB512BE8D;
	Wed, 31 Jan 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718437; cv=none; b=uUugR9DDnH5ef+ENrdm6M+b0d/DNAbhm7oAIbDJWyZpHKR/Zx62D2pB0WA4olEGawWbqN99yIolEe0LDn1RlcuNotmu2l+aryon1UiNlEzSCYtu4WkkD+cHNyUmJFnJjOaOkxEzwkYmxFhVikKM7OyRns/OdZdx6cSXGh6GAH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718437; c=relaxed/simple;
	bh=k5WJ0M19WQMRKKJde8+1raSruC9nJF44AkrsG2UFIQw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ssHJKGy9vJauk7PiJs3gxD9fZwm32CJf0WwMq7X5ZaJUuiiy1fY/mp4ggr58340OFXKKIbqwvumtpfaIPmcD+DVjDy32+sUgGriwW4VZaQTDzZAK5IoobR+WNR7tuiDaC0lesGEQ8/YLJraUjVZ3GIYL4tXqDd9n/xFiJ4i8Xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e4fj9jwM; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3370340007;
	Wed, 31 Jan 2024 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706718431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dghIVrp7cReMYGwybLCN5JkUqpZvLrJ8sgReFNKToLY=;
	b=e4fj9jwM4tgS3upnmM8L+1In85FdIMM7KuO3A9TO5u/+PG+1p2jMv1U4MF+PcofvnrQ2nf
	Y1cnOqYOzs72M9JvC3VshgJzRfg8xhaczlLkCEjlRJSJaOC+C6/zQJ7X8Tj/DOT1S5wHk+
	vY80rVjsN+hya30oLIyOcvZFSw7SdYCipqzzNpsJQ6QYdbTtnRBl2NUMtlXY817FOm8NLi
	TLS2rnX93UbWrnTyCO+poVRZTioDIYJSz1KJy6KzjXVKOWp6GirV8QmlvvQxj3HFFjoMri
	eRDM0NnnTCWCU4YXmQxL7Hc75x1dg4aeJ3czIGMvrhyoxMsKwVF8gxdwDG7RcQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v4 00/18] Add support for Mobileye EyeQ5 system controller
Date: Wed, 31 Jan 2024 17:26:13 +0100
Message-Id: <20240131-mbly-clk-v4-0-bcd00510d6a0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKV0umUC/3WQy27CMBBFfwV5XaN5mMRh1f+ouogdu1gNcZUgq
 wjl3zsBIR5tF15ca86ZqzmpKYwpTGq7OqkxlDSlPEgwLyvld+3wEXTqJCsCYpSn964/at9/alv
 7sPFkMIJVMv41hpi+z6q3d8m7NB3yeDybCy6/Fwky3CQFNWhbuYjY1B1yeHU5H/o0rH3eL9Z/E
 McBNl3lGhfaPxFC+4QYI30Ngo1QPSBL2UK3gkT1HUqCtrLLVezZQvyN8hU1gPcHKiwoN+QAwVm
 y+IjO8/wDTWc5tn4BAAA=
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

The patch adding the system-controller dt-bindings ("dt-bindings: soc:
mobileye: add EyeQ5 OLB system controller") is dependent on the three
controllers dt-bindings:
 - dt-bindings: clock: mobileye,eyeq5-clk: add bindings
 - dt-bindings: reset: mobileye,eyeq5-reset: add bindings
 - dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings

The parent is v6.8-rc2 with the "[PATCH v6 00/15] Add support for the
Mobileye EyeQ5 SoC" series [0] rebased on top.

Here is the patch list, split by subsystems:

 - clk:
   [PATCH V4 01/18] clk: fixed-factor: add optional accuracy support
   [PATCH V4 02/18] clk: fixed-factor: add fwname-based constructor
                    functions
   [PATCH V4 04/18] dt-bindings: clock: mobileye,eyeq5-clk: add bindings
   [PATCH V4 08/18] clk: eyeq5: add platform driver, and init routine
                    at of_clk_init()

 - pinctrl:
   [PATCH V4 03/18] dt-bindings: pinctrl: allow pin controller device
                    without unit address
   [PATCH V4 06/18] dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add
                    bindings
   [PATCH V4 10/18] pinctrl: eyeq5: add platform driver

 - reset:
   [PATCH V4 05/18] dt-bindings: reset: mobileye,eyeq5-reset: add
                    bindings
   [PATCH V4 09/18] reset: eyeq5: add platform driver

 - MIPS: (note: dependent on the [0] series)
   [PATCH V4 07/18] dt-bindings: soc: mobileye: add EyeQ5 OLB system
                    controller
   [PATCH V4 11/18] MIPS: mobileye: eyeq5: rename olb@e00000 to
                    system-controller@e00000
   [PATCH V4 12/18] MIPS: mobileye: eyeq5: remove reg-io-width property
                    from OLB syscon
   [PATCH V4 13/18] MIPS: mobileye: eyeq5: add memory translation
                    inside OLB syscon
   [PATCH V4 14/18] MIPS: mobileye: eyeq5: use OLB clocks controller
   [PATCH V4 15/18] MIPS: mobileye: eyeq5: add OLB reset controller node
   [PATCH V4 16/18] MIPS: mobileye: eyeq5: add reset properties to UARTs
   [PATCH V4 17/18] MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux
                    function nodes
   [PATCH V4 18/18] MIPS: mobileye: eyeq5: add pinctrl properties to
                    UART nodes

Thanks to Andrew, Krzysztof, Philipp, Rob, Sergei & Stephen for the
previous feedback!

Have a nice day,
Théo Lebrun

[0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
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
Théo Lebrun (18):
      clk: fixed-factor: add optional accuracy support
      clk: fixed-factor: add fwname-based constructor functions
      dt-bindings: pinctrl: allow pin controller device without unit address
      dt-bindings: clock: mobileye,eyeq5-clk: add bindings
      dt-bindings: reset: mobileye,eyeq5-reset: add bindings
      dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      clk: eyeq5: add platform driver, and init routine at of_clk_init()
      reset: eyeq5: add platform driver
      pinctrl: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: rename olb@e00000 to system-controller@e00000
      MIPS: mobileye: eyeq5: remove reg-io-width property from OLB syscon
      MIPS: mobileye: eyeq5: add memory translation inside OLB syscon
      MIPS: mobileye: eyeq5: use OLB clocks controller
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add reset properties to UARTs
      MIPS: mobileye: eyeq5: add pinctrl nodes & pinmux function nodes
      MIPS: mobileye: eyeq5: add pinctrl properties to UART nodes

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  52 ++
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   | 242 +++++++++
 .../devicetree/bindings/pinctrl/pinctrl.yaml       |  18 +-
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  44 ++
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  89 ++++
 MAINTAINERS                                        |   8 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 125 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  39 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 289 +++++++++++
 drivers/clk/clk-fixed-factor.c                     | 103 +++-
 drivers/pinctrl/Kconfig                            |  15 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 567 +++++++++++++++++++++
 drivers/reset/Kconfig                              |  12 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq5.c                        | 342 +++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  22 +
 include/linux/clk-provider.h                       |  26 +-
 21 files changed, 2000 insertions(+), 61 deletions(-)
---
base-commit: b93830a88d7a3a18a92ff7a1a9272934ca1bade1
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


