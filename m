Return-Path: <linux-kernel+bounces-112087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F6A8875A1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112A9283947
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961B82899;
	Fri, 22 Mar 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NV+lYgoL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DA80629
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149285; cv=none; b=T0RDdRsB5C3gAJzQjQJi1yX3Oy1jO94sabUUADuDpWlecpLW+7lTVKpPjq0Ge75xENqofS7PnBdRWWBVriUy6yIF5+IFdqGt4hOFRVmIKpgNaDeJXlADr4wTOTZQ29A/+ae1Ksvk72RFYFgvjGYu1c7iE1X0mMsqkwynEBmj4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149285; c=relaxed/simple;
	bh=mFt9sTai3iFEvINDiRR7vT0SJxMtiNAwZ8okJHN4jjs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mlGrEyqkW65ncQdk2gU1Fe6Dykbl+XhkWIQaUG1pYZJEIPUbJG0Ny6+jkOO25dE7ThHaXJ5bG+pl8UXELkrf0ER5aoB5W9B8jQCGbV1ajg9WVhTJn0M5UVo5rjjNQ44o8vHPP3i15VthrHhY58Av5nX+6PzWV4NEUHdkqHeDdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NV+lYgoL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149283; x=1742685283;
  h=date:from:to:cc:subject:message-id;
  bh=mFt9sTai3iFEvINDiRR7vT0SJxMtiNAwZ8okJHN4jjs=;
  b=NV+lYgoLDqzaEVoQLXQ3zUEgnWN2av6JzKb59VKhRbHuUNOrkp1vc0XG
   GTUybl9lGHGybojrBqJberB6Mg6rg61e47KrdEzsss/q0IUisleRaPtpx
   ADGA4+GnBI4wnKVhJlENv6/wTUSCufZHzQzNz1J5ykTA6v/jhZKBDq4t8
   m7QS0MB/Kdfux69i9XR+JYWUEDzW0tgjK9O3dI/qITe1Xi4HV872lOqSj
   TpZbebPa3oXpI3u8UAa28E9h4U9+pw6gF/PPt9tdRbSg5ZxZFcyLJ9A7/
   8bBO1sU85qGXIiJY7XNFj5AV48imnRSiFaNtXsQtlJiblmr+4HTkeiIMU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="10005115"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="10005115"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="15156789"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Mar 2024 16:14:41 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rno5u-000Kgp-3B;
	Fri, 22 Mar 2024 23:14:38 +0000
Date: Sat, 23 Mar 2024 07:14:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 4c9a93800121e90484cd07c8e5bde70e31cdb996
Message-ID: <202403230727.Jct62s6Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 4c9a93800121e90484cd07c8e5bde70e31cdb996  x86/asm/64: Clean up memset16(), memset32(), memset64() assembly constraints in <asm/string_64.h>

elapsed time: 734m

configs tested: 101
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
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
i386                                defconfig   clang
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-014-20240323   gcc  
i386                  randconfig-015-20240323   gcc  
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
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             allyesconfig   gcc  
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
um                             i386_defconfig   gcc  
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

