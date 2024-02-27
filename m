Return-Path: <linux-kernel+bounces-82748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645208688FE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877001C22169
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2237145;
	Tue, 27 Feb 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5jXjfBD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE08256A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015631; cv=none; b=uKbqVl+XkxsaYirlKCEPjEN4aLfmCAH3nFZ7VXKNZJWKY/kA+VwUDWz5Z/P2RjoaBfvMhU6sqtyI5rtqrnsROvfx6mZbCVFNXEUSPECWqXllok0+R1n9XshArbkJ9ELA46iczU6XKKEvNmFfzdKR1TspPXTcV+b3qR3nVZzv1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015631; c=relaxed/simple;
	bh=Js4VEzIOR4R0vbwH8iycrAoT2/jESVdakdQah83BV7Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r8/4xDFhI15Lw6F8KW0qYaUfdmvTHiUv2+oeYgCzX85Gr1+Gu74ZRBSJWfQSR/rIXH+eeHTH4jkyt3LC4oBkFN/E0/R+8XEs4r9U9mmAuVW0PQ+X0THzmVHAtIdx3byuVaC69giHHZvxvb7Tv1X9hqIbbKuZkBNoaXVGeiVL53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5jXjfBD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709015629; x=1740551629;
  h=date:from:to:cc:subject:message-id;
  bh=Js4VEzIOR4R0vbwH8iycrAoT2/jESVdakdQah83BV7Q=;
  b=O5jXjfBDH1dlM3uMtbBM6ACcf2TiVASEScJgK0EAdbXooZyJJIESuPrY
   I+gjuL1Zr4ty45IlkoT3LolxLQQuzUSQk4YzURBSOMpmtT2fRtxQBi+VU
   5OMNUUWc1AzhSMrxTvBPOzSeT/eaPRQ/ceyX9hvblMAWCu7/cpB2aOsZS
   bi/pT1v979iT6zpP5pf3qLJc7EXLbU6s5fR9BSb5UYpNQa3MtTi7q0nB0
   19EyLGEy7e4TIdy5tIfG0MBhQtckduTey7/eJ4ldL8nkb+MAKf2tA7142
   tMMVHq8Ya99RdB+emxJ8BqW0aqs0bxHcERVEpbIXmzJaK92VItA/UsP4n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14488737"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14488737"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 22:33:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11601044"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Feb 2024 22:33:48 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rer29-000B03-1S;
	Tue, 27 Feb 2024 06:33:45 +0000
Date: Tue, 27 Feb 2024 14:33:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD REGRESSION
 62aaed88843a9a69b5614f99ec4a2930edd09658
Message-ID: <202402271400.BGvTqpdT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 62aaed88843a9a69b5614f99ec4a2930edd09658  x86/apic: Build the x86 topology enumeration functions on UP APIC builds too

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402271008.YvpQ54cP-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/smp.h:221:27: error: 'setup_max_cpus' defined but not used [-Werror=unused-const-variable=]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-004-20240227
|   `-- include-linux-smp.h:error:setup_max_cpus-defined-but-not-used
|-- csky-allmodconfig
|   `-- include-linux-smp.h:error:setup_max_cpus-defined-but-not-used
`-- csky-allyesconfig
    `-- include-linux-smp.h:error:setup_max_cpus-defined-but-not-used

elapsed time: 1109m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240227   gcc  
arc                   randconfig-002-20240227   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20240227   gcc  
arm                   randconfig-002-20240227   gcc  
arm                   randconfig-003-20240227   gcc  
arm                   randconfig-004-20240227   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240227   clang
arm64                 randconfig-002-20240227   gcc  
arm64                 randconfig-003-20240227   gcc  
arm64                 randconfig-004-20240227   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240227   gcc  
csky                  randconfig-002-20240227   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240227   clang
hexagon               randconfig-002-20240227   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240226   clang
i386         buildonly-randconfig-002-20240226   gcc  
i386         buildonly-randconfig-003-20240226   clang
i386         buildonly-randconfig-004-20240226   clang
i386         buildonly-randconfig-005-20240226   clang
i386         buildonly-randconfig-006-20240226   clang
i386                                defconfig   clang
i386                  randconfig-001-20240226   clang
i386                  randconfig-002-20240226   gcc  
i386                  randconfig-003-20240226   clang
i386                  randconfig-004-20240226   gcc  
i386                  randconfig-005-20240226   clang
i386                  randconfig-006-20240226   clang
i386                  randconfig-011-20240226   gcc  
i386                  randconfig-012-20240226   gcc  
i386                  randconfig-013-20240226   gcc  
i386                  randconfig-014-20240226   gcc  
i386                  randconfig-015-20240226   gcc  
i386                  randconfig-016-20240226   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240227   gcc  
loongarch             randconfig-002-20240227   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240227   gcc  
nios2                 randconfig-002-20240227   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240227   gcc  
parisc                randconfig-002-20240227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc               randconfig-001-20240227   clang
powerpc               randconfig-002-20240227   gcc  
powerpc               randconfig-003-20240227   clang
powerpc                        warp_defconfig   gcc  
powerpc64             randconfig-001-20240227   clang
powerpc64             randconfig-002-20240227   gcc  
powerpc64             randconfig-003-20240227   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240227   gcc  
riscv                 randconfig-002-20240227   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240227   gcc  
s390                  randconfig-002-20240227   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240227   gcc  
sh                    randconfig-002-20240227   gcc  
sh                           se7722_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240227   gcc  
sparc64               randconfig-002-20240227   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240227   clang
um                    randconfig-002-20240227   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240227   clang
x86_64       buildonly-randconfig-002-20240227   gcc  
x86_64       buildonly-randconfig-003-20240227   clang
x86_64       buildonly-randconfig-004-20240227   clang
x86_64       buildonly-randconfig-005-20240227   clang
x86_64       buildonly-randconfig-006-20240227   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240227   clang
x86_64                randconfig-002-20240227   clang
x86_64                randconfig-003-20240227   gcc  
x86_64                randconfig-004-20240227   gcc  
x86_64                randconfig-005-20240227   gcc  
x86_64                randconfig-006-20240227   gcc  
x86_64                randconfig-011-20240227   gcc  
x86_64                randconfig-012-20240227   gcc  
x86_64                randconfig-013-20240227   clang
x86_64                randconfig-014-20240227   gcc  
x86_64                randconfig-015-20240227   gcc  
x86_64                randconfig-016-20240227   gcc  
x86_64                randconfig-071-20240227   gcc  
x86_64                randconfig-072-20240227   clang
x86_64                randconfig-073-20240227   gcc  
x86_64                randconfig-074-20240227   clang
x86_64                randconfig-075-20240227   clang
x86_64                randconfig-076-20240227   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240227   gcc  
xtensa                randconfig-002-20240227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

