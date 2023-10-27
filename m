Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1967D9C37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbjJ0Ox0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0OxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:53:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1710E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:53:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f613272so17711465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698418399; x=1699023199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xp/RHDAdIYM2oYESWlQ3i5FwbVZWzzMgSEHazAhWKbs=;
        b=IQk1k/mUHAPWlqJNklWjwb/Ndsb1gIyOnKG5PX0yJLTy8dmo94WgkHsFUy04Ue870/
         N/IqcRt9yr/OGsBuevw/2SH3qmPiVxdgHKP2XE4BVlBdfSPIgJC2rTbglh2WY2UPflMo
         IO4J2UyupQBfhDLOlxQlsJqNaWC0+tSiTA4/YvTVmIJaBOx8r+jigkdMDWJ29H5bZLMC
         vL/TVLoEzGj8lNb7AfrD4xlbUQRYLKpUyrYIXVnVx6XpWEtlboh1DjhnMXJlCdDkG4Cu
         4DNZW+47wKQ+RfvOHeN9vF1iesPhqxlD7uWABPf/8EN9iirTETU1UH1iH3NRPzmGabCP
         Tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418399; x=1699023199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp/RHDAdIYM2oYESWlQ3i5FwbVZWzzMgSEHazAhWKbs=;
        b=jGyL3fo285dI/SAA8EnF7DzDtbkhkVTtgsgMzKsf6xovrSrmj19LENypoOtvb1AR/8
         WmUETvs1NP3YqL5WWjPaAOWMgA78rpkiyppMSyQDyE6X5XLoJNSfI+iulJwPVkvMWKAK
         L0PVDEj3GigNtGqD6VY2cdunLl3K4Ptoy8AzFJDgFGzur0YfICj3CORJHULWubCY+NjX
         /AuEs1Hz+HloqCpctsB3dtk+sTYDfTspiMicDMsM09efkCLz+MQJbVDYWffbrq8hyAro
         TMTzDuu+7SIupih567eedJ5a/0gkPj4SbQUmVZGALGUyr+yn8GMeN0bG+8GWyOXfn6y8
         R9jA==
X-Gm-Message-State: AOJu0YwITy5VRZLrEczlhE2PqmA10cATFsKqHEqSO3vz25V4ZFbKm+43
        Am4H0XTbuxnQakRPAruuwASX4g==
X-Google-Smtp-Source: AGHT+IH47A8qMtCEx7V4WdpCvdNhao7C6i1394vJ9KsTqCPJXt4x0ESR2dZavc8s98ZKm0Sk44RPNg==
X-Received: by 2002:a05:600c:444d:b0:405:3cc5:1105 with SMTP id v13-20020a05600c444d00b004053cc51105mr2463942wmn.8.1698418398615;
        Fri, 27 Oct 2023 07:53:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:da0a:6e9a:7c82:4c9f])
        by smtp.gmail.com with ESMTPSA id t3-20020a1c7703000000b004042dbb8925sm5206504wmi.38.2023.10.27.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:53:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.7-rc1
Date:   Fri, 27 Oct 2023 16:53:09 +0200
Message-Id: <20231027145309.27582-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's is the first pull-request from the GPIO subsystem for this merge window.
It's going to be one of three total, more on that later. I'm sending it ahead
as I'll be off Mon-Thu.

We don't have any new drivers. The loongson driver is getting extended with
support for new models. There's a big refactor of gpio-pca953x and many small
improvements to others.

The GPIO code in the kernel has acquired a lot of cruft over the years as well
as many abusers of the API across the kernel tree. This release cycle we have
started a major cleanup and improvement effort that will most likely span
several releases. We have started by converting external users of struct
gpio_chip to accessing the wrapper around it - struct gpio_device. This is
because the latter is reference counted while the former is removed when the
provider is unbound. We also removed several instances of drivers accessing
private GPIOLIB structures and including the private header from drivers/gpio/.

To that end you'll see several commits aimed at different subsystems (acked by
relevant maintainers) as well as two merges from the x86/platform tree.

We'll then rework the locking in GPIOLIB which currently uses a big spinlock
for many different things and could use becoming more fine-grained, especially
as it doesn't even get the locking right. We'll also use SRCU for protecting
the gpio_chip pointer against in-kernel hot-unplug crashes similar to what we
saw triggered from user-space and fixed with semaphores in gpiolib-cdev. The
core GPIOLIB is still vulnerable to these use-cases. I'm just mentioning the
plans here, this is not part of this PR.

You'll see some new instances of using __free(). We've added a gpio_device_put
cleanup helper similar to the put_device one introduced by Peter Zijlstra and
used it according to the preferred pattern except where it didn't make sense.

All details are in the signed tag.

There's a trivial conflict between this tag and current master that can be
resolved as follows:

diff --cc drivers/gpio/gpio-vf610.c
index 656d6b1dddb5,a89ae84a1fa0..444501c56a3b
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@@ -126,9 -140,7 +140,9 @@@ static int vf610_gpio_direction_output(
  	unsigned long mask = BIT(gpio);
  	u32 val;
  
 +	vf610_gpio_set(chip, gpio, value);
 +
- 	if (port->sdata && port->sdata->have_paddr) {
+ 	if (port->sdata->have_paddr) {
  		val = vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
  		val |= mask;
  		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);

And another one between the GPIO and HTE trees for which the proposed
resolution looks like this:

diff --cc drivers/hte/Kconfig
index 8e0fd818a73e,083e67492bf2..000000000000
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@@ -16,8 -16,7 +16,8 @@@ if HT
  
  config HTE_TEGRA194
  	tristate "NVIDIA Tegra194 HTE Support"
- 	depends on ARCH_TEGRA_194_SOC
+ 	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
 +	depends on GPIOLIB
  	help
  	  Enable this option for integrated hardware timestamping engine also
  	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194

There'll be two more PRs later in the merge window. First will contain ~70
commits that refactor the glue code between GPIO and pinctrl. It introduced
several conflicts between Linus' and my trees so we decided to wait for the
bulk GPIO and pinctrl changes to be in the master branch before sending it
separately. The final PR will remove gpiochip_find() from the tree. This
removal depends on changes in the SPI tree and will be sent once they are
merged as well.

Please pull
Bartosz Golaszewski

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.7-rc1

for you to fetch changes up to 9bc633117d6a8411c6912cb0194b3e0f83ef9d56:

  hte: tegra194: add GPIOLIB dependency (2023-10-23 20:07:36 +0200)

----------------------------------------------------------------
gpio updates for v6.7-rc1

GPIOLIB core:
- provide interfaces allowing users to retrieve, manage and query the
  reference counted GPIO device instead of accessing the private gpio_chip
  structure
- replace gpiochip_find() with gpio_device_find()
- remove unused acpi_get_and_request_gpiod()
- improve the ignore_interrupt functionality in GPIO ACPI
- correct notifier return codes in gpiolib-of
- unexport gpiod_set_transitory() as it's unused outside of core GPIO code
- while there are still external users accessing struct gpio_chip, let's
  make gpiochip_get_desc() public so that they at least use the preferred
  helper
- improve locking for lookup tables
- annotate struct linereq with __counted_by
- improve GPIOLIB docs
- add an OF quirk for LED trigger sources

Driver improvements:
- convert all GPIO drivers with .remove() callbacks to using the new
  variant returning void instead of int
- stop accessing the GPIOLIB private structures in gpio-mockup,
  i2c-mux-gpio, hte-tegra194, gpio-sim
- use the recommended pattern for autofree variables in gpio-sim
- add support for more models to gpio-loongson
- use a notifier chain to notify other blocks about interrupts in
  gpio-eic-sprd instead of looking up GPIO devices on every interrupt
- convert gpio-pca953x and gpio-fx6408 to using the maple tree regmap
  cache
- don't include GPIOLIB internal headers in drivers which don't need them
- move the ingenic NAND quirk into gpiolib-of
- add an ignore interrupt quirk for Peaq C1010
- drop static GPIO base from gpio-omap, gpio-f7188x
- use the preferred device_get_match_data() function in drivers that still
  don't
- refactor gpio-pca953x: switch to using DEFINE_SIMPLE_DEV_PM_OPS(), use
  cleanup helpers, use dev_err_probe() where it makes sense, fully convert
  to using devres and some other minor tweaks

DT bindings:
- add support for a new model to gpio-vf610 and update existing properties
- add support for more loongson models
- add missing support for imx models that are used but undocumented
- convert bindings for Intel IXP4xx to schema

Minor stuff:
- deprecate gpio-mockup in favor of gpio-sim
- include missing headers here and there
- stop using gpiochip_find() in OMAP1 board files
- minor tweaks in gpio-vf610, gpio-hisi
- remove unneeded 'extern' specifiers from headers

----------------------------------------------------------------
Andy Shevchenko (11):
      gpio: pca953x: Drop unused fields in struct pca953x_platform_data
      gpio: pca953x: Fully convert to device managed resources
      gpio: pca953x: Utilise dev_err_probe() where it makes sense
      gpio: pca953x: Split pca953x_restore_context() and pca953x_save_context()
      gpio: pca953x: Simplify code with cleanup helpers
      gpio: pca953x: Utilise temporary variable for struct device
      gpio: pca953x: Utilise temporary variable for struct gpio_chip
      gpio: pca953x: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
      gpio: pca953x: Get rid of useless goto label
      gpio: pca953x: Revisit header inclusions
      gpiolib: provide gpio_device_find_by_fwnode()

Arnd Bergmann (1):
      hte: tegra194: add GPIOLIB dependency

Bartosz Golaszewski (45):
      gpio: mockup: fix kerneldoc
      gpio: mockup: remove unused field
      gpio: mockup: deprecate the old testing module
      gpio: mockup: simplify code by using cleanup helpers
      gpio: mockup: don't access internal GPIOLIB structures
      gpiolib: unexport gpiod_set_transitory()
      gpio: of: correct notifier return codes
      gpiolib: remove stray newline in gpio/driver.h
      gpiolib: remove unnecessary extern specifiers from the driver header
      gpio: xgene-sb: don't include gpiolib.h
      gpio: dwapb: don't include gpiolib.h
      gpio: mb86s7x: don't include gpiolib.h
      gpio: eic-sprd: use atomic notifiers to notify all chips about irqs
      Merge tag 'platform-drivers-x86-ib-x86-android-tablets-v6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into gpio/for-next
      gpio: sim: don't fiddle with GPIOLIB private members
      pinctrl: da9062: add missing include
      gpiolib: make gpiochip_get_desc() public
      pinctrl: da9062: don't include private GPIOLIB header
      gpio: eic-sprd: unregister from the irq notifier on remove()
      gpio: eic-sprd: use a helper variable for &pdev->dev
      gpio: sim: include a missing header
      gpio: sim: initialize a managed pointer when declaring it
      mtd: rawnand: ingenic: move the GPIO quirk to gpiolib-of.c
      gpio: sim: add missing include
      gpiolib: extend the critical sections of lookup tables
      gpiolib: make gpio_device_get() and gpio_device_put() public
      gpiolib: add support for scope-based management to gpio_device
      gpiolib: provide gpio_device_find()
      gpiolib: provide gpio_device_find_by_label()
      gpiolib: provide gpio_device_get_desc()
      gpiolib: reluctantly provide gpio_device_get_chip()
      gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
      gpio: of: replace gpiochip_find_* with gpio_device_find_*
      gpio: acpi: replace gpiochip_find() with gpio_device_find()
      gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
      gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
      arm: omap1: ams-delta: stop using gpiochip_find()
      platform/x86: int3472: Add new skl_int3472_gpiod_get_from_temp_lookup() helper
      Merge tag 'platform-drivers-x86-ib-int3472-v6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into gpio/for-next
      gpio: acpi: remove acpi_get_and_request_gpiod()
      gpiolib: provide gpio_device_to_device()
      gpiolib: provide gpiod_to_gpio_device()
      i2c: mux: gpio: don't fiddle with GPIOLIB internals
      gpiolib: provide gpio_device_get_base()
      hte: tegra194: don't access struct gpio_chip

Devyn Liu (1):
      gpio: hisi: Fix format specifier

Fabio Estevam (1):
      dt-bindings: gpio: fsl-imx-gpio: Document imx25 and imx27

Hans de Goede (11):
      gpiolib: acpi: Check if a GPIO is listed in ignore_interrupt earlier
      gpiolib: acpi: Add a ignore interrupt quirk for Peaq C1010
      platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip from Peaq C1010
      platform/x86: x86-android-tablets: Remove invalid_aei_gpiochip support
      platform/x86: x86-android-tablets: Create a platform_device from module_init()
      platform/x86: x86-android-tablets: Stop using gpiolib private APIs
      platform/x86: x86-android-tablets: Use platform-device as gpio-keys parent
      platform/x86: x86-android-tablets: Drop "linux,power-supply-name" from lenovo_yt3_bq25892_0_props[]
      platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
      platform/x86: int3472: Stop using gpiod_toggle_active_low()
      platform/x86: int3472: Switch to devm_get_gpiod()

Kees Cook (1):
      gpiolib: cdev: annotate struct linereq with __counted_by

Linus Walleij (4):
      gpio: Rewrite IXP4xx GPIO bindings in schema
      gpiolib: of: Allow "trigger-sources" to reference a GPIO
      OMAP/gpio: drop MPUIO static base
      gpio: Further document optional GPIOLIB

Mark Brown (2):
      gpio: pca953x: Convert to use maple tree register cache
      gpio: fx6408: Convert to use maple tree register cache

Peng Fan (6):
      dt-bindings: gpio: vf610: update gpio-ranges
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      gpio: vf610: simplify code by dropping data check
      gpio: vf610: update comment for i.MX8ULP and i.MX93 legacy compatibles

Rob Herring (1):
      gpio: Use device_get_match_data()

Uwe Kleine-König (23):
      gpio: altera: Convert to platform remove callback returning void
      gpio: amdpt: Convert to platform remove callback returning void
      gpio: brcmstb: Convert to platform remove callback returning void
      gpio: cadence: Convert to platform remove callback returning void
      gpio: dln2: Convert to platform remove callback returning void
      gpio: ftgpio010: Convert to platform remove callback returning void
      gpio: grgpio: Convert to platform remove callback returning void
      gpio: ljca: Convert to platform remove callback returning void
      gpio: lpc18xx: Convert to platform remove callback returning void
      gpio: mb86s7x: Convert to platform remove callback returning void
      gpio: mm-lantiq: Convert to platform remove callback returning void
      gpio: mpc5200: Convert to platform remove callback returning void
      gpio: mpc8xxx: Convert to platform remove callback returning void
      gpio: omap: Convert to platform remove callback returning void
      gpio: rcar: Convert to platform remove callback returning void
      gpio: rockchip: Convert to platform remove callback returning void
      gpio: ts5500: Convert to platform remove callback returning void
      gpio: uniphier: Convert to platform remove callback returning void
      gpio: xgene-sb: Convert to platform remove callback returning void
      gpio: xgs-iproc: Convert to platform remove callback returning void
      gpio: xilinx: Convert to platform remove callback returning void
      gpio: zynq: Convert to platform remove callback returning void
      gpio: tb10x: Convert to platform remove callback returning void

Yinbo Zhu (2):
      gpio: dt-bindings: add more loongson gpio chip support
      gpio: loongson: add more gpio chip support

xingtong.wu (1):
      gpio-f7188x: fix base values conflicts with other gpio pins

 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml     |   8 +
 .../devicetree/bindings/gpio/gpio-vf610.yaml       |  40 ++-
 .../devicetree/bindings/gpio/intel,ixp4xx-gpio.txt |  38 ---
 .../bindings/gpio/intel,ixp4xx-gpio.yaml           |  73 +++++
 .../devicetree/bindings/gpio/loongson,ls-gpio.yaml |  21 +-
 Documentation/driver-api/gpio/consumer.rst         |   4 +
 MAINTAINERS                                        |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |  36 ++-
 arch/arm/mach-omap1/board-palmte.c                 |   5 -
 drivers/gpio/Kconfig                               |   4 +-
 drivers/gpio/gpio-altera.c                         |   6 +-
 drivers/gpio/gpio-amdpt.c                          |   6 +-
 drivers/gpio/gpio-brcmstb.c                        |   6 +-
 drivers/gpio/gpio-cadence.c                        |   6 +-
 drivers/gpio/gpio-davinci.c                        |   9 +-
 drivers/gpio/gpio-dln2.c                           |   6 +-
 drivers/gpio/gpio-dwapb.c                          |   1 -
 drivers/gpio/gpio-eic-sprd.c                       |  73 +++--
 drivers/gpio/gpio-f7188x.c                         | 138 ++++-----
 drivers/gpio/gpio-ftgpio010.c                      |   6 +-
 drivers/gpio/gpio-fxl6408.c                        |   2 +-
 drivers/gpio/gpio-grgpio.c                         |   6 +-
 drivers/gpio/gpio-hisi.c                           |   2 +-
 drivers/gpio/gpio-ljca.c                           |   5 +-
 drivers/gpio/gpio-loongson-64bit.c                 | 119 +++++++-
 drivers/gpio/gpio-lpc18xx.c                        |   6 +-
 drivers/gpio/gpio-mb86s7x.c                        |   7 +-
 drivers/gpio/gpio-mm-lantiq.c                      |   6 +-
 drivers/gpio/gpio-mmio.c                           |   4 +-
 drivers/gpio/gpio-mockup.c                         |  88 +++---
 drivers/gpio/gpio-mpc5200.c                        |   8 +-
 drivers/gpio/gpio-mpc8xxx.c                        |   6 +-
 drivers/gpio/gpio-mvebu.c                          |  10 +-
 drivers/gpio/gpio-omap.c                           |   9 +-
 drivers/gpio/gpio-pca953x.c                        | 307 +++++++++------------
 drivers/gpio/gpio-rcar.c                           |   5 +-
 drivers/gpio/gpio-rockchip.c                       |   6 +-
 drivers/gpio/gpio-sim.c                            |  76 +++--
 drivers/gpio/gpio-tb10x.c                          |   6 +-
 drivers/gpio/gpio-ts5500.c                         |   6 +-
 drivers/gpio/gpio-uniphier.c                       |   6 +-
 drivers/gpio/gpio-vf610.c                          |  56 +++-
 drivers/gpio/gpio-xgene-sb.c                       |   7 +-
 drivers/gpio/gpio-xgs-iproc.c                      |   6 +-
 drivers/gpio/gpio-xilinx.c                         |   6 +-
 drivers/gpio/gpio-zynq.c                           |   5 +-
 drivers/gpio/gpiolib-acpi.c                        |  70 +++--
 drivers/gpio/gpiolib-cdev.c                        |   4 +-
 drivers/gpio/gpiolib-of.c                          |  86 ++++--
 drivers/gpio/gpiolib-swnode.c                      |  33 ++-
 drivers/gpio/gpiolib-sysfs.c                       |   2 +-
 drivers/gpio/gpiolib.c                             | 304 ++++++++++++++++----
 drivers/gpio/gpiolib.h                             |  14 +-
 drivers/hte/Kconfig                                |   1 +
 drivers/hte/hte-tegra194.c                         |  30 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  12 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c    |  12 -
 drivers/pinctrl/pinctrl-da9062.c                   |   7 +-
 .../platform/x86/intel/int3472/clk_and_regulator.c |  54 +---
 drivers/platform/x86/intel/int3472/common.h        |   7 +-
 drivers/platform/x86/intel/int3472/discrete.c      | 101 +++++--
 drivers/platform/x86/intel/int3472/led.c           |  24 +-
 drivers/platform/x86/x86-android-tablets/asus.c    |   1 +
 drivers/platform/x86/x86-android-tablets/core.c    | 117 ++++----
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  29 +-
 drivers/platform/x86/x86-android-tablets/other.c   |  11 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   7 +-
 include/linux/gpio/consumer.h                      |  16 --
 include/linux/gpio/driver.h                        |  47 +++-
 include/linux/platform_data/gpio-omap.h            |   3 -
 include/linux/platform_data/pca953x.h              |  13 -
 71 files changed, 1336 insertions(+), 927 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/intel,ixp4xx-gpio.yaml
