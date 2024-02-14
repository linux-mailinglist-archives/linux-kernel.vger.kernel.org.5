Return-Path: <linux-kernel+bounces-65168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9748548D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDA21C2219C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EB1AADE;
	Wed, 14 Feb 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjQnSix4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B111AAD0
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911874; cv=none; b=mTJ3RCCy5EbSfw0kQ29cttND4FMIYmp/seT7IEA3mwNIpKkyzaMH7JVLjFKsnL1o9Ao+eyp8VFfV0gUT2SnzaXqEQfYoiGFGyHXm2XvJKi9u/B68EtJZm44Gv7Uzd1M/SD4E7CA9jtqy4+BB68wdDRrS1n7aGFRx1zwZyNTWS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911874; c=relaxed/simple;
	bh=UKAAU+vIRFFzjkSnpzVg/QisXytclYahNbqRMy4jcWg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QOeTu4J3/TRwuXWb/NUY3bfzGDnPC7Ny2bJGUsNcj8U6gZqvu1c+64YCTN/oGS4h8MdJf+I2Scg7Z1TJHi4PCqhV1kwsS6dBxmUreyzsyz4FVuUvx2RGnJUwitUUWNgIfPc4AZpZVSiF9x70ugcFhW2L4R7xYGbyMqRWhbhKgsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjQnSix4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707911872; x=1739447872;
  h=date:from:to:cc:subject:message-id;
  bh=UKAAU+vIRFFzjkSnpzVg/QisXytclYahNbqRMy4jcWg=;
  b=QjQnSix4mjIDHACEsgXP2IjKhPTyZ240ZCn1q0ZqeJypu3eIsI5N6hMi
   BiRjX/9oAZv+NK5FwJto1V0d/7CFrrON47at9UhqiAZxRSI3ukhQOvRQN
   H2lV3ILERt2fclLhhX1ZkAN3tw5L8IlPlmk4aASgx3JuFp64g4TW1dA4B
   v+Xpdi7T2r4bHzzkNjZjnl+cQ/Kf1OT20r1Upe2xBpHtc4qQ7sK/LMFif
   Svm7G3fkOEqiIK+VR+IYLVkYCN7tPakpSgp4fjzJS2WkMES8+oLjFQrbY
   60TznW2y6G7+8cdD2sOtfl/kba1beoAoEya046IsHM+i3z2cb8cNq+FXD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12584134"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="12584134"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 03:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3149161"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2024 03:57:51 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raDtb-0008jo-1b;
	Wed, 14 Feb 2024 11:57:47 +0000
Date: Wed, 14 Feb 2024 19:57:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 ee8ff8768735edc3e013837c4416f819543ddc17
Message-ID: <202402141913.3gmZADsZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: ee8ff8768735edc3e013837c4416f819543ddc17  crypto: ccp - Have it depend on AMD_IOMMU

elapsed time: 1449m

configs tested: 178
configs skipped: 4

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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240214   gcc  
arc                   randconfig-002-20240214   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240214   clang
arm                   randconfig-002-20240214   gcc  
arm                   randconfig-003-20240214   clang
arm                   randconfig-004-20240214   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240214   clang
arm64                 randconfig-002-20240214   clang
arm64                 randconfig-003-20240214   gcc  
arm64                 randconfig-004-20240214   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240214   gcc  
csky                  randconfig-002-20240214   gcc  
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240214   clang
hexagon               randconfig-002-20240214   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240214   clang
i386         buildonly-randconfig-002-20240214   clang
i386         buildonly-randconfig-003-20240214   clang
i386         buildonly-randconfig-004-20240214   gcc  
i386         buildonly-randconfig-005-20240214   gcc  
i386         buildonly-randconfig-006-20240214   clang
i386                                defconfig   clang
i386                  randconfig-001-20240214   clang
i386                  randconfig-002-20240214   clang
i386                  randconfig-003-20240214   clang
i386                  randconfig-004-20240214   gcc  
i386                  randconfig-005-20240214   clang
i386                  randconfig-006-20240214   gcc  
i386                  randconfig-011-20240214   clang
i386                  randconfig-012-20240214   gcc  
i386                  randconfig-013-20240214   gcc  
i386                  randconfig-014-20240214   gcc  
i386                  randconfig-015-20240214   clang
i386                  randconfig-016-20240214   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240214   gcc  
loongarch             randconfig-002-20240214   gcc  
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
mips                        bcm63xx_defconfig   clang
mips                  decstation_64_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240214   gcc  
nios2                 randconfig-002-20240214   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240214   gcc  
parisc                randconfig-002-20240214   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc               randconfig-001-20240214   clang
powerpc               randconfig-002-20240214   clang
powerpc               randconfig-003-20240214   clang
powerpc                      walnut_defconfig   gcc  
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240214   clang
powerpc64             randconfig-002-20240214   clang
powerpc64             randconfig-003-20240214   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240214   clang
riscv                 randconfig-002-20240214   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240214   clang
s390                  randconfig-002-20240214   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240214   gcc  
sh                    randconfig-002-20240214   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240214   gcc  
sparc64               randconfig-002-20240214   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240214   clang
um                    randconfig-002-20240214   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240214   gcc  
x86_64       buildonly-randconfig-002-20240214   clang
x86_64       buildonly-randconfig-003-20240214   gcc  
x86_64       buildonly-randconfig-004-20240214   gcc  
x86_64       buildonly-randconfig-005-20240214   gcc  
x86_64       buildonly-randconfig-006-20240214   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240214   clang
x86_64                randconfig-002-20240214   gcc  
x86_64                randconfig-003-20240214   clang
x86_64                randconfig-004-20240214   gcc  
x86_64                randconfig-005-20240214   clang
x86_64                randconfig-006-20240214   clang
x86_64                randconfig-011-20240214   clang
x86_64                randconfig-012-20240214   clang
x86_64                randconfig-013-20240214   gcc  
x86_64                randconfig-014-20240214   gcc  
x86_64                randconfig-015-20240214   clang
x86_64                randconfig-016-20240214   clang
x86_64                randconfig-071-20240214   gcc  
x86_64                randconfig-072-20240214   clang
x86_64                randconfig-073-20240214   gcc  
x86_64                randconfig-074-20240214   clang
x86_64                randconfig-075-20240214   clang
x86_64                randconfig-076-20240214   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240214   gcc  
xtensa                randconfig-002-20240214   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

