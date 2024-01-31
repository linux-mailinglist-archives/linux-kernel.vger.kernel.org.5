Return-Path: <linux-kernel+bounces-46299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2E843DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471FD1F28B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954F745C8;
	Wed, 31 Jan 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y20puwzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FF6A353;
	Wed, 31 Jan 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698837; cv=none; b=aB1bkCAiVbwMakVR9domLZYh5kI6UhibCq0K6xk7H8UvrahWQPw41G9+yTNfArO25N+UtMwt2B3Tvi/QzqXnAQLM8wiG0NmQn30UkY9cg4c+/STmtsizFt8OEAygovpX6Ehpnz+bkiFWFMks34Qa89WD/2DrxqgIwRRGJC42nPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698837; c=relaxed/simple;
	bh=M4FtRNaJRGX1hU6IbURFv7FbIXOuZSMJpHIp14hyZwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBeypV0jF7ZJyAjVcpY9YuoV379AqVcJuPp1EZUv93vGJwkJfSBrMILu7c7JMNMk7C2EkHurhBVQn5VcUh2yzaZPl3BYqXvA0LwPQvg/oW9GRQZm6SRZzzabE6JoYzJmdIN4LGrTyADSchthrE72IZCgk5rVmy5+vSFu9W9BXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y20puwzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCF5C433F1;
	Wed, 31 Jan 2024 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706698837;
	bh=M4FtRNaJRGX1hU6IbURFv7FbIXOuZSMJpHIp14hyZwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y20puwzLdo/kirgWBFWjcmKYOlA/ZF4xNYVnC83MgAugYyoVJspVVkLreGJKZ3X4R
	 0Y/BgCdGgtgtqjP3LksfVvY2tdD80blY9kS23yS2QCwO0KXg0aZl+Qk6Z8h4ead78R
	 W7zU6hHIy7Tqq9NxR04pmdF5jWoXA96723OWR3ux3bAUDh3SITHVlmV/8ubepVm75s
	 xmw5nE6l36S3o+Pmyfl/mVVAUHM4kcoQSnGZMrB6KC76OIZxH/dLFTZ5a5kPlCb3CL
	 TkvEy3Qb3BCkxw011+VwoytVmb31DEsWpbT0oCm27YFWSIB+ORJ4Qfwnme4JlIpWvT
	 /2TbbbZCKFgtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB1D2CE04B6; Wed, 31 Jan 2024 03:00:36 -0800 (PST)
Date: Wed, 31 Jan 2024 03:00:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: brgl@bgdev.pl
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <d0636911-e15e-40fd-ac8f-200127fe433d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240130124828.14678-21-brgl@bgdev.pl>
 <202401311050.YNdm98Hv-lkp@intel.com>
 <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>
 <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop>
 <CAMRc=MdoG1Ku-hbBWt7Jc+d4=ANfshPWwW3C_G-e2GdyggqG1w@mail.gmail.com>
 <26942a3c-efc9-4344-9fac-c5feea06639c@paulmck-laptop>
 <CAMRc=MdYbGH8Q0Wk_40RV=_HN86oYg146bz-TeYp1KKwSoEhGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdYbGH8Q0Wk_40RV=_HN86oYg146bz-TeYp1KKwSoEhGw@mail.gmail.com>

On Wed, Jan 31, 2024 at 02:17:30AM -0800, brgl@bgdev.pl wrote:
> On Wed, 31 Jan 2024 10:42:20 +0100, "Paul E. McKenney"
> <paulmck@kernel.org> said:
> > On Wed, Jan 31, 2024 at 10:28:19AM +0100, Bartosz Golaszewski wrote:
> >> On Wed, Jan 31, 2024 at 10:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >> >
> >> > On Wed, Jan 31, 2024 at 10:02:40AM +0100, Bartosz Golaszewski wrote:
> >> > > On Wed, Jan 31, 2024 at 3:21 AM kernel test robot <lkp@intel.com> wrote:
> >> > > >
> >> > > > Hi Bartosz,
> >> > > >
> >> > > > kernel test robot noticed the following build warnings:
> >> > > >
> >> > > > [auto build test WARNING on brgl/gpio/for-next]
> >> > > > [also build test WARNING on linus/master v6.8-rc2 next-20240130]
> >> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> > > > And when submitting patch, we suggest to use '--base' as documented in
> >> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >> > > >
> >> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
> >> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
> >> > > > patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40bgdev.pl
> >> > > > patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
> >> > > > config: x86_64-randconfig-122-20240131 (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
> >> > > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> >> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
> >> > > >
> >> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> > > > the same patch/commit), kindly add following tags
> >> > > > | Reported-by: kernel test robot <lkp@intel.com>
> >> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm98Hv-lkp@intel.com/
> >> > > >
> >> > > > sparse warnings: (new ones prefixed by >>)
> >> > > > >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
> >> > > >    drivers/gpio/gpiolib.c: note: in included file:
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >> > > >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >> > > >
> >> > > > vim +444 drivers/gpio/gpiolib.c
> >> > > >
> >> > > >    422
> >> > > >    423  /*
> >> > > >    424   * Convert a GPIO name to its descriptor
> >> > > >    425   * Note that there is no guarantee that GPIO names are globally unique!
> >> > > >    426   * Hence this function will return, if it exists, a reference to the first GPIO
> >> > > >    427   * line found that matches the given name.
> >> > > >    428   */
> >> > > >    429  static struct gpio_desc *gpio_name_to_desc(const char * const name)
> >> > > >    430  {
> >> > > >    431          struct gpio_device *gdev;
> >> > > >    432          struct gpio_desc *desc;
> >> > > >    433          struct gpio_chip *gc;
> >> > > >    434
> >> > > >    435          if (!name)
> >> > > >    436                  return NULL;
> >> > > >    437
> >> > > >    438          guard(srcu)(&gpio_devices_srcu);
> >> > > >    439
> >> > > >    440          list_for_each_entry_srcu(gdev, &gpio_devices, list,
> >> > > >    441                                   srcu_read_lock_held(&gpio_devices_srcu)) {
> >> > > >    442                  guard(srcu)(&gdev->srcu);
> >> > > >    443
> >> > > >  > 444                  gc = rcu_dereference(gdev->chip);
> >> > > >    445                  if (!gc)
> >> > > >    446                          continue;
> >> > > >    447
> >> > > >    448                  for_each_gpio_desc(gc, desc) {
> >> > > >    449                          if (desc->name && !strcmp(desc->name, name))
> >> > > >    450                                  return desc;
> >> > > >    451                  }
> >> > > >    452          }
> >> > > >    453
> >> > > >    454          return NULL;
> >> > > >    455  }
> >> > > >    456
> >> > > >
> >> > > > --
> >> > > > 0-DAY CI Kernel Test Service
> >> > > > https://github.com/intel/lkp-tests/wiki
> >> > >
> >> > > Paul,
> >> > >
> >> > > Should I care about these warnings? They seem to be emitted for a lot
> >> > > of RCU code already upstream. I'm not even sure how I'd go about
> >> > > addressing them honestly.
> >> >
> >> > This is maintainer's choice.
> >> >
> >> > The fix would be to apply __rcu to the definition of ->chip.  The benefit
> >> > is that it finds bugs where rcu-protected pointers are used without RCU
> >> > primitives and vice versa.
> >>
> >> Ah, good point. I marked the other RCU-protected fields like
> >> descriptor label but forgot this one.
> >>
> >> It also seems like I need to use __rcu for all function arguments
> >> taking an RCU-protected pointer as argument?
> >
> > Not if that argument gets its value from rcu_dereference(), which is
> > the usual pattern.
> >
> > And if you are passing an RCU-protected pointer to a function *before*
> > passing it through rcu_dereference(), I would have some questions for you.
> >
> > Or are you instead passing a pointer to an RCU-protected pointer as an
> > argument to your functions?
> 
> No, I'm not. Thanks for making it clear. With the following changes to the
> series, the warnings are now gone:
> 
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 6a421309319e..15349f92d0ec 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -762,7 +762,7 @@ EXPORT_SYMBOL_GPL(gpiod_unexport);
> 
>  int gpiochip_sysfs_register(struct gpio_device *gdev)
>  {
> -	struct gpio_chip *chip = gdev->chip;
> +	struct gpio_chip *chip;

This is protected by an update-side lock, correct?

>  	struct device *parent;
>  	struct device *dev;
> 
> @@ -775,6 +775,12 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
>  	if (!class_is_registered(&gpio_class))
>  		return 0;
> 
> +	guard(srcu)(&gdev->srcu);
> +
> +	chip = rcu_dereference(gdev->chip);

If so, you rely on that lock's protection by replacing the above
two lines of code with something like this:

	chip = rcu_dereference_protected(gdev->chip,
					 lockdep_is_held(&my_lock));

> +	if (!chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * For sysfs backward compatibility we need to preserve this
>  	 * preferred parenting to the gpio_chip parent field, if set.
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7ecdd8cc39c5..ea0675514891 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -221,7 +221,7 @@ struct gpio_chip *gpiod_to_chip(const struct
> gpio_desc *desc)
>  {
>  	if (!desc)
>  		return NULL;
> -	return desc->gdev->chip;
> +	return rcu_dereference(desc->gdev->chip);
>  }
>  EXPORT_SYMBOL_GPL(gpiod_to_chip);
> 
> @@ -291,7 +291,7 @@ EXPORT_SYMBOL(gpio_device_get_label);
>   */
>  struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
>  {
> -	return gdev->chip;
> +	return rcu_dereference(gdev->chip);
>  }
>  EXPORT_SYMBOL_GPL(gpio_device_get_chip);
> 
> @@ -742,7 +742,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
>  		goto err_remove_device;
> 
>  	dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->base,
> -		gdev->base + gdev->ngpio - 1, gdev->chip->label ? : "generic");
> +		gdev->base + gdev->ngpio - 1, gdev->label);

I don't know enough to comment here, but the rest of the look good to me.

>  	return 0;
> 
> @@ -866,7 +866,7 @@ int gpiochip_add_data_with_key(struct gpio_chip
> *gc, void *data,
>  		return -ENOMEM;
>  	gdev->dev.bus = &gpio_bus_type;
>  	gdev->dev.parent = gc->parent;
> -	WRITE_ONCE(gdev->chip, gc);
> +	rcu_assign_pointer(gdev->chip, gc);
> 
>  	gc->gpiodev = gdev;
>  	gpiochip_set_data(gc, data);
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index c76acb8f95c6..07443d26cbca 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -59,7 +59,7 @@ struct gpio_device {
>  	int			id;
>  	struct device		*mockdev;
>  	struct module		*owner;
> -	struct gpio_chip	*chip;
> +	struct gpio_chip __rcu	*chip;
>  	struct gpio_desc	*descs;
>  	int			base;
>  	u16			ngpio;
> 
> Bartosz

