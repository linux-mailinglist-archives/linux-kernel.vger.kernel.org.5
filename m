Return-Path: <linux-kernel+bounces-37056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390EF83AAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B61C2537A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA40877F07;
	Wed, 24 Jan 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwTswNzo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA1199D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102104; cv=none; b=EGOiNNiIB0DFpdIWF3XNHj+5prsX4YM+/moawtMmXQ7sJVSzNZJoZ6aCCDwSeetgrVkhdqMtHBAP8FyYzxhdlxESkA89TTUbHWk+d+uMCxcEjoCNIwjQRjakCYqW4fVokPgizHyr0IrD/HhB5OhA+3BZQfot0xzZZsXKS/SvIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102104; c=relaxed/simple;
	bh=B6hu+C1ZGlfaS+mj0scAW+Z1IBpSRA7QNQYZ6LaDoIo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nj4A4rZsHOD+iM9poy47ahwJ1HPmfp7gH7AwBEymZ23RyW9+U0KIx0amF6hQQaUsZyVeqIwuiAIJBVlLKlTc4a8OySDXubz9ZZv4EbuawEXfg392a8QVz5WHEjl6wRrmBPTpgkyZb7Wk0KUHRiY4nSDR8FZJkV6niD43IEMVqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwTswNzo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706102103; x=1737638103;
  h=date:from:to:cc:subject:message-id;
  bh=B6hu+C1ZGlfaS+mj0scAW+Z1IBpSRA7QNQYZ6LaDoIo=;
  b=QwTswNzoPt+kFbiz+ukFB0WjYVIjqTGMu7GTcGgA+O1pTg636UgyNyS+
   8D6wGCHuwU2ilRjtXGkorRn3iFhyo707S9LVI629ZDTTJNTwoarUQhGf6
   gYYHH+L3UGYzKYuhW1V/s6rIWXJsgrh0zxH/E2dmvQMd0aXZUyEIr6UEX
   DB1RHZ6Wgp8r3QGc1WTfKTFWhHDYAgENWqSdQpugaTLwqLmxKjxCx4WR8
   jqoAGKM2Rf0VWzxrDh1BNAErUfWvahnLE6L8/Dx7acBC3UV/5dqf8b8nB
   0wYJHaR2aGES5ccFW36iz0IAvxuy5K5sRDML/+rdJHYlCdvWBvVhhqp7i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1680425"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1680425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117615346"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117615346"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2024 05:15:00 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSd5n-000870-10;
	Wed, 24 Jan 2024 13:14:59 +0000
Date: Wed, 24 Jan 2024 21:14:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 2f4aa1f71eb57223beca2b66d3bf3cbacc5048c8
Message-ID: <202401242133.4OEJsepy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 2f4aa1f71eb57223beca2b66d3bf3cbacc5048c8  rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks

elapsed time: 1498m

configs tested: 160
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
arc                   randconfig-001-20240124   gcc  
arc                   randconfig-002-20240124   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240124   clang
arm                   randconfig-002-20240124   clang
arm                   randconfig-003-20240124   clang
arm                   randconfig-004-20240124   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240124   clang
arm64                 randconfig-002-20240124   clang
arm64                 randconfig-003-20240124   clang
arm64                 randconfig-004-20240124   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240124   gcc  
csky                  randconfig-002-20240124   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240124   clang
hexagon               randconfig-002-20240124   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240123   gcc  
i386         buildonly-randconfig-002-20240123   gcc  
i386         buildonly-randconfig-003-20240123   gcc  
i386         buildonly-randconfig-004-20240123   gcc  
i386         buildonly-randconfig-005-20240123   gcc  
i386         buildonly-randconfig-006-20240123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240123   gcc  
i386                  randconfig-002-20240123   gcc  
i386                  randconfig-003-20240123   gcc  
i386                  randconfig-004-20240123   gcc  
i386                  randconfig-005-20240123   gcc  
i386                  randconfig-006-20240123   gcc  
i386                  randconfig-011-20240123   clang
i386                  randconfig-012-20240123   clang
i386                  randconfig-013-20240123   clang
i386                  randconfig-014-20240123   clang
i386                  randconfig-015-20240123   clang
i386                  randconfig-016-20240123   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240124   gcc  
loongarch             randconfig-002-20240124   gcc  
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
nios2                 randconfig-001-20240124   gcc  
nios2                 randconfig-002-20240124   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240124   gcc  
parisc                randconfig-002-20240124   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240124   clang
powerpc               randconfig-002-20240124   clang
powerpc               randconfig-003-20240124   clang
powerpc64             randconfig-001-20240124   clang
powerpc64             randconfig-002-20240124   clang
powerpc64             randconfig-003-20240124   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240124   clang
riscv                 randconfig-002-20240124   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240124   gcc  
s390                  randconfig-002-20240124   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240124   gcc  
sh                    randconfig-002-20240124   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240124   gcc  
sparc64               randconfig-002-20240124   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240124   clang
um                    randconfig-002-20240124   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240124   clang
x86_64       buildonly-randconfig-002-20240124   clang
x86_64       buildonly-randconfig-003-20240124   clang
x86_64       buildonly-randconfig-004-20240124   clang
x86_64       buildonly-randconfig-005-20240124   clang
x86_64       buildonly-randconfig-006-20240124   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240124   gcc  
x86_64                randconfig-002-20240124   gcc  
x86_64                randconfig-003-20240124   gcc  
x86_64                randconfig-004-20240124   gcc  
x86_64                randconfig-005-20240124   gcc  
x86_64                randconfig-006-20240124   gcc  
x86_64                randconfig-011-20240124   clang
x86_64                randconfig-012-20240124   clang
x86_64                randconfig-013-20240124   clang
x86_64                randconfig-014-20240124   clang
x86_64                randconfig-015-20240124   clang
x86_64                randconfig-016-20240124   clang
x86_64                randconfig-071-20240124   clang
x86_64                randconfig-072-20240124   clang
x86_64                randconfig-073-20240124   clang
x86_64                randconfig-074-20240124   clang
x86_64                randconfig-075-20240124   clang
x86_64                randconfig-076-20240124   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240124   gcc  
xtensa                randconfig-002-20240124   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

