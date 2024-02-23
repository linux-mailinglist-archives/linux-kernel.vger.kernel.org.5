Return-Path: <linux-kernel+bounces-78699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD36861789
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B36282182
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321113B7B7;
	Fri, 23 Feb 2024 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKtCppnp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C913A899
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704915; cv=none; b=jW2nI9W/amn9BTnGk1Z0I5vxv4ADz3rlI1Bpn/3D/6WJ/gJZFqtGI5T5bn4ZTQQK4NNhch+Xwq+08lz0fcG7rnlgO1nTjEGIVtw5Rk5wqT8jW0KXI9SevzwKKHAwNlSML+zkAbZd1LiaE3xHzzPXq5AkPsSG7uid+kDUa2tYrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704915; c=relaxed/simple;
	bh=mrGc8Gl82D/sdUB90gbyCPOUp2tdtmck2FNruNO29PA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Rs+bZbeAdPPuKQzgJE7bU+qPdLYcgawdhZrKmLMo5IqK8c19+PdqLEFxb9pDRe9xIo9+vWzPOCdKZlSCrCI5KgAxmNnLI0O0gJRoTBkfZJ3q6qxLZkPGCrWRClBqMpg8uN7slHQU3jCS2j0bUtLNdFYFcLaSujEgYh4LRIN+sDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKtCppnp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704914; x=1740240914;
  h=date:from:to:cc:subject:message-id;
  bh=mrGc8Gl82D/sdUB90gbyCPOUp2tdtmck2FNruNO29PA=;
  b=JKtCppnpdtSTbfQOqzVK+Rb30ScejI5whQUuPw3pFsHMYNVAkmX5Btba
   eH/kgJZrbBBYeWrMQMW5LWcs95yYuReYeb/vlmbvT/9cRV9woZ9SMWmA7
   fwh4bmL2RDV8vllKKlBKst4d8WARK1jVfB478i7kTS5NGhQPHqA4B1IlE
   MQz2YTkvjdtLxGqdcsx2Ujb68JCwNAa2ySASc847AqHDirbW3GL/JuH9R
   Lz+nOGNTtNE1yn84XlEy2ze07FCYkT9RPRdvHL5jeKPMbHNoNfLaK5L+4
   NBhEgEeZFu7NR42s7cQoRDuStMo0LJzulqouztXGDkJlAF8LytZn2oXdD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14455775"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14455775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6165332"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2024 08:15:12 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdYCb-0007ee-1X;
	Fri, 23 Feb 2024 16:15:09 +0000
Date: Sat, 24 Feb 2024 00:11:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 c0d848fcb09d80a5f48b99f85e448185125ef59f
Message-ID: <202402240033.prx015i6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: c0d848fcb09d80a5f48b99f85e448185125ef59f  x86/resctrl: Remove lockdep annotation that triggers false positive

elapsed time: 1464m

configs tested: 181
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
arm                           stm32_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
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
m68k                        mvme147_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
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
parisc                           alldefconfig   gcc  
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
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
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
sh                            migor_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240223   gcc  
sh                    randconfig-002-20240223   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7705_defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240223   gcc  
x86_64       buildonly-randconfig-002-20240223   gcc  
x86_64       buildonly-randconfig-003-20240223   clang
x86_64       buildonly-randconfig-004-20240223   clang
x86_64       buildonly-randconfig-005-20240223   gcc  
x86_64       buildonly-randconfig-006-20240223   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240223   gcc  
x86_64                randconfig-002-20240223   clang
x86_64                randconfig-003-20240223   gcc  
x86_64                randconfig-004-20240223   gcc  
x86_64                randconfig-005-20240223   clang
x86_64                randconfig-006-20240223   gcc  
x86_64                randconfig-011-20240223   gcc  
x86_64                randconfig-012-20240223   gcc  
x86_64                randconfig-013-20240223   clang
x86_64                randconfig-014-20240223   gcc  
x86_64                randconfig-015-20240223   clang
x86_64                randconfig-016-20240223   clang
x86_64                randconfig-071-20240223   gcc  
x86_64                randconfig-072-20240223   gcc  
x86_64                randconfig-073-20240223   gcc  
x86_64                randconfig-074-20240223   clang
x86_64                randconfig-075-20240223   gcc  
x86_64                randconfig-076-20240223   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240223   gcc  
xtensa                randconfig-002-20240223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

