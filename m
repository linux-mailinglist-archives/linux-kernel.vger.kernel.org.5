Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E807A21D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjIOPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIOPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:03:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36442211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f853f2f3aso2228466f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790210; x=1695395010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2icBidhNqLF921D274+HegN9s4sM/PCTy5BqMLL57c=;
        b=x+TQ3jbvdGtso1IF9KzIw5VBjDCeGxZzua2+ltbfk/Q6ccsT9ckmoEmB6Vwww8Ya1p
         x5DEBj9e9fMTtm6x+6Z2KWv4RlbqCFxIIwHL33FE9p9rmWg+5ukU9483ehDlE8JwYaC4
         zsn/OdN83lSofAYFsMvVkOMdacpmEp2t0EGMOcH6Fb+VNv0ufeuzvJx+XlKxmcFtpJ8V
         smnsfxxDR9EB27ePdweKgXpclwitYh3hPI+/aGIQVwO/OOBsNIRekL2s4bu9xgYtCOfK
         rWC0JVR66XXSWKKiIM9TJdNIzliWaIu0LksZ2JB8O0wh9WbJELVM7Pzm3s7T/rOL6dzb
         uaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790210; x=1695395010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2icBidhNqLF921D274+HegN9s4sM/PCTy5BqMLL57c=;
        b=d7GZwHb8Y9RSfKKovz8gbpEVJtDetrsXT/7aXQNPmzgcx8lcJUXJFKF/Not2Jn/Rx0
         lPf7Og+EI2L83g0NqAHmk+TFvP/09nQIDY/uujpUVzcCuvTHTj5VUcGOVoGf8lVYpnPR
         3CcLgwTbp9Ph8/ytTbw7xEJKytadaNu6OwR28erzRoZL1j0xhdFWKIej09fn7a2GJNIO
         2e2DLP7fKGGQ3T6ZCI0zNa6g65k+5J5kp2uURrXo2LA0k4cWGiHCc7W3do6BFUm6fif2
         gU9reY1i3Fq6B56Jm3MpGm/OZrYi5qrqjH2tyYHFuSxfPSS/A1Z8NxnHkn6FxYF8no3F
         F3sw==
X-Gm-Message-State: AOJu0YyI5Hme3efjuZ4MsnsgcDVoKKzCU9l6bocyBfVf7fWSiQjynSNx
        FutENDQR9aR4hVlkPIXs/rUvWQ==
X-Google-Smtp-Source: AGHT+IEfWgq+54eJPYGOwbdJHlYxpAVHAOywpVSMyAjN9QotMhlImJ8mbahol9G3z4CPEP99bWShMQ==
X-Received: by 2002:a5d:6f15:0:b0:31f:ecb2:d774 with SMTP id ay21-20020a5d6f15000000b0031fecb2d774mr2343475wrb.19.1694790210397;
        Fri, 15 Sep 2023 08:03:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:29 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 00/11] gpiolib: work towards removing gpiochip_find()
Date:   Fri, 15 Sep 2023 17:03:15 +0200
Message-Id: <20230915150327.81918-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v2 -> v3:
- use gpio_device_get_chip() consistently
- clarify comments
- fix buggy chip assignment
- check for PTR_ERR() in automatic cleanup
- rearrange code as requested by Andy

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
 drivers/gpio/gpiolib-of.c     |  33 +++---
 drivers/gpio/gpiolib-swnode.c |  33 +++---
 drivers/gpio/gpiolib-sysfs.c  |   2 +-
 drivers/gpio/gpiolib.c        | 202 ++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.h        |  10 --
 include/linux/gpio/driver.h   |  16 +++
 7 files changed, 216 insertions(+), 92 deletions(-)

-- 
2.39.2

