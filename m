Return-Path: <linux-kernel+bounces-78635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2286162B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061FC1C241ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2A82866;
	Fri, 23 Feb 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK9WXJCS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7D1DFF9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703163; cv=none; b=DX3XC9Te9Q5OvbwZ0A2iiZW0RQyhxyHM/RxwQmIkEpXwsu3S1oXdh8o7evSg8LGOiJwsaointcIQrtmGXO1vsuWjBePbdt2WrCzCkCv/IBqI4yMi9QmPa/05qNmMWutvJEDs8PX4A4ujpD6emcRCitLcSiAswDs1IPzYpL4cFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703163; c=relaxed/simple;
	bh=NnUsj3dr6Qg0rH4rAM3oY3b0bzb8Cu3R6NbeblqQP/A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bBpDmgbfW8oljNJF0jf658TIQFCHJtX+W1tPxTvRgXsGJ2f4AkVNeF3un6wh10NiT4V4Il+7nyMOqQN71l3nW+Va3pd81DkoDPRyy2XAdtL0Tpn59lY/nSeL5017Jb7E1+Fe67cpgAm/YTaY9Qpf7jQLsYCMjH9KJYr/SI3TiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK9WXJCS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703161; x=1740239161;
  h=date:from:to:cc:subject:message-id;
  bh=NnUsj3dr6Qg0rH4rAM3oY3b0bzb8Cu3R6NbeblqQP/A=;
  b=kK9WXJCSe5tPAFoTBcSQ1BumePB8kYWKqZhCIoRAK28QyQi9FqIBdDZT
   hyAvWANBqq0/iY/0elN3rH5ON/OfLgQTDOkj8uwK3ddKt0U0WSHEM7jpK
   rgU3+uBLJamx+apm4i2EFmBI50QaC6ilXVNv0dPeTU0WnUAcoNu90oeyd
   ulYXZOrUB7bzw+y6HRWU/Ji6yWktbstnEqxzKjD/lpL5BzZVzVf2k9Slo
   kXZzxETXjbfXcHomIz25o8xI2TPfC2nwa4IKdyksJJiZHqOA/qfUNmGSL
   ukCQI083Pf2FM3y9ug9hggIREs6UHKF4cCxJc28XRNYnSAeA8L6Q3isgo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14451077"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14451077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6306321"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Feb 2024 07:46:00 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdXkL-0007cy-1L;
	Fri, 23 Feb 2024 15:45:57 +0000
Date: Fri, 23 Feb 2024 23:45:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf
Message-ID: <202402232346.NYTCQSGS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 5bdd181821b2c65b074cfad07d7c7d5d3cfe20bf  x86/asm: Remove the __iomem annotation of movdir64b()'s dst argument

elapsed time: 987m

configs tested: 119
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
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
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
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
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

