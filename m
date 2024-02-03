Return-Path: <linux-kernel+bounces-51284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AF8488B4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76935B226E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9741119F;
	Sat,  3 Feb 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSIRQZUD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07310A11
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706992531; cv=none; b=GaqufMjojmFk9DxqV/DWg+63nlZEOaO/0WHAOw+oLs3Z56abIUaycmDcHlERmR9jVMBjulliXUt9NiP1YsNG32vKkL72euvP6g6FvuPvJ4Bq8VossU+Q2P7LQY1DGpT46O+YIzCIfWx6HBEtui2LRqlR/gm0BObGxuWU1zi9GlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706992531; c=relaxed/simple;
	bh=vDR2Mfi4ywCrU8un7wo5u7cY2Cb3ks6fT21pDZTjYkU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dZ4aPkhzZhDNV4ok8h1adG7owqmMxAVaze2citGzuDbcdDAQ9JXMNcYPf+0SnjPxpSib+7dKugP9ku9vFwOa7rKOesDNOPYxJLgglHEwnx9E+4o/6YaAMZxNszJ+W9B0Ecdnmmd+0CcDFx0tDdI6aoexHdfgCXdjZuzY7K1W2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSIRQZUD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706992529; x=1738528529;
  h=date:from:to:cc:subject:message-id;
  bh=vDR2Mfi4ywCrU8un7wo5u7cY2Cb3ks6fT21pDZTjYkU=;
  b=FSIRQZUDNtr8nEwPeQaTP7RU1mPhcP6T/cbbse5aldpWqleoBtLqsWI+
   aDFsrTlTdvRI2rDbRA/QjzX/GAnlCCypIviC/aWZOr5X7bL6i2POUXZIO
   PAxdiuB82nB004k6YkgM7y6465eRf8POnWXOR2kdOgxzlNDVLyjPBArZJ
   YWog65tUyxfbm0bDOCmSFc9dRBQ0mB4GzQW5GNQY1zYqqagOHK6cbtsbb
   H7zsa6yfZcufrChmE1cR9P/rGr6EyeaEA70n0My8ckJahtW9UE4nDfR/5
   yPhGpHNxRIOcJhcqdDmTsUWgWtQd7GujxEULmVomdyq8FeWr+7CeZvaYb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="3306549"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="3306549"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 12:35:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="908913431"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="908913431"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2024 12:35:27 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWMjV-0005ZQ-0V;
	Sat, 03 Feb 2024 20:35:25 +0000
Date: Sun, 04 Feb 2024 04:34:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.02b] BUILD SUCCESS
 b2c3e9f1a8d53ca55c31e0b30a1e4a7e0b33de61
Message-ID: <202402040435.YkiQBKzY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.02b
branch HEAD: b2c3e9f1a8d53ca55c31e0b30a1e4a7e0b33de61  rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

elapsed time: 1453m

configs tested: 185
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
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-001-20240204   gcc  
arc                   randconfig-002-20240203   gcc  
arc                   randconfig-002-20240204   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240204   gcc  
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240204   gcc  
arm                         s5pv210_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240204   gcc  
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-003-20240204   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-001-20240204   gcc  
csky                  randconfig-002-20240203   gcc  
csky                  randconfig-002-20240204   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-006-20240203   gcc  
i386                                defconfig   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-016-20240203   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-001-20240204   gcc  
loongarch             randconfig-002-20240203   gcc  
loongarch             randconfig-002-20240204   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-001-20240204   gcc  
nios2                 randconfig-002-20240203   gcc  
nios2                 randconfig-002-20240204   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-001-20240204   gcc  
parisc                randconfig-002-20240203   gcc  
parisc                randconfig-002-20240204   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240204   gcc  
powerpc               randconfig-002-20240204   gcc  
powerpc               randconfig-003-20240204   gcc  
powerpc64             randconfig-001-20240204   gcc  
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240204   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240204   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240204   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-001-20240204   gcc  
sh                    randconfig-002-20240203   gcc  
sh                    randconfig-002-20240204   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-001-20240204   gcc  
sparc64               randconfig-002-20240203   gcc  
sparc64               randconfig-002-20240204   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240204   gcc  
um                    randconfig-002-20240204   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-001-20240204   gcc  
xtensa                randconfig-002-20240203   gcc  
xtensa                randconfig-002-20240204   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

