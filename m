Return-Path: <linux-kernel+bounces-118390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD488BA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38B11F3BADC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036E12AAD9;
	Tue, 26 Mar 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0sTQjGt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10784D0D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432793; cv=none; b=dU/QrSu41Z0F07CmObaPNd027M1kExtmaYFbpzB/JevWY7OyegWAFd+ZSFGNtZh3z7qEjXf7oxx8CHtGfXjRQo6RV1Rs8l818N3OdH3A76fM32CqBJgizs2IUh15fyqE241kOZYv818IEWxHve6HJaHZKYZpZv9c9xWTtE/ZX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432793; c=relaxed/simple;
	bh=L7nngx2KYVizDBoA5P/3uP+meeHn6xRi/4qedSv9Tb8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d1jtuK27zD3V+WGuaW0zdqlv7LWHSVWbNlOtx9Ptjot/fu8dx1KCFShLVG/n5tAYyHOTZjrBOAlAvURZU73y63aFgHWsMtL2t5bq4qVHB5qo7N/mu4kN5h3VMMOILdYnSYYuycfvNe2yzXiNEjzI/gIgMk+rLK+PTMEm8kE1lAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0sTQjGt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711432792; x=1742968792;
  h=date:from:to:cc:subject:message-id;
  bh=L7nngx2KYVizDBoA5P/3uP+meeHn6xRi/4qedSv9Tb8=;
  b=I0sTQjGttjJWiZ5eQhBYIwHp63yQ9bPvTDeoSOJrCIvhn7WQmwKXuKeR
   T9sDjxVjSVIQBhry7PyuZJJAzpyGzx7lz7vjpQV1nBs4TsNAwTCrPdgmi
   dmVpYh+/O/FgCmsdM26h16PsEhCr62Cx8oJb37bvAZCkp6WqBwG+lfk5K
   lDg3fDS9MHwYqFglVan17qkiE5nEHa3j0reT0EV8djpkWmxtX2s/03pHe
   SPlGzAJ26PgsSujPZ6ZQucpGdrllBJV4BIlVcs45NaYrDiDbHkaZmnlzs
   mezi1pSr9aBcwvyr23N46OZxgH0oM+UPIl2N3Dt5RFJ7WMGGVyVOWEA4K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6595449"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6595449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 22:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20513292"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 25 Mar 2024 22:59:49 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rozqc-000N9a-2s;
	Tue, 26 Mar 2024 05:59:46 +0000
Date: Tue, 26 Mar 2024 13:59:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:WIP.fixes] BUILD SUCCESS
 6828f035430feb306f4aad44e39763b7bc02660d
Message-ID: <202403261333.7GRjI21L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.fixes
branch HEAD: 6828f035430feb306f4aad44e39763b7bc02660d  uio_pruss: Fix build failure on 32 bit builds with 64 bit physaddr

elapsed time: 1172m

configs tested: 203
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
arc                          axs101_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240326   gcc  
arc                   randconfig-002-20240326   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240326   gcc  
arm                   randconfig-002-20240326   gcc  
arm                   randconfig-003-20240326   gcc  
arm                   randconfig-004-20240326   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         s5pv210_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240326   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240326   gcc  
csky                  randconfig-002-20240326   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240325   clang
i386         buildonly-randconfig-002-20240325   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240325   gcc  
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-004-20240325   gcc  
i386         buildonly-randconfig-005-20240325   clang
i386         buildonly-randconfig-006-20240325   clang
i386                                defconfig   clang
i386                  randconfig-001-20240325   gcc  
i386                  randconfig-002-20240325   gcc  
i386                  randconfig-003-20240325   clang
i386                  randconfig-004-20240325   gcc  
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240325   gcc  
i386                  randconfig-006-20240325   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240325   gcc  
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240325   clang
i386                  randconfig-013-20240325   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240325   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-015-20240325   gcc  
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240325   gcc  
i386                  randconfig-016-20240326   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240326   gcc  
loongarch             randconfig-002-20240326   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240326   gcc  
nios2                 randconfig-002-20240326   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240326   gcc  
parisc                randconfig-002-20240326   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-002-20240326   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240326   gcc  
powerpc64             randconfig-002-20240326   gcc  
powerpc64             randconfig-003-20240326   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240326   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240326   gcc  
sh                    randconfig-002-20240326   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240326   gcc  
sparc64               randconfig-002-20240326   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240326   gcc  
um                    randconfig-002-20240326   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-076-20240326   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240326   gcc  
xtensa                randconfig-002-20240326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

