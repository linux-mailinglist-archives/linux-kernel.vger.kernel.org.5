Return-Path: <linux-kernel+bounces-56756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFA84CEAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4C41F27C17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB180625;
	Wed,  7 Feb 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZO2HDLZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B678005B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322331; cv=none; b=AOvzcCqgj+E7/6WbvfQ5qnMJ8eTh7e/9EF+Qspv4UR5JRMFv2mBaiEEYfKusiA23ZkACl8H9UJ+iTG6cld5PjWTPOizO3NU90nOPzR5ORl45CvQ2weeSiVw9+KCIKQIZibxofYnmyR6Q6O3zMeRuRuoDjAft2ysZv6Qta2wjbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322331; c=relaxed/simple;
	bh=5F5E0dfdj/Bp1qcJ0kg1990CfjZ+HrLrlTft1L8lJ5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nIncDNeRbvqXFgXKNZZ8gh0d22ZpaZL29e7WVJ6lRs8Erk5nvw9448ZYGnuMXECbZ4guR7Yn8fYWRhiPEsfg7RHiR8s1p2tHts9vp/vANRwFQhiqr564+W7GTGj5sIgImsGMG4s+VuovgVmS8tHSld/w1dcRij1SP2w+ZDZPoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZO2HDLZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707322329; x=1738858329;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5F5E0dfdj/Bp1qcJ0kg1990CfjZ+HrLrlTft1L8lJ5k=;
  b=mZO2HDLZ0I73zFt5Bk/08RIbWhCQutgv/K4NQprGshwD9n47RmXXhJaC
   ooAAmoJmJvEUfUnSWOSm8mXIhrrnDMb8tiBJviEY/rv/H+WAUFn5NCAUG
   qI9leF0Pp3OuAypEw6h52FjMcXg9IDgW4qvUa3LXkgW8hALt801mGwWlb
   ipbEFsxT9ObYiovEc+fxdvxozzogGF1B8uUUgmB376oHoGlMwtc6exylA
   KYwL1iTLd1VVMCkL7mOPrQhvPtKCkJzjOigFY0kO9eqA5D9tJT0HD//Hc
   LE8eQlpSDNuvL70d8AbHP7gXdZBfcV5NihSYqMWQEHylytEOFPhUruHsY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1157610"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1157610"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="933826260"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="933826260"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 08:12:01 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXkWl-0002my-1H;
	Wed, 07 Feb 2024 16:11:59 +0000
Date: Thu, 8 Feb 2024 00:11:36 +0800
From: kernel test robot <lkp@intel.com>
To: David Wang <davidwang@zhaoxin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/kernel/cpu/intel.c:673:34: warning: variable 'l2' set but
 not used
Message-ID: <202402080007.mX2pYVVF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d280f4d760e3bcb4a8df302afebf085b65ec982
commit: 807e9bc8e2fe6b4907f9f77fd073f7ef5073af29 x86/CPU: Move cpu_detect_cache_sizes() into init_intel_cacheinfo()
date:   6 years ago
config: x86_64-randconfig-x051-20230705 (https://download.01.org/0day-ci/archive/20240208/202402080007.mX2pYVVF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402080007.mX2pYVVF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402080007.mX2pYVVF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/cpu/intel.c: In function 'init_intel':
>> arch/x86/kernel/cpu/intel.c:673:34: warning: variable 'l2' set but not used [-Wunused-but-set-variable]
     673 |                 unsigned int l1, l2;
         |                                  ^~
   arch/x86/kernel/cpu/intel.o: warning: objtool: init_intel_misc_features()+0x1d7: sibling call from callable instruction with modified stack frame
   arch/x86/kernel/cpu/intel.o: warning: objtool: init_intel_energy_perf()+0x9b: sibling call from callable instruction with modified stack frame
   arch/x86/kernel/cpu/intel.o: warning: objtool: detect_tme()+0x150: sibling call from callable instruction with modified stack frame
   arch/x86/kernel/cpu/intel.o: warning: objtool: early_init_intel()+0x583: sibling call from callable instruction with modified stack frame


vim +/l2 +673 arch/x86/kernel/cpu/intel.c

   635	
   636	static void init_intel(struct cpuinfo_x86 *c)
   637	{
   638		early_init_intel(c);
   639	
   640		intel_workarounds(c);
   641	
   642		/*
   643		 * Detect the extended topology information if available. This
   644		 * will reinitialise the initial_apicid which will be used
   645		 * in init_intel_cacheinfo()
   646		 */
   647		detect_extended_topology(c);
   648	
   649		if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
   650			/*
   651			 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
   652			 * detection.
   653			 */
   654			c->x86_max_cores = detect_num_cpu_cores(c);
   655	#ifdef CONFIG_X86_32
   656			detect_ht(c);
   657	#endif
   658		}
   659	
   660		init_intel_cacheinfo(c);
   661	
   662		if (c->cpuid_level > 9) {
   663			unsigned eax = cpuid_eax(10);
   664			/* Check for version and the number of counters */
   665			if ((eax & 0xff) && (((eax>>8) & 0xff) > 1))
   666				set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
   667		}
   668	
   669		if (cpu_has(c, X86_FEATURE_XMM2))
   670			set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
   671	
   672		if (boot_cpu_has(X86_FEATURE_DS)) {
 > 673			unsigned int l1, l2;
   674	
   675			rdmsr(MSR_IA32_MISC_ENABLE, l1, l2);
   676			if (!(l1 & (1<<11)))
   677				set_cpu_cap(c, X86_FEATURE_BTS);
   678			if (!(l1 & (1<<12)))
   679				set_cpu_cap(c, X86_FEATURE_PEBS);
   680		}
   681	
   682		if (c->x86 == 6 && boot_cpu_has(X86_FEATURE_CLFLUSH) &&
   683		    (c->x86_model == 29 || c->x86_model == 46 || c->x86_model == 47))
   684			set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
   685	
   686		if (c->x86 == 6 && boot_cpu_has(X86_FEATURE_MWAIT) &&
   687			((c->x86_model == INTEL_FAM6_ATOM_GOLDMONT)))
   688			set_cpu_bug(c, X86_BUG_MONITOR);
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

