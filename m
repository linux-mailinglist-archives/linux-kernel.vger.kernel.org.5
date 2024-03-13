Return-Path: <linux-kernel+bounces-102607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD287B482
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25746B21050
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465365D8F6;
	Wed, 13 Mar 2024 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENgY7dSm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE35D8E0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369790; cv=none; b=bmwLGmmlDdzhoanPaBzFHWaDq3b81DRlkuFcd6WMyS3GqF6NHnfnVxJ3tLtudnpIKLDXgWQoN34UYZLQO7WUT4c6Ug/JGHmEBCZonzNB8NeEGG6kV2sxUeLNoTLYb4IsLdsnmcPKHsnNxKczFbA/yDebh+jlt0tGhbOOG3zkhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369790; c=relaxed/simple;
	bh=cJpYXX9V8XXGORIp/zIlv93t0xJpH4qgugJSUgJxIfw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lt1BeLQGAgFpm6hDysh9B+BjnhBO/MZ3BBJPCpBOq3VcPQEUCDq6E02P8U4J76OUQqBcetL2qr+eSJd0xpHfQ6r3C2F2l+tVWt/qBkcr8pRXLTmy/mvEIn9BQmFFSn2fLJ6phwTOjni/qwpxpvTuikCyn8mlsKvqFYaSTLvmG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENgY7dSm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710369788; x=1741905788;
  h=date:from:to:cc:subject:message-id;
  bh=cJpYXX9V8XXGORIp/zIlv93t0xJpH4qgugJSUgJxIfw=;
  b=ENgY7dSmFnH3femWUd2qNYgt4wkw9wv0MYD7ag5FjUL2AiowTYAFIX0h
   EPenjc+dzjAw6cKiC2RLnMF+4rGHW7MZ+WFnbCm5UJ1d5RnL1IopSyCCs
   RjwIOddw4rJvlSM3DZdOzGaNvryAqUah9l0tNPwgQZNyIiTS3NKGkl2ty
   fMYjzuJ9G8KIYkemUOA8TSODY/ctydmW+HHhSPX6rqtrv/VKwCP4xF83c
   eodpexyrJFnTBKcbsxxdspZccAzQ13tKdWwVN2ZQLYqXg3SWlHGn9B3M4
   3avZfKfe0xDa3vZy9tBADnN4RORir8fgECcYdhX4luYMsfv+HfiTnsX2a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16616869"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="16616869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 15:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="11974865"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2024 15:43:06 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkXJP-000Cpn-2t;
	Wed, 13 Mar 2024 22:43:03 +0000
Date: Thu, 14 Mar 2024 06:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 ad8c91282c95f801c37812d59d2d9eba6899b384
Message-ID: <202403140652.5k7PLBVK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: ad8c91282c95f801c37812d59d2d9eba6899b384  perf/x86/amd/core: Avoid register reset when CPU is dead

elapsed time: 722m

configs tested: 91
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                              allmodconfig   gcc  
arc                              allyesconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-002-20240314   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-004-20240314   clang
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-011-20240314   clang
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240313   gcc  
i386                  randconfig-016-20240314   clang
loongarch                        allmodconfig   gcc  
loongarch                        allyesconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
openrisc                         allmodconfig   gcc  
powerpc                      bamboo_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                        dreamcast_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240314   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240314   gcc  
x86_64                randconfig-002-20240314   gcc  
x86_64                randconfig-012-20240314   gcc  
x86_64                randconfig-013-20240314   gcc  
x86_64                randconfig-014-20240314   gcc  
x86_64                randconfig-016-20240314   gcc  
x86_64                randconfig-071-20240314   gcc  
x86_64                randconfig-074-20240314   gcc  
x86_64                randconfig-075-20240314   gcc  
x86_64                randconfig-076-20240314   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

