Return-Path: <linux-kernel+bounces-112045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB54888748F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EAE1C20AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7580C02;
	Fri, 22 Mar 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9VkbPSM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445417FBBD;
	Fri, 22 Mar 2024 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143945; cv=none; b=R8KkjNvNNjuyl64y7b8uFQNKpKH0bpRicD7JA/oqq+ZZaaJ56dAGoB3r/EZXSAPBbdIu0LlKRGNhReWVxowBMHrd1RMiWPQCOlGhXBtD9M6R2a88R4+wyJpp09tt2e6pXTDK/edvhuIXtH+PxpjOoMrZDsWLTY6W6jQgmmR/67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143945; c=relaxed/simple;
	bh=RPzQOy33+Y/0DmScu38OT6d5/HZNS3n3ZyQRLAU8nw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPyrK4fVbZE/GsgprR14MN0wI28vH/P9uo9NOXN8j5TDWmp1KLc8OSB/I/3RahEqEyM50HIEUqyoJtDA40XcFwcIKsIcmE/ILQIfLONS4paAOPinCTvhq474lRB/oZnFXN3aqQC4HyiFgVqP535GVlZPWJBwcKhl+Qpf5S+epEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9VkbPSM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711143944; x=1742679944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPzQOy33+Y/0DmScu38OT6d5/HZNS3n3ZyQRLAU8nw4=;
  b=j9VkbPSM8GhRYGVolJXNZWwKWIBLRmi+zW7HP8VkTWi4wvd8IHFEcteg
   TIvRtGbK6S0nrEcxpYVgTaeVB3eI3uWqy8mdYpU0Ox4jf9JErEhgJGMLx
   hr8zX6dN8dNhKktjXNKUJ2DxyBbRb3PX7HduTKOy2G8HA6HCdGWHSrzz2
   9ZPci8GXIiwXsiLg9BD/Zt1+AppouotEFSJ73zZFPzi0yG4IxRDAnuYAI
   2GGsteUbo2Z+MblD997stXlf08/i96qzEbm4wr5c2LbAvf47kDZmruJOR
   68+P1ImscllPQpa75SFtXVtnOEX9M64XNftGezF3vzo2tjwsdXyCZU7Ui
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6328945"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6328945"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 14:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="15018611"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 22 Mar 2024 14:45:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnmhj-000Kdj-23;
	Fri, 22 Mar 2024 21:45:35 +0000
Date: Sat, 23 Mar 2024 05:45:09 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Bee <knaerzche@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH 2/5] mfd: rk8xx: Add RK816 support
Message-ID: <202403230551.Vc1eaxTr-lkp@intel.com>
References: <20240321143911.90210-5-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321143911.90210-5-knaerzche@gmail.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on lee-mfd/for-mfd-fixes broonie-regulator/for-next robh/for-next linus/master v6.8 next-20240322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Bee/dt-bindings-mfd-Add-rk816-binding/20240321-224318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20240321143911.90210-5-knaerzche%40gmail.com
patch subject: [PATCH 2/5] mfd: rk8xx: Add RK816 support
config: arm-randconfig-002-20240322 (https://download.01.org/0day-ci/archive/20240323/202403230551.Vc1eaxTr-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240323/202403230551.Vc1eaxTr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403230551.Vc1eaxTr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mfd/rk8xx-core.c:14:
   In file included from include/linux/mfd/rk808.h:18:
   In file included from include/linux/regulator/machine.h:15:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:20:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/mfd/rk8xx-core.c:395:8: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
     395 | static const unsigned int rk816_get_irq_reg(struct regmap_irq_chip_data *data,
         |        ^~~~~
>> drivers/mfd/rk8xx-core.c:573:17: error: incompatible function pointer types initializing 'unsigned int (*)(struct regmap_irq_chip_data *, unsigned int, int)' with an expression of type 'const unsigned int (struct regmap_irq_chip_data *, unsigned int, int)' [-Wincompatible-function-pointer-types]
     573 |         .get_irq_reg = rk816_get_irq_reg,
         |                        ^~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +573 drivers/mfd/rk8xx-core.c

   394	
 > 395	static const unsigned int rk816_get_irq_reg(struct regmap_irq_chip_data *data,
   396						    unsigned int base, int index)
   397	{
   398		unsigned int irq_reg = base;
   399	
   400		switch (base) {
   401		case RK816_INT_STS_REG1:
   402			irq_reg += rk816_irq_status_offsets[index];
   403			break;
   404		case RK816_INT_STS_MSK_REG1:
   405			irq_reg += rk816_irq_mask_offsets[index];
   406			break;
   407		}
   408	
   409		return irq_reg;
   410	};
   411	
   412	static const struct regmap_irq rk816_irqs[] = {
   413		/* INT_STS_REG1 IRQs */
   414		REGMAP_IRQ_REG(RK816_IRQ_PWRON_FALL, 0, RK816_INT_STS_PWRON_FALL),
   415		REGMAP_IRQ_REG(RK816_IRQ_PWRON_RISE, 0, RK816_INT_STS_PWRON_RISE),
   416	
   417		/* INT_STS_REG2 IRQs  */
   418		REGMAP_IRQ_REG(RK816_IRQ_VB_LOW, 1, RK816_INT_STS_VB_LOW),
   419		REGMAP_IRQ_REG(RK816_IRQ_PWRON, 1, RK816_INT_STS_PWRON),
   420		REGMAP_IRQ_REG(RK816_IRQ_PWRON_LP, 1, RK816_INT_STS_PWRON_LP),
   421		REGMAP_IRQ_REG(RK816_IRQ_HOTDIE, 1, RK816_INT_STS_HOTDIE),
   422		REGMAP_IRQ_REG(RK816_IRQ_RTC_ALARM, 1, RK816_INT_STS_RTC_ALARM),
   423		REGMAP_IRQ_REG(RK816_IRQ_RTC_PERIOD, 1, RK816_INT_STS_RTC_PERIOD),
   424		REGMAP_IRQ_REG(RK816_IRQ_USB_OV, 1, RK816_INT_STS_USB_OV),
   425	
   426		/* INT_STS3 IRQs */
   427		REGMAP_IRQ_REG(RK816_IRQ_PLUG_IN, 2, RK816_INT_STS_PLUG_IN),
   428		REGMAP_IRQ_REG(RK816_IRQ_PLUG_OUT, 2, RK816_INT_STS_PLUG_OUT),
   429		REGMAP_IRQ_REG(RK816_IRQ_CHG_OK, 2, RK816_INT_STS_CHG_OK),
   430		REGMAP_IRQ_REG(RK816_IRQ_CHG_TE, 2, RK816_INT_STS_CHG_TE),
   431		REGMAP_IRQ_REG(RK816_IRQ_CHG_TS, 2, RK816_INT_STS_CHG_TS),
   432		REGMAP_IRQ_REG(RK816_IRQ_CHG_CVTLIM, 2, RK816_INT_STS_CHG_CVTLIM),
   433		REGMAP_IRQ_REG(RK816_IRQ_DISCHG_ILIM, 2, RK816_INT_STS_DISCHG_ILIM),
   434	};
   435	
   436	static const struct regmap_irq rk818_irqs[] = {
   437		/* INT_STS */
   438		[RK818_IRQ_VOUT_LO] = {
   439			.mask = RK818_IRQ_VOUT_LO_MSK,
   440			.reg_offset = 0,
   441		},
   442		[RK818_IRQ_VB_LO] = {
   443			.mask = RK818_IRQ_VB_LO_MSK,
   444			.reg_offset = 0,
   445		},
   446		[RK818_IRQ_PWRON] = {
   447			.mask = RK818_IRQ_PWRON_MSK,
   448			.reg_offset = 0,
   449		},
   450		[RK818_IRQ_PWRON_LP] = {
   451			.mask = RK818_IRQ_PWRON_LP_MSK,
   452			.reg_offset = 0,
   453		},
   454		[RK818_IRQ_HOTDIE] = {
   455			.mask = RK818_IRQ_HOTDIE_MSK,
   456			.reg_offset = 0,
   457		},
   458		[RK818_IRQ_RTC_ALARM] = {
   459			.mask = RK818_IRQ_RTC_ALARM_MSK,
   460			.reg_offset = 0,
   461		},
   462		[RK818_IRQ_RTC_PERIOD] = {
   463			.mask = RK818_IRQ_RTC_PERIOD_MSK,
   464			.reg_offset = 0,
   465		},
   466		[RK818_IRQ_USB_OV] = {
   467			.mask = RK818_IRQ_USB_OV_MSK,
   468			.reg_offset = 0,
   469		},
   470	
   471		/* INT_STS2 */
   472		[RK818_IRQ_PLUG_IN] = {
   473			.mask = RK818_IRQ_PLUG_IN_MSK,
   474			.reg_offset = 1,
   475		},
   476		[RK818_IRQ_PLUG_OUT] = {
   477			.mask = RK818_IRQ_PLUG_OUT_MSK,
   478			.reg_offset = 1,
   479		},
   480		[RK818_IRQ_CHG_OK] = {
   481			.mask = RK818_IRQ_CHG_OK_MSK,
   482			.reg_offset = 1,
   483		},
   484		[RK818_IRQ_CHG_TE] = {
   485			.mask = RK818_IRQ_CHG_TE_MSK,
   486			.reg_offset = 1,
   487		},
   488		[RK818_IRQ_CHG_TS1] = {
   489			.mask = RK818_IRQ_CHG_TS1_MSK,
   490			.reg_offset = 1,
   491		},
   492		[RK818_IRQ_TS2] = {
   493			.mask = RK818_IRQ_TS2_MSK,
   494			.reg_offset = 1,
   495		},
   496		[RK818_IRQ_CHG_CVTLIM] = {
   497			.mask = RK818_IRQ_CHG_CVTLIM_MSK,
   498			.reg_offset = 1,
   499		},
   500		[RK818_IRQ_DISCHG_ILIM] = {
   501			.mask = RK818_IRQ_DISCHG_ILIM_MSK,
   502			.reg_offset = 1,
   503		},
   504	};
   505	
   506	static const struct regmap_irq rk817_irqs[RK817_IRQ_END] = {
   507		REGMAP_IRQ_REG_LINE(0, 8),
   508		REGMAP_IRQ_REG_LINE(1, 8),
   509		REGMAP_IRQ_REG_LINE(2, 8),
   510		REGMAP_IRQ_REG_LINE(3, 8),
   511		REGMAP_IRQ_REG_LINE(4, 8),
   512		REGMAP_IRQ_REG_LINE(5, 8),
   513		REGMAP_IRQ_REG_LINE(6, 8),
   514		REGMAP_IRQ_REG_LINE(7, 8),
   515		REGMAP_IRQ_REG_LINE(8, 8),
   516		REGMAP_IRQ_REG_LINE(9, 8),
   517		REGMAP_IRQ_REG_LINE(10, 8),
   518		REGMAP_IRQ_REG_LINE(11, 8),
   519		REGMAP_IRQ_REG_LINE(12, 8),
   520		REGMAP_IRQ_REG_LINE(13, 8),
   521		REGMAP_IRQ_REG_LINE(14, 8),
   522		REGMAP_IRQ_REG_LINE(15, 8),
   523		REGMAP_IRQ_REG_LINE(16, 8),
   524		REGMAP_IRQ_REG_LINE(17, 8),
   525		REGMAP_IRQ_REG_LINE(18, 8),
   526		REGMAP_IRQ_REG_LINE(19, 8),
   527		REGMAP_IRQ_REG_LINE(20, 8),
   528		REGMAP_IRQ_REG_LINE(21, 8),
   529		REGMAP_IRQ_REG_LINE(22, 8),
   530		REGMAP_IRQ_REG_LINE(23, 8)
   531	};
   532	
   533	static struct regmap_irq_chip rk805_irq_chip = {
   534		.name = "rk805",
   535		.irqs = rk805_irqs,
   536		.num_irqs = ARRAY_SIZE(rk805_irqs),
   537		.num_regs = 1,
   538		.status_base = RK805_INT_STS_REG,
   539		.mask_base = RK805_INT_STS_MSK_REG,
   540		.ack_base = RK805_INT_STS_REG,
   541		.init_ack_masked = true,
   542	};
   543	
   544	static struct regmap_irq_chip rk806_irq_chip = {
   545		.name = "rk806",
   546		.irqs = rk806_irqs,
   547		.num_irqs = ARRAY_SIZE(rk806_irqs),
   548		.num_regs = 2,
   549		.irq_reg_stride = 2,
   550		.mask_base = RK806_INT_MSK0,
   551		.status_base = RK806_INT_STS0,
   552		.ack_base = RK806_INT_STS0,
   553		.init_ack_masked = true,
   554	};
   555	
   556	static const struct regmap_irq_chip rk808_irq_chip = {
   557		.name = "rk808",
   558		.irqs = rk808_irqs,
   559		.num_irqs = ARRAY_SIZE(rk808_irqs),
   560		.num_regs = 2,
   561		.irq_reg_stride = 2,
   562		.status_base = RK808_INT_STS_REG1,
   563		.mask_base = RK808_INT_STS_MSK_REG1,
   564		.ack_base = RK808_INT_STS_REG1,
   565		.init_ack_masked = true,
   566	};
   567	
   568	static const struct regmap_irq_chip rk816_irq_chip = {
   569		.name = "rk816",
   570		.irqs = rk816_irqs,
   571		.num_irqs = ARRAY_SIZE(rk816_irqs),
   572		.num_regs = 3,
 > 573		.get_irq_reg = rk816_get_irq_reg,
   574		.status_base = RK816_INT_STS_REG1,
   575		.mask_base = RK816_INT_STS_MSK_REG1,
   576		.ack_base = RK816_INT_STS_REG1,
   577		.init_ack_masked = true,
   578	};
   579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

