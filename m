Return-Path: <linux-kernel+bounces-62025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A1851A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9FB283175
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FC3F9E0;
	Mon, 12 Feb 2024 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OcQr7FX7"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBD3F9CE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756999; cv=none; b=beH96+BVzBG7tU7mp44aFEeM3Yp3osFf4nqFmuhalbnJAt3JZiUyTL5O08Y9oEFlSKdGD4nv35DbE81j5RnfwNxKkL5RUhn6SkgT0hdfV09SejzOZOYvCM9dLGkMegA1mSxds7e1rHJ77mV7sdaAQAxN9uVi067tS37ndzcmeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756999; c=relaxed/simple;
	bh=h3AcMA2a6EtIrIAD/Um+nsR8fti6f3lN8/dfIY/yweE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDNbEjecBfzdAWVRfgBkPfVA1dNNdXtxV10df0Na2TrEC4AutgIIEcx7/1ZJbrAn8+Uny1lxoFhz/8hvpakcErhA9d5l2MHQU5FuYwTG0K1CInQLJV8s4HDFgrjcZrDeWl8f7Lq7mFMzK9Skwbc3HqFV4NaeHVpZdzoBRzke8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OcQr7FX7; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so1291328241.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707756995; x=1708361795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXLA/HKEUblBaR45SvZJb+XTYMbTcWaCEZt0vRKw4Cs=;
        b=OcQr7FX7CWTsKfE9l+3cUmT6dchjPAoex2HxwldxpywRAiRW7erKJMkLSAhoy3kxi6
         /cvoh037cziRwPNLib/t3QS227dX8KBSe8FJ2rATwYzLZXW6pROc8dx1PhBaNmOx7Ll3
         9WNCvb2hMGUyIG1E9/lVaViNP9vkatTHI+SMK99ZPcTf+Nh+CGuQpfFIeT0fxGKdvfeq
         cKVsdrXLT1JhGhC7GvsC161jjm331PrYnW2FoAwM/lCvmq9jk/27EYuxetjE2H6EN5KL
         mG5YuQXXQycPzRN9+dNh46omwgiZtw2T7RIpUg01SoIL1aJNEE9ClSVURpM8hVVpe3mR
         ffbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756995; x=1708361795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXLA/HKEUblBaR45SvZJb+XTYMbTcWaCEZt0vRKw4Cs=;
        b=JJrFIC2ERZKdh0TdoY6yrr2WXMzioHoGrv7Ftj3c0TMggt00G4EmVoU8q/jJeEiCf/
         NsBhOftAZ/r4INWwBCrrJjMkitXP/4TiTRpl7pdW0OQunQtUncYU4cgJ9Ca3+et46XGz
         O1eM0bWtbr9EBYL2c58s2JHbmgD9zZJdNphBXo15o1sOzNL/UjHTQCTP1+yONZnYMC7d
         k11UgX8n5NzknQrl2c4acJGYce9f23XxLubO34pipF0G0AhwX0g+TPPwMwuMBSOqvuta
         UuWJo7DkJpmvUkG5AIdoLJA+ZFAZP/btW5BUXjRVJRKTh0ZnKrp/99EAXG3oLZMiDWIM
         mjAg==
X-Forwarded-Encrypted: i=1; AJvYcCVgAL3fUN3tjLRzJz6cGgnUfOBySmeZ3syZJVTDc1Yr0SnT/6qqFcTzMkCZBk7ZqhCy9/CUKJioslgN2MDxsZP+nEN6i1zY7yGu7ukv
X-Gm-Message-State: AOJu0YzSl8mJBQ/MnMiJI+RFHO/+igrlL3bt7H/13mZAtc2l0+pdcNUo
	KhuRlDzVT32/ENcr3Lbe3cEIgU5uiufQQCpTlsbXT7sV/zDIje7KX2vdAacVndEzMNSJvn67MNw
	SJictjx5STSgKYgjq8FAoKLYNk2uLbs2FxFkXUA==
X-Google-Smtp-Source: AGHT+IEUqaOuEdqFyjRc9hdKrymyf+2ksJWXSjdyiytMSmudkXoIUXXj/2dXksOWvYfxfS5mgow/2Mcwn31AjL7q8+c=
X-Received: by 2002:a05:6102:3709:b0:46d:2500:b3f5 with SMTP id
 s9-20020a056102370900b0046d2500b3f5mr4311719vst.35.1707756994833; Mon, 12 Feb
 2024 08:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-23-brgl@bgdev.pl> <202402122234.d85cca9b-lkp@intel.com>
In-Reply-To: <202402122234.d85cca9b-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 17:56:23 +0100
Message-ID: <CAMRc=MesjZVGTHQG0heP2OP8DNHPsiiPOv2JjKDpaTnvkyj6nA@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:11=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: c21131f83abc1f7227e7a6d5311e1df68bfa44e0 ("[PATCH v3 22/24] gpio:=
 protect the pointer to gpio_chip in gpio_device with SRCU")
> url: https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/g=
pio-protect-the-list-of-GPIO-devices-with-SRCU/20240208-180822
> base: https://git.kernel.org/cgit/linux/kernel/git/brgl/linux.git gpio/fo=
r-next
> patch link: https://lore.kernel.org/all/20240208095920.8035-23-brgl@bgdev=
pl/
> patch subject: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in=
 gpio_device with SRCU
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-----------------------------------------------------------------+------=
------+------------+
> |                                                                 | a3dfc=
11062 | c21131f83a |
> +-----------------------------------------------------------------+------=
------+------------+
> | drivers/gpio/gpiolib.c:#suspicious_rcu_dereference_check()usage | 0    =
      | 8          |
> | drivers/gpio/gpiolib.h:#suspicious_rcu_dereference_check()usage | 0    =
      | 8          |
> +-----------------------------------------------------------------+------=
------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.=
com
>
>
>
> [   76.432519][    T1] gpiochip_find_base_unlocked: found new base at 512
> [   76.434591][    T1]
> [   76.435240][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   76.436545][    T1] WARNING: suspicious RCU usage
> [   76.437813][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G       =
          N
> [   76.439873][    T1] -----------------------------
> [   76.441158][    T1] drivers/gpio/gpiolib.c:219 suspicious rcu_derefere=
nce_check() usage!
> [   76.443364][    T1]
> [   76.443364][    T1] other info that might help us debug this:
> [   76.443364][    T1]
> [   76.446059][    T1]
> [   76.446059][    T1] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   76.448217][    T1] 1 lock held by swapper/1:
> [ 76.449412][ T1] #0: ffff88816954f0f0 (&dev->mutex){....}-{3:3}, at: __d=
river_attach (drivers/base/dd.c:1216)
> [   76.451938][    T1]
> [   76.451938][    T1] stack backtrace:
> [   76.453486][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G            =
     N 6.8.0-rc1-00050-gc21131f83abc #1
> [   76.456114][    T1] Call Trace:
> [   76.456936][    T1]  <TASK>
> [ 76.457682][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 76.458833][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.=
h:153 kernel/locking/lockdep.c:6713)
> [ 76.460205][ T1] gpiod_to_chip (drivers/gpio/gpiolib.c:219 (discriminato=
r 9))
> [ 76.461346][ T1] gpiod_hog (drivers/gpio/gpiolib.h:243 drivers/gpio/gpio=
lib.c:4502)

Ah, gpiod_hog() is not taking the SRCU read lock as it should. I'll send a =
fix.

Bart

[snip]

