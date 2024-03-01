Return-Path: <linux-kernel+bounces-88837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041B86E75A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353DE1C240E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71B381D9;
	Fri,  1 Mar 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX+vtYS5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615B848E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314332; cv=none; b=Eedr8pKAOhGxeFeV/Q8yRnHAxV6DWsT0YkgqITigUAp7q9aOCBaWyNCOeaxFNthJCElQTRSdFrg+wsToQKK7GHheewtk5VEnilBuY+TRB8oysF6Y1NTWI82CF9vF0/1VKmnolq10Y8iGlRYXap+MZqiqnJ9NIKT5aGhBadHSv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314332; c=relaxed/simple;
	bh=jBebuAM7MTN0IvFU0ynJehpaFTr/gem9EsTMn+pXQFI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I/mHVw7QmOYQaIDfX9dWo7LXyDQqMF53NxICRAQGE0TJfXeG1uYLJxfmuRboRPWiv8ViZWi8MAUxD0it5ftXPjXXNM0Hv6xrBuLOJn+lp36qxXEwNOwwQoAhpq4+SBKkjb+fUhWgFoL/nTECeX4Bojx3FpnmgcUMAHsF8qe0AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX+vtYS5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314329; x=1740850329;
  h=date:from:to:cc:subject:message-id;
  bh=jBebuAM7MTN0IvFU0ynJehpaFTr/gem9EsTMn+pXQFI=;
  b=kX+vtYS5dkxJUkQOA+el6eWlm4SsprJUOlXs+oTcu3ylaqRwj6qYKsoh
   ioT6q0GdpyWMaqsP5qCHDEwW4znKmIaTXxpjKoz57HtVtZBJkumLZOAZ3
   IK09rUxAmi1XJNWEWflLXakZd0+8A95fntp1ExGarFd2bi6pMWt6PGyQp
   3cWpFOpQjJJ54pPh32cRSh9ygobWIfZ676mj/dHlgSmuMOdOkcQW0P18I
   Qv/OVakQVz75kIrtK27tw4330Y6hwpDii/BH9LpDtL2GIZB45UWZq7sKM
   Ap0zs2h+gIdVcYO5jwgF5po4HGJNvI+5yWlTt61Tfk0Tuh2BnnIOwMbPg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7681653"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7681653"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39106287"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Mar 2024 09:32:08 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg6jt-000E0b-2g;
	Fri, 01 Mar 2024 17:32:05 +0000
Date: Sat, 02 Mar 2024 01:30:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240229] BUILD SUCCESS
 94c8b1ae352725e95b0e1fa55b6fb5c4b36f0499
Message-ID: <202403020145.zzwCKgOR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240229
branch HEAD: 94c8b1ae352725e95b0e1fa55b6fb5c4b36f0499  RDMA/uverbs: Avoid -Wflex-array-member-not-at-end warning

elapsed time: 727m

configs tested: 151
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
arc                   randconfig-001-20240301   gcc  
arc                   randconfig-002-20240301   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240301   gcc  
arm                   randconfig-002-20240301   clang
arm                   randconfig-003-20240301   gcc  
arm                   randconfig-004-20240301   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240301   gcc  
arm64                 randconfig-002-20240301   clang
arm64                 randconfig-003-20240301   gcc  
arm64                 randconfig-004-20240301   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240301   gcc  
csky                  randconfig-002-20240301   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240301   clang
hexagon               randconfig-002-20240301   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240301   clang
i386         buildonly-randconfig-002-20240301   clang
i386         buildonly-randconfig-003-20240301   gcc  
i386         buildonly-randconfig-004-20240301   clang
i386         buildonly-randconfig-005-20240301   clang
i386         buildonly-randconfig-006-20240301   clang
i386                                defconfig   clang
i386                  randconfig-001-20240301   clang
i386                  randconfig-002-20240301   clang
i386                  randconfig-003-20240301   clang
i386                  randconfig-004-20240301   clang
i386                  randconfig-005-20240301   gcc  
i386                  randconfig-006-20240301   gcc  
i386                  randconfig-011-20240301   gcc  
i386                  randconfig-012-20240301   clang
i386                  randconfig-013-20240301   clang
i386                  randconfig-014-20240301   gcc  
i386                  randconfig-015-20240301   gcc  
i386                  randconfig-016-20240301   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240301   gcc  
loongarch             randconfig-002-20240301   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240301   gcc  
nios2                 randconfig-002-20240301   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240301   gcc  
parisc                randconfig-002-20240301   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240301   gcc  
powerpc               randconfig-002-20240301   gcc  
powerpc               randconfig-003-20240301   clang
powerpc64             randconfig-001-20240301   clang
powerpc64             randconfig-002-20240301   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240301   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20240301   clang
x86_64       buildonly-randconfig-002-20240301   gcc  
x86_64       buildonly-randconfig-003-20240301   clang
x86_64       buildonly-randconfig-004-20240301   gcc  
x86_64       buildonly-randconfig-005-20240301   clang
x86_64       buildonly-randconfig-006-20240301   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240301   gcc  
x86_64                randconfig-002-20240301   clang
x86_64                randconfig-003-20240301   clang
x86_64                randconfig-004-20240301   clang
x86_64                randconfig-005-20240301   gcc  
x86_64                randconfig-006-20240301   gcc  
x86_64                randconfig-011-20240301   clang
x86_64                randconfig-012-20240301   clang
x86_64                randconfig-013-20240301   clang
x86_64                randconfig-014-20240301   gcc  
x86_64                randconfig-015-20240301   clang
x86_64                randconfig-016-20240301   gcc  
x86_64                randconfig-071-20240301   gcc  
x86_64                randconfig-072-20240301   clang
x86_64                randconfig-073-20240301   gcc  
x86_64                randconfig-074-20240301   gcc  
x86_64                randconfig-075-20240301   gcc  
x86_64                randconfig-076-20240301   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

