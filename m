Return-Path: <linux-kernel+bounces-39637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4483D3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD4BB25962
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 05:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A932C128;
	Fri, 26 Jan 2024 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHU5YN8v"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031010A19
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706246801; cv=none; b=muOFhMDUvREwOaOcxvBgyKPQ2t9gN3b8l4Mdt7eqSoYwrSOWz7KJCNE9nOz8Hl+LcW5emKcpS9vkHvJzuaerUkgOO08djyj1BiwU2ULIvybSr/As0ABFyn2o0fjhzPSMYVPev1VHTuU9JaCiUqSlTbe6g8ngdvrsOoit8t9NE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706246801; c=relaxed/simple;
	bh=0srVlTuuRr5HXWXZIGZUv/anH3kUhIIgqfalf3rkwDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VitMzqflmILjYJTbR0k0BTzXHpfXwq96AlNOcMuRQnU8V/4ZgPDjAML+BKvteQCpzxwtTMft1y9dx3F3sQPoTuF8laWizLCbhdZ9teAhAavFBtNmCjZGC5oe/0Lizwau4WF4ChiK5LfU+VpprnNZCeIrdBABzmvYADZ776JfOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHU5YN8v; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706246799; x=1737782799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0srVlTuuRr5HXWXZIGZUv/anH3kUhIIgqfalf3rkwDE=;
  b=GHU5YN8vazhO+6d25717gqwsSfJ2h1fJOy5ld1amfvjyiPNpNVT2OwFg
   C5w04xAs2TDr4s6NQB+cTEcaafLkvPKO4FDCFuh51VJe7vCXtvYY7WM4e
   6MJ8OGVa40zRhVu02l1DlIkw+YANR+yBoWyoqXac30726E4YHFUYlee9X
   FUiC8qoeSyM2dnuigChuvXrahqL12vlR8K22irTS5QRcVZFujmCFYm1Rk
   gkLNTOwhNCyeSHsquBctKGCFkmkqJXJbuKJj5uDpxb6fpBuSSRSK7qXH1
   mBACRY/urCHR+O7l43WrP0mTzExsKobiftV4F1AbBq+7Cij6Isc6sthCd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399556914"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399556914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 21:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960113139"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960113139"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2024 21:26:33 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTEjX-0000iq-0P;
	Fri, 26 Jan 2024 05:26:31 +0000
Date: Fri, 26 Jan 2024 13:25:43 +0800
From: kernel test robot <lkp@intel.com>
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
	akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de,
	maz@kernel.org, liusong@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCH 1/3] watchdog/softlockup: low-overhead detection of
 interrupt storm
Message-ID: <202401261310.Ixxefn7o-lkp@intel.com>
References: <20240123121223.22318-2-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123121223.22318-2-yaoma@linux.alibaba.com>

Hi Bitao,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.8-rc1 next-20240125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bitao-Hu/watchdog-softlockup-low-overhead-detection-of-interrupt-storm/20240123-201509
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20240123121223.22318-2-yaoma%40linux.alibaba.com
patch subject: [PATCH 1/3] watchdog/softlockup: low-overhead detection of interrupt storm
config: i386-randconfig-013-20240126 (https://download.01.org/0day-ci/archive/20240126/202401261310.Ixxefn7o-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240126/202401261310.Ixxefn7o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401261310.Ixxefn7o-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/watchdog.o: in function `print_cpustat':
>> kernel/watchdog.c:453: undefined reference to `__udivdi3'
>> ld: kernel/watchdog.c:457: undefined reference to `__udivdi3'


vim +453 kernel/watchdog.c

   446	
   447	static void print_cpustat(void)
   448	{
   449		int i, j, k;
   450		u64 a[5][NR_STATS], b[5][NR_STATS];
   451		u64 (*diff)[NR_STATS] = this_cpu_ptr(cpustat_diff);
   452		int tail = this_cpu_read(cpustat_tail);
 > 453		u32 period_us = sample_period / 1000;
   454	
   455		for (i = 0; i < 5; i++) {
   456			for (j = 0; j < NR_STATS; j++) {
 > 457				a[i][j] = 100 * (diff[i][j] / 1000);
   458				b[i][j] = 10 * do_div(a[i][j], period_us);
   459				do_div(b[i][j], period_us);
   460			}
   461		}
   462		printk(KERN_CRIT "CPU#%d Utilization every %us during lockup:\n",
   463			smp_processor_id(), period_us/1000000);
   464		for (k = 0, i = tail; k < 5; k++, i = (i + 1) % 5) {
   465			printk(KERN_CRIT "\t#%d: %llu.%llu%% system,\t%llu.%llu%% softirq,\t"
   466				"%llu.%llu%% hardirq,\t%llu.%llu%% idle\n", k+1,
   467				a[i][CPUTIME_SYSTEM], b[i][CPUTIME_SYSTEM],
   468				a[i][CPUTIME_SOFTIRQ], b[i][CPUTIME_SOFTIRQ],
   469				a[i][CPUTIME_IRQ], b[i][CPUTIME_IRQ],
   470				a[i][CPUTIME_IDLE], b[i][CPUTIME_IDLE]);
   471		}
   472	}
   473	#else
   474	static inline void update_cpustat(void) { }
   475	static inline void print_cpustat(void) { }
   476	#endif
   477	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

