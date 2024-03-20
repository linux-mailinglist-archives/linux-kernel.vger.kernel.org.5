Return-Path: <linux-kernel+bounces-108311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9DD8808FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E11B1C22D03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFD125C4;
	Wed, 20 Mar 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TS/ID8oZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FFA125A9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897598; cv=none; b=nFC47n3Xgr/4cCRTajw7XU/kn/dvJ5cB+wFBMUHfHx9mL7XLE72KyEmSIQcloVLwRMnRlerxacN3wErdccXUQYyS7tRlslPm1fSV2Tb6V/TZTX93l7CY1dWnfbhl9Ef5vrPHwQCgrJ+wyPhq2JWZQVUn1o/Dng4+WgXpRrUDlBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897598; c=relaxed/simple;
	bh=TQiqeBbsy2eRQahd3+vRjsPzlViZx8kMnA1T4IkClWo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UvDc7WTAHYajsqiJwWz+mrxbfyZ8P2yeY1+JdRgXQodB6DnzaOHp8oWcTd8acViILQIGnTNAPnRf1txgipwT4qqu6Zjc2A2ybADfaba/CsJruIInWA/bMIZ5PFP9yNrBEPwusb3t6zPrUosDRr/SdBZxfrotsukiLMI1osmO6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TS/ID8oZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710897597; x=1742433597;
  h=date:from:to:cc:subject:message-id;
  bh=TQiqeBbsy2eRQahd3+vRjsPzlViZx8kMnA1T4IkClWo=;
  b=TS/ID8oZhaM+U2i4ckstaOzgx044f6GKGAA5Uv8fxKNQ7tXE6U/aaWTS
   RY/h43GZa+vlmoZZfvHfQKXpUcCFsdq0Kl+X3CZYXgZkcTx8RQPUjOOo0
   HXgnu7H/hN/rg1InnBt4p77CojcKWcWs2qT0fonHB++bRGkMrEXn0qjXn
   bedNvIyyLf1kPRVuhGiXtnEKkrehsQ5F3bRqyJsTnOZ9Uheytjt8sGAkl
   5fbZ46U0VntJoqPr3r2rI0ZyGrW3OYz+Z+M5YYjotHWzDzd6vogWZkm1s
   i02Np133u/M5tcIicC1vM5RUctIE7zAkgcHaasTUGNTiudXI5gYZGjBp9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="16945580"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="16945580"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 18:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="18714627"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2024 18:19:55 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmkcS-000IDl-1y;
	Wed, 20 Mar 2024 01:19:52 +0000
Date: Wed, 20 Mar 2024 09:19:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 eb8ed5b0e9d988a75b10ea811eeb1cffc6aa95c0
Message-ID: <202403200916.UmvEdbdq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: eb8ed5b0e9d988a75b10ea811eeb1cffc6aa95c0  Merge branch into tip/master: 'x86/fpu'

elapsed time: 730m

configs tested: 162
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
arc                   randconfig-001-20240319   gcc  
arc                   randconfig-002-20240319   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240319   clang
arm                   randconfig-002-20240319   gcc  
arm                   randconfig-003-20240319   clang
arm                   randconfig-004-20240319   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240319   gcc  
arm64                 randconfig-002-20240319   clang
arm64                 randconfig-003-20240319   clang
arm64                 randconfig-004-20240319   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240319   gcc  
csky                  randconfig-002-20240319   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240319   clang
hexagon               randconfig-002-20240319   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240320   clang
i386         buildonly-randconfig-002-20240320   gcc  
i386         buildonly-randconfig-003-20240320   gcc  
i386         buildonly-randconfig-004-20240320   clang
i386         buildonly-randconfig-005-20240320   gcc  
i386         buildonly-randconfig-006-20240320   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240320   clang
i386                  randconfig-002-20240320   clang
i386                  randconfig-003-20240320   clang
i386                  randconfig-004-20240320   clang
i386                  randconfig-005-20240320   clang
i386                  randconfig-006-20240320   gcc  
i386                  randconfig-011-20240320   clang
i386                  randconfig-012-20240320   clang
i386                  randconfig-013-20240320   clang
i386                  randconfig-014-20240320   clang
i386                  randconfig-015-20240320   gcc  
i386                  randconfig-016-20240320   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240319   gcc  
loongarch             randconfig-002-20240319   gcc  
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
nios2                 randconfig-001-20240319   gcc  
nios2                 randconfig-002-20240319   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240319   gcc  
parisc                randconfig-002-20240319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
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
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

