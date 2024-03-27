Return-Path: <linux-kernel+bounces-120192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4888D430
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAFD1C247AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9420322;
	Wed, 27 Mar 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UB3nsqnc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37C210FF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504872; cv=none; b=sCWu9R4HhFMjssQhy7vJOK3HmeNFsoig5axR8ftb04yOyq/Ljq4FoYCmtWuO9TYfDNs4GZwCKBTrGtF++XPsXsHILjzSVyh+75JDRSd9eQvtclJCSexg2xXbRDV+8kM6/uJ1rAZLTjXGrqpR6/trrgbdHXIFg+S3KWPRNcvDMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504872; c=relaxed/simple;
	bh=2NjonIuOBmG7e1Jjiar2OdzG4TvyYOd0+UWY9wAOhhk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QHtntAHR+x5ouUYO6JW90hxZzpIoEWaUHNrd9B3BOwjVfv8oyD87iCwGqZIJqQG6sujvYyY9dgsW67GAcCVu5f5WhuRTMiL76XpIrWplIeaneI1L9F5L0HUXNzL7VnEW4BQj3RcmHK8aZ23Ax/HVtE64sRIzQ+7ryA+McC3c65g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UB3nsqnc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711504871; x=1743040871;
  h=date:from:to:cc:subject:message-id;
  bh=2NjonIuOBmG7e1Jjiar2OdzG4TvyYOd0+UWY9wAOhhk=;
  b=UB3nsqnc2w3NYMTxCvnN9kqvUonYUtYIJOLkTRv1DQL+YZFTU/IQbzcB
   AbKFy0sBnZx7poXC21dOZmQZGg5rhlfNPxzUwdz0s3hCb8OkwF/r6Heh2
   YgzEHOeEHtgTP/kxe2tBHGq19JOrXUQPfsENB/uo/HAzUw/7iPJJD+HRK
   RKywa/xba74w9VPtBO7N421Behft5Q4FaC8OU2jzdzLIUkTSWWbl96Spa
   xUtg5Yz8dKjzCPG5wMLDawIocOutCiINg70qgKYvTqtaCmrghBTjB+/dS
   hiAdx3N57lveoaAE4mcsj3t54HSc+lemvpsVdXLLd/rivckloH8mRgpja
   g==;
X-CSE-ConnectionGUID: 5NFV8fDJTbqKVZ5x1LWuzw==
X-CSE-MsgGUID: OwHbzYERSS2LHUwNviRwJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="29063840"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="29063840"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:01:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16528748"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2024 19:01:09 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpIbC-0000cq-1B;
	Wed, 27 Mar 2024 02:01:06 +0000
Date: Wed, 27 Mar 2024 10:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 9e81e329508576b499b5c47ab106b5fa45ce96d9
Message-ID: <202403271059.4vxsVGIu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 9e81e329508576b499b5c47ab106b5fa45ce96d9  irqchip/armada-370-xp: Suppress unused-function warning

elapsed time: 1481m

configs tested: 181
configs skipped: 5

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
arc                   randconfig-001-20240326   gcc  
arc                   randconfig-002-20240326   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-001-20240326   gcc  
arm                   randconfig-002-20240326   gcc  
arm                   randconfig-003-20240326   gcc  
arm                   randconfig-004-20240326   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240326   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240326   gcc  
csky                  randconfig-002-20240326   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20240326   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-003-20240327   clang
i386         buildonly-randconfig-004-20240326   gcc  
i386         buildonly-randconfig-004-20240327   clang
i386         buildonly-randconfig-005-20240326   gcc  
i386         buildonly-randconfig-005-20240327   clang
i386         buildonly-randconfig-006-20240326   gcc  
i386         buildonly-randconfig-006-20240327   clang
i386                                defconfig   clang
i386                  randconfig-001-20240326   gcc  
i386                  randconfig-002-20240326   gcc  
i386                  randconfig-003-20240326   gcc  
i386                  randconfig-003-20240327   clang
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240326   gcc  
i386                  randconfig-005-20240327   clang
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240326   gcc  
i386                  randconfig-012-20240327   clang
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-014-20240327   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240326   clang
i386                  randconfig-016-20240327   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240326   gcc  
loongarch             randconfig-002-20240326   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240326   gcc  
nios2                 randconfig-002-20240326   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240326   gcc  
parisc                randconfig-002-20240326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc               randconfig-002-20240326   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240326   gcc  
powerpc64             randconfig-002-20240326   gcc  
powerpc64             randconfig-003-20240326   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240326   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240326   gcc  
sh                    randconfig-002-20240326   gcc  
sh                          rsk7269_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240326   gcc  
sparc64               randconfig-002-20240326   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240326   gcc  
um                    randconfig-002-20240326   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-004-20240327   clang
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-001-20240327   clang
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-005-20240327   clang
x86_64                randconfig-006-20240327   clang
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-012-20240327   clang
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-013-20240327   clang
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-014-20240327   clang
x86_64                randconfig-015-20240327   clang
x86_64                randconfig-016-20240327   clang
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-072-20240327   clang
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-073-20240327   clang
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-074-20240327   clang
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-075-20240327   clang
x86_64                randconfig-076-20240326   gcc  
x86_64                randconfig-076-20240327   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240326   gcc  
xtensa                randconfig-002-20240326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

