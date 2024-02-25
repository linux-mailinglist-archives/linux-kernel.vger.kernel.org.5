Return-Path: <linux-kernel+bounces-79982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F7862934
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 06:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01338B215A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3BF944C;
	Sun, 25 Feb 2024 05:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNLiG6St"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9055256
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708839986; cv=none; b=LapC6+UqBR8+XFKNflsiebvsThpGPiRR1IBDajTa1MfZIAbqW8x5YuZjLxTw8faU18zBN+cbBvipbp2h0u0MJ6KUdp8T2/Mnqw5wH/+i3RvP3xY5LxW5yIagotgjKT/JCgNFY3SJFuFADeudYX8X2R9uJteRo+OH5skCrox0hfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708839986; c=relaxed/simple;
	bh=TTeffnEph9tBXeMJmYfZIUUy/GELkvm/WCLyMWzTJ4o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RIRtPDWnRltmyNhlI9f5oWqJYVqDZFNeVwA1Nom66TRLN6I/M6Pwz0Ct2nFogGnHZN/5y8b+k3ZRGS/kmzec+K6bASTw/QBazOvzs7gxhsTs3zcJGRNru8hj566znLxS//+7DG6CxlfChy630vThAzmlMbwrEDbruXQTfZr4uNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNLiG6St; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708839985; x=1740375985;
  h=date:from:to:cc:subject:message-id;
  bh=TTeffnEph9tBXeMJmYfZIUUy/GELkvm/WCLyMWzTJ4o=;
  b=dNLiG6StgMHrNsmeFB1hd+hfH3tohK19bVeC0mXa1CwWDXEpADg3l/M1
   v0RyvQ+Rx2nDG0mKdaOzDBLRA532/j47ohWFKwwOj6yWHgjyQ2AALOL/4
   aUi3aXegyFK1709oy7d3RbNXY7OIpqHj3mYAf4Uc0Z1fWW7rKek4JtkP0
   wY/C/IhY0CaomErsG0awoe3oV3liJiw+NOmKT8fd/q9Ejt3kD0tMXFAYs
   +mRwxsDJcCykfKbs5dztpRcT5v5tfrYq4AEVe0kFElqFjWCe2KCaqeABu
   qUQ3UMM1vJcrRh3s2Cxa8rM+jZ+FP3zf8Asw3+JpBrfOy6JY04iCMJEqm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3055674"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="3055674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 21:46:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="10892678"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2024 21:46:22 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1re7LA-0009M6-0G;
	Sun, 25 Feb 2024 05:46:20 +0000
Date: Sun, 25 Feb 2024 13:45:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 10395f8cfef8e360355770776945aff5d23f793b
Message-ID: <202402251319.DAMky17U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 10395f8cfef8e360355770776945aff5d23f793b  tracing: Select new NEED_TASKS_RCU Kconfig option

elapsed time: 1460m

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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240225   gcc  
arc                   randconfig-002-20240225   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240225   clang
arm                   randconfig-002-20240225   gcc  
arm                   randconfig-003-20240225   clang
arm                   randconfig-004-20240225   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240225   gcc  
arm64                 randconfig-002-20240225   clang
arm64                 randconfig-003-20240225   gcc  
arm64                 randconfig-004-20240225   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240225   gcc  
csky                  randconfig-002-20240225   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240225   clang
hexagon               randconfig-002-20240225   clang
i386         buildonly-randconfig-001-20240225   gcc  
i386         buildonly-randconfig-002-20240225   gcc  
i386         buildonly-randconfig-003-20240225   clang
i386         buildonly-randconfig-004-20240225   gcc  
i386         buildonly-randconfig-005-20240225   clang
i386         buildonly-randconfig-006-20240225   gcc  
i386                  randconfig-001-20240225   gcc  
i386                  randconfig-002-20240225   clang
i386                  randconfig-003-20240225   clang
i386                  randconfig-004-20240225   gcc  
i386                  randconfig-005-20240225   gcc  
i386                  randconfig-006-20240225   gcc  
i386                  randconfig-011-20240225   clang
i386                  randconfig-012-20240225   gcc  
i386                  randconfig-013-20240225   gcc  
i386                  randconfig-014-20240225   clang
i386                  randconfig-015-20240225   gcc  
i386                  randconfig-016-20240225   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240225   gcc  
loongarch             randconfig-002-20240225   gcc  
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
nios2                 randconfig-001-20240225   gcc  
nios2                 randconfig-002-20240225   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240225   gcc  
parisc                randconfig-002-20240225   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240225   clang
powerpc               randconfig-002-20240225   clang
powerpc               randconfig-003-20240225   clang
powerpc64             randconfig-001-20240225   gcc  
powerpc64             randconfig-002-20240225   clang
powerpc64             randconfig-003-20240225   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240225   gcc  
riscv                 randconfig-002-20240225   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240225   gcc  
s390                  randconfig-002-20240225   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240225   gcc  
sh                    randconfig-002-20240225   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240225   gcc  
sparc64               randconfig-002-20240225   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240225   clang
um                    randconfig-002-20240225   clang
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240225   clang
x86_64       buildonly-randconfig-002-20240225   clang
x86_64       buildonly-randconfig-003-20240225   clang
x86_64       buildonly-randconfig-004-20240225   gcc  
x86_64       buildonly-randconfig-005-20240225   clang
x86_64       buildonly-randconfig-006-20240225   gcc  
x86_64                randconfig-001-20240225   gcc  
x86_64                randconfig-002-20240225   clang
x86_64                randconfig-003-20240225   gcc  
x86_64                randconfig-004-20240225   clang
x86_64                randconfig-005-20240225   clang
x86_64                randconfig-006-20240225   gcc  
x86_64                randconfig-011-20240225   clang
x86_64                randconfig-012-20240225   clang
x86_64                randconfig-013-20240225   gcc  
x86_64                randconfig-014-20240225   gcc  
x86_64                randconfig-015-20240225   clang
x86_64                randconfig-016-20240225   gcc  
x86_64                randconfig-071-20240225   gcc  
x86_64                randconfig-072-20240225   gcc  
x86_64                randconfig-073-20240225   clang
x86_64                randconfig-074-20240225   gcc  
x86_64                randconfig-075-20240225   clang
x86_64                randconfig-076-20240225   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240225   gcc  
xtensa                randconfig-002-20240225   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

