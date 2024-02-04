Return-Path: <linux-kernel+bounces-51594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FED848CFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F251C21325
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EFC21A06;
	Sun,  4 Feb 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOUc0UuE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF72134F
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044247; cv=none; b=rt8EDEjlBTOqg3KcSdqtXx9qWcny7T1iGbAtyRFAp6JcSN7+CZnavyTi1U9hFfaHov5KeriRwHbHzmUvx+gO8Gk4Z5v04jC3PK+wvJnOURxA0NEYQ2ZhrZXO35JPUwBm9bJ1GCF6bwtWgHWVcqcK/rG1wqpn4VktnumPwDtk6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044247; c=relaxed/simple;
	bh=Q0tbUYhKNy1m4UO9vosfihx3dgnkZJGhXPIuApuO914=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P2Ak7tNFrTJ5G4xq9o7NrazV1QF3GNgqouXuuuC0wbY/TKsqGhiHooSmeqUtgqBNtrcEQfiD4x5JGrJblzD9CqGMNrvRqXkZ9cvBXczLQPlP7zF94FtQKEWyZAdAeHpnr4owiJbydSOXy/g2Vm54ynysbUDmqGyduiQUPnJOKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOUc0UuE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707044246; x=1738580246;
  h=date:from:to:cc:subject:message-id;
  bh=Q0tbUYhKNy1m4UO9vosfihx3dgnkZJGhXPIuApuO914=;
  b=LOUc0UuEWXLmvxtav0mVf373/o2zSopoX11ZHwWuPWUOLeujkCZ56QHw
   OCj9WWgx2AQxj14gTJtSfloM2Wf/1WfXcBRBxavc20gKRzVs2nJE3cN0C
   bdUZHlh75lBKYHpvrdgjJluSx3BgA6e54AsYV1ge3f3huXK8ODitMBsm9
   Pu23+T+Tavxit2ylfTK3Mq10v7/2dluwzy8mA4ubC2OQvVsSTVtPQ+6RA
   QlSvfPntLI3O63xsGki137ZxYNNWdY60BsvsVvh1MwAhpn7y74KOnK82t
   Uz3XXYyU55LAigi8cPBlJdiFYgSA8+UXtbSezGzKwfa2NQ7OH9Lgvzz28
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="627207"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="627207"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 02:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="684639"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2024 02:57:23 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWaBe-0006Gg-0F;
	Sun, 04 Feb 2024 10:57:22 +0000
Date: Sun, 04 Feb 2024 18:56:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 f9e6f00d93d34f60f90b42c24e80194b11a72bb2
Message-ID: <202402041853.06D9CXH9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: f9e6f00d93d34f60f90b42c24e80194b11a72bb2  crypto: ccp: Make snp_range_list static

elapsed time: 1447m

configs tested: 179
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
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-002-20240203   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                   randconfig-001-20240203   clang
arm                   randconfig-002-20240203   clang
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240203   clang
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240203   clang
arm64                 randconfig-002-20240203   clang
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-002-20240203   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240203   clang
hexagon               randconfig-002-20240203   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240203   clang
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-003-20240203   clang
i386         buildonly-randconfig-004-20240203   clang
i386         buildonly-randconfig-005-20240203   clang
i386         buildonly-randconfig-006-20240203   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240203   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-003-20240203   clang
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-005-20240203   clang
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-011-20240203   clang
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-016-20240203   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-002-20240203   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-002-20240203   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-002-20240203   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc               randconfig-001-20240203   clang
powerpc               randconfig-002-20240203   clang
powerpc               randconfig-003-20240203   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240203   clang
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240203   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240203   clang
riscv                 randconfig-002-20240203   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240203   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-002-20240203   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-002-20240203   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240203   clang
um                    randconfig-002-20240203   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240203   gcc  
x86_64       buildonly-randconfig-002-20240203   gcc  
x86_64       buildonly-randconfig-003-20240203   gcc  
x86_64       buildonly-randconfig-004-20240203   gcc  
x86_64       buildonly-randconfig-005-20240203   gcc  
x86_64       buildonly-randconfig-006-20240203   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240203   gcc  
x86_64                randconfig-002-20240203   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-004-20240203   gcc  
x86_64                randconfig-005-20240203   gcc  
x86_64                randconfig-006-20240203   gcc  
x86_64                randconfig-011-20240203   gcc  
x86_64                randconfig-012-20240203   gcc  
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-072-20240203   gcc  
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-002-20240203   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

