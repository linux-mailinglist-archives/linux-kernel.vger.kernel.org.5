Return-Path: <linux-kernel+bounces-61218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8D850F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7911F2269F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CFF9E6;
	Mon, 12 Feb 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN3BF3Kd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E94F9CA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727661; cv=none; b=neiXKSc4FPThw/xjVLqUR7LWtK5XTCyrypM73wb4ZlWUv8Rrncjs6KZHmrvks7WPZElPCZ0OKVMr/hZx1CvHzBE43erGljs1soCTOBcrzwI8f3fN+F0xC1P4eIwQQK6ECu9xiMGk0U05SOgoKvV0v2/5zpxZ+EdIF+nMf/Xs/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727661; c=relaxed/simple;
	bh=gOv3ZLKYYMw9tEAigbQ1eSqvtq0jeFefo8KvROG/P+s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PTzuvXCN7nT4hdZ4h6Rs3Y0sFgGyFvH+HXhJ2kQPxlJ6rXd0aZxIlzfe+ZLXiNaP6FILibbzh1/yXRAB2cWAwojF2JVlu+Z8fAJr4bpkYbEmTrNRyXNoaNU4MWJMULrBcliVeHfMioQVcWl+og08n8w5d4tNKDiE2GAgAXV4tPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN3BF3Kd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707727659; x=1739263659;
  h=date:from:to:cc:subject:message-id;
  bh=gOv3ZLKYYMw9tEAigbQ1eSqvtq0jeFefo8KvROG/P+s=;
  b=AN3BF3Kd0RHrM/7pdxOSxpXQVKUZWpr4eRk+9IGXHwDYF2oYtgUb4n9g
   fRUiBuR60yg30xXMyr64ElhHtiA+SQKbpcWHlPGWkFcbclHe6aMQ+CcJs
   24rGSL5t1kv5eMCSK1kgKkSR8PEi0RSCJ/ycaqGWawUs9SAN25vNeXfq/
   xRVMNliThsrjw7W4s5BLwzYnI73kpZxlOBQVr0MvmKZ5zzfCpIpqRcq4h
   4+ai82lYAgwcMH/WqS0EnspMhyIr9rwI/B6Abgyyi7lIQ9ScIUfXx02CN
   eoe8Mm7HJ6OG7wU05Zw1L0/horzbVEppnBPwtXrWDtCGXjZZRyPMzHPZm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12420313"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12420313"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 00:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2491317"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2024 00:47:38 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZRyR-00071y-1B;
	Mon, 12 Feb 2024 08:47:35 +0000
Date: Mon, 12 Feb 2024 16:46:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/ptp] BUILD SUCCESS
 27f6a9c87a97f5ea7459be08d5be231af6b32c20
Message-ID: <202402121649.hEDU461r-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/ptp
branch HEAD: 27f6a9c87a97f5ea7459be08d5be231af6b32c20  kvmclock: Unexport kvmclock clocksource

elapsed time: 1443m

configs tested: 216
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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240211   gcc  
arc                   randconfig-001-20240212   gcc  
arc                   randconfig-002-20240211   gcc  
arc                   randconfig-002-20240212   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240211   clang
arm                   randconfig-001-20240212   gcc  
arm                   randconfig-002-20240211   clang
arm                   randconfig-003-20240211   gcc  
arm                   randconfig-004-20240211   gcc  
arm                             rpc_defconfig   clang
arm                       spear13xx_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240211   clang
arm64                 randconfig-002-20240211   gcc  
arm64                 randconfig-003-20240211   gcc  
arm64                 randconfig-004-20240211   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240211   gcc  
csky                  randconfig-001-20240212   gcc  
csky                  randconfig-002-20240211   gcc  
csky                  randconfig-002-20240212   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240211   clang
hexagon               randconfig-002-20240211   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240211   clang
i386         buildonly-randconfig-002-20240211   gcc  
i386         buildonly-randconfig-003-20240211   clang
i386         buildonly-randconfig-004-20240211   gcc  
i386         buildonly-randconfig-005-20240211   gcc  
i386         buildonly-randconfig-006-20240211   clang
i386                                defconfig   clang
i386                  randconfig-001-20240211   gcc  
i386                  randconfig-002-20240211   gcc  
i386                  randconfig-003-20240211   gcc  
i386                  randconfig-004-20240211   clang
i386                  randconfig-005-20240211   gcc  
i386                  randconfig-006-20240211   clang
i386                  randconfig-011-20240211   clang
i386                  randconfig-012-20240211   gcc  
i386                  randconfig-013-20240211   clang
i386                  randconfig-014-20240211   clang
i386                  randconfig-015-20240211   clang
i386                  randconfig-016-20240211   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240211   gcc  
loongarch             randconfig-001-20240212   gcc  
loongarch             randconfig-002-20240211   gcc  
loongarch             randconfig-002-20240212   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  cavium_octeon_defconfig   gcc  
mips                           ci20_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240211   gcc  
nios2                 randconfig-001-20240212   gcc  
nios2                 randconfig-002-20240211   gcc  
nios2                 randconfig-002-20240212   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240211   gcc  
parisc                randconfig-001-20240212   gcc  
parisc                randconfig-002-20240211   gcc  
parisc                randconfig-002-20240212   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240211   gcc  
powerpc               randconfig-002-20240211   clang
powerpc               randconfig-002-20240212   gcc  
powerpc               randconfig-003-20240211   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240211   clang
powerpc64             randconfig-002-20240211   gcc  
powerpc64             randconfig-002-20240212   gcc  
powerpc64             randconfig-003-20240211   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240211   gcc  
riscv                 randconfig-001-20240212   gcc  
riscv                 randconfig-002-20240211   gcc  
riscv                 randconfig-002-20240212   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240211   clang
s390                  randconfig-002-20240211   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240211   gcc  
sh                    randconfig-001-20240212   gcc  
sh                    randconfig-002-20240211   gcc  
sh                    randconfig-002-20240212   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240211   gcc  
sparc64               randconfig-001-20240212   gcc  
sparc64               randconfig-002-20240211   gcc  
sparc64               randconfig-002-20240212   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240211   gcc  
um                    randconfig-002-20240211   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240211   gcc  
x86_64       buildonly-randconfig-002-20240211   clang
x86_64       buildonly-randconfig-003-20240211   clang
x86_64       buildonly-randconfig-004-20240211   clang
x86_64       buildonly-randconfig-005-20240211   gcc  
x86_64       buildonly-randconfig-006-20240211   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240211   gcc  
x86_64                randconfig-002-20240211   clang
x86_64                randconfig-003-20240211   clang
x86_64                randconfig-004-20240211   clang
x86_64                randconfig-005-20240211   gcc  
x86_64                randconfig-006-20240211   clang
x86_64                randconfig-011-20240211   clang
x86_64                randconfig-012-20240211   clang
x86_64                randconfig-013-20240211   gcc  
x86_64                randconfig-014-20240211   gcc  
x86_64                randconfig-015-20240211   clang
x86_64                randconfig-016-20240211   gcc  
x86_64                randconfig-071-20240211   gcc  
x86_64                randconfig-072-20240211   gcc  
x86_64                randconfig-073-20240211   gcc  
x86_64                randconfig-074-20240211   clang
x86_64                randconfig-075-20240211   clang
x86_64                randconfig-076-20240211   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240211   gcc  
xtensa                randconfig-001-20240212   gcc  
xtensa                randconfig-002-20240211   gcc  
xtensa                randconfig-002-20240212   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

