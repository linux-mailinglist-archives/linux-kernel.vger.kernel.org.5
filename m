Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC18B809E52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573344AbjLHIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:36:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C6A171C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:37:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b27726369so19883335e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702024620; x=1702629420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNfU9DBaDJWRRxmgHYFx4nHbGgVZAwp+QKmlmlzyeuQ=;
        b=gZ5RtFhk197PCmeKXMy761pH5NclNaCp6XuJvUumzJR9BF8Ok3lhhAt5/QioDaMwoK
         eh+/B3d8TivCVwz8DLqnK4MmI7svyW3R8nUVzxhz51Ixs7iDlA+sm1p9iFdP7YR1q4Qw
         PCeCgS1L37XeXlHF4wKMDPGxGc0Teh6llHyOPJ2t286FJdqS5qlhLE2oMlblOWUEbrAy
         /xwATJH5i2SfDP91y7JyLYILjcyngt6CnGnXBcfQIQHvxxNikfagvKVAoWoxn4JGpziM
         uLUcPF2gnauTrnWIcLhL5Dy267NT8bFbPWUvGd12J5/i+8tQCFmdW5t5cdm6jVDZgeDh
         RgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024620; x=1702629420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNfU9DBaDJWRRxmgHYFx4nHbGgVZAwp+QKmlmlzyeuQ=;
        b=V7WNpmJzaRnib+N0hocC8S8xwbimOMXGgBcLbhItEf6yG/M5wRQlkE40QCaWkqMDnD
         632biayFxLjkWPZcPUlI7s7PDKEtjiEqm7KRaarrkljZcb8LuL4Mlba843ku0x4c+hko
         jj/AAztU8KR2iuwwmAKTi41RWcSb0tmGpQJPQ35983OzDzxcrgsxNg/t6BTePWGQtdIr
         j1ms3FUwOtVPjl87NwiHje9G1KO7u4ZiDLv3hZfXlo+d7yqyFM+9nzqx9i/N7JXnY7Fb
         8yycccRnnmu5YAZ3fIZv0s0JMj3hBfBnPLXkyfIo0zn5ra3tfR5WhuYD8AOcO6wFuI+K
         ivcQ==
X-Gm-Message-State: AOJu0Yz5ZyOktrHkqIJgFJ7M7EtkbHLzCKhe4q1yrtHfX81fubqr3Fqs
        Lz6KVbPhB/8bApdPorwCJb1KuQ==
X-Google-Smtp-Source: AGHT+IFTDanBKxnNxQj3jzP20OiOzKn2N0tR8XTkfJOvIBTmyMTeK2zrzuve+Z4+WUb6UkIgGVs/JA==
X-Received: by 2002:a05:600c:3093:b0:40b:5e59:da99 with SMTP id g19-20020a05600c309300b0040b5e59da99mr2355770wmn.172.1702024619510;
        Fri, 08 Dec 2023 00:36:59 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm2113880wmb.38.2023.12.08.00.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:36:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: immutable branch between the GPIO and pinctrl trees for v6.8-rc1
Date:   Fri,  8 Dec 2023 09:36:50 +0100
Message-Id: <20231208083650.25015-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus, Andy,

Please pull the following changes into your trees for the next merge window.
These are the patches providing a safer alternative for gpiochip_is_requested()
before we rework the locking in GPIOLIB.

Bart

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-remove-gpiochip_is_requested-for-v6.8-rc1

for you to fetch changes up to f8d05e276b45e3097dfddd628fa991ce69c05c99:

  gpiolib: remove gpiochip_is_requested() (2023-12-08 09:26:43 +0100)

----------------------------------------------------------------
gpio: remove gpiochip_is_requested()

- provide a safer alternative to gpiochip_is_requested()
- convert all existing users
- remove gpiochip_is_requested()

----------------------------------------------------------------
Bartosz Golaszewski (10):
      gpiolib: provide gpiochip_dup_line_label()
      gpio: wm831x: use gpiochip_dup_line_label()
      gpio: wm8994: use gpiochip_dup_line_label()
      gpio: stmpe: use gpiochip_dup_line_label()
      pinctrl: abx500: use gpiochip_dup_line_label()
      pinctrl: nomadik: use gpiochip_dup_line_label()
      pinctrl: baytrail: use gpiochip_dup_line_label()
      pinctrl: sppctl: use gpiochip_dup_line_label()
      gpiolib: use gpiochip_dup_line_label() in for_each helpers
      gpiolib: remove gpiochip_is_requested()

 drivers/gpio/gpio-stmpe.c                 |  6 ++++-
 drivers/gpio/gpio-wm831x.c                | 14 +++++++----
 drivers/gpio/gpio-wm8994.c                | 13 +++++++----
 drivers/gpio/gpiolib.c                    | 35 ++++++++++++++++-----------
 drivers/pinctrl/intel/pinctrl-baytrail.c  | 11 +++++----
 drivers/pinctrl/nomadik/pinctrl-abx500.c  |  9 +++++--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c |  6 ++++-
 drivers/pinctrl/sunplus/sppctl.c          | 10 ++++----
 include/linux/gpio/driver.h               | 39 ++++++++++++++++++++++++-------
 9 files changed, 96 insertions(+), 47 deletions(-)
