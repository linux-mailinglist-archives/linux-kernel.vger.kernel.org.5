Return-Path: <linux-kernel+bounces-104176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B4187CA3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DBDB22874
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7817579;
	Fri, 15 Mar 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl1Exu0Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E11427E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492450; cv=none; b=XmZUR821LCkZmDg+mXIjrXNVL0AtvoNljYSGX33LRUOrsppagONMfDRBQpVtq7IEz8OwaYEPaRP5QAZMkgVTyuQFjAs23EosBWv4nGzd8JZRKtkc5mMtJhjXDxsQobc1La6KUq+aVulNCyglEaF/M4zJMxDpm4yfcOvRfEMpfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492450; c=relaxed/simple;
	bh=N4aORpf6YzpY+CoUuVCJbkq6/N5F4XvV84VSD9HT3w8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CN2vD0x/LqCBnEc+OpxEo0fU0+Y6y/dB2+oddQ2OHZ6yR6qwPPMGEPvJfQk3aJIRVd+qt81lhOZ9KhLemx4quLSEXwrylbWhJTvj0okJYUBTavqP3PhOYspXXy854UPBZ6JqlRlNjP9P1u0PIK/Lu7Tuyo/2hYffwxhqWTpuIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl1Exu0Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710492449; x=1742028449;
  h=date:from:to:cc:subject:message-id;
  bh=N4aORpf6YzpY+CoUuVCJbkq6/N5F4XvV84VSD9HT3w8=;
  b=Nl1Exu0YUCNxJpBvwdyLv1sljWGZ0I7rE6t+yuoU6sKl20+fkJ0XlEZ5
   lZHaFXyWMQIniFGy3jCo2PAfGrQ9ZX1E/xaa3mC2O5S49PQCGhXFMw1bb
   7eq+h28PA9KMsB1SBCicTf8Cg+mLVrLF9AseTA6sOgR9ax+5yREjeZzZy
   MP926IKl1uFL9w2msTRYoUhq0M5OleYMZwWDXG2vdhL2OpG57XVmMFW3R
   S4KrGm0HzARo0aEvpyaHAXUs0uLRr6DEbnNvG4DVn+4aPE2NJAUPUKAN7
   dPkOlPLN37SB7uSflaqTXV9sXXyA70Ggo+0BdSrpl9cG2iHwHZjhTn2RC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16499877"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="16499877"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12519850"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 15 Mar 2024 01:47:03 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl3DQ-000EH5-14;
	Fri, 15 Mar 2024 08:47:00 +0000
Date: Fri, 15 Mar 2024 16:46:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9ed4a756ed3a321823026bc8d9f59278ac8a3cf6
Message-ID: <202403151637.gDNfoMQG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9ed4a756ed3a321823026bc8d9f59278ac8a3cf6  Merge branch into tip/master: 'x86/build'

elapsed time: 1289m

configs tested: 153
configs skipped: 5

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
arc                   randconfig-001-20240315   gcc  
arc                   randconfig-002-20240315   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                   randconfig-001-20240315   clang
arm                   randconfig-002-20240315   gcc  
arm                   randconfig-003-20240315   gcc  
arm                   randconfig-004-20240315   gcc  
arm                         socfpga_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240315   gcc  
arm64                 randconfig-002-20240315   gcc  
arm64                 randconfig-003-20240315   gcc  
arm64                 randconfig-004-20240315   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240315   gcc  
csky                  randconfig-002-20240315   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240315   clang
hexagon               randconfig-002-20240315   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-003-20240314   gcc  
i386         buildonly-randconfig-004-20240314   gcc  
i386         buildonly-randconfig-005-20240314   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240314   gcc  
i386                  randconfig-002-20240314   clang
i386                  randconfig-003-20240314   gcc  
i386                  randconfig-004-20240314   clang
i386                  randconfig-005-20240314   gcc  
i386                  randconfig-006-20240314   gcc  
i386                  randconfig-011-20240314   clang
i386                  randconfig-012-20240314   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240314   gcc  
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240314   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240315   gcc  
loongarch             randconfig-002-20240315   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip32_defconfig   clang
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240315   gcc  
nios2                 randconfig-002-20240315   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240315   gcc  
parisc                randconfig-002-20240315   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240315   clang
powerpc               randconfig-002-20240315   gcc  
powerpc               randconfig-003-20240315   clang
powerpc                     stx_gp3_defconfig   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240315   clang
powerpc64             randconfig-002-20240315   gcc  
powerpc64             randconfig-003-20240315   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240315   clang
riscv                 randconfig-002-20240315   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240315   gcc  
s390                  randconfig-002-20240315   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240315   gcc  
sh                    randconfig-002-20240315   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240315   gcc  
sparc64               randconfig-002-20240315   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240315   gcc  
um                    randconfig-002-20240315   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240315   gcc  
xtensa                randconfig-002-20240315   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

