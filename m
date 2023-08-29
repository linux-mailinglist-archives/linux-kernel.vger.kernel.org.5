Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FEB78C38C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjH2Lnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjH2LnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:43:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E611B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:43:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401da71b7faso2030295e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1693309386; x=1693914186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tfZ7jTTtOJDQgXQtm1uAdU9eCcZqyeyVorm0CfJYHOI=;
        b=I8E6o+imrrWY9se0+pzUUNmHHy6CIcZmqJInFOa7kOLK1llInJZPc4um9SAWQ6ThJ7
         RwYb7muULdxl8rwUK+yCs6DuvsBT2hIrfc8QZnjoCUWZnrCP9G9jHejaNMFJ7Pmv0KsS
         SaKcS+FA1rNjcivnjnfWkXkurAt7tiEwPzN3VBEyZur5EghBu7LCRVKC9LMPBPxTzcTV
         m/YjxrmPDiFW3ugvX3wG3eAFlMZBlq7PqR+sHo1jY2Ui9TxYmEORi+5LiRbFR7Ek8ou9
         r+wcmAoXvyyn7/apmqlCwZZBMerlOeCri1fOPqRzbazpqpW95GDnDYLbzqy3ez5do+vO
         +XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309386; x=1693914186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfZ7jTTtOJDQgXQtm1uAdU9eCcZqyeyVorm0CfJYHOI=;
        b=DhUzYKjN7KCItsNbfLeqht/7krBBYy4dk/1kFNhIhw2BkAxjZ0RYHadM4KBYyxW05f
         uSP0jpi631gqJG4J0Swt4NJ0q0v/tXkI/wEnXxrAE8TMA/rpQoY8u37xZpD4mLAGCXLd
         Ka31e5TN4AcTtH1o6bpddSkyG00i3KUH9Wepko6Lr34eLu7zAYyuQ/SI2B83pKrcAh2e
         ORTh2UbZ4gnjJ0lqrckmjFPXgLRZJeqRmdzwBvX+9UmeHa5if+tNrLwLrwCQzHv0DIDE
         RKT3073SL9pic6MZyhgwzMIUZmF3AknKcJe5fmc5beG7sDObIvT6YlCXUp/gt1lB8Mqe
         ooAQ==
X-Gm-Message-State: AOJu0Yz50l7zHGguQc+7YZ2aVeSZIED1V/MJQrXiiA7YBusOfY8M4/cJ
        9nYTit9WZBDFxnyz5U3PEWQJ8A==
X-Google-Smtp-Source: AGHT+IGeFQ7tcxojiDVHSGNMDjzIBv4b3is86cnUF6y/tEYd7PGJv3imZ58geseOt760RA9z6YRNNg==
X-Received: by 2002:a05:600c:3654:b0:3fb:b5dc:dab1 with SMTP id y20-20020a05600c365400b003fbb5dcdab1mr19791432wmq.39.1693309385573;
        Tue, 29 Aug 2023 04:43:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2a3f:6761:e8aa:5b5a])
        by smtp.gmail.com with ESMTPSA id w24-20020a05600c2a1800b003fed9b1a1f4sm1000714wme.1.2023.08.29.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:43:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.6
Date:   Tue, 29 Aug 2023 13:43:01 +0200
Message-Id: <20230829114301.10450-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the pull-request from the GPIO subsystem for this merge window. We have
a lot of code refactoring using common helpers and ended up removing more lines
then we're adding this release cycle.

Everything has been in next for at least a couple days with most stuff having
spent weeks in there. Nothing really stands out, just small updates all over
the place. Details are in the signed tag.

Please pull,
Bartosz

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.6

for you to fetch changes up to 3d0957b07e27abd3237b1fe0c7f06485ba80852f:

  gpio: pca953x: add support for TCA9538 (2023-08-25 13:16:54 +0200)

----------------------------------------------------------------
gpio updates for v6.6

Core GPIOLIB updates:
- wake-up poll() in user-space on device unbind
- improve fwnode usage
- interrupt domain handling improvements
- correctly handle the ngpios property in gpio-mmio

Driver cleanups:
- remove unneeded calls to platform_set_drvdata() all around the place
- remove unneeded of_match_ptr() expansions whenever a driver depends on
  CONFIG_OF
- remove redundant calls to dev_err_probe() from gpio-omap and gpio-davinci

Driver improvements:
- use autopointers and guards from cleanup.h in gpio-sim
- shrink code in gpio-sim using some common helpers
- convert the idio family of drivers to using gpio-regmap
- convert gpio-ws16c48 to using gpio-regmap
- use devres to simplify code in gpio-pisosr and gpio-mxc
- update gpio-sifive: support IRQ wake, improve interrupt handling, allow
  building as module
- make gpio-ge and gpio-bcm-kona OF-independent (plus some minor tweaks)
- add support for new models in gpio-pca953x and gpio-ds4520
- add runtime PM support to gpio-mxc
- fix a build warning in gpio-mxs
- add support for adding pin ranges to gpio-mlxbf3
- add counter/timer support to gpio-104-dio-48e
- switch to dynamic GPIO base allocation in gpio-vf610
- minor oneliners here and there

Device-tree bindings updates:
- enable the gpio-line-names property in snps,dw-apb and STMPE GPIO
- document new models in fsl-imx-gpio, ds4520 and pca95xx
- convert the bindings for brcm,kona-gpio to YAML

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: gpio: Add gpio-line-names to STMPE GPIO

Alexandru Ardelean (1):
      gpio: 74xx-mmio: remove unneeded platform_set_drvdata() call

Andrei Coardos (16):
      gpio: bcm-kona: remove unneeded platform_set_drvdata() call
      gpio: exar: remove unneeded platform_set_drvdata() call
      gpio: logicvc: remove unneeded platform_set_drvdata() call
      gpio: eic-sprd: remove unneeded platform_set_drvdata() call
      gpio: lp3943: remove unneeded platform_set_drvdata() call
      gpio: max77620: remove unneeded platform_set_drvdata() call
      gpio: palmas: remove unnecessary call to platform_set_drvdata()
      gpio: pmic-eic-sprd: remove unnecessary call to platform_set_drvdata()
      gpio: rc5t583: remove unneeded call to platform_set_drvdata()
      gpio: sama5d2-piobu: remove unneeded call to platform_set_drvdata()
      gpio: sch: remove unneeded call to platform_set_drvdata()
      gpio: syscon: remove unneeded call to platform_set_drvdata()
      gpio: timberdale: remove unneeded call to platform_set_drvdata()
      gpio: tqmx86: remove unneeded call to platform_set_drvdata()
      gpio: vx855: remove unneeded call to platform_set_drvdata()
      gpio: zevio: remove unneeded call to platform_set_drvdata()

Andrew Davis (1):
      gpio: pisosr: Use devm_gpiochip_add_data() to simplify remove path

Andy Shevchenko (16):
      gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
      gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
      gpiolib: Do not alter GPIO chip fwnode member
      gpiolib: Make gpiochip_hierarchy_add_domain() return domain
      gpiolib: Factor out gpiochip_simple_create_domain()
      gpiolib: Do not assign error pointer to the GPIO IRQ chip domain
      gpiolib: Split out gpiochip_irqchip_add_allocated_domain() helper
      gpiolib: Replace open coded gpiochip_irqchip_add_allocated_domain()
      gpio: bcm-kona: Make driver OF-independent
      gpio: bcm-kona: Drop unused pdev member in private data structure
      gpio: ge: Add missing header
      gpio: ge: Fix English spelling and grammar
      gpio: ge: Make driver OF-independent
      gpio: ge: Utilise temporary variable for struct device
      gpio: ge: Replace GPLv2 boilerplate with SPDX
      gpio: ge: Enable COMPILE_TEST for the driver

Asmaa Mnebhi (2):
      gpio: mmio: handle "ngpios" properly in bgpio_init()
      gpio: mlxbf3: Support add_pin_ranges()

Bartosz Golaszewski (15):
      gpiolib: add missing include
      gpio: sim: fix a typo in comment
      gpiolib: order includes alphabetically in gpiolib.h
      gpio: sim: use sysfs_streq() and avoid an strdup()
      gpio: sim: simplify gpio_sim_device_config_live_store()
      gpio: sim: replace memmove() + strstrip() with skip_spaces() + strim()
      gpio: sim: simplify code with cleanup helpers
      gpio: pca9570: fix kerneldoc
      gpiolib: rename the gpio_device notifier
      gpio: cdev: open-code to_gpio_chardev_data()
      gpiolib: add a second blocking notifier to struct gpio_device
      gpio: cdev: wake up chardev poll() on device unbind
      gpio: cdev: wake up linereq poll() on device unbind
      gpio: cdev: wake up lineevent poll() on device unbind
      gpiolib: provide and use gpiod_line_state_notify()

Biju Das (2):
      gpio: pcf857x: Extend match data support for OF tables
      gpio: pca953x: Use i2c_get_match_data()

Geert Uytterhoeven (1):
      gpio: mxc: Improve PM configuration

Haibo Chen (1):
      gpio: vf610: switch to dynamic allocat GPIO base

Krzysztof Kozlowski (3):
      dt-bindings: gpio: snps,dw-apb: allow gpio-line-names
      gpio: mxs: fix Wvoid-pointer-to-enum-cast warning
      gpio: mlxbf3: use capital "OR" for multiple licenses in SPDX

Li Zetao (1):
      gpio: mxc: Use helper function devm_clk_get_optional_enabled()

Liam Beguin (2):
      dt-bindings: gpio: pca95xx: document new tca9538 chip
      gpio: pca953x: add support for TCA9538

Okan Sahin (2):
      dt-bindings: gpio: ds4520: Add ADI DS4520
      gpio: ds4520: Add ADI DS4520 GPIO Expander Support

Peng Fan (1):
      dt-bindings: gpio: fsl-imx-gpio: support i.MX8QM/DXL

Rajeshwar R Shinde (1):
      gpio: imx-scu: Use ARRAY_SIZE for array length

Rob Herring (1):
      gpio: Explicitly include correct DT includes

Ruan Jinjie (3):
      gpio: omap: Remove redundant dev_err_probe() and zero value handle code
      gpio: davinci: Remove redundant dev_err_probe()
      gpio: ftgpio010: Do not check for 0 return after calling platform_get_irq()

Samuel Holland (5):
      gpio: sifive: Support IRQ wake
      gpio: sifive: Directly use the device's fwnode
      gpio: sifive: Look up IRQs only once during probe
      gpio: sifive: Get the parent IRQ's domain from its irq_data
      gpio: sifive: Allow building the driver as a module

Shenwei Wang (2):
      gpio: mxc: add runtime pm support
      gpio: mxc: release the parent IRQ in runtime suspend

Stanislav Jakubek (1):
      dt-bindings: gpio: brcm,kona-gpio: convert to YAML

William Breathitt Gray (7):
      gpio: 104-dio-48e: Add Counter/Timer support
      gpio: idio-16: Migrate to the regmap API
      gpio: 104-idio-16: Migrate to the regmap API
      gpio: pci-idio-16: Migrate to the regmap API
      gpio: idio-16: Remove unused legacy interface
      gpio: pcie-idio-24: Migrate to the regmap API
      gpio: ws16c48: Migrate to the regmap API

Zhu Wang (9):
      gpio: tps65218: remove redundant of_match_ptr()
      gpio: max732x: remove redundant CONFIG_OF and of_match_ptr()
      gpio: altera-a10sr: remove redundant of_match_ptr
      gpio: clps711x: remove redundant of_match_ptr()
      gpio: ixp4xx: remove redundant of_match_ptr()
      gpio: lpc32xx: remove redundant CONFIG_OF and of_match_ptr()
      gpio: max3191x: remove redundant of_match_ptr()
      gpio: raspberrypi-exp: remove redundant of_match_ptr()
      gpio: xra1403: remove redundant of_match_ptr()

 .../devicetree/bindings/gpio/adi,ds4520-gpio.yaml  |  51 ++
 .../devicetree/bindings/gpio/brcm,kona-gpio.txt    |  52 --
 .../devicetree/bindings/gpio/brcm,kona-gpio.yaml   | 100 +++
 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml     |   2 +
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |   1 +
 .../devicetree/bindings/gpio/snps,dw-apb-gpio.yaml |   4 +
 .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    |   4 +
 MAINTAINERS                                        |   2 +-
 drivers/gpio/Kconfig                               |  31 +-
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-104-dio-48e.c                    | 127 +++-
 drivers/gpio/gpio-104-idio-16.c                    | 286 ++-------
 drivers/gpio/gpio-74xx-mmio.c                      |   2 -
 drivers/gpio/gpio-altera-a10sr.c                   |   3 +-
 drivers/gpio/gpio-ath79.c                          |   3 +-
 drivers/gpio/gpio-bcm-kona.c                       |  24 +-
 drivers/gpio/gpio-brcmstb.c                        |   4 +-
 drivers/gpio/gpio-clps711x.c                       |   4 +-
 drivers/gpio/gpio-creg-snps.c                      |   2 +-
 drivers/gpio/gpio-davinci.c                        |   2 +-
 drivers/gpio/gpio-ds4520.c                         |  80 +++
 drivers/gpio/gpio-eic-sprd.c                       |   3 +-
 drivers/gpio/gpio-exar.c                           |   2 -
 drivers/gpio/gpio-ftgpio010.c                      |   4 +-
 drivers/gpio/gpio-ge.c                             |  66 +-
 drivers/gpio/gpio-grgpio.c                         |   2 +-
 drivers/gpio/gpio-hlwd.c                           |   2 +-
 drivers/gpio/gpio-idio-16.c                        | 254 ++++----
 drivers/gpio/gpio-idio-16.h                        |  79 +--
 drivers/gpio/gpio-imx-scu.c                        |   3 +-
 drivers/gpio/gpio-ixp4xx.c                         |   2 +-
 drivers/gpio/gpio-logicvc.c                        |   3 -
 drivers/gpio/gpio-lp3943.c                         |   2 -
 drivers/gpio/gpio-lpc32xx.c                        |   4 +-
 drivers/gpio/gpio-max3191x.c                       |   4 +-
 drivers/gpio/gpio-max732x.c                        |   6 +-
 drivers/gpio/gpio-max77620.c                       |   2 -
 drivers/gpio/gpio-mb86s7x.c                        |   2 +-
 drivers/gpio/gpio-mlxbf3.c                         |  26 +-
 drivers/gpio/gpio-mmio.c                           |   9 +-
 drivers/gpio/gpio-mpc5200.c                        |   2 +-
 drivers/gpio/gpio-mpc8xxx.c                        |   4 +-
 drivers/gpio/gpio-msc313.c                         |   1 -
 drivers/gpio/gpio-mxc.c                            | 118 +++-
 drivers/gpio/gpio-mxs.c                            |   3 +-
 drivers/gpio/gpio-omap.c                           |   8 +-
 drivers/gpio/gpio-palmas.c                         |   2 -
 drivers/gpio/gpio-pca953x.c                        |  20 +-
 drivers/gpio/gpio-pca9570.c                        |   2 +-
 drivers/gpio/gpio-pcf857x.c                        |  29 +-
 drivers/gpio/gpio-pci-idio-16.c                    | 294 ++-------
 drivers/gpio/gpio-pcie-idio-24.c                   | 677 ++++++++-------------
 drivers/gpio/gpio-pisosr.c                         |  28 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |   3 +-
 drivers/gpio/gpio-pxa.c                            |   1 -
 drivers/gpio/gpio-raspberrypi-exp.c                |   4 +-
 drivers/gpio/gpio-rc5t583.c                        |   2 -
 drivers/gpio/gpio-rcar.c                           |   1 -
 drivers/gpio/gpio-rockchip.c                       |   2 +-
 drivers/gpio/gpio-sama5d2-piobu.c                  |   1 -
 drivers/gpio/gpio-sch.c                            |   2 -
 drivers/gpio/gpio-sifive.c                         |  48 +-
 drivers/gpio/gpio-sim.c                            | 285 +++------
 drivers/gpio/gpio-sprd.c                           |   2 +-
 drivers/gpio/gpio-stp-xway.c                       |   3 +-
 drivers/gpio/gpio-syscon.c                         |   3 -
 drivers/gpio/gpio-tegra.c                          |   2 +-
 drivers/gpio/gpio-tegra186.c                       |   2 +-
 drivers/gpio/gpio-timberdale.c                     |   2 -
 drivers/gpio/gpio-tps65218.c                       |   2 +-
 drivers/gpio/gpio-tps6586x.c                       |   2 +-
 drivers/gpio/gpio-tps65910.c                       |   2 +-
 drivers/gpio/gpio-tqmx86.c                         |   2 -
 drivers/gpio/gpio-ts4800.c                         |   3 +-
 drivers/gpio/gpio-ts4900.c                         |   2 +-
 drivers/gpio/gpio-uniphier.c                       |   1 -
 drivers/gpio/gpio-vf610.c                          |   4 +-
 drivers/gpio/gpio-vx855.c                          |   2 -
 drivers/gpio/gpio-wcd934x.c                        |   3 +-
 drivers/gpio/gpio-ws16c48.c                        | 552 ++++++-----------
 drivers/gpio/gpio-xilinx.c                         |   4 +-
 drivers/gpio/gpio-xra1403.c                        |   6 +-
 drivers/gpio/gpio-zevio.c                          |   2 -
 drivers/gpio/gpiolib-acpi.c                        |   2 +-
 drivers/gpio/gpiolib-cdev.c                        | 107 +++-
 drivers/gpio/gpiolib-of.c                          |   6 +-
 drivers/gpio/gpiolib.c                             | 203 +++---
 drivers/gpio/gpiolib.h                             |  20 +-
 88 files changed, 1668 insertions(+), 2068 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.yaml
 create mode 100644 drivers/gpio/gpio-ds4520.c
