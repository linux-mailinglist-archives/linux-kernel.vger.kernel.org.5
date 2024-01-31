Return-Path: <linux-kernel+bounces-45508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A57F8431A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B63DB221E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1236C;
	Wed, 31 Jan 2024 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On+lgv2m"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E475363
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659432; cv=none; b=uL6dM45rEpyHRAX1Ry8uTEURWWobw7LjQ1SQHbcJXlPKvHLpB3E8JkdcHQSkx7JeiLUv/79zZTHDK/eavx76IU5mC0yGI5Z3HhWpU9ntkEcDVfP+hPrI7V9JD9jtRmDYAoANuv0OTWZBR8cpml23gF46om53iNt8gytHaAXWXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659432; c=relaxed/simple;
	bh=b9jRkCNzA1IaTzODrwI+blTwU1a3dLW0yo9KTMFRGOA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jlJ6/95wZmi6pDKPA7EomjxWZXy+OitcNjWhmT8nrPVxjPMAkUOdGPJLdpe+Ekd8IEV77bLhA0CDP3lzHtEszaaEVGUdI+a9vsk/nTbakdeSulP8TQhKmtiUaDiPCH6CX1NRGWV3dhJQ1sJCb34EhuYGCvHQyZdIpAZN3wvpVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On+lgv2m; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706659430; x=1738195430;
  h=date:from:to:cc:subject:message-id;
  bh=b9jRkCNzA1IaTzODrwI+blTwU1a3dLW0yo9KTMFRGOA=;
  b=On+lgv2m2GZWOsJ98cGtMGg52DKea3/vvB9EGreDfSIhxQ5DC91PRu14
   VxvaPI65b/9ZMSOuY+Ch/oDqFOlFFqUsvcHYx1GWTm952HQLz65XTGSPl
   oLRs1aQo3si0/73ehPRv10RSISIdifkXwF2aZX1HpJWqDo+75EWhu2Wi8
   eBLhtUa6cl2nU7Ay/2ZxLTtNO2/fzEXC+qOXbupxZoXlvhsBKnRDsSwK0
   Hf0Co6tbXeBy56PboGBcvZlsOuWbhirsKu5xD1bjrfpnY5E728rlma31y
   r+VPxfgy5IO0j9cWcHQ7o9/nCoMTgBzgWgDYbIus3PyhePdu59PlkXelj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="434612529"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="434612529"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 16:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3920305"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jan 2024 16:03:48 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUy4p-0000xa-2k;
	Wed, 31 Jan 2024 00:03:39 +0000
Date: Wed, 31 Jan 2024 08:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a6f0b57202b0ee50dc042bae16494008dc6dc992
Message-ID: <202401310802.PHFWeFn3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a6f0b57202b0ee50dc042bae16494008dc6dc992  Merge branch into tip/master: 'x86/sev'

elapsed time: 756m

configs tested: 213
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
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240130   gcc  
arc                   randconfig-001-20240131   gcc  
arc                   randconfig-002-20240130   gcc  
arc                   randconfig-002-20240131   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                                 defconfig   clang
arm                      integrator_defconfig   gcc  
arm                        neponset_defconfig   clang
arm                   randconfig-001-20240130   gcc  
arm                   randconfig-001-20240131   clang
arm                   randconfig-002-20240130   gcc  
arm                   randconfig-002-20240131   clang
arm                   randconfig-003-20240130   gcc  
arm                   randconfig-003-20240131   clang
arm                   randconfig-004-20240130   gcc  
arm                   randconfig-004-20240131   clang
arm                        spear6xx_defconfig   gcc  
arm                           spitz_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240130   gcc  
arm64                 randconfig-001-20240131   clang
arm64                 randconfig-002-20240130   gcc  
arm64                 randconfig-002-20240131   clang
arm64                 randconfig-003-20240130   gcc  
arm64                 randconfig-003-20240131   clang
arm64                 randconfig-004-20240130   gcc  
arm64                 randconfig-004-20240131   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240130   gcc  
csky                  randconfig-001-20240131   gcc  
csky                  randconfig-002-20240130   gcc  
csky                  randconfig-002-20240131   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240130   clang
hexagon               randconfig-001-20240131   clang
hexagon               randconfig-002-20240130   clang
hexagon               randconfig-002-20240131   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240130   gcc  
i386         buildonly-randconfig-002-20240130   gcc  
i386         buildonly-randconfig-003-20240130   gcc  
i386         buildonly-randconfig-004-20240130   gcc  
i386         buildonly-randconfig-005-20240130   gcc  
i386         buildonly-randconfig-006-20240130   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240130   gcc  
i386                  randconfig-002-20240130   gcc  
i386                  randconfig-003-20240130   gcc  
i386                  randconfig-004-20240130   gcc  
i386                  randconfig-005-20240130   gcc  
i386                  randconfig-006-20240130   gcc  
i386                  randconfig-011-20240130   clang
i386                  randconfig-012-20240130   clang
i386                  randconfig-013-20240130   clang
i386                  randconfig-014-20240130   clang
i386                  randconfig-015-20240130   clang
i386                  randconfig-016-20240130   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240130   gcc  
loongarch             randconfig-001-20240131   gcc  
loongarch             randconfig-002-20240130   gcc  
loongarch             randconfig-002-20240131   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                        bcm63xx_defconfig   clang
mips                           ip27_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240130   gcc  
nios2                 randconfig-001-20240131   gcc  
nios2                 randconfig-002-20240130   gcc  
nios2                 randconfig-002-20240131   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240130   gcc  
parisc                randconfig-001-20240131   gcc  
parisc                randconfig-002-20240130   gcc  
parisc                randconfig-002-20240131   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc               randconfig-001-20240130   gcc  
powerpc               randconfig-001-20240131   clang
powerpc               randconfig-002-20240130   gcc  
powerpc               randconfig-002-20240131   clang
powerpc               randconfig-003-20240130   gcc  
powerpc               randconfig-003-20240131   clang
powerpc64             randconfig-001-20240130   gcc  
powerpc64             randconfig-001-20240131   clang
powerpc64             randconfig-002-20240130   gcc  
powerpc64             randconfig-002-20240131   clang
powerpc64             randconfig-003-20240130   gcc  
powerpc64             randconfig-003-20240131   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240130   gcc  
riscv                 randconfig-001-20240131   clang
riscv                 randconfig-002-20240130   gcc  
riscv                 randconfig-002-20240131   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240130   clang
s390                  randconfig-001-20240131   gcc  
s390                  randconfig-002-20240130   clang
s390                  randconfig-002-20240131   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240130   gcc  
sh                    randconfig-001-20240131   gcc  
sh                    randconfig-002-20240130   gcc  
sh                    randconfig-002-20240131   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240130   gcc  
sparc64               randconfig-001-20240131   gcc  
sparc64               randconfig-002-20240131   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240131   clang
um                    randconfig-002-20240131   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240130   gcc  
x86_64       buildonly-randconfig-002-20240130   gcc  
x86_64       buildonly-randconfig-003-20240130   gcc  
x86_64       buildonly-randconfig-004-20240130   gcc  
x86_64       buildonly-randconfig-005-20240130   gcc  
x86_64       buildonly-randconfig-006-20240130   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240130   clang
x86_64                randconfig-002-20240130   clang
x86_64                randconfig-003-20240130   clang
x86_64                randconfig-004-20240130   clang
x86_64                randconfig-005-20240130   clang
x86_64                randconfig-006-20240130   clang
x86_64                randconfig-011-20240130   gcc  
x86_64                randconfig-012-20240130   gcc  
x86_64                randconfig-013-20240130   gcc  
x86_64                randconfig-014-20240130   gcc  
x86_64                randconfig-015-20240130   gcc  
x86_64                randconfig-016-20240130   gcc  
x86_64                randconfig-071-20240130   gcc  
x86_64                randconfig-072-20240130   gcc  
x86_64                randconfig-073-20240130   gcc  
x86_64                randconfig-074-20240130   gcc  
x86_64                randconfig-075-20240130   gcc  
x86_64                randconfig-076-20240130   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240131   gcc  
xtensa                randconfig-002-20240131   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

