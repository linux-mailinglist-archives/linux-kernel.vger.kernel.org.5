Return-Path: <linux-kernel+bounces-69286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937AF8586A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D1280F67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB91386B3;
	Fri, 16 Feb 2024 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLcHg2O3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19717138496
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114847; cv=none; b=ejGBLs83aoTM5mgR7w1j/502mh2ukOLfeBeGxgWgcoVgF1BMoetraOlnROEL+41btx3pvn1zkHhbx/ISh1Jk1mQUdokH8kActSltQzeaxwuX/lje6ZDQbxUuKFTDks3WKIlHzZb+WSzZ4/ywwRf5FfXGw872/kbPrrvfcFumy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114847; c=relaxed/simple;
	bh=LjXrhM5S5R5YyJMzFZKDmPkYrKpRkwV4zq5L+4sY/P8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pf56FyeEl19ia+jZHK2ESDN14sctYPplwLSDdGLjtoHReDd5u9LXyKbIoOAuKmbQQk3owklR7ez4YimpbXzyY513Ko6/oesgown76LVXheALJXD2lJ0U7GkO23qQK8lVomX3oyfbO4PRIAJEPI/QDbyfhamdC+U59BRc4TYTpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLcHg2O3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708114845; x=1739650845;
  h=date:from:to:cc:subject:message-id;
  bh=LjXrhM5S5R5YyJMzFZKDmPkYrKpRkwV4zq5L+4sY/P8=;
  b=eLcHg2O3r4Vcnx8GiW6T3Vsjq763aXFdWzhWMWL3jCTzpYvRlYJ9DWUd
   2qzekVdJQFvnvnr2poSvqsOhFNEXbbs31wV3Yi69yrYuq/RfF6zYDfpXj
   cKUAW8odDqHHYcT4hk8pYUzCBc1WcNIcCtPZ5T1Xq5pBevrFMWS7ox1GI
   Jyw3OmZZICOujpuizPTu8kObGg5sxJOKtIrZ2SITXGSMrRjD0oD9u8nnn
   EEOjq8q9dp0xw2zLuLKli2/sNodmKFc1Rd4qotv5LcewzETJ2e+gxOEAW
   AhQi2qeJ+g7MxjMfF/A7gFAydqEXVQ5KgA0zAeWVvf/Wypra+sqoj9Lnh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2372575"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2372575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 12:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8520641"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 16 Feb 2024 12:20:43 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb4hM-0001b0-2e;
	Fri, 16 Feb 2024 20:20:40 +0000
Date: Sat, 17 Feb 2024 04:20:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 9bbe13a5d414a7f8208dba64b54d2b6e4f7086bd
Message-ID: <202402170424.2tedNrJl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 9bbe13a5d414a7f8208dba64b54d2b6e4f7086bd  genirq/msi: Provide MSI_FLAG_PARENT_PM_DEV

elapsed time: 1445m

configs tested: 157
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
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240216   gcc  
arc                   randconfig-002-20240216   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-003-20240216   gcc  
arm                   randconfig-004-20240216   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240216   gcc  
arm64                 randconfig-004-20240216   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240216   gcc  
csky                  randconfig-002-20240216   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386                                defconfig   clang
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-016-20240216   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240216   gcc  
loongarch             randconfig-002-20240216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240216   gcc  
nios2                 randconfig-002-20240216   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240216   gcc  
parisc                randconfig-002-20240216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-003-20240216   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240216   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240216   gcc  
s390                  randconfig-002-20240216   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240216   gcc  
sh                    randconfig-002-20240216   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240216   gcc  
sparc64               randconfig-002-20240216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240216   gcc  
um                    randconfig-002-20240216   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-005-20240216   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240216   gcc  
x86_64                randconfig-003-20240216   gcc  
x86_64                randconfig-004-20240216   gcc  
x86_64                randconfig-005-20240216   gcc  
x86_64                randconfig-011-20240216   gcc  
x86_64                randconfig-012-20240216   gcc  
x86_64                randconfig-014-20240216   gcc  
x86_64                randconfig-073-20240216   gcc  
x86_64                randconfig-074-20240216   gcc  
x86_64                randconfig-076-20240216   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240216   gcc  
xtensa                randconfig-002-20240216   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

