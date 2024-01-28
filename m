Return-Path: <linux-kernel+bounces-41551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9883F45E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB50B224C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B0D51A;
	Sun, 28 Jan 2024 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLYAR48w"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56AC129;
	Sun, 28 Jan 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706423963; cv=none; b=lAEQ2N8JJWRNmotVKp25w3hKMiXViySUTnW9TJZBI+hSdvmEK7nN0LHWB8n/Ms+C7XnTXR3zZxJtQTkenXbJbzFD3kgTUs/ApPCO97l8ZH6I3rYR9mUB28LQUyrX9YDqZEmaGvd+WnQ1GIRDOM8dRIJfwcP74AhMkBsDPX0Ws2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706423963; c=relaxed/simple;
	bh=4lijp4ucfB/6jErrAcwvyyricA31fH+Gjfga3LbNXWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbJdeA79uLWtYAvp44yibSCgZnZ2Osf+PQ0whp5VU3z45xOfXs0oKHRbpzXaXHbz4JBZPbEV1fdsd9TTF90eEQvbvkDiXGMPC/mjoNdN/pnRzK+V4L6ettPV+/a+tEuZpi0Sn8VJLeJ678Rf+so0XOVlHbSTjhmW5N9v5GnwpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLYAR48w; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706423962; x=1737959962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4lijp4ucfB/6jErrAcwvyyricA31fH+Gjfga3LbNXWw=;
  b=hLYAR48wKtsOPTqM0VtMhSuMYPwbR3yg/TU9wkjOgimU0zzujT08zyrc
   R7cl2OVbNfps0nitsoXvKUgga1JuVZbq5u6hdrxj/OehMPFzuj37HqWRM
   EjD/oDLbq3FXgbVfDdvibWhi3aRvMVVYvpR019Sn6Q0UuYwZsj3Sylygb
   5E8+G1mUa2m2BwFtc0givUeO6X8qwjPUgSX56s0Q5ZIKJ1y5sVBgDKl6h
   uLxbIt7bXkYzQtLc8nKJhjtDvJp3TeX0lepBL0qrsKQ+v9nmpz4lIe4e4
   PShQoKYrf/mp5y8eejGXZh93egyKHJRewvS+378EMwCnOJwog85fyox2G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="402391080"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="402391080"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910733513"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910733513"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 22:39:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTyp0-0003AW-1e;
	Sun, 28 Jan 2024 06:39:14 +0000
Date: Sun, 28 Jan 2024 14:38:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Message-ID: <202401281459.4OP8NSLy-lkp@intel.com>
References: <20240123080637.1902578-5-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123080637.1902578-5-ychuang570808@gmail.com>

Hi Jacky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next robh/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/dt-bindings-reset-Add-syscon-to-nuvoton-ma35d1-system-management-node/20240123-161939
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240123080637.1902578-5-ychuang570808%40gmail.com
patch subject: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
config: x86_64-randconfig-121-20240128 (https://download.01.org/0day-ci/archive/20240128/202401281459.4OP8NSLy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281459.4OP8NSLy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281459.4OP8NSLy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/nuvoton/pinctrl-ma35.c: In function 'ma35_gpiolib_register':
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:523:27: error: 'struct gpio_chip' has no member named 'of_gpio_n_cells'
     523 |                 bank->chip.of_gpio_n_cells = 2;
         |                           ^
   drivers/pinctrl/nuvoton/pinctrl-ma35.c: At top level:
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:10: error: 'const struct pinconf_ops' has no member named 'is_generic'
    1008 |         .is_generic = true,
         |          ^~~~~~~~~~
>> drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:23: warning: initialization of 'int (*)(struct pinctrl_dev *, unsigned int,  long unsigned int *)' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1008 |         .is_generic = true,
         |                       ^~~~
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:1008:23: note: (near initialization for 'ma35_pinconf_ops.pin_config_group_get')
   drivers/pinctrl/nuvoton/pinctrl-ma35.c: In function 'ma35_pinctrl_parse_groups':
   drivers/pinctrl/nuvoton/pinctrl-ma35.c:1024:15: error: implicit declaration of function 'pinconf_generic_parse_dt_config'; did you mean 'pinconf_generic_dump_config'? [-Werror=implicit-function-declaration]
    1024 |         ret = pinconf_generic_parse_dt_config(np, NULL, &configs, &nconfigs);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               pinconf_generic_dump_config
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PINCTRL_MA35
   Depends on [n]: PINCTRL [=y] && (ARCH_MA35 || COMPILE_TEST [=n]) && OF [=n]
   Selected by [y]:
   - PINCTRL_MA35D1 [=y] && PINCTRL [=y]


vim +1008 drivers/pinctrl/nuvoton/pinctrl-ma35.c

  1004	
  1005	static const struct pinconf_ops ma35_pinconf_ops = {
  1006		.pin_config_get = ma35_pinconf_get,
  1007		.pin_config_set = ma35_pinconf_set,
> 1008		.is_generic = true,
  1009	};
  1010	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

