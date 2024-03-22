Return-Path: <linux-kernel+bounces-112089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE48875A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE4DB21691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4182D72;
	Fri, 22 Mar 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0PqYVZk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8362282895
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149287; cv=none; b=F3t3ASBJ4Vspa+n19MTlm7ej9K6csO2h9WmI3rsUJzpBxROFUnJ2AqjYpjZL0l6FtN5iptR46fM3f2CZOqcKlbFXEAUojn60h1EFCMahjZzjVOn0+oZU0A/DsbZBntrbMCsVSHZchTTOfsnod9pPLoGDJWP9391ZYl8CMG983a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149287; c=relaxed/simple;
	bh=fEBcrpJw02YpJKztamcyxJdjMSOisoiKfJE0LoZdqQY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RCuay1uSwnoPNm0DJqgnpcduZqF8WvriR3tFgl56lKzn3o+/oJ/52wHfGtLB5/uSLpIDxC7eMsTqcLy0NRduP7wDEzZ+Tswsy8pDWv2XmUVqJ/IYiUEayUP2DF5qr9Ab6jmZ42UZfY7yCNh2+kzKisn76sCSW+24IPtQsBZ7/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0PqYVZk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149286; x=1742685286;
  h=date:from:to:cc:subject:message-id;
  bh=fEBcrpJw02YpJKztamcyxJdjMSOisoiKfJE0LoZdqQY=;
  b=W0PqYVZkz96tmbmriVf+jC4nevf7jOLc0Yye0041u+cgLAfRa20opikH
   HJVvgdFcLadLM69t0WeJ5AbNT6ibBgaI/vqlxAONcSyb5wRUb0VnufHUn
   48znKrVMZ+ovTrYbBpLBc/jkvEYdAwAxqwphC4L0K/2CB7Tk/JdksRFu7
   5XY0qI281I+vq8YX/jileeUPSLw9g6vpiiDvFbFD6zZvsSpsJn7761y+y
   3laKxfkzrNk8ti7GS9+Mb8fZVjlQ2WQPqQVf67nn3DrFlIeVrmN9VSBe3
   6dkpOsUrGsymw8miByeFZqxIrYEaGHbn3Ef3ERFyNmGW79XJAc5UzaYnF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="10005119"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="10005119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="15156792"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2024 16:14:41 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rno5v-000Kgt-05;
	Fri, 22 Mar 2024 23:14:39 +0000
Date: Sat, 23 Mar 2024 07:13:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 79a4567b2e8ae4d0282602a24f76f5e2382f5b98
Message-ID: <202403230753.Pg4XeEL2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 79a4567b2e8ae4d0282602a24f76f5e2382f5b98  x86/tsc: Make __use_tsc __ro_after_init

elapsed time: 734m

configs tested: 143
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240322   gcc  
i386         buildonly-randconfig-001-20240323   gcc  
i386         buildonly-randconfig-002-20240322   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-004-20240323   gcc  
i386         buildonly-randconfig-005-20240322   gcc  
i386         buildonly-randconfig-005-20240323   gcc  
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-003-20240322   gcc  
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240322   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240322   clang
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240322   clang
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240322   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240322   clang
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-014-20240323   gcc  
i386                  randconfig-015-20240322   gcc  
i386                  randconfig-015-20240323   gcc  
i386                  randconfig-016-20240322   clang
i386                  randconfig-016-20240323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240323   clang
x86_64       buildonly-randconfig-002-20240323   clang
x86_64       buildonly-randconfig-003-20240323   clang
x86_64       buildonly-randconfig-005-20240323   clang
x86_64       buildonly-randconfig-006-20240323   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240323   clang
x86_64                randconfig-003-20240323   clang
x86_64                randconfig-004-20240323   clang
x86_64                randconfig-011-20240323   clang
x86_64                randconfig-013-20240323   clang
x86_64                randconfig-014-20240323   clang
x86_64                randconfig-015-20240323   clang
x86_64                randconfig-016-20240323   clang
x86_64                randconfig-071-20240323   clang
x86_64                randconfig-072-20240323   clang
x86_64                randconfig-073-20240323   clang
x86_64                randconfig-074-20240323   clang
x86_64                randconfig-076-20240323   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

