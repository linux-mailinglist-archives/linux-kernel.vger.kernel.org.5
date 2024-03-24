Return-Path: <linux-kernel+bounces-112729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36588887D85
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35971F21304
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26818EB1;
	Sun, 24 Mar 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPSda7AS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3E18EB3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296583; cv=none; b=cI6CtkYP7VVUooSwp1GPbi+Ffq96Ba5pRhPhwYXNbDEJs2bpXvdxSeRFyyHkz1e22PGGGwTPWA2oBT0WlPoj4FBJeVbhDsjY8KivB9QLNpPLqoYPh2GP1oGv0E72nzLmJat++E+W5kfL6yzJ9XDWCKBCQoQoKDT3XDytydghYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296583; c=relaxed/simple;
	bh=jMjMW1XOVJQB5jJ2XId/jp+/nK7jXIcbnqM30i4ZA1A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tLa50P7wpfaT4lEH/GYaj/fXO0ztcBsDLFe2kuLxIv/g2rk307FZU2UyWaJ4/+L9z+cChJRMgbj+byFglWo1N/dAU+qNZSCUaKzVANWqEJqKC9BqdYVQw8xjwAdjUGhdkDoinPrxLU0g73kmw2luv9NXEomXycSfRZ6LLYsQY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPSda7AS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711296581; x=1742832581;
  h=date:from:to:cc:subject:message-id;
  bh=jMjMW1XOVJQB5jJ2XId/jp+/nK7jXIcbnqM30i4ZA1A=;
  b=FPSda7ASxiHeU6l1+u1NFO4owTt+EKg7OJVPWYW1AN0jw0dSE/j6JrUm
   hiDeYKHxqV+HiAX+W4i5LSyJGHTVkpEPukca2mDielosVmzSG6Duyik0W
   IU6E7ElQUF6CiXHHqKDA/hc/oLaLSnibAY6iJTuQpsYJthoikuyPmSj2I
   nGl3OfoqaaxUrVhSIo886GfIg40uyVae/AIXaryk909W4frZcC4h3b+Ce
   BtTCI3XaL1zMM+fBJWAX/I2+cGz+GSQyZQlqPl3Xd1pBi4EZaP0h1eO0g
   DATG/UvMYuPXQsh2ZLTGXIUzPjFHHBJsZNrtwAgbsRdJ4rv7TtTb7nxpG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6406290"
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="6406290"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 09:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="19864624"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Mar 2024 09:09:39 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1roQPg-000Lth-1S;
	Sun, 24 Mar 2024 16:09:36 +0000
Date: Mon, 25 Mar 2024 00:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 17608373cf907afe97654998663cc2ab8070e90b
Message-ID: <202403250013.RW96Pt4i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 17608373cf907afe97654998663cc2ab8070e90b  x86/build: Clean up arch/x86/tools/relocs.c a bit

elapsed time: 721m

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
arc                   randconfig-001-20240324   gcc  
arc                   randconfig-002-20240324   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240324   clang
arm                   randconfig-002-20240324   gcc  
arm                   randconfig-003-20240324   clang
arm                   randconfig-004-20240324   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240324   gcc  
arm64                 randconfig-002-20240324   gcc  
arm64                 randconfig-003-20240324   gcc  
arm64                 randconfig-004-20240324   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240324   gcc  
csky                  randconfig-002-20240324   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240324   clang
hexagon               randconfig-002-20240324   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240324   gcc  
i386         buildonly-randconfig-002-20240324   clang
i386         buildonly-randconfig-003-20240324   gcc  
i386         buildonly-randconfig-004-20240324   gcc  
i386         buildonly-randconfig-005-20240324   gcc  
i386         buildonly-randconfig-006-20240324   clang
i386                                defconfig   clang
i386                  randconfig-001-20240324   clang
i386                  randconfig-002-20240324   gcc  
i386                  randconfig-003-20240324   gcc  
i386                  randconfig-004-20240324   gcc  
i386                  randconfig-005-20240324   clang
i386                  randconfig-006-20240324   gcc  
i386                  randconfig-011-20240324   clang
i386                  randconfig-012-20240324   clang
i386                  randconfig-013-20240324   clang
i386                  randconfig-014-20240324   clang
i386                  randconfig-015-20240324   clang
i386                  randconfig-016-20240324   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240324   gcc  
loongarch             randconfig-002-20240324   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   clang
mips                malta_qemu_32r6_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240324   gcc  
nios2                 randconfig-002-20240324   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240324   gcc  
parisc                randconfig-002-20240324   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 linkstation_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc               randconfig-001-20240324   gcc  
powerpc               randconfig-002-20240324   gcc  
powerpc               randconfig-003-20240324   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240324   gcc  
powerpc64             randconfig-002-20240324   gcc  
powerpc64             randconfig-003-20240324   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240324   clang
riscv                 randconfig-002-20240324   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240324   clang
s390                  randconfig-002-20240324   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240324   gcc  
sh                    randconfig-002-20240324   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240324   gcc  
sparc64               randconfig-002-20240324   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240324   gcc  
um                    randconfig-002-20240324   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240324   gcc  
x86_64       buildonly-randconfig-002-20240324   gcc  
x86_64       buildonly-randconfig-003-20240324   clang
x86_64       buildonly-randconfig-004-20240324   clang
x86_64       buildonly-randconfig-005-20240324   gcc  
x86_64       buildonly-randconfig-006-20240324   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240324   clang
x86_64                randconfig-002-20240324   clang
x86_64                randconfig-003-20240324   clang
x86_64                randconfig-004-20240324   clang
x86_64                randconfig-005-20240324   clang
x86_64                randconfig-006-20240324   gcc  
x86_64                randconfig-011-20240324   clang
x86_64                randconfig-012-20240324   gcc  
x86_64                randconfig-013-20240324   gcc  
x86_64                randconfig-014-20240324   gcc  
x86_64                randconfig-015-20240324   gcc  
x86_64                randconfig-016-20240324   clang
x86_64                randconfig-071-20240324   clang
x86_64                randconfig-072-20240324   gcc  
x86_64                randconfig-073-20240324   clang
x86_64                randconfig-074-20240324   clang
x86_64                randconfig-075-20240324   clang
x86_64                randconfig-076-20240324   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240324   gcc  
xtensa                randconfig-002-20240324   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

