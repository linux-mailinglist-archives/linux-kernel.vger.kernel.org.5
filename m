Return-Path: <linux-kernel+bounces-40078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C483D9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CC281563
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E018E06;
	Fri, 26 Jan 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFjWPSH5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B17BB9;
	Fri, 26 Jan 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270243; cv=none; b=vGjzKz/qwMN4XSf0Kj7RCKhqlc4utenEFXfkJSxhz06GePMn5eJ8940SK/doSNN0t/ripolvI6A4L+bBnPAcA4EDthW+UXKDd8kGuv3G64kW8YiiVs+aZM6v0i6SErWIYM0MNIqEh63JapOF/ajH3fBjfD1AQCsjUEs0L6hv478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270243; c=relaxed/simple;
	bh=tN3dkWpIc3gME9QQTNhlZjc9wz+9nnvN5lcfplh8yV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2nfP1Wvzi/2cPq/oebfFL5ynlKdxs9VMBJlIVqiCb//f57B/GwPQsoqnL6vhZkvC7fhZH9D74n3OC0vA+kUofTxkAgMToBcjyWhSQ7DJu52NmCx7JJzad9jWQ704MbyxERa6Rv9VOWh9ORA/yfP0SmpLWnoHgn6Ud6vpuDt7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFjWPSH5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706270239; x=1737806239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tN3dkWpIc3gME9QQTNhlZjc9wz+9nnvN5lcfplh8yV8=;
  b=LFjWPSH5EnLAJLph/YxhjeTKHLuLsQUt9amaxImTlLxylyUco1/2awkZ
   OpgoKAiQBeBO67eOpJnXWEqC+24SLqnFEdMT21ijPm14wNiLIltStEgvu
   auBKz3SkBTtHvH+ljjMbWBqRPue5zbe5cYSFcTKr8lM3nN5j6pnvYRpiy
   xLZPcdm4dho6IkbzR580Yih1hlFJsycFWkbien29CVFHQiCaqsohSA3Ry
   540rFnJELVpPs+w/LuGSMQUo65P6BPN+Zisy63ST3e4yN3s9fizFHfLhH
   AZgHoI3QswtPLDlejnKzW+Jw/fN2kRXrF0uVo9ip6LLEcK7u9pv/MbKHS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9131838"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9131838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 03:57:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930348517"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930348517"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2024 03:57:16 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTKpe-0000zs-0c;
	Fri, 26 Jan 2024 11:57:14 +0000
Date: Fri, 26 Jan 2024 19:56:37 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 08/21] power: supply: max77693: Use
 devm_power_supply_register() helper
Message-ID: <202401261917.tA05PFDO-lkp@intel.com>
References: <20240123163653.384385-9-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123163653.384385-9-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-supply-da9030-Use-devm_power_supply_register-helper/20240124-004253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240123163653.384385-9-afd%40ti.com
patch subject: [PATCH 08/21] power: supply: max77693: Use devm_power_supply_register() helper
config: i386-buildonly-randconfig-006-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261917.tA05PFDO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261917.tA05PFDO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261917.tA05PFDO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/max77693_charger.c:733:27: warning: unused variable 'chg' [-Wunused-variable]
     733 |         struct max77693_charger *chg = platform_get_drvdata(pdev);
         |                                  ^~~
   1 warning generated.


vim +/chg +733 drivers/power/supply/max77693_charger.c

87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  730  
1d138270d2963b drivers/power/supply/max77693_charger.c Uwe Kleine-König    2023-09-18  731  static void max77693_charger_remove(struct platform_device *pdev)
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  732  {
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20 @733  	struct max77693_charger *chg = platform_get_drvdata(pdev);
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  734  
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  735  	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  736  	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  737  	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  738  }
87c2d9067893cd drivers/power/max77693_charger.c        Krzysztof Kozlowski 2015-01-20  739  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

