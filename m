Return-Path: <linux-kernel+bounces-125564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45F8928BE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A262837CC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AFD17CD;
	Sat, 30 Mar 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWR9+gMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED27801
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711761738; cv=none; b=rgtOc9jEfL9MI2mheF9Vf6xprDg8P0CJoNgFMcGEb2PuzF73dverLBqMzDSb2RBALQm3xH75EXyaRQoPjm3AxQx1uMKsou63qAUg7EmFL9VRRpZWGzvJp/UgGfWFU3sDxlG1ssvNeMczUTTfe614iXNkAIo2KVe1YzscJdy5NvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711761738; c=relaxed/simple;
	bh=ThPafopokyMVlFJxr3hRoIZUklGipMdt7vF+rVsNMaQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VAmTZBOMinIc2MLUHJE1QWkqrnHrUz8HNL++A74DS8r7sX8WCMyoQXPR6KyOZtfl+nvP54gi4V+gYuNYlU5QGlz2hQCGY0BvHyVPcRUmIjmaJ829TP75BugFnJRrQSiPFWcTVDnESoxrSo8fWaZ2ApBRp0Zlgus5nvHLbph8kFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWR9+gMx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711761736; x=1743297736;
  h=date:from:to:cc:subject:message-id;
  bh=ThPafopokyMVlFJxr3hRoIZUklGipMdt7vF+rVsNMaQ=;
  b=WWR9+gMxvuJ4gMAOyBi9zP103p+33CpuZf2/4kXrOK58BuTI1K0AOtdQ
   J2qlLca83yZEhpVXtDhjChAKYW7Qh+3JVJemCTu9oAk3strrRFhB6jbj8
   YqJJBpCuzq/6SptY9evu1zWSIlixaG6v3QQrQs226gMhQ0Bo1RAb6Oho7
   XbTA4EhMadnxeI7URR47QnBni22zGm9vY3trd3ZXRAb7xzCDA7yjuyIpG
   rcRJwvUVkWM01xC5KHiRmzIIxHqeKLhtjnuqd56fdAr9X68FCBwB7+U/8
   FPM0nRYr+WUCLr/4E6kCKVDWzcnv4JA1RGk3ZsiCeX7skTl7/TbeUAdBs
   Q==;
X-CSE-ConnectionGUID: NI3TuJc/QxOaOnPeMTNRmA==
X-CSE-MsgGUID: nR/lIE22SYWRhZ9edarkyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="10743720"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="10743720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 18:22:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17529444"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Mar 2024 18:22:14 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqNQB-0003ot-37;
	Sat, 30 Mar 2024 01:22:11 +0000
Date: Sat, 30 Mar 2024 09:21:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27b] BUILD REGRESSION
 786fab3085d764055a78edb54023420920344333
Message-ID: <202403300945.IV47RWYb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
branch HEAD: 786fab3085d764055a78edb54023420920344333  EXP rcu Move wakeup out from under lock

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403292318.88dppMPt-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403292322.bwguovKc-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403300508.Xz7XNp71-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/parisc/include/asm/cmpxchg.h:75:24: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
arch/parisc/include/asm/cmpxchg.h:75:66: error: 'new' undeclared (first use in this function); did you mean 'new_'?
arch/riscv/include/asm/cmpxchg.h:328:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
arch/riscv/include/asm/cmpxchg.h:332:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
arch/sh/include/asm/cmpxchg.h:60:24: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
arch/sh/include/asm/cmpxchg.h:62:24: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
arch/xtensa/include/asm/cmpxchg.h:78:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
include/linux/atomic/atomic-arch-fallback.h:2026:9: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
lib/cmpxchg-emu.c:24:11: warning: no previous prototype for 'cmpxchg_emu_u8' [-Wmissing-prototypes]
lib/cmpxchg-emu.c:51:11: warning: no previous prototype for 'cmpxchg_emu_u16' [-Wmissing-prototypes]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- csky-allnoconfig
|   |-- lib-cmpxchg-emu.c:warning:no-previous-prototype-for-cmpxchg_emu_u16
|   `-- lib-cmpxchg-emu.c:warning:no-previous-prototype-for-cmpxchg_emu_u8
|-- parisc-allnoconfig
|   |-- arch-parisc-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-parisc-include-asm-cmpxchg.h:error:new-undeclared-(first-use-in-this-function)
|-- riscv-allnoconfig
|   |-- arch-riscv-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-riscv-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- riscv-randconfig-r051-20240330
|   |-- arch-riscv-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-riscv-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-allmodconfig
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-allnoconfig
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-allyesconfig
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-defconfig
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-r7780mp_defconfig
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-randconfig-001-20240330
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- sh-randconfig-002-20240330
|   |-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-sh-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- xtensa-allnoconfig
|   |-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
|-- xtensa-iss_defconfig
|   |-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
|   `-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
`-- xtensa-smp_lx200_defconfig
    |-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u16
    `-- arch-xtensa-include-asm-cmpxchg.h:error:implicit-declaration-of-function-cmpxchg_emu_u8
clang_recent_errors
|-- riscv-allmodconfig
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u16-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u8-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-allyesconfig
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u16-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u8-ISO-C99-and-later-do-not-support-implicit-function-declarations
|-- riscv-defconfig
|   |-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u16-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   `-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u8-ISO-C99-and-later-do-not-support-implicit-function-declarations
`-- riscv-randconfig-002-20240330
    |-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u16-ISO-C99-and-later-do-not-support-implicit-function-declarations
    `-- include-linux-atomic-atomic-arch-fallback.h:error:call-to-undeclared-function-cmpxchg_emu_u8-ISO-C99-and-later-do-not-support-implicit-function-declarations

elapsed time: 1280m

configs tested: 196
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240329   gcc  
arc                   randconfig-001-20240330   gcc  
arc                   randconfig-002-20240329   gcc  
arc                   randconfig-002-20240330   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240329   gcc  
arm                   randconfig-003-20240330   gcc  
arm                   randconfig-004-20240329   gcc  
arm                   randconfig-004-20240330   gcc  
arm                       spear13xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240329   gcc  
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240329   gcc  
csky                  randconfig-001-20240330   gcc  
csky                  randconfig-002-20240329   gcc  
csky                  randconfig-002-20240330   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240329   clang
i386         buildonly-randconfig-003-20240329   clang
i386         buildonly-randconfig-004-20240329   clang
i386         buildonly-randconfig-005-20240329   clang
i386         buildonly-randconfig-006-20240329   clang
i386                                defconfig   clang
i386                  randconfig-001-20240329   clang
i386                  randconfig-002-20240329   clang
i386                  randconfig-003-20240329   clang
i386                  randconfig-004-20240329   clang
i386                  randconfig-005-20240329   clang
i386                  randconfig-006-20240329   clang
i386                  randconfig-006-20240330   gcc  
i386                  randconfig-011-20240329   clang
i386                  randconfig-012-20240329   clang
i386                  randconfig-012-20240330   gcc  
i386                  randconfig-013-20240330   gcc  
i386                  randconfig-015-20240330   gcc  
i386                  randconfig-016-20240329   clang
i386                  randconfig-016-20240330   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240329   gcc  
loongarch             randconfig-001-20240330   gcc  
loongarch             randconfig-002-20240329   gcc  
loongarch             randconfig-002-20240330   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                       lemote2f_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240329   gcc  
nios2                 randconfig-001-20240330   gcc  
nios2                 randconfig-002-20240329   gcc  
nios2                 randconfig-002-20240330   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240329   gcc  
parisc                randconfig-001-20240330   gcc  
parisc                randconfig-002-20240329   gcc  
parisc                randconfig-002-20240330   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc               randconfig-001-20240330   gcc  
powerpc               randconfig-002-20240329   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240329   gcc  
powerpc64             randconfig-001-20240330   gcc  
powerpc64             randconfig-002-20240330   gcc  
powerpc64             randconfig-003-20240329   gcc  
powerpc64             randconfig-003-20240330   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240329   gcc  
riscv                 randconfig-001-20240330   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240329   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240329   gcc  
sh                    randconfig-001-20240330   gcc  
sh                    randconfig-002-20240329   gcc  
sh                    randconfig-002-20240330   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240329   gcc  
sparc64               randconfig-001-20240330   gcc  
sparc64               randconfig-002-20240329   gcc  
sparc64               randconfig-002-20240330   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240329   gcc  
um                    randconfig-002-20240330   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240329   clang
x86_64       buildonly-randconfig-003-20240330   clang
x86_64       buildonly-randconfig-004-20240329   clang
x86_64       buildonly-randconfig-004-20240330   clang
x86_64       buildonly-randconfig-006-20240329   clang
x86_64       buildonly-randconfig-006-20240330   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240330   clang
x86_64                randconfig-003-20240329   clang
x86_64                randconfig-003-20240330   clang
x86_64                randconfig-005-20240329   clang
x86_64                randconfig-011-20240329   clang
x86_64                randconfig-011-20240330   clang
x86_64                randconfig-012-20240330   clang
x86_64                randconfig-013-20240329   clang
x86_64                randconfig-013-20240330   clang
x86_64                randconfig-014-20240329   clang
x86_64                randconfig-016-20240329   clang
x86_64                randconfig-071-20240330   clang
x86_64                randconfig-072-20240330   clang
x86_64                randconfig-073-20240329   clang
x86_64                randconfig-074-20240330   clang
x86_64                randconfig-075-20240329   clang
x86_64                randconfig-075-20240330   clang
x86_64                randconfig-076-20240329   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240329   gcc  
xtensa                randconfig-001-20240330   gcc  
xtensa                randconfig-002-20240329   gcc  
xtensa                randconfig-002-20240330   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

