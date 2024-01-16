Return-Path: <linux-kernel+bounces-27584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E482F283
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E5F1F2479C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3561C6B6;
	Tue, 16 Jan 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxq9KwMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B71C698
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82E4C433F1;
	Tue, 16 Jan 2024 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423199;
	bh=SR2A1f8PnP1PWjPzOmsU5oBG3dc0Ul/izztt0Tjo0bw=;
	h=Date:From:To:Cc:Subject:From;
	b=kxq9KwMakTXEW2VBm85etfBs8rzAgVE0xyHNoccEVOFO68j/Q8ZpZ8Sx9irLzM9MC
	 5VLmNTbpOEWR5WKiPL4HJ3sqEnhPU87MUVdM/YvY7pUGt+UamrvThSZjTbiNhfxD7k
	 NGMpl6Ql8DKvOwGP+5gygb0S0HW6osZciZuyIg2qSGfhizOiLpUZloKnhaGbSpWg3B
	 VSe3gzT1GK5HLsObYqbQ6vpKqZWQrsQbtyIahRN0E0UGiOiKsI32gqfNGw0/CWtLZG
	 nUsV9lQamt9UHlQNPNjMrGiJTw0FbR2a3k599x9I4pQlcbVi3qwhPALtSEw2bMPUBP
	 mw9Cy8MFXSmsQ==
Date: Tue, 16 Jan 2024 16:39:55 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.8
Message-ID: <20240116163955.GK1920897@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.8

for you to fetch changes up to 4289e434c46c8cbd32cf8b67fa7689b3d2ca4361:

  leds: trigger: netdev: Add core support for hw not supporting fallback to LED sw control (2023-12-21 16:25:21 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Allwinner A100 RGB LED controller
   - Add support for Maxim 5970 Dual Hot-swap controller

 - New Device Support
   - Add support for AW20108 to Awinic LED driver

 - New Functionality
   - Extend support for Net speeds to include; 2.5G, 5G and 10G
   - Allow tx/rx and cts/dsr/dcd/rng TTY LEDS to be turned on and off via sysfs if required
   - Add support for hardware control in AW200xx

 - Fix-ups
   - Use safer methods for string handling
   - Improve error handling; return proper error values, simplify, avoid duplicates, etc
   - Replace Mutex use with the Completion mechanism
   - Fix include lists; alphabetise, remove unused, explicitly add used
   - Use generic platform device properties
   - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations
   - Device Tree binding adaptions/conversions/creation
   - Continue work to remove superfluous platform .remove() call-backs
   - Remove superfluous/defunct code
   - Trivial; whitespace, unused variables, spelling, clean-ups, etc
   - Avoid unnecessary duplicate locks

 - Bug Fixes
   - Repair Kconfig based dependency lists
   - Ensure unused dynamically allocated data is freed after use
   - Fix support for brightness control
   - Add missing sufficient delays during reset to ensure correct operation
   - Avoid division-by-zero issues

----------------------------------------------------------------
Andrew Davis (2):
      leds: tca6507: Use devm_gpiochip_add_data() to simplify remove path
      leds: tca6507: Use devm_led_classdev_register() to simplify remove path

Andy Shevchenko (9):
      leds: trigger: gpio: Replace custom code for gpiod_get_optional()
      leds: trigger: gpio: Convert to use kstrtox()
      leds: trigger: gpio: Use sysfs_emit() to instead of s*printf()
      leds: trigger: gpio: Convert to DEVICE_ATTR_RW()
      leds: max5970: Remove unused variable
      leds: max5970: Make use of device properties
      leds: max5970: Make use of dev_err_probe()
      leds: max5970: Add missing headers
      leds: sun50i-a100: Convert to be agnostic to property provider

Arnd Bergmann (1):
      leds: sun50i-a100: Avoid division-by-zero warning

Dang Huynh (1):
      leds: aw2013: Select missing dependency REGMAP_I2C

Daniel Golle (2):
      leds: trigger: netdev: Extend speeds up to 10G
      docs: ABI: sysfs-class-led-trigger-netdev: Add new modes and entry

Dmitry Rokosov (3):
      leds: aw200xx: Support HWEN hardware control
      dt-bindings: leds: aw200xx: Introduce optional enable-gpios property
      dt-bindings: leds: aw200xx: Fix led pattern and add reg constraints

Florian Eckert (5):
      leds: ledtrig-tty: Free allocated ttyname buffer on deactivate
      tty: add new helper function tty_get_tiocm
      leds: ledtrig-tty: Replace mutex with completion
      leds: ledtrig-tty: Make rx tx activitate configurable
      leds: ledtrig-tty: Add additional line state evaluation

George Stark (7):
      leds: aw200xx: Calculate dts property display_rows in the driver
      dt-bindings: leds: aw200xx: Remove property "awinic,display-rows"
      leds: aw200xx: Add delay after software reset
      leds: aw200xx: Enable disable_locking flag in regmap config
      leds: aw200xx: Improve autodim calculation method
      leds: aw200xx: Add support for aw20108 device
      dt-bindings: leds: awinic,aw200xx: Add AW20108 device

Heiner Kallweit (3):
      leds: trigger: Remove unused function led_trigger_rename_static()
      leds: trigger: panic: Don't register panic notifier if creating the trigger failed
      leds: trigger: netdev: Add core support for hw not supporting fallback to LED sw control

Jean Delvare (1):
      leds: rgb: Drop obsolete dependency on COMPILE_TEST

Johan Hovold (1):
      dt-bindings: leds: qcom,spmi-flash-led: Fix example node name

Martin Kurbanov (1):
      leds: aw200xx: Fix write to DIM parameter

Patrick Rudolph (1):
      leds: max5970: Add support for max5970

Rob Herring (2):
      leds: syscon: Support 'reg' in addition to 'offset' for register address
      dt-bindings: leds: Fix JSON pointer in max-brightness

Samuel Holland (2):
      dt-bindings: leds: Add Allwinner A100 LED controller
      leds: sun50i-a100: New driver for the A100 LED controller

Stefan Wahren (1):
      leds: gpio: Add kernel log if devm_fwnode_gpiod_get() fails

Uwe Kleine-König (3):
      leds: qcom-lpg: Use devm_pwmchip_add() simplifying driver removal
      leds: qcom-lpg: Consistenly use dev_err_probe() in .probe()'s error path
      leds: qcom-lpg: Introduce a wrapper for getting driver data from a pwm chip

 .../ABI/testing/sysfs-class-led-trigger-netdev     |  39 ++
 .../ABI/testing/sysfs-class-led-trigger-tty        |  56 ++
 .../bindings/leds/allwinner,sun50i-a100-ledc.yaml  | 137 +++++
 .../devicetree/bindings/leds/awinic,aw200xx.yaml   |  95 +++-
 Documentation/devicetree/bindings/leds/common.yaml |   2 +-
 .../bindings/leds/qcom,spmi-flash-led.yaml         |   4 +-
 drivers/leds/Kconfig                               |  35 +-
 drivers/leds/Makefile                              |   2 +
 drivers/leds/led-triggers.c                        |  13 -
 drivers/leds/leds-aw200xx.c                        |  98 +++-
 drivers/leds/leds-gpio.c                           |   2 +
 drivers/leds/leds-max5970.c                        | 111 ++++
 drivers/leds/leds-sun50i-a100.c                    | 584 +++++++++++++++++++++
 drivers/leds/leds-syscon.c                         |   3 +-
 drivers/leds/leds-tca6507.c                        |  30 +-
 drivers/leds/rgb/Kconfig                           |   2 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |  63 +--
 drivers/leds/trigger/ledtrig-gpio.c                |  26 +-
 drivers/leds/trigger/ledtrig-netdev.c              |  47 +-
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/leds/trigger/ledtrig-tty.c                 | 247 +++++++--
 drivers/tty/tty_io.c                               |  28 +-
 include/linux/leds.h                               |  20 +-
 include/linux/tty.h                                |   1 +
 24 files changed, 1449 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
 create mode 100644 drivers/leds/leds-max5970.c
 create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
Lee Jones [李琼斯]

