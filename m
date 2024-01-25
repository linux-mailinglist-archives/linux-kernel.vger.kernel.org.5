Return-Path: <linux-kernel+bounces-39045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D183CA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB2E29137E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18713174E;
	Thu, 25 Jan 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsARqJQi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8563413
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204358; cv=none; b=VlvykqV3l7CAE2MeypyRxkaHSWWQjiY1y5qQZzHYnBsi7GB4wtvF2nTmsB6tYoqtkzI2QQrEBqP4FS66HdUjkIlMZEW6uTcyhQDTZS+7eMjq0w1QzEaO8XWEugHlAAo1KE4Jc/zgjF9DeV+rdIOuuo38KGuML9DAxh7iKfzX6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204358; c=relaxed/simple;
	bh=w2pS1tZX4cPAJFw4udsgluHlpRcv0NmpG8Hpd8o+UBg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d/gQt2c1qOIDUQ6HlauXfo7tenSgLdVs9uTgeNOpHqx6qbCx64dTxwjMiV7uSQyWj3jVCgCtfptaJVAbQlgUOuNC+bEFEUvhiJOCfUa5m/BIYM2diTxiUDGeO5L1uw4LoIEUlzabSSRcWfmLMxhRvqmt2Pg5I7HNzDHaNQfO2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsARqJQi; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706204356; x=1737740356;
  h=date:from:to:cc:subject:message-id;
  bh=w2pS1tZX4cPAJFw4udsgluHlpRcv0NmpG8Hpd8o+UBg=;
  b=XsARqJQi9pTxVHgGs4RiWlGAj9aCu5DxYae0DOffr/WKW1YoVI/PqZv8
   rQHiO1eS3EGzRk9CquOM2TkJ/R3GpvQEVOzVv+0nnzjYlWOqaX3QWlawa
   6yLfnz9cCs3RyVoDGlnujQjvrE388QcXEo5jU/LZs/z5Xd/oB+llB023R
   tMIVIZMirgH3lCWikP0lN4YLKpeUh8/XPOyz0T0TFCEocROOZXMO1NyYA
   ncZUk6PZiu8HP9l4oIRz9y2od7QYXKYMx5F6jqF3QN4qD6UNDxYYAj7U6
   QlhGYDQLzmxngOsN8k2g7+FvEOrMtsCSeVUlVw9EUUbFmGrfiYh/9RO+S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9617320"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9617320"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 09:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2307426"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jan 2024 09:39:13 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT3h1-0000HP-1i;
	Thu, 25 Jan 2024 17:39:11 +0000
Date: Fri, 26 Jan 2024 01:39:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 0af3acc42dbe991b20a14767b99da5c512c03d21
Message-ID: <202401260158.KabpXpIA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 0af3acc42dbe991b20a14767b99da5c512c03d21  rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks

elapsed time: 1606m

configs tested: 156
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
arc                   randconfig-001-20240125   gcc  
arc                   randconfig-002-20240125   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240125   gcc  
arm                   randconfig-002-20240125   gcc  
arm                   randconfig-003-20240125   gcc  
arm                   randconfig-004-20240125   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240125   gcc  
arm64                 randconfig-002-20240125   gcc  
arm64                 randconfig-003-20240125   gcc  
arm64                 randconfig-004-20240125   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240125   gcc  
csky                  randconfig-002-20240125   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240125   clang
hexagon               randconfig-002-20240125   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240124   clang
i386         buildonly-randconfig-002-20240124   clang
i386         buildonly-randconfig-003-20240124   clang
i386         buildonly-randconfig-004-20240124   clang
i386         buildonly-randconfig-005-20240124   clang
i386         buildonly-randconfig-006-20240124   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240124   clang
i386                  randconfig-002-20240124   clang
i386                  randconfig-003-20240124   clang
i386                  randconfig-004-20240124   clang
i386                  randconfig-005-20240124   clang
i386                  randconfig-006-20240124   clang
i386                  randconfig-011-20240124   gcc  
i386                  randconfig-012-20240124   gcc  
i386                  randconfig-013-20240124   gcc  
i386                  randconfig-014-20240124   gcc  
i386                  randconfig-015-20240124   gcc  
i386                  randconfig-016-20240124   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240125   gcc  
loongarch             randconfig-002-20240125   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240125   gcc  
nios2                 randconfig-002-20240125   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240125   gcc  
parisc                randconfig-002-20240125   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240125   gcc  
powerpc               randconfig-002-20240125   gcc  
powerpc               randconfig-003-20240125   gcc  
powerpc64             randconfig-001-20240125   gcc  
powerpc64             randconfig-002-20240125   gcc  
powerpc64             randconfig-003-20240125   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240125   gcc  
riscv                 randconfig-002-20240125   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240125   clang
s390                  randconfig-002-20240125   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240125   gcc  
sh                    randconfig-002-20240125   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240125   gcc  
sparc64               randconfig-002-20240125   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240125   gcc  
um                    randconfig-002-20240125   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240125   gcc  
x86_64       buildonly-randconfig-002-20240125   gcc  
x86_64       buildonly-randconfig-003-20240125   gcc  
x86_64       buildonly-randconfig-004-20240125   gcc  
x86_64       buildonly-randconfig-005-20240125   gcc  
x86_64       buildonly-randconfig-006-20240125   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240125   clang
x86_64                randconfig-002-20240125   clang
x86_64                randconfig-003-20240125   clang
x86_64                randconfig-004-20240125   clang
x86_64                randconfig-005-20240125   clang
x86_64                randconfig-006-20240125   clang
x86_64                randconfig-011-20240125   gcc  
x86_64                randconfig-012-20240125   gcc  
x86_64                randconfig-013-20240125   gcc  
x86_64                randconfig-014-20240125   gcc  
x86_64                randconfig-015-20240125   gcc  
x86_64                randconfig-016-20240125   gcc  
x86_64                randconfig-071-20240125   gcc  
x86_64                randconfig-072-20240125   gcc  
x86_64                randconfig-073-20240125   gcc  
x86_64                randconfig-074-20240125   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240125   gcc  
xtensa                randconfig-002-20240125   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

