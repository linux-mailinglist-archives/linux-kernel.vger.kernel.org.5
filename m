Return-Path: <linux-kernel+bounces-88677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC3086E523
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE11F25CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696706F523;
	Fri,  1 Mar 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHkDJQYH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4A38DC0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309960; cv=none; b=BRHRDdn4IriDGDTm6zfxkQNyrsn2GsfGg4c6dmLoO/lVWPjaR3Yre7k1S67Giu2siAMWAOpyz71ZYzWiHR/qnRRDOP1L6i+i2HWjJN+rAoOJJv6RAmM8nqLHW9puOPVkhTY+Nbue0AHZDqoZ/BzP/luQzXpqod0AIBEWy81u5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309960; c=relaxed/simple;
	bh=1dgY+t2fEQvAKMTCrnnEQ30zjIpVGDBTXL0zOb3bx6E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nT0fumaWbk+qUSxlUHxH+7G3OjHX3p4n9/2ak24lH0noBZ36zebK8JOTAo/SweYGIa6PF2Mb5cA8rJLwtdMa9MzwVFVubLvTsOLhYlj8q3CpLLSFoUlLrc39HSz43TuA2KpOZeAxUSXqS/xrk4Ckq6i2hJk7G+JcWkMLHxdWHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHkDJQYH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709309956; x=1740845956;
  h=date:from:to:cc:subject:message-id;
  bh=1dgY+t2fEQvAKMTCrnnEQ30zjIpVGDBTXL0zOb3bx6E=;
  b=kHkDJQYHi4nOgHKxzNH5tAgdW+PEO6LeSQk8ywmlMf+gWQ9Uv4peQRR/
   MrAVVe33JvzTOnQs7ouRZ1HqrCBvrb9kqn0UsQnUgWI/9jsslVnF6yJw+
   RvK2XpfW1DHN0GySCTL+rp5F5g/5HeofKAVGNAO7z/Cq9Cm/hW04VESou
   gQGGfchrgqGcT0WaVV+MY7To4FJ07B60JVdNai846v4+g/VqrPlyYO6W4
   vUNh1WU7DOrGjOqlfzPSyi1CcqExy4CdB1QOyH7nEufNJiNXdJMEu1b8k
   dun283GqHsdPEmqIN7Kijeg9uieaq1Qs2bJBnQ8/2kUQjZ6vF6dDauw/d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14494791"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="14494791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="45775606"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Mar 2024 08:19:14 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg5bL-000DwQ-1r;
	Fri, 01 Mar 2024 16:19:11 +0000
Date: Sat, 02 Mar 2024 00:17:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240229-smc_clc] BUILD
 SUCCESS 0a93dd98351466329286809d6d136b04d09ddf64
Message-ID: <202403020017.ephuG9iu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240229-smc_clc
branch HEAD: 0a93dd98351466329286809d6d136b04d09ddf64  net/smc: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 727m

configs tested: 143
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
arc                   randconfig-001-20240301   gcc  
arc                   randconfig-002-20240301   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240301   gcc  
arm                   randconfig-002-20240301   clang
arm                   randconfig-003-20240301   gcc  
arm                   randconfig-004-20240301   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240301   gcc  
arm64                 randconfig-002-20240301   clang
arm64                 randconfig-003-20240301   gcc  
arm64                 randconfig-004-20240301   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240301   gcc  
csky                  randconfig-002-20240301   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240301   clang
hexagon               randconfig-002-20240301   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240301   clang
i386         buildonly-randconfig-002-20240301   clang
i386         buildonly-randconfig-003-20240301   gcc  
i386         buildonly-randconfig-004-20240301   clang
i386         buildonly-randconfig-005-20240301   clang
i386         buildonly-randconfig-006-20240301   clang
i386                                defconfig   clang
i386                  randconfig-001-20240301   clang
i386                  randconfig-002-20240301   clang
i386                  randconfig-003-20240301   clang
i386                  randconfig-004-20240301   clang
i386                  randconfig-005-20240301   gcc  
i386                  randconfig-006-20240301   gcc  
i386                  randconfig-011-20240301   gcc  
i386                  randconfig-012-20240301   clang
i386                  randconfig-013-20240301   clang
i386                  randconfig-014-20240301   gcc  
i386                  randconfig-015-20240301   gcc  
i386                  randconfig-016-20240301   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240301   gcc  
loongarch             randconfig-002-20240301   gcc  
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
nios2                 randconfig-001-20240301   gcc  
nios2                 randconfig-002-20240301   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240301   gcc  
parisc                randconfig-002-20240301   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240301   gcc  
powerpc               randconfig-002-20240301   gcc  
powerpc               randconfig-003-20240301   clang
powerpc64             randconfig-001-20240301   clang
powerpc64             randconfig-002-20240301   gcc  
powerpc64             randconfig-003-20240301   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240301   gcc  
riscv                 randconfig-002-20240301   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240301   clang
s390                  randconfig-002-20240301   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240301   gcc  
sh                    randconfig-002-20240301   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240301   clang
x86_64       buildonly-randconfig-002-20240301   gcc  
x86_64       buildonly-randconfig-003-20240301   clang
x86_64       buildonly-randconfig-004-20240301   gcc  
x86_64       buildonly-randconfig-005-20240301   clang
x86_64       buildonly-randconfig-006-20240301   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240301   gcc  
x86_64                randconfig-002-20240301   clang
x86_64                randconfig-003-20240301   clang
x86_64                randconfig-004-20240301   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

