Return-Path: <linux-kernel+bounces-108950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5D881262
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34D21C2105D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404744370;
	Wed, 20 Mar 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXm+aFka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F442067
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941641; cv=none; b=HIny5DFZhLYpu4/TtK2ZzmwTLoiGumtj7wKtk95SAdyQQJq6dUPQa3sKgUfmYQQGqXBe3d+6FCCAVy+Y9lx/A8ejKf8ZScTxayxlBS9Oab+C6t6nB+uBFhQMqSwgHoFoVodCholsq4TQyvMXMKXbpH7t83Qgi/q7XsAGpMhZLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941641; c=relaxed/simple;
	bh=hSKTlPhRg47+D8pqtRT94nWWyBvg0cktU+5oR2P4CJY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q1tnnxED1Eg1jrf7BTLl+SIj6AhCl5+y6r5RIWm4JguMyZLSwciFKxwdVCv4m4XaUz0T80UVRhhoe5hWhnFLsuqQ6dAjHEsDyFlvy/GWdjjFqNknOb+9TNEAH/iG8eTk2B4aY9XbEl3MLNkqqrZcPOfT95qxagUvTeAh3Iaw5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXm+aFka; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710941638; x=1742477638;
  h=date:from:to:cc:subject:message-id;
  bh=hSKTlPhRg47+D8pqtRT94nWWyBvg0cktU+5oR2P4CJY=;
  b=gXm+aFkabjcgPRFoMvr4nO/+lgL0B/S4yiXMLI7Lia8nA6NOxRkKOiof
   MbxiP4z94swSIfMZh3dk8j20RAYMTzaXDI9uS2rUQwdE/EG4tx/IEbN8K
   Mv5KpXNeeCiamsCrXQyEjY3EZ0mz6KrvzNFlESP2pcXVcXsRftn9Pv6F9
   3kJDiSAdIBySX+JL0Ncrx9+8lOKIlAuTIeMhPC1lMh33hK2nLyl2XZcMl
   plNvoTvBL6iUqVzdOCgbONfvQl0exoL+Zoqx1cvpO/RQlVaZkiQeqGDnC
   MLC9vlmcddXdiFO76TxXttsFFVtM+GmcqrPmErvkcE6aCtS3M/gEVzorG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23321750"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23321750"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 06:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14799743"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Mar 2024 06:33:11 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmw44-000Idn-23;
	Wed, 20 Mar 2024 13:33:08 +0000
Date: Wed, 20 Mar 2024 21:32:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240318-commit-by-commit]
 BUILD SUCCESS 9b232d3c29109ce6b2370d4fef8dd1d47d301559
Message-ID: <202403202134.fzgfPo2i-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240318-commit-by-commit
branch HEAD: 9b232d3c29109ce6b2370d4fef8dd1d47d301559  cgroup: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 727m

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
arc                   randconfig-001-20240320   gcc  
arc                   randconfig-002-20240320   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   clang
arm                         mv78xx0_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240320   gcc  
arm                   randconfig-002-20240320   gcc  
arm                   randconfig-003-20240320   gcc  
arm                   randconfig-004-20240320   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240320   clang
arm64                 randconfig-002-20240320   gcc  
arm64                 randconfig-003-20240320   clang
arm64                 randconfig-004-20240320   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240320   gcc  
csky                  randconfig-002-20240320   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240320   clang
hexagon               randconfig-002-20240320   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240320   clang
i386         buildonly-randconfig-002-20240320   gcc  
i386         buildonly-randconfig-003-20240320   gcc  
i386         buildonly-randconfig-004-20240320   clang
i386         buildonly-randconfig-005-20240320   gcc  
i386         buildonly-randconfig-006-20240320   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240320   clang
i386                  randconfig-002-20240320   clang
i386                  randconfig-003-20240320   clang
i386                  randconfig-004-20240320   clang
i386                  randconfig-005-20240320   clang
i386                  randconfig-006-20240320   gcc  
i386                  randconfig-011-20240320   clang
i386                  randconfig-012-20240320   clang
i386                  randconfig-013-20240320   clang
i386                  randconfig-014-20240320   clang
i386                  randconfig-015-20240320   gcc  
i386                  randconfig-016-20240320   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240320   gcc  
loongarch             randconfig-002-20240320   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240320   gcc  
nios2                 randconfig-002-20240320   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240320   gcc  
parisc                randconfig-002-20240320   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc               randconfig-001-20240320   gcc  
powerpc               randconfig-002-20240320   clang
powerpc               randconfig-003-20240320   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240320   gcc  
powerpc64             randconfig-002-20240320   gcc  
powerpc64             randconfig-003-20240320   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240320   clang
riscv                 randconfig-002-20240320   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240320   clang
s390                  randconfig-002-20240320   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240320   gcc  
sh                    randconfig-002-20240320   gcc  
sh                          rsk7201_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240320   gcc  
sparc64               randconfig-002-20240320   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240320   gcc  
um                    randconfig-002-20240320   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240320   gcc  
x86_64       buildonly-randconfig-002-20240320   clang
x86_64       buildonly-randconfig-003-20240320   clang
x86_64       buildonly-randconfig-004-20240320   clang
x86_64       buildonly-randconfig-005-20240320   gcc  
x86_64       buildonly-randconfig-006-20240320   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240320   clang
x86_64                randconfig-002-20240320   clang
x86_64                randconfig-003-20240320   gcc  
x86_64                randconfig-004-20240320   clang
x86_64                randconfig-005-20240320   clang
x86_64                randconfig-006-20240320   clang
x86_64                randconfig-011-20240320   gcc  
x86_64                randconfig-012-20240320   gcc  
x86_64                randconfig-013-20240320   gcc  
x86_64                randconfig-014-20240320   gcc  
x86_64                randconfig-015-20240320   clang
x86_64                randconfig-016-20240320   gcc  
x86_64                randconfig-071-20240320   clang
x86_64                randconfig-072-20240320   gcc  
x86_64                randconfig-073-20240320   clang
x86_64                randconfig-074-20240320   gcc  
x86_64                randconfig-075-20240320   gcc  
x86_64                randconfig-076-20240320   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240320   gcc  
xtensa                randconfig-002-20240320   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

