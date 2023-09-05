Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B4792E12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjIETAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbjIES75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:59:57 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF091A3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 11:59:27 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so28185155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940006; x=1694544806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm8uw+f5LvxPs16TrhkfvENCN1+QZz7s8rxXSoottC8=;
        b=A7UpjwfdbJKhRaEWbwhKYlgzouLcNfgEEMmEJ1LGo0vRVMyAmNFuvr77wNzIKJfI8A
         zATRShOgFPIRzZgChhys5vhQQ6/NndEmYZB19RGfcA6IH8d+RHmmb3PjJv/Vd7uscdtS
         /iYAui9lJcOUzAxnsPdv1HoW7GouEnyuVIv3Xr5japB+GUySazZG+e90Wncqu0qqFCuG
         YAqfDT5o9OIe4ZIq8Y0nvq4hYPQ2RN8KLeoTK7UbAgIk5RXAaszQ6WgQ6mB/yHCcKV/x
         GU55rAldx9EQL3hDnxRWafrWv5RlgA2nQUWKMcL22gdkjxqPrRDnQuOp0U3iixUJnxAn
         qEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940006; x=1694544806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zm8uw+f5LvxPs16TrhkfvENCN1+QZz7s8rxXSoottC8=;
        b=C7z2IRUGNs1NuEcIqU+Q1bhHQVcHmh3S8afZGixZej4nVwLL0qYQIBLDuaM71GpVQ8
         gLDum/g/ceelVAeNpNdjSfM8YnXHmlT1bBX7qoidUF+fH3WLj0UVdP+nONStPth7o5bx
         4idK7RpYPu7pUDtVlHPDy3A3UukOdLNE4ldwvETBEzJhCSVuH+MzMWD8IqbDmBD6cak6
         i5gChYgwTvtom2wgWsgrfxo8sKusTJTzKglBhhcCl8FrsNOWnma7cnU2teZ2jsuLJSni
         G0DT3rorUpTK5QXXoy6BLcZ9d4lsB3amErklHEVVeak5Z+P39hoD2DMMwH1dUc9dJS20
         uw1g==
X-Gm-Message-State: AOJu0YxbLISSow6RF0xjoJ2HLii3Hjh5HStpjhHq872uwoZ1Z3o8nzxP
        bftVcO0e1dogPYP9r3XosE8rpA==
X-Google-Smtp-Source: AGHT+IFg7Vm2Cmqv15Sqv5calroUVFxizFJ5aDOZ0cNR6d+rt5FAt8Ucbl9e61HcahWOBMsw3jlYSQ==
X-Received: by 2002:a7b:cb8a:0:b0:401:bf62:9456 with SMTP id m10-20020a7bcb8a000000b00401bf629456mr490236wmi.8.1693940006065;
        Tue, 05 Sep 2023 11:53:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/21] gpio: convert users to gpio_device_find() and remove gpiochip_find()
Date:   Tue,  5 Sep 2023 20:52:48 +0200
Message-Id: <20230905185309.131295-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The GPIO subsystem does not handle hot-unplug events very well. We have
recently patched the user-space part of it so that at least a rouge user
cannot crash the kernel but in-kernel users are still affected by a lot of
issues: from incorrect locking or lack thereof to using structures that are
private to GPIO drivers. Since almost all GPIO controllers can be unbound,
not to mention that we have USB devices registering GPIO expanders as well as
I2C-on-USB HID devices on which I2C GPIO expanders can live, various media
gadgets etc., we really need to make GPIO hotplug/unplug friendly.

Before we can even get to fixing the locking, we need to address a serious
abuse of the GPIO driver API - accessing struct gpio_chip by anyone who isn't
the driver owning this object. This structure is owned by the GPIO provider
and its lifetime is tied to that of that provider. It is destroyed when the
device is unregistered and this may happen at any moment. struct gpio_device
is the opaque, reference counted interface to struct gpio_chip (which is the
low-level implementation) and all access should pass through it.

The end-goal is to make all gpio_device manipulators check the existence of
gdev->chip and then lock it for the duration of any of the calls using SRCU.
Before we can get there, we need to first provide a set of functions that will
replace any gpio_chip functions and convert all in-kernel users.

This series starts the process by replacing gpiochip_find() with
gpio_device_find(). This is in line with other device_find type interfaces and
returns a reference to the GPIO device that is guaranteed to remain valid
until it is put.

Note that this does not make everything correct just yet. Especially the
GPIOLIB internal users release the reference returned by the lookup function
after getting the descriptor of interest but before requesting it. This will
eventually be addressed. This is not a regression either.

First we add a bunch of new APIs that are needed to start replacing calls
to gpiochip_find. We then use them first in external users and then locally in
GPIOLIB core. Finally we remove gpiochip_find().

Bartosz Golaszewski (21):
  gpiolib: make gpio_device_get() and gpio_device_put() public
  gpiolib: provide gpio_device_find()
  gpiolib: provide gpio_device_find_by_label()
  gpiolib: provide gpio_device_get_desc()
  gpiolib: add support for scope-based management to gpio_device
  gpiolib: provide gpiod_to_device()
  gpiolib: provide gpio_device_get_base()
  gpio: acpi: provide acpi_gpio_device_free_interrupts()
  gpiolib: reluctantly provide gpio_device_get_chip()
  gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
  platform: x86: android-tablets: don't access GPIOLIB private members
  hte: allow building modules with COMPILE_TEST enabled
  hte: tegra194: improve the GPIO-related comment
  hte: tegra194: don't access struct gpio_chip
  arm: omap1: ams-delta: stop using gpiochip_find()
  gpio: of: correct notifier return codes
  gpio: of: replace gpiochip_find_* with gpio_device_find_*
  gpio: acpi: replace gpiochip_find() with gpio_device_find()
  gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
  gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
  gpiolib: remove gpiochip_find()

 arch/arm/mach-omap1/board-ams-delta.c         |  36 ++--
 drivers/gpio/gpiolib-acpi.c                   |  37 +++-
 drivers/gpio/gpiolib-of.c                     |  48 ++---
 drivers/gpio/gpiolib-swnode.c                 |  29 ++-
 drivers/gpio/gpiolib-sysfs.c                  |   2 +-
 drivers/gpio/gpiolib.c                        | 203 +++++++++++++-----
 drivers/gpio/gpiolib.h                        |  10 -
 drivers/hte/Kconfig                           |   4 +-
 drivers/hte/hte-tegra194.c                    |  49 +++--
 .../platform/x86/x86-android-tablets/core.c   |  38 ++--
 include/linux/gpio/driver.h                   |  30 ++-
 11 files changed, 316 insertions(+), 170 deletions(-)

-- 
2.39.2

