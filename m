Return-Path: <linux-kernel+bounces-62883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A29852774
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0F21C2328A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B744690;
	Tue, 13 Feb 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AisV+v+u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B52F2F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790633; cv=none; b=qcOiBmiyTwR7oD0oPzbRhCPyeIU5XUtWRB4HkSnG85mkk+ppF/8LJaFjPd5InCbkU8C1aP8KyE2lOoVKLbJ1U5Tmk1SsvbnXIqT7bh7udAJvrFenKLgLR4u6rbRp07BBvjhivTvPCOVuwZpvNB/8/PbfRq1MiK5Y+SPhqXFcELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790633; c=relaxed/simple;
	bh=Oqodr/SM9/+QkNEIwKcYxcTAJF63ndUgPl59SuueMPw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a3mK0VfwBQQwpLgrq2sjyB+IBEQdABAUJO6DpkaCDTKVoyetVgAgHqVmuW2AYwU27Zv1sxPsxmIpQHYo5sDyEsQDTqoJ7pQrwVBfe1XQ2TGVrCz6zW9XUDMvfqhKQ2zmBJDEH+7SIJNIENk7rVHoGH69ehhP2GQg6hib3dwGtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AisV+v+u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707790631; x=1739326631;
  h=date:from:to:cc:subject:message-id;
  bh=Oqodr/SM9/+QkNEIwKcYxcTAJF63ndUgPl59SuueMPw=;
  b=AisV+v+uQVSoyUNTWrIvXeVVj3eQ+Maxn8mrg9dSb0J6QdWgJT/RMABN
   qq50dtwRa3Gl6O00TH3ZOarMFV0HPmfIEIHVieMgocAF/x5C0p3nElfuB
   6Z7XBFEaXnlUo3VIW/1xfeXj5+mUZWQI/OUYCZheBjjx89GJz+XEtp6jg
   1CG4gUlTUGruOpu3IigXIcESxpdTAgN7xd5gL4NAdwZqtaN7FAte2CiTB
   OoBLvcNJ5TuRKhtGigIP1eegkM9E1MmxRE/nAIPBayChNXWC4C5kVxFLo
   tDE0peN7pja+FyZFC0IMsuKRvje/pvSv18oZgeq98+0PpJnMXdCfqzQRt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1669192"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1669192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 18:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2721036"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Feb 2024 18:17:09 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZiM7-0007Ss-1a;
	Tue, 13 Feb 2024 02:17:07 +0000
Date: Tue, 13 Feb 2024 10:17:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 4461438a8405e800f90e0e40409e5f3d07eed381
Message-ID: <202402131005.eowQKg71-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 4461438a8405e800f90e0e40409e5f3d07eed381  x86/retpoline: Ensure default return thunk isn't used at runtime

elapsed time: 721m

configs tested: 134
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240213   gcc  
arc                   randconfig-002-20240213   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240213   gcc  
arm                   randconfig-002-20240213   gcc  
arm                   randconfig-003-20240213   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240213   gcc  
arm64                 randconfig-002-20240213   gcc  
arm64                 randconfig-003-20240213   gcc  
arm64                 randconfig-004-20240213   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240213   gcc  
csky                  randconfig-002-20240213   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240213   clang
i386         buildonly-randconfig-002-20240213   gcc  
i386         buildonly-randconfig-003-20240213   gcc  
i386         buildonly-randconfig-004-20240213   clang
i386         buildonly-randconfig-005-20240213   gcc  
i386         buildonly-randconfig-006-20240213   clang
i386                                defconfig   clang
i386                  randconfig-001-20240213   clang
i386                  randconfig-002-20240213   gcc  
i386                  randconfig-003-20240213   gcc  
i386                  randconfig-004-20240213   clang
i386                  randconfig-005-20240213   gcc  
i386                  randconfig-006-20240213   gcc  
i386                  randconfig-011-20240213   clang
i386                  randconfig-012-20240213   gcc  
i386                  randconfig-013-20240213   gcc  
i386                  randconfig-014-20240213   gcc  
i386                  randconfig-015-20240213   gcc  
i386                  randconfig-016-20240213   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240213   gcc  
loongarch             randconfig-002-20240213   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240213   gcc  
nios2                 randconfig-002-20240213   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240213   gcc  
parisc                randconfig-002-20240213   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-002-20240213   gcc  
powerpc               randconfig-003-20240213   gcc  
powerpc64             randconfig-001-20240213   gcc  
powerpc64             randconfig-002-20240213   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                 randconfig-001-20240213   gcc  
riscv                 randconfig-002-20240213   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240213   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240213   gcc  
sh                    randconfig-002-20240213   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240213   gcc  
sparc64               randconfig-002-20240213   gcc  
um                               allmodconfig   clang
um                    randconfig-002-20240213   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240213   clang
x86_64       buildonly-randconfig-002-20240213   gcc  
x86_64       buildonly-randconfig-003-20240213   clang
x86_64       buildonly-randconfig-004-20240213   gcc  
x86_64       buildonly-randconfig-005-20240213   gcc  
x86_64       buildonly-randconfig-006-20240213   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240213   gcc  
x86_64                randconfig-002-20240213   clang
x86_64                randconfig-003-20240213   clang
x86_64                randconfig-004-20240213   gcc  
x86_64                randconfig-005-20240213   clang
x86_64                randconfig-006-20240213   clang
x86_64                randconfig-011-20240213   clang
x86_64                randconfig-012-20240213   clang
x86_64                randconfig-013-20240213   clang
x86_64                randconfig-014-20240213   gcc  
x86_64                randconfig-015-20240213   clang
x86_64                randconfig-016-20240213   clang
x86_64                randconfig-071-20240213   gcc  
x86_64                randconfig-072-20240213   gcc  
x86_64                randconfig-073-20240213   clang
x86_64                randconfig-074-20240213   gcc  
x86_64                randconfig-075-20240213   gcc  
x86_64                randconfig-076-20240213   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240213   gcc  
xtensa                randconfig-002-20240213   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

