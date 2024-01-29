Return-Path: <linux-kernel+bounces-43655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14F841739
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF341C23806
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD19524BB;
	Mon, 29 Jan 2024 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIZ4rm4K"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE754667
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572762; cv=none; b=OQfCLfMBJ8pRJrYZqAYYO+h1Y46XRK1ZqZv6ufa5tw+PFv4bJ4SDrU0eOd26OG8KCwbM6PHxxceyw0Fe8+/+/Uz2cyls15P3KqfMiMAEoFJ4W4m/9rUN3JZd9ZtPfEwpDfKKW+QL6JSfNwa2TcIQodo3AZ73tu45CM+/yzY+t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572762; c=relaxed/simple;
	bh=gbDIUPc5oko5Y+hrRmZmpluksDCNpCN7m3cdmIpDos0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cjGkDMi0SlRXB7VIfRHdIWo7gfX8mpyX5XCQwoDRmixDaC+wFZNHvbnvMKChGOLb1LnAiYRZ7ThviT2XGKZ8ULek8k3sICeTj4xMvV+cZPeKmEbl8vEqYDnercX3AgSS9tXjwnCoWyLkxI2kW2L03wHefZIROpzA68V8SGjSDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIZ4rm4K; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706572761; x=1738108761;
  h=date:from:to:cc:subject:message-id;
  bh=gbDIUPc5oko5Y+hrRmZmpluksDCNpCN7m3cdmIpDos0=;
  b=bIZ4rm4KPc0d5do9rvutQo2RsTAHGfkzRVH05264Fdk2v4vDIXq/WQ2H
   qEFz3w7W3pKPpiXeGBhe3US24pHm0ZaoYLa7rkEre95JbCk5oUuMnOSbR
   EKHnL940QzyXypLr5w865tbdI4OJuTwqcAX+YDpzBPPwsszz/ryodqR5Q
   r3mDkk2v2yl3EL87HKrpLOb+DK/BAX7twELvPKxahAlye1qYVAu7CR4R5
   NDSgDmkkcb49G1rfLGGBbi9XKi7qUolMpVQR/8syG9iZ6re84xWUio7hI
   CLXeS2m+XFgR7zyRTEYS4l9ELOSHLYIIgkYajbKZ9hmxjHb2s52gwcCKk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="406838725"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="406838725"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 15:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3457831"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Jan 2024 15:59:18 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUbX2-0004jC-19;
	Mon, 29 Jan 2024 23:59:16 +0000
Date: Tue, 30 Jan 2024 07:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 07f51d1555abadee5ccf911c4588324582bf6c18
Message-ID: <202401300743.cvNTWGNs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 07f51d1555abadee5ccf911c4588324582bf6c18  Merge branch into tip/master: 'x86/sev'

elapsed time: 828m

configs tested: 178
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
arc                   randconfig-001-20240130   gcc  
arc                   randconfig-002-20240130   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                        neponset_defconfig   clang
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
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240130   clang
hexagon               randconfig-002-20240130   clang
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
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240130   gcc  
nios2                 randconfig-002-20240130   gcc  
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
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240130   gcc  
powerpc               randconfig-002-20240130   gcc  
powerpc               randconfig-003-20240130   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240130   gcc  
powerpc64             randconfig-002-20240130   gcc  
powerpc64             randconfig-003-20240130   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240130   gcc  
riscv                 randconfig-002-20240130   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240130   clang
s390                  randconfig-002-20240130   clang
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
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240130   gcc  
sparc64               randconfig-002-20240130   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240130   gcc  
um                    randconfig-002-20240130   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240129   gcc  
x86_64       buildonly-randconfig-002-20240129   gcc  
x86_64       buildonly-randconfig-003-20240129   gcc  
x86_64       buildonly-randconfig-004-20240129   gcc  
x86_64       buildonly-randconfig-005-20240129   gcc  
x86_64       buildonly-randconfig-006-20240129   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240129   clang
x86_64                randconfig-002-20240129   clang
x86_64                randconfig-003-20240129   clang
x86_64                randconfig-004-20240129   clang
x86_64                randconfig-005-20240129   clang
x86_64                randconfig-006-20240129   clang
x86_64                randconfig-011-20240129   gcc  
x86_64                randconfig-012-20240129   gcc  
x86_64                randconfig-013-20240129   gcc  
x86_64                randconfig-014-20240129   gcc  
x86_64                randconfig-015-20240129   gcc  
x86_64                randconfig-016-20240129   gcc  
x86_64                randconfig-071-20240129   gcc  
x86_64                randconfig-072-20240129   gcc  
x86_64                randconfig-073-20240129   gcc  
x86_64                randconfig-074-20240129   gcc  
x86_64                randconfig-075-20240129   gcc  
x86_64                randconfig-076-20240129   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240130   gcc  
xtensa                randconfig-002-20240130   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

