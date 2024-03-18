Return-Path: <linux-kernel+bounces-106758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2587F32B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7901C21653
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805D5A4E2;
	Mon, 18 Mar 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGSve2qc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5159143
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801499; cv=none; b=JfpfvSMI/O/eUziBKTtc4P2r3kyg69n92KnLcJbFcE7RRx8P68y5tXj+7aK4uPRd5tYLD9E9B5KhFsqNQ9bHS5afv6TKlKn01jOGBsr94liiK5fNJXODqyRS0qceRp/KFlP6m1mapw9kqFqNiWwPcXB99xYXHfTMIprjERdM52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801499; c=relaxed/simple;
	bh=M0gk58ZvOSNbqp2Xq96HYaQFGVPw2HHu5ok6aGvmEYU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o4G/jEmdgPN7ApfWZ6eC97vMOSlkV8vXMTE4BlvXdrs8zwLcmGFddoRxNfScrUcuxMksZVvOn5OAmBefzoUwu9Ck/nmyKqYaEnQFKtf1C9qeVrGzLdW4oYrI/55t7hcX7B9eaChjrhVXljXqexLmrUopbvRuWbdopfIOnCE8NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGSve2qc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710801497; x=1742337497;
  h=date:from:to:cc:subject:message-id;
  bh=M0gk58ZvOSNbqp2Xq96HYaQFGVPw2HHu5ok6aGvmEYU=;
  b=mGSve2qcCKBg6LZF+lncLLZdmBdyTd2SXM2odkN5MPEtj89X+M3awwKK
   bGsqQcumQVimfSdh8zHDKgfXb60YlQvf/uKcJ4hw8YOZREaCCm/9qZG83
   cJ5YQ1yDQFi0u9BDpOV2eHJIoh8juKK7aLhNe3RPlMb0e1U0F8iiNzW5Z
   kk8s/JDERc5L5s9JNQyI98p7yHdblx7ImIxv1xxI15iGEacmX+u25CbGy
   4BF46lhx/di8C97hPBDdGkfbl1D5P9LXU0LW+SR1WBtdKjvDTKxSN0A+s
   j1Cizzb2TfaOy+0KeAY2xbxbyG57tPPs5/nvliCV4x2zBbEKjBCKqTWzn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5491878"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5491878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 15:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="44550724"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Mar 2024 15:38:16 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmLcT-000HI9-18;
	Mon, 18 Mar 2024 22:38:13 +0000
Date: Tue, 19 Mar 2024 06:37:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 86c54c846e126d6f7cbfacefa0cfeaed6f67207b
Message-ID: <202403190645.OeFz3ZTd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 86c54c846e126d6f7cbfacefa0cfeaed6f67207b  Merge tag 'timers-v6.9-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 728m

configs tested: 180
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
arc                   randconfig-001-20240319   gcc  
arc                   randconfig-002-20240319   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240319   clang
arm                   randconfig-002-20240319   gcc  
arm                   randconfig-003-20240319   clang
arm                   randconfig-004-20240319   clang
arm                       spear13xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240319   gcc  
arm64                 randconfig-002-20240319   clang
arm64                 randconfig-003-20240319   clang
arm64                 randconfig-004-20240319   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240319   gcc  
csky                  randconfig-002-20240319   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240319   clang
hexagon               randconfig-002-20240319   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240318   gcc  
i386         buildonly-randconfig-002-20240318   clang
i386         buildonly-randconfig-003-20240318   clang
i386         buildonly-randconfig-004-20240318   clang
i386         buildonly-randconfig-005-20240318   gcc  
i386         buildonly-randconfig-006-20240318   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240318   gcc  
i386                  randconfig-002-20240318   clang
i386                  randconfig-003-20240318   gcc  
i386                  randconfig-004-20240318   gcc  
i386                  randconfig-005-20240318   gcc  
i386                  randconfig-006-20240318   gcc  
i386                  randconfig-011-20240318   gcc  
i386                  randconfig-012-20240318   clang
i386                  randconfig-013-20240318   clang
i386                  randconfig-014-20240318   clang
i386                  randconfig-015-20240318   clang
i386                  randconfig-016-20240318   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240319   gcc  
loongarch             randconfig-002-20240319   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                         db1xxx_defconfig   clang
mips                           ip22_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240319   gcc  
nios2                 randconfig-002-20240319   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240319   gcc  
parisc                randconfig-002-20240319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   clang
powerpc                     mpc83xx_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc               randconfig-001-20240319   gcc  
powerpc               randconfig-002-20240319   clang
powerpc               randconfig-003-20240319   clang
powerpc64             randconfig-001-20240319   gcc  
powerpc64             randconfig-002-20240319   clang
powerpc64             randconfig-003-20240319   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240319   gcc  
riscv                 randconfig-002-20240319   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240319   gcc  
s390                  randconfig-002-20240319   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240319   gcc  
sh                    randconfig-002-20240319   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240319   gcc  
sparc64               randconfig-002-20240319   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240319   gcc  
um                    randconfig-002-20240319   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240318   gcc  
x86_64       buildonly-randconfig-002-20240318   gcc  
x86_64       buildonly-randconfig-003-20240318   gcc  
x86_64       buildonly-randconfig-004-20240318   gcc  
x86_64       buildonly-randconfig-005-20240318   gcc  
x86_64       buildonly-randconfig-006-20240318   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240318   gcc  
x86_64                randconfig-002-20240318   clang
x86_64                randconfig-003-20240318   clang
x86_64                randconfig-004-20240318   clang
x86_64                randconfig-005-20240318   clang
x86_64                randconfig-006-20240318   gcc  
x86_64                randconfig-011-20240318   clang
x86_64                randconfig-012-20240318   clang
x86_64                randconfig-013-20240318   gcc  
x86_64                randconfig-014-20240318   gcc  
x86_64                randconfig-015-20240318   clang
x86_64                randconfig-016-20240318   gcc  
x86_64                randconfig-071-20240318   gcc  
x86_64                randconfig-072-20240318   gcc  
x86_64                randconfig-073-20240318   gcc  
x86_64                randconfig-074-20240318   clang
x86_64                randconfig-075-20240318   gcc  
x86_64                randconfig-076-20240318   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240319   gcc  
xtensa                randconfig-002-20240319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

