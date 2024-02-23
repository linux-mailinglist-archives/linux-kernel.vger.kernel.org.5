Return-Path: <linux-kernel+bounces-79276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0A7861FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2122B1F24B45
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DCE146E6D;
	Fri, 23 Feb 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgsrOtWM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10022071;
	Fri, 23 Feb 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728073; cv=none; b=kD6wPBE+sHBOeDtYbrvVB/u6CcxxXWG1kgkbZ8l8a5mtEviFfMj70TvseKLKazukn9DxMMT0dZi8ZDE2PiECdTgWc3Y9+ItIW++fwJWmuseAsco0ZKkvPSwDYEdl8DRutN4cDvNeRxpK3gPPVKcAGlgpemX7DGRuLL1Is2FxVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728073; c=relaxed/simple;
	bh=M9KvWFP79FSlwdzb3EPPAWvxhpQ6pdeQUdYnpVN5Fok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G49gU8O6PnDuOgcTQd4G8jG79X8dJgCmE/BZUZLH0AQGE6cE0Db3PrQxMgy585Iiwk7uo8kBCPtVDMumecgmZao7rCzL9bBK6pSOzs43AdLXleL7+X9gPqrlnTkbfinAU2ROOLvmULG1Nvjh0yAtRWXCrMJ/uJBOZQ4Gm5esnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgsrOtWM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708728071; x=1740264071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M9KvWFP79FSlwdzb3EPPAWvxhpQ6pdeQUdYnpVN5Fok=;
  b=fgsrOtWM7rksJnt+ldJTUS7CFewZrXeKXK3CxYa7XhE74kY4EU+y6sj0
   2kkxbYNvDx264npPwFuf00OYaNSGK2Ky+uysmiLTwrpyLvEdtpxSKJBpW
   2J56ikIA8nlGD8XpzhG5fgs3CFzAf0/BzxA8/KboGZ9F54UTph9rOV7Je
   IpDDGOglwiyZVuX9Zc1q50mAOO6IXKtS9UL+LPhpxWqknh5QVwhasnldC
   INdKTW0YBknWspEd19QqPVDoJRtCPwsdqhoOb6MLSn+Bq36aYSYfvZUyj
   UoquNfwkvCHHmzXphkaXcxyeejNU4OahxhsV8AJm6RHYnOVoYVrQonwSb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13714259"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13714259"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:41:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10601984"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Feb 2024 14:41:06 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdeE4-0007yi-2H;
	Fri, 23 Feb 2024 22:41:04 +0000
Date: Sat, 24 Feb 2024 06:40:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets
 exclusively
Message-ID: <202402240646.IirqjDw8-lkp@intel.com>
References: <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>

Hi Yang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8d3dea210042f54b952b481838c1e7dfc4ec751d]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/dt-bindings-simple-pm-bus-Add-optional-resets/20240223-115400
base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
patch link:    https://lore.kernel.org/r/20240223-b4-bus-v1-2-2803c3ac4673%40outlook.com
patch subject: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets exclusively
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240224/202402240646.IirqjDw8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240224/202402240646.IirqjDw8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402240646.IirqjDw8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/bus/simple-pm-bus.c:67:43: error: passing 'const struct device *' to parameter of type 'struct device *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      67 |         bus->rsts = devm_reset_control_array_get(dev, false, true);
         |                                                  ^~~
   include/linux/reset.h:192:45: note: passing argument to parameter 'dev' here
     192 | devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
         |                                             ^
   1 error generated.


vim +67 drivers/bus/simple-pm-bus.c

    26	
    27	static int simple_pm_bus_probe(struct platform_device *pdev)
    28	{
    29		const struct device *dev = &pdev->dev;
    30		const struct of_dev_auxdata *lookup = dev_get_platdata(dev);
    31		struct device_node *np = dev->of_node;
    32		const struct of_device_id *match;
    33		struct simple_pm_bus *bus;
    34	
    35		/*
    36		 * Allow user to use driver_override to bind this driver to a
    37		 * transparent bus device which has a different compatible string
    38		 * that's not listed in simple_pm_bus_of_match. We don't want to do any
    39		 * of the simple-pm-bus tasks for these devices, so return early.
    40		 */
    41		if (pdev->driver_override)
    42			return 0;
    43	
    44		match = of_match_device(dev->driver->of_match_table, dev);
    45		/*
    46		 * These are transparent bus devices (not simple-pm-bus matches) that
    47		 * have their child nodes populated automatically.  So, don't need to
    48		 * do anything more. We only match with the device if this driver is
    49		 * the most specific match because we don't want to incorrectly bind to
    50		 * a device that has a more specific driver.
    51		 */
    52		if (match && match->data) {
    53			if (of_property_match_string(np, "compatible", match->compatible) == 0)
    54				return 0;
    55			else
    56				return -ENODEV;
    57		}
    58	
    59		bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
    60		if (!bus)
    61			return -ENOMEM;
    62	
    63		bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus->clks);
    64		if (bus->num_clks < 0)
    65			return dev_err_probe(&pdev->dev, bus->num_clks, "failed to get clocks\n");
    66	
  > 67		bus->rsts = devm_reset_control_array_get(dev, false, true);
    68		if (IS_ERR(bus->rsts))
    69			return dev_err_probe(&pdev->dev, PTR_ERR(bus->rsts), "failed to get resets\n");
    70	
    71		dev_set_drvdata(&pdev->dev, bus);
    72	
    73		dev_dbg(&pdev->dev, "%s\n", __func__);
    74	
    75		pm_runtime_enable(&pdev->dev);
    76	
    77		if (np)
    78			of_platform_populate(np, NULL, lookup, &pdev->dev);
    79	
    80		return 0;
    81	}
    82	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

