Return-Path: <linux-kernel+bounces-79287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE64862010
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED61B22289
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138C1493B4;
	Fri, 23 Feb 2024 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hEaItwDP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5A24B2B;
	Fri, 23 Feb 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728699; cv=none; b=FYglo9kxQ4gR/pMTj5RCbTIcGjMVl+Yp1Svyly2Do3ZabF5G6wJI+fqZGLZPAtnrjToGARzRoIc6fzJadGyyXBh0KNkhtdy+PPCAJd2Lbgssc4pPU5iKwZs/oL5lnkW4cRId9gC3efGm9p20bQakdjmSi1/esF09+MyLHecv6xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728699; c=relaxed/simple;
	bh=Mc357CVHrALPxH36XBhZd6gv5wG0eLnjO1BTu774TgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv4Qc6N1yaCyG5qbiqLdKcpBw06O+38BYF4kTuazlWpLmVAc8KyzFXpBBDOF6hZmqCLJX2BV5NbTrP7mRVBiTZXcUtCfZ/TzirW0VO+1TleFTXwtCxE3NiOJP0+96jvMvHYCC99QimLsAQOgAcZ+PqdPWbzPMOpEmjb8uU6fEPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hEaItwDP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708728697; x=1740264697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mc357CVHrALPxH36XBhZd6gv5wG0eLnjO1BTu774TgA=;
  b=hEaItwDPF+oDN1AdK4O3zl0Uq83P+fMbkdtBhTbsWQkLHk1H8ex0WI7B
   NZ5rrVq99t/N8Mg99ATHwt/kVor2RvQtRYF5VESmQne/dyNDcZEkTEfgv
   Wtw7Jb/EunBMSpdXMSasNFHZOm1FFDKQpTPbzfhkjkfKyr1sJlKuqy9/W
   4H6dTZ820dJm27vRegby+fdg8+avNIBOJyARMr7I2cJbLpqXlckMXT7OA
   FrMYIeaAnJ/aWbL+bP4+AELS12M3WQyk8qI4f0kBUnsql4TGfMI9IQnRI
   6gdso0Yg1XZN1eWF+ShXOGDJQ0SLm7nR/2IaNWAdFfIP53CoRNBef9ZI2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6013691"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6013691"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6194312"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2024 14:51:34 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdeOA-0007z2-1p;
	Fri, 23 Feb 2024 22:51:31 +0000
Date: Sat, 24 Feb 2024 06:50:30 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
Subject: Re: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets
 exclusively
Message-ID: <202402240650.1O7vtd48-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8d3dea210042f54b952b481838c1e7dfc4ec751d]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Xiwen-via-B4-Relay/dt-bindings-simple-pm-bus-Add-optional-resets/20240223-115400
base:   8d3dea210042f54b952b481838c1e7dfc4ec751d
patch link:    https://lore.kernel.org/r/20240223-b4-bus-v1-2-2803c3ac4673%40outlook.com
patch subject: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets exclusively
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240224/202402240650.1O7vtd48-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240224/202402240650.1O7vtd48-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402240650.1O7vtd48-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/bus/simple-pm-bus.c: In function 'simple_pm_bus_probe':
>> drivers/bus/simple-pm-bus.c:67:50: warning: passing argument 1 of 'devm_reset_control_array_get' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      67 |         bus->rsts = devm_reset_control_array_get(dev, false, true);
         |                                                  ^~~
   In file included from drivers/bus/simple-pm-bus.c:19:
   include/linux/reset.h:192:45: note: expected 'struct device *' but argument is of type 'const struct device *'
     192 | devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
         |                              ~~~~~~~~~~~~~~~^~~


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

