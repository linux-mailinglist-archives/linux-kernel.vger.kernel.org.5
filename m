Return-Path: <linux-kernel+bounces-66723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248C8560B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188FB1F2418F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA2B12AADA;
	Thu, 15 Feb 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHQocX0N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948883A04
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994652; cv=none; b=lUXHJ7QSRHiGu4DsOpRGvs+t4fe2+75pBv/hbVmYlcgv1M0IU/GNRv5DP8DXIQEAwENzOnEjetPPo8Sj6bmKkUJ5cwOvkSFyUeaFDmAo3Z6CSZbv0sj7jbfamrcPI3AwoRiHV9kE2YjctsmnRsW6RemA8zFZDsUsKqOBeHM5Gn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994652; c=relaxed/simple;
	bh=fia32X7UBkpe3dW/uCV30sxHEtkvNs3IFKVG0jds3Xg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZUqUdv8tE7iTwqtQZHeWXJrfs4F5tYCPWuJRLpC5z3qs4ojUuI+odHKdhDFd2pxgQVVd097EYdEfDh3dl4Gu7HUkC5coORx3NdvaXCzfSAxr82qheVi+5BEhOmi69imOoOyuSTl8f38G52CXEn+/A1hE9nuO+NVP2plMMggE1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHQocX0N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707994650; x=1739530650;
  h=date:from:to:cc:subject:message-id;
  bh=fia32X7UBkpe3dW/uCV30sxHEtkvNs3IFKVG0jds3Xg=;
  b=mHQocX0NIv7g3h5GEdXhlJtdfzBGrjVLn67K4FSizxLk8N3qluHj719Z
   wU2lGPJBqlBgTf8Ni8aocHr7wIrW+c5gAguhZoY/SY5F5RPSYcZ6KCEQ1
   ApjJVq/+dhh2LwcvxyjN/aiBIozUQLjEnMuwpo61W93DgEGJM2AgYPVIr
   dy+Bs0kTFC+dRS0xVsjolf1P/Fm/ACe6D9jJWP9eWUKeH/isY50SYS4xK
   WU7cjmd3fR+BnIqMwntPbxhp3yjvDsXRQRTNar1KxCmsBoQ/9u//GA1Lo
   rYmcFsSJBW0VgZnYjrIqRWH9pQo7CqVUBqO4FswCAIhZ+ZR++CzjqyWjO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1948591"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1948591"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 02:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3460932"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 15 Feb 2024 02:56:52 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raZPb-0000QS-0W;
	Thu, 15 Feb 2024 10:56:37 +0000
Date: Thu, 15 Feb 2024 18:55:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 218b13db258c091e646857fc962ef45fe2163054
Message-ID: <202402151840.iW7Gvdz6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 218b13db258c091e646857fc962ef45fe2163054  Merge branch 'x86/core' into x86/merge, to ease integration testing

elapsed time: 1445m

configs tested: 150
configs skipped: 2

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
arc                   randconfig-001-20240215   gcc  
arc                   randconfig-002-20240215   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   clang
arm                                 defconfig   clang
arm                          ep93xx_defconfig   clang
arm                      integrator_defconfig   clang
arm                   randconfig-001-20240215   clang
arm                   randconfig-002-20240215   gcc  
arm                   randconfig-003-20240215   gcc  
arm                   randconfig-004-20240215   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear6xx_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240215   clang
arm64                 randconfig-002-20240215   clang
arm64                 randconfig-003-20240215   gcc  
arm64                 randconfig-004-20240215   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240215   gcc  
csky                  randconfig-002-20240215   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240215   clang
hexagon               randconfig-002-20240215   clang
i386         buildonly-randconfig-001-20240215   clang
i386         buildonly-randconfig-002-20240215   clang
i386         buildonly-randconfig-003-20240215   clang
i386         buildonly-randconfig-004-20240215   clang
i386         buildonly-randconfig-005-20240215   clang
i386         buildonly-randconfig-006-20240215   clang
i386                  randconfig-001-20240215   gcc  
i386                  randconfig-002-20240215   gcc  
i386                  randconfig-003-20240215   clang
i386                  randconfig-004-20240215   gcc  
i386                  randconfig-005-20240215   gcc  
i386                  randconfig-006-20240215   gcc  
i386                  randconfig-011-20240215   clang
i386                  randconfig-012-20240215   clang
i386                  randconfig-013-20240215   gcc  
i386                  randconfig-014-20240215   gcc  
i386                  randconfig-015-20240215   clang
i386                  randconfig-016-20240215   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240215   gcc  
loongarch             randconfig-002-20240215   gcc  
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
nios2                 randconfig-001-20240215   gcc  
nios2                 randconfig-002-20240215   gcc  
openrisc                         allyesconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240215   gcc  
parisc                randconfig-002-20240215   gcc  
powerpc                          allmodconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      makalu_defconfig   clang
powerpc               randconfig-001-20240215   gcc  
powerpc               randconfig-002-20240215   clang
powerpc               randconfig-003-20240215   clang
powerpc                     tqm8555_defconfig   clang
powerpc64             randconfig-001-20240215   clang
powerpc64             randconfig-002-20240215   gcc  
powerpc64             randconfig-003-20240215   clang
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                 randconfig-001-20240215   gcc  
riscv                 randconfig-002-20240215   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240215   clang
s390                  randconfig-002-20240215   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240215   gcc  
sh                    randconfig-002-20240215   gcc  
sh                           se7343_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240215   gcc  
sparc64               randconfig-002-20240215   gcc  
um                               allmodconfig   clang
um                               allyesconfig   gcc  
um                    randconfig-001-20240215   gcc  
um                    randconfig-002-20240215   gcc  
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-001-20240215   clang
x86_64       buildonly-randconfig-002-20240215   clang
x86_64       buildonly-randconfig-003-20240215   gcc  
x86_64       buildonly-randconfig-004-20240215   gcc  
x86_64       buildonly-randconfig-005-20240215   clang
x86_64       buildonly-randconfig-006-20240215   gcc  
x86_64                randconfig-001-20240215   clang
x86_64                randconfig-002-20240215   clang
x86_64                randconfig-003-20240215   gcc  
x86_64                randconfig-004-20240215   clang
x86_64                randconfig-005-20240215   clang
x86_64                randconfig-006-20240215   clang
x86_64                randconfig-011-20240215   gcc  
x86_64                randconfig-012-20240215   gcc  
x86_64                randconfig-013-20240215   gcc  
x86_64                randconfig-014-20240215   gcc  
x86_64                randconfig-015-20240215   gcc  
x86_64                randconfig-016-20240215   clang
x86_64                randconfig-071-20240215   clang
x86_64                randconfig-072-20240215   clang
x86_64                randconfig-073-20240215   gcc  
x86_64                randconfig-074-20240215   gcc  
x86_64                randconfig-075-20240215   clang
x86_64                randconfig-076-20240215   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240215   gcc  
xtensa                randconfig-002-20240215   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

