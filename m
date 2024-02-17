Return-Path: <linux-kernel+bounces-69938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D2859087
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C404B2130A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C47C6E7;
	Sat, 17 Feb 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa7SyuE5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39D7C6D6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183889; cv=none; b=dn3CH25eg7IolcyMX2Fs2nCqTOsxiTxLZNZt/PwQaLraD6I053XRDsB/9HIxbIjLxdEPAJooa+JqLeSdkDL3qk7T2pCtub7B/dkQvrNVTlbG/tKrcSkSgda6SeyVvRhapYfoJmlFf2eQXB2BzyO5KvWMoVcuyf/JybyQ7Xs6SlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183889; c=relaxed/simple;
	bh=8xsLiIJ5Ym20LCEmuZf43yisN1nCebfb03VvvY1yPYo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BSSly/xt8rrNylVpy4oix1/bTzYpnGlCdB5IfgheQ4mwzDBhVwT4PB+rsYsBGCLpyZxR5xjslrCPc7dvwk5bQ+gytYuQX0/ptexlCnalo7XtpnsMj2rw7885myrgl4RR1i8NS1DMI4DlVAMcuQ0NsTZtWnkORJa8mi+keJjg1LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa7SyuE5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708183886; x=1739719886;
  h=date:from:to:cc:subject:message-id;
  bh=8xsLiIJ5Ym20LCEmuZf43yisN1nCebfb03VvvY1yPYo=;
  b=aa7SyuE5gIVzmGMz6PUoiScAdfZTtIzW+7qL1FaHSoAmGekbCFOwQkBR
   ne/HTknVhDG3r4OBAaUgWaEGwHCUZue1CEf1cdyuBYiQNAmNuKf7yjUIk
   mdod+1AepnP9QP8fWxp2pgkDOSSs72bURkHV9kk8PYAMtswNwX+qtiOsb
   2Sb30mmjK5VgezGTrFajf63R/qLuHsleUHSG84sdVrGShmY79J0hU0nD9
   RwwLxdSfSTa6Cs+AtjvFf4BD9hkYJS7QDSpfR5LpaYvvsQ3wNgb1Bn+i3
   25a6Jr/Fwomur9xtqqSK+GP+FyWaNknzwb5k7lb3zzsMawx6DeV69O+BI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="12854160"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="12854160"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 07:31:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="8758407"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2024 07:31:25 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbMeg-0002CK-1V;
	Sat, 17 Feb 2024 15:31:10 +0000
Date: Sat, 17 Feb 2024 23:30:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 89b0f15f408f7c4ee98c1ec4c3224852fcbc3274
Message-ID: <202402172349.Xt8i3IvD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 89b0f15f408f7c4ee98c1ec4c3224852fcbc3274  x86/cpu/topology: Get rid of cpuinfo::x86_max_cores

elapsed time: 1452m

configs tested: 150
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                         s5pv210_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
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
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240217   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240217   clang
i386                                defconfig   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-003-20240217   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240217   clang
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-013-20240217   clang
i386                  randconfig-014-20240217   clang
i386                  randconfig-015-20240217   clang
i386                  randconfig-016-20240217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                     kmeter1_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
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
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240217   gcc  
x86_64       buildonly-randconfig-003-20240217   gcc  
x86_64       buildonly-randconfig-004-20240217   gcc  
x86_64       buildonly-randconfig-006-20240217   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240217   gcc  
x86_64                randconfig-011-20240217   gcc  
x86_64                randconfig-012-20240217   gcc  
x86_64                randconfig-014-20240217   gcc  
x86_64                randconfig-015-20240217   gcc  
x86_64                randconfig-071-20240217   gcc  
x86_64                randconfig-072-20240217   gcc  
x86_64                randconfig-073-20240217   gcc  
x86_64                randconfig-075-20240217   gcc  
x86_64                randconfig-076-20240217   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

