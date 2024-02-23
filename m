Return-Path: <linux-kernel+bounces-79218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F8861F18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0591F26CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68BB1493AE;
	Fri, 23 Feb 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN9HRta6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D656148FE2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724223; cv=none; b=bBHNPE1DXDg8IG6jEryPQyFOU66BbKeN4LQ1U7FAhR4dFe30BdOmFvQi1zaRrPCaVwttpTdVe+AAjAzMwzGqCxeUwaHrdQnDMzoh8ZRbSw2HWjazx6HUIlSKIQCPGOZrLSpqQltPymrKVt6y/UjoW+vKznEGn6BMvRM5KQGGBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724223; c=relaxed/simple;
	bh=iCUi6Iury85zHUH4wfyMGLL10JEW8BC43mKqU1s74lc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EaKPUKFiCpeg8EqkMDfMZ3viklJqaI0AzmugLqKslnEvSpbGE+NpTRQPwnahs+Ih2vpGSPNec5zTS3U4HDKu7uo6amQJ0hXaJ2+wrxm1R+OaPyal0WhSIvF2pxG+ORuLEnsMmuxqCM5tJRbN0BssUS9X5OM+yAEIPSUbJufbQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN9HRta6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708724222; x=1740260222;
  h=date:from:to:cc:subject:message-id;
  bh=iCUi6Iury85zHUH4wfyMGLL10JEW8BC43mKqU1s74lc=;
  b=TN9HRta6BYGiEQS598Un+IPN6WyKDa8anKjU8FCQfalL0keXyZRJoeBr
   Rhx48YdiQVz9NmB6Ru1IrpAH6M1OUdqgElOhtMkXpbof+sV0a9WZawrqS
   EP6J1i9whKfjcNYRYQRUIfKLe9t6wqtQqgXgelUVJalVmB+3e2ihTAWUa
   8WDb/r5MgWadsoVWZd6ljhoVwes/WCleIWnBjKgqH/CE/5HLGN55p6Zly
   mynbMp16DgcFc1TDgLEyxTu/EGFRhY5zftorKF7QgpaBVbK1AGHtnuSo8
   //YaFo8UWh//t+k+N2A32PQTwjAP8z44N1E4nGQUfFXxc0ieXwpGw6Rkc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3576570"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3576570"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 13:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6440955"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2024 13:37:00 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rddE1-0007v4-2X;
	Fri, 23 Feb 2024 21:36:57 +0000
Date: Sat, 24 Feb 2024 05:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.02.17a] BUILD SUCCESS
 e72d464faeb0279da4dd8411b369587fab127db3
Message-ID: <202402240552.SIMmqveV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.02.17a
branch HEAD: e72d464faeb0279da4dd8411b369587fab127db3  squash! rcu-tasks: Maintain real-time response in rcu_tasks_postscan()

elapsed time: 1171m

configs tested: 158
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
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240223   gcc  
arc                   randconfig-002-20240223   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240223   gcc  
arm                   randconfig-004-20240223   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240223   gcc  
arm64                 randconfig-004-20240223   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240223   gcc  
csky                  randconfig-002-20240223   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-006-20240223   clang
i386                                defconfig   clang
i386                  randconfig-001-20240223   clang
i386                  randconfig-006-20240223   clang
i386                  randconfig-013-20240223   clang
i386                  randconfig-014-20240223   clang
i386                  randconfig-015-20240223   clang
i386                  randconfig-016-20240223   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240223   gcc  
loongarch             randconfig-002-20240223   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240223   gcc  
nios2                 randconfig-002-20240223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240223   gcc  
parisc                randconfig-002-20240223   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20240223   gcc  
powerpc64             randconfig-002-20240223   gcc  
powerpc64             randconfig-003-20240223   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240223   gcc  
riscv                 randconfig-002-20240223   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240223   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240223   gcc  
sh                    randconfig-002-20240223   gcc  
sh                           se7619_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240223   gcc  
sparc64               randconfig-002-20240223   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240223   gcc  
um                           x86_64_defconfig   clang
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-003-20240223   clang
x86_64       buildonly-randconfig-004-20240223   clang
x86_64       buildonly-randconfig-006-20240223   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240223   clang
x86_64                randconfig-005-20240223   clang
x86_64                randconfig-013-20240223   clang
x86_64                randconfig-015-20240223   clang
x86_64                randconfig-016-20240223   clang
x86_64                randconfig-074-20240223   clang
x86_64                randconfig-076-20240223   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240223   gcc  
xtensa                randconfig-002-20240223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

