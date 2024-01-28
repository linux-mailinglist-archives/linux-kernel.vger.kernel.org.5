Return-Path: <linux-kernel+bounces-41603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52583F540
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD77E1F21C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774F1F93F;
	Sun, 28 Jan 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmcEyuKW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5F1F61C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706442690; cv=none; b=G7m7l33hwBEGvlSevV9krV2cuIQOZ0OMF9E83+E1yIKS7EqE4+iC7s3AfDp6Pa5ERyNFFdxiBXO09hsY39K6ie4yef/bf+/tmClXO2mcA4BE7EZXJ7R5QmoORHraItEJWiRvt864QJoot4Y5JlYCEez61Rj04tCkBS9QJUmzuQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706442690; c=relaxed/simple;
	bh=wmKj12HLaRGocsXQGjbrLgbmhPiebtcESvtMjDjXCJk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CXokFT2nshR9qzv6wJUwpKjta+BmgC0pkndhukuomrpr/lb6g7vEV/WoyBUs1lno7IgVHYKrC3Gz5DX3CKI/EvFcYqpPaZu0zSrwj9c4RGk18hiXT6wUTFncxMEVK4HOQLhnVMLwN9CZdQPLA0r37746UJ1mgT93IPCqXWTpDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmcEyuKW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706442688; x=1737978688;
  h=date:from:to:cc:subject:message-id;
  bh=wmKj12HLaRGocsXQGjbrLgbmhPiebtcESvtMjDjXCJk=;
  b=hmcEyuKW8d2eRLv20D0wCq7Q68EE6ONOZF8fYGP4QzF3mSLqhr+2j5L+
   iaBA8Hyhhx7w5tt7uHHxlGms+f6X+pzuS2P8zrHQHmekwwxzKnHZfpPVv
   YhmOl/qQl3pByJ7byY8+2gaEGzgFTphaJUOdU5nFW86FyFv4EC4kGLlvn
   EDPXVJwb1NN6EBILt06Z4R/wg7JRmDs3qsRzniS00YPH7qHdqEs4C5tqV
   hfdPT60Ce8LXukqm7AF7vfo6kpHx3VxCy8YK0ZELzBE4oxU8ZVH+bakam
   UbeOKT6fZTfdoRg0K6fcE2BuZ3JdzoS/HHnPTHXiHNchEV2HT0qaZ7rUi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="21297441"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21297441"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 03:51:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35874318"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Jan 2024 03:51:27 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU3h5-0003MY-2j;
	Sun, 28 Jan 2024 11:51:23 +0000
Date: Sun, 28 Jan 2024 19:51:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 aa8eff72842021f52600392b245fb82d113afa8a
Message-ID: <202401281904.VYRCnTZB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: aa8eff72842021f52600392b245fb82d113afa8a  x86/sme: Fix memory encryption setting if enabled by default and not overridden

elapsed time: 1459m

configs tested: 166
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20240127   clang
i386                  randconfig-011-20240128   gcc  
i386                  randconfig-012-20240127   clang
i386                  randconfig-012-20240128   gcc  
i386                  randconfig-013-20240127   clang
i386                  randconfig-013-20240128   gcc  
i386                  randconfig-014-20240127   clang
i386                  randconfig-014-20240128   gcc  
i386                  randconfig-015-20240127   clang
i386                  randconfig-015-20240128   gcc  
i386                  randconfig-016-20240127   clang
i386                  randconfig-016-20240128   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240128   gcc  
loongarch             randconfig-002-20240128   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240128   gcc  
nios2                 randconfig-002-20240128   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240128   gcc  
parisc                randconfig-002-20240128   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240128   gcc  
s390                  randconfig-002-20240128   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240128   gcc  
sh                    randconfig-002-20240128   gcc  
sh                           se7705_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240128   gcc  
sparc64               randconfig-002-20240128   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240127   gcc  
x86_64       buildonly-randconfig-001-20240128   clang
x86_64       buildonly-randconfig-002-20240127   gcc  
x86_64       buildonly-randconfig-002-20240128   clang
x86_64       buildonly-randconfig-003-20240127   gcc  
x86_64       buildonly-randconfig-003-20240128   clang
x86_64       buildonly-randconfig-004-20240127   gcc  
x86_64       buildonly-randconfig-004-20240128   clang
x86_64       buildonly-randconfig-005-20240127   gcc  
x86_64       buildonly-randconfig-005-20240128   clang
x86_64       buildonly-randconfig-006-20240127   gcc  
x86_64       buildonly-randconfig-006-20240128   clang
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240127   gcc  
x86_64                randconfig-011-20240128   clang
x86_64                randconfig-012-20240127   gcc  
x86_64                randconfig-012-20240128   clang
x86_64                randconfig-013-20240127   gcc  
x86_64                randconfig-013-20240128   clang
x86_64                randconfig-014-20240127   gcc  
x86_64                randconfig-014-20240128   clang
x86_64                randconfig-015-20240127   gcc  
x86_64                randconfig-015-20240128   clang
x86_64                randconfig-016-20240127   gcc  
x86_64                randconfig-016-20240128   clang
x86_64                randconfig-071-20240127   gcc  
x86_64                randconfig-071-20240128   clang
x86_64                randconfig-072-20240127   gcc  
x86_64                randconfig-072-20240128   clang
x86_64                randconfig-073-20240127   gcc  
x86_64                randconfig-073-20240128   clang
x86_64                randconfig-074-20240127   gcc  
x86_64                randconfig-074-20240128   clang
x86_64                randconfig-075-20240127   gcc  
x86_64                randconfig-075-20240128   clang
x86_64                randconfig-076-20240127   gcc  
x86_64                randconfig-076-20240128   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240128   gcc  
xtensa                randconfig-002-20240128   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

