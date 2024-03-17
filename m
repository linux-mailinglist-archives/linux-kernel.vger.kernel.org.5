Return-Path: <linux-kernel+bounces-105344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36AE87DC7C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A59282186
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F9E555;
	Sun, 17 Mar 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5senYK+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B0CA78
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710660438; cv=none; b=YTmwLrDb383gofVnvVhX+qA/lahee2RI/n6YfASRSydJpLRnGZ8/rrb4GI/hGtAhZMi+JlwEd7t+oINyXFxYFRFZBtz+I7dRT38LkHboy2ZJDYH01CcZMqd2kYEpVKBxAr63rF+c2GTtypsVx8yUoqn9A+kN4WOpWyWOcywURTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710660438; c=relaxed/simple;
	bh=sFe+xBZdZ79Y8qLkfh+tbCiy+KewcWvlvXwy2DBtFPw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dG89wEyf1cPYHhNJGvy7GxUfSn7+4CdbbRR2kSwmkcbn0I1dV03MlNz9RyVi7VRz/dlI3IIZzauhhvnp4euHVKHFgcqTagcBV2CC2esVxProuPWolhnjegmzIeI+nUPU7kMak3ezdsdA1jJRrgSBmgEJ/NS7IWqfyWuXjb3GGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5senYK+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710660436; x=1742196436;
  h=date:from:to:cc:subject:message-id;
  bh=sFe+xBZdZ79Y8qLkfh+tbCiy+KewcWvlvXwy2DBtFPw=;
  b=k5senYK+wculUu89DlsJqNUJbNT+Ha4Aqf9zPiZqKbnPgnX7TR9OFVmG
   1SaI5e/hGz2Pl1v0qvudDTszQgfdsqI3zkgQhxq1PBONf5nN2nWhjdiAX
   n/be+9CSQ1I5CVlmZ0HKe0WXZLovs2NoHgCVinBgQDHvXl8HCQ0YHEFkm
   UGn0lvEE96RqRz2qPZo6t8ZAU9PBrz05XpZqw0p1FhAr0+WoFdJuLQS2m
   u0A1F4MUJuccljhf5YSukDxiZUfz1BAGWfoxkvYIjXQ9PpK6B06G4n5HD
   rbiWFJT98O9nrolzO8qDOru5kEzk6Utp+V7QxT+NoYPgyePjivN9FiTU0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="23004813"
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="23004813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 00:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="44045265"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Mar 2024 00:27:15 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlkvH-000G6k-3C;
	Sun, 17 Mar 2024 07:27:11 +0000
Date: Sun, 17 Mar 2024 15:26:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 4b6f4c5a67c07417bf29d896c76f513a4be07516
Message-ID: <202403171543.tb8tDx2n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 4b6f4c5a67c07417bf29d896c76f513a4be07516  timer/migration: Remove buggy early return on deactivation

elapsed time: 725m

configs tested: 199
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240317   gcc  
arc                   randconfig-002-20240317   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                        mvebu_v7_defconfig   clang
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20240317   clang
arm                   randconfig-002-20240317   clang
arm                   randconfig-003-20240317   gcc  
arm                   randconfig-004-20240317   clang
arm                         socfpga_defconfig   gcc  
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240317   clang
arm64                 randconfig-002-20240317   gcc  
arm64                 randconfig-003-20240317   gcc  
arm64                 randconfig-004-20240317   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240317   gcc  
csky                  randconfig-002-20240317   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240317   clang
hexagon               randconfig-002-20240317   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240317   gcc  
i386         buildonly-randconfig-002-20240317   clang
i386         buildonly-randconfig-003-20240317   gcc  
i386         buildonly-randconfig-004-20240317   clang
i386         buildonly-randconfig-005-20240317   clang
i386         buildonly-randconfig-006-20240317   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240317   clang
i386                  randconfig-002-20240317   clang
i386                  randconfig-003-20240317   clang
i386                  randconfig-004-20240317   clang
i386                  randconfig-005-20240317   gcc  
i386                  randconfig-006-20240317   gcc  
i386                  randconfig-011-20240317   clang
i386                  randconfig-012-20240317   clang
i386                  randconfig-013-20240317   clang
i386                  randconfig-014-20240317   gcc  
i386                  randconfig-015-20240317   gcc  
i386                  randconfig-016-20240317   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240317   gcc  
loongarch             randconfig-002-20240317   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240317   gcc  
nios2                 randconfig-002-20240317   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240317   gcc  
parisc                randconfig-002-20240317   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240317   clang
powerpc               randconfig-002-20240317   gcc  
powerpc               randconfig-003-20240317   clang
powerpc64             randconfig-001-20240317   gcc  
powerpc64             randconfig-002-20240317   clang
powerpc64             randconfig-003-20240317   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240317   clang
riscv                 randconfig-002-20240317   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240317   clang
s390                  randconfig-002-20240317   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240317   gcc  
sh                    randconfig-002-20240317   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240317   gcc  
sparc64               randconfig-002-20240317   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240317   gcc  
um                    randconfig-002-20240317   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240317   gcc  
x86_64       buildonly-randconfig-002-20240317   gcc  
x86_64       buildonly-randconfig-003-20240317   gcc  
x86_64       buildonly-randconfig-004-20240317   clang
x86_64       buildonly-randconfig-005-20240317   gcc  
x86_64       buildonly-randconfig-006-20240317   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240317   gcc  
x86_64                randconfig-002-20240317   gcc  
x86_64                randconfig-003-20240317   gcc  
x86_64                randconfig-004-20240317   gcc  
x86_64                randconfig-005-20240317   gcc  
x86_64                randconfig-006-20240317   clang
x86_64                randconfig-011-20240317   clang
x86_64                randconfig-012-20240317   gcc  
x86_64                randconfig-013-20240317   clang
x86_64                randconfig-014-20240317   clang
x86_64                randconfig-015-20240317   gcc  
x86_64                randconfig-016-20240317   clang
x86_64                randconfig-071-20240317   gcc  
x86_64                randconfig-072-20240317   clang
x86_64                randconfig-073-20240317   clang
x86_64                randconfig-074-20240317   gcc  
x86_64                randconfig-075-20240317   gcc  
x86_64                randconfig-076-20240317   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240317   gcc  
xtensa                randconfig-002-20240317   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

