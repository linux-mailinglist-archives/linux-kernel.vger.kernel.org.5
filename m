Return-Path: <linux-kernel+bounces-43614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7E8416AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7D91F23BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417E524BB;
	Mon, 29 Jan 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1Mt2lVs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BB54276
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570241; cv=none; b=p7ZspZbfUiNmnp2pFpfsmrtb1M5G01FhqNv+tfhgzTF66pk5IJHsWw8fDjG9eJQXgnmXpSdRc7fZdakNdLd8jTae7AA3+6sJIfTX/+zcDaGE2SxkPRV4Ji2gUcdYmnu8ZgBXAd6nBIbOU7jK0CauHT/q9Pa64pNCRUX/o5K7UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570241; c=relaxed/simple;
	bh=W6teJrmm0mc2NEcdPS+oBHWUTG9nA4QmwudsC9v6mXc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BQORaF/AQIyaY+l8AdajRPFWJyq22b2dGY2asBNrMYHHH3Sx8rCjuPutSzM2dzO+68HUUFT1UxnZY58jEZC2Wogr4BYsNtNKtQDE79Gpoeu6EGpXMmeShieAw+F+VLf1fJ1GyEvSnL9CL5MKRSkGSinTltaKmNIHivijxajK2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1Mt2lVs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706570240; x=1738106240;
  h=date:from:to:cc:subject:message-id;
  bh=W6teJrmm0mc2NEcdPS+oBHWUTG9nA4QmwudsC9v6mXc=;
  b=M1Mt2lVssTIwQNbznBiMB+QMUMDKbDPeQsIhTjthTFssTMYvCx5AVfkm
   uRfZsH1jxtpFGDa9oShA2IBmZloacAuqsNTrXGr6RhzjdZbArabzo6z8y
   N+dg2JTy/UVcdJ3WpkVkjvjfBqx3HfILvHActwRGNyYJXA7gbS06Ec2/G
   GsN8IwtlxHMURqz3e0mQ+TgMxCYoWigh4KhtLpOu97P3/VcgwGhE0oILZ
   7gIuXlZgNdpCtJ75FayMHGvpkLZZSzSiu42cC4iA9xvziwgYtOuBuvpLl
   hnYJYQ7qBFiR85tK+y4qNwz+o0tT+vuq+QEa9N+NNqv3pXG1R3x7IZVfo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942886"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942886"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 15:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="36300792"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 29 Jan 2024 15:17:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUasN-0004hc-0k;
	Mon, 29 Jan 2024 23:17:15 +0000
Date: Tue, 30 Jan 2024 07:16:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 8eed4e00a370b37b4e5985ed983dccedd555ea9d
Message-ID: <202401300754.knVWJARw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 8eed4e00a370b37b4e5985ed983dccedd555ea9d  x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

elapsed time: 725m

configs tested: 201
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
arc                   randconfig-001-20240130   gcc  
arc                   randconfig-002-20240130   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20240130   gcc  
arm                   randconfig-002-20240130   gcc  
arm                   randconfig-003-20240130   gcc  
arm                   randconfig-004-20240130   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240130   gcc  
arm64                 randconfig-002-20240130   gcc  
arm64                 randconfig-003-20240130   gcc  
arm64                 randconfig-004-20240130   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240130   gcc  
csky                  randconfig-002-20240130   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240129   gcc  
i386         buildonly-randconfig-002-20240129   gcc  
i386         buildonly-randconfig-003-20240129   gcc  
i386         buildonly-randconfig-004-20240129   gcc  
i386         buildonly-randconfig-005-20240129   gcc  
i386         buildonly-randconfig-006-20240129   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240129   gcc  
i386                  randconfig-002-20240129   gcc  
i386                  randconfig-003-20240129   gcc  
i386                  randconfig-004-20240129   gcc  
i386                  randconfig-005-20240129   gcc  
i386                  randconfig-006-20240129   gcc  
i386                  randconfig-011-20240129   clang
i386                  randconfig-012-20240129   clang
i386                  randconfig-013-20240129   clang
i386                  randconfig-014-20240129   clang
i386                  randconfig-015-20240129   clang
i386                  randconfig-016-20240129   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240130   gcc  
loongarch             randconfig-002-20240130   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                          rm200_defconfig   gcc  
mips                         rt305x_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240130   gcc  
nios2                 randconfig-002-20240130   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240130   gcc  
parisc                randconfig-002-20240130   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc               randconfig-001-20240130   gcc  
powerpc               randconfig-002-20240130   gcc  
powerpc               randconfig-003-20240130   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240130   gcc  
powerpc64             randconfig-002-20240130   gcc  
powerpc64             randconfig-003-20240130   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240130   gcc  
riscv                 randconfig-002-20240130   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                       zfcpdump_defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240130   gcc  
sh                    randconfig-002-20240130   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240130   gcc  
sparc64               randconfig-002-20240130   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240130   gcc  
um                    randconfig-002-20240130   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240129   gcc  
x86_64       buildonly-randconfig-001-20240130   gcc  
x86_64       buildonly-randconfig-002-20240129   gcc  
x86_64       buildonly-randconfig-002-20240130   gcc  
x86_64       buildonly-randconfig-003-20240129   gcc  
x86_64       buildonly-randconfig-003-20240130   gcc  
x86_64       buildonly-randconfig-004-20240129   gcc  
x86_64       buildonly-randconfig-004-20240130   gcc  
x86_64       buildonly-randconfig-005-20240129   gcc  
x86_64       buildonly-randconfig-005-20240130   gcc  
x86_64       buildonly-randconfig-006-20240129   gcc  
x86_64       buildonly-randconfig-006-20240130   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240129   clang
x86_64                randconfig-002-20240129   clang
x86_64                randconfig-003-20240129   clang
x86_64                randconfig-004-20240129   clang
x86_64                randconfig-005-20240129   clang
x86_64                randconfig-006-20240129   clang
x86_64                randconfig-011-20240129   gcc  
x86_64                randconfig-011-20240130   gcc  
x86_64                randconfig-012-20240129   gcc  
x86_64                randconfig-012-20240130   gcc  
x86_64                randconfig-013-20240129   gcc  
x86_64                randconfig-013-20240130   gcc  
x86_64                randconfig-014-20240129   gcc  
x86_64                randconfig-014-20240130   gcc  
x86_64                randconfig-015-20240129   gcc  
x86_64                randconfig-015-20240130   gcc  
x86_64                randconfig-016-20240129   gcc  
x86_64                randconfig-016-20240130   gcc  
x86_64                randconfig-071-20240129   gcc  
x86_64                randconfig-071-20240130   gcc  
x86_64                randconfig-072-20240129   gcc  
x86_64                randconfig-072-20240130   gcc  
x86_64                randconfig-073-20240129   gcc  
x86_64                randconfig-073-20240130   gcc  
x86_64                randconfig-074-20240129   gcc  
x86_64                randconfig-074-20240130   gcc  
x86_64                randconfig-075-20240129   gcc  
x86_64                randconfig-075-20240130   gcc  
x86_64                randconfig-076-20240129   gcc  
x86_64                randconfig-076-20240130   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240130   gcc  
xtensa                randconfig-002-20240130   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

