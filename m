Return-Path: <linux-kernel+bounces-167756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3801F8BAEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50011F233B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790F1552EC;
	Fri,  3 May 2024 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Nl9ST+k1"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52952153BF3;
	Fri,  3 May 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746079; cv=none; b=sI160RSMmZrH6DV4N4pbcSR6sNHD6jV1g3MVjhaJnH5dsOW8Zx0aF0N5shdZJU3zsp9zB0bMC+HxS9YJpnWTOoCB2IA6B/Z7lZBA/JTXuf7Gl6BjM2Y+oukC1n2IPF5w54/lM5R2KQo1+mzBGZ3CvzVqIUml/8hXUVXmrenM/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746079; c=relaxed/simple;
	bh=RlPqLAnreRucam7vP7wW4xXszOq8/j39ateAy9eIb5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bH6nJ5Jl7PcDnBdvJnIxVFThUOFhVI6rCWRmXrm5uPy8VcV/Q6VVMXNb0+M5RL2wlRKt40pab90ehIWN7M9irHVbZWge1sEOLE+z0h+3e9bmZBxTra40k9wSqSWplSCysDP4Kl4w58pJKvo0dnJwCWhI941RH7/Kvkj3mCINTHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Nl9ST+k1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AED6E0005;
	Fri,  3 May 2024 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714746069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PTqZ54gj8ig1Fedp9Waojut71etolv05n2qYK+FFydU=;
	b=Nl9ST+k1xWyBaGbqqkpWbBra4iDps9JT33bXsHJP3ig/58P0koDDbDG9GF9zgGmrIKv9rX
	YCSuvvlGwEc07hcY8gk+IHELyo+MppOToCYM85b4j0ZWo4LhukVsDwUCrpv3Fb7KH01SSu
	zYCmcrGZhl5zjVfbT56EBtCIgAcLvR05DSBXAATqAu1eiHXe4PPMBOZCv52YoDFuM+B4Dd
	2WI4bYNmNzK5B39Y9rIexSg/HzyrNzx6qs1xeYBQqhlIBEQGZoNc6i3fAcpNLMlsWNfGgg
	ZfHiMl5DV1y0sR0NCVQ7qnAdKpqGBY/n3Is5aZ9mMoJH/sQFFL87HGUn6U0iug==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 00/11] Add Mobileye EyeQ system controller support (clk,
 reset, pinctrl)
Date: Fri, 03 May 2024 16:20:45 +0200
Message-Id: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL3yNGYC/0XMSwqDMBSF4a3IHTcl5lFtR91HcWCSm3pBTUkkV
 MS9N5VCh//h8G2QMBImuFUbRMyUKMwlxKkCO/TzExm50iC4UFzxlk1mXFkYDWt032qvrXcoodx
 fET29D+rRlR4oLSGuh5zr7/pDav5Hcs04k1Kjul5cY1DeTQjLSPPZhgm6fd8/Vog/16IAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

This builds on previous EyeQ5 system-controller revisions[0], supporting
EyeQ5, EyeQ6L and EyeQ6H. We expose a few OLB system-controller
features here:
 - Clocks: some read-only PLLs derived from main crystal and some
   divider clocks based on PLLs.
 - Resets.
 - Pin controller, only on EyeQ5 (rest will use generic pinctrl-single).

EyeQ6H is special in that it has seven instances of this
system-controller. Those are spread around and cannot be seen as a
single device, hence are exposed as seven DT nodes and seven
compatibles.

This revision differs from previous in that it exposes all devices as a
single DT node. Driver-wise, a MFD registers multiple cells for each
device. Each driver is still in isolation from one another, each in
their respective subsystem.

This has been requested during previous reviews and took time to
implement; I'd be happy to get some feedback on this aspect.

Patches are targeting MIPS, clk, reset, pinctrl and MFD:

MIPS:
 - dt-bindings: clock: mobileye,eyeq5-clk: drop bindings
 - dt-bindings: clock: mobileye,eyeq5-reset: drop bindings
 - dt-bindings: soc: mobileye: add EyeQ OLB system controller
 - MIPS: mobileye: eyeq5: add OLB system-controller node

   Start by dropping already accepted dt-bindings that don't match
   current approach of single node for entire OLB (and no subnodes).
   Then add single dt-bindings that cover clk/reset/pinctrl features.

   Squash devicetree commits together into one.
   Adapted to having a single devicetree node without subnodes.

MFD:
 - driver core: platform: Introduce platform_device_add_with_name()
 - mfd: Add cell device name
 - mfd: olb: Add support for Mobileye OLB system-controller

   There are seven instances of OLB on EyeQ6H. That means many clk/reset
   instances. Without naming devices properly it becomes a mess because
   integer IDs are not explicit. Add feature to name MFD sub-devices.

   Then add OLB MFD platform driver; a really simple driver. Most its
   content is iomem resources and MFD cells.

clk:
 - clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
 - clk: eyeq: add driver

reset:
 - reset: eyeq: add platform driver

pinctrl:
 - pinctrl: eyeq5: add platform driver

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240301-mbly-clk-v9-0-cbf06eb88708@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- dt-bindings:
  - Drop mobileye,eyeq5-clk and mobileye,eyeq5-reset bindings.
  - Update OLB bindings to handle clk/reset/pinctrl from OLB node.
- MFD:
  - Add core driver and MFD patches to allow setting sub-devices names
    from MFD cell.
  - Add MFD OLB driver.
- clk:
  - Change type of eqc_pll->reg64 from u32 to unsigned int.
  - Use resource indexes rather than names for iomem resources.
  - Put early PLLs into a separate match data table. Also, have store
    number of late clocks in early match data to properly alloc cells.
  - Pre-acquire all divclk resources first, then register them.
    This simplifies code.
  - Extract PLLs and divclks init to two separate functions.
  - Avoid variable declarations in loop bodies.
  - Do not register match data table to platform driver. It gets probed
    as MFD sub-device matching on driver name. Match data table is
    matched against parent OF node compatible.
  - Fix ugly memory corruption bug when clk count == 1.
- reset:
  - EQR_EYEQ5_SARCR and EQR_EYEQ6H_SARCR did not use offset 0x0: do
    minus four to all their offsets and reduce resource sizes.
  - Remove resource names. Reset i uses iomem resource index i.
  - Simplify xlate: have two implementations for of_reset_n_cells==1 and
    of_reset_n_cells==2. Both call the same helper internal function.
  - Do not register match data table to platform driver. It gets probed
    as MFD sub-device matching on driver name. Match data table is
    matched against parent OF node compatible.
- pinctrl:
  - Remove match data table to platform driver. It gets probed as MFD
    sub-device matching on driver name. Driver has single compatible.
  - Drop "Reviewed-by: Linus Walleij" as driver changed approach.
- MIPS DTS:
  - Squash all commits together into a single one.
  - Adapt to new approach: OLB is now a single OF node.
- Link to v1: https://lore.kernel.org/r/20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com

---
Théo Lebrun (11):
      dt-bindings: clock: mobileye,eyeq5-clk: drop bindings
      dt-bindings: clock: mobileye,eyeq5-reset: drop bindings
      dt-bindings: soc: mobileye: add EyeQ OLB system controller
      driver core: platform: Introduce platform_device_add_with_name()
      mfd: Add cell device name
      mfd: olb: Add support for Mobileye OLB system-controller
      clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
      clk: eyeq: add driver
      reset: eyeq: add platform driver
      pinctrl: eyeq5: add platform driver
      MIPS: mobileye: eyeq5: add OLB system-controller node

 .../bindings/clock/mobileye,eyeq5-clk.yaml         |  51 --
 .../bindings/reset/mobileye,eyeq5-reset.yaml       |  43 --
 .../bindings/soc/mobileye/mobileye,eyeq5-olb.yaml  | 375 +++++++++++
 MAINTAINERS                                        |   5 +
 .../{eyeq5-fixed-clocks.dtsi => eyeq5-clocks.dtsi} |  54 +-
 arch/mips/boot/dts/mobileye/eyeq5-pins.dtsi        | 125 ++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  22 +-
 drivers/base/platform.c                            |  17 +-
 drivers/clk/Kconfig                                |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-divider.c                          |  12 +-
 drivers/clk/clk-eyeq.c                             | 690 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/mfd-core.c                             |   2 +-
 drivers/mfd/mobileye-olb.c                         | 180 ++++++
 drivers/pinctrl/Kconfig                            |  14 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-eyeq5.c                    | 573 +++++++++++++++++
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-eyeq.c                         | 541 ++++++++++++++++
 include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +
 include/linux/clk-provider.h                       |  11 +-
 include/linux/mfd/core.h                           |  19 +-
 include/linux/platform_device.h                    |  12 +-
 26 files changed, 2651 insertions(+), 155 deletions(-)
---
base-commit: d5a00175dce1740a3e9d519933ba76f9ce5cbd24
change-id: 20240408-mbly-olb-75a85f5cfde3

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


