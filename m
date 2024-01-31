Return-Path: <linux-kernel+bounces-45745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9961E8434DA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F7328A3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD1E4A6;
	Wed, 31 Jan 2024 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZoIs0JuV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7381B7E9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706675431; cv=none; b=Iwzc34CW1P78cjz4gxoAYml4hk9Z/DlX9EIuUOnRgy4oi3/cd0HtERZmjwXrIg799UOL+ILB8Nv++3bKjIHrD3fc1aGLPm9wMcewWoIkFOd9nbUzrJcmJygfZly+S7CLR5ER2nau/PhtNcn2SdLonD9TixM1WUUTDD1p1SVILL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706675431; c=relaxed/simple;
	bh=4kXyWj1CMpKN3/ty97hbPcZMy2+wRzcK+Q+WqzZV3JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIxl6JAn6WEArYnQUNVstsLNlO/RIdkHO3Q6ipxEc38ORQUwTGcJmfeRgw98P4rg/qf34zi5kTy5OznMV17R6bOvF2EVdqc7Ny2bu9Ppi+8X+rnx7iZz3NEei3CG6F0R15Rk5wcCinuRUEposT6dD7vGtmLA9wibdRU8/EZfQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZoIs0JuV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706675429; x=1738211429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kXyWj1CMpKN3/ty97hbPcZMy2+wRzcK+Q+WqzZV3JQ=;
  b=ZoIs0JuVUuG8mkSQ/H7HIV0cvS7LbHOy1Ikny3xcWkBTd0jGhiFPd8yu
   dAYSZ/l8O4FciDqD+IHDTD6wG+1eyL3ELgaa1uFzuORqL+uryA18u3Bjp
   Bxta6BhvMxF0wcK5YFyrVS/L8lxcHNS6Fw1Y6fr2cCl3/VwD3JqOHccJw
   XYKsHCUsMp0HUTiTKZ0Yf0zMB2iMtMlDn0xifEIEupoTMo5rI7N4H/cDm
   zHRCfHlb3nK77yQGDF+vZ/XpFi7xe5RMpf09RGmqjwsWYik/h2P6cZByB
   rsXtn6TvX6aMtQJnB2vvG11MPtmI8kIj9h1JYUMSpNjNRhkAM1XBGwOaC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16868407"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16868407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 20:30:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907747444"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="907747444"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2024 20:30:25 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV2Eq-00018a-1z;
	Wed, 31 Jan 2024 04:30:20 +0000
Date: Wed, 31 Jan 2024 12:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
	akpm@linux-foundation.org, pmladek@suse.com,
	lecopzer.chen@mediatek.com, kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: Re: [PATCHv2 1/2] watchdog/softlockup: low-overhead detection of
 interrupt storm
Message-ID: <202401311206.nS3XM5Li-lkp@intel.com>
References: <20240130074744.45759-2-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130074744.45759-2-yaoma@linux.alibaba.com>

Hi Bitao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.8-rc2 next-20240131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitao-Hu/watchdog-softlockup-low-overhead-detection-of-interrupt-storm/20240130-155029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240130074744.45759-2-yaoma%40linux.alibaba.com
patch subject: [PATCHv2 1/2] watchdog/softlockup: low-overhead detection of interrupt storm
config: x86_64-randconfig-122-20240130 (https://download.01.org/0day-ci/archive/20240131/202401311206.nS3XM5Li-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240131/202401311206.nS3XM5Li-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401311206.nS3XM5Li-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/watchdog.c:464:50: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected unsigned char [usertype] ( *utilization )[4] @@     got unsigned char [noderef] [usertype] ( * )[4] @@
   kernel/watchdog.c:464:50: sparse:     expected unsigned char [usertype] ( *utilization )[4]
   kernel/watchdog.c:464:50: sparse:     got unsigned char [noderef] [usertype] ( * )[4]
   kernel/watchdog.c:489:50: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected unsigned char [usertype] ( *utilization )[4] @@     got unsigned char [noderef] [usertype] ( * )[4] @@
   kernel/watchdog.c:489:50: sparse:     expected unsigned char [usertype] ( *utilization )[4]
   kernel/watchdog.c:489:50: sparse:     got unsigned char [noderef] [usertype] ( * )[4]

vim +464 kernel/watchdog.c

   459	
   460	static void update_cpustat(void)
   461	{
   462		u8 i;
   463		u16 *old = this_cpu_ptr(cpustat_old);
 > 464		u8 (*utilization)[NUM_STATS_PER_GROUP] = this_cpu_ptr(cpustat_utilization);
   465		u8 tail = this_cpu_read(cpustat_tail);
   466		struct kernel_cpustat kcpustat;
   467		u64 *cpustat = kcpustat.cpustat;
   468		u16 sample_period_ms = sample_period >> 24LL; /* 2^24ns ~= 16.8ms */
   469	
   470		kcpustat_cpu_fetch(&kcpustat, smp_processor_id());
   471		for (i = STATS_SYSTEM; i < NUM_STATS_PER_GROUP; i++) {
   472			/*
   473			 * We don't need nanosecond resolution. A granularity of 16ms is
   474			 * sufficient for our precision, allowing us to use u16 to store
   475			 * cpustats, which will roll over roughly every ~1000 seconds.
   476			 * 2^24 ~= 16 * 10^6
   477			 */
   478			cpustat[idx_to_stat[i]] = lower_16_bits(cpustat[idx_to_stat[i]] >> 24LL);
   479			utilization[tail][i] = 100 * (u16)(cpustat[idx_to_stat[i]] - old[i])
   480						/ sample_period_ms;
   481			old[i] = cpustat[idx_to_stat[i]];
   482		}
   483		this_cpu_write(cpustat_tail, (tail + 1) % NUM_STATS_GROUPS);
   484	}
   485	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

