Return-Path: <linux-kernel+bounces-93182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72925872BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60374B23F66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E816FAD;
	Wed,  6 Mar 2024 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7Dd1RVs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8A1FA4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687169; cv=none; b=qrchfzVYRTM9IB+UljX9Deq94xCFYGwiVHBWIr/NvWh+fkgZoZY2qgY9mt+JNQK3ezKCxMKFF6ybdi6HvQvsJNR3TtHG+OpR1zW3Tg5FYzPTjDCyT/+wuOkvow3/OHP38ZQ7YLq3+ZtzADnDRrM8xGzzIPxYVTdIJpsV3k20VkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687169; c=relaxed/simple;
	bh=0ol+tSrFbzRclVXBHNpChXnLhYFbRazhRPyYtW9mLho=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TWLhe76AoGL6yd2ioYEmxneRHmGSxfL69cjZ23owoV6G1AXkP7GeJMY1JJbVbfQaXCtANKT8hb0C+y9Z7LyZ4vVNMeKMLLoJnjsqy6Cm4YPr3XjeFhHPJK/SjKffug31uydz2Rr+C6jRnh6IERC6SyWqsobmB6QI5GVMnOBT4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7Dd1RVs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709687167; x=1741223167;
  h=date:from:to:cc:subject:message-id;
  bh=0ol+tSrFbzRclVXBHNpChXnLhYFbRazhRPyYtW9mLho=;
  b=K7Dd1RVsOXIlQZtQboDlXuz9fuUXlsRmI3YEMlOkwEwXw3O1ppzpddDC
   v/t5k7FRNjxeFt6qBkV/revcehbtHoMbYnXRL2e0m0r8xWwFwe3o+d3dF
   10JTnMv9DrMqM/mJPPTkbvPh9ealBREh6OjnbBi5cBJyE8GgYUlN1iDhm
   dcjm6z4T2TZkyLMWJaUxiy/Vf2HZD/oZ23CLIP9yRKWT14ekfM4aCnw7q
   anirpqZwBXmumxiL0tt8Ml6vNDmlodaXTW/x1yO/EuZUeVmS4q/eILmig
   vQ/Ej5hX5aVs0cAqfhh0SKj/xj98TKM2Af8URUeHXtXzNCDPGYZtHmWY8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="26735565"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="26735565"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:06:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14228173"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Mar 2024 17:06:05 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhfjO-0003nZ-2h;
	Wed, 06 Mar 2024 01:06:02 +0000
Date: Wed, 06 Mar 2024 09:05:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.27a] BUILD SUCCESS
 bbd4a676f3b2da65a795b9d58fa263a9c40c842e
Message-ID: <202403060900.SuXxJXlR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.27a
branch HEAD: bbd4a676f3b2da65a795b9d58fa263a9c40c842e  fixup! x86/nmi: Upgrade NMI backtrace stall checks

elapsed time: 1471m

configs tested: 207
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
arc                   randconfig-001-20240305   gcc  
arc                   randconfig-002-20240305   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-001-20240305   clang
arm                   randconfig-002-20240305   gcc  
arm                   randconfig-003-20240305   clang
arm                   randconfig-004-20240305   gcc  
arm                           sunxi_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240305   gcc  
arm64                 randconfig-002-20240305   clang
arm64                 randconfig-003-20240305   gcc  
arm64                 randconfig-004-20240305   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240305   gcc  
csky                  randconfig-002-20240305   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240305   clang
hexagon               randconfig-002-20240305   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240305   clang
i386         buildonly-randconfig-001-20240306   clang
i386         buildonly-randconfig-002-20240305   gcc  
i386         buildonly-randconfig-002-20240306   clang
i386         buildonly-randconfig-003-20240305   gcc  
i386         buildonly-randconfig-004-20240305   clang
i386         buildonly-randconfig-004-20240306   clang
i386         buildonly-randconfig-005-20240305   clang
i386         buildonly-randconfig-005-20240306   clang
i386         buildonly-randconfig-006-20240305   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240305   clang
i386                  randconfig-002-20240305   gcc  
i386                  randconfig-002-20240306   clang
i386                  randconfig-003-20240305   clang
i386                  randconfig-003-20240306   clang
i386                  randconfig-004-20240305   gcc  
i386                  randconfig-004-20240306   clang
i386                  randconfig-005-20240305   gcc  
i386                  randconfig-006-20240305   gcc  
i386                  randconfig-006-20240306   clang
i386                  randconfig-011-20240305   gcc  
i386                  randconfig-011-20240306   clang
i386                  randconfig-012-20240305   gcc  
i386                  randconfig-012-20240306   clang
i386                  randconfig-013-20240305   gcc  
i386                  randconfig-014-20240305   gcc  
i386                  randconfig-015-20240305   clang
i386                  randconfig-015-20240306   clang
i386                  randconfig-016-20240305   clang
i386                  randconfig-016-20240306   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240305   gcc  
loongarch             randconfig-002-20240305   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240305   gcc  
nios2                 randconfig-002-20240305   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240305   gcc  
parisc                randconfig-002-20240305   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240305   gcc  
powerpc               randconfig-002-20240305   gcc  
powerpc               randconfig-003-20240305   gcc  
powerpc64             randconfig-001-20240305   clang
powerpc64             randconfig-002-20240305   clang
powerpc64             randconfig-003-20240305   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240305   clang
riscv                 randconfig-002-20240305   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240305   gcc  
s390                  randconfig-002-20240305   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240305   gcc  
sh                    randconfig-002-20240305   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240305   gcc  
sparc64               randconfig-002-20240305   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240305   gcc  
um                    randconfig-002-20240305   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240305   clang
x86_64       buildonly-randconfig-001-20240306   clang
x86_64       buildonly-randconfig-002-20240305   clang
x86_64       buildonly-randconfig-002-20240306   clang
x86_64       buildonly-randconfig-003-20240305   clang
x86_64       buildonly-randconfig-003-20240306   clang
x86_64       buildonly-randconfig-004-20240305   clang
x86_64       buildonly-randconfig-004-20240306   clang
x86_64       buildonly-randconfig-005-20240305   clang
x86_64       buildonly-randconfig-006-20240306   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240305   clang
x86_64                randconfig-001-20240306   clang
x86_64                randconfig-002-20240305   clang
x86_64                randconfig-002-20240306   clang
x86_64                randconfig-004-20240305   clang
x86_64                randconfig-005-20240305   clang
x86_64                randconfig-005-20240306   clang
x86_64                randconfig-006-20240306   clang
x86_64                randconfig-011-20240306   clang
x86_64                randconfig-012-20240306   clang
x86_64                randconfig-013-20240305   clang
x86_64                randconfig-013-20240306   clang
x86_64                randconfig-015-20240305   clang
x86_64                randconfig-015-20240306   clang
x86_64                randconfig-016-20240305   clang
x86_64                randconfig-071-20240306   clang
x86_64                randconfig-072-20240306   clang
x86_64                randconfig-073-20240305   clang
x86_64                randconfig-073-20240306   clang
x86_64                randconfig-074-20240305   clang
x86_64                randconfig-074-20240306   clang
x86_64                randconfig-075-20240306   clang
x86_64                randconfig-076-20240305   clang
x86_64                randconfig-076-20240306   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240305   gcc  
xtensa                randconfig-002-20240305   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

