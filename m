Return-Path: <linux-kernel+bounces-123388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED18907CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3249F1F24E66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38F130E5E;
	Thu, 28 Mar 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABODoSXt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BAF2E419
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648642; cv=none; b=X6HylOdRL6zlipe+bpekKJ6a5CgBwhoNxS/xTGtKTcnXG7EvPSkdAdgPEueed3Pi2FOHtwukF5jmuI6OYqxCnZDHaTpBmNU96m0ysN5DcMaN0kJJMSWn2oYiB0VXUOBRt9BeWUVP9MzUss1wZxjpUBl6tzcTd9O2e2OngYHilRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648642; c=relaxed/simple;
	bh=IVq6Jh0jCDmu0MAyE1Q52ZRjaYWXBcz9P2bd3TEbfWY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mu+R42t5wpHLKFBuKxkMqixXISEYedl/Tev4CbldC1C68Gd0DbJ2eM67AiY0yD2pJBoR4JtjHYmW82axdOmBz06heaf/tmyoVVe3fpJSzSzEuSjtejGhrKdrW2yiPTTbCD51gB6+UmbwwS9m4NLF35xt30LS6JalHHNadHD8lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABODoSXt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711648640; x=1743184640;
  h=date:from:to:cc:subject:message-id;
  bh=IVq6Jh0jCDmu0MAyE1Q52ZRjaYWXBcz9P2bd3TEbfWY=;
  b=ABODoSXtN02IBi8keYpxSeNqg5TQqTlOecRLw/jriDNmGVT6LN+QJ/CJ
   xs9K3JN5MeeL2gLqLhWl2sFFsyDUDKCxOm8ului3bLFuFauwxKn1MBqj4
   ktQq5iqtYQE7UZA2NvmoJ4GXmmZNEgs+d3CNS9tpNx51NVPDAQiHd8u4Q
   2sDt/xF/XOAznvQd1n87fj5DxfoZnlhrEbDtBQ7uyMD4dsAaqfpEnsyhU
   4QHQA0133dvnqy38mG9tvnmr+Pzxrb7cS4QECN2VjHjoRUuTB3mLODuiv
   TxACrcWELxFvr5kbWY1UI0gQEdlnJJxwZqXUAlhaEm9VPAs6Rl+oeghKu
   Q==;
X-CSE-ConnectionGUID: RYhla8sNS5e7jRL/iPVSnA==
X-CSE-MsgGUID: T33lX0fiQxiZcdwb1PRGIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24310235"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24310235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 10:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="47907359"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Mar 2024 10:57:18 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpu03-0002Ou-2L;
	Thu, 28 Mar 2024 17:57:15 +0000
Date: Fri, 29 Mar 2024 01:56:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27a] BUILD SUCCESS
 af78edbcea52139a43a8b88979c07511235bd35f
Message-ID: <202403290156.NhMeaZe1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27a
branch HEAD: af78edbcea52139a43a8b88979c07511235bd35f  EXP arch/x86: Test one-byte cmpxchg emulation

elapsed time: 1224m

configs tested: 180
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240328   gcc  
arc                   randconfig-002-20240328   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240328   gcc  
arm                   randconfig-002-20240328   gcc  
arm                   randconfig-003-20240328   gcc  
arm                   randconfig-004-20240328   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240328   gcc  
arm64                 randconfig-002-20240328   gcc  
arm64                 randconfig-003-20240328   gcc  
arm64                 randconfig-004-20240328   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240328   gcc  
csky                  randconfig-002-20240328   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240328   clang
hexagon               randconfig-002-20240328   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240328   gcc  
i386         buildonly-randconfig-002-20240328   gcc  
i386         buildonly-randconfig-003-20240328   clang
i386         buildonly-randconfig-004-20240328   gcc  
i386         buildonly-randconfig-005-20240328   gcc  
i386         buildonly-randconfig-006-20240328   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240328   clang
i386                  randconfig-002-20240328   clang
i386                  randconfig-003-20240328   clang
i386                  randconfig-004-20240328   clang
i386                  randconfig-005-20240328   gcc  
i386                  randconfig-006-20240328   gcc  
i386                  randconfig-011-20240328   clang
i386                  randconfig-012-20240328   clang
i386                  randconfig-013-20240328   clang
i386                  randconfig-014-20240328   clang
i386                  randconfig-015-20240328   clang
i386                  randconfig-016-20240328   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240328   gcc  
loongarch             randconfig-002-20240328   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240328   gcc  
nios2                 randconfig-002-20240328   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240328   gcc  
parisc                randconfig-002-20240328   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240328   clang
powerpc               randconfig-002-20240328   clang
powerpc               randconfig-003-20240328   clang
powerpc64             randconfig-001-20240328   clang
powerpc64             randconfig-002-20240328   gcc  
powerpc64             randconfig-003-20240328   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240328   gcc  
riscv                 randconfig-002-20240328   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240328   clang
s390                  randconfig-002-20240328   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240328   gcc  
sh                    randconfig-002-20240328   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240328   gcc  
sparc64               randconfig-002-20240328   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240328   gcc  
um                    randconfig-002-20240328   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240328   gcc  
x86_64       buildonly-randconfig-002-20240328   clang
x86_64       buildonly-randconfig-003-20240328   gcc  
x86_64       buildonly-randconfig-004-20240328   gcc  
x86_64       buildonly-randconfig-005-20240328   gcc  
x86_64       buildonly-randconfig-006-20240328   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240328   clang
x86_64                randconfig-002-20240328   gcc  
x86_64                randconfig-003-20240328   clang
x86_64                randconfig-004-20240328   gcc  
x86_64                randconfig-005-20240328   clang
x86_64                randconfig-006-20240328   clang
x86_64                randconfig-011-20240328   clang
x86_64                randconfig-012-20240328   clang
x86_64                randconfig-013-20240328   gcc  
x86_64                randconfig-014-20240328   gcc  
x86_64                randconfig-015-20240328   clang
x86_64                randconfig-016-20240328   clang
x86_64                randconfig-071-20240328   gcc  
x86_64                randconfig-072-20240328   clang
x86_64                randconfig-073-20240328   gcc  
x86_64                randconfig-074-20240328   gcc  
x86_64                randconfig-075-20240328   gcc  
x86_64                randconfig-076-20240328   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240328   gcc  
xtensa                randconfig-002-20240328   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

