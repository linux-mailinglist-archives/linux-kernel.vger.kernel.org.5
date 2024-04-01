Return-Path: <linux-kernel+bounces-127058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51289464B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E50B22223
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D145548E4;
	Mon,  1 Apr 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWnY6Aj+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C953380
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004664; cv=none; b=rNW7Kv4LFGqIZ3ms10tNFMZnzFQ+ioJBhlhnaModk7tjNVeMcRiCY5uYrTe1F7sLcRJUKiaA9q79GqYMvEeRypsrng6B0dlM7ZbuMIoCIIb1vrjB/IamhIUyWQERULQ1p8hwD3HgjCZ3oZr0d18fxC3iYcBZA3LdTj4xMDvqiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004664; c=relaxed/simple;
	bh=0C5NptG45DY8ce+KAPcgLttZhSAT5L+nebSlCFoQ05k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jKn07qwGbH+STydjrJD59CADlnvU7LUnIePLMoHkcYkU1KQiN+0dTuzh/hWRB72LYK52+2cRO1SAXUL127UNk/OjO2Ny5pmuHdv2WfGFaAN5DNGYIHxSOpkAI7Vlrk7H1zvCi+L37z9bWgKVO+ZMmP+xE0fgsA3kpkC2ZS3Ka9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWnY6Aj+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712004661; x=1743540661;
  h=date:from:to:cc:subject:message-id;
  bh=0C5NptG45DY8ce+KAPcgLttZhSAT5L+nebSlCFoQ05k=;
  b=SWnY6Aj+kmWitDO9R66EcS2iJHnBHq1sTdGk6xEASFteEEovsbdLaHFm
   gjGsW+Y6MCsWaEL7BQjnT/cdXi5NxS7hr+gpSJrdYQ+3spETyf89oqhi5
   twElnKtQoP34KlrkLzHuIUH/J3ksjdd3T97bba69bHP6LZf1oGK0nQ4VT
   rVkPjBImHMdyY7o5Xo+XlEyMY7Othl/WMCj0KC5kSHq/NVJNG/mhKA0Qg
   NqwXLkH/s66riuWBynTDYukcHYuZwsctgQleas3Y73Sp8EO1yX9H7jfm/
   BHbbEGIdAr0S/90dQZvaC0AtLDPorO7fKwsZwIldYLqpb4kJwiULqXv9o
   A==;
X-CSE-ConnectionGUID: uvFNGEeqS62BHF2GTMHidA==
X-CSE-MsgGUID: bImfs4R9QbmfGY/1wzC5LQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7337393"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7337393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="22309574"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 01 Apr 2024 13:50:46 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrOc8-0000c8-1a;
	Mon, 01 Apr 2024 20:50:44 +0000
Date: Tue, 02 Apr 2024 04:49:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 9e643ab59d7ee4332994671720a9528bac62e9b7
Message-ID: <202404020449.TcJwvhEs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 9e643ab59d7ee4332994671720a9528bac62e9b7  timers: Fix text inconsistencies and spelling

elapsed time: 723m

configs tested: 182
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
arc                   randconfig-001-20240401   gcc  
arc                   randconfig-002-20240401   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240401   clang
arm                   randconfig-002-20240401   clang
arm                   randconfig-003-20240401   gcc  
arm                   randconfig-004-20240401   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240401   gcc  
arm64                 randconfig-002-20240401   gcc  
arm64                 randconfig-003-20240401   gcc  
arm64                 randconfig-004-20240401   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240401   gcc  
csky                  randconfig-002-20240401   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240401   clang
hexagon               randconfig-002-20240401   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240401   gcc  
i386         buildonly-randconfig-002-20240401   clang
i386         buildonly-randconfig-003-20240401   clang
i386         buildonly-randconfig-004-20240401   gcc  
i386         buildonly-randconfig-005-20240401   gcc  
i386         buildonly-randconfig-006-20240401   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240401   gcc  
i386                  randconfig-002-20240401   gcc  
i386                  randconfig-003-20240401   clang
i386                  randconfig-004-20240401   clang
i386                  randconfig-005-20240401   gcc  
i386                  randconfig-006-20240401   gcc  
i386                  randconfig-011-20240401   clang
i386                  randconfig-012-20240401   clang
i386                  randconfig-013-20240401   gcc  
i386                  randconfig-014-20240401   gcc  
i386                  randconfig-015-20240401   gcc  
i386                  randconfig-016-20240401   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240401   gcc  
loongarch             randconfig-002-20240401   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                           gcw0_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240401   gcc  
nios2                 randconfig-002-20240401   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240401   gcc  
parisc                randconfig-002-20240401   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240401   gcc  
powerpc               randconfig-002-20240401   gcc  
powerpc               randconfig-003-20240401   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-001-20240401   gcc  
powerpc64             randconfig-002-20240401   clang
powerpc64             randconfig-003-20240401   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240401   clang
riscv                 randconfig-002-20240401   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240401   gcc  
s390                  randconfig-002-20240401   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240401   gcc  
sh                    randconfig-002-20240401   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240401   gcc  
sparc64               randconfig-002-20240401   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240401   gcc  
um                    randconfig-002-20240401   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240401   clang
x86_64       buildonly-randconfig-002-20240401   clang
x86_64       buildonly-randconfig-003-20240401   gcc  
x86_64       buildonly-randconfig-004-20240401   gcc  
x86_64       buildonly-randconfig-005-20240401   gcc  
x86_64       buildonly-randconfig-006-20240401   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240401   gcc  
x86_64                randconfig-002-20240401   clang
x86_64                randconfig-003-20240401   clang
x86_64                randconfig-004-20240401   gcc  
x86_64                randconfig-005-20240401   gcc  
x86_64                randconfig-006-20240401   clang
x86_64                randconfig-011-20240401   clang
x86_64                randconfig-012-20240401   gcc  
x86_64                randconfig-013-20240401   gcc  
x86_64                randconfig-014-20240401   gcc  
x86_64                randconfig-015-20240401   gcc  
x86_64                randconfig-016-20240401   gcc  
x86_64                randconfig-071-20240401   gcc  
x86_64                randconfig-072-20240401   gcc  
x86_64                randconfig-073-20240401   clang
x86_64                randconfig-074-20240401   gcc  
x86_64                randconfig-075-20240401   gcc  
x86_64                randconfig-076-20240401   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240401   gcc  
xtensa                randconfig-002-20240401   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

