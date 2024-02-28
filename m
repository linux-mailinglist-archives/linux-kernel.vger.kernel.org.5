Return-Path: <linux-kernel+bounces-85575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE086B7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BD41C20A11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6DB7440B;
	Wed, 28 Feb 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BKs6uSK3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB55D79B74
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147392; cv=none; b=MMr+CyzX5s4dEnqRO4aQ66OeWASHEYfoi/vEvzNFAarfi3HGHrFmYgMRUrP1MFYf4+QHaV+nrm6zqUfWK25eRAVbvSNlBLKSEJMUmLvHNj0vSPicFX+JKtCcWNftKiOxrNH4jOCYCaINchtvcNzFf+TrJJlWYqh2MldlXHm00Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147392; c=relaxed/simple;
	bh=oV0fNQfrX7ORhGgGj3q270nxqTcx6NM05Ak6RkSspYA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P7N3Tqas2bzoE+D9HPHmc0Iv38JR0xdWaHkbIb5nlcFZgtDFyw/m2a+zpHOKX6NiLIEN3bkAirUObGxyXcQRzd214whB/Xd2RpGpuHhEyomYwHSlAsJxLaarcx+quwqRDLWJIYCiRMKQmIH+BUIdFt108iFSkeIz7wCAqxRebsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BKs6uSK3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709147391; x=1740683391;
  h=date:from:to:cc:subject:message-id;
  bh=oV0fNQfrX7ORhGgGj3q270nxqTcx6NM05Ak6RkSspYA=;
  b=BKs6uSK36kDu7wxuY4lSVXHI8XysrhpPOP6U5jzR+RbyquyLhC+grsUm
   l1gCdeubxhNdFflU4nnyMHenE9kcZHDdSwaSpFCkMy4VCxKuaX46v/zRh
   pYXQ0SEFUQg0k+VRgW2lKpRPcEA9qBeed9jE30fRat0tDwUTxrl0lAS38
   daDQo/LAZ3hfhTEZ9pmrjKABpFCndEIXaWGfVDpi1HHqXR8I3rfe1GfpO
   9R0V08xAmHQRN62yzqTCyRKAnKb5N8+V+K9f/fCSGbpjAlBaotemH7CoL
   d4WTUlEbmzPNivbz+SFI4KBsZUrmePeTst/5o74/rm6L+Rr7ka8YR85gP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3435881"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3435881"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12153568"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2024 11:09:49 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfPJL-000CKO-0A;
	Wed, 28 Feb 2024 19:09:47 +0000
Date: Thu, 29 Feb 2024 03:09:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.23a] BUILD SUCCESS
 2fcf5a0f06f2edb7794af897756791278bcc6100
Message-ID: <202402290327.ocl5LEKD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.23a
branch HEAD: 2fcf5a0f06f2edb7794af897756791278bcc6100  rcu: Add lockdep checks and kernel-doc header to rcu_softirq_qs()

elapsed time: 1070m

configs tested: 151
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
arc                   randconfig-001-20240228   gcc  
arc                   randconfig-002-20240228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-004-20240228   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240228   gcc  
arm64                 randconfig-003-20240228   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240228   gcc  
csky                  randconfig-002-20240228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240228   clang
i386         buildonly-randconfig-002-20240228   clang
i386         buildonly-randconfig-003-20240228   clang
i386         buildonly-randconfig-004-20240228   clang
i386         buildonly-randconfig-005-20240228   gcc  
i386         buildonly-randconfig-006-20240228   clang
i386                                defconfig   clang
i386                  randconfig-001-20240228   clang
i386                  randconfig-002-20240228   clang
i386                  randconfig-003-20240228   gcc  
i386                  randconfig-004-20240228   clang
i386                  randconfig-005-20240228   clang
i386                  randconfig-006-20240228   gcc  
i386                  randconfig-011-20240228   clang
i386                  randconfig-012-20240228   clang
i386                  randconfig-013-20240228   gcc  
i386                  randconfig-014-20240228   gcc  
i386                  randconfig-015-20240228   gcc  
i386                  randconfig-016-20240228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240228   gcc  
loongarch             randconfig-002-20240228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240228   gcc  
nios2                 randconfig-002-20240228   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240228   gcc  
parisc                randconfig-002-20240228   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc               randconfig-003-20240228   gcc  
powerpc64             randconfig-003-20240228   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240228   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240228   gcc  
sh                    randconfig-002-20240228   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240228   gcc  
sparc64               randconfig-002-20240228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240228   clang
x86_64       buildonly-randconfig-003-20240228   clang
x86_64       buildonly-randconfig-006-20240228   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240228   clang
x86_64                randconfig-006-20240228   clang
x86_64                randconfig-011-20240228   clang
x86_64                randconfig-012-20240228   clang
x86_64                randconfig-013-20240228   clang
x86_64                randconfig-072-20240228   clang
x86_64                randconfig-075-20240228   clang
x86_64                randconfig-076-20240228   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240228   gcc  
xtensa                randconfig-002-20240228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

