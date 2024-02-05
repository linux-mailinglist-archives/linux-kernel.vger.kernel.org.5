Return-Path: <linux-kernel+bounces-52197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237684953C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39282814CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D9111AE;
	Mon,  5 Feb 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFarbNJZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066B111A2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121225; cv=none; b=lRIHJmOqC7WzVdV/n8MOzl/3gcfqqMwwv8QdEcCfnCXC96N2XhZ1B8Q1UoK+JedNWl5eQz20tXKb6fSjXZ2MLCfIiGD86FVjabRZwaijAX/DuY5YUr2X524ckM9IlIn5YMPErLuWgtzdwRSMRwmtjymKTi4Qll+T/WvkNG4FKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121225; c=relaxed/simple;
	bh=vy4K2p6QxT+8hjXLL/Go4Lky3C+xlZhTyYZy2s0sIj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N3UT1E6jKxC5+LdR5+8Y/ueadsimG1aL6K7n9/TNBC7iAaIn9eTUqdtUqq+nTOLXbLgotgSCpfv0FdfKK4TrMFtCM+9AOzQsPgWJdZ0zw9DZ8A5yGe5ypFiAtBKRXaKKBhyfPEiAq2ppES0VfpdQ2JeZYoBWeSS45u9fJa5D6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFarbNJZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707121223; x=1738657223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vy4K2p6QxT+8hjXLL/Go4Lky3C+xlZhTyYZy2s0sIj0=;
  b=KFarbNJZj0lcXrUljnnOTT0RTK9UKUYq9IXAmwtFYf/S3n2QFGKevUNL
   /U5HnMLs2+4EGmUjHNKkqA/UsMvp12klde4uRXd7ofeOOlcQg82zYxgj1
   QS/gsJO02GjyYukSCAoxW1Hnc0rGJ7mQrPgEhl+owaBWouRHQ4LddwVqR
   EBG/h54BSdC9dQr+L86PPVhpNauGpyyE0BOUBSXtYzr+KLxVQjmqxX8mT
   NF3ldKaz/0qOTFNu63sicIMALWJ29RxLDTzGq8qumD8GB53hGx4XgPhbV
   fm6jC/lPiWd/FWWBFYH5m/awOoy3BeP38rWnIhLXU4uyEK6Z33HRI7GWQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="728157"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="728157"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 00:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5283004"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Feb 2024 00:20:18 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWuD9-0000H4-1a;
	Mon, 05 Feb 2024 08:20:15 +0000
Date: Mon, 5 Feb 2024 16:19:47 +0800
From: kernel test robot <lkp@intel.com>
To: Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:338:45: error: call to
 '__compiletime_assert_270' declared with attribute error: BUILD_BUG_ON
 failed: SECTIONS_WIDTH + NODES_WIDTH + ZONES_WIDTH +
 ilog2(roundup_pow_of_two(NR_CPUS)) > 32
Message-ID: <202402051630.uyEkSOkn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Will,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
commit: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
date:   3 years, 7 months ago
config: sparc-randconfig-002-20240113 (https://download.01.org/0day-ci/archive/20240205/202402051630.uyEkSOkn-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240205/202402051630.uyEkSOkn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402051630.uyEkSOkn-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'sun4v_linear_pte_xor_finalize':
   arch/sparc/mm/init_64.c:2210:23: warning: variable 'pagecv_flag' set but not used [-Wunused-but-set-variable]
    2210 |         unsigned long pagecv_flag;
         |                       ^~~~~~~~~~~
   In file included from <command-line>:
   arch/sparc/mm/init_64.c: In function 'paging_init':
>> include/linux/compiler_types.h:338:45: error: call to '__compiletime_assert_270' declared with attribute error: BUILD_BUG_ON failed: SECTIONS_WIDTH + NODES_WIDTH + ZONES_WIDTH + ilog2(roundup_pow_of_two(NR_CPUS)) > 32
     338 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:319:25: note: in definition of macro '__compiletime_assert'
     319 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:338:9: note: in expansion of macro '_compiletime_assert'
     338 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/sparc/mm/init_64.c:2306:9: note: in expansion of macro 'BUILD_BUG_ON'
    2306 |         BUILD_BUG_ON(SECTIONS_WIDTH + NODES_WIDTH + ZONES_WIDTH +
         |         ^~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
   Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
   Selected by [y]:
   - COMPAT [=y] && SPARC64 [=y]
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by [y]:
   - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]


vim +/__compiletime_assert_270 +338 include/linux/compiler_types.h

   324	
   325	#define _compiletime_assert(condition, msg, prefix, suffix) \
   326		__compiletime_assert(condition, msg, prefix, suffix)
   327	
   328	/**
   329	 * compiletime_assert - break build and emit msg if condition is false
   330	 * @condition: a compile-time constant condition to check
   331	 * @msg:       a message to emit if condition is false
   332	 *
   333	 * In tradition of POSIX assert, this macro will break the build if the
   334	 * supplied condition is *false*, emitting the supplied error message if the
   335	 * compiler has support to do so.
   336	 */
   337	#define compiletime_assert(condition, msg) \
 > 338		_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

