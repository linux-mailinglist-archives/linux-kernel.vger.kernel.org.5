Return-Path: <linux-kernel+bounces-46147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A257C843B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5131F2C303
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC826996F;
	Wed, 31 Jan 2024 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEvgYj1D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981569941;
	Wed, 31 Jan 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693863; cv=none; b=N3B+pbgxdKal+mgOHIVTTm+uu3mojHSK4HKlJSTatsJaHeRHcp39fOCVzKOwwL5JIWN462uU4mRVVGM0ozdqhQxoaCTS3t+pfixrApLDgQ028mmzkjh8oYlmNTF8VMs4KYMe786lJU0q2jSbwOl3d3zr5xexpqAuP/1fu22X0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693863; c=relaxed/simple;
	bh=hR3CBMAREr/xNcwJYK+yDVMcP8chuolAWpvStyy2ikE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPnyUaj18zOtHphHOtRTbObak9RfrknEOYtytWPyP2h68ZBbEb+zZTGnsrIgjTFQnv843uhEKJybVs2LNHAiLfNeHon45oQRqYno/VN2y8yByrmYZGk6lnZvkHgxI2BLwNcYtW75yY3CC7SZ+EDxkS5KsfGe3WazDIpIRfYh3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEvgYj1D; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706693862; x=1738229862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hR3CBMAREr/xNcwJYK+yDVMcP8chuolAWpvStyy2ikE=;
  b=CEvgYj1DcCHR6cz9PD23/7+gsgU4jpcnPtu+dUOzhDrB1cGy/0/EasHz
   x6MU7Hb8kPxxNXb4hR917YsU95KyNS5j8O+Rh8ZpQUD03J1THRMfb4fAN
   HftU1QK7bCpwG9PNWJ3rNfFPoH/oyX/w//6o9Pjd1WIykjzzDZhz2k0Xo
   5P/uz3+uEYPvuGeL86DHFef5OZZLwLEN7odCT6ozjaMhYwZMY9sUXjv4B
   boc6zYpX/Hj1LJcq5lTiLEzLNw9SBR2ac3GwaCABPMO2C7nGt16+kTCoc
   ndreAYypOfyyVI3uEGMGSo5jK40bCoHVMk2tmJ7l9ykVihdC2nLSH756R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10215277"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10215277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 01:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822505467"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822505467"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2024 01:37:37 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV72C-0001PK-1K;
	Wed, 31 Jan 2024 09:37:33 +0000
Date: Wed, 31 Jan 2024 17:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 01/22] gpio: protect the list of GPIO devices with SRCU
Message-ID: <202401311746.be3dlVTg-lkp@intel.com>
References: <20240130124828.14678-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130124828.14678-2-brgl@bgdev.pl>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.8-rc2 next-20240131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240130124828.14678-2-brgl%40bgdev.pl
patch subject: [PATCH 01/22] gpio: protect the list of GPIO devices with SRCU
config: i386-randconfig-141-20240131 (https://download.01.org/0day-ci/archive/20240131/202401311746.be3dlVTg-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311746.be3dlVTg-lkp@intel.com/

New smatch warnings:
drivers/gpio/gpiolib.c:4167 gpiod_find_and_request() error: uninitialized symbol 'ret'.
drivers/gpio/gpiolib.c:4181 gpiod_find_and_request() error: uninitialized symbol 'desc'.

Old smatch warnings:
drivers/gpio/gpiolib.c:4184 gpiod_find_and_request() error: uninitialized symbol 'desc'.

vim +/ret +4167 drivers/gpio/gpiolib.c

0eadd36d9123745 Dmitry Torokhov     2022-09-03  4128  
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4129  static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4130  						struct fwnode_handle *fwnode,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4131  						const char *con_id,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4132  						unsigned int idx,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4133  						enum gpiod_flags flags,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4134  						const char *label,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4135  						bool platform_lookup_allowed)
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4136  {
ba2dc1cb5491712 Hans de Goede       2022-12-29  4137  	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
c122f461ccac0e7 Andy Shevchenko     2023-03-09  4138  	struct gpio_desc *desc;
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4139  	int ret;
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4140  
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4141  	scoped_guard(srcu, &gpio_devices_srcu) {
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4142  		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4143  					    &flags, &lookupflags);
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4144  		if (gpiod_not_found(desc) && platform_lookup_allowed) {
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4145  			/*
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4146  			 * Either we are not using DT or ACPI, or their lookup
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4147  			 * did not return a result. In that case, use platform
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4148  			 * lookup as a fallback.
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4149  			 */
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4150  			dev_dbg(consumer,
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4151  				"using lookup tables for GPIO lookup\n");
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4152  			desc = gpiod_find(consumer, con_id, idx, &lookupflags);
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4153  		}
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4154  
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4155  		if (IS_ERR(desc)) {
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4156  			dev_dbg(consumer, "No GPIO consumer %s found\n",
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4157  				con_id);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4158  			return desc;
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4159  		}
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4160  
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4161  		/*
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4162  		 * If a connection label was passed use that, else attempt to use
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4163  		 * the device name as label
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4164  		 */
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4165  		ret = gpiod_request(desc, label);
1fe5210a1bfba00 Bartosz Golaszewski 2024-01-30  4166  	}
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11 @4167  	if (ret) {
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4168  		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4169  			return ERR_PTR(ret);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4170  
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4171  		/*
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4172  		 * This happens when there are several consumers for
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4173  		 * the same GPIO line: we just return here without
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4174  		 * further initialization. It is a bit of a hack.
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4175  		 * This is necessary to support fixed regulators.
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4176  		 *
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4177  		 * FIXME: Make this more sane and safe.
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4178  		 */
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4179  		dev_info(consumer,
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4180  			 "nonexclusive access to GPIO for %s\n", con_id);
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11 @4181  		return desc;
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4182  	}
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4183  
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4184  	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4185  	if (ret < 0) {
8eb1f71e7acca4f Dmitry Torokhov     2022-11-11  4186  		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4187  		gpiod_put(desc);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4188  		return ERR_PTR(ret);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4189  	}
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4190  
9ce4ed5b4db1363 Bartosz Golaszewski 2023-08-21  4191  	gpiod_line_state_notify(desc, GPIOLINE_CHANGED_REQUESTED);
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4192  
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4193  	return desc;
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4194  }
0eadd36d9123745 Dmitry Torokhov     2022-09-03  4195  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

