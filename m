Return-Path: <linux-kernel+bounces-109889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05E885761
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D717283A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3355674C;
	Thu, 21 Mar 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNry3yBl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9054FB7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016626; cv=none; b=phAJ6qJd0JTyXKr0uZF68USYDTUvB8dDZci09+s9KpkhXuEbRJyAYZBu++xEU8ZaO9u51t9OOpTRJTh8wPDby4UkZoNzYoMO3ZEQ9eBANTFmwGSLjmKOqUArolDkpYRR+/L+H4CRtJGTDPUexEG+jrIPo2srsLQCNHTs3773bWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016626; c=relaxed/simple;
	bh=H/4U1Q2C7ulMnENGAMxN1vwruqRhliXmWhnXfYVA648=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Zf+zlirEq/ZpK7Z4wEQlzq1TYpQ5/Z9+7B4zdVxf78yjX/kFiYDKQOaIMZHic2xiDS+Of8j3XEXm19VTGiTtU6sSVokF1LKZadNC8+Awnc/rSY5FAMKoKH/1IeUcMnhJEbe7PsaV2XV7jQgLBUFiGr8mVtQiD9fnYJTcchMvTkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNry3yBl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711016625; x=1742552625;
  h=date:from:to:cc:subject:message-id;
  bh=H/4U1Q2C7ulMnENGAMxN1vwruqRhliXmWhnXfYVA648=;
  b=QNry3yBl/QWCk2wNCjB6TtMZcb3h6X8/m0C2WBH6S5PebCanI/s+wZhH
   7/MXBg5WPhKPPOmUAw57xL/d3Ag/ow5Xy5xGrYuT6KRaxl1qmwwXwDxz+
   b4dzyicvbkCMiQeUE6EYhlDnRi6h4E1oRe7awn3kKM1dN/WHxpid0FfnK
   07AviyyJ0XZ6ACKMIbVMsuOfdPNe2nPEJZDGmkZZWSXxiyK+HZfBetQTX
   QWlD0YJqx+j1mdQ/8kwIx/mzZ29kfe/5uaodPUg2IQ6I+kWsPaP+pjQP6
   kFdw8jydwFeMvqw3Tw2UfV43Y74w9dhP9l8SlpFRFdLrD7oAbfQO72x7/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5862565"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="5862565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 03:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="19035169"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Mar 2024 03:23:43 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnFaG-000JKb-28;
	Thu, 21 Mar 2024 10:23:40 +0000
Date: Thu, 21 Mar 2024 18:23:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240318-commit-by-commit]
 BUILD SUCCESS ee86071f178f30e42829ea42433c20ca302e8ec0
Message-ID: <202403211829.9AcAnNSc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240318-commit-by-commit
branch HEAD: ee86071f178f30e42829ea42433c20ca302e8ec0  wifi: mwl8k: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 736m

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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240321   gcc  
arc                   randconfig-002-20240321   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm                   randconfig-001-20240321   clang
arm                   randconfig-002-20240321   gcc  
arm                   randconfig-003-20240321   clang
arm                   randconfig-004-20240321   clang
arm                             rpc_defconfig   clang
arm                        spear3xx_defconfig   clang
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240321   clang
arm64                 randconfig-002-20240321   clang
arm64                 randconfig-003-20240321   clang
arm64                 randconfig-004-20240321   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240321   gcc  
csky                  randconfig-002-20240321   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240321   clang
hexagon               randconfig-002-20240321   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240321   gcc  
i386         buildonly-randconfig-002-20240321   gcc  
i386         buildonly-randconfig-003-20240321   clang
i386         buildonly-randconfig-004-20240321   clang
i386         buildonly-randconfig-005-20240321   gcc  
i386         buildonly-randconfig-006-20240321   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240321   clang
i386                  randconfig-002-20240321   gcc  
i386                  randconfig-003-20240321   gcc  
i386                  randconfig-004-20240321   clang
i386                  randconfig-005-20240321   clang
i386                  randconfig-006-20240321   gcc  
i386                  randconfig-011-20240321   clang
i386                  randconfig-012-20240321   gcc  
i386                  randconfig-013-20240321   gcc  
i386                  randconfig-014-20240321   gcc  
i386                  randconfig-015-20240321   gcc  
i386                  randconfig-016-20240321   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240321   gcc  
loongarch             randconfig-002-20240321   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                           ip28_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240321   gcc  
nios2                 randconfig-002-20240321   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240321   gcc  
parisc                randconfig-002-20240321   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-001-20240321   clang
powerpc               randconfig-002-20240321   gcc  
powerpc               randconfig-003-20240321   clang
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240321   clang
powerpc64             randconfig-002-20240321   clang
powerpc64             randconfig-003-20240321   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240321   clang
riscv                 randconfig-002-20240321   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240321   clang
s390                  randconfig-002-20240321   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240321   gcc  
sh                    randconfig-002-20240321   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240321   gcc  
sparc64               randconfig-002-20240321   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240321   gcc  
um                    randconfig-002-20240321   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240321   gcc  
x86_64       buildonly-randconfig-002-20240321   clang
x86_64       buildonly-randconfig-003-20240321   clang
x86_64       buildonly-randconfig-004-20240321   clang
x86_64       buildonly-randconfig-005-20240321   clang
x86_64       buildonly-randconfig-006-20240321   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240321   gcc  
x86_64                randconfig-002-20240321   clang
x86_64                randconfig-003-20240321   gcc  
x86_64                randconfig-004-20240321   gcc  
x86_64                randconfig-005-20240321   gcc  
x86_64                randconfig-006-20240321   gcc  
x86_64                randconfig-011-20240321   clang
x86_64                randconfig-012-20240321   gcc  
x86_64                randconfig-013-20240321   clang
x86_64                randconfig-014-20240321   gcc  
x86_64                randconfig-015-20240321   gcc  
x86_64                randconfig-016-20240321   gcc  
x86_64                randconfig-071-20240321   clang
x86_64                randconfig-072-20240321   gcc  
x86_64                randconfig-073-20240321   gcc  
x86_64                randconfig-074-20240321   clang
x86_64                randconfig-075-20240321   clang
x86_64                randconfig-076-20240321   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240321   gcc  
xtensa                randconfig-002-20240321   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

