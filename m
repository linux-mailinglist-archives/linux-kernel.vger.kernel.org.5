Return-Path: <linux-kernel+bounces-69660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A776858CED
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EF91F2326D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797191B7EA;
	Sat, 17 Feb 2024 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDTCI+eu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB018AF6
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708135353; cv=none; b=YrjNwpaE2XMxrfWe4SGwqpMUTIr4VmmEK9zDStlKf30aJORklUPsTl8n+cAe1vFvrE8nZlm8TSRGxz9UlWyg0D4wNGyP30iltBMk+3+Le9jXvFfBkwYpFJw40HOAHIlOM9ZfIPtaUkPXgxe2ng2k9wau62Opl3EF8TtwU8zn6SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708135353; c=relaxed/simple;
	bh=6m3nmNT9VIiU5z38TY2SR1N1XIg/6P2hZWXY89MbczI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EWX08L/aEQSxNBVFSECT5IuQg6jvruFt4XY2VhzK2t+Q8RtW52M79RIb0trAlQSQhY55+J4LLwObsqeNdE71J0G9Rn++eZyeWudXAcXFNFBDxYptWLu2k1q5P+2iaybq/QvzOaAE/PaPWM6/bIOom3moL0Pzh9yT6Ghhjz1jZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDTCI+eu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708135352; x=1739671352;
  h=date:from:to:cc:subject:message-id;
  bh=6m3nmNT9VIiU5z38TY2SR1N1XIg/6P2hZWXY89MbczI=;
  b=GDTCI+euGzl6v4LvVzff0X2sIsNajLi/o9udlN4CN0c4T2YrTFkK/3s0
   kq1uVeCJHUhznHBGZ4U9pyNpe9rAt3cZGAzFuXVWLUIfDvKVoe/SxZBrd
   dvAeh8CtfGbXSdZZQb4NjpaRdBBzbU30slo1sEfA7EXQphoSqvfGSPH5K
   v4C07CjV7Js3uZ5JY5XbtHkHNnfj0a/bNHQKMAkD/kTuWwDZYJruHZP00
   msr2bZOFxysnyC1WhKwPbl0shL0xraEOF1a9rhlXHGx0oDSGGfXJlm04n
   6UHZlpM5Xs6o6LC9ce3Tt1rTThEZCqrryM2ZprTl0D8qb/MLZQ2RbvbEx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12833705"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12833705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 18:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="912466739"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="912466739"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2024 18:02:29 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbA26-0001km-1y;
	Sat, 17 Feb 2024 02:02:26 +0000
Date: Sat, 17 Feb 2024 10:02:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 03ceaf678d444e67fb9c1a372458ba869aa37a60
Message-ID: <202402171016.uVxzBXq9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 03ceaf678d444e67fb9c1a372458ba869aa37a60  x86/CPU/AMD: Do the common init on future Zens too

elapsed time: 794m

configs tested: 94
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-001-20240217   gcc  
i386         buildonly-randconfig-002-20240216   clang
i386         buildonly-randconfig-003-20240216   clang
i386         buildonly-randconfig-003-20240217   gcc  
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-004-20240217   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386         buildonly-randconfig-005-20240217   gcc  
i386         buildonly-randconfig-006-20240216   clang
i386                                defconfig   clang
i386                  randconfig-001-20240216   clang
i386                  randconfig-001-20240217   gcc  
i386                  randconfig-002-20240216   clang
i386                  randconfig-002-20240217   gcc  
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-004-20240216   clang
i386                  randconfig-004-20240217   gcc  
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-005-20240217   gcc  
i386                  randconfig-006-20240216   clang
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-011-20240217   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-012-20240217   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-014-20240216   clang
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-016-20240216   gcc  
i386                  randconfig-016-20240217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                           virt_defconfig   gcc  
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
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     kmeter1_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

