Return-Path: <linux-kernel+bounces-109550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404F881ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50F61F216A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98573187F;
	Thu, 21 Mar 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZtG1rk8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05979F0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985833; cv=none; b=csb9NYrNAJrtqoNP44zyH2gi0db8vRMuCpwBRlXNDimR1qQ6pxOLqUyVjTyYbswmijYP+Tk9szUfejxMgBOXEr1+pzA6pq99hA6bgbgXwf/fLtYPOelpGfa2SknzM+IKY5NR3cmOnAaEnnrnexU4YmKjbtQHCSk6kCiw2uq7Ok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985833; c=relaxed/simple;
	bh=Ify3JB9EiCvpobMYjGD+B4BJzZVL5gLo7wB87X7Vv6I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GWS8CE6UjHB5FgJ7OQ+8DrCC7MwHE6aYCx/cKTDzbwM1VRYvEUPJiup2R2dqfj+88udJ2Y+kaPCze9yMV3lx8Heyrms8SUZZIb76ylpg4+TS68LTUmJHv7QhIENNdJxrFBErDm+erPKXG8S0cBy+8uNXIX7ZH9or1XlUI0QzFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZtG1rk8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710985831; x=1742521831;
  h=date:from:to:cc:subject:message-id;
  bh=Ify3JB9EiCvpobMYjGD+B4BJzZVL5gLo7wB87X7Vv6I=;
  b=DZtG1rk8c/+BjaL+NBTmNAHlkTMGiFE2DY1MbcEbGKUjwLcWNpU+aJ9L
   z2en4S0+F9JwWN1syn097SVmEp9IIYx38Rh1iANO8gitZl0jl0pcPifkC
   ansNqD/+XCWqQxK/uTAMmZ/KpoFdGVrVUOqoz7I3O0YYhU7tUtsqCDroq
   YQzXqqBMQ3k1tm+baQBkHu0N3tIHgxSHHxj1VZHK7ia+0RsRGXfQra5eR
   jc2GKDhNTp1bbS35ZQy1mUqtniULNSppS1nTn3SNydAX4260BrNP2jDub
   iEXKnjBEyOMveRv/vkh9PWnBErsWlkPpkSUKHGMpwcrUlV4LjFa12dxuB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16589192"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="16589192"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 18:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="18917219"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Mar 2024 18:50:29 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn7Zb-000J59-2F;
	Thu, 21 Mar 2024 01:50:27 +0000
Date: Thu, 21 Mar 2024 09:49:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e1826833c3a9abb9d1fe4b938eca0e25eeafb39f
Message-ID: <202403210930.YW4BRuvF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e1826833c3a9abb9d1fe4b938eca0e25eeafb39f  Merge branch into tip/master: 'x86/percpu'

elapsed time: 735m

configs tested: 146
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
arc                   randconfig-001-20240320   gcc  
arc                   randconfig-002-20240320   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                         orion5x_defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240320   gcc  
arm                   randconfig-002-20240320   gcc  
arm                   randconfig-003-20240320   gcc  
arm                   randconfig-004-20240320   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240320   clang
arm64                 randconfig-002-20240320   gcc  
arm64                 randconfig-003-20240320   clang
arm64                 randconfig-004-20240320   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240320   gcc  
csky                  randconfig-002-20240320   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240320   clang
hexagon               randconfig-002-20240320   clang
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
i386                  randconfig-005-20240320   clang
i386                  randconfig-006-20240320   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240320   gcc  
loongarch             randconfig-002-20240320   gcc  
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
mips                           ci20_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240320   gcc  
nios2                 randconfig-002-20240320   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240320   gcc  
parisc                randconfig-002-20240320   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20240320   gcc  
powerpc               randconfig-002-20240320   clang
powerpc               randconfig-003-20240320   gcc  
powerpc64             randconfig-001-20240320   gcc  
powerpc64             randconfig-002-20240320   gcc  
powerpc64             randconfig-003-20240320   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240320   clang
riscv                 randconfig-002-20240320   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240320   clang
s390                  randconfig-002-20240320   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240320   gcc  
sh                    randconfig-002-20240320   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240320   gcc  
sparc64               randconfig-002-20240320   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240320   gcc  
um                    randconfig-002-20240320   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

