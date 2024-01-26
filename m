Return-Path: <linux-kernel+bounces-40094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87983DA33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88865B24E10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C485199D0;
	Fri, 26 Jan 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDMt9w6Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9C1B7E8;
	Fri, 26 Jan 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272162; cv=none; b=uxodGLlnvVyJL06Zq/9SO2e+U6J4W/420W/k4eQhXRQJ9xY82bbD3F+6+DDv92CFGFnR0AYtHyBuLaHTXUxyCuZFo743nbYVI0e78FkU9NL7SPslj+2RGIsip/C5D850gXs84Bpofj4IjaONm7pYkD24LcCN+v6zZ0Oppzsm7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272162; c=relaxed/simple;
	bh=m34am/tbomi6cgCuIDffvsmNZlwPxjAWYsFaQ9DxZl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJfhnNxvrVMwfRW1UCOimIlZG//tWS1PKAcCcBUeRlONcXmKMKdFOnXLx6tljPkEf8/6szcjxVhIdIdafPje65cYCm0VO9UJNOhALyiNQNtcoT71JyBXKmfgqLvIK82ADzoDbIAxUe5YpCPxeu2Dpy9hL0X8JIZil+6jzuLJXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDMt9w6Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706272160; x=1737808160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m34am/tbomi6cgCuIDffvsmNZlwPxjAWYsFaQ9DxZl8=;
  b=YDMt9w6ZnqXEic/9gmDNeYYXQQ2iu2C/kuYUns1kESIO+EtzVqz3Qjs4
   fy8h2zZ3ecDWxdsULDqGUVLZxSqHi8zorjILIzKU4Yzf2E9+szuDIca0T
   L4J/nNu2KW+xuBnq1zLF9yGCnQe8Uv6FgKbrRplJDToEdCoO5pEaTVuuM
   ZwNHaUT5dPG5DX2UCNfraCjP+mYuctvSmdmVN5SgguaovBfBknCJ/ytQJ
   R5RqOf7QkNpTVkeWRRAcSsrv/TUKiYt/Md3tOYV2gw82G/8NLHFXrLZG9
   3jqWCcxhTxoTVAxo00Kxjb7FT1FnHgA94KoHglN9+dmVZapaNmRRwMd00
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9207969"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9207969"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 04:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2732248"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jan 2024 04:29:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTLKc-00011E-2y;
	Fri, 26 Jan 2024 12:29:14 +0000
Date: Fri, 26 Jan 2024 20:28:54 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 09/21] power: supply: max8925: Use
 devm_power_supply_register() helper
Message-ID: <202401262006.hqYtlg6E-lkp@intel.com>
References: <20240123163653.384385-10-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123163653.384385-10-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-supply-da9030-Use-devm_power_supply_register-helper/20240124-004253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240123163653.384385-10-afd%40ti.com
patch subject: [PATCH 09/21] power: supply: max8925: Use devm_power_supply_register() helper
config: i386-buildonly-randconfig-001-20240126 (https://download.01.org/0day-ci/archive/20240126/202401262006.hqYtlg6E-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401262006.hqYtlg6E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401262006.hqYtlg6E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/max8925_power.c:510:6: warning: unused variable 'ret' [-Wunused-variable]
     510 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +510 drivers/power/supply/max8925_power.c

eba3b670a9166a drivers/power/max8925_power.c        Qing Xu             2012-11-19  503  
c8afa6406e60ae drivers/power/max8925_power.c        Bill Pemberton      2012-11-19  504  static int max8925_power_probe(struct platform_device *pdev)
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  505  {
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  506  	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
2dc9215d7c94f7 drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  507  	struct power_supply_config psy_cfg = {}; /* Only for ac and usb */
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  508  	struct max8925_power_pdata *pdata = NULL;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  509  	struct max8925_power_info *info;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25 @510  	int ret;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  511  
eba3b670a9166a drivers/power/max8925_power.c        Qing Xu             2012-11-19  512  	pdata = max8925_power_dt_init(pdev);
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  513  	if (!pdata) {
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  514  		dev_err(&pdev->dev, "platform data isn't assigned to "
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  515  			"power supply\n");
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  516  		return -EINVAL;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  517  	}
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  518  
feeb3a92b1f4e4 drivers/power/max8925_power.c        Jingoo Han          2013-03-11  519  	info = devm_kzalloc(&pdev->dev, sizeof(struct max8925_power_info),
feeb3a92b1f4e4 drivers/power/max8925_power.c        Jingoo Han          2013-03-11  520  				GFP_KERNEL);
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  521  	if (!info)
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  522  		return -ENOMEM;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  523  	info->chip = chip;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  524  	info->gpm = chip->i2c;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  525  	info->adc = chip->adc;
2402ca5e300db0 drivers/power/max8925_power.c        Haojian Zhuang      2011-04-18  526  	platform_set_drvdata(pdev, info);
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  527  
2dc9215d7c94f7 drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  528  	psy_cfg.supplied_to = pdata->supplied_to;
2dc9215d7c94f7 drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  529  	psy_cfg.num_supplicants = pdata->num_supplicants;
2dc9215d7c94f7 drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  530  
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  531  	info->ac = devm_power_supply_register(&pdev->dev, &ac_desc, &psy_cfg);
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  532  	if (IS_ERR(info->ac))
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  533  		return PTR_ERR(info->ac);
297d716f6260cc drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  534  	info->ac->dev.parent = &pdev->dev;
e7a5f6d55991fb drivers/power/max8925_power.c        Philip Rakity       2011-08-29  535  
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  536  	info->usb = devm_power_supply_register(&pdev->dev, &usb_desc, &psy_cfg);
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  537  	if (IS_ERR(info->usb))
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  538  		return PTR_ERR(info->usb);
297d716f6260cc drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  539  	info->usb->dev.parent = &pdev->dev;
297d716f6260cc drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  540  
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  541  	info->battery = devm_power_supply_register(&pdev->dev, &battery_desc, NULL);
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  542  	if (IS_ERR(info->battery))
fec07f69a3e201 drivers/power/supply/max8925_power.c Andrew Davis        2024-01-23  543  		return PTR_ERR(info->battery);
297d716f6260cc drivers/power/max8925_power.c        Krzysztof Kozlowski 2015-03-12  544  	info->battery->dev.parent = &pdev->dev;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  545  
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  546  	info->batt_detect = pdata->batt_detect;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  547  	info->topoff_threshold = pdata->topoff_threshold;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  548  	info->fast_charge = pdata->fast_charge;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  549  	info->set_charger = pdata->set_charger;
92de378b739115 drivers/power/max8925_power.c        Philip Rakity       2011-11-25  550  	info->no_temp_support = pdata->no_temp_support;
5ba1fa0ae288e9 drivers/power/max8925_power.c        Philip Rakity       2011-11-25  551  	info->no_insert_detect = pdata->no_insert_detect;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  552  
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  553  	max8925_init_charger(chip, info);
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  554  	return 0;
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  555  }
28db38888b2a53 drivers/power/max8925_power.c        Haojian Zhuang      2010-01-25  556  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

