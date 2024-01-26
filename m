Return-Path: <linux-kernel+bounces-40395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7E83DF75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9573FB23728
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26841DDEB;
	Fri, 26 Jan 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An4ezcik"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4421D54B;
	Fri, 26 Jan 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288711; cv=none; b=aP64nYi6COeJldGhi6DVyqe2ZFbrrQ6ZNtnAYIiPPJP/ftqVy2PE44+p9FobqaAi1m+mGCc265v6xra/TYCMN3dtRXdtuuIOUyv2Ujju/HA5euJiVgKSwhITlyq9MUSyG83r/jDBuY/L72bvLi2aHBQufwMNN/mMx9PfSAApBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288711; c=relaxed/simple;
	bh=B2eTgBCFVQKRYm7Y4FhNIecDMa1S3RJPllkOTJs5j3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ls42hD7vyJ56axJNXbNFyYmZwwEiLpgsagA0faFWvowAsjYaf97hK0S/ElCInr7eGJZ+1ztvK1E1rVC/Klme1em44Yju7Lgt3i/vVXyQ/l5HTxNPkJC8Nz3h+xljTEFJCI2a0TUmmra3JbkSeuUtnPy5Er4cwgPDYtdFXY3s8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An4ezcik; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706288709; x=1737824709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B2eTgBCFVQKRYm7Y4FhNIecDMa1S3RJPllkOTJs5j3E=;
  b=An4ezcikvMXYQbN5MQWuLr+t6fu80AA3MZFlnxhoiegDkebB84/+FN82
   L0kIf9eBPvdj9HLw8whejN6Vojgb9M+yZrOkrDDBCTP8QSrJFsjkaeNT5
   9UlCTGYvJfbZ+5NGZC96mI9oWJhA19FAiXpBVZt1n5Jvl6uS8nBsW/q4y
   FwUFvAYos66P59vxpYOvL0ebyA2ImbsIltxVtArL8dd1OYVoP4Kq13Un9
   +zp9iOggZoYd3p3nRJgIbcA6hEeOrr+s1BA5pkbziGg3U6uRT1e74FvnC
   nakF6Kb0fDfYzZZnZbmqcPXZ0izKl0LEfWcXEJ2GepB7abmuj0/wmfxcc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392954082"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392954082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:05:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21432338"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jan 2024 09:05:01 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTPdT-0001Dy-0X;
	Fri, 26 Jan 2024 17:04:59 +0000
Date: Sat, 27 Jan 2024 01:04:13 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net, wim@linux-watchdog.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
	chanho61.park@samsung.com, semen.protsenko@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel-team@android.com, peter.griffin@linaro.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
Message-ID: <202401270001.630IWRta-lkp@intel.com>
References: <20240122225710.1952066-4-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122225710.1952066-4-peter.griffin@linaro.org>

Hi Peter,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Griffin/dt-bindings-watchdog-samsung-wdt-deprecate-samsung-syscon-phandle/20240123-070052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20240122225710.1952066-4-peter.griffin%40linaro.org
patch subject: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new exynos_pmu_*() apis
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240127/202401270001.630IWRta-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240127/202401270001.630IWRta-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401270001.630IWRta-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/samsung/exynos5420-pmu.c:12:10: fatal error: 'asm/cputype.h' file not found
      12 | #include <asm/cputype.h>
         |          ^~~~~~~~~~~~~~~
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for EXYNOS_PMU
   Depends on [n]: SOC_SAMSUNG [=y] && (ARCH_EXYNOS || (ARM || ARM64) && COMPILE_TEST [=y])
   Selected by [y]:
   - S3C2410_WATCHDOG [=y] && WATCHDOG [=y] && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST [=y])


vim +12 drivers/soc/samsung/exynos5420-pmu.c

92c4bf04735130 arch/arm/mach-exynos/exynos5420-pmu.c Pankaj Dubey 2015-12-18  11  
92c4bf04735130 arch/arm/mach-exynos/exynos5420-pmu.c Pankaj Dubey 2015-12-18 @12  #include <asm/cputype.h>
92c4bf04735130 arch/arm/mach-exynos/exynos5420-pmu.c Pankaj Dubey 2015-12-18  13  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

