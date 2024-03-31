Return-Path: <linux-kernel+bounces-126055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B9893182
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03571B21369
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBEA144300;
	Sun, 31 Mar 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERSZwxq1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195475803
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711884929; cv=none; b=ahv8Or1uK93gMr8KqrvIBTbkSV2H6EbVX3HvShScpDxbPm1DKnB65kxdrudVYEBXoRhNZ9/tS2HxooRNwJdH9QkaB+39tXd6O/l8XdynGx8+p9RvebVmNmhM4fI6PYwVwuvQmmBy8kUHEeC1gG+vnxvTw9GxRfSnHc8nEUQgH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711884929; c=relaxed/simple;
	bh=5ySSUqCjZ+/X2+6psiVbLbb3CfPcwN4ptXRwa0ZWY0A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fNAIYZYvgSaCOjHlFvyBfAsc+WH5LH6H5UGFQ6KdwngDCTE4tjnHLQTMqXI+GWe0NUJS4mN83QQphplXt5irfLnEJ2b6qIWUvQBfPAf4aXv7VOwXt/VIaZggVteEvQdBNlmw00uL8uDLs1tpw2EIhMYSZi7RxCJltKzsn0l8/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERSZwxq1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711884928; x=1743420928;
  h=date:from:to:cc:subject:message-id;
  bh=5ySSUqCjZ+/X2+6psiVbLbb3CfPcwN4ptXRwa0ZWY0A=;
  b=ERSZwxq1iHFfN3VSnOEt+f9cjCskVYF7Vdo9wYWab7HM77D06dPT8aZt
   nBNSb6aF6TwCbDXpcUO0SYoHXt+QI6s1a0HSPkAxcp5jDWLQQJrpUu0Lf
   otx0ZfLdAVjPnjK6UOREzsauNcoqnvF5CbSdClv+gMvhUT2D5s8Ek0L9/
   inTlhbHUVLSCkZMHHxQlVdFpfT5qvr86wxvQIDQxZZLx83Lrr0BzF8TdU
   OC1BRe3S6odTseQl/aXZW+IRLqgdB7u7vDVT3QsaSN7DdG6ma+sBIjoRz
   FsVHEygTFt0vpE2nccu2BlxfjIhqbVP/H+iEaXhjGhfwbjW7ppa4hIZ/H
   g==;
X-CSE-ConnectionGUID: 31guGrUhQB2h0C7ixrIhGQ==
X-CSE-MsgGUID: pRloNrTQS/CQ3iAPkQCK9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="7158508"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="7158508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 04:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="17486136"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Mar 2024 04:35:24 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqtT8-000147-2N;
	Sun, 31 Mar 2024 11:35:22 +0000
Date: Sun, 31 Mar 2024 19:35:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.28a] BUILD REGRESSION
 a326496eb88936b291adea830c2e59e74ca1d373
Message-ID: <202403311911.OJMPrNOv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.28a
branch HEAD: a326496eb88936b291adea830c2e59e74ca1d373  squash! lib: Add one-byte and two-byte cmpxchg() emulation functions

Error/Warning: (recently discovered and may have been fixed)

/usr/bin/ld: update.c:(.ltext+0x1f1e): undefined reference to `cmpxchg_emu_u8'
update.c:(.ltext+0x69e): undefined reference to `cmpxchg_emu_u8'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- um-randconfig-001-20240331
    |-- update.c:(.ltext):undefined-reference-to-cmpxchg_emu_u8
    `-- usr-bin-ld:update.c:(.ltext):undefined-reference-to-cmpxchg_emu_u8

elapsed time: 919m

configs tested: 181
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240331   gcc  
arc                   randconfig-002-20240331   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         orion5x_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240331   gcc  
arm                   randconfig-002-20240331   gcc  
arm                   randconfig-003-20240331   clang
arm                   randconfig-004-20240331   clang
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240331   gcc  
arm64                 randconfig-002-20240331   gcc  
arm64                 randconfig-003-20240331   gcc  
arm64                 randconfig-004-20240331   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240331   gcc  
csky                  randconfig-002-20240331   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240331   clang
hexagon               randconfig-002-20240331   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240331   clang
i386         buildonly-randconfig-002-20240331   clang
i386         buildonly-randconfig-003-20240331   clang
i386         buildonly-randconfig-004-20240331   gcc  
i386         buildonly-randconfig-005-20240331   gcc  
i386         buildonly-randconfig-006-20240331   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240331   gcc  
i386                  randconfig-002-20240331   gcc  
i386                  randconfig-003-20240331   clang
i386                  randconfig-004-20240331   gcc  
i386                  randconfig-005-20240331   gcc  
i386                  randconfig-006-20240331   gcc  
i386                  randconfig-011-20240331   clang
i386                  randconfig-012-20240331   gcc  
i386                  randconfig-013-20240331   gcc  
i386                  randconfig-014-20240331   gcc  
i386                  randconfig-015-20240331   clang
i386                  randconfig-016-20240331   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240331   gcc  
loongarch             randconfig-002-20240331   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240331   gcc  
nios2                 randconfig-002-20240331   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240331   gcc  
parisc                randconfig-002-20240331   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240331   clang
powerpc               randconfig-002-20240331   gcc  
powerpc               randconfig-003-20240331   clang
powerpc                     stx_gp3_defconfig   clang
powerpc64             randconfig-001-20240331   clang
powerpc64             randconfig-002-20240331   gcc  
powerpc64             randconfig-003-20240331   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240331   gcc  
riscv                 randconfig-002-20240331   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240331   clang
s390                  randconfig-002-20240331   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240331   gcc  
sh                    randconfig-002-20240331   gcc  
sh                           se7705_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240331   gcc  
sparc64               randconfig-002-20240331   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240331   clang
um                    randconfig-002-20240331   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240331   gcc  
x86_64       buildonly-randconfig-002-20240331   clang
x86_64       buildonly-randconfig-003-20240331   clang
x86_64       buildonly-randconfig-004-20240331   clang
x86_64       buildonly-randconfig-005-20240331   clang
x86_64       buildonly-randconfig-006-20240331   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240331   gcc  
x86_64                randconfig-002-20240331   gcc  
x86_64                randconfig-003-20240331   gcc  
x86_64                randconfig-004-20240331   clang
x86_64                randconfig-005-20240331   gcc  
x86_64                randconfig-006-20240331   clang
x86_64                randconfig-011-20240331   gcc  
x86_64                randconfig-012-20240331   clang
x86_64                randconfig-013-20240331   gcc  
x86_64                randconfig-014-20240331   gcc  
x86_64                randconfig-015-20240331   gcc  
x86_64                randconfig-016-20240331   gcc  
x86_64                randconfig-071-20240331   gcc  
x86_64                randconfig-072-20240331   gcc  
x86_64                randconfig-073-20240331   gcc  
x86_64                randconfig-074-20240331   clang
x86_64                randconfig-075-20240331   gcc  
x86_64                randconfig-076-20240331   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240331   gcc  
xtensa                randconfig-002-20240331   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

