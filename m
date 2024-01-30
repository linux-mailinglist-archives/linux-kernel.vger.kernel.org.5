Return-Path: <linux-kernel+bounces-44627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F61842548
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5672B23777
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3F6A355;
	Tue, 30 Jan 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qaOmb9tX"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23F6A010
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618923; cv=none; b=INJG6LkZydsv/l+zjoEOW//3yV2b5mlPsTxOGEF7z2Pe7R69MaRzOXguYDyDNv+ZotejCPhu1ZUgZjsKCNyAJQFO/boLch3KauPs8xHKv+zXA4szpJlTGmlYSGjKr+qA6mEnWEkweYsrgjkwed17uL7zZY5anJk6AYTH7fyamLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618923; c=relaxed/simple;
	bh=DLFEpbi+GIN0OR0cK3hZ14rudiYt5ObrbPYx2m7fJd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPjYInCH+kWtFuXjIfogHdhRVt9w3zdkgXuvTyyo+5LWh+WlVym805fWn1WzlG0YRJzaUGhEcN2ofv96CtFfgsrEs+anuBzPoYN5/0k/Ii9QBcPFqUuoAzQE3bpCvz0ig7fBMheWxP84XIgDk1J4W0QW1wbsBJ+JFjHfa4t4LEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qaOmb9tX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ae4eb360aso2265953f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706618920; x=1707223720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TM4N++qzpiBwfwnB5WEJqzKPWkBeyUp9jsBDFdQRjYg=;
        b=qaOmb9tXMf4O7cEtwEMXbfKoepF0oZh1DbL0KfJC+cQAgjL848+qgktxl0HQwTIWP4
         wk9mXt8DrobDSfTmx1AhYbCdZZQuTGJIkjFEeMYbSPuJQMARxwHrWyoNM9AWgMLvqjLy
         B20jdL9hw4inyR+TnfizLmB16+GhseB7O7cYR3aDvWXYadj0ySHzUVIKZY8tJt6Ovef+
         73HNYKrfsz2hQc2fKBcGl5t/LhgTFsSxK0VUOY2DfnqiDDsHTOBbFfcmAuH4jRrdheyH
         ntfegrc3JSWzwahfeBf3ZIdMOceD7FBkTzmr0m4JJ/4u8y/onRCw44V6GdKxqV/5GeEw
         fLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618920; x=1707223720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TM4N++qzpiBwfwnB5WEJqzKPWkBeyUp9jsBDFdQRjYg=;
        b=liYOK0fsxFi3HTZHR/nUObFal01q3mK6waE7SoUHHO20+vQtls8qP37OXWi96Tyaa/
         8k8Ij2u9qdWYVS+AsBs0WO2MLZ1PtUZQBH6ZejU6t6sLn/QkayDeHTPevG1n/0MX19WC
         MSn0SU+1qtbufq13hcdmPwnLbF4Eppc+xjMK/D7jG5Bv+VWc/CMh9zxPhynI9KwK5u+I
         WDbemCpwqgGLtJYQLUnEF7K2nNDmGOgMp3iclepSE1m5d1PUimmHooMgVqYY4ioQeHcg
         R6X8WFTKEiLgZEkbOUYwk33qBpDAuikEm/BGzNPV7gbXUmDM4kWpWFKJX8wglhSUgUm2
         eNeA==
X-Gm-Message-State: AOJu0YzNysIMAFu3vJPlrADCpONATB8kFjtW0hv+msE20EJxQ9s6u3tC
	WKrtxrhhB+Y6Xb9Uxt38tcaT0A50qgg7kdDUI49A+T1D597rVmx8l4g3C7jg0cI=
X-Google-Smtp-Source: AGHT+IGO70GsGHeRexHE8nfdAlfLgxsHDIxmA01skOEoiTnCjs5tHuM59Ijq0XoMi3EySQsHBRHoGw==
X-Received: by 2002:a5d:47c4:0:b0:33a:f50c:d4e5 with SMTP id o4-20020a5d47c4000000b0033af50cd4e5mr3747756wrc.49.1706618919516;
        Tue, 30 Jan 2024 04:48:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id en8-20020a056000420800b0033940016d6esm6625337wrb.93.2024.01.30.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:48:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/22] gpio: rework locking and object life-time control
Date: Tue, 30 Jan 2024 13:48:06 +0100
Message-Id: <20240130124828.14678-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This has been brewing for some time now but is finally ready to send out
for review. This series relies on SRCU a lot so I'm Cc'ing Paul.

This is a big rework of locking in GPIOLIB. The current serialization is
pretty much useless. There is one big spinlock (gpio_lock) that "protects"
both the GPIO device list, GPIO descriptor access and who knows what else.

I'm putting "protects" in quotes as in several places the lock is
taken, released whenever a sleeping function is called and re-taken
without any regards for the "protected" state that may have changed.

First a little background on what we're dealing with in GPIOLIB. We have
consumer API functions that can be called from any context explicitly
(get/set value, set direction) as well as many others which will get
called in atomic context implicitly (e.g. set config called in certain
situations from gpiod_direction_output()).

On the other side: we have GPIO provider drivers whose callbacks may or
may not sleep depending on the underlying protocol but they're called
from the same code paths.

This makes any attempts at serialization quite complex. We typically
cannot use sleeping locks - we may be called from atomic - but we also
often cannot use spinlocks - provider callbacks may sleep. Moreover: we
have close ties with the interrupt and pinctrl subsystems, often either
calling into them or getting called from them. They use their own locking
schemes which are at odds with ours (pinctrl uses mutexes, the interrupt
subsystem can call GPIO helpers with spinlock taken).

There is also another significant issue: the GPIO device object contains
a pointer to gpio_chip which is the implementation of the GPIO provider.
This object can be removed at any point - as GPIOLIB officially supports
hotplugging with all the dynamic expanders that we provide drivers for -
and leave the GPIO API callbacks with a suddenly NULL pointer. This is
a problem that allowed user-space processes to easily crash the kernel
until we patched it with a read-write semaphore in the user-space facing
code (but the problem still exists for in-kernel users). This was
recognized before as evidenced by the implementation of validate_desc()
but without proper serialization, simple checking for a NULL pointer is
pointless and we do need a generic solution for that issue as well.

If we want to get it right - the more lockless we go, the better. This is
why SRCU seems to be the right candidate for the mechanism to use. In fact
it's the only mechanism we can use for our read-only critical sections to
be called from atomic and process contexts as well as be able to call
driver callbacks that may sleep (for the latter case).

We're going to use it in three places: to protect the global list of GPIO
devices, to ensure consistency when dereferencing the chip pointer in GPIO
device struct and finally to ensure that users can access GPIO descriptors
and always see a consistent state.

We do NOT serialize all API callbacks. This means that provider callbacks
may be called simultaneously and GPIO drivers need to provide their own
locking if needed. This is on purpose. First: we only support exclusive
GPIO usage[1] so there's no risk of two drivers getting in each other's
way over the same GPIO. Second: with this series, we ensure enough
consistency to limit the chance of drivers or user-space users crashing
the kernel. With additional improvements in handling the flags field in
GPIO descriptors there's very little to gain, while bitbanging drivers
may care about the increased performance of going lockless.

This series brings in one somewhat significant functional change for
in-kernel users, namely: GPIO API calls, for which the underlying GPIO
chip is gone, will no longer return 0 and emit a log message but instead
will return -ENODEV.

I tested the series with libgpiod tests, ran it on some x86 and aarch64
boards and tested some corner cases with user-space command-line tools.

Thanks,
Bartosz

[1] - This is not technically true. We do provide the
GPIOD_FLAGS_BIT_NONEXCLUSIVE flag. However this is just another piece of
technical debt. This is a hack provided for a single use-case in the
regulator framework which got out of control and is now used in many
places that should have never touched it. It's utterly broken and doesn't
even provide any contract as to what a "shared GPIO" is. I would argue
that it's the next thing we should address by providing "reference counted
GPIO enable", not just a flag allowing to request the same GPIO twice
and then allow two drivers to fight over who toggles it as is the case
now. For now, let's just treat users of GPIOD_FLAGS_BIT_NONEXCLUSIVE like
they're consciously and deliberately choosing to risk undefined behavior.

Bartosz Golaszewski (22):
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
  gpio: sysfs: extend the critical section for unregistering sysfs
    devices
  gpio: sysfs: pass the GPIO device - not chip - to sysfs callbacks
  gpio: cdev: replace gpiochip_get_desc() with gpio_device_get_desc()
  gpio: cdev: don't access gdev->chip if it's not needed
  gpio: reduce the functionality of validate_desc()
  gpio: remove unnecessary checks from gpiod_to_chip()
  gpio: add the can_sleep flag to struct gpio_device
  gpio: add SRCU infrastructure to struct gpio_device
  gpio: protect the pointer to gpio_chip in gpio_device with SRCU
  gpio: remove the RW semaphore from the GPIO device
  gpio: mark unsafe gpio_chip manipulators as deprecated

 drivers/gpio/gpiolib-cdev.c  |  82 ++--
 drivers/gpio/gpiolib-of.c    |   4 +-
 drivers/gpio/gpiolib-sysfs.c | 155 +++++---
 drivers/gpio/gpiolib.c       | 735 +++++++++++++++++++----------------
 drivers/gpio/gpiolib.h       |  84 ++--
 5 files changed, 595 insertions(+), 465 deletions(-)

-- 
2.40.1


