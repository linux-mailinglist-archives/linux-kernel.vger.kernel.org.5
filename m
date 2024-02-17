Return-Path: <linux-kernel+bounces-69778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C70D858E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6679B21994
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7321D553;
	Sat, 17 Feb 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEchPcTc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F51D52C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708162987; cv=none; b=EFQj54b+HeHnl0Fo4pNt+G3UCx0ifEYkQxwTV4tNe9CEd8NozxErm96BZNqCA/4JTQ5540mPz5YFb/CGmmeBpxl0z66IhFnIvp9MvLBZHwOfa5u++eu7V6JxtgPakLqXGyWMhJKWvtELEBFNjUpKX5jDxPGPx5YOo7eeKXKtSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708162987; c=relaxed/simple;
	bh=4BtxzeT468ENpn/RjiszkE0NAw02zk1QYpTOlx4jY9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EAPKI2IRtY8BnoUENDlqLvbdL5B/RIAXsyRvZFV4MHuMPNtpRPIvvRyatep1MpYJWTkDmP57nXCtXo3uMIIHPsfm2wi2510LIuhoEQ+9Qtqi+oH3MCEqJe6Rutm30o9VZG74zeVL1xuvIFiKMz7rAK4FJ1qH2yqwKNarpj1ZjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEchPcTc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708162981; x=1739698981;
  h=date:from:to:cc:subject:message-id;
  bh=4BtxzeT468ENpn/RjiszkE0NAw02zk1QYpTOlx4jY9k=;
  b=eEchPcTcO3ht6jgWNqmI4BACgEPFzasY0BBrKfjmj1k96ob0htwvuG2y
   QbrTD9yuQ6mE0FspBNHx3526l0qaOav/tOWtM9oUs6w0G3DYFzCjjONi9
   U1Gw9ZM37fXtvPyBufdFgSLGRbGtliQ8HFIeuIUx8X8iA3odI+Hw/gbyq
   BP4U/8FYtRKNq1VY0DJ0ERWLo3WbK4WIAn/qarbj5sGeLWSB14fyg5mfv
   48AEGbiN2UsTcA6i2VpGq/LGluZCrlyTNNeqJMbEIxenFNq4s837zj1Ue
   Kr6uZMCq1oaeVvO48+SNU7Ju1J93exGaRho6jxwV4H1VXbeB/ebC91mxw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6069278"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="6069278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 01:43:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="8716892"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2024 01:42:59 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbHDj-000214-2r;
	Sat, 17 Feb 2024 09:42:55 +0000
Date: Sat, 17 Feb 2024 17:42:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 8cec3dd9e5930c82c6bd0af3fdb3a36bcd428310
Message-ID: <202402171722.qqQ97VBQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 8cec3dd9e5930c82c6bd0af3fdb3a36bcd428310  sched/core: Simplify code by removing duplicate #ifdefs

elapsed time: 1446m

configs tested: 195
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240217   gcc  
arc                   randconfig-002-20240217   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-002-20240217   gcc  
arm                   randconfig-003-20240217   gcc  
arm                   randconfig-004-20240217   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240217   gcc  
arm64                 randconfig-003-20240217   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240217   gcc  
csky                  randconfig-002-20240217   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240216   clang
i386         buildonly-randconfig-002-20240217   clang
i386         buildonly-randconfig-003-20240216   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240216   clang
i386         buildonly-randconfig-006-20240217   clang
i386                                defconfig   clang
i386                  randconfig-001-20240216   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240216   clang
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-003-20240217   clang
i386                  randconfig-004-20240216   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240216   clang
i386                  randconfig-006-20240217   clang
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-013-20240217   clang
i386                  randconfig-014-20240216   clang
i386                  randconfig-014-20240217   clang
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-015-20240217   clang
i386                  randconfig-016-20240216   gcc  
i386                  randconfig-016-20240217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240217   gcc  
loongarch             randconfig-002-20240217   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240217   gcc  
nios2                 randconfig-002-20240217   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240217   gcc  
parisc                randconfig-002-20240217   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240217   gcc  
powerpc               randconfig-002-20240217   gcc  
powerpc               randconfig-003-20240217   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-002-20240217   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240217   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240217   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240217   gcc  
sh                    randconfig-002-20240217   gcc  
sh                          sdk7780_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240217   gcc  
sparc64               randconfig-002-20240217   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240217   gcc  
x86_64       buildonly-randconfig-003-20240217   gcc  
x86_64       buildonly-randconfig-004-20240217   gcc  
x86_64       buildonly-randconfig-006-20240217   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240217   gcc  
x86_64                randconfig-011-20240217   gcc  
x86_64                randconfig-012-20240217   gcc  
x86_64                randconfig-014-20240217   gcc  
x86_64                randconfig-015-20240217   gcc  
x86_64                randconfig-071-20240217   gcc  
x86_64                randconfig-072-20240217   gcc  
x86_64                randconfig-073-20240217   gcc  
x86_64                randconfig-075-20240217   gcc  
x86_64                randconfig-076-20240217   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240217   gcc  
xtensa                randconfig-002-20240217   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

