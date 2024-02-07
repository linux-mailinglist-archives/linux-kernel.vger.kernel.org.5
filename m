Return-Path: <linux-kernel+bounces-56378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A584C97B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58E228A5BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1E19470;
	Wed,  7 Feb 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ka0Lk+US"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA5182A7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304676; cv=none; b=DkrG97LxGLQWGRPHFSiePaSwRZnYLC1ag0HEHYvcl1YjWj0nK3PtupD2OnuAsIFJhaTXbp1yaEuPwA9yv6btahgWARwt4i4rK+LXKfudwFXUBdNT1E55br+BUKuFJ9bAY+BlDPJAkQvU7givA7qFzskMCR0CARd6lPOxO20aqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304676; c=relaxed/simple;
	bh=tN8KEHU7cDPU0rhzR7IyFcNEgGMW+Iz8N8hiD2DwTig=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AC3kqOoVl0daOYtOkR2N+nuWkJjglh6Rc/PHq5BWyrtKb1aegpVF+JxWnyJjklzb+/OMINiI6O6A5doh1B91CLenWPlurJU8Xh7ShFjm+lba/vlT2y93vgR/CopG8UVNBxh5ULOydp/VB5FUPjs61FS11jk+8HmnxhLtu3ZAb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ka0Lk+US; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707304675; x=1738840675;
  h=date:from:to:cc:subject:message-id;
  bh=tN8KEHU7cDPU0rhzR7IyFcNEgGMW+Iz8N8hiD2DwTig=;
  b=Ka0Lk+USz7kU/Zq1RAqgFKgapWMhgaORHiiOVPua8g2k+CkSSS5gV4VR
   V6NmRYjriJeHjsf50QarfptwXmIMLz910SdSp63729IoOUxjT/TkP9sKV
   icZXK7T8RV3i/ic2ArKDehtEYTa0Sc5w/aCAOmhxKHu099XHSsKXT0+c9
   AzzaV1U7wIYCvOunZYtAeCregib1e7UE+baTgCOXSG1K5tj5LfCVa14bn
   iQO/7FYTjvGvG1qP8rvHcNTUCxTcIOd9HlMDFK//BeKK+dT23p+kUuOCJ
   GrEYNS5yASVBmN6teIoC2HYPpVq7vAyEvKt9UI7cj+kDJjRFxBGn573vC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23443911"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="23443911"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 03:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="32378540"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Feb 2024 03:17:52 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXfw6-0002Xy-0a;
	Wed, 07 Feb 2024 11:17:50 +0000
Date: Wed, 07 Feb 2024 19:17:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 dad6a09f3148257ac1773cd90934d721d68ab595
Message-ID: <202402071943.q81osewp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: dad6a09f3148257ac1773cd90934d721d68ab595  hrtimer: Report offline hrtimer enqueue

elapsed time: 1489m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20240207   gcc  
arc                   randconfig-002-20240207   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                            qcom_defconfig   clang
arm                   randconfig-004-20240207   gcc  
arm                        shmobile_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240207   gcc  
csky                  randconfig-002-20240207   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240206   clang
i386         buildonly-randconfig-002-20240206   clang
i386         buildonly-randconfig-003-20240206   gcc  
i386         buildonly-randconfig-004-20240206   clang
i386         buildonly-randconfig-005-20240206   gcc  
i386         buildonly-randconfig-006-20240206   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240206   clang
i386                  randconfig-001-20240207   gcc  
i386                  randconfig-002-20240206   clang
i386                  randconfig-003-20240206   clang
i386                  randconfig-003-20240207   gcc  
i386                  randconfig-004-20240206   clang
i386                  randconfig-004-20240207   gcc  
i386                  randconfig-005-20240206   clang
i386                  randconfig-005-20240207   gcc  
i386                  randconfig-006-20240206   clang
i386                  randconfig-011-20240206   clang
i386                  randconfig-011-20240207   gcc  
i386                  randconfig-012-20240206   gcc  
i386                  randconfig-012-20240207   gcc  
i386                  randconfig-013-20240206   clang
i386                  randconfig-013-20240207   gcc  
i386                  randconfig-014-20240206   gcc  
i386                  randconfig-014-20240207   gcc  
i386                  randconfig-015-20240206   gcc  
i386                  randconfig-015-20240207   gcc  
i386                  randconfig-016-20240206   gcc  
i386                  randconfig-016-20240207   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240207   gcc  
loongarch             randconfig-002-20240207   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                  cavium_octeon_defconfig   gcc  
mips                         db1xxx_defconfig   clang
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240207   gcc  
nios2                 randconfig-002-20240207   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240207   gcc  
parisc                randconfig-002-20240207   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-003-20240207   gcc  
powerpc64             randconfig-002-20240207   gcc  
powerpc64             randconfig-003-20240207   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-002-20240207   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240207   gcc  
s390                  randconfig-002-20240207   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240207   gcc  
sh                    randconfig-002-20240207   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240207   gcc  
sparc64               randconfig-002-20240207   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-002-20240207   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240207   clang
x86_64       buildonly-randconfig-002-20240207   clang
x86_64       buildonly-randconfig-003-20240207   gcc  
x86_64       buildonly-randconfig-004-20240207   clang
x86_64       buildonly-randconfig-005-20240207   clang
x86_64       buildonly-randconfig-006-20240207   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240207   clang
x86_64                randconfig-002-20240207   gcc  
x86_64                randconfig-003-20240207   gcc  
x86_64                randconfig-004-20240207   gcc  
x86_64                randconfig-005-20240207   clang
x86_64                randconfig-006-20240207   clang
x86_64                randconfig-011-20240207   clang
x86_64                randconfig-012-20240207   gcc  
x86_64                randconfig-013-20240207   clang
x86_64                randconfig-014-20240207   clang
x86_64                randconfig-015-20240207   gcc  
x86_64                randconfig-016-20240207   gcc  
x86_64                randconfig-071-20240207   gcc  
x86_64                randconfig-072-20240207   clang
x86_64                randconfig-073-20240207   clang
x86_64                randconfig-074-20240207   gcc  
x86_64                randconfig-075-20240207   gcc  
x86_64                randconfig-076-20240207   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240207   gcc  
xtensa                randconfig-002-20240207   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

