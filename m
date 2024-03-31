Return-Path: <linux-kernel+bounces-126036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10FC89313D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41728B216E3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D65143C61;
	Sun, 31 Mar 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ/xmLu8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3672900
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711881627; cv=none; b=JhbfIXtSdBBMXxJVM7BHD44x06AiOLMTwt/zsxU26KqKfcHwyXJ7z76wRk3BfIq493pCeV+Si9Fy0RPG2jVrjuCGpYd6pzppfqz6u5Bu8kqa83F486PbcAPFMFpGw7lKgrj9oWVits0i+9V+0bgmom2rLE6Xf77O0l/o0UrcVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711881627; c=relaxed/simple;
	bh=B7wdfTO5y9PSZuJIEc3QakkJdOZPrBBR1sCu9EmM5TY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S97uj80JxATt7OwsspwatAd1rx5LTkxxDOjeYude9xN5QP16A1b+jnq3tWMUzMlQXlKez/N7RHKIdXYkiB1mLtgRez4hdMw84h0qAIF9AKtc6KvhF3/B6brVcfuJPdLT2wGTJPe0e+OlB956jCaqsaguK0dQ4cLYL+WjNBuDDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ/xmLu8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711881625; x=1743417625;
  h=date:from:to:cc:subject:message-id;
  bh=B7wdfTO5y9PSZuJIEc3QakkJdOZPrBBR1sCu9EmM5TY=;
  b=ZJ/xmLu8XAhsHvvhXO5eOan1h7dgpDn844jz8Ho/omGnSDANrSgkehO1
   Bjf2Z6UDtAOR5/1+wMQM3vye6kncuL6bZc34teyTTbAonKClOzaXkWmBe
   BxeVI1lS118P8E5HL8odN8TpIU/ln9fInmJ6kDvPy/ThpnRLSA9/4KegQ
   QGRUSF8AQFzf+sWZ32a8KMCQDcilVeijSkXoJOTpMxJcIxu7IDg80Cnyb
   jvo6zI8ZiqWsshbLmWZYwEHEIRToC6htZYhEPIPVocELD2rO93V5o2xuY
   0XEtdNGmmV2/nqTuYwTxPXzQkt/gl9zx09CgmQlx8G6DxdIiRwfogMr8a
   A==;
X-CSE-ConnectionGUID: p0igyI9KQbWamvtQnFn47A==
X-CSE-MsgGUID: UUAgpfStQG+eE5mHZykeig==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="18388909"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18388909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 03:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="48636423"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Mar 2024 03:40:23 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqsbt-00012K-0H;
	Sun, 31 Mar 2024 10:40:21 +0000
Date: Sun, 31 Mar 2024 18:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 6205125bd326ed0153e5f9da3c4689fe60ae885a
Message-ID: <202403311834.nGQGbpmD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 6205125bd326ed0153e5f9da3c4689fe60ae885a  objtool: Fix compile failure when using the x32 compiler

elapsed time: 793m

configs tested: 154
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
arc                   randconfig-001-20240331   gcc  
arc                   randconfig-002-20240331   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240331   gcc  
arm                   randconfig-002-20240331   gcc  
arm                   randconfig-003-20240331   clang
arm                   randconfig-004-20240331   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240331   gcc  
arm64                 randconfig-002-20240331   gcc  
arm64                 randconfig-003-20240331   gcc  
arm64                 randconfig-004-20240331   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240331   gcc  
csky                  randconfig-002-20240331   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240331   clang
hexagon               randconfig-002-20240331   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240331   clang
i386         buildonly-randconfig-002-20240331   clang
i386         buildonly-randconfig-003-20240331   clang
i386         buildonly-randconfig-004-20240331   gcc  
i386         buildonly-randconfig-005-20240331   gcc  
i386         buildonly-randconfig-006-20240331   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240331   gcc  
i386                  randconfig-002-20240331   gcc  
i386                  randconfig-003-20240331   clang
i386                  randconfig-004-20240331   gcc  
i386                  randconfig-005-20240331   gcc  
i386                  randconfig-006-20240331   gcc  
i386                  randconfig-011-20240331   clang
i386                  randconfig-012-20240331   gcc  
i386                  randconfig-013-20240331   gcc  
i386                  randconfig-014-20240331   gcc  
i386                  randconfig-015-20240331   clang
i386                  randconfig-016-20240331   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240331   gcc  
loongarch             randconfig-002-20240331   gcc  
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
nios2                 randconfig-001-20240331   gcc  
nios2                 randconfig-002-20240331   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240331   gcc  
parisc                randconfig-002-20240331   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240331   clang
powerpc               randconfig-002-20240331   gcc  
powerpc               randconfig-003-20240331   clang
powerpc64             randconfig-001-20240331   clang
powerpc64             randconfig-002-20240331   gcc  
powerpc64             randconfig-003-20240331   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240331   gcc  
riscv                 randconfig-002-20240331   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240331   clang
s390                  randconfig-002-20240331   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240331   gcc  
sh                    randconfig-002-20240331   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240331   gcc  
sparc64               randconfig-002-20240331   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240331   clang
um                    randconfig-002-20240331   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240331   gcc  
x86_64       buildonly-randconfig-002-20240331   clang
x86_64       buildonly-randconfig-003-20240331   clang
x86_64       buildonly-randconfig-004-20240331   clang
x86_64       buildonly-randconfig-005-20240331   clang
x86_64       buildonly-randconfig-006-20240331   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240331   gcc  
x86_64                randconfig-002-20240331   gcc  
x86_64                randconfig-003-20240331   gcc  
x86_64                randconfig-004-20240331   clang
x86_64                randconfig-005-20240331   gcc  
x86_64                randconfig-006-20240331   clang
x86_64                randconfig-011-20240331   gcc  
x86_64                randconfig-012-20240331   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240331   gcc  
xtensa                randconfig-002-20240331   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

