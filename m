Return-Path: <linux-kernel+bounces-123131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1A89028E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330F0B23638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC0128826;
	Thu, 28 Mar 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdVAXNhL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE57D417
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638077; cv=none; b=qYd8uOW0tCJ6CAKrBWfH0XZRB953Z348ZR3dI/8P9vp0kpyfT6xsrG0NVEPBBG5hcD/K+mTJOymVjuUIcyi3/cwk1bzPzv7T6KUe37Z3EegwcdBsKQ3o4m4od0YMBJ6cTx/vQda7JpsrmHGa65GDs8+AJNcCgVNK4T2+wmTaMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638077; c=relaxed/simple;
	bh=YWsMq5qCbTSN10VSj3S38szpilVOqvfniOFct++Y/y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEg3Hfbzrw7CCWbmR6vS3bes08BS6U+WKrRcGdFE03lmcwxA9LWJeIa3suxAXYNJSti0eKjRdThRh6ZaEs8avvcducIgOw1q1nOoROkvcmEVDD0561XUp168WBe9SF1ex6SaLs4DmZnWNFf8K/6mtbhT+7qJ144cx3+ZdteRw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdVAXNhL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711638075; x=1743174075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWsMq5qCbTSN10VSj3S38szpilVOqvfniOFct++Y/y4=;
  b=cdVAXNhLUij22qO+ZR9TebujvJs1pvIXjUtsRxBhwT7JpoFAunk7YCAR
   3tLsJxiGqfi5ORg8n84UAmjBf9BfFS1zyatagNGt+rXzz+bUEgq7/myLy
   373x2O2AlQ9NalRdbmX0kh/axrC4X5pbrVWbj+1qDchfeEZsbjhQyIFTg
   uuSHsxBUodg+8J0RpsrYuVByctnEfPhgpm+azD04iy6JZHSAIQHEwarRW
   626k3O7eTIt5z0X3/3YTaEvAOUKP5YT6XAJbj5Q9E1MqMpxa441i7Nk/Z
   nPGdvwYo6bld5P0QeR4jpoVK3D6vttIMEbN9Dpn2tnpOOuCPds8SpkT0z
   Q==;
X-CSE-ConnectionGUID: fKezzsbiTAemoL4NEevABg==
X-CSE-MsgGUID: I09zO87DSVG0P3aFPt88fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6983867"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6983867"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 08:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21320762"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Mar 2024 08:01:11 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rprFc-0002FK-36;
	Thu, 28 Mar 2024 15:01:08 +0000
Date: Thu, 28 Mar 2024 23:01:07 +0800
From: kernel test robot <lkp@intel.com>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	bbhushan2@marvell.com, gcherian@marvell.com,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [RESEND PATCH v4 3/3] perf/marvell : Odyssey LLC-TAD performance
 monitor
Message-ID: <202403282246.ybWRrXj7-lkp@intel.com>
References: <20240327071832.1556576-4-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327071832.1556576-4-gthiagarajan@marvell.com>

Hi Gowthami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gowthami-Thiagarajan/perf-marvell-Refactor-to-extract-platform-data/20240327-152242
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240327071832.1556576-4-gthiagarajan%40marvell.com
patch subject: [RESEND PATCH v4 3/3] perf/marvell : Odyssey LLC-TAD performance monitor
config: alpha-randconfig-r071-20240328 (https://download.01.org/0day-ci/archive/20240328/202403282246.ybWRrXj7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403282246.ybWRrXj7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403282246.ybWRrXj7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/perf/marvell_cn10k_tad_pmu.c:416:34: warning: 'tad_pmu_v2_data' defined but not used [-Wunused-const-variable=]
     416 | static const struct tad_pmu_data tad_pmu_v2_data = {
         |                                  ^~~~~~~~~~~~~~~
>> drivers/perf/marvell_cn10k_tad_pmu.c:412:34: warning: 'tad_pmu_data' defined but not used [-Wunused-const-variable=]
     412 | static const struct tad_pmu_data tad_pmu_data = {
         |                                  ^~~~~~~~~~~~


vim +/tad_pmu_data +412 drivers/perf/marvell_cn10k_tad_pmu.c

   411	
 > 412	static const struct tad_pmu_data tad_pmu_data = {
   413		.id   = TAD_PMU_V1,
   414	};
   415	
 > 416	static const struct tad_pmu_data tad_pmu_v2_data = {
   417		.id   = TAD_PMU_V2,
   418	};
   419	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

