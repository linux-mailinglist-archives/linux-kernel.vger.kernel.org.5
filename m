Return-Path: <linux-kernel+bounces-60631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76E8507B9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E351F2382C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 04:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7012B76;
	Sun, 11 Feb 2024 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhuREhkN"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F936FBF5;
	Sun, 11 Feb 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707625193; cv=none; b=mLFvrHnQd3S3OKmh/Fz9qsGkds1gqeeN/7Z6l8NeDR0EbFJ8DSNltCQnJG25t3Oe5SKEp06RXo0vLy26u1kJdSHUW+NOqEh8zFvA4zS96Vb+UayExAax+/P6OCS29bCtJmm7Hoo5TAVwjfkPJqpft31h79uQAz8b9tdJoclX45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707625193; c=relaxed/simple;
	bh=HuE/qn9uO4Mak3wb7u3vZhiBv+6UYRAGaV1V4lIuL0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGEipj57WH0Bmh8zF4sndzAHjvIi6XRvYW06sFyOFEi7cMtlOcUeqajel3JZ9PVl7n80qPOX109CH1/02F1I4en5zaL2tXMsPd08/dZmHknZNa7rVQyp9dz/e1XikFlguJXWyIsmrplwHFt+UpZC7E+wOGyJD/ZCGMv5xPKAnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhuREhkN; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707625190; x=1739161190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HuE/qn9uO4Mak3wb7u3vZhiBv+6UYRAGaV1V4lIuL0U=;
  b=WhuREhkNtB2O6qHGVR+E46PamqHHfzu3HOwyCJXxlgtf0XuvF+pAWrk1
   4nglJiL8u9bkE2uE40rsYrKwR+FoiBpGULVneQw3rZcKjmMgWlDTDesxp
   dLyhmAVdWIM/9c9ngf1TE27wA761FUH7JbJbdDup20oqM4tOQzPjees5e
   mbBcD3zw50HN6v6ooo6T42SAExyma8IboSUovy6oXC3eON6Y8RsiPRP/o
   BQy0c4kOnNkz+KPQJsa3VBokZYHKq1XF6YXiwk1Kusi1hMnWljG+43TUL
   te03d5tW5Ypzy9sk7RoLZBY4GdWpO4cvz08mqy5NjP4IuRYHabOq+OGoA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="436747867"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="436747867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 20:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="2588419"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2024 20:19:46 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZ1Jg-0006Jc-0q;
	Sun, 11 Feb 2024 04:19:44 +0000
Date: Sun, 11 Feb 2024 12:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com,
	schung@nuvoton.com
Subject: Re: [PATCH v4 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Message-ID: <202402111204.to88Twuu-lkp@intel.com>
References: <20240206025223.35147-5-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206025223.35147-5-ychuang570808@gmail.com>

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next robh/for-next linus/master v6.8-rc3 next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/dt-bindings-reset-Add-syscon-to-nuvoton-ma35d1-system-management-node/20240206-105502
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20240206025223.35147-5-ychuang570808%40gmail.com
patch subject: [PATCH v4 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver
config: powerpc-randconfig-r122-20240208 (https://download.01.org/0day-ci/archive/20240211/202402111204.to88Twuu-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20240211/202402111204.to88Twuu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111204.to88Twuu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:14:
   drivers/pinctrl/nuvoton/pinctrl-ma35.h:46:31: warning: declaration of 'struct platform_device' will not be visible outside of this function [-Wvisibility]
   int ma35_pinctrl_probe(struct platform_device *pdev, const struct ma35_pinctrl_soc_info *info);
                                 ^
   drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:1770:40: warning: declaration of 'struct platform_device' will not be visible outside of this function [-Wvisibility]
   static int ma35d1_pinctrl_probe(struct platform_device *pdev)
                                          ^
   drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:1772:28: error: incompatible pointer types passing 'struct platform_device *' to parameter of type 'struct platform_device *' [-Werror,-Wincompatible-pointer-types]
           return ma35_pinctrl_probe(pdev, &ma35d1_pinctrl_info);
                                     ^~~~
   drivers/pinctrl/nuvoton/pinctrl-ma35.h:46:48: note: passing argument to parameter 'pdev' here
   int ma35_pinctrl_probe(struct platform_device *pdev, const struct ma35_pinctrl_soc_info *info);
                                                  ^
   drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:1780:31: error: variable has incomplete type 'struct platform_driver'
   static struct platform_driver ma35d1_pinctrl_driver = {
                                 ^
   drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:1780:15: note: forward declaration of 'struct platform_driver'
   static struct platform_driver ma35d1_pinctrl_driver = {
                 ^
>> drivers/pinctrl/nuvoton/pinctrl-ma35d1.c:1791:9: error: implicit declaration of function 'platform_driver_register' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           return platform_driver_register(&ma35d1_pinctrl_driver);
                  ^
   2 warnings and 3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ADB_CUDA
   Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
   Selected by [y]:
   - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]


vim +/platform_driver_register +1791 drivers/pinctrl/nuvoton/pinctrl-ma35d1.c

  1788	
  1789	static int __init ma35d1_pinctrl_init(void)
  1790	{
> 1791		return platform_driver_register(&ma35d1_pinctrl_driver);
  1792	}
  1793	arch_initcall(ma35d1_pinctrl_init);
  1794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

