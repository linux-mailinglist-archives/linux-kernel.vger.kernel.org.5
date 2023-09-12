Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E756479CD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjILKH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjILKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:07:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD21718
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so61895695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513256; x=1695118056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4haYmdObfDE5/y07WwdJnqnP4U8yxjngc5oSCKLzDA=;
        b=eOBil49xQ2KaWxvTRxsfcHKMH0o9oRKWUycF3TRF3ovVXr5HdMCxU0NjXLzvDFkwry
         io5EdUVDpL1faHiEGAuwKICPpBT988WwXHgs/mc+VRM3TfNB3cPE5tTTvvQG1WKL5QgU
         /JmQVZtbSrVUvvTnb7q5mKBxdS7Jv0R+R6EjlWZe1Kt1NFjQnQUruVsZSnajSQF40hZU
         cffbmI0Pkc0R++dtLTRTb7XPr+J54lrhGYT6HXQ9JCgjYfLEBig8oV6zaHztkNzjreM4
         ZgzDKBNk91G/6URNr4GdCDTfcKAyqlSd5zewrDD/IEpbm+B+pJpW7rPLnT4HDiF93sbf
         Wp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513256; x=1695118056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4haYmdObfDE5/y07WwdJnqnP4U8yxjngc5oSCKLzDA=;
        b=UzW9X7oVjpQZSedDdxR5obvLpmpp7/m6G6iK2IsruUgnojg2EwFVsAwZJOzuxurMqN
         01UkwObFVk4PH/CAiZTw+bj+mTby1x2tA5Hh+0qvjzk3etnoQ2JCC/LzZ+4Ts1gnx4y8
         EhjQIkiwnb0/+/R38iXUbs73E2cShPslP0CbGYNyZs9rq8BwLCkUxzDW8bWRaBmhyegT
         GC6MNPIz0p1CGd+a6ImHVmT00uMmS8O7Xeu+Bn87MocQANmD9OglXOQVSNpuw3LkXqlm
         I5mNIceDCC7ZTT7pkdbocgGL+hKQYSFvaEwQ0oZ4hWTLkf0Tx7TcyO2b786BVRdeiK6X
         hrjA==
X-Gm-Message-State: AOJu0YzF3BZB42O/ZdVnolNTv3jNhQQGp7TbNgYEcU+U0cfeMQ5HGqV+
        fNYyCYCBOaArL3kIrxa6MprIFPYg3yRV5FyoPGc=
X-Google-Smtp-Source: AGHT+IFP2ZkHAn0oAd5VEal3U/DDMSBmSZPRnW97oOBXBaMn4x42Nik4c/SZV7LTaAhOehrGAWOVXw==
X-Received: by 2002:a1c:7c11:0:b0:402:98cd:aa22 with SMTP id x17-20020a1c7c11000000b0040298cdaa22mr11221950wmc.41.1694513255919;
        Tue, 12 Sep 2023 03:07:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 00/11] gpiolib: work towards removing gpiochip_find()
Date:   Tue, 12 Sep 2023 12:07:16 +0200
Message-Id: <20230912100727.23197-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is a reduced subset of patches from the initial sumbission[1]
limited only to changes inside GPIOLIB. Once this is upstream, we can
then slowly merge patches for other subsystems (like HTE) and then
eventually remove gpiochip_find() entirely.

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

This series adds several new helpers to the public GPIO API and uses
them across the core GPIO code.

Note that this does not make everything correct just yet. Especially the
GPIOLIB internal users release the reference returned by the lookup function
after getting the descriptor of interest but before requesting it. This will
eventually be addressed. This is not a regression either.

[1] https://lore.kernel.org/lkml/20230905185309.131295-1-brgl@bgdev.pl/T/

v1 -> v2:
- drop all non-GPIOLIB patches
- collect tags
- fix kernel docs
- use gpio_device_get_chip() and gpio_device_get_desc() where applicable

Bartosz Golaszewski (11):
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

 drivers/gpio/gpiolib-acpi.c   |  12 +-
 drivers/gpio/gpiolib-of.c     |  32 +++---
 drivers/gpio/gpiolib-swnode.c |  33 +++---
 drivers/gpio/gpiolib-sysfs.c  |   2 +-
 drivers/gpio/gpiolib.c        | 201 ++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.h        |  10 --
 include/linux/gpio/driver.h   |  13 +++
 7 files changed, 211 insertions(+), 92 deletions(-)

-- 
2.39.2

