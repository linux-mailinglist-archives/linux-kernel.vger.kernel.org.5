Return-Path: <linux-kernel+bounces-78683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B0A86172B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF351C20C02
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1184FBB;
	Fri, 23 Feb 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERUi9X1a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E5982D66
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704658; cv=none; b=jfJAadVS+sQJ8R9kgLxJoup5g2slJL65prM5/RnMh17aJJvbEUwgou64FAEIDVHrmcC4UMIwTj9SQI3w96yhvpdliCl/O/jB3sj8ehVR08V+W05XgBuvJVTIytQD4bsnisxquEW921xd0KTYXL1p251lvcqp/9mjRNvgsHiv5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704658; c=relaxed/simple;
	bh=tPYPr2Ihz4IkCSFdSdADXv2PCaOn1w6tGi9e/+qEgL4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E59SaoAnfQXzGCps6fUqfkShijXuxjRIGFnGGViP7LppHy9l3XA2YlKyP+VOMmeRjV8SqaynqXFDFI69eu5/NazeVgcntIrwcCz9Gabmx/LxaEam3prWG6LRCrmjCl8OaZ55SYCNoSrShxKk6PXdaSJU4c/mUOMS72qgweAXYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERUi9X1a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708704657; x=1740240657;
  h=date:from:to:cc:subject:message-id;
  bh=tPYPr2Ihz4IkCSFdSdADXv2PCaOn1w6tGi9e/+qEgL4=;
  b=ERUi9X1aJbphGl5p2wSbacHFfqG1QBjgL7AcaXfCuy5w2s0I74yntsby
   8QqLkez/hm9vMv8w3R4lLK+ZCIdDSRotxIobx+u72JSF54ddEZ4LqcoHW
   Se53No6fHhedtloGI2tOM7V9DOrcvbEXEiSYvHC/O3+FqlnYent8n8TYn
   CdG+4TEq7zgwFql1U1cjn3xke1c8Su1qHl8vkn68SkMQPTEVWyBDWTxC7
   saBoWebM9EfDjmH32jRF0o+95g3wrHY1whozrrfTLkQoeYaoFSy5sClX4
   +XTSJ3isYu6t8TFSu4WublSwvetPeMjEyrlPoSdubC8fr03aY3B3+I7v2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2913332"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2913332"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 08:10:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5893092"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Feb 2024 08:10:54 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdY7x-0007dw-1w;
	Fri, 23 Feb 2024 16:10:33 +0000
Date: Sat, 24 Feb 2024 00:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 82ace185017fbbe48342bf7d8a9fd795f9c711cd
Message-ID: <202402240008.SPVGsBEq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git x86/mm
branch HEAD: 82ace185017fbbe48342bf7d8a9fd795f9c711cd  x86/mm/cpa: Warn for set_memory_XXcrypted() VMM fails

elapsed time: 1062m

configs tested: 146
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
arc                   randconfig-001-20240223   gcc  
arc                   randconfig-002-20240223   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240223   gcc  
arm                   randconfig-004-20240223   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           spitz_defconfig   gcc  
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
loongarch             randconfig-001-20240223   gcc  
loongarch             randconfig-002-20240223   gcc  
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
nios2                 randconfig-001-20240223   gcc  
nios2                 randconfig-002-20240223   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240223   gcc  
parisc                randconfig-002-20240223   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
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
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240223   gcc  
sh                    randconfig-002-20240223   gcc  
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
sparc64               randconfig-001-20240223   gcc  
sparc64               randconfig-002-20240223   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-002-20240223   gcc  
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
xtensa                randconfig-001-20240223   gcc  
xtensa                randconfig-002-20240223   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

