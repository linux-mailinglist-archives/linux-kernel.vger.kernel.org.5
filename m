Return-Path: <linux-kernel+bounces-53996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E084A8F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6981F2D12E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1971AB7ED;
	Mon,  5 Feb 2024 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp1O1HAG"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D61AB7E3
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170694; cv=none; b=s+cq9Odo3MOgto0N8fqo5xCOGMqhSCdWZbXfGA7/UH9ql4ire3Tkbo3wV//XOBqUIB/khWlDpFZHSNKp4dAeUDFvPzGzON9OKSYHzpfn4x95hPom2gu9Yt3pYOyQyFuZKr3UfSphad28OrrNeV5YRRsoH4QuXdAyOFxpt+XsiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170694; c=relaxed/simple;
	bh=lP9ObYhzyfwh3hX2bYqFdVQ4wn9aZLRK/nSwIVhA7oI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K9MNAXYXGnqc25i75sPYAIuEa8Ud19Bp9jHTP+KXbQdP4dQ5dxlv1Kb8P6P1Rqoqndc8TCqulGv1GGJiJlKRp/o9cEpxO/jJvYp22DEIBpw3MRfYpo0qXF0vzDg/p/xqjfD8NkEPRr1VBuJ6SBnbsNxC3bTdEzizPC9Vq7+P1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp1O1HAG; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707170692; x=1738706692;
  h=date:from:to:cc:subject:message-id;
  bh=lP9ObYhzyfwh3hX2bYqFdVQ4wn9aZLRK/nSwIVhA7oI=;
  b=fp1O1HAGmiQhLYf73gpk+PB3Sit0bor8A9aBd7j1vXho7lT1XqZOpzFC
   lpaik7P9ZoWfktHREpwHhu8whRton5SIq74q/D0EmhoOsMsQQJqOei0Hy
   zwCeIXqN+V8uHfSI2cEFme+zmnPNuaY6uCvwjwttkmDni+JR6c4O+lsv+
   SL5SfOSUe260kCi6CIinQ1riMiZSK+qorrSPiI+eQDWPNwbDxLBHlVJlh
   WdnwUWPHa2V0hHbMFsTqznb/znQwioHPI4XX8cUao7NuN7EM7icGc8+ga
   ULM+uzJFeP0nSWV7dqJR7WeqVa4nEf90zV/KqXto+8e9FqhA7Ws2NFv1U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="395039732"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="395039732"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:04:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="855077"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Feb 2024 14:04:43 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rX74y-0000q6-1Q;
	Mon, 05 Feb 2024 22:04:40 +0000
Date: Tue, 06 Feb 2024 06:03:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 a6a789165bbdb506b784f53b7467dbe0210494ad
Message-ID: <202402060648.5kN1X1gf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: a6a789165bbdb506b784f53b7467dbe0210494ad  x86/mce: Make mce_subsys const

elapsed time: 729m

configs tested: 165
configs skipped: 135

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
arc                   randconfig-001-20240205   gcc  
arc                   randconfig-002-20240205   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-002-20240205   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240205   gcc  
arm64                 randconfig-002-20240205   gcc  
arm64                 randconfig-003-20240205   gcc  
arm64                 randconfig-004-20240205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240205   gcc  
csky                  randconfig-002-20240205   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240205   clang
i386         buildonly-randconfig-002-20240205   clang
i386         buildonly-randconfig-003-20240205   clang
i386         buildonly-randconfig-003-20240206   gcc  
i386         buildonly-randconfig-004-20240205   clang
i386         buildonly-randconfig-005-20240205   clang
i386         buildonly-randconfig-005-20240206   gcc  
i386         buildonly-randconfig-006-20240205   clang
i386         buildonly-randconfig-006-20240206   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240205   clang
i386                  randconfig-002-20240205   clang
i386                  randconfig-003-20240205   clang
i386                  randconfig-004-20240205   gcc  
i386                  randconfig-005-20240205   clang
i386                  randconfig-006-20240205   gcc  
i386                  randconfig-011-20240205   gcc  
i386                  randconfig-012-20240205   clang
i386                  randconfig-012-20240206   gcc  
i386                  randconfig-013-20240205   gcc  
i386                  randconfig-014-20240205   gcc  
i386                  randconfig-014-20240206   gcc  
i386                  randconfig-015-20240205   clang
i386                  randconfig-015-20240206   gcc  
i386                  randconfig-016-20240205   gcc  
i386                  randconfig-016-20240206   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240205   gcc  
loongarch             randconfig-002-20240205   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240205   gcc  
nios2                 randconfig-002-20240205   gcc  
openrisc                         allmodconfig   gcc  
parisc                randconfig-001-20240205   gcc  
parisc                randconfig-002-20240205   gcc  
powerpc                          allyesconfig   clang
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc               randconfig-003-20240205   gcc  
powerpc                  storcenter_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240205   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240205   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240205   gcc  
sh                    randconfig-002-20240205   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240205   gcc  
sparc64               randconfig-002-20240205   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-002-20240205   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240205   clang
x86_64       buildonly-randconfig-002-20240205   clang
x86_64       buildonly-randconfig-003-20240205   gcc  
x86_64       buildonly-randconfig-004-20240205   gcc  
x86_64       buildonly-randconfig-005-20240205   gcc  
x86_64       buildonly-randconfig-006-20240205   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240205   gcc  
x86_64                randconfig-002-20240205   gcc  
x86_64                randconfig-003-20240205   clang
x86_64                randconfig-004-20240205   gcc  
x86_64                randconfig-005-20240205   gcc  
x86_64                randconfig-006-20240205   gcc  
x86_64                randconfig-011-20240205   gcc  
x86_64                randconfig-012-20240205   gcc  
x86_64                randconfig-013-20240205   clang
x86_64                randconfig-014-20240205   clang
x86_64                randconfig-015-20240205   gcc  
x86_64                randconfig-016-20240205   clang
x86_64                randconfig-071-20240205   clang
x86_64                randconfig-072-20240205   gcc  
x86_64                randconfig-073-20240205   clang
x86_64                randconfig-074-20240205   clang
x86_64                randconfig-075-20240205   gcc  
x86_64                randconfig-076-20240205   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                randconfig-001-20240205   gcc  
xtensa                randconfig-002-20240205   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

