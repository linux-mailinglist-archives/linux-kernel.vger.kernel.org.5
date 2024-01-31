Return-Path: <linux-kernel+bounces-45538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD6843227
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8B8B25335
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF122103;
	Wed, 31 Jan 2024 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/DQZK3d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34371184F;
	Wed, 31 Jan 2024 00:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661709; cv=none; b=j6CdVyp9tEy+90/rsKxZ/3imsW/KMZOcWP/KA8pcsoFqo7qvx5CSso7qqCzCb3CRUGA8uPf7TBVATTmtAbgRozgNjO1thFPSQM8EW4sGJY+1yNKcu8zTXvd/3eZMN4rjjzfI+qYJHkxKLkLL85yCPnD9QPjb85NxoUEmab5/lzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661709; c=relaxed/simple;
	bh=9BaXRayDarka3tfQ5PcIrOs9aOl+SKm73lmSiJa5rBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWD5A6rvWvJmPYfnvZHzfYov9bz36wA/cauPCGafI1yas6YXsVBB9cvvK+Yj2YBy3rCwSmmgxS6X09DoLRxTFOO29bUdfXhYl2bZMAjsQurNw+uH34dU/j9VmmguguQDu6awVEiNAoImtJrUUAewE00XFgn8fGYR6dxcY/SMeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/DQZK3d; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706661707; x=1738197707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BaXRayDarka3tfQ5PcIrOs9aOl+SKm73lmSiJa5rBM=;
  b=j/DQZK3deJSkcLR/SvrKnGoN/DctOVNV8dlEou7PGqS9XLqpX2woLxFe
   pCXX9Ls24GJWmVWMvX4aya+lHJRDUZN0Xp9Y6l4cOFKreWtYPvgajNv7j
   VqG6zIA8WUCJzK6VyFFJ9LsSEVKTUvB5hexlMgj7kxyiRk8wEMIAj6/4k
   OnK0fXgmelbRni8ZG9/s13anY7zZEMnBozist3iFG8THv1SRitOYuXtu2
   HW1LXR9GP/P+eZYxOMgpHeb+NIZ6y9x4COezr5JUt3KnKkwKe55jdEdBa
   DQDJuoyRV7mFfBmXm9RpmpzHj4fQrWobK3b4A+76Q6IUzbpsqz/Qmz9Uj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2385038"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2385038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 16:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858638284"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="858638284"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jan 2024 16:41:43 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUyfc-0000yy-26;
	Wed, 31 Jan 2024 00:41:40 +0000
Date: Wed, 31 Jan 2024 08:41:11 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <202401310855.aA6wzlm2-lkp@intel.com>
References: <20240130124828.14678-21-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130124828.14678-21-brgl@bgdev.pl>

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.8-rc2 next-20240130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40bgdev.pl
patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
config: x86_64-buildonly-randconfig-004-20240131 (https://download.01.org/0day-ci/archive/20240131/202401310855.aA6wzlm2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401310855.aA6wzlm2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401310855.aA6wzlm2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpio/gpiolib-sysfs.c:481:3: error: cannot jump from this goto statement to its label
     481 |                 goto done;
         |                 ^
   drivers/gpio/gpiolib-sysfs.c:490:25: note: jump bypasses initialization of variable with __attribute__((cleanup))
     490 |         CLASS(gpio_chip_guard, guard)(desc);
         |                                ^
   1 error generated.


vim +481 drivers/gpio/gpiolib-sysfs.c

0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  464  
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  465  /*
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  466   * /sys/class/gpio/export ... write-only
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  467   *	integer N ... number of GPIO to export (full access)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  468   * /sys/class/gpio/unexport ... write-only
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  469   *	integer N ... number of GPIO to unexport
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  470   */
75a2d4226b5371 Greg Kroah-Hartman  2023-03-25  471  static ssize_t export_store(const struct class *class,
75a2d4226b5371 Greg Kroah-Hartman  2023-03-25  472  				const struct class_attribute *attr,
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  473  				const char *buf, size_t len)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  474  {
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  475  	struct gpio_desc *desc;
513246a34b8dc5 Bartosz Golaszewski 2023-12-21  476  	int status, offset;
513246a34b8dc5 Bartosz Golaszewski 2023-12-21  477  	long gpio;
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  478  
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  479  	status = kstrtol(buf, 0, &gpio);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  480  	if (status < 0)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01 @481  		goto done;
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  482  
f13a0b0bb46f07 Linus Walleij       2018-09-13  483  	desc = gpio_to_desc(gpio);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  484  	/* reject invalid GPIOs */
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  485  	if (!desc) {
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  486  		pr_warn("%s: invalid GPIO %ld\n", __func__, gpio);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  487  		return -EINVAL;
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  488  	}
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  489  
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  490  	CLASS(gpio_chip_guard, guard)(desc);
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  491  	if (!guard.gc)
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  492  		return -ENODEV;
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  493  
23cf00ddd2e1aa Matti Vaittinen     2021-03-29  494  	offset = gpio_chip_hwgpio(desc);
2796d5332f8ac8 Bartosz Golaszewski 2024-01-30  495  	if (!gpiochip_line_is_valid(guard.gc, offset)) {
23cf00ddd2e1aa Matti Vaittinen     2021-03-29  496  		pr_warn("%s: GPIO %ld masked\n", __func__, gpio);
23cf00ddd2e1aa Matti Vaittinen     2021-03-29  497  		return -EINVAL;
23cf00ddd2e1aa Matti Vaittinen     2021-03-29  498  	}
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  499  
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  500  	/* No extra locking here; FLAG_SYSFS just signifies that the
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  501  	 * request and export were done by on behalf of userspace, so
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  502  	 * they may be undone on its behalf too.
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  503  	 */
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  504  
95a4eed7dd5b7c Andy Shevchenko     2022-02-01  505  	status = gpiod_request_user(desc, "sysfs");
95a4eed7dd5b7c Andy Shevchenko     2022-02-01  506  	if (status)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  507  		goto done;
e10f72bf4b3e88 Andrew Jeffery      2017-11-30  508  
e10f72bf4b3e88 Andrew Jeffery      2017-11-30  509  	status = gpiod_set_transitory(desc, false);
95dd1e34ff5bbe Boerge Struempfel   2023-11-29  510  	if (status) {
95dd1e34ff5bbe Boerge Struempfel   2023-11-29  511  		gpiod_free(desc);
95dd1e34ff5bbe Boerge Struempfel   2023-11-29  512  		goto done;
95dd1e34ff5bbe Boerge Struempfel   2023-11-29  513  	}
95dd1e34ff5bbe Boerge Struempfel   2023-11-29  514  
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  515  	status = gpiod_export(desc, true);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  516  	if (status < 0)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  517  		gpiod_free(desc);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  518  	else
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  519  		set_bit(FLAG_SYSFS, &desc->flags);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  520  
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  521  done:
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  522  	if (status)
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  523  		pr_debug("%s: status %d\n", __func__, status);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  524  	return status ? : len;
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  525  }
d83bb159f4c6af Greg Kroah-Hartman  2017-06-08  526  static CLASS_ATTR_WO(export);
0eb4c6c2671ca0 Alexandre Courbot   2014-07-01  527  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

