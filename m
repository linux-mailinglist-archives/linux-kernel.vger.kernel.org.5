Return-Path: <linux-kernel+bounces-118182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610588B58C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FD71C3ACD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C984D11;
	Mon, 25 Mar 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLk7z74F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E580C00
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410574; cv=none; b=Vfphl+RMHjj6MHAOOMSeIj4XMd9HLLXlfJ9ZBXEXj+1S0pdeUfbMcL86V47vA+VbfxUg3M+UASXTquY2BrMDrNdb4yfQ/gak6+jpPalCdWUqhjR051PF57HpBltKWyyK+fKbDaN3vvPpuUgFlgQOPdS2zNvE1t0mrfsJyRezlZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410574; c=relaxed/simple;
	bh=FDTjqRSZ/1Zer7UUtV7ilNcULl0lYnTIZ8kWdizko+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u8O+o0YM7rY5twCyG35c7FV0QU52I3Ntm74rQu3EHDhnv9Bzh6aUaVyJxAQSXHcR3ak06CcwqwaK9vyDbkp1UTCA7bOs4mw4XLU8tjfT+iWcp9BG2T9Omr5htAUR3pHRSxNT3JyjNvlye1aNf5uPE74zKDPnBbjFu3fE2ZHEFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLk7z74F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711410572; x=1742946572;
  h=date:from:to:cc:subject:message-id;
  bh=FDTjqRSZ/1Zer7UUtV7ilNcULl0lYnTIZ8kWdizko+E=;
  b=kLk7z74FlDesG/SL6e+OL7/Y5x6fewso5JlYTvOCMu8Myl4qOJOeqT1j
   tmCxOUoySJ9ivyLAOuQn+KTvofMXFIPrhhwYQv5vpjn8xHNlLC3TFwuyi
   my3Dl05u1EJjVpYpbKfO4jG25LIhUJ6nw+q2bqRi8iHTgglsJYXQQQSX4
   xvFeWd/dSA3YavCmYoV/b/0N9heTStm2egrQ2ZiU55lVXsGXv2Uak5ubJ
   MFJrDKelHlNoy3A9ocMboHyC1fQZpU4kvMIoWTQkM2siQC0CgEDIlCVxm
   lLzVR9fki9+oFSe5R4Z5XH0yggetQu7CZkACHj2bdPM/OvuIfU6V3CoDz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="7039325"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="7039325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 16:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15811921"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 25 Mar 2024 16:49:31 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rou4G-000MvM-28;
	Mon, 25 Mar 2024 23:49:28 +0000
Date: Tue, 26 Mar 2024 07:49:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 b90169b42a6f49ff2fe2e4d4ed0bbcf17fb8f1bf
Message-ID: <202403260710.CzQXunw8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: b90169b42a6f49ff2fe2e4d4ed0bbcf17fb8f1bf  x86/percpu: Do not use this_cpu_read_stable_8() for 32-bit targets

elapsed time: 752m

configs tested: 135
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240326   gcc  
arc                   randconfig-002-20240326   gcc  
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240326   gcc  
arm                   randconfig-002-20240326   gcc  
arm                   randconfig-003-20240326   gcc  
arm                   randconfig-004-20240326   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240326   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240326   gcc  
csky                  randconfig-002-20240326   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240326   clang
i386                                defconfig   clang
i386                  randconfig-004-20240326   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240326   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240326   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240326   gcc  
loongarch             randconfig-002-20240326   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240326   gcc  
nios2                 randconfig-002-20240326   gcc  
openrisc                         allmodconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                randconfig-001-20240326   gcc  
parisc                randconfig-002-20240326   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc               randconfig-002-20240326   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240326   gcc  
powerpc64             randconfig-002-20240326   gcc  
powerpc64             randconfig-003-20240326   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240326   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240326   gcc  
sh                    randconfig-002-20240326   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240326   gcc  
sparc64               randconfig-002-20240326   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240326   gcc  
um                    randconfig-002-20240326   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-076-20240326   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240326   gcc  
xtensa                randconfig-002-20240326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

