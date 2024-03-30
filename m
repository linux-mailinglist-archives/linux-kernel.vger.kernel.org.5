Return-Path: <linux-kernel+bounces-125573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F38928EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30FB1F22470
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BD1FA5;
	Sat, 30 Mar 2024 02:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8GeS9a2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2417F6
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711766180; cv=none; b=p2gJZyLcD5p6XMzngpw7PW0zvGwy5Uujm7muOcSYbn/F1Qs6Y5MNCdj75/Fjgyn7i0a3CxfaNpKOtD+73pMonMf0bYN3y3s9rdujZE+qV9KG4J8ShkokmVVFWQvcnBvEJKJMyvwFRPdXprIGvz4wgTxoZmxNpGNYtBkYSQU77H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711766180; c=relaxed/simple;
	bh=lnL8Jby1H0u9xgnQjqDm7k8+F/HUFP5hqAsDfOI+3S0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JKmn5erM4Pgl7hVBuz0/IYHX1RYtr900NWPApFoGowC0SZfZkfQnmCvDOvjBUz/Wm7NmJ8BYMNf/NPcSwb5e3PGPtzSiQFG+G015fLVuDw/zaL6KU0kwWKqNFpEONOIfiQ5VFIBcseSsehs2FAtC/v3h8a8xYj+eeRAqLXnMAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8GeS9a2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711766178; x=1743302178;
  h=date:from:to:cc:subject:message-id;
  bh=lnL8Jby1H0u9xgnQjqDm7k8+F/HUFP5hqAsDfOI+3S0=;
  b=n8GeS9a2wuOaQDGC6UqEU+6SZz8LLSdNgOLFi+SjXOEL+DQnluhyTfNi
   ftb/BocZIU9Y+yQ1eF/62rY6Gew+fiIZvBvamjHcAK8XOO4pZkolWHtHD
   k9knyCsA24EYelC8MBs6ncKMtL+COkOXgFmgn6IE+1dClK9CQZFkVrZ0o
   nBII/nWTbr+7gCJab5unYSXZBGuBlv7yVxsmRov+VcZmSeylsrB5EoBgU
   4zfhZGTXF2ABd+mfYeGdX1vsVvbhF+2KPxQJMfxgdQc0UM5P0edsuJZtq
   2F/sTM7RGGcckvtzKtrorzZkGz9zx7kb5yAD97XaapR0bL7KbHIHJhY/p
   A==;
X-CSE-ConnectionGUID: B2xDgGgoQkq8dg9CcJG1Tg==
X-CSE-MsgGUID: dWAZhF+KRRSw/80sd4MPXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6820034"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="6820034"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 19:36:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17543614"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Mar 2024 19:36:16 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqOZp-0003sC-2E;
	Sat, 30 Mar 2024 02:36:13 +0000
Date: Sat, 30 Mar 2024 10:35:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 4475cd8bfd9bcb898953fcadb2f51b3432eb68a1
Message-ID: <202403301036.ODP6MgCN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 4475cd8bfd9bcb898953fcadb2f51b3432eb68a1  sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags

elapsed time: 1158m

configs tested: 157
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
arc                   randconfig-001-20240330   gcc  
arc                   randconfig-002-20240330   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240330   clang
arm                   randconfig-002-20240330   clang
arm                   randconfig-003-20240330   gcc  
arm                   randconfig-004-20240330   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240330   clang
arm64                 randconfig-002-20240330   clang
arm64                 randconfig-003-20240330   clang
arm64                 randconfig-004-20240330   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240330   gcc  
csky                  randconfig-002-20240330   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240330   clang
hexagon               randconfig-002-20240330   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240330   clang
i386         buildonly-randconfig-002-20240330   clang
i386         buildonly-randconfig-003-20240330   clang
i386         buildonly-randconfig-004-20240330   clang
i386         buildonly-randconfig-005-20240330   clang
i386         buildonly-randconfig-006-20240330   clang
i386                                defconfig   clang
i386                  randconfig-001-20240330   clang
i386                  randconfig-002-20240330   clang
i386                  randconfig-003-20240330   clang
i386                  randconfig-004-20240330   clang
i386                  randconfig-005-20240330   clang
i386                  randconfig-006-20240330   gcc  
i386                  randconfig-011-20240330   clang
i386                  randconfig-012-20240330   gcc  
i386                  randconfig-013-20240330   gcc  
i386                  randconfig-014-20240330   clang
i386                  randconfig-015-20240330   gcc  
i386                  randconfig-016-20240330   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240330   gcc  
loongarch             randconfig-002-20240330   gcc  
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
nios2                 randconfig-001-20240330   gcc  
nios2                 randconfig-002-20240330   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240330   gcc  
parisc                randconfig-002-20240330   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240330   gcc  
powerpc               randconfig-002-20240330   clang
powerpc               randconfig-003-20240330   clang
powerpc64             randconfig-001-20240330   gcc  
powerpc64             randconfig-002-20240330   gcc  
powerpc64             randconfig-003-20240330   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240330   gcc  
riscv                 randconfig-002-20240330   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240330   clang
s390                  randconfig-002-20240330   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240330   gcc  
sh                    randconfig-002-20240330   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240330   gcc  
sparc64               randconfig-002-20240330   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240330   clang
um                    randconfig-002-20240330   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240330   gcc  
x86_64       buildonly-randconfig-002-20240330   gcc  
x86_64       buildonly-randconfig-003-20240330   clang
x86_64       buildonly-randconfig-004-20240330   clang
x86_64       buildonly-randconfig-005-20240330   gcc  
x86_64       buildonly-randconfig-006-20240330   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240330   gcc  
x86_64                randconfig-002-20240330   clang
x86_64                randconfig-003-20240330   clang
x86_64                randconfig-004-20240330   gcc  
x86_64                randconfig-005-20240330   gcc  
x86_64                randconfig-006-20240330   gcc  
x86_64                randconfig-011-20240330   clang
x86_64                randconfig-012-20240330   clang
x86_64                randconfig-013-20240330   clang
x86_64                randconfig-014-20240330   gcc  
x86_64                randconfig-015-20240330   gcc  
x86_64                randconfig-016-20240330   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240330   gcc  
xtensa                randconfig-002-20240330   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

