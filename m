Return-Path: <linux-kernel+bounces-79956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0048628F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F1F1C20E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873E85382;
	Sun, 25 Feb 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmXK5w1c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067C10F4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831017; cv=none; b=efsTCjrbEX2+MBl6Qg5Ke6MD9/NRpeLyhjXVZo/+VljDUryXF34itQ1HqYiGJDrkorNaLIok9pfa1EtFAlNFo7UDY+UOo4+BIiEJZazoecxTYWwltzUTAOS7MD1rUFa2RS0PhFSWUFyPM9VDusz7pPk5k2Uc8Nygjd7yUcU4slM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831017; c=relaxed/simple;
	bh=fjNssO1TQTTV3qjeyKW1Xocz6sqp/3GhMai8gLI5Oyk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Oq5ZhVc+ebkSLnf7RDaQe7wv3JTUw3CDABdN06FJm2gKU673PhovbeluHVFNbaZY3XOfzGe3hDdU+vPO2TEzLs2MfmJ12goOBaESFutExZuMjNHCNJPz+3OA0JoVB70+wRLajboDKgv+Hv7w/XWYhBiqnZDjB4nLt/GhpQF23co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmXK5w1c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708831016; x=1740367016;
  h=date:from:to:cc:subject:message-id;
  bh=fjNssO1TQTTV3qjeyKW1Xocz6sqp/3GhMai8gLI5Oyk=;
  b=FmXK5w1cGUWY7ZgFz5Fwvy34zag6QEIoH73dJfk5jhWN/6C7qv/hxi6Y
   M1xPPxwyfsliyUFSk/PEHVwV9/DNoGWne3YhN0RWLtzQhKS2s0kgsymZt
   BTsWewDUwMEKdFvzUtBPU/yuPoTUY4VGPtfT3Wgi095Qcf3louWK/iVgt
   Pa0yZXlUblR/DoN6sDu2HGW9fZH3I3FkwfkR2l09an2OUkR44VdK7YXnC
   jTOQDexi5RJO7mXsC+ZLT19K4utYAFjGqc9ndBZ8yCzAY95n0C9rqE/rp
   M/6Lll83dQzZ450PhVYC7iTxuLN4Xrw9Xnl4nspDKCTeZciBNoLwNnR7k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="6948050"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="6948050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 19:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="10909933"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2024 19:16:53 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1re50U-0009G2-2i;
	Sun, 25 Feb 2024 03:16:50 +0000
Date: Sun, 25 Feb 2024 11:14:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.22a] BUILD SUCCESS
 870a279c3d8355308bdd9a65b0cabac479ceea03
Message-ID: <202402251132.ou4qAT7e-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.22a
branch HEAD: 870a279c3d8355308bdd9a65b0cabac479ceea03  rcu-tasks: Replace exit_tasks_rcu_start() initialization with WARN_ON_ONCE()

elapsed time: 1452m

configs tested: 226
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240224   gcc  
arc                   randconfig-001-20240225   gcc  
arc                   randconfig-002-20240224   gcc  
arc                   randconfig-002-20240225   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240224   gcc  
arm                   randconfig-002-20240224   gcc  
arm                   randconfig-002-20240225   gcc  
arm                   randconfig-003-20240224   gcc  
arm                   randconfig-004-20240224   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           sama5_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240224   gcc  
arm64                 randconfig-001-20240225   gcc  
arm64                 randconfig-002-20240224   gcc  
arm64                 randconfig-003-20240225   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240224   gcc  
csky                  randconfig-001-20240225   gcc  
csky                  randconfig-002-20240224   gcc  
csky                  randconfig-002-20240225   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240225   gcc  
i386         buildonly-randconfig-002-20240224   clang
i386         buildonly-randconfig-002-20240225   gcc  
i386         buildonly-randconfig-004-20240225   gcc  
i386         buildonly-randconfig-005-20240224   clang
i386         buildonly-randconfig-006-20240224   clang
i386         buildonly-randconfig-006-20240225   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240225   gcc  
i386                  randconfig-002-20240224   clang
i386                  randconfig-003-20240224   clang
i386                  randconfig-004-20240225   gcc  
i386                  randconfig-005-20240225   gcc  
i386                  randconfig-006-20240225   gcc  
i386                  randconfig-012-20240225   gcc  
i386                  randconfig-013-20240224   clang
i386                  randconfig-013-20240225   gcc  
i386                  randconfig-014-20240224   clang
i386                  randconfig-015-20240224   clang
i386                  randconfig-015-20240225   gcc  
i386                  randconfig-016-20240224   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240224   gcc  
loongarch             randconfig-001-20240225   gcc  
loongarch             randconfig-002-20240224   gcc  
loongarch             randconfig-002-20240225   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                          rm200_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240224   gcc  
nios2                 randconfig-001-20240225   gcc  
nios2                 randconfig-002-20240224   gcc  
nios2                 randconfig-002-20240225   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240224   gcc  
parisc                randconfig-001-20240225   gcc  
parisc                randconfig-002-20240224   gcc  
parisc                randconfig-002-20240225   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                        fsp2_defconfig   gcc  
powerpc                          g5_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240224   gcc  
powerpc64             randconfig-001-20240225   gcc  
powerpc64             randconfig-003-20240224   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240224   gcc  
riscv                 randconfig-001-20240225   gcc  
riscv                 randconfig-002-20240225   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240224   gcc  
s390                  randconfig-001-20240225   gcc  
s390                  randconfig-002-20240224   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240224   gcc  
sh                    randconfig-001-20240225   gcc  
sh                    randconfig-002-20240224   gcc  
sh                    randconfig-002-20240225   gcc  
sh                          rsk7201_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240224   gcc  
sparc64               randconfig-001-20240225   gcc  
sparc64               randconfig-002-20240224   gcc  
sparc64               randconfig-002-20240225   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240224   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240224   clang
x86_64       buildonly-randconfig-001-20240225   clang
x86_64       buildonly-randconfig-002-20240224   clang
x86_64       buildonly-randconfig-002-20240225   clang
x86_64       buildonly-randconfig-003-20240224   clang
x86_64       buildonly-randconfig-003-20240225   clang
x86_64       buildonly-randconfig-004-20240224   clang
x86_64       buildonly-randconfig-005-20240224   clang
x86_64       buildonly-randconfig-005-20240225   clang
x86_64       buildonly-randconfig-006-20240224   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240224   clang
x86_64                randconfig-002-20240225   clang
x86_64                randconfig-003-20240224   clang
x86_64                randconfig-004-20240225   clang
x86_64                randconfig-005-20240225   clang
x86_64                randconfig-006-20240224   clang
x86_64                randconfig-011-20240225   clang
x86_64                randconfig-012-20240225   clang
x86_64                randconfig-014-20240224   clang
x86_64                randconfig-015-20240224   clang
x86_64                randconfig-015-20240225   clang
x86_64                randconfig-016-20240224   clang
x86_64                randconfig-072-20240224   clang
x86_64                randconfig-073-20240224   clang
x86_64                randconfig-073-20240225   clang
x86_64                randconfig-075-20240225   clang
x86_64                randconfig-076-20240224   clang
x86_64                randconfig-076-20240225   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240224   gcc  
xtensa                randconfig-001-20240225   gcc  
xtensa                randconfig-002-20240224   gcc  
xtensa                randconfig-002-20240225   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

