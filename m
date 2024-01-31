Return-Path: <linux-kernel+bounces-46130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE2843B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E815B2F785
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B467E6C;
	Wed, 31 Jan 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0sFeqxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9D633F5;
	Wed, 31 Jan 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693044; cv=none; b=l1a01iqHbSUf6AKbsSYmeR52o3yUh9F9EkRoOqjSC1HXYcSpPVzOAZtdDFZeuoQ9TU1YK6bcP4OkV+1JMlmwcz6H7aIeqN4XSndZDDSZQciD1Yn8twVvXM86s9Js795yxQXwKT3pITQtkH+xIg5PNFENxtSyVqdED7oavC2Ylfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693044; c=relaxed/simple;
	bh=hu5eQUJzfxsMEz0ZHG6ZMXFeXR3S/iIZlc98/mUeRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOmiA0ngqvcdPDFjmK+8bayOBtDVGvs7c8yAKbnWJ7Y0kOyFZntrZ0x1MtPrmXRmNySM4zzkveLAiGuwcBfwtinuTWv/9iNScN2dKXzWXWTeKkGOwH47O8L1OL4jGcJErXwksn1DarJH9nWxIm/+r+CzxUrot6yDurFLf1tzBNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0sFeqxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FA9C433C7;
	Wed, 31 Jan 2024 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706693042;
	bh=hu5eQUJzfxsMEz0ZHG6ZMXFeXR3S/iIZlc98/mUeRMM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=P0sFeqxLplgSoA1/dGpRmvNlZwDv+4XGS/+IJdEByRLpszgJxH1cZJhAIijWxkHQs
	 iTqzwEnmjb/hA/nSw3hiR2R2wdzSQa6KZN/Bmf5lOOsSFKB5qPLmMQ9NQH4SpxwTPL
	 5Gsnh5VTPWlZFKZAt3PvwKYBJfKCPG3DJsTfVMbfYJ6g/A3S49wfVfaWHWVcEeOQvq
	 +vohQxgCsOo/jfP0rMw9j5UD6o8li6h/jYuAJj5l9rnw95jonn377oMyniH6tXkYpO
	 tdZOd+eltzLBh5jqnNNdV3GnTnLjaBDfhobbr9Z69OdGmPOy9dvXr8g3AnsBYV1d1o
	 YpITa2GD2jsWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 481FECE04B6; Wed, 31 Jan 2024 01:24:02 -0800 (PST)
Date: Wed, 31 Jan 2024 01:24:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
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
Message-ID: <fa273f23-320a-465d-a403-523424d98e3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240130124828.14678-21-brgl@bgdev.pl>
 <202401311050.YNdm98Hv-lkp@intel.com>
 <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me0y-P4zTu_nCPpdF8hX_7rqri1AG1zCU6sO9tbJXbneQ@mail.gmail.com>

On Wed, Jan 31, 2024 at 10:02:40AM +0100, Bartosz Golaszewski wrote:
> On Wed, Jan 31, 2024 at 3:21 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bartosz,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on brgl/gpio/for-next]
> > [also build test WARNING on linus/master v6.8-rc2 next-20240130]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
> > patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40bgdev.pl
> > patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
> > config: x86_64-randconfig-122-20240131 (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm98Hv-lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
> >    drivers/gpio/gpiolib.c: note: in included file:
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> > >> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
> >    drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
> >
> > vim +444 drivers/gpio/gpiolib.c
> >
> >    422
> >    423  /*
> >    424   * Convert a GPIO name to its descriptor
> >    425   * Note that there is no guarantee that GPIO names are globally unique!
> >    426   * Hence this function will return, if it exists, a reference to the first GPIO
> >    427   * line found that matches the given name.
> >    428   */
> >    429  static struct gpio_desc *gpio_name_to_desc(const char * const name)
> >    430  {
> >    431          struct gpio_device *gdev;
> >    432          struct gpio_desc *desc;
> >    433          struct gpio_chip *gc;
> >    434
> >    435          if (!name)
> >    436                  return NULL;
> >    437
> >    438          guard(srcu)(&gpio_devices_srcu);
> >    439
> >    440          list_for_each_entry_srcu(gdev, &gpio_devices, list,
> >    441                                   srcu_read_lock_held(&gpio_devices_srcu)) {
> >    442                  guard(srcu)(&gdev->srcu);
> >    443
> >  > 444                  gc = rcu_dereference(gdev->chip);
> >    445                  if (!gc)
> >    446                          continue;
> >    447
> >    448                  for_each_gpio_desc(gc, desc) {
> >    449                          if (desc->name && !strcmp(desc->name, name))
> >    450                                  return desc;
> >    451                  }
> >    452          }
> >    453
> >    454          return NULL;
> >    455  }
> >    456
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> Paul,
> 
> Should I care about these warnings? They seem to be emitted for a lot
> of RCU code already upstream. I'm not even sure how I'd go about
> addressing them honestly.

This is maintainer's choice.

The fix would be to apply __rcu to the definition of ->chip.  The benefit
is that it finds bugs where rcu-protected pointers are used without RCU
primitives and vice versa.

							Thanx, Paul

