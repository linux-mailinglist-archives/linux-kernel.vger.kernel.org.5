Return-Path: <linux-kernel+bounces-40115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C383DA76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3491C25CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56E1B805;
	Fri, 26 Jan 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQpwCPEf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A8D272;
	Fri, 26 Jan 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274083; cv=none; b=DdZA933sFzHxh969XbyTqgfnl3znt1BisXz8Zr651WMlL2BasomiyxyZYSo11PEjLPeX2TofwzhPFLIX1XIq04pQVDA5DJ5F0oX/upjAoEbQ4T7RLDwpr9ttT6fQXw8sPoHzyyOIziiSr/C22GIL+lruZezhvxH66//plXmMZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274083; c=relaxed/simple;
	bh=5SWrKIH3WHqs/ItgY9QXo1+BMJoRoFr2wwCVpRtIzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2SDAnHwjRu0pI9EGri9ljqJEMGcn0Q+8qDizLZ273RQeFhWI3ldkXjZWUD4PqpnPdLo+t1lb28VfAfOIsN2fjanhMNix6G0RFr8sNLyW3A7lLiNpeQCf5vrLPAW+wV0xkPhVXZRxIDFXzBpmgs0wmGaIr1QfuUjzGz3kTaeNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQpwCPEf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706274081; x=1737810081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5SWrKIH3WHqs/ItgY9QXo1+BMJoRoFr2wwCVpRtIzgo=;
  b=lQpwCPEfsGx5/d0SEuv8ncMQK4GmszoXFa9EJd1DVZujWepUnHsaBbOP
   uTMjHHzi1PGbMiKabGxsbnjfHMb+vbQc3HdPRqeS18J09II8RIKaExcPG
   ThQ/r0relPSPxYgjaasPP7b0I+cH/ntaDXw/27MSAiuXkO/Gtjwk/jEe6
   9ESs3p+U4LRJVBeljawljKS66uI/e/pA4/5B5tDNF6Ds9tffjXnMfFW5h
   NlGEpPOp26KA9cMV6W6ecUjCOTDJ4ARnpduvegkt9SM+oJz2i58lhCXTk
   LV+CRxotsQijrMlvCBt8z8bhpGNCNm299mNiKHtELBJ7VDLZHWuteGvfS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1391707"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1391707"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:01:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736690810"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="736690810"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2024 05:01:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTLpb-00011o-0q;
	Fri, 26 Jan 2024 13:01:15 +0000
Date: Fri, 26 Jan 2024 21:00:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Davis <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 15/21] power: supply: wm8350: Use
 devm_power_supply_register() helper
Message-ID: <202401262027.yOqHrHcD-lkp@intel.com>
References: <20240123163653.384385-16-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123163653.384385-16-afd@ti.com>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Davis/power-supply-da9030-Use-devm_power_supply_register-helper/20240124-004253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240123163653.384385-16-afd%40ti.com
patch subject: [PATCH 15/21] power: supply: wm8350: Use devm_power_supply_register() helper
config: i386-buildonly-randconfig-004-20240126 (https://download.01.org/0day-ci/archive/20240126/202401262027.yOqHrHcD-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401262027.yOqHrHcD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401262027.yOqHrHcD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/power/supply/wm8350_power.c:573:23: warning: unused variable 'power' [-Wunused-variable]
     573 |         struct wm8350_power *power = &wm8350->power;
         |                              ^~~~~
   1 warning generated.


vim +/power +573 drivers/power/supply/wm8350_power.c

14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  569  
42720969f394dc drivers/power/supply/wm8350_power.c Uwe Kleine-König 2023-09-18  570  static void wm8350_power_remove(struct platform_device *pdev)
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  571  {
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  572  	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16 @573  	struct wm8350_power *power = &wm8350->power;
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  574  
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  575  	free_charger_irq(wm8350);
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  576  	device_remove_file(&pdev->dev, &dev_attr_charger_state);
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  577  }
14431aa0c5a443 drivers/power/wm8350_power.c        Mark Brown       2008-11-16  578  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

