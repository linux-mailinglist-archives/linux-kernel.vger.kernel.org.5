Return-Path: <linux-kernel+bounces-51328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90588489D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1D41C213B5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839A7FB;
	Sun,  4 Feb 2024 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrnF0M2b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95938C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 00:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707005597; cv=none; b=htHaGr/hX45gq506Nwe21eRHt1POeQJVvg6eFZVDFMd0uRlXtCizZ90UfU+UxT/rTfcoKTAupR92UV20w9dEPCiCEvihZyWIcEPwAjhFiGvYpLwIaLGLLvYfx5vEBS5dujz2/Hr1sXd2TeWF5gpHyxih5ONdsNjh8sD5mkb4yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707005597; c=relaxed/simple;
	bh=YX8nnL9WxvYRodD41xybrN+YLEXqaxlBtCZYimb1kwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iAZGFnWqUmOHzydP/okCpl6RWM194oQMrAPyZkHITwqB43Zn4mF7D9ciopTSqV2kuVgXsnLISNqPIZYgToKSZiPe9keCJEXvjWPF3VQcW9YMakvO1p2U9zTtHHFHaqHjWIFE3B3rNdtyAR5bXUxGtmqat8n8ELkTeLk7+iYeTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrnF0M2b; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707005595; x=1738541595;
  h=date:from:to:cc:subject:message-id;
  bh=YX8nnL9WxvYRodD41xybrN+YLEXqaxlBtCZYimb1kwc=;
  b=NrnF0M2bHReBYjM7eDZmPmk2MMqhG5WvLi4Jh8zAra7fPkfiIUGylbze
   8dsVqXTTCVZVCyqUz3fgt1vDs0p2Jrdtyw0HfED0soxlrxp00lfUFT0G0
   7oDt2UCJAPWZuemtTDgQQWSJiFwq9Lm4xW21C6k0pE/8siA43WKeT6FmQ
   lo0me5AKwUxNxoaX1XKB4D4WOf7eyLAS7/VvLV0d96tyy7YsPnmsBO0dU
   XJ6W1A6zyNMC6o1jdmHINcjUD/Dj2th6y87IaoVHEIskWB38pm/3DAy40
   XWPoS98qNxbjQKLWgH8yz/N/qmEku7XmlcGqxqzlW+4+Vz9E4jbec2Pc4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="502966"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="502966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 16:13:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="23663123"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Feb 2024 16:13:13 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWQ8E-0005lm-1d;
	Sun, 04 Feb 2024 00:13:10 +0000
Date: Sun, 04 Feb 2024 08:12:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 3909f6fb51679ee6f34580958fbccf9dafaecc11
Message-ID: <202402040854.mdUZxu51-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 3909f6fb51679ee6f34580958fbccf9dafaecc11  rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

elapsed time: 1451m

configs tested: 261
configs skipped: 4

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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-001-20240204   gcc  
arc                   randconfig-002-20240203   gcc  
arc                   randconfig-002-20240204   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                          exynos_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240203   clang
arm                   randconfig-001-20240204   gcc  
arm                   randconfig-002-20240203   clang
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240203   clang
arm                   randconfig-004-20240204   gcc  
arm                         s5pv210_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240203   clang
arm64                 randconfig-001-20240204   gcc  
arm64                 randconfig-002-20240203   clang
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-003-20240204   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-001-20240204   gcc  
csky                  randconfig-002-20240203   gcc  
csky                  randconfig-002-20240204   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240203   clang
hexagon               randconfig-002-20240203   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240203   clang
i386         buildonly-randconfig-001-20240204   gcc  
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-002-20240204   gcc  
i386         buildonly-randconfig-003-20240203   clang
i386         buildonly-randconfig-003-20240204   gcc  
i386         buildonly-randconfig-004-20240203   clang
i386         buildonly-randconfig-004-20240204   gcc  
i386         buildonly-randconfig-005-20240203   clang
i386         buildonly-randconfig-005-20240204   gcc  
i386         buildonly-randconfig-006-20240203   gcc  
i386         buildonly-randconfig-006-20240204   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240203   clang
i386                  randconfig-001-20240204   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-002-20240204   clang
i386                  randconfig-003-20240203   clang
i386                  randconfig-003-20240204   clang
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-004-20240204   gcc  
i386                  randconfig-005-20240203   clang
i386                  randconfig-005-20240204   clang
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-006-20240204   gcc  
i386                  randconfig-011-20240203   clang
i386                  randconfig-011-20240204   clang
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-012-20240204   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-013-20240204   clang
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-014-20240204   clang
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-015-20240204   clang
i386                  randconfig-016-20240203   gcc  
i386                  randconfig-016-20240204   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-001-20240204   gcc  
loongarch             randconfig-002-20240203   gcc  
loongarch             randconfig-002-20240204   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                     cu1000-neo_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-001-20240204   gcc  
nios2                 randconfig-002-20240203   gcc  
nios2                 randconfig-002-20240204   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-001-20240204   gcc  
parisc                randconfig-002-20240203   gcc  
parisc                randconfig-002-20240204   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240203   clang
powerpc               randconfig-001-20240204   gcc  
powerpc               randconfig-002-20240203   clang
powerpc               randconfig-002-20240204   gcc  
powerpc               randconfig-003-20240203   clang
powerpc               randconfig-003-20240204   gcc  
powerpc64             randconfig-001-20240203   clang
powerpc64             randconfig-001-20240204   gcc  
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240203   clang
powerpc64             randconfig-003-20240204   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240203   clang
riscv                 randconfig-002-20240203   clang
riscv                 randconfig-002-20240204   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240203   clang
s390                  randconfig-002-20240204   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-001-20240204   gcc  
sh                    randconfig-002-20240203   gcc  
sh                    randconfig-002-20240204   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-001-20240204   gcc  
sparc64               randconfig-002-20240203   gcc  
sparc64               randconfig-002-20240204   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240203   clang
um                    randconfig-001-20240204   gcc  
um                    randconfig-002-20240203   clang
um                    randconfig-002-20240204   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240203   gcc  
x86_64       buildonly-randconfig-001-20240204   clang
x86_64       buildonly-randconfig-002-20240203   gcc  
x86_64       buildonly-randconfig-002-20240204   clang
x86_64       buildonly-randconfig-003-20240203   gcc  
x86_64       buildonly-randconfig-004-20240203   gcc  
x86_64       buildonly-randconfig-005-20240203   gcc  
x86_64       buildonly-randconfig-005-20240204   clang
x86_64       buildonly-randconfig-006-20240203   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240203   gcc  
x86_64                randconfig-002-20240203   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-003-20240204   clang
x86_64                randconfig-004-20240203   gcc  
x86_64                randconfig-004-20240204   clang
x86_64                randconfig-005-20240203   gcc  
x86_64                randconfig-006-20240203   gcc  
x86_64                randconfig-011-20240203   gcc  
x86_64                randconfig-012-20240203   gcc  
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-015-20240204   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-016-20240204   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-072-20240203   gcc  
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-074-20240204   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-075-20240204   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-001-20240204   gcc  
xtensa                randconfig-002-20240203   gcc  
xtensa                randconfig-002-20240204   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

