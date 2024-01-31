Return-Path: <linux-kernel+bounces-46097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E255F843A48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C01292A34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512567B3D1;
	Wed, 31 Jan 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0YhYvzCx"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB27AE78
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691775; cv=none; b=WHMoSYSpZql5xYosyIyoAeJT6O4m94Ep3OlIMIGkrXkw/1czom2MUSS0TrWkfJ1a3Jt6+8Gm5UdbAysU+Hn3gmX0IMAF/cYGP6ywwtoOhpewrKE4DloQNrOHaaWWIPv65XjxT9x6JR+dbSTj5YAv4hHviYDbGFcm3CtTcB0oyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691775; c=relaxed/simple;
	bh=4ube494DxN77EoNRTkC5bj/EFomeKNhiGAdr5fHNlZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTmurbaLnZhQ58YaXpC4IR7lagkZYuw+I3+WZgxH8DsliQ38Wmwcxfx19dMjsi3dJSoeZcJa/CGelaq8TcTQdqLqIHGITaWh7Y/cmzxuB3+WAhqcuNyaG8NJbIMfJ6QjJmq+m1IKJnfcCxxLczsdRcYhJQaMxeU2WAWs5AIXJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0YhYvzCx; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-46b1419ad06so395570137.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706691772; x=1707296572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHIn5iEEeJ3rw/RfxswFaDoxGXKGctXGF45XOL5dY2I=;
        b=0YhYvzCxYAnZGH1eqQz4qiNWSZlL2gW7qKhOKpDohLlwsr6+quAg5ELxjHsQ4V2JOG
         AT0k17poXYzb9/fhZs8t1rCmg0vmDb0CiTDj9zVpGZdLC/leBy3Lvm69HmJCWibYic1B
         IQVCZLQxvDv19u7chU4gwADJBgRLP3FdxjdpuAKOoOzRfV8altkjc//RJluxdDmeMbg4
         OKZw0+TidVtx64GOsdOjDFcRIqBwBlj8mRlrmyY3E134/OUht6pssbGiKO08mvXkiiOu
         molLZ9gAaR4HfMynE7TQvwWP6IaJszrO5rZa71VjwlvpBk1ZNxsAZvOAEJUiy28IDxyI
         zE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691772; x=1707296572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHIn5iEEeJ3rw/RfxswFaDoxGXKGctXGF45XOL5dY2I=;
        b=M5IaqozZWioZeVGLgw3jLurThI3D3Wij/PWIC5ykM//rBG+sNxlwoMyn1s6zBH8pJe
         n3GQtVOKzaELkaD2BJTMyP6TIXERBCdYns6LdRNn89uLxYYG44TQvG5yfVGs7+KxqBBj
         FTXhHFsN/xwD8wPVVoIvq6HbltSH02nRC83xwjzsJkQpPCP7V8qksoFkLnYlZ+N8Mofn
         4hhe7SxnHV6liY232CGYFi/gvrPheza8xQ4kzdncysQ9YlkjiO4gEMMLaLFl1FHcqh1F
         s7PswdQGQzJPaJIXZwlyZGG3yQYLcEAjetJvmohPCxM7A1Xx+VZk4hppBuCyUz8eCYEx
         M2qQ==
X-Gm-Message-State: AOJu0YxAdvlFFAPMP1hfQ+n5KLekR37HT1WS9ItRK+0S8E1JiKrTJiVr
	9oaXxGJ/v8QHWByLzVKGue/aU6E6DXAk7JeVUuKsqTELo0hzJejwkyOPNO1XsyteLaWd580QTMb
	oxqOeO7LRcvNfEEOj/v/Z6dp71vBxA38jDVjGdB3zxrDNCF1M
X-Google-Smtp-Source: AGHT+IHwfAAjqdqROm25j35JKJFRD2vF9Pt57pirLSUCe4FZ2jlrKokE/urkjVy/LFDj01VwH0GsmB66CaZJuy1zsg0=
X-Received: by 2002:a05:6102:3b91:b0:46b:6936:bdcf with SMTP id
 z17-20020a0561023b9100b0046b6936bdcfmr1780735vsu.28.1706691772117; Wed, 31
 Jan 2024 01:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-21-brgl@bgdev.pl> <202401311050.YNdm98Hv-lkp@intel.com>
In-Reply-To: <202401311050.YNdm98Hv-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 10:02:40 +0100
Message-ID: <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:21=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Bartosz,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on brgl/gpio/for-next]
> [also build test WARNING on linus/master v6.8-rc2 next-20240130]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewsk=
i/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gp=
io/for-next
> patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40b=
gdev.pl
> patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gp=
io_device with SRCU
> config: x86_64-randconfig-122-20240131 (https://download.01.org/0day-ci/a=
rchive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm98Hv-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible types in c=
omparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [noderef] _=
_rcu *
>    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible types in c=
omparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [noderef] _=
_rcu *
>    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible types in =
comparison expression (different address spaces):
>    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [noderef] =
__rcu *
>    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
>    drivers/gpio/gpiolib.c: note: in included file:
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in co=
mparison expression (different address spaces):
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __=
rcu *
>    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>
> vim +444 drivers/gpio/gpiolib.c
>
>    422
>    423  /*
>    424   * Convert a GPIO name to its descriptor
>    425   * Note that there is no guarantee that GPIO names are globally u=
nique!
>    426   * Hence this function will return, if it exists, a reference to =
the first GPIO
>    427   * line found that matches the given name.
>    428   */
>    429  static struct gpio_desc *gpio_name_to_desc(const char * const nam=
e)
>    430  {
>    431          struct gpio_device *gdev;
>    432          struct gpio_desc *desc;
>    433          struct gpio_chip *gc;
>    434
>    435          if (!name)
>    436                  return NULL;
>    437
>    438          guard(srcu)(&gpio_devices_srcu);
>    439
>    440          list_for_each_entry_srcu(gdev, &gpio_devices, list,
>    441                                   srcu_read_lock_held(&gpio_device=
s_srcu)) {
>    442                  guard(srcu)(&gdev->srcu);
>    443
>  > 444                  gc =3D rcu_dereference(gdev->chip);
>    445                  if (!gc)
>    446                          continue;
>    447
>    448                  for_each_gpio_desc(gc, desc) {
>    449                          if (desc->name && !strcmp(desc->name, nam=
e))
>    450                                  return desc;
>    451                  }
>    452          }
>    453
>    454          return NULL;
>    455  }
>    456
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Paul,

Should I care about these warnings? They seem to be emitted for a lot
of RCU code already upstream. I'm not even sure how I'd go about
addressing them honestly.

Bart

