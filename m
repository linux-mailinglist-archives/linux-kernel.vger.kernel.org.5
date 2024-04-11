Return-Path: <linux-kernel+bounces-139709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97718A06BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B651F21FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6313BAC7;
	Thu, 11 Apr 2024 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBxtK/iB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DA23BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806266; cv=none; b=rOJHwrgj8TUtFNV+309hadjCLV2hsyoOsoR37JkTlB90C/BwzjFCk9s14ovkJSNEAvnFLB4mO9PBJuUp+xerjixgRK4uNzo376mbOMc0hEnsTvf9afIvU4oj/9hAA7ShkRlHZmjNBxFg52TPkdjE5deyKzpId46pXn4G0WB/HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806266; c=relaxed/simple;
	bh=6incy4jXr1Te9/dsK9z6pR3xtx9ae1X2f+EpaGOthXo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OV5fCMjLEa5PCzsfsqv+U4c/ruq84+RJDulmepZ8OFdWTlDssMScneyb7riPA2pvLthSvAXPGYcCy246wu8Z+gWzkiid4z2xFl+jtlLyTIicCPs3Rvg5wDdynQUX6rrb6Hwr7h5+SbMEVXYjzM8l+ANd+HNNHO9+TVCsaIxRJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBxtK/iB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712806265; x=1744342265;
  h=date:from:to:cc:subject:message-id;
  bh=6incy4jXr1Te9/dsK9z6pR3xtx9ae1X2f+EpaGOthXo=;
  b=HBxtK/iBz+PMSEO8bzvhRPaSsTLe6euAadG/GcZD9TpH9ayOWerqmJ06
   ZRNmLqGdeawYRbb1Buf4lumY5YVvmervFQwJQID7IKTGiRf32lcmR9acI
   PCof2w0tBTpiGKMQH88ZEq+8Da4uIk2V5N3RK+059yN4OeEy/OOjOj9mo
   z8vy6/B2hm+b/J1gaI6FAYug5fkTIqoEsHuQtahUr2e41QALeMUjNs3Oc
   sM+iifAK3Ar5u3yHmwqojpXTqlxUacjuezaCiK9y9rX1j449FtFlFoVBs
   KCuyR4rb0Uxe9bzN2tMBFIZQ3wiPb1jbIb2kPeZ2ca/C8Rb9a5pnEMgUT
   w==;
X-CSE-ConnectionGUID: zsD2Sx/IRi2SkMxrQmyS+w==
X-CSE-MsgGUID: ouben5zUT4igigyqJNIyfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19352314"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="19352314"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:31:04 -0700
X-CSE-ConnectionGUID: xz3VDV6aTsuKKzsj/VWujg==
X-CSE-MsgGUID: PqwpWsHJTziJBcZo0biMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="21265888"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Apr 2024 20:31:03 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rul9Q-0008AQ-2G;
	Thu, 11 Apr 2024 03:31:00 +0000
Date: Thu, 11 Apr 2024 11:30:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 dbbe13a6f66b228a2867844ad4dd108576134775
Message-ID: <202404111139.LwbIgBGQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: dbbe13a6f66b228a2867844ad4dd108576134775  x86/cpu: Improve readability of per-CPU cpumask initialization code

elapsed time: 1333m

configs tested: 171
configs skipped: 11

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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240411   gcc  
arc                   randconfig-002-20240411   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240411   gcc  
arm                   randconfig-002-20240411   gcc  
arm                   randconfig-003-20240411   clang
arm                   randconfig-004-20240411   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240411   clang
arm64                 randconfig-002-20240411   gcc  
arm64                 randconfig-003-20240411   gcc  
arm64                 randconfig-004-20240411   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240411   gcc  
csky                  randconfig-002-20240411   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240411   clang
hexagon               randconfig-002-20240411   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240410   gcc  
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240410   gcc  
i386                  randconfig-016-20240411   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240411   gcc  
loongarch             randconfig-002-20240411   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240411   gcc  
nios2                 randconfig-002-20240411   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240411   gcc  
parisc                randconfig-002-20240411   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240411   gcc  
powerpc               randconfig-002-20240411   clang
powerpc               randconfig-003-20240411   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240411   clang
powerpc64             randconfig-002-20240411   gcc  
powerpc64             randconfig-003-20240411   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240411   clang
riscv                 randconfig-002-20240411   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240411   clang
s390                  randconfig-002-20240411   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240411   gcc  
sh                    randconfig-002-20240411   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240411   gcc  
sparc64               randconfig-002-20240411   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240411   gcc  
um                    randconfig-002-20240411   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240411   clang
x86_64       buildonly-randconfig-003-20240411   clang
x86_64       buildonly-randconfig-005-20240411   clang
x86_64       buildonly-randconfig-006-20240411   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240411   clang
x86_64                randconfig-002-20240411   clang
x86_64                randconfig-004-20240411   clang
x86_64                randconfig-006-20240411   clang
x86_64                randconfig-011-20240411   clang
x86_64                randconfig-013-20240411   clang
x86_64                randconfig-071-20240411   clang
x86_64                randconfig-072-20240411   clang
x86_64                randconfig-073-20240411   clang
x86_64                randconfig-076-20240411   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240411   gcc  
xtensa                randconfig-002-20240411   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

