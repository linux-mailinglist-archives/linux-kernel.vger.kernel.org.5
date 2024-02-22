Return-Path: <linux-kernel+bounces-76852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A26085FD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F24281D82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A114F9FE;
	Thu, 22 Feb 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U8G2O58l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3C14F9FD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618045; cv=none; b=oAWRVQg6cO8B1fTZ3Ffhw1HZ39R7uJrG8L5OlUDZgx8rngxjalRv6xEd+60LVa+yToq+zm6o6oGEDlB8/sv1oBADO9fKC4xqL1RwqkM3g5IFA2c4U5BQx3UTFQ2aXyeD1pOLnYYjcuZk5fdYx3AIEi1M9D3Ll7YhgELLlwUGxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618045; c=relaxed/simple;
	bh=BOs+wATWIP0hf5yAdjIAntiqPkV3r6X+bsEPmZIaqek=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UXlje46rFMyzyB7evZ02B7pzbvvxEdsss6x3hm1gOSa/kKBWeHic7Lb85M+QR83Brzu8AHNH8PeoGj/wMzexFpSuc3xMCXpB1zs273+Z+2KFb90bTs3wMMDUzWRbM+WgVY1Q5OVKF/4b4Sy+lHr/UXy52gTSqOXoSBI3paw9SEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U8G2O58l; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708618044; x=1740154044;
  h=date:from:to:cc:subject:message-id;
  bh=BOs+wATWIP0hf5yAdjIAntiqPkV3r6X+bsEPmZIaqek=;
  b=U8G2O58lqWFhYJH6EfRVm7QtBOveV8Gsg/2fsQdwRwbaPm2rsRc3j/cW
   ddGu5AKJl7Xi6xSqbvC5DG0dibo+gW9JH088jU7XjNP1XwcvDP4/djnAa
   iRf5596Phz6RLyv6uURnud/2G5kVG8A+DnYF7n/2fNLAQui8w+P/wEkIq
   uphA9BHkHFB/1Nw2wJzzQ4zAq2UxXNXZpRo8UbkCg9SjoDyyy0CAJ8gn8
   poYZnQwvMOv2lvzVOkEKepO7jVpoTrS3tmu2JQVP6s5RtuSMOSlQCOJn5
   JeteFSYYC1SEWLvyrsBMMwMgtaQEx10DX0z4q1P0a0XukNLC0gZxha6PQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2724667"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2724667"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36542718"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2024 08:06:56 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdBaH-0006SY-1P;
	Thu, 22 Feb 2024 16:06:14 +0000
Date: Fri, 23 Feb 2024 00:02:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ec4308ecfc887128a468f03fb66b767559c57c23
Message-ID: <202402230050.3i3HimgL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ec4308ecfc887128a468f03fb66b767559c57c23  irqchip/gic-v3-its: Do not assume vPE tables are preallocated

elapsed time: 1180m

configs tested: 163
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
arc                   randconfig-001-20240222   gcc  
arc                   randconfig-002-20240222   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240222   gcc  
arm                   randconfig-002-20240222   gcc  
arm                   randconfig-003-20240222   clang
arm                   randconfig-004-20240222   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240222   clang
arm64                 randconfig-002-20240222   gcc  
arm64                 randconfig-003-20240222   clang
arm64                 randconfig-004-20240222   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240222   gcc  
csky                  randconfig-002-20240222   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240222   clang
hexagon               randconfig-002-20240222   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240222   gcc  
i386         buildonly-randconfig-002-20240222   clang
i386         buildonly-randconfig-003-20240222   clang
i386         buildonly-randconfig-004-20240222   gcc  
i386         buildonly-randconfig-005-20240222   clang
i386         buildonly-randconfig-006-20240222   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240222   clang
i386                  randconfig-002-20240222   clang
i386                  randconfig-003-20240222   gcc  
i386                  randconfig-004-20240222   clang
i386                  randconfig-005-20240222   gcc  
i386                  randconfig-006-20240222   clang
i386                  randconfig-011-20240222   gcc  
i386                  randconfig-012-20240222   clang
i386                  randconfig-013-20240222   gcc  
i386                  randconfig-014-20240222   gcc  
i386                  randconfig-015-20240222   clang
i386                  randconfig-016-20240222   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240222   gcc  
loongarch             randconfig-002-20240222   gcc  
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
nios2                 randconfig-001-20240222   gcc  
nios2                 randconfig-002-20240222   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240222   gcc  
parisc                randconfig-002-20240222   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240222   clang
powerpc               randconfig-002-20240222   clang
powerpc               randconfig-003-20240222   clang
powerpc64             randconfig-001-20240222   clang
powerpc64             randconfig-002-20240222   clang
powerpc64             randconfig-003-20240222   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240222   clang
riscv                 randconfig-002-20240222   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240222   gcc  
s390                  randconfig-002-20240222   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240222   gcc  
sh                    randconfig-002-20240222   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240222   gcc  
sparc64               randconfig-002-20240222   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240222   clang
um                    randconfig-002-20240222   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240222   clang
x86_64       buildonly-randconfig-002-20240222   clang
x86_64       buildonly-randconfig-003-20240222   gcc  
x86_64       buildonly-randconfig-004-20240222   clang
x86_64       buildonly-randconfig-005-20240222   gcc  
x86_64       buildonly-randconfig-006-20240222   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240222   clang
x86_64                randconfig-002-20240222   clang
x86_64                randconfig-003-20240222   clang
x86_64                randconfig-004-20240222   clang
x86_64                randconfig-005-20240222   gcc  
x86_64                randconfig-006-20240222   gcc  
x86_64                randconfig-011-20240222   clang
x86_64                randconfig-012-20240222   gcc  
x86_64                randconfig-013-20240222   clang
x86_64                randconfig-014-20240222   gcc  
x86_64                randconfig-015-20240222   clang
x86_64                randconfig-016-20240222   clang
x86_64                randconfig-071-20240222   clang
x86_64                randconfig-072-20240222   clang
x86_64                randconfig-073-20240222   clang
x86_64                randconfig-074-20240222   gcc  
x86_64                randconfig-075-20240222   gcc  
x86_64                randconfig-076-20240222   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240222   gcc  
xtensa                randconfig-002-20240222   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

