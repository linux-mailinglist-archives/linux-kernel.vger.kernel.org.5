Return-Path: <linux-kernel+bounces-58480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42184E6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9381B1F29287
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1E982D71;
	Thu,  8 Feb 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae+cnaLW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124B8564E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414362; cv=none; b=myy6rhVAUTA672fsI3Yj2sPuvXwykx4YPXkmDkwK3oyj7ygSz/fLsXgmUIIO18p73itQR3beCcAsELJ7kLvLS9NeAsN2ukEL6rkQ6p4d0mPw32xlVSgcHSvgctKC2c5MV4ww5u+H0aaXAOn/ympXkOhOfBMTxB6tcr3FnHdT8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414362; c=relaxed/simple;
	bh=DGawrRqtYeqOrBvzvwOYYvqISr/5uez89z5EVMVIj0U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sFDcnohUIkBSWy9VE/cg/n4V9fjpeexb/DyFxzV3ZhRBa/K2coDORf9FFFW86m6oCOfjLziYM/5JuJbksii8/BdYSFd4beAim8/3ice6rjDuKU4yiqZMtHC6ScKbi8Qapp9zas00d2QRYQWr8Fwk2ykRFxnjYIpiZfmUAONRWlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae+cnaLW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707414360; x=1738950360;
  h=date:from:to:cc:subject:message-id;
  bh=DGawrRqtYeqOrBvzvwOYYvqISr/5uez89z5EVMVIj0U=;
  b=ae+cnaLW9cOws7KStpadYpejpschNuSeJe7ngT6nK+zfUgPwcu1o0Ovb
   6GETlbHa8W7OhHfRVHk+HqpFwaAfl/TxnRX2SFnj+bmq1xYlRWYIWZwxy
   SfisWMsJ+uKY3xYObA8V6Nmj0ZXptz1GbeQRVHfAbGJJ9PW9VnDpkLRj8
   j2FlRyav5s4RyZUgjFiuveXhN+W+Uazo8gXN9ETFTr+I1H7KxynW8QA1V
   EKoT/84jQh1e4nMCc997gP5207apsuuJPt/3OBOs13jU7Y3xecJWZrDUh
   8gwHT5Y4U4n5Bh6pB7DdfODj/WGjRHckYWfPjsiZGAm65WZjipovugGO2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="5132002"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="5132002"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:45:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="2088413"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Feb 2024 09:45:53 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY8T8-000402-15;
	Thu, 08 Feb 2024 17:45:50 +0000
Date: Fri, 09 Feb 2024 01:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 45ba5b3c0a02949a4da74ead6e11c43e9b88bdca
Message-ID: <202402090114.l2XJv9Lk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 45ba5b3c0a02949a4da74ead6e11c43e9b88bdca  iommu/amd: Fix failure return from snp_lookup_rmpentry()

elapsed time: 1452m

configs tested: 167
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
arc                   randconfig-001-20240208   gcc  
arc                   randconfig-002-20240208   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240208   gcc  
arm                   randconfig-002-20240208   gcc  
arm                   randconfig-003-20240208   gcc  
arm                   randconfig-004-20240208   clang
arm                        realview_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240208   clang
arm64                 randconfig-002-20240208   clang
arm64                 randconfig-003-20240208   clang
arm64                 randconfig-004-20240208   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240208   gcc  
csky                  randconfig-002-20240208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240208   clang
hexagon               randconfig-002-20240208   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240208   gcc  
i386         buildonly-randconfig-002-20240208   clang
i386         buildonly-randconfig-003-20240208   gcc  
i386         buildonly-randconfig-004-20240208   gcc  
i386         buildonly-randconfig-005-20240208   gcc  
i386         buildonly-randconfig-006-20240208   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240208   gcc  
i386                  randconfig-002-20240208   gcc  
i386                  randconfig-003-20240208   gcc  
i386                  randconfig-004-20240208   clang
i386                  randconfig-005-20240208   gcc  
i386                  randconfig-006-20240208   gcc  
i386                  randconfig-011-20240208   clang
i386                  randconfig-012-20240208   clang
i386                  randconfig-013-20240208   clang
i386                  randconfig-014-20240208   clang
i386                  randconfig-015-20240208   clang
i386                  randconfig-016-20240208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240208   gcc  
loongarch             randconfig-002-20240208   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                      bmips_stb_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240208   gcc  
nios2                 randconfig-002-20240208   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240208   gcc  
parisc                randconfig-002-20240208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240208   clang
powerpc               randconfig-002-20240208   gcc  
powerpc               randconfig-003-20240208   gcc  
powerpc64             randconfig-001-20240208   gcc  
powerpc64             randconfig-002-20240208   gcc  
powerpc64             randconfig-003-20240208   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240208   gcc  
riscv                 randconfig-002-20240208   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240208   clang
s390                  randconfig-002-20240208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240208   gcc  
sh                    randconfig-002-20240208   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240208   gcc  
sparc64               randconfig-002-20240208   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240208   clang
x86_64       buildonly-randconfig-002-20240208   clang
x86_64       buildonly-randconfig-003-20240208   gcc  
x86_64       buildonly-randconfig-004-20240208   clang
x86_64       buildonly-randconfig-005-20240208   clang
x86_64       buildonly-randconfig-006-20240208   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240208   gcc  
x86_64                randconfig-002-20240208   gcc  
x86_64                randconfig-003-20240208   gcc  
x86_64                randconfig-004-20240208   clang
x86_64                randconfig-005-20240208   gcc  
x86_64                randconfig-006-20240208   gcc  
x86_64                randconfig-011-20240208   gcc  
x86_64                randconfig-012-20240208   gcc  
x86_64                randconfig-013-20240208   clang
x86_64                randconfig-014-20240208   clang
x86_64                randconfig-015-20240208   clang
x86_64                randconfig-016-20240208   clang
x86_64                randconfig-071-20240208   clang
x86_64                randconfig-072-20240208   clang
x86_64                randconfig-073-20240208   gcc  
x86_64                randconfig-074-20240208   clang
x86_64                randconfig-075-20240208   gcc  
x86_64                randconfig-076-20240208   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

