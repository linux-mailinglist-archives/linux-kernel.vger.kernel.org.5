Return-Path: <linux-kernel+bounces-45668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FE8433C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466D01F211AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC85C89;
	Wed, 31 Jan 2024 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYGjuM9b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509738DD1;
	Wed, 31 Jan 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667702; cv=none; b=uK575rY4KxcxeEK1Fkfs8BjmsvqYNzcEldL5Jaoa4i73wYImk+0rI4miOBb8H4mbkSLmeTkIb4gATFI77pfQz1M+eBGMBSHVBoGqTZlKY3BRC0z2DaK5MrN/sPo5PXTCIYddrlQXU7sqWCiBQXG0lmPNGqREP9dMmYAGaHLJUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667702; c=relaxed/simple;
	bh=th37S7Dg+8O94IslOUsTpOj05UGTSRkRzwjkJffUsj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP2HUmFY1bWXk33wS7opjjCtK8HhhroYuwSMDgm2GqVT1QH3PIeLYav/D6NhAo6fubDhKFD8LbRoAvAIr+zCNwlazN9zwAZW7BopRH9av9JnOBoRgQM2jZiQQSbreX+UnBqqdat0bbuIyqhH3cIq5+5du6TWN3BcSTLoaqPmKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYGjuM9b; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706667700; x=1738203700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=th37S7Dg+8O94IslOUsTpOj05UGTSRkRzwjkJffUsj8=;
  b=WYGjuM9bIsDYoFvgBTaG0wfihZrGbxdGlt44yVQoC03ZmsO/0S4a/vXF
   pmy7ud56dxWtRqlMviap26pKuo7gw/D8Lbli1jZsCL5kknmrM3i4CzWiM
   VSUqbH1CaholEUFU4oeK4S4UsyGeVqOtJEPWZggPoc/82exgz6EzO9aWO
   cCHPXCcdFjksMnQ0TihiSdrkw9OFr18Niht0ecUcDC2QgO11Sy07aL5Wt
   QBpOeRDsBAKAKskLOiKO++bHadG89X9Ehbvum0fhfXsKOfm2MgQ+7tctg
   6BwC8/mozptwTzCedI/dpjYKFNODbvMn/Tgm2HnrEqYqtA5njOhP5cmKi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10849216"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10849216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822407291"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822407291"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2024 18:21:36 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV0EF-00013k-2v;
	Wed, 31 Jan 2024 02:21:32 +0000
Date: Wed, 31 Jan 2024 10:20:40 +0800
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
Subject: Re: [PATCH 20/22] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <202401311050.YNdm98Hv-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.8-rc2 next-20240130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-protect-the-list-of-GPIO-devices-with-SRCU/20240130-205537
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20240130124828.14678-21-brgl%40bgdev.pl
patch subject: [PATCH 20/22] gpio: protect the pointer to gpio_chip in gpio_device with SRCU
config: x86_64-randconfig-122-20240131 (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311050.YNdm98Hv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311050.YNdm98Hv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpio/gpiolib.c:444:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:444:22: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:1103:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:1103:9: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:1182:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:1182:22: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:2970:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:2970:14: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:3004:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:3004:22: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:3585:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:3585:14: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:4772:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:4772:14: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c:4846:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.c:4846:14: sparse:    struct gpio_chip *
   drivers/gpio/gpiolib.c: note: in included file:
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *
>> drivers/gpio/gpiolib.h:202:1: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip [noderef] __rcu *
   drivers/gpio/gpiolib.h:202:1: sparse:    struct gpio_chip *

vim +444 drivers/gpio/gpiolib.c

   422	
   423	/*
   424	 * Convert a GPIO name to its descriptor
   425	 * Note that there is no guarantee that GPIO names are globally unique!
   426	 * Hence this function will return, if it exists, a reference to the first GPIO
   427	 * line found that matches the given name.
   428	 */
   429	static struct gpio_desc *gpio_name_to_desc(const char * const name)
   430	{
   431		struct gpio_device *gdev;
   432		struct gpio_desc *desc;
   433		struct gpio_chip *gc;
   434	
   435		if (!name)
   436			return NULL;
   437	
   438		guard(srcu)(&gpio_devices_srcu);
   439	
   440		list_for_each_entry_srcu(gdev, &gpio_devices, list,
   441					 srcu_read_lock_held(&gpio_devices_srcu)) {
   442			guard(srcu)(&gdev->srcu);
   443	
 > 444			gc = rcu_dereference(gdev->chip);
   445			if (!gc)
   446				continue;
   447	
   448			for_each_gpio_desc(gc, desc) {
   449				if (desc->name && !strcmp(desc->name, name))
   450					return desc;
   451			}
   452		}
   453	
   454		return NULL;
   455	}
   456	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

