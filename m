Return-Path: <linux-kernel+bounces-84880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0033486AD08
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53125B2121E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7913A891;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WVCfrTLG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CD12E1FD;
	Wed, 28 Feb 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119701; cv=none; b=FTwS0rbrXvE4rtJnLYaQgLTXZmMIIlP/Jo/9C4pbWjBFDjwcxuNZ71R+45BuA1DQmcfXWcBj2Q99mGQKKFzZIcwU4Q28K+hJ37mHj8DW1bau4MztsO7DiK1P7Tb0jhVt3Mq1MONYgn0XkziEewcLtITejYamwpvHdUXixhETqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119701; c=relaxed/simple;
	bh=4aOopf4jXtqDRDW3FIuhQ4/nRYsU/hj/5V3KCzXokSY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ui63O6YfuMHcMQ0H57ErpTEoVP0GcnW0kFzAY84Y7UVUkzcsZ0qKs3R5b0vzDuKHnl0LVNG6A/cQjmWzKyLtMswwB5qgA2m2Dc4HiKfXQPfxzDHSHXqD/HyiC9r+OYq1kpt5B/TNnXci4yR3MLLLoHm1k9NkkYpH41DnwGGeaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WVCfrTLG; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A0EF1BF213;
	Wed, 28 Feb 2024 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtE8ccdMBx2A8EhTVDOTFlKlJ4eQpPULg5/PMLwosXM=;
	b=WVCfrTLGmYi4GhNKJ4qT5hcVa3heEJca6ADyK1rjR6iMcCK9m+R9eXxoNbNxAWQfTq0y7c
	3oAaRclaLppRM99Fo0jAL+h2v9v1p3MmJrGh9n1qyl0qEbyLYwa6zYrPabSaEqCXgWg3eP
	FxbS3gTETuKaj5DcOUqhMlnrlttlxH3wLKeD30gfhUaN/hGKh4Q/HnfShdl6yIobuK8EfH
	v0FmKOaKfToGfxloywYFapyy035wA+gL8IwNDG9vtuhXwiiWCTizB7nRsc+1jY+IFpN59l
	sL4WhNsKOV29g22nuO97IceD8m+Y3dHordn3RmXUAbzugl8MMG3E8/G4lAQrZg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH v2 00/30] Rework Nomadik GPIO to add Mobileye EyeQ5 support
Date: Wed, 28 Feb 2024 12:27:58 +0100
Message-Id: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL8Y32UC/03MQQ6DIBCF4auYWZcGBhtJV71H40Io6CQKBgypM
 dy96KqLWfyTl++AZCPZBM/mgGgzJQq+Bt4aMNPgR8voUxuQoxT12KLnnY0rBTZI/uiENRKVhLp
 fo3X0vax3X3uitIW4X3QW5/dUWo6i/VOyYJw5pQw3xskO9UuHsM3k7yYs0JdSfuaBJNWkAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stephen Warren <swarren@wwwdotorg.org>, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

This patch series reworks the Nomadik GPIO driver to bring it up to date
to current kernel standards. We then add Mobileye EyeQ5 support that
uses the same IP block but with limited functionality. We also add
features required by our newly supported platform:

 - Dynamic GPIO ID allocation;
 - Make clock optional;
 - Shared IRQ (usecase: EyeQ5 has two banks using the same IRQ);
 - Handle variadic GPIO counts (usecase: EyeQ5 has <32 GPIOs per bank);
 - Grab optional reset at probe (usecase: EyeQ5 has a shared GPIO reset).

This GPIO platform driver was previously declared & registered inside
drivers/pinctrl/nomadik/pinctrl-nomadik.c, side-by-side with the
pinctrl driver. Both are tightly integrated, mostly for muxing reasons.
Now that gpio-nomadik is used for another platform, we loosen the
relationship. The behavior should not change on already supported
hardware but I do not have Nomadik hardware to test for that.

We have some dependencies. Those are:
- The base platform support series from Grégory [0], present in
  mips-next. It in turns depends on [1], also in mips-next. This
  relates to the last four patches (27 thru 30), ie defconfig and
  devicetree.
- The OLB syscon support series [2]. It provides reset and pinctrl nodes
  inside the devicetree. This relates to the last two patches (29 and
  30), ie resets and gpio-ranges DT props. GPIO works fine if patches
  29 and 30 are dropped and bootloader deasserts the reset (it does).

This has been tested on the EyeQ5 hardware, with the two parent series
applied. It also works fine without the OLB syscon series when our last
two patches are removed. It has been built on both Arm defconfigs that
rely on pinctrl-nomadik: nhk8815_defconfig and u8500_defconfig. I don't
have any Nomadik hardware to test though.

Have a nice day,
Théo

[0]: https://lore.kernel.org/lkml/20240216174227.409400-1-gregory.clement@bootlin.com/
[1]: https://lore.kernel.org/linux-mips/20240209-regname-v1-0-2125efa016ef@flygoat.com/
[2]: https://lore.kernel.org/lkml/20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com/

To: Linus Walleij <linus.walleij@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Changes in v2:
- dt-bindings: add description to gpio-bank.
- dt-bindings: fix disabling of st,supports-sleepmode prop with
  st,supports-sleepmode compatible.
- gpio: move "fix offset bug in nmk_pmx_set()" to the start of the
  series and add a Fixes trailer. The patch changed because of that.
- pinctrl: allow building PINCTRL_NOMADIK and co with COMPILE_TEST.
- gpio: in "support shared GPIO IRQs" remove fake raw lock and use
  generic_handle_domain_irq_safe() helper.
- gpio: remove OF API calls.
    of_property_read_*()     => device_property_read_*()
    of_find_device_by_node() => bus_find_device_by_of_node()
- gpio: use device_is_compatible() rather than match data to detect for
  Mobileye SoC. If GPIO device is populated by pinctrl match data is
  unavailable.
- gpio: rename quirk_mbly field to is_mobileye_soc.
- gpio: add comment about unbalanced reset_control_deassert() and
  disable bind sysfs attributes.
- gpio: use devm_platform_ioremap_resource() helper.
- gpio: use devres version of clk_get*() in case of probe failure.
- gpio: add missing <linux/slab.h> include.
- Documentation: gpio: replace outdated comment of using a fake spin
  lock and mention the generic_handle_irq_safe() helper.
- gpio: in "follow whitespace kernel coding conventions", add missing
  newline before headers.
- Take 6 Reviewed-By Linus, 1 Reviewed-by and 1 Acked-by Krzysztof.
- Link to v1: https://lore.kernel.org/r/20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com

---
Théo Lebrun (30):
      dt-bindings: gpio: nomadik: convert into yaml format
      dt-bindings: gpio: nomadik: add optional ngpios property
      dt-bindings: gpio: nomadik: add mobileye,eyeq5-gpio compatible
      dt-bindings: gpio: nomadik: add optional reset property
      gpio: nomadik: fix offset bug in nmk_pmx_set()
      gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/nomadik/
      pinctrl: nomadik: Kconfig: allow building with COMPILE_TEST
      pinctrl: nomadik: fix build warning (-Wformat)
      pinctrl: nomadik: fix build warning (-Wpointer-to-int-cast)
      pinctrl: nomadik: minimise indentation in probe
      pinctrl: nomadik: follow type-system kernel coding conventions
      pinctrl: nomadik: follow whitespace kernel coding conventions
      pinctrl: nomadik: follow conditional kernel coding conventions
      gpio: nomadik: add #include <linux/slab.h>
      gpio: nomadik: replace of_find_*() by bus_find_device_by_of_node()
      gpio: nomadik: replace of_property_read_*() by device_property_read_*()
      gpio: nomadik: use devm_platform_ioremap_resource() helper
      gpio: nomadik: use devres version of clk_get*()
      gpio: nomadik: request dynamic ID allocation
      gpio: nomadik: make clock optional
      gpio: nomadik: change driver name from gpio to gpio-nomadik
      gpio: nomadik: support shared GPIO IRQs
      gpio: nomadik: handle variadic GPIO count
      gpio: nomadik: support mobileye,eyeq5-gpio
      gpio: nomadik: grab optional reset control and deassert it at probe
      Documentation: gpio: mention generic_handle_irq_safe()
      MIPS: eyeq5_defconfig: enable GPIO by default
      MIPS: mobileye: eyeq5: add two GPIO bank nodes
      MIPS: mobileye: eyeq5: add resets to GPIO banks
      MIPS: mobileye: eyeq5: map GPIOs to pins using gpio-ranges

 .../devicetree/bindings/gpio/gpio-nmk.txt          |  31 -
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml  |  95 +++
 Documentation/driver-api/gpio/driver.rst           |  11 +-
 MAINTAINERS                                        |   2 +
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             |  30 +
 arch/mips/configs/eyeq5_defconfig                  |   2 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-nomadik.c                        | 722 ++++++++++++++++
 drivers/pinctrl/nomadik/Kconfig                    |   7 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |   3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |   3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          | 939 +++------------------
 .../linux/gpio/gpio-nomadik.h                      | 123 ++-
 14 files changed, 1117 insertions(+), 865 deletions(-)
---
base-commit: 3ebad8a9638d4c667e8925968806a82e1b9025ea
change-id: 20231023-mbly-gpio-a30571ec3283

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


