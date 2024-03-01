Return-Path: <linux-kernel+bounces-88680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A444B86E537
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB3A1F23B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BD71745;
	Fri,  1 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ut3Tl5pv"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7573AC01;
	Fri,  1 Mar 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310143; cv=none; b=uD2a2soNwQIwpJxotubpxG3PwKaQM1sGRETeIOa8QAl17lnofh2rlkUlEfnevEH98nJGmoazHVS8B0nX8cybO0X9UTf6M7KW2wOaPe2nsxJSjcBClCLudirCx94ewuEANQHa8qkeE0PxAY2/916M9vu2SRygkRKIdIw9TG/1B3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310143; c=relaxed/simple;
	bh=1zqTElPwTCF49b5oYzbwdb19NrFXvh4Ap9t+SLNaPaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i6dxzTfpPg0RuwzD/XFCz/Z3YMuwkju9Z9tpRXQHNPNjkjjclvi7caLMfZGaq41S6nEKFd1Iwi1yIsuBaTjk6L3hVBpA2ZtCUiVxW+W851dA8zKCRfVLwMtDjd69mDcNBdHi34HG18p/NxOdWUpjoLKA6eVS8y23s1YCqlCzkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ut3Tl5pv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4811C0005;
	Fri,  1 Mar 2024 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709310137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jgkt1Yt2tONrXuihezfAosJHwTSaZiG6q1ba8ipCjy0=;
	b=Ut3Tl5pvrbbLPMpVzS2NALxwafd/KewWKVRHY7z5Ysg0HJy2xnHEFXelFZGa0ih53henYE
	ITEJBIluJVqUqYagK3erpzY/9cqaWj9/2hoX79CZwDsFqZ1/SXXmjT/dnQ/ntIO+Oi6Gyy
	ROJ+4C6pNpyBZ6t9+ScjjESfbOphDVcWkm7NKffSJl2FH/b7UTJN8OTFVmomMfkRHnHcnv
	21pbv5BFq/RGT+Ifx6OY7+SHi6JzYMOPvykAXa7oNzy3SYH4ORxLcm+KDdLkdhs5kyvueP
	+Lt/+GOYU7Oh+fPUxEcJN33Q+HFZnigLBP59p+fBGJOCodcmp2B1LIM0F+ubUA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v9 0/9] Add support for Mobileye EyeQ5 system controller
Date: Fri, 01 Mar 2024 17:22:13 +0100
Message-Id: <20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALUA4mUC/3XQyU7DMBQF0F+psiboDR5Z8R+IhUdq0TYoqSKqq
 v+OU4RqGlhk8SKf6+t37qY0ljR1T5tzN6a5TGU41ME+bLqwdYe31JdY546AGOvX7/3u1Ifde29
 0SDKQwAymq8c/xpTL5zXq5bXO2zIdh/F0TZ5x+fsdggy3kBl76I3yGdHqiJye/TAcd+XwGIb9k
 voP8ZxARuWtT+5PQmjuiBC1r0AwGdQvspSd6VaQSDeUKnX1Lq84sIG8pvxDBWC7oJkrZUseELw
 hg2sqGsrYULG8MUQAiRCVgzWVN0pgGyorzWBFSjJZNG5NVUORGqoqDUJlh9myYbumuqHUFtbLW
 zHWHbNiCLympqXths1yq9TZR6eVEneFL5fLF90IzUOlAgAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

Here again for a new revision of the system-controller on Mobileye
EyeQ5. It deals with clk, reset and pinctrl. Drivers are meant to be
merged in their respective trees. Each already have their dt-bindings
in -next.

MIPS is the one with dependencies to outside trees. The syscon
dt-bindings ("dt-bindings: soc: mobileye: add EyeQ5 OLB system
controller") depends on dt-bindings for the three drivers. Patches:
 - dt-bindings: clock: mobileye,eyeq5-clk: add bindings
 - dt-bindings: reset: mobileye,eyeq5-reset: add bindings
 - dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings

To build + test the series, you need:
 - v6.8-rc6.
 - Platform support [1] and [0] series (both in mips-next [2]).
 - 4 patches from previous iteration, applied to clk-next [3].
    - clk: fixed-factor: add optional accuracy support
    - clk: fixed-factor: add fwname-based constructor functions
    - dt-bindings: clock: mobileye,eyeq5-clk: add bindings
    - dt-bindings: reset: mobileye,eyeq5-reset: add bindings
 - Pinctrl dt-bindings patch in pinctrl-next [4].
    - dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings

Here is the patch list, split by subsystems.
- pinctrl:
   [PATCH v9 4/9] pinctrl: eyeq5: add platform driver
- clk:
   [PATCH v9 2/9] clk: eyeq5: add platform driver, and init routine at of_clk_init()
- reset:
   [PATCH v9 3/9] reset: eyeq5: add platform driver
- MIPS:
   [PATCH v9 1/9] dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
   [PATCH v9 5/9] MAINTAINERS: Map OLB files to Mobileye SoCs
   [PATCH v9 6/9] MIPS: mobileye: eyeq5: add OLB syscon node
   [PATCH v9 7/9] MIPS: mobileye: eyeq5: use OLB clocks controller node
   [PATCH v9 8/9] MIPS: mobileye: eyeq5: add OLB reset controller node
   [PATCH v9 9/9] MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

Thanks all for the previous feedback!

Have a nice day,
Théo Lebrun

[0]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@flygoat.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-next
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=for-next

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v9:
- dt-bindings: soc: mobileye: remove useless labels in example.
- dt-bindings: pinctrl: drop patch applied to pinctrl-next [4].
- clk:
  - Kconfig: depend on "OF || COMPILE_TEST" rather than "OF".
  - fix includes; add <linux/errno.h> and <linux/overflow.h>.
  - eq5c_pll->index made unsigned.
  - eq5c_pll->reg renamed to reg64; remove associated comment.
  - probe(): remove "np" local variable.
  - probe(): remove useless else in "else if".
  - probe(): use dev_warn() rather than dev_err().
  - probe() and init(): i made unsigned.
  - probe() and init(): use readq() to read r0 and r1.
  - init(): simplify error handling of of_property_match_string().
  - init(): fail if parsing registers or clk registering errored out,
            previously we kept going. Use pr_err() rather than pr_warn().
  - init(): use %pe to print clk_hw_register_*() return value.
- reset:
  - fix includes.
  - replace "_withlock" prefix by "_locked".
  - add units to poll constants, introduce delay constants to avoid
    magic values.
  - eq5r_busy_wait_locked(): use readl_poll_timeout() helper.
  - introduce ID mask constants for domain+offset; exploit FIELD_GET()
    and FIELD_PREP().
  - add missing breaks in default case of switches.
  - probe(): use hweight32() instead of __builtin_popcount().
  - probe(): make i unsigned.
  - probe(): use dev_err_probe().
  - remove newline before builtin_platform_driver().
- pinctrl:
  - Kconfig: remove useless OF dependency.
  - fix includes.
  - introduce drive-strength mask constant (EQ5P_DS_MASK) to avoid magic
    numbers littering code.
  - eq5p_pinconf_get(): do not forward-declare function.
  - replace eq5p_function struct by generic pinfunction struct; allows
    removing custom FUNCTION() macro.
  - format gpio_groups[] strings, 8 by line and align columns.
  - eq5p_pinctrl_pin_dbg_show(): remove useless arg assignment.
  - eq5p_pinctrl_pin_dbg_show(): reverse if logic to avoid NOT.
  - eq5p_pinmux_set_mux(): remove __func__ in dev_dbg().
  - eq5p_pinmux_set_mux(): in value computation, use mask rather than
    U32_MAX.
  - eq5p_pinconf_set_drive_strength(): explicit max value is 0b11.
  - add missing MODULE_DEVICE_TABLE(of, eq5p_match).
  - remove newline before builtin_platform_driver().
- Link to v8: https://lore.kernel.org/r/20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com

Changes in v8:
- clk: drop two clk subsystem patches, clk dt-bindings and reset
  dt-bindings (4 patches taken into clk-next [3]).
- clk: Kconfig: fix help block indent.
- clk: fix #includes and whitespace.
- clk: add comment to explicit error conditions at start of probe.
- clk: fix error checking of devm_platform_ioremap_resource_byname() and
  do not shadow the error.
- clk: if parsing registers fail, put error in clk rather than keeping
  the EPROBE_DEFER set at init.
- clk: use dev_err_probe() on clk_hw_register_*() failure in probe.
- Link to v7: https://lore.kernel.org/r/20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com

Changes in v7:
- pinctrl: use dev_err_probe() and lower first letter of messages.
- Move all MAINTAINERS changes to a separate patch aimed at the MIPS
  tree. This means clk/reset/pinctrl can take patches independently.
- Apply two Reviewed-by: Linus Walleij.
- Link to v6: https://lore.kernel.org/r/20240212-mbly-clk-v6-0-c46fa1f93839@bootlin.com

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
Théo Lebrun (9):
      dt-bindings: soc: mobileye: add EyeQ5 OLB system controller
      clk: eyeq5: add platform driver, and init routine at of_clk_init()
      reset: eyeq5: add platform driver
      pinctrl: eyeq5: add platform driver
      MAINTAINERS: Map OLB files to Mobileye SoCs
      MIPS: mobileye: eyeq5: add OLB syscon node
      MIPS: mobileye: eyeq5: use OLB clocks controller node
      MIPS: mobileye: eyeq5: add OLB reset controller node
      MIPS: mobileye: eyeq5: add pinctrl node & pinmux function nodes

 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  |  94 ++++
 MAINTAINERS                                        |   8 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 125 +++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  42 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-eyeq5.c                            | 311 +++++++++++
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 579 +++++++++++++++++++++
 drivers/reset/Kconfig                              |  12 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq5.c                        | 361 +++++++++++++
 14 files changed, 1575 insertions(+), 39 deletions(-)
---
base-commit: e4153f4be7cc7928743145684385c305dae0d2f6
change-id: 20231023-mbly-clk-87ce5c241f08

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


