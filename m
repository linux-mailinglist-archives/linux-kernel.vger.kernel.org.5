Return-Path: <linux-kernel+bounces-41347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05283EF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C4B228A7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F52D058;
	Sat, 27 Jan 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDNWFdkK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65E25777
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377861; cv=none; b=GcbJLghUZ4S4sOb0nB9/fv2drN6QHDg9Ayl2sNqnaoXtGCin9Ks8hsWIsPjxhA74ycNd444pMd1RzPFiyBRNw18XFTTWFioyK4c3NgQEnfQ4tSM/SchV9ytCLiFK9jJfIuxWUB1khxteTNBzC4E9HoLaL0rRRkFIUcUAbJUQGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377861; c=relaxed/simple;
	bh=w1bv8M1JtpVH+FUwVsT2zyQxbIjJPUkOAhdT/yuGiPc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GWe1ywgEoBRcooxuvSYrS5vdR4TJoeOox94nWSVxIAQIBJYTagqstvaK1QoSRJC7iIjGmTMIG9xVuJd15qHVaiO/FdI/0u5/WJ3WTidbRsgErwQ/Ysw5baqXSY0dawsTfZ8ZFskiEEdTswfgj1WzxfdGzJ/b8i3bZvGd2ysSyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDNWFdkK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706377860; x=1737913860;
  h=date:from:to:cc:subject:message-id;
  bh=w1bv8M1JtpVH+FUwVsT2zyQxbIjJPUkOAhdT/yuGiPc=;
  b=kDNWFdkKMrutfSahhhj5mi4dgzjhWpus8RLXtaUlkrl+hsdnGe+hYRC9
   /933SuAmWbFGNQF7C5aZN76U5z7Z1Rvg0IBV/CjTs/EFBkuDRfPfKEDMZ
   8J/JeWMNQ7ENAjIYvkhyjyf41x5jwGeya3QovSiVxAicFjXjp/wQn75Pz
   zX4ENsbmtADWPTzgUTNmjwMUkxWvwesiIkmBiOp6zdt+Qxp3vbQcQBogR
   Fl32/ms60Lhcl/D6QY+zLY2m3ZdOtr9ZCADIUOv3cV24JlUeLc4/onLHr
   /lg8U7mAjUlp6LQwlmLdjxN+H+tcW2xmCH3nQsK/tD0kfWcIWSedoMgAR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2532203"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2532203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 09:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910643732"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910643732"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 09:50:54 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTmpP-0002aS-29;
	Sat, 27 Jan 2024 17:50:51 +0000
Date: Sun, 28 Jan 2024 01:50:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 effe6d278e06f85289b6ada0402a6d16ebc149a5
Message-ID: <202401280124.uXniRX9y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: effe6d278e06f85289b6ada0402a6d16ebc149a5  kernel/cpu: Convert snprintf() to sysfs_emit()

elapsed time: 1461m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240127   gcc  
arc                   randconfig-002-20240127   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240127   gcc  
arm                   randconfig-002-20240127   gcc  
arm                   randconfig-003-20240127   gcc  
arm                   randconfig-004-20240127   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240127   gcc  
arm64                 randconfig-002-20240127   gcc  
arm64                 randconfig-003-20240127   gcc  
arm64                 randconfig-004-20240127   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240127   gcc  
csky                  randconfig-002-20240127   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240127   gcc  
loongarch             randconfig-002-20240127   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240127   gcc  
nios2                 randconfig-002-20240127   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240127   gcc  
parisc                randconfig-002-20240127   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   currituck_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc               randconfig-001-20240127   gcc  
powerpc               randconfig-002-20240127   gcc  
powerpc               randconfig-003-20240127   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240127   gcc  
powerpc64             randconfig-002-20240127   gcc  
powerpc64             randconfig-003-20240127   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240127   gcc  
riscv                 randconfig-002-20240127   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240127   gcc  
sh                    randconfig-002-20240127   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240127   gcc  
sparc64               randconfig-002-20240127   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240127   gcc  
um                    randconfig-002-20240127   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240127   gcc  
x86_64       buildonly-randconfig-002-20240127   gcc  
x86_64       buildonly-randconfig-003-20240127   gcc  
x86_64       buildonly-randconfig-004-20240127   gcc  
x86_64       buildonly-randconfig-005-20240127   gcc  
x86_64       buildonly-randconfig-006-20240127   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240127   gcc  
x86_64                randconfig-012-20240127   gcc  
x86_64                randconfig-013-20240127   gcc  
x86_64                randconfig-014-20240127   gcc  
x86_64                randconfig-015-20240127   gcc  
x86_64                randconfig-016-20240127   gcc  
x86_64                randconfig-071-20240127   gcc  
x86_64                randconfig-072-20240127   gcc  
x86_64                randconfig-073-20240127   gcc  
x86_64                randconfig-074-20240127   gcc  
x86_64                randconfig-075-20240127   gcc  
x86_64                randconfig-076-20240127   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240127   gcc  
xtensa                randconfig-002-20240127   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

