Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F679196D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353127AbjIDOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353113AbjIDOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:08:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C617CDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39C59CE0ED4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C230C433CA;
        Mon,  4 Sep 2023 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693836502;
        bh=gd69hIUvGQm5dfh1U9IAJg0R/KjeaMzqKk532gUoF20=;
        h=Date:From:To:Cc:Subject:From;
        b=NBEQyzJ9ptyJT425N7sMBM08vSBJwPslp+X8xh1v3TfKmhm+OQOyOFbSx2f1RsdbL
         E5zf3SbidJ9QVgjICEw3Ic8GU1EXRpeoblcfzOHMuVR8nqwVSJP5h0BAxejTWPhWLg
         HxJDqX+PGYq8ozcUOdE1sjvvxWlwfrZRhDww8/Kyk3ijzer1D7KqeGGb+glGfG1sjA
         o+YXpVd9XVTkFLLj3woVN6CsWo32ddWEWPuVBOHa//unRMX13S2MLzZA3kDYchMl9O
         EHAseDoJhJK3LFCDDemJnHxFtc5d8dih+J1McZIl72dZeg3yDPZeQ12hK3Pdd/bSgr
         vQRfsQb75OqFA==
Date:   Mon, 4 Sep 2023 15:08:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.6
Message-ID: <20230904140818.GB13143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.6

for you to fetch changes up to baca986e1f2c31f8e4b2a6d99d47c3bc844033e8:

  leds: aw2013: Enable pull-up supply for interrupt and I2C (2023-08-18 16:47:21 +0100)

----------------------------------------------------------------
- Core Frameworks
   - Add new framework to support Group Multi-Color (GMC) LEDs
   - Offer an 'optional' API for non-essential LEDs
   - Support obtaining 'max brightness' values from Device Tree
   - Provide new led_classdev member 'color' (settable via DT and SYFS)
   - Stop TTY Trigger from using the old LED_ON constraints
   - Statically allocate leds_class

 - New Drivers
   - Add support for NXP PCA995x I2C Constant Current LED Driver

 - New Device Support
   - Add support for Siemens Simatic IPC BX-21 to Simatic IPC

 - Fix-ups
   - Some dependency / Kconfig tweaking
   - Move final probe() functions back over from .probe_new()
   - Simplify obtaining resources (memory, device data) using unified API helpers
   - Bunch of Device Tree additions, conversions and adaptions
   - Fix trivial styling issues; comments
   - Ensure correct includes are present and remove some that are not required
   - Omit the use of redundant casts and if relevant replace with better ones
   - Use purpose-built APIs for various actions; sysfs_emit(), module_led_trigger()
   - Remove a bunch of superfluous locking

 - Bug Fixes
   - Ensure error codes are correctly propagated back up the call chain
   - Fix incorrect error values from being returned (missing '-')
   - Ensure get'ed resources are put'ed to prevent leaks
   - Use correct class when exporting module resources
   - Fixing rounding (or lack there of) issues
   - Fix 'always false' LED_COLOR_ID_MULTI BUG() check

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: leds: Add gpio-line-names to PCA9532 GPIO

Arnd Bergmann (1):
      leds: simatic-ipc-leds-gpio: Restore LEDS_CLASS dependency

Astrid Rost (2):
      dt-bindings: leds: Read max-brightness from device tree
      led: led-class: Read max-brightness from devicetree

Christophe JAILLET (1):
      leds: ns2: Slightly simplify a memory allocation

Dan Carpenter (2):
      leds: aw200xx: Fix error code in probe()
      leds: pwm: Fix error code in led_pwm_create_fwnode()

Fenglin Wu (3):
      leds: flash: leds-qcom-flash: Declare the driver as a module
      leds: flash: leds-qcom-flash: Turn off LED before setting flash current
      leds: flash: leds-qcom-flash: Put child node if registration failed

Henning Schild (9):
      platform/x86: simatic-ipc: add another model BX-21A
      watchdog: simatic-ipc-wdt: make IO region access of one model muxed
      platform/x86: simatic-ipc: add CMOS battery monitoring
      platform/x86: simatic-ipc: drop PCI runtime depends and header
      platform/x86: simatic-ipc: add another model
      platform/x86: simatic-ipc: add auto-loading of hwmon modules
      platform/x86: simatic-ipc: use extra module loading for watchdog
      leds: simatic-ipc-leds-gpio: Fix comment style in SPDX header
      leds: simatic-ipc-leds-gpio: Add Elkhart Lake version

Isai Gaspar (1):
      leds: pca995x: Add support for PCA995X chips

Ivan Orlov (1):
      leds: Make leds_class a static const structure

Jean-Jacques Hiblot (4):
      leds: Provide devm_of_led_get_optional()
      leds: class: Store the color index in struct led_classdev
      dt-bindings: leds: Add binding for a multicolor group of LEDs
      leds: rgb: Add a multicolor LED driver to group monochromatic LEDs

Jonathan Neuschäfer (1):
      dt-bindings: leds: Fix reference to definition of default-state

Krzysztof Kozlowski (1):
      dt-bindings: leds: rohm,bd71828: Drop select:false

Li Zetao (2):
      leds: trigger: netdev: Use module_led_trigger macro to simplify the code
      leds: uleds: Use module_misc_device macro to simplify the code

Lin, Meng-Bo (1):
      leds: aw2013: Enable pull-up supply for interrupt and I2C

Marek Behún (5):
      leds: multicolor: Use rounded division when calculating color components
      leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false
      leds: trigger: tty: Do not use LED_ON/OFF constants, use led_blink_set_oneshot instead
      leds: turris-omnia: Use sysfs_emit() instead of sprintf()
      leds: turris-omnia: Drop unnecessary mutex locking

Marek Vasut (3):
      dt-bindings: leds: bd2606mvv: Fix maximum register value
      dt-bindings: leds: pca995x: Add binding document for PCA995X chips
      leds: pca995x: Fix MODULE_DEVICE_TABLE for OF

Rafał Miłecki (1):
      leds: bcm63138: Rename dependency symbol ARCH_BCM4908 to ARCH_BCMBCA

Rob Herring (2):
      leds: Explicitly include correct DT includes
      dt-bindings: leds: Convert Panasonic AN30259A to DT schema

Stephan Gerhold (2):
      dt-bindings: leds: aw2013: Document interrupt
      dt-bindings: leds: Document pull-up supply for interrupt and I2C

Uwe Kleine-König (2):
      leds: aw200xx: Switch back to use struct i2c_driver::probe
      leds: qcom-lpg: Drop assignment to struct pwmchip::base

Yangtao Li (1):
      leds: ip30: Convert to devm_platform_ioremap_resource()

Zhu Wang (1):
      leds: Remove redundant of_match_ptr()

 Documentation/ABI/testing/sysfs-class-led          |   9 +
 Documentation/devicetree/bindings/leds/common.yaml |  15 +-
 .../devicetree/bindings/leds/leds-an30259a.txt     |  55 -----
 .../devicetree/bindings/leds/leds-aw2013.yaml      |  13 ++
 .../bindings/leds/leds-group-multicolor.yaml       |  64 ++++++
 .../devicetree/bindings/leds/nxp,pca953x.yaml      |   4 +
 .../devicetree/bindings/leds/nxp,pca995x.yaml      |  81 +++++++
 .../bindings/leds/panasonic,an30259a.yaml          |  84 +++++++
 .../devicetree/bindings/leds/rohm,bd2606mvv.yaml   |   4 +-
 .../bindings/leds/rohm,bd71828-leds.yaml           |   2 -
 drivers/leds/Kconfig                               |   9 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/blink/Kconfig                         |   4 +-
 drivers/leds/flash/Kconfig                         |   2 +
 drivers/leds/flash/leds-qcom-flash.c               |   5 +
 drivers/leds/led-class-multicolor.c                |   8 +-
 drivers/leds/led-class.c                           |  76 +++++--
 drivers/leds/led-core.c                            |   8 +-
 drivers/leds/leds-an30259a.c                       |   2 +-
 drivers/leds/leds-ariel.c                          |   2 +-
 drivers/leds/leds-aw200xx.c                        |   4 +-
 drivers/leds/leds-aw2013.c                         |  38 ++--
 drivers/leds/leds-cpcap.c                          |   2 +-
 drivers/leds/leds-cr0014114.c                      |   2 +-
 drivers/leds/leds-ip30.c                           |   8 +-
 drivers/leds/leds-is31fl32xx.c                     |   1 -
 drivers/leds/leds-lp5521.c                         |   5 +-
 drivers/leds/leds-lp5523.c                         |   4 +-
 drivers/leds/leds-lp5562.c                         |   4 +-
 drivers/leds/leds-lp8501.c                         |   4 +-
 drivers/leds/leds-mlxreg.c                         |   1 -
 drivers/leds/leds-ns2.c                            |   2 +-
 drivers/leds/leds-pca9532.c                        |   1 -
 drivers/leds/leds-pca995x.c                        | 204 +++++++++++++++++
 drivers/leds/leds-pm8058.c                         |   1 -
 drivers/leds/leds-pwm.c                            |   4 +-
 drivers/leds/leds-spi-byte.c                       |   2 +-
 drivers/leds/leds-syscon.c                         |   3 +-
 drivers/leds/leds-ti-lmu-common.c                  |   2 +-
 drivers/leds/leds-tlc591xx.c                       |   1 -
 drivers/leds/leds-turris-omnia.c                   |  13 +-
 drivers/leds/rgb/Kconfig                           |  12 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-group-multicolor.c           | 169 ++++++++++++++
 drivers/leds/rgb/leds-qcom-lpg.c                   |   2 -
 drivers/leds/simple/Kconfig                        |  14 ++
 drivers/leds/simple/Makefile                       |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio-core.c   |   4 +
 .../simple/simatic-ipc-leds-gpio-elkhartlake.c     |  57 +++++
 drivers/leds/simple/simatic-ipc-leds-gpio.h        |   2 +-
 drivers/leds/trigger/ledtrig-netdev.c              |  13 +-
 drivers/leds/trigger/ledtrig-tty.c                 |  12 +-
 drivers/leds/uleds.c                               |  12 +-
 drivers/platform/x86/Kconfig                       |  49 +++-
 drivers/platform/x86/Makefile                      |   6 +-
 drivers/platform/x86/simatic-ipc-batt-apollolake.c |  51 +++++
 .../platform/x86/simatic-ipc-batt-elkhartlake.c    |  51 +++++
 drivers/platform/x86/simatic-ipc-batt-f7188x.c     |  70 ++++++
 drivers/platform/x86/simatic-ipc-batt.c            | 252 +++++++++++++++++++++
 drivers/platform/x86/simatic-ipc-batt.h            |  20 ++
 drivers/platform/x86/simatic-ipc.c                 | 119 ++++++++--
 drivers/watchdog/simatic-ipc-wdt.c                 |   9 +-
 include/linux/leds.h                               |   3 +
 include/linux/platform_data/x86/simatic-ipc-base.h |   4 +-
 include/linux/platform_data/x86/simatic-ipc.h      |   4 +-
 65 files changed, 1487 insertions(+), 204 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-an30259a.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-group-multicolor.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca995x.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/panasonic,an30259a.yaml
 create mode 100644 drivers/leds/leds-pca995x.c
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-elkhartlake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-apollolake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-elkhartlake.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt-f7188x.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.c
 create mode 100644 drivers/platform/x86/simatic-ipc-batt.h

-- 
Lee Jones [李琼斯]
