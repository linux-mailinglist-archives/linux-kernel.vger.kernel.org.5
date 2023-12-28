Return-Path: <linux-kernel+bounces-12425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9DC81F4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE3B1C21A92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCC2904;
	Thu, 28 Dec 2023 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCQ1XFZi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D715C3;
	Thu, 28 Dec 2023 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703740771; x=1735276771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcGj3hy/rgIPr7kx2Q/XYCRW7TjUvWTpE5wspKmi1ck=;
  b=OCQ1XFZiEp1ouyFNEGQRrz5UuZK7feKntZF2+50/T4NTxMyUAvqZL/TM
   QHULu6vlziKnlKbRCjwaPercrCNaw86L2e6+F2Nht3x1uOM4u0+zCSFaN
   yw79x9IQwfGLYxepoDQ2QibREw82JtLNabUNsWNzubrgAz/FNR8hrPjSa
   sIIu66x6F6JHaiuNoWl0tvwndvjzCHaF1hACHH0UTgQ1BFySNy2lXwZzZ
   Cjai2MLuf/uGlANaVRrgsKtzVoA39G5QUL1zAXgZ4gRhxZFp7ZAkRzF93
   2+MzI7VDR/A3jBW5BDGXtq6rIl0p8nxetKkcOP0UTppRBQMJYEwDr86yM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="482692903"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="482692903"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 21:19:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="754643985"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="754643985"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Dec 2023 21:19:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIinj-000G81-2x;
	Thu, 28 Dec 2023 05:19:23 +0000
Date: Thu, 28 Dec 2023 13:18:28 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Tero Kristo <kristo@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	cocci@inria.fr
Subject: Re: [PATCH 09/10] clk: ti: Less function calls in
 _ti_clkctrl_clk_register() after error detection
Message-ID: <202312281350.5H2Rhh67-lkp@intel.com>
References: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11039e4-69c6-4247-b4ba-c442b9427231@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/clk-ti-Less-function-calls-in-of_omap2_apll_setup-after-error-detection/20231225-152410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/b11039e4-69c6-4247-b4ba-c442b9427231%40web.de
patch subject: [PATCH 09/10] clk: ti: Less function calls in _ti_clkctrl_clk_register() after error detection
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20231228/202312281350.5H2Rhh67-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312281350.5H2Rhh67-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312281350.5H2Rhh67-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/ti/clkctrl.c: In function '_ti_clkctrl_clk_register':
>> drivers/clk/ti/clkctrl.c:330:1: error: 'free_init_name' undeclared (first use in this function)
     330 | free_init_name;
         | ^~~~~~~~~~~~~~
   drivers/clk/ti/clkctrl.c:330:1: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clk/ti/clkctrl.c:305:17: error: label 'free_init_name' used but not defined
     305 |                 goto free_init_name;
         |                 ^~~~


vim +/free_init_name +330 drivers/clk/ti/clkctrl.c

   283	
   284	static int __init
   285	_ti_clkctrl_clk_register(struct omap_clkctrl_provider *provider,
   286				 struct device_node *node, struct clk_hw *clk_hw,
   287				 u16 offset, u8 bit, const char * const *parents,
   288				 int num_parents, const struct clk_ops *ops,
   289				 const char *clkctrl_name)
   290	{
   291		struct clk_init_data init = { NULL };
   292		struct clk *clk;
   293		struct omap_clkctrl_clk *clkctrl_clk;
   294		int ret = 0;
   295	
   296		init.name = clkctrl_get_clock_name(node, clkctrl_name, offset, bit,
   297						   ti_clk_get_features()->flags &
   298						   TI_CLK_CLKCTRL_COMPAT);
   299		if (!init.name)
   300			return -ENOMEM;
   301	
   302		clkctrl_clk = kzalloc(sizeof(*clkctrl_clk), GFP_KERNEL);
   303		if (!clkctrl_clk) {
   304			ret = -ENOMEM;
 > 305			goto free_init_name;
   306		}
   307	
   308		clk_hw->init = &init;
   309		init.parent_names = parents;
   310		init.num_parents = num_parents;
   311		init.ops = ops;
   312		init.flags = 0;
   313	
   314		clk = of_ti_clk_register(node, clk_hw, init.name);
   315		if (IS_ERR_OR_NULL(clk)) {
   316			ret = -EINVAL;
   317			goto cleanup;
   318		}
   319	
   320		clkctrl_clk->reg_offset = offset;
   321		clkctrl_clk->bit_offset = bit;
   322		clkctrl_clk->clk = clk_hw;
   323	
   324		list_add(&clkctrl_clk->node, &provider->clocks);
   325	
   326		return 0;
   327	
   328	cleanup:
   329		kfree(clkctrl_clk);
 > 330	free_init_name;
   331		kfree(init.name);
   332		return ret;
   333	}
   334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

