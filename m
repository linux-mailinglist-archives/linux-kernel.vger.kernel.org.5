Return-Path: <linux-kernel+bounces-102588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E05A87B44E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4350B286B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED13059B66;
	Wed, 13 Mar 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUhc4oir"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CF59B4E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368668; cv=none; b=Z8HxGXdcQxy07wfp0AwEC5Emow6opQyJbCNVhxoiqj6BhBH06J/7P53D18pC5OQuXo+or4vfSQYec5okGLru6M9wAQUQY8C7Wj0dviCOMiy5SO5HGUwzZIjU+H5laR21UJU8pOINy1gCtizIGVOYlQunZ8F1UcstZKnb5EbRzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368668; c=relaxed/simple;
	bh=zbLeQIWvy5qwTJ6MDXQixdKvzQX4rEAfnJ7pl0mTJ0E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C8OYfsk5sSdPvHkIKMSAkGoKIujOglU5xW+36iSyGxrhoEqMROnE9SKtvdqgEJNfBKDCD1I9AYOjSH40ndcBG4NwQgdZRhALvMZ2Sfbq/NdF7tcqwjhuCWSsfeKLPcvBv6NkvzxR6LMv3K2DaLdWPeoJQDfiJTeIgEm9hIdvxJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUhc4oir; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso235690276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710368666; x=1710973466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gqcbVEM/vE886TusLqgUrg1+EocQSk8oVS1AlNPmiiw=;
        b=jUhc4oirCVgJ2fDB8t8gry2VZ6nd38Hd2QD7En/NefUSFF0UEHvp0eshwmtW7HBUOS
         fWiAlqv2Zx69EHL1tcOcv2h87qT/G9JUiGv2/S5wWviiEn4FP7XeNL+8DTWXMqVdsx8f
         wtopVFVJ18utcgwpP5AwP/4nn8qXiTFFlXst21071scIv0E+7XRZnH7EICTobjodq3uZ
         O03tdhF4snGIoeKUBUXrdi4+9qLyE8EH32ZAl8pX5FsnvZgsMPPmniy9jLM/7ShOncTs
         tfK0XgmqLxkJIKmk40zzi9aetLU3nq5h45aL0/v5Lq9BshtxCAJFKHafFwwt0bbpHF4x
         5QqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710368666; x=1710973466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqcbVEM/vE886TusLqgUrg1+EocQSk8oVS1AlNPmiiw=;
        b=TEtlvH31hIsNES5dZQouxTwrkpqzpyZKXxD5/4qjj/NtdMu+CqaKN4A1I6l/BhgaRk
         Le9dwANa2dRVoCfmzrkrsPsC67T4cZG5ceWNU1VChyJRGtF6N6RSFxH9DmvvSlFoMCdq
         5rdUcIVCSwql86fCmmkdWp0D1r72zs6sPvyz2RuwCzQAqCO/SYneu3MqOxzKalmJbOnR
         4lPZ90E+q4NcC8yOPXoXc2ZcswK27Ljn5ttSfPl6omZ3NpGL+EBzZ9KkuLkmD2WzBnNG
         +U5s0K09QC/xj5nGcYnjiH17o4t+MPL5n4Y6bgVcPBvKJPfJLxPM1Tb4ymDGHU+yH8Nj
         cIng==
X-Gm-Message-State: AOJu0Yx3bf0cie35ODNaT3Z+gEFVfUMWCpSp1H0coX9my2wtMFeBlIvI
	TJGo3Jt4HcdeA4Emk5js0fO95yaZj21Mwpju4idzlqPx0YKOfJlndV/wKkGzBJKeRpFXQIoO+KZ
	qYtSeDYDezgCVqDdWdBl/DvduMGbb8S1gIa0Uj7oNuNDGi1cBum0=
X-Google-Smtp-Source: AGHT+IHpQ4YIO03aPM1BuAYFi8DxKeqs+GpFXRCN0uax2uGsql/PD2rMsOs0arfNXIiNgBZ59EP+HKhUHPEKnIm4Fsg=
X-Received: by 2002:a25:b124:0:b0:dcc:d694:b4a6 with SMTP id
 g36-20020a25b124000000b00dccd694b4a6mr54290ybj.15.1710368665695; Wed, 13 Mar
 2024 15:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2024 23:24:14 +0100
Message-ID: <CACRpkdYZ01rEzd5d8RcDbZqBPdy4uVU1uYWH6q7XS1WjKNXrUA@mail.gmail.com>
Subject: [GIT PULL] pin control changes for v6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

pin control is rather boring this time with mainly cleanups.
There are some 2-3 new drivers.

Some stuff hits drivers/gpio as we split out the Nomadik
GPIO driver, but the merge should be painless AFAICT.
The main GPIO maintainer Bartosz is in sync.

Details are in the signed tag, please pull it in!

Yours,
Linus Walleij

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d=
:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.9-1

for you to fetch changes up to fa63587f94a77a49b53274dc0fd1ea41dfde5966:

  drivers/gpio/nomadik: move dummy nmk_gpio_dbg_show_one() to header
(2024-03-12 12:53:35 +0100)

----------------------------------------------------------------
Pin control changes for the v6.9 kernel cycle:

No core changes this time around.

New drivers:

- New driver for Renesas R8A779H0 also known as R-Car V4M.

- New driver for the Awinic AW9523/B I2C GPIO expander.
  I found this living out-of-tree in OpenWrt as an upstream
  attempt had stalled on the finishing line, so I picked it
  up and finished the job.

Improvements:

- The Nomadik pin control driver was for years re-used out of
  tree for the ST STA chips, and now the IP was re-used in a
  MIPS automotive SoC called MobilEyeq5, so it has been split
  in pin control and GPIO drivers so the latter can be reused
  by MobilEyeq5. (Along with a long list of cleanups.)

- A lot of overall cleanup and tidying up.

----------------------------------------------------------------
Andre Przywara (1):
      pinctrl: pinmux: Suppress error message for -EPROBE_DEFER

Andy Shevchenko (2):
      pinctrl: nuvoton: Constify wpcm450_groups
      gpio: nomadik: Finish conversion to use firmware node APIs

AngeloGioacchino Del Regno (2):
      dt-bindings: pinctrl: Add bindings for Awinic AW9523/AW9523B
      pinctrl: Add driver for Awinic AW9523/B I2C GPIO Expander

Arturas Moskvinas (1):
      pinctrl: mcp23s08: Check only GPIOs which have interrupts enabled

Biju Das (4):
      pinctrl: renesas: rzg2l: Configure interrupt input mode
      pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
      pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}a=
ble*(
      pinctrl: da9062: Add OF table

Charles Keepax (3):
      pinctrl: cs42l43: Tidy up header includes
      pinctrl: cs42l43: Remove some needless inlines
      pinctrl: cs42l43: Use str_high_low()

Chen Ni (1):
      pinctrl: st: Return pinctrl_gpio_direction_output to transfer the err=
or

Chen-Yu Tsai (2):
      pinctrl: mediatek: Drop bogus slew rate register range for MT8186
      pinctrl: mediatek: Drop bogus slew rate register range for MT8192

Claudiu Beznea (3):
      pinctrl: renesas: rzg2l: Fix locking in rzg2l_dt_subnode_to_map()
      pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERAR=
CHY
      pinctrl: renesas: rzg2l: Add suspend/resume support

Colin Ian King (1):
      pinctrl: ocelot: remove redundant assignment to variable ret

Cong Dang (13):
      pinctrl: renesas: Initial R8A779H0 (R-Car V4M) PFC support
      pinctrl: renesas: r8a779h0: Add Ethernet AVB pins, groups, functions
      pinctrl: renesas: r8a779h0: Add SD/MMC pins, groups, functions
      pinctrl: renesas: r8a779h0: Add QSPI pins, groups, functions
      pinctrl: renesas: r8a779h0: Add SCIF pins, groups, functions
      pinctrl: renesas: r8a779h0: Add SCIF_CLK pins, groups, functions
      pinctrl: renesas: r8a779h0: Add HSCIF pins, groups, functions
      pinctrl: renesas: r8a779h0: Add I2C pins, groups, functions
      pinctrl: renesas: r8a779h0: Add MSIOF pins, groups, functions
      pinctrl: renesas: r8a779h0: Add PWM/TPU pins, groups, functions
      pinctrl: renesas: r8a779h0: Add CANFD pins, groups, functions
      pinctrl: renesas: r8a779h0: Add PCIe pins, groups, functions
      pinctrl: renesas: r8a779h0: Add Audio pins, groups, functions

Dan Carpenter (2):
      pinctrl: core: comment that pinctrl_add_gpio_range() is deprecated
      gpio: nomadik: remove BUG_ON() in nmk_gpio_populate_chip()

Erick Archer (1):
      pinctrl: pinctrl-zynqmp: Use devm_kcalloc() instead of devm_kzalloc()

Geert Uytterhoeven (4):
      pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
      pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs
      dt-bindings: pinctrl: renesas,pfc: Document R-Car V4M support
      pinctrl: renesas: Allow the compiler to optimize away sh_pfc_pm

Jean Thomas (2):
      pinctrl: mediatek: mt7981: add additional uart group
      pinctrl: mediatek: mt7981: add additional emmc groups

Krzysztof Kozlowski (2):
      dt-bindings: pinctrl: amlogic: narrow regex for unit address to
hex numbers
      pinctrl: qcom: sm8650-lpass-lpi: correct Kconfig name

Lad Prabhakar (3):
      pinctrl: renesas: rzg2l: Improve code for readability
      pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() mac=
ro
      pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28

Linus Walleij (6):
      Merge tag 'renesas-pinctrl-for-v6.9-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'renesas-pinctrl-for-v6.9-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      pinctrl: aw9523: Add proper terminator
      gpio: nomadik: Back out some managed resources
      Merge branch 'ib-nomadik-gpio' into devel
      pinctrl: aw9523: Make the driver tristate

Max Kellermann (1):
      drivers/gpio/nomadik: move dummy nmk_gpio_dbg_show_one() to header

Michal Simek (1):
      dt-bindings: pinctr: pinctrl-zynq: Fix compatible string

Naresh Solanki (1):
      dt-bindings: pinctrl: cy8c95x0: Update gpio-reserved-ranges

Randy Dunlap (1):
      pinctrl: mt7986: excise kernel-doc warnings

Rob Herring (3):
      dt-bindings: pinctrl: Unify "input-debounce" schema
      dt-bindings: pinctrl: nuvoton,npcm845: Drop redundant type for "slew-=
rate"
      dt-bindings: pinctrl: nvidia,tegra234-pinmux: Restructure common sche=
ma

Tengfei Fan (1):
      dt-bindings: pinctrl: qcom: update compatible name for match with dri=
ver

Th=C3=A9o Lebrun (28):
      dt-bindings: pinctrl: mobileye,eyeq5-pinctrl: add bindings
      dt-bindings: gpio: nomadik: convert into yaml format
      dt-bindings: gpio: nomadik: add optional ngpios property
      dt-bindings: gpio: nomadik: add mobileye,eyeq5-gpio compatible
      dt-bindings: gpio: nomadik: add optional reset property
      gpio: nomadik: fix offset bug in nmk_pmx_set()
      gpio: nomadik: extract GPIO platform driver from drivers/pinctrl/noma=
dik/
      pinctrl: nomadik: Kconfig: allow building with COMPILE_TEST
      pinctrl: nomadik: fix build warning (-Wformat)
      pinctrl: nomadik: fix build warning (-Wpointer-to-int-cast)
      pinctrl: nomadik: minimise indentation in probe
      pinctrl: nomadik: follow type-system kernel coding conventions
      pinctrl: nomadik: follow whitespace kernel coding conventions
      pinctrl: nomadik: follow conditional kernel coding conventions
      gpio: nomadik: add #include <linux/slab.h>
      gpio: nomadik: replace of_find_*() by bus_find_device_by_of_node()
      gpio: nomadik: replace of_property_read_*() by device_property_read_*=
()
      gpio: nomadik: use devm_platform_ioremap_resource() helper
      gpio: nomadik: use devres version of clk_get*()
      gpio: nomadik: request dynamic ID allocation
      gpio: nomadik: make clock optional
      gpio: nomadik: change driver name from gpio to nomadik-gpio
      gpio: nomadik: support shared GPIO IRQs
      gpio: nomadik: handle variadic GPIO count
      gpio: nomadik: support mobileye,eyeq5-gpio
      gpio: nomadik: grab optional reset control and deassert it at probe
      gpio: nomadik: fix Kconfig dependencies inbetween pinctrl & GPIO
      pinctrl: nomadik: fix dereference of error pointer

Varshini Rajendran (1):
      dt-bindings: pinctrl: at91: add sam9x7

 .../devicetree/bindings/gpio/gpio-nmk.txt          |   31 -
 .../devicetree/bindings/gpio/st,nomadik-gpio.yaml  |   95 +
 .../bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml |    2 +-
 .../pinctrl/amlogic,meson-pinctrl-g12a-aobus.yaml  |    2 +-
 .../amlogic,meson-pinctrl-g12a-periphs.yaml        |    2 +-
 .../pinctrl/amlogic,meson8-pinctrl-aobus.yaml      |    2 +-
 .../pinctrl/amlogic,meson8-pinctrl-cbus.yaml       |    2 +-
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |    2 +
 .../bindings/pinctrl/awinic,aw9523-pinctrl.yaml    |  139 +
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml |    3 +-
 .../bindings/pinctrl/cypress,cy8c95x0.yaml         |   24 +-
 .../bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml   |  242 ++
 .../bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml  |    2 -
 .../bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml  |    3 +-
 .../pinctrl/nvidia,tegra234-pinmux-aon.yaml        |    7 +-
 .../pinctrl/nvidia,tegra234-pinmux-common.yaml     |   84 +-
 .../bindings/pinctrl/nvidia,tegra234-pinmux.yaml   |    7 +-
 .../devicetree/bindings/pinctrl/pincfg-node.yaml   |    2 +-
 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml         |    2 +-
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml   |    1 +
 ...nx,zynq-pinctrl.yaml =3D> xlnx,pinctrl-zynq.yaml} |    6 +-
 MAINTAINERS                                        |    2 +
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi        |    4 +
 drivers/gpio/Kconfig                               |   12 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-nomadik.c                        |  730 ++++
 drivers/pinctrl/Kconfig                            |   18 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |   18 +-
 drivers/pinctrl/core.c                             |    4 +
 drivers/pinctrl/mediatek/pinctrl-mt7981.c          |   24 +-
 drivers/pinctrl/mediatek/pinctrl-mt7986.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8186.c          |    1 -
 drivers/pinctrl/mediatek/pinctrl-mt8192.c          |    1 -
 drivers/pinctrl/nomadik/Kconfig                    |    8 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-db8500.c   |    3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik-stn8815.c  |    3 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  955 +----
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |    2 +-
 drivers/pinctrl/pinctrl-aw9523.c                   | 1119 ++++++
 drivers/pinctrl/pinctrl-da9062.c                   |    7 +
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   15 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |    1 -
 drivers/pinctrl/pinctrl-st.c                       |    3 +-
 drivers/pinctrl/pinctrl-zynqmp.c                   |    8 +-
 drivers/pinctrl/pinmux.c                           |    6 +-
 drivers/pinctrl/qcom/Kconfig                       |    2 +-
 drivers/pinctrl/renesas/Kconfig                    |    7 +
 drivers/pinctrl/renesas/Makefile                   |    1 +
 drivers/pinctrl/renesas/core.c                     |   14 +-
 drivers/pinctrl/renesas/pfc-r8a779g0.c             |   14 +
 drivers/pinctrl/renesas/pfc-r8a779h0.c             | 3967 ++++++++++++++++=
++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  790 +++-
 drivers/pinctrl/renesas/sh_pfc.h                   |    1 +
 .../linux/gpio/gpio-nomadik.h                      |  138 +-
 55 files changed, 7496 insertions(+), 1046 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/st,nomadik-gpio.=
yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/awinic,aw9523-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/mobileye,eyeq5-pinctrl.yaml
 rename Documentation/devicetree/bindings/pinctrl/{xlnx,zynq-pinctrl.yaml
=3D> xlnx,pinctrl-zynq.yaml} (98%)
 create mode 100644 drivers/gpio/gpio-nomadik.c
 create mode 100644 drivers/pinctrl/pinctrl-aw9523.c
 create mode 100644 drivers/pinctrl/renesas/pfc-r8a779h0.c
 rename drivers/pinctrl/nomadik/pinctrl-nomadik.h =3D>
include/linux/gpio/gpio-nomadik.h (59%)

