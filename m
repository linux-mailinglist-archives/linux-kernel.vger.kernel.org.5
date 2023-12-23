Return-Path: <linux-kernel+bounces-10154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518781D0D7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5696A1C2132E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2262656;
	Sat, 23 Dec 2023 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJdcJqqX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE8384
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703291844; x=1734827844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MvHXDEbF+7k2hyye4yydeiebgNTyADbp+pawi9WjYw=;
  b=EJdcJqqXuBfj6oSENKOP8VwsfyIh6VwBrsy8qVspj8Ws2IEhhPGBjXas
   JWLBSYbczQ/wtI6xWRddxEOEUmJWV7FzjW0A88gRmY114gJXqqhXw/IwZ
   ntOTWbgQAPOuRQ1cgNVOnzNQEINRDpovmMWnkbsvUQruSuPBoeVSmSwEg
   uqmwezMISgAlR+mSxfXTc9Ff1hOIaEfnwGqglX3pbfudc+3Z38mpZddA3
   y28CbqPGn9kf93M/IkK9CEW7rsUdQFOEfO7a6r2fgzKNON2QZHkd/GBka
   Wa8/imRySfXtU9I2W6DxwX3qwNU6Mv7CYy+mx3tHbTy5Kb6ryGRHxM64D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="2991268"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="2991268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="950479369"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="950479369"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2023 16:37:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGq0A-000A3P-2M;
	Sat, 23 Dec 2023 00:36:47 +0000
Date: Sat, 23 Dec 2023 08:32:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <202312230846.9DkpFRNv-lkp@intel.com>
References: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>

Hi Mark,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on chrome-platform/for-next chrome-platform/for-firmware-next wsa/i2c/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Hasemeyer/gpiolib-acpi-Modify-acpi_dev_irq_wake_get_by-to-use-resource/20231222-172104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28%40changeid
patch subject: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to manage wakeirq
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20231223/202312230846.9DkpFRNv-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230846.9DkpFRNv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230846.9DkpFRNv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/acpi.h:14,
                    from drivers/platform/chrome/cros_ec_lpc.c:14:
>> include/linux/module.h:244:1: error: expected ',' or ';' before 'extern'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         | ^~~~~~
   drivers/platform/chrome/cros_ec_lpc.c:67:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
      67 | MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);
         | ^~~~~~~~~~~~~~~~~~~


vim +244 include/linux/module.h

^1da177e4c3f41 Linus Torvalds    2005-04-16  240  
cff26a51da5d20 Rusty Russell     2014-02-03  241  #ifdef MODULE
cff26a51da5d20 Rusty Russell     2014-02-03  242  /* Creates an alias so file2alias.c can find device table. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  243  #define MODULE_DEVICE_TABLE(type, name)					\
0bf8bf50eddc75 Matthias Kaehlcke 2017-07-24 @244  extern typeof(name) __mod_##type##__##name##_device_table		\
cff26a51da5d20 Rusty Russell     2014-02-03  245    __attribute__ ((unused, alias(__stringify(name))))
cff26a51da5d20 Rusty Russell     2014-02-03  246  #else  /* !MODULE */
cff26a51da5d20 Rusty Russell     2014-02-03  247  #define MODULE_DEVICE_TABLE(type, name)
cff26a51da5d20 Rusty Russell     2014-02-03  248  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  249  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

