Return-Path: <linux-kernel+bounces-94938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62C8746ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4331C227DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC31B7F7;
	Thu,  7 Mar 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLiWggvA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C181B27D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 03:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782666; cv=none; b=PlXypbhhaiLFWdbY8+OtjJUc2JUtslcf9Ac9Kd4YRy3QQi5e0/4APqYROtj+ueYOFPjVAug9Vf0ELzx7XsL0D13JXNqnjsvakzC1bpRr2YD5kAcK8rI/dvwDcUXaQ0vkRhO1D5gNo+Dmk8qijBTAFYCa3Y06OI8eEi52EDiSgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782666; c=relaxed/simple;
	bh=NFkMlqYjX4CE9CYquHhg4TWhvFG2s8H6//OmNQ84g5Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jDIJaBLzrzkznio0fN565vCZwmCJWiLidkLlaTct3z5BpDcM+XISwFOoj9ny3V5JO5GuKawBO7776x1m61g4oWjtKL687SgCuVUefTl8yItPVqvno9x3KLzJ9/zLIclSdXwVK8Ja6df6HiUvqNEa/TxYQ3vNtK/v5USmVYSxvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLiWggvA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709782664; x=1741318664;
  h=date:from:to:cc:subject:message-id;
  bh=NFkMlqYjX4CE9CYquHhg4TWhvFG2s8H6//OmNQ84g5Y=;
  b=iLiWggvAu6snXohXCzMRkRAaEGH49hq4tI1oDAAWO1WztgGkZYzJfvC2
   3fjSjPBmclTGXlf2m3fzQsqan7xOgtDvIFIzJNvlKB6afFZMMx4bwjR4t
   byVsQvbSPXDTI8PUQkPLciAsobPuXZjfrmVcUE3lQ7/XL4wXY5xRbbqM9
   RjrDorGV87Dg/HiuTjJ+lZmIN7nnNuoRT68k3gfz/4IylDVHrt7ZjqLuE
   CRsS36KVwn9eukbdMO0bNoX8WG6DWPzuwkclKa26z0Ex8ScEqIrzwWHvF
   eaCtMs5Y6z98hbakI01ZVS/JoTIGdPXt1NCbjNqXe6iKfhxZWg+g28mtW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15843110"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="15843110"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14624517"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Mar 2024 19:37:42 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ri4Zf-0004lC-2z;
	Thu, 07 Mar 2024 03:37:39 +0000
Date: Thu, 07 Mar 2024 11:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1aa35edbdb61f4622dcb508cf980e3eb84212b36
Message-ID: <202403071145.hsKK5Yuv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1aa35edbdb61f4622dcb508cf980e3eb84212b36  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1093m

configs tested: 138
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
arc                   randconfig-001-20240307   gcc  
arc                   randconfig-002-20240307   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240307   clang
arm                   randconfig-002-20240307   gcc  
arm                   randconfig-003-20240307   gcc  
arm                   randconfig-004-20240307   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240307   gcc  
arm64                 randconfig-002-20240307   gcc  
arm64                 randconfig-003-20240307   gcc  
arm64                 randconfig-004-20240307   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240307   gcc  
csky                  randconfig-002-20240307   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240307   clang
hexagon               randconfig-002-20240307   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-003-20240307   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-006-20240307   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-013-20240307   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-016-20240307   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240307   gcc  
loongarch             randconfig-002-20240307   gcc  
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
nios2                 randconfig-001-20240307   gcc  
nios2                 randconfig-002-20240307   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240307   gcc  
parisc                randconfig-002-20240307   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240307   gcc  
powerpc               randconfig-002-20240307   gcc  
powerpc               randconfig-003-20240307   gcc  
powerpc64             randconfig-001-20240307   gcc  
powerpc64             randconfig-002-20240307   gcc  
powerpc64             randconfig-003-20240307   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240307   clang
riscv                 randconfig-002-20240307   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240307   clang
s390                  randconfig-002-20240307   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240307   gcc  
sh                    randconfig-002-20240307   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240307   gcc  
sparc64               randconfig-002-20240307   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240307   gcc  
um                    randconfig-002-20240307   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-002-20240307   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

