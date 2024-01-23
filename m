Return-Path: <linux-kernel+bounces-34685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE0838620
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8210628C71F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281F4403;
	Tue, 23 Jan 2024 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0DD+lDr"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCD3C2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705981463; cv=none; b=tB4dvqxQEVzD9D3jOtTg9OUQ+5/MZkSbSviBIwYU3etn2ahSqDEPbjpR5AD9K8jFTui7usKWxVArvAy2/pFh0e1ifqmfvEiq6iDYL+P0ep3FxgM3Wbbbvg+el4n0ZYsaiFGSwD5L95UMrcUC5YB3Be900/UWLlY1WdzgumFE1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705981463; c=relaxed/simple;
	bh=0QFl14KU9CPQfyc3U9smbcZC9DRQhUktE9JIHe9F0tw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EyK5cjgrtKgosygw3fntMWYPJxbzppJpwVgFdN1onGiGom6btuQtTX1xohYombOgldNbnsZMAtKyTe5q7qyOds87aOJyrevS3u2KyIXCYZ71NzqQ33prjcEBa1QOO6ZMepP6qIUzuGc12EsdMZe5i+9RTpEZ8USBD4mcapjkJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0DD+lDr; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705981462; x=1737517462;
  h=date:from:to:cc:subject:message-id;
  bh=0QFl14KU9CPQfyc3U9smbcZC9DRQhUktE9JIHe9F0tw=;
  b=a0DD+lDrlbQEU8EFMPHPOwCns2kY2grNexDHkRbr3/VGOLtM9H250RdH
   0tP6ciFMqiDBI5YuLNKOEHbNgsEeW8ifD99Rj+Kft//woHtb3AF0C61RH
   igW+gRKhRVLuP42xBnvEBN7rHNLb4NuoxJmQVOYkornXtYGygtWsLsaVo
   cWvNNjXVd6MChi8uJhig4oa0EnnSxiwbxWqpZoI2Ua3bwlcJPZy7BU7Rd
   OXzHDq1X8Y7lkQi0xl08OFxi2HNN0j+DjxVEY/TLfLuM82ncnEq/E98Fj
   n/PsGFMGh/EaodtTvDznXz7RpdPa0woBYoYEc2b3Gr3JV3s4omJOTcUZe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="401061077"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="401061077"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 19:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="856182100"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="856182100"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2024 19:44:20 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rS7hy-00079Q-1R;
	Tue, 23 Jan 2024 03:44:18 +0000
Date: Tue, 23 Jan 2024 11:43:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.8-rc1-Wstringop-overflow] BUILD
 SUCCESS a5e0ace04fbf56c1794b1a2fa7a93672753b3fc7
Message-ID: <202401231134.liEAF2wF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.8-rc1-Wstringop-overflow
branch HEAD: a5e0ace04fbf56c1794b1a2fa7a93672753b3fc7  init: Kconfig: Disable -Wstringop-overflow for GCC-11

elapsed time: 1585m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240123   gcc  
arc                   randconfig-002-20240123   gcc  
arm                               allnoconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   gcc  
arm                   randconfig-001-20240123   gcc  
arm                   randconfig-002-20240123   gcc  
arm                   randconfig-003-20240123   gcc  
arm                   randconfig-004-20240123   gcc  
arm                       spear13xx_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240123   gcc  
arm64                 randconfig-002-20240123   gcc  
arm64                 randconfig-003-20240123   gcc  
arm64                 randconfig-004-20240123   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240123   gcc  
csky                  randconfig-002-20240123   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240123   clang
hexagon               randconfig-002-20240123   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240122   clang
i386         buildonly-randconfig-002-20240122   clang
i386         buildonly-randconfig-003-20240122   clang
i386         buildonly-randconfig-004-20240122   clang
i386         buildonly-randconfig-005-20240122   clang
i386         buildonly-randconfig-006-20240122   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240122   clang
i386                  randconfig-002-20240122   clang
i386                  randconfig-003-20240122   clang
i386                  randconfig-004-20240122   clang
i386                  randconfig-005-20240122   clang
i386                  randconfig-006-20240122   clang
i386                  randconfig-011-20240122   gcc  
i386                  randconfig-012-20240122   gcc  
i386                  randconfig-013-20240122   gcc  
i386                  randconfig-014-20240122   gcc  
i386                  randconfig-015-20240122   gcc  
i386                  randconfig-016-20240122   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240123   gcc  
loongarch             randconfig-002-20240123   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                      maltaaprp_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240123   gcc  
nios2                 randconfig-002-20240123   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240123   gcc  
parisc                randconfig-002-20240123   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc               randconfig-001-20240123   gcc  
powerpc               randconfig-002-20240123   gcc  
powerpc               randconfig-003-20240123   gcc  
powerpc64             randconfig-001-20240123   gcc  
powerpc64             randconfig-002-20240123   gcc  
powerpc64             randconfig-003-20240123   gcc  
riscv                             allnoconfig   clang
riscv                 randconfig-001-20240123   gcc  
riscv                 randconfig-002-20240123   gcc  
s390                  randconfig-001-20240123   clang
s390                  randconfig-002-20240123   clang
sh                               allmodconfig   gcc  
sh                    randconfig-001-20240123   gcc  
sh                    randconfig-002-20240123   gcc  
sparc64               randconfig-001-20240123   gcc  
sparc64               randconfig-002-20240123   gcc  
um                    randconfig-001-20240123   gcc  
um                    randconfig-002-20240123   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240123   gcc  
xtensa                randconfig-002-20240123   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

