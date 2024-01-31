Return-Path: <linux-kernel+bounces-46413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69C843F55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827F1291740
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67BD78B64;
	Wed, 31 Jan 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vvdZ4UeT"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB0768F8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703821; cv=none; b=a4gjoNM70KveIsfHQU56H3j0bF/fQxiCRltQY154EyCW617jGQUFbQtc6pzaglSmat4Fv6nUs3jcJiFASHW9DEVu5DRo3Xf4Anmxr6EngWDgA9hmjVFttksZM/0IC9wPmuhS8PfQw9NLVYvY999fslvk75GbSeJP57NpjHFGQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703821; c=relaxed/simple;
	bh=c33Er1TeSS9rz3xr8baQWgOAzTz5Cap8ABpKfSjpLxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARdsyiZmjSUFNtJQrUy085XkND/8C4Ubmdkg5EwL/dxFaGbdTS19ntcLSLkHi7iTi4SEfJ4ST04X2hpY1OJbbFiSmODqms6PUpPQeEUDwSsWHacbNZrfpzt0cDDwrKdWbOFt9DWSWuAmsS7eX5PvAWYcmNSi48f8nmRF9paW9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vvdZ4UeT; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so2259664241.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706703817; x=1707308617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDZ0y3K1vALYkXWEBA8kQjuf+xPFq63N9uh4loLDWC4=;
        b=vvdZ4UeTZKYXCKxg1dqFXpVQfGq0oswPgu1rp4VPzsfPmxtoMvoteidkfTZkiRKz+h
         7S9Rk1GAoUUWNgzbzip/CBNbJrZwiN0HLqy2PHH3XJDwGjFozU9NfuMXrW/f8+qimR43
         nte8or/5WznCk0QsKYcSmM1RZTW+9pa9+jHQwL2JYxQZ6tLJVrMiOnWG+S7sVZBlnNwm
         utPzRaD3UJv6CNGkg6O7H5Au6awEX1pcrxj6xiUeObljhwfAc4X33QaZStTY6TvlrmBk
         RVf4IogH6dkQUMQHq72P6hP14tfhzs4ZKlCL+0RtS0NLyyVc9isFPghvDBgga+Pmvq4y
         1+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706703817; x=1707308617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDZ0y3K1vALYkXWEBA8kQjuf+xPFq63N9uh4loLDWC4=;
        b=TofQOM2OHecLlnG+Bc25RPa02Ork5Fulxg/gWYQ12XQMEDeYXWi44rqe+Z6bNqJYth
         cVS9345vRZ7/azO2V5g38bOztXJT5nyvmhzi6aQQX4QQtoId33jgqZUe9o7g5KZyRK3I
         woWzOJgVIiP6ga4vnoR7x1ewY5tuwyZwQhQGtUBi0FjlPlkZSmKrwWqGKzEsspDK/xGw
         mmfMEit0Ebd/1DtPCFYbtqA525XSSMpuqI6+zWsZanqqNZ19hRV4vNxRB/EeqZiM/VHE
         B+0cwM4+jOvSr+OA/pvwOccxfzwunAGmYjh3tMDdHy+gLBEl8UUsWCkzfS3Bk5BLrt2Y
         VVYg==
X-Gm-Message-State: AOJu0YwNq/YzwyVdVV3T72RsMpdln6/m/oH1CZUCL4yFvITI/tS5zurq
	0ssm/lAahhNy1iT+UOaeUVg0SE8Za3hTHBYviNdsOUOnqWMsJsKK6SqQi2/msPj2775qG+qqRan
	LGCqSrWGEWOUeM96+jVhFqkqE/4Pk9ezdI64IJA==
X-Google-Smtp-Source: AGHT+IF9RqTOC7U+znvapFpJidadVp5RRGvimqCN6BZKduefb5aa59V6Kr6unPXxP/Mdo9Tassgfe7gEDjhsdpbMS+g=
X-Received: by 2002:a05:6102:356a:b0:46a:ff02:1ae with SMTP id
 bh10-20020a056102356a00b0046aff0201aemr994530vsb.60.1706703817103; Wed, 31
 Jan 2024 04:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-21-brgl@bgdev.pl> <202401311050.YNdm98Hv-lkp@intel.com>
 <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>
 <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop> <CAMRc=MdoG1Ku-hbBWt7Jc+d4=ANfshPWwW3C_G-e2GdyggqG1w@mail.gmail.com>
 <26942a3c-efc9-4344-9fac-c5feea06639c@paulmck-laptop> <CAMRc=MdYbGH8Q0Wk_40RV=_HN86oYg146bz-TeYp1KKwSoEhGw@mail.gmail.com>
 <d0636911-e15e-40fd-ac8f-200127fe433d@paulmck-laptop>
In-Reply-To: <d0636911-e15e-40fd-ac8f-200127fe433d@paulmck-laptop>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 13:23:25 +0100
Message-ID: <CAMRc=McVdOyV-dHR5J7vBBP0pQu1TDTjspoAjMtsGuy4HZukkA@mail.gmail.com>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: paulmck@kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Alex Elder <elder@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, oe-kbuild-all@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:00=E2=80=AFPM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Wed, Jan 31, 2024 at 02:17:30AM -0800, brgl@bgdev.pl wrote:
> > On Wed, 31 Jan 2024 10:42:20 +0100, "Paul E. McKenney"
> > <paulmck@kernel.org> said:
> > > On Wed, Jan 31, 2024 at 10:28:19AM +0100, Bartosz Golaszewski wrote:
> > >> On Wed, Jan 31, 2024 at 10:24=E2=80=AFAM Paul E. McKenney <paulmck@k=
ernel.org> wrote:
> > >> >
> > >> > On Wed, Jan 31, 2024 at 10:02:40AM +0100, Bartosz Golaszewski wrot=
e:
> > >> > > On Wed, Jan 31, 2024 at 3:21=E2=80=AFAM kernel test robot <lkp@i=
ntel.com> wrote:
> > >> > > >
> > >> > > > Hi Bartosz,
> > >> > > >
> > >> > > > kernel test robot noticed the following build warnings:
> > >> > > >
> > >> > > > [auto build test WARNING on brgl/gpio/for-next]
> > >> > > > [also build test WARNING on linus/master v6.8-rc2 next-2024013=
0]
> > >> > > > [If your patch is applied to the wrong git tree, kindly drop u=
s a note.
> > >> > > > And when submitting patch, we suggest to use '--base' as docum=
ented in
> > >> > > > https://git-scm.com/docs/git-format-patch#_base_tree_informati=
on]
> > >> > > >
> > >> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz=
-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-20553=
7
> > >> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/l=
inux.git gpio/for-next
> > >> > > > patch link:    https://lore.kernel.org/r/20240130124828.14678-=
21-brgl%40bgdev.pl
> > >> > > > patch subject: [PATCH 20/22] gpio: protect the pointer to gpio=
_chip in gpio_device with SRCU
> > >> > > > config: x86_64-randconfig-122-20240131 (https://download.01.or=
g/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
> > >> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > >> > > > reproduce (this is a W=3D1 build): (https://download.01.org/0d=
ay-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
> > >> > > >
> > >> > > > If you fix the issue in a separate patch/commit (i.e. not just=
 a new version of
> > >> > > > the same patch/commit), kindly add following tags
> > >> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > >> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.Y=
Ndm98Hv-lkp@intel.com/
> > >> > > >
> > >> > > > sparse warnings: (new ones prefixed by >>)
> > >> > > > >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible=
 types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip =
[noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip =
*
> > >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible=
 types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip =
[noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip =
*
> > >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatibl=
e types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip=
 [noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip=
 *
> > >> > > >    drivers/gpio/gpiolib.c: note: in included file:
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible =
types in comparison expression (different address spaces):
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [=
noderef] __rcu *
> > >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> > > >
> > >> > > > vim +444 drivers/gpio/gpiolib.c
> > >> > > >
> > >> > > >    422
> > >> > > >    423  /*
> > >> > > >    424   * Convert a GPIO name to its descriptor
> > >> > > >    425   * Note that there is no guarantee that GPIO names are=
 globally unique!
> > >> > > >    426   * Hence this function will return, if it exists, a re=
ference to the first GPIO
> > >> > > >    427   * line found that matches the given name.
> > >> > > >    428   */
> > >> > > >    429  static struct gpio_desc *gpio_name_to_desc(const char =
* const name)
> > >> > > >    430  {
> > >> > > >    431          struct gpio_device *gdev;
> > >> > > >    432          struct gpio_desc *desc;
> > >> > > >    433          struct gpio_chip *gc;
> > >> > > >    434
> > >> > > >    435          if (!name)
> > >> > > >    436                  return NULL;
> > >> > > >    437
> > >> > > >    438          guard(srcu)(&gpio_devices_srcu);
> > >> > > >    439
> > >> > > >    440          list_for_each_entry_srcu(gdev, &gpio_devices, =
list,
> > >> > > >    441                                   srcu_read_lock_held(&=
gpio_devices_srcu)) {
> > >> > > >    442                  guard(srcu)(&gdev->srcu);
> > >> > > >    443
> > >> > > >  > 444                  gc =3D rcu_dereference(gdev->chip);
> > >> > > >    445                  if (!gc)
> > >> > > >    446                          continue;
> > >> > > >    447
> > >> > > >    448                  for_each_gpio_desc(gc, desc) {
> > >> > > >    449                          if (desc->name && !strcmp(desc=
->name, name))
> > >> > > >    450                                  return desc;
> > >> > > >    451                  }
> > >> > > >    452          }
> > >> > > >    453
> > >> > > >    454          return NULL;
> > >> > > >    455  }
> > >> > > >    456
> > >> > > >
> > >> > > > --
> > >> > > > 0-DAY CI Kernel Test Service
> > >> > > > https://github.com/intel/lkp-tests/wiki
> > >> > >
> > >> > > Paul,
> > >> > >
> > >> > > Should I care about these warnings? They seem to be emitted for =
a lot
> > >> > > of RCU code already upstream. I'm not even sure how I'd go about
> > >> > > addressing them honestly.
> > >> >
> > >> > This is maintainer's choice.
> > >> >
> > >> > The fix would be to apply __rcu to the definition of ->chip.  The =
benefit
> > >> > is that it finds bugs where rcu-protected pointers are used withou=
t RCU
> > >> > primitives and vice versa.
> > >>
> > >> Ah, good point. I marked the other RCU-protected fields like
> > >> descriptor label but forgot this one.
> > >>
> > >> It also seems like I need to use __rcu for all function arguments
> > >> taking an RCU-protected pointer as argument?
> > >
> > > Not if that argument gets its value from rcu_dereference(), which is
> > > the usual pattern.
> > >
> > > And if you are passing an RCU-protected pointer to a function *before=
*
> > > passing it through rcu_dereference(), I would have some questions for=
 you.
> > >
> > > Or are you instead passing a pointer to an RCU-protected pointer as a=
n
> > > argument to your functions?
> >
> > No, I'm not. Thanks for making it clear. With the following changes to =
the
> > series, the warnings are now gone:
> >
> > diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.=
c
> > index 6a421309319e..15349f92d0ec 100644
> > --- a/drivers/gpio/gpiolib-sysfs.c
> > +++ b/drivers/gpio/gpiolib-sysfs.c
> > @@ -762,7 +762,7 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);
> >
> >  int gpiochip_sysfs_register(struct gpio_device *gdev)
> >  {
> > -     struct gpio_chip *chip =3D gdev->chip;
> > +     struct gpio_chip *chip;
>
> This is protected by an update-side lock, correct?
>

No, it may be called from two places. One needs to be protected (it
isn't in my series but I'll fix it), the other does not as we are
holding the pointer to gdev already.

> >       struct device *parent;
> >       struct device *dev;
> >
> > @@ -775,6 +775,12 @@ int gpiochip_sysfs_register(struct gpio_device *gd=
ev)
> >       if (!class_is_registered(&gpio_class))
> >               return 0;
> >
> > +     guard(srcu)(&gdev->srcu);
> > +
> > +     chip =3D rcu_dereference(gdev->chip);
>
> If so, you rely on that lock's protection by replacing the above
> two lines of code with something like this:
>
>         chip =3D rcu_dereference_protected(gdev->chip,
>                                          lockdep_is_held(&my_lock));
>

Thanks, I'll see if I can use it elsewhere.

Bart

> > +     if (!chip)
> > +             return -ENODEV;
> > +
> >       /*
> >        * For sysfs backward compatibility we need to preserve this
> >        * preferred parenting to the gpio_chip parent field, if set.
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 7ecdd8cc39c5..ea0675514891 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -221,7 +221,7 @@ struct gpio_chip *gpiod_to_chip(const struct
> > gpio_desc *desc)
> >  {
> >       if (!desc)
> >               return NULL;
> > -     return desc->gdev->chip;
> > +     return rcu_dereference(desc->gdev->chip);
> >  }
> >  EXPORT_SYMBOL_GPL(gpiod_to_chip);
> >
> > @@ -291,7 +291,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
> >   */
> >  struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
> >  {
> > -     return gdev->chip;
> > +     return rcu_dereference(gdev->chip);
> >  }
> >  EXPORT_SYMBOL_GPL(gpio_device_get_chip);
> >
> > @@ -742,7 +742,7 @@ static int gpiochip_setup_dev(struct gpio_device *g=
dev)
> >               goto err_remove_device;
> >
> >       dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->ba=
se,
> > -             gdev->base + gdev->ngpio - 1, gdev->chip->label ? : "gene=
ric");
> > +             gdev->base + gdev->ngpio - 1, gdev->label);
>
> I don't know enough to comment here, but the rest of the look good to me.
>
> >       return 0;
> >
> > @@ -866,7 +866,7 @@ int gpiochip_add_data_with_key(struct gpio_chip
> > *gc, void *data,
> >               return -ENOMEM;
> >       gdev->dev.bus =3D &gpio_bus_type;
> >       gdev->dev.parent =3D gc->parent;
> > -     WRITE_ONCE(gdev->chip, gc);
> > +     rcu_assign_pointer(gdev->chip, gc);
> >
> >       gc->gpiodev =3D gdev;
> >       gpiochip_set_data(gc, data);
> > diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> > index c76acb8f95c6..07443d26cbca 100644
> > --- a/drivers/gpio/gpiolib.h
> > +++ b/drivers/gpio/gpiolib.h
> > @@ -59,7 +59,7 @@ struct gpio_device {
> >       int                     id;
> >       struct device           *mockdev;
> >       struct module           *owner;
> > -     struct gpio_chip        *chip;
> > +     struct gpio_chip __rcu  *chip;
> >       struct gpio_desc        *descs;
> >       int                     base;
> >       u16                     ngpio;
> >
> > Bartosz

