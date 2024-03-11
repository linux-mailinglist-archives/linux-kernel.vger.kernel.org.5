Return-Path: <linux-kernel+bounces-98697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A213877E14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F5A281BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106C29424;
	Mon, 11 Mar 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="08+ZdKJm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2336AE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152752; cv=none; b=WRwtXV+HlU+qjoNjNot3I5xR0kP1Pn1XXKrIHgw7UPZ7cUFhf90TDNRBB7m0faog322zXQxWAgH3D/v2kdp6CcnfjnGFJPCrLOQOb2Be8nBRaDOjMmFogJ4lh8vlewdFuNZBPHK1j8HvumBmT9nzEHRzFA68R4iAAMcfaeHweYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152752; c=relaxed/simple;
	bh=NKzQRpYd4XsmvL2/Mc+3+s+am7PEJYTvX9SlwrmK5qg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6ic+q1K8eyQ/zNKf8HiGWJo5IGWm1gvhL2mIkrIZLBuUGMef2cn0ebunFV3Zgq0mBjihnYRdmDQIdiGK3+GqIyzSVLT/y3Pywq2CrBQHjHbBImUOUOYh8e18UupmrYmnRmwc1k4oggnc4wGFUxC/WwkLiEH7j1QQO6ymmjry3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=08+ZdKJm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso43872181fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1710152748; x=1710757548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJBTtKCFZFU1NgQg6omumaVOxiH+NOomPpdqjSCzYok=;
        b=08+ZdKJmz5bMz11apYUYp05N4hXwz74FLbtG+JvgRj5GBXXVhcanmi3WqfhM8IVPMs
         Doh6127bvhvrvFSFLiyPBVCXg4B6fpfgUxxw2LNDv7fONIGJUKueiZr811Tvk91yial/
         lCpsz81hd9rFXjFQwJdh3zHcdxRLBo7WUdEnNf4C3QfD1jQCFWob1UO0OYoP6j+oSy+H
         JNj56buhfDOYpumQ7vm3bdqbZKDDRebEG8jbzkL4r5optFPYhc3LkkJ9OO5dAqk13z9A
         YjdCRQaegItCkEO0W0M5q020K0UKmLhQnrIvX2ybLt3EyqOXG0/3TW/BsFd6qf35R6e0
         6zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710152748; x=1710757548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJBTtKCFZFU1NgQg6omumaVOxiH+NOomPpdqjSCzYok=;
        b=g1OG+ybHJaMrBDFpbW+18/Kz2/OOyJZenPs02MMVWg6P7xdJ4LMhLyi+yAy+CxJjnh
         yaLGpniVsxb6p7exofyH/QVim1i2Ar34717UjRFEMbpBtwzpavg0/RWlPL1spPgNdwd0
         9DCNff6Vv641ebPM0/2NsI1yJGntpi7WPwM65q2DSmhUnZtWuIQtfFYm5ZwWqZ7z61ZH
         cr40uCsIeliPgCmQrZ0CJ0pA2TQGQy/jNkkRUX+ocLkZafyv/SMC7z+1TQM0kHErx4H7
         tiuReRbRJgdQHCQLQ6btHnUneuwQwFml6LmZUyfxWwEz5axxTB8SpoECNmJGDvWnuoib
         yz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfK7DcEzM9jX0p765FKktwrvBYCCKSproaNgqjHcJJlNhYxQCK3rqC07XO2bw9BGWTNL4weafcI4Ebh0HUW9t33Qyg5MNq7y5IL1D2
X-Gm-Message-State: AOJu0YwzjV07xZcWPKXWeEEc9Qu74MMK2HtAfDVmSnwgGemVyxCpxeT1
	mEEjjdMR68J4mRiBo363M/TyZgwTPKsrQyMwSJyfy9auRAVsHkJXvecKTUR+zsk=
X-Google-Smtp-Source: AGHT+IEN4DzMt+hN/BTodnnBDvq4gQz+Z7F64Wx10GhszAqLMkMxjOWbFnu3A/SAaErMTfaOjvxdoQ==
X-Received: by 2002:a2e:81c5:0:b0:2d2:ebc4:a75 with SMTP id s5-20020a2e81c5000000b002d2ebc40a75mr3629236ljg.5.1710152748174;
        Mon, 11 Mar 2024 03:25:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2647:282c:79b0:93ed])
        by smtp.gmail.com with ESMTPSA id fm9-20020a05600c0c0900b004132a34824dsm2863043wmb.41.2024.03.11.03.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:25:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.9-rc1
Date: Mon, 11 Mar 2024 11:25:45 +0100
Message-Id: <20240311102545.21177-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the main (and most likely the only) pull-request from the GPIO subsystem
for the next release.

The biggest feature is the locking overhaul. Up until now the synchronization
in the GPIO subsystem was broken. There was a single spinlock "protecting"
multiple data structures but doing it wrong (as evidenced by several places
where it would be released when a sleeping function was called and then
reacquired without checking the protected state).

We tried to use an RW semaphore before but the main issue with GPIO is that
we have drivers implementing the interfaces in both sleeping and non-sleeping
ways as well as user-facing interfaces that can be called both from process as
well as atomic contexts. Both ends converge in the same code paths that can use
neither spinlocks nor mutexes. The only reasonable way out is to use SRCU and
go mostly lockless. To that end: we add several SRCU structs in relevant places
and use them to assure consistency between API calls together with atomic reads
and writes of GPIO descriptor flags where it makes sense.

This code has spent several weeks in next and has received several fixes in the
first week or two after which it stabilized nicely. The GPIO subsystem is now
resilient to providers being suddenly unbound. We managed to also remove the
existing character device RW semaphore and the obsolete global spinlock.

Other than the locking rework we have one new driver (for Chromebook EC), much
appreciated documentation improvements from Kent and the regular driver
improvements, DT-bindings updates and GPIOLIB core tweaks.

Details are in the signed tag. Please pull.

Best regards,
Bartosz Golaszewski

The following changes since commit 90d35da658da8cff0d4ecbb5113f5fac9d00eb72:

  Linux 6.8-rc7 (2024-03-03 13:02:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.9-rc1

for you to fetch changes up to 8636f19c2d1f8199b27b4559d9caa115b3011f06:

  gpio: sysfs: repair export returning -EPERM on 1st attempt (2024-03-08 10:32:00 +0100)

----------------------------------------------------------------
gpio updates for v6.9

Serialization rework:
- use SRCU to serialize access to the global GPIO device list, to GPIO device
  structs themselves and to GPIO descriptors
- make the GPIO subsystem resilient to the GPIO providers being unbound while
  the API calls are in progress
- don't dereference the SRCU-protected chip pointer if the information we need
  can be obtained from the GPIO device structure
- move some of the information contained in struct gpio_chip to struct
  gpio_device to further reduce the need to dereference the former
- pass the GPIO device struct instead of the GPIO chip to sysfs callback to,
  again, reduce the need for accessing the latter
- get GPIO descriptors from the GPIO device, not from the chip for the same
  reason
- allow for mostly lockless operation of the GPIO driver API: assure
  consistency with SRCU and atomic operations
- remove the global GPIO spinlock
- remove the character device RW semaphore

Core GPIOLIB:
- constify pointers in GPIO API where applicable
- unify the GPIO counting APIs for ACPI and OF
- provide a macro for iterating over all GPIOs, not only the ones that are
  requested
- remove leftover typedefs
- pass the consumer device to GPIO core in devm_fwnode_gpiod_get_index() for
  improved logging
- constify the GPIO bus type
- don't warn about removing GPIO chips with descriptors still held by users as
  we can now handle this situation gracefully
- remove unused logging helpers
- unexport functions that are only used internally in the GPIO subsystem
- set the device type (assign the relevant struct device_type) for GPIO devices

New drivers:
- add the ChromeOS EC GPIO driver

Driver improvements:
- allow building gpio-vf610 with COMPILE_TEST as well as disabling it in
  menuconfig (before it was always built for i.MX cofigs)
- count the number of EICs using the device properties instead of hard-coding
  it in gpio-eic-sprd
- improve the device naming, extend the debugfs output and add lockdep asserts
  to gpio-sim

DT bindings:
- document the 'label' property for gpio-pca9570
- convert aspeed,ast2400-gpio bindings to DT schema
- disallow unevaluated properties for gpio-mvebu
- document a new model in renesas,rcar-gpio

Documentation:
- improve the character device kerneldocs in user-space headers
- add proper documentation for the character device uAPI (both v1 and v2)
- move the sysfs and gpio-mockup docs into the "obsolete" section
- improve naming consistency for GPIO terms
- clarify the line values description for sysfs
- minor docs improvements
- improve the driver API contract for setting GPIO direction
- mark unsafe APIs as deprecated in kerneldocs and suggest replacements

Other:
- remove an obsolete test from selftests

----------------------------------------------------------------
Alexander Sverdlin (1):
      gpio: sysfs: repair export returning -EPERM on 1st attempt

Andrew Jeffery (1):
      dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema

Andy Shevchenko (3):
      gpio: of: Make of_gpio_get_count() take firmware node as a parameter
      gpio: acpi: Make acpi_gpio_count() take firmware node as a parameter
      gpiolib: Deduplicate cleanup for-loop in gpiochip_add_data_with_key()

Bartosz Golaszewski (43):
      gpio: legacy: mark old interfaces as deprecated in kernel docs
      gpio: cdev: remove leftover function pointer typedefs
      gpio: unexport GPIO irq domain functions only used internally
      gpio: improve the API contract for setting direction
      gpio: set device type for GPIO chips
      Merge tag 'v6.8-rc4' into gpio/for-next
      gpio: protect the list of GPIO devices with SRCU
      gpio: of: assign and read the hog pointer atomically
      gpio: remove unused logging helpers
      gpio: provide and use gpiod_get_label()
      gpio: don't set label from irq helpers
      gpio: add SRCU infrastructure to struct gpio_desc
      gpio: protect the descriptor label with SRCU
      gpio: sysfs: use gpio_device_find() to iterate over existing devices
      gpio: remove gpio_lock
      gpio: reinforce desc->flags handling
      gpio: remove unneeded code from gpio_device_get_desc()
      gpio: sysfs: extend the critical section for unregistering sysfs devices
      gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
      gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
      gpio: cdev: don't access gdev->chip if it's not needed
      gpio: sysfs: don't access gdev->chip if it's not needed
      gpio: don't dereference gdev->chip in gpiochip_setup_dev()
      gpio: reduce the functionality of validate_desc()
      gpio: remove unnecessary checks from gpiod_to_chip()
      gpio: add the can_sleep flag to struct gpio_device
      gpio: add SRCU infrastructure to struct gpio_device
      gpio: protect the pointer to gpio_chip in gpio_device with SRCU
      gpio: remove the RW semaphore from the GPIO device
      gpio: mark unsafe gpio_chip manipulators as deprecated
      gpio: initialize descriptor SRCU structure before adding OF-based chips
      gpio: take the SRCU read lock in gpiod_hog()
      gpio: cdev: use correct pointer accessors with SRCU
      gpio: use srcu_dereference() with SRCU-protected pointers
      gpio: don't let lockdep complain about inherently dangerous RCU usage
      gpio: sysfs: fix inverted pointer logic
      gpio: cdev: fix a NULL-pointer dereference with DEBUG enabled
      gpio: sim: add lockdep asserts
      gpio: sim: delimit the fwnode name with a ":" when generating labels
      gpio: don't warn about removing GPIO chips with active users anymore
      gpio: provide for_each_hwgpio()
      gpio: sim: use for_each_hwgpio()
      Merge tag 'v6.8-rc7' into gpio/for-next

Geert Uytterhoeven (1):
      dt-bindings: gpio: renesas,rcar-gpio: Add r8a779h0 support

Kent Gibson (20):
      gpio: uapi: improve description of fd fields
      gpio: uapi: clarify hte references
      gpio: uapi: drop trailing period from one sentence descriptions
      gpio: uapi: document possible values of gpioevent_data.id
      gpio: uapi: clarify using v2 rather than v1
      Documentation: gpio: add chardev userspace API documentation
      Documentation: ABI: update gpio-cdev to reference chardev.rst
      Documentation: ABI: update sysfs-gpio to reference gpio-cdev
      Documentation: gpio: move sysfs into an obsolete section
      Documentation: gpio: update sysfs documentation to reference new chardev doc
      Documentation: gpio: add chardev v1 userspace API documentation
      Documentation: gpio: capitalize GPIO in index title
      Documentation: gpio: document gpio-mockup as obsoleted by gpio-sim
      Documentation: gpio: move gpio-mockup into obsolete section
      MAINTAINERS: add Documentation/userspace-api/gpio/ to GPIO UAPI section
      Documentation: gpio: describe uAPI behaviour for unsupported config
      Documentation: gpio: clarify sysfs line values are logical
      Documentation: gpio: consistently use logical line value terminology
      gpio: uapi: clarify default_values being logical
      selftest: gpio: remove obsolete gpio-mockup test

Krzysztof Kozlowski (3):
      gpio: constify opaque pointer in gpio_device_find() match function
      gpio: constify opaque pointer "data" in gpio_device_find()
      gpio: constify of_phandle_args in of_find_gpio_device_by_xlate()

Martin Kaiser (2):
      gpio: vf610: allow disabling the vf610 driver
      gpio: vf610: enable COMPILE_TEST

Michal Simek (1):
      dt-bindings: gpio: pca9570: Add label property

Ricardo B. Marliere (1):
      gpio: gpiolib: make gpio_bus_type const

Rob Herring (1):
      dt-bindings: gpio: mvebu: Fix "unevaluatedProperties" to be false

Stephen Boyd (2):
      gpio: Add ChromeOS EC GPIO driver
      gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()

Wenhua Lin (1):
      gpio: eic-sprd: Optimize the calculation method of eic number

Xiaolei Wang (1):
      gpio: fix memory leak in gpiod_request_commit()

 Documentation/ABI/obsolete/sysfs-gpio              |   4 +-
 Documentation/ABI/testing/gpio-cdev                |   9 +-
 Documentation/admin-guide/gpio/gpio-mockup.rst     |   8 +
 Documentation/admin-guide/gpio/index.rst           |   6 +-
 Documentation/admin-guide/gpio/obsolete.rst        |  13 +
 .../bindings/gpio/aspeed,ast2400-gpio.yaml         | 148 ++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt       |  39 -
 .../devicetree/bindings/gpio/gpio-mvebu.yaml       |   2 +-
 .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   3 +
 .../bindings/gpio/renesas,rcar-gpio.yaml           |   1 +
 Documentation/driver-api/gpio/consumer.rst         |  10 +-
 Documentation/userspace-api/gpio/chardev.rst       | 116 +++
 Documentation/userspace-api/gpio/chardev_v1.rst    | 131 +++
 Documentation/userspace-api/gpio/error-codes.rst   |  79 ++
 .../userspace-api/gpio/gpio-get-chipinfo-ioctl.rst |  41 +
 .../gpio/gpio-get-lineevent-ioctl.rst              |  84 ++
 .../gpio/gpio-get-linehandle-ioctl.rst             | 125 +++
 .../userspace-api/gpio/gpio-get-lineinfo-ioctl.rst |  54 ++
 .../gpio/gpio-get-lineinfo-unwatch-ioctl.rst       |  49 ++
 .../gpio/gpio-get-lineinfo-watch-ioctl.rst         |  74 ++
 .../gpio/gpio-handle-get-line-values-ioctl.rst     |  56 ++
 .../gpio/gpio-handle-set-config-ioctl.rst          |  63 ++
 .../gpio/gpio-handle-set-line-values-ioctl.rst     |  48 +
 .../gpio/gpio-lineevent-data-read.rst              |  84 ++
 .../gpio/gpio-lineinfo-changed-read.rst            |  87 ++
 .../userspace-api/gpio/gpio-v2-get-line-ioctl.rst  | 152 ++++
 .../gpio/gpio-v2-get-lineinfo-ioctl.rst            |  50 ++
 .../gpio/gpio-v2-get-lineinfo-watch-ioctl.rst      |  67 ++
 .../userspace-api/gpio/gpio-v2-line-event-read.rst |  83 ++
 .../gpio/gpio-v2-line-get-values-ioctl.rst         |  51 ++
 .../gpio/gpio-v2-line-set-config-ioctl.rst         |  58 ++
 .../gpio/gpio-v2-line-set-values-ioctl.rst         |  47 +
 .../gpio/gpio-v2-lineinfo-changed-read.rst         |  81 ++
 Documentation/userspace-api/gpio/index.rst         |  18 +
 Documentation/userspace-api/gpio/obsolete.rst      |  11 +
 .../{admin-guide => userspace-api}/gpio/sysfs.rst  |  31 +-
 Documentation/userspace-api/index.rst              |   1 +
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |  15 +-
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-cros-ec.c                        | 209 +++++
 drivers/gpio/gpio-eic-sprd.c                       |  10 +-
 drivers/gpio/gpio-sim.c                            |  49 +-
 drivers/gpio/gpiolib-acpi.c                        |  15 +-
 drivers/gpio/gpiolib-acpi.h                        |   5 +-
 drivers/gpio/gpiolib-cdev.c                        |  96 +-
 drivers/gpio/gpiolib-devres.c                      |   2 +-
 drivers/gpio/gpiolib-legacy.c                      |  12 +
 drivers/gpio/gpiolib-of.c                          |  29 +-
 drivers/gpio/gpiolib-of.h                          |   6 +-
 drivers/gpio/gpiolib-sysfs.c                       | 152 ++--
 drivers/gpio/gpiolib.c                             | 973 +++++++++++----------
 drivers/gpio/gpiolib.h                             |  95 +-
 include/linux/gpio/driver.h                        |  42 +-
 include/uapi/linux/gpio.h                          |  63 +-
 tools/testing/selftests/gpio/gpio-mockup.sh        |   9 +-
 56 files changed, 2995 insertions(+), 773 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/obsolete.rst
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
 create mode 100644 Documentation/userspace-api/gpio/chardev.rst
 create mode 100644 Documentation/userspace-api/gpio/chardev_v1.rst
 create mode 100644 Documentation/userspace-api/gpio/error-codes.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/index.rst
 create mode 100644 Documentation/userspace-api/gpio/obsolete.rst
 rename Documentation/{admin-guide => userspace-api}/gpio/sysfs.rst (87%)
 create mode 100644 drivers/gpio/gpio-cros-ec.c

