Return-Path: <linux-kernel+bounces-52304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3F84968C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C81C220D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC812B9B;
	Mon,  5 Feb 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jMM0gX3/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DF12B7B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125669; cv=none; b=rAWSUl7XfOwC6jxTm6st7HvsM9tjt7WXoMaM/gqiMqn2quUHkiygMuxiyiXboIJQgQAhgNC8ruGAgUcEFBqWKwHd+MSydIKX+w7vlU5B2nQqMq/7v99SHMkfdENjKAb9qv/5zupR0+RdCjoRTUZL5qD9vNxrH1PQvlv7sK2ZNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125669; c=relaxed/simple;
	bh=K7ZFkCVNfTzkHWT3kyjAxLn7zdwISVDk7B9NBGYhRXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDjGf4MHzLjAnMFhtCJ5aEcCmdU1RevcbOSFT2IxclxB57t9JxINtXJo5oeUM+/x8ddnPnPcNDpnvmpMXlkfYj1jQsbjI+Uv+/toHShZ62nvUtxGa33/R/n7mqlKiX3PKwl8COOVl323HhdWFM0aCnuRsN13pr6iyUrESy6cdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jMM0gX3/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd72f71f8so5513195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707125665; x=1707730465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxy6DNRVLVXRfxM53TbL7nhrphReFKWpE9lNLkV9gAU=;
        b=jMM0gX3/vtn/IFCD96cWlChIOcIUGueDCWhYjVEebs7pkD/rFBNdFnl0kNOJC+ixgR
         bNsrBZOOrnQCHpPEP7v6QP+moMHLVHyBFjBzas4RjMiL7jDHdT2URwn7OHldLqp8qraN
         AxvK0HbNw3Nun+jjudZZ3sY2m5iwsEqIWi1dDIFV1Am2ka97BaTRTmP0DdwwgINgQvPn
         4uj2scnJhDmfFEsKBmSjpKuKU81Pa4Fc74Hc3ugQoMGnLeMcJ77MuK61p2jRIjppH6pT
         ULt/cbTftjBt/1rk1murmIGrUEWZXmHwh6d1GzPis21GFoOSVcKo/9d6GKbYWphC1YjY
         RodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125665; x=1707730465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxy6DNRVLVXRfxM53TbL7nhrphReFKWpE9lNLkV9gAU=;
        b=SJGE9F/gAoCQhsTbB88PwD1e3kUafk/El5ZsdKciBZjsnKQImGWcB2U4AxxPH43+0K
         RT5JoMUJFrz9JN043pMf5volTEoZBgLmvYwqr4hHlPZH8ehW/cUMeWSrX0WkHSQt2J7J
         M0ogXt1X3lKyHJV3SeLT4SiqH3VyM3xxJEE4kUChDP2gaOYeCJm6DQ7BHYmwNShJTfyY
         eVKHTo29ado1OHH1Pl6MqMI4luWZvPGLi08QCWXPo9tFrW20cLIya7/dY0zfH74MhkGj
         J/G2wKMrfXiA2Y00rijq+iAF2s2jRYa82R7mOZ3SAOSGgLxiUFYnbS+4sOwMay7oZGHR
         DFQg==
X-Gm-Message-State: AOJu0YxNa/IG3bNKA87qdbpFUXGrmoJA29Ny++25ryABpgvdnIFGC1Mw
	9dbqbGgd8eoJTyJgxiQ8G/bMb6Wq2nK61XspVx2SPpKqN6wj2eLBceAGhEWAngQ=
X-Google-Smtp-Source: AGHT+IF1nlbXrw8VO/SLXb/ihHKDq2yfvo830q3XioskWWSzVvPBvsB1bYbhmouyNh1XyXVeTS42Gw==
X-Received: by 2002:a05:600c:1e18:b0:40f:c234:2006 with SMTP id ay24-20020a05600c1e1800b0040fc2342006mr4145538wmb.8.1707125665118;
        Mon, 05 Feb 2024 01:34:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtqHYpsThXqMf61zoPVLS49pez9IPjY0i6t17B3n+3aStUgeVcC9Tlx/xJg4Wa5F6J8Y/n12/5nI1xQlYSCdUU1H9b0oEMdv7KJpNZIJh7MNj2BbsJUzuTK30QgNNr8VUR3IF3o+R//hvnUz34e6Et+LUbT7Ipu7/h/aZxZsqM6KFO3CjCLE+/D9uI5cmuvONg+LUgR07tEZRimIipYc6f6U5n1hBNOOwUWBy5WFtZO2dJfsBkKqYw8RlceYvka1mapPLZLmd9TxDiHLSe8U28iSCpAwkaiNcPsdFeD+qCygDyl0dL0Jws38w4GT+joclFNDyr2vdd82paS0shaWhxp73LMdISJg==
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040fc771c864sm7980397wmg.14.2024.02.05.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:34:24 -0800 (PST)
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
Subject: [PATCH v2 00/23] gpio: rework locking and object life-time control
Date: Mon,  5 Feb 2024 10:33:55 +0100
Message-Id: <20240205093418.39755-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is a big rework of locking in GPIOLIB. The current serialization is
pretty much useless. There is one big spinlock (gpio_lock) that "protects"
both the GPIO device list, GPIO descriptor access and who knows what else.

I'm putting "protects" in quotes as in several places the lock is
taken, released whenever a sleeping function is called and re-taken
without regards for the "protected" state that may have changed.

First a little background on what we're dealing with in GPIOLIB. We have
consumer API functions that can be called from any context explicitly
(get/set value, set direction) as well as many others which will get
called in atomic context implicitly (e.g. set config called in certain
situations from gpiod_direction_output()).

On the other side: we have GPIO provider drivers whose callbacks may or
may not sleep depending on the underlying protocol.

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
it's the only mechanism we can use our read-only critical sections to be
called from atomic and protecc contexts as well as call driver callbacks
that may sleep (for the latter case).

We're going to use it in three places: to protect the global list of GPIO
devices, to ensure consistency when dereferencing the chip pointer in GPIO
device struct and finally to ensure that users can access GPIO descriptors
and always see a consistent state.

We do NOT serialize all API callbacks. This means that provider callbacks
may be called simultaneously and GPIO drivers need to provide their own
locking if needed. This is on purpose. First: we only support exclusive
GPIO usage* so there's no risk of two drivers getting in each other's way
over the same GPIO. Second: with this series, we ensure enough consistency
to limit the chance of drivers or user-space users crashing the kernel.
With additional improvements in handling the flags field in GPIO
descriptors there's very little to gain, while bitbanging drivers may care
about the increased performance of going lockless.

This series brings in one somewhat significant functional change for
in-kernel users, namely: GPIO API calls, for which the underlying GPIO
chip is gone, will no longer return 0 and emit a log message but instead
will return -ENODEV.

I know this is a lot of code to go through but the more eyes we get on it
the better.

Thanks,
Bartosz

* - This is not technically true. We do provide the
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

v1 -> v2:
- fix jumping over variable initialization in sysfs code
- fix RCU-related sparse warnings
- fix a smatch complaint about uninitialized variables (even though it's
  a false positive coming from the fact that scoped_guard() is implemented
  as a for loop
- fix a potential NULL-pointer dereference in debugfs callbacks
- improve commit messages

Bartosz Golaszewski (23):
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
  gpio: don't dereference gdev->chip in gpiochip_setup_dev()
  gpio: reduce the functionality of validate_desc()
  gpio: remove unnecessary checks from gpiod_to_chip()
  gpio: add the can_sleep flag to struct gpio_device
  gpio: add SRCU infrastructure to struct gpio_device
  gpio: protect the pointer to gpio_chip in gpio_device with SRCU
  gpio: remove the RW semaphore from the GPIO device
  gpio: mark unsafe gpio_chip manipulators as deprecated

 drivers/gpio/gpiolib-cdev.c  |  92 +++--
 drivers/gpio/gpiolib-of.c    |   4 +-
 drivers/gpio/gpiolib-sysfs.c | 167 +++++---
 drivers/gpio/gpiolib.c       | 760 +++++++++++++++++++----------------
 drivers/gpio/gpiolib.h       |  86 ++--
 5 files changed, 630 insertions(+), 479 deletions(-)

-- 
2.40.1


