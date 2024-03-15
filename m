Return-Path: <linux-kernel+bounces-104087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320687C8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12A1F221A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17EC171B6;
	Fri, 15 Mar 2024 06:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZReS4mhb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DB13FE7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710484328; cv=none; b=Ozp7tEe6NGsVIWQ0I1DflGx3oMcWZVuHGvmkW+/Owkvy863SdExtq2eQGV+FQbSCmgsXGQ8dbNjuTV4PuExb+/p6dEF4uDia0/RFWGlZ5uFYzXZNurS9kjFF2/oQtBRoJHGHoK1Zse/QH+obrZaOdEgHMdmSBGksNEc1Etgxw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710484328; c=relaxed/simple;
	bh=HtWmFr00a8PTWGqWp2wm99oTGY9tWCfNYNkImcq3MTM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RVpe9/5ycJojxf0mm96iXPPylZovmZXt6O/e0lIjrhRWI5gBNI7SnV41PXgRZHpZZaAnH1jOR9gtyxgo38sZbJNkp7Kz+0JUye8M4GCDxli6Aea40cycF4mCrMSfjDbJuk8afpCwk8eyxdDl54s4zlQQP3I0PctgNAYulk0eJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZReS4mhb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710484327; x=1742020327;
  h=date:from:to:cc:subject:message-id;
  bh=HtWmFr00a8PTWGqWp2wm99oTGY9tWCfNYNkImcq3MTM=;
  b=ZReS4mhbU24HNjO0EpS2tl/IBSjX5Hy6LJjadacDJky8wvnYMzjsyUF0
   pNe87WkJftg7GGplzEBaMGTSEcAKRo41qHLXWZZ1LuV1L/D3awjjL6IB4
   wYKGGg9x+6HVx7YeJnkxoJIjlESvoAyUAeaBsMaY/KeBeB2SEZQkT+Kvj
   U5b4YOuUkRq/sPjiEWInksx1cUd7PgSqG3GzPgxx/92pOKJyne7frUNfd
   D+PBO97GtzOAzmsVYexvO/P9hX2aOl92H3XegVnFSIHMmsWBrwKIZmP8M
   mNLrw5SvH6PrUb+8uPJDFAH82ptfb9F/MdA7K/nCnrJYpFaCUPggLQC1x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16065539"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="16065539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 23:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="17257569"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Mar 2024 23:31:59 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl16i-000ECp-2T;
	Fri, 15 Mar 2024 06:31:56 +0000
Date: Fri, 15 Mar 2024 14:31:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 b9e6e28663928cab836a19abbdec3d036a07db3b
Message-ID: <202403151424.FNEghCrv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: b9e6e28663928cab836a19abbdec3d036a07db3b  sched/fair: Fix typos in comments

elapsed time: 1153m

configs tested: 177
configs skipped: 5

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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240315   gcc  
arc                   randconfig-002-20240315   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                         lpc18xx_defconfig   clang
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240315   clang
arm                   randconfig-002-20240315   gcc  
arm                   randconfig-003-20240315   gcc  
arm                   randconfig-004-20240315   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240315   gcc  
arm64                 randconfig-002-20240315   gcc  
arm64                 randconfig-003-20240315   gcc  
arm64                 randconfig-004-20240315   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240315   gcc  
csky                  randconfig-002-20240315   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240315   clang
hexagon               randconfig-002-20240315   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-003-20240314   gcc  
i386         buildonly-randconfig-004-20240314   gcc  
i386         buildonly-randconfig-005-20240314   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240314   gcc  
i386                  randconfig-002-20240314   clang
i386                  randconfig-003-20240314   gcc  
i386                  randconfig-004-20240314   clang
i386                  randconfig-005-20240314   gcc  
i386                  randconfig-006-20240314   gcc  
i386                  randconfig-011-20240314   clang
i386                  randconfig-012-20240314   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240314   gcc  
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240314   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240315   gcc  
loongarch             randconfig-002-20240315   gcc  
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
mips                           ip28_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240315   gcc  
nios2                 randconfig-002-20240315   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240315   gcc  
parisc                randconfig-002-20240315   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      cm5200_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc               randconfig-001-20240315   clang
powerpc               randconfig-002-20240315   gcc  
powerpc               randconfig-003-20240315   clang
powerpc64             randconfig-001-20240315   clang
powerpc64             randconfig-002-20240315   gcc  
powerpc64             randconfig-003-20240315   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240315   clang
riscv                 randconfig-002-20240315   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240315   gcc  
s390                  randconfig-002-20240315   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240315   gcc  
sh                    randconfig-002-20240315   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240315   gcc  
sparc64               randconfig-002-20240315   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240315   gcc  
um                    randconfig-002-20240315   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-001-20240315   gcc  
x86_64       buildonly-randconfig-002-20240315   gcc  
x86_64       buildonly-randconfig-003-20240315   gcc  
x86_64       buildonly-randconfig-004-20240315   gcc  
x86_64       buildonly-randconfig-005-20240315   clang
x86_64       buildonly-randconfig-006-20240315   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240315   gcc  
x86_64                randconfig-002-20240315   clang
x86_64                randconfig-003-20240315   gcc  
x86_64                randconfig-004-20240315   clang
x86_64                randconfig-005-20240315   gcc  
x86_64                randconfig-006-20240315   gcc  
x86_64                randconfig-011-20240315   clang
x86_64                randconfig-012-20240315   gcc  
x86_64                randconfig-013-20240315   gcc  
x86_64                randconfig-014-20240315   gcc  
x86_64                randconfig-015-20240315   clang
x86_64                randconfig-016-20240315   clang
x86_64                randconfig-071-20240315   clang
x86_64                randconfig-072-20240315   clang
x86_64                randconfig-073-20240315   gcc  
x86_64                randconfig-074-20240315   gcc  
x86_64                randconfig-075-20240315   clang
x86_64                randconfig-076-20240315   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240315   gcc  
xtensa                randconfig-002-20240315   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

