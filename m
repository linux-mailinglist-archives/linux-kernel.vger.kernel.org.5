Return-Path: <linux-kernel+bounces-108293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6348808D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897EFB22F91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0619138C;
	Wed, 20 Mar 2024 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0Ggs0md"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE010EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896338; cv=none; b=Cl8QJjetbIYGExibgoo6k/ICEhtX5WBzTH9jch6uutDmDLqy//mAl1YDGah0FLd9j0rIu80YwbrUXNNXLhbzMMhYhKproxiACufSKKrfsl2B8v69DopLYbXEQeNRGko8Ns9otUugiqeM0sXyD3grNrWj3tTPn2EGNnahogAx7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896338; c=relaxed/simple;
	bh=PhqYH8mbBFNWHex8uUePB89Suyd62rcPLMoFbbWWXDE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dITstmAU+VUGwEGx2Y/8wH2bxKcdD9A/C2BpLkXyJKq0GquVaD3m4wrPDIrRSzMxXyvRZVXSsRReIaTVClP4gHUV7Anda67Upx35DX4DvTZuu1UUTZJUPoa4Qq98URqu2NPKPHMb6U51QRyUaM1Mc5q8zO84aLQqKrsAcd8f/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0Ggs0md; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710896337; x=1742432337;
  h=date:from:to:cc:subject:message-id;
  bh=PhqYH8mbBFNWHex8uUePB89Suyd62rcPLMoFbbWWXDE=;
  b=U0Ggs0md3WxsyuQ+BJPfLlLXtxKsaSqKJ6LD09dQs98gnY7z8NHy3eN0
   +tGSvA/DO5j+D+nYbpU0fsVBzEouyI1sSuZrvazeGCYfkrN1gqMcntzAG
   nwV8aR/Xy7XlkTRumLTeEhaooPRBEdILYxoAJOtQIgzYN2aXVgHDXtHxN
   dXFgYy3ejhDjqB5YUMvuziII/d5S08wraaVoq9PUPGdmK46RM7HVZUiR0
   FoHxLWlI2WYGU7e8/wZ8fFUtIPBts7dcec7PmgXl+Z6E3Aag7W0neghsP
   4K4YuG6A4bLueYG8M35GGd+2ZCuevfg28E11Z13SDti6vOF44DUkWG619
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="31236074"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="31236074"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="44955796"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Mar 2024 17:58:54 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmkI8-000ICx-0j;
	Wed, 20 Mar 2024 00:58:52 +0000
Date: Wed, 20 Mar 2024 08:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 d689863c1a60b9936b47a34fa5c3330de374f4fc
Message-ID: <202403200803.tzmW74hK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: d689863c1a60b9936b47a34fa5c3330de374f4fc  x86/asm: Use %a instead of %P operand modifier in asm templates

elapsed time: 739m

configs tested: 167
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240320   gcc  
arc                   randconfig-002-20240320   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240320   gcc  
arm                   randconfig-002-20240320   gcc  
arm                   randconfig-003-20240320   gcc  
arm                   randconfig-004-20240320   gcc  
arm                           spitz_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240320   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240320   gcc  
csky                  randconfig-002-20240320   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240319   clang
i386         buildonly-randconfig-001-20240320   clang
i386         buildonly-randconfig-002-20240319   clang
i386         buildonly-randconfig-003-20240319   clang
i386         buildonly-randconfig-004-20240319   clang
i386         buildonly-randconfig-004-20240320   clang
i386         buildonly-randconfig-005-20240319   gcc  
i386         buildonly-randconfig-006-20240319   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240319   clang
i386                  randconfig-001-20240320   clang
i386                  randconfig-002-20240319   clang
i386                  randconfig-002-20240320   clang
i386                  randconfig-003-20240319   clang
i386                  randconfig-003-20240320   clang
i386                  randconfig-004-20240319   clang
i386                  randconfig-004-20240320   clang
i386                  randconfig-005-20240319   clang
i386                  randconfig-005-20240320   clang
i386                  randconfig-006-20240319   gcc  
i386                  randconfig-011-20240319   gcc  
i386                  randconfig-011-20240320   clang
i386                  randconfig-012-20240319   clang
i386                  randconfig-012-20240320   clang
i386                  randconfig-013-20240319   gcc  
i386                  randconfig-013-20240320   clang
i386                  randconfig-014-20240319   clang
i386                  randconfig-014-20240320   clang
i386                  randconfig-015-20240319   clang
i386                  randconfig-016-20240319   gcc  
i386                  randconfig-016-20240320   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240320   gcc  
loongarch             randconfig-002-20240320   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240320   gcc  
nios2                 randconfig-002-20240320   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240320   gcc  
parisc                randconfig-002-20240320   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc               randconfig-001-20240320   gcc  
powerpc               randconfig-003-20240320   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240320   gcc  
powerpc64             randconfig-002-20240320   gcc  
powerpc64             randconfig-003-20240320   gcc  
riscv                             allnoconfig   gcc  
riscv                 randconfig-002-20240320   gcc  
s390                          debug_defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240320   gcc  
sh                    randconfig-002-20240320   gcc  
sh                          rsk7201_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240320   gcc  
sparc64               randconfig-002-20240320   gcc  
um                               allmodconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240320   gcc  
um                    randconfig-002-20240320   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240320   gcc  
x86_64       buildonly-randconfig-002-20240320   clang
x86_64       buildonly-randconfig-003-20240320   clang
x86_64       buildonly-randconfig-004-20240320   clang
x86_64       buildonly-randconfig-005-20240320   gcc  
x86_64       buildonly-randconfig-006-20240320   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240320   clang
x86_64                randconfig-002-20240320   clang
x86_64                randconfig-003-20240320   gcc  
x86_64                randconfig-004-20240320   clang
x86_64                randconfig-005-20240320   clang
x86_64                randconfig-006-20240320   clang
x86_64                randconfig-011-20240320   gcc  
x86_64                randconfig-012-20240320   gcc  
x86_64                randconfig-013-20240320   gcc  
x86_64                randconfig-014-20240320   gcc  
x86_64                randconfig-015-20240320   clang
x86_64                randconfig-016-20240320   gcc  
x86_64                randconfig-071-20240320   clang
x86_64                randconfig-072-20240320   gcc  
x86_64                randconfig-073-20240320   clang
x86_64                randconfig-074-20240320   gcc  
x86_64                randconfig-075-20240320   gcc  
x86_64                randconfig-076-20240320   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240320   gcc  
xtensa                randconfig-002-20240320   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

