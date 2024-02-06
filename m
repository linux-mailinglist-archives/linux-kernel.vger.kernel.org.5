Return-Path: <linux-kernel+bounces-55698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C8A84C02A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471DA1C22781
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9B1C2A6;
	Tue,  6 Feb 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGKZzofM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2801C291
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707259108; cv=none; b=oUe11bg4Vh51M6LiVMKOED5YhYg4YWnHpiP5Xv8kaC18p++fqSBmgQDCe4KZHL13VM6QGtJ8fame7TKcQ/lqT2rtvShBvVdOlWj95w0MrlS9mRcxixnM6QQWe0aT0oD3S6nfg7mY1QYBOHCJAo4H2FYagtTZ/vGGPgK9g7Fnb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707259108; c=relaxed/simple;
	bh=Yy4kp68OfEDvNN1mgvXPLZ0jJJe4A8B7QxKF7qvZR9k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZJJUK//RagOfB+tdKvS2eWkkJtEnDApjXR6QHCJbeRZCqVljK6SZBZlwOUbBueFhhhK0D8s/aaER/+/yH1McRw/rxBmLo4htfp6RCSfiK3inClJuzaSiLzA/yUNZs6duMhL8nz00Jj3MVc/5qoe1uo6hWfFE1oYK4mlGfoqJ/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGKZzofM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707259104; x=1738795104;
  h=date:from:to:cc:subject:message-id;
  bh=Yy4kp68OfEDvNN1mgvXPLZ0jJJe4A8B7QxKF7qvZR9k=;
  b=QGKZzofMdBsqnAEPcn65hdZC/KSCR49ZYK5LcqLsB2I5DChXNCnGM+HH
   ryXPiqhgXEkN74PF8EDAJ9CNMPDhEJILIyxlAFTFM7D3URhoVakECv7uI
   YTvnB8EknD9r4OFhjZHQ3tjMsCLlN85SOOG6TH5+dNtrLtAMEFOhkzRG8
   vQNEzAVhrFp0a0MQatG/amIUYgvmWwisvUqlk8HsBHt57wG984duLDChG
   sdxwz7vy2MYe328N9mfc0L7brmol9vYb6TtGwhfpxUA2NUyBoa+8FEU1B
   RMvA/5nyBzLntPkY+OfSl8/4DvyIFtgerPV5IZdKGRMhbeMnpLpZ0cSVS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="753512"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="753512"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1179756"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 06 Feb 2024 14:38:22 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXU55-0001qm-1d;
	Tue, 06 Feb 2024 22:38:19 +0000
Date: Wed, 07 Feb 2024 06:38:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.05a] BUILD SUCCESS
 fa6e95361336711adb04c01e56813201e7cc0d9e
Message-ID: <202402070616.qRnpLyQV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.05a
branch HEAD: fa6e95361336711adb04c01e56813201e7cc0d9e  EXP sched: Export dump_cpu_task() to GPL modules for locktorture

elapsed time: 1480m

configs tested: 265
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
arc                     haps_hs_smp_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240206   gcc  
arc                   randconfig-001-20240207   gcc  
arc                   randconfig-002-20240206   gcc  
arc                   randconfig-002-20240207   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                        neponset_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240206   clang
arm                   randconfig-002-20240206   gcc  
arm                   randconfig-003-20240206   gcc  
arm                   randconfig-004-20240206   clang
arm                   randconfig-004-20240207   gcc  
arm                          sp7021_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240206   gcc  
arm64                 randconfig-002-20240206   clang
arm64                 randconfig-003-20240206   gcc  
arm64                 randconfig-004-20240206   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240206   gcc  
csky                  randconfig-001-20240207   gcc  
csky                  randconfig-002-20240206   gcc  
csky                  randconfig-002-20240207   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240206   clang
hexagon               randconfig-002-20240206   clang
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
loongarch             randconfig-001-20240206   gcc  
loongarch             randconfig-001-20240207   gcc  
loongarch             randconfig-002-20240206   gcc  
loongarch             randconfig-002-20240207   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                           rs90_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240206   gcc  
nios2                 randconfig-001-20240207   gcc  
nios2                 randconfig-002-20240206   gcc  
nios2                 randconfig-002-20240207   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240206   gcc  
parisc                randconfig-001-20240207   gcc  
parisc                randconfig-002-20240206   gcc  
parisc                randconfig-002-20240207   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240206   clang
powerpc               randconfig-002-20240206   gcc  
powerpc               randconfig-003-20240206   clang
powerpc               randconfig-003-20240207   gcc  
powerpc                  storcenter_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240206   gcc  
powerpc64             randconfig-002-20240206   clang
powerpc64             randconfig-002-20240207   gcc  
powerpc64             randconfig-003-20240206   gcc  
powerpc64             randconfig-003-20240207   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240206   gcc  
riscv                 randconfig-002-20240206   clang
riscv                 randconfig-002-20240207   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240206   clang
s390                  randconfig-001-20240207   gcc  
s390                  randconfig-002-20240206   clang
s390                  randconfig-002-20240207   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240206   gcc  
sh                    randconfig-001-20240207   gcc  
sh                    randconfig-002-20240206   gcc  
sh                    randconfig-002-20240207   gcc  
sh                          sdk7780_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240206   gcc  
sparc64               randconfig-001-20240207   gcc  
sparc64               randconfig-002-20240206   gcc  
sparc64               randconfig-002-20240207   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240206   clang
um                    randconfig-002-20240206   gcc  
um                    randconfig-002-20240207   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240206   gcc  
x86_64       buildonly-randconfig-001-20240207   clang
x86_64       buildonly-randconfig-002-20240206   clang
x86_64       buildonly-randconfig-002-20240207   clang
x86_64       buildonly-randconfig-003-20240206   gcc  
x86_64       buildonly-randconfig-004-20240206   gcc  
x86_64       buildonly-randconfig-004-20240207   clang
x86_64       buildonly-randconfig-005-20240206   gcc  
x86_64       buildonly-randconfig-005-20240207   clang
x86_64       buildonly-randconfig-006-20240206   gcc  
x86_64       buildonly-randconfig-006-20240207   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240206   clang
x86_64                randconfig-001-20240207   clang
x86_64                randconfig-002-20240206   clang
x86_64                randconfig-003-20240206   gcc  
x86_64                randconfig-004-20240206   gcc  
x86_64                randconfig-005-20240206   gcc  
x86_64                randconfig-005-20240207   clang
x86_64                randconfig-006-20240206   clang
x86_64                randconfig-006-20240207   clang
x86_64                randconfig-011-20240206   gcc  
x86_64                randconfig-011-20240207   clang
x86_64                randconfig-012-20240206   clang
x86_64                randconfig-013-20240206   gcc  
x86_64                randconfig-013-20240207   clang
x86_64                randconfig-014-20240206   clang
x86_64                randconfig-014-20240207   clang
x86_64                randconfig-015-20240206   gcc  
x86_64                randconfig-016-20240206   clang
x86_64                randconfig-071-20240206   gcc  
x86_64                randconfig-072-20240206   gcc  
x86_64                randconfig-072-20240207   clang
x86_64                randconfig-073-20240206   gcc  
x86_64                randconfig-073-20240207   clang
x86_64                randconfig-074-20240206   gcc  
x86_64                randconfig-075-20240206   clang
x86_64                randconfig-076-20240206   gcc  
x86_64                randconfig-076-20240207   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240206   gcc  
xtensa                randconfig-001-20240207   gcc  
xtensa                randconfig-002-20240206   gcc  
xtensa                randconfig-002-20240207   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

