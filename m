Return-Path: <linux-kernel+bounces-31515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B30832F64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43765282295
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A95645A;
	Fri, 19 Jan 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrbXh5ZJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE21E520
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705692857; cv=none; b=eRDszWgT7XBhfSPCCnLUN4o5YKWwk9qhbLKnHBVrPLbyjuA/Yrx+ONWuiiVfyggswwpuXTXQiCqu7UQFpB3fHQvvxv+4ux9ZHk2covoNUC9OXnR5lklJiqynPzQrQtkIJxCB62NPUtCPGUJV6GT1RxuGIHyws25enphIYrqRxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705692857; c=relaxed/simple;
	bh=MIEUoP5a2OiOmUoqf2Pw0AaSbvsH2ScnxOrQHtG0L4Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sY8bf1lce8PgnoEwuCNi8HwplHjnm7PgwSe8rkqGA1DSEuq1ZTm7WfeOBrYwAlq9E7Chq0OyIRIM2Jb6ybyIQaZK6G2l0tMbjrg2wfnHlz+5vVN+qb4BVR7zBuGUxQktBcH4WoSvBx4k103Jw00MpCSQrLPCayPu9TmkM2isC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrbXh5ZJ; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705692855; x=1737228855;
  h=date:from:to:cc:subject:message-id;
  bh=MIEUoP5a2OiOmUoqf2Pw0AaSbvsH2ScnxOrQHtG0L4Y=;
  b=DrbXh5ZJo+fhMKqMf0bDOsKJPV/2CI4FR3FhwnF2kNyvWNLdPkJazLdH
   fqJxhsHIOpz0UjVfs9ZI55dDC489xl+AvhRFVE3JmjJudJhQsSksObQVo
   hvsq1ZUowpkQajmLUr3ax5m8e37nJvvETublkLZOD0KXQxu8Txw3vplHw
   0Ddv9vRprVmqPCctIX2EXnCJDTeRm+5cw8prHcWElDquNfXOe6W35pn+M
   KFQ0z1Iwy86mSOZgHYR/Z1QYSTgjQftCA2D1m+YVnFgWEsgHcUpEpiCk3
   83raWz0oZQ4cILuuPfyMt4rkMJEsd0TZfAc8EtmeidXXR4q7w3Y84PKIw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="486974480"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="486974480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 11:34:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="635584"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jan 2024 11:34:13 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQud1-0004NI-0Z;
	Fri, 19 Jan 2024 19:34:11 +0000
Date: Sat, 20 Jan 2024 03:33:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dc053699f17c065a994b99c6a9f6f3a268fd3edf
Message-ID: <202401200346.CfKUU84Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dc053699f17c065a994b99c6a9f6f3a268fd3edf  Merge branch into tip/master: 'x86/tdx'

elapsed time: 2109m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240119   gcc  
arc                   randconfig-002-20240119   gcc  
arm                               allnoconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                      jornada720_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                           omap1_defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240119   gcc  
arm                   randconfig-002-20240119   gcc  
arm                   randconfig-003-20240119   gcc  
arm                   randconfig-004-20240119   gcc  
arm                        realview_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240119   gcc  
arm64                 randconfig-002-20240119   gcc  
arm64                 randconfig-003-20240119   gcc  
arm64                 randconfig-004-20240119   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240119   gcc  
csky                  randconfig-002-20240119   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240119   clang
hexagon               randconfig-002-20240119   clang
i386         buildonly-randconfig-001-20240119   gcc  
i386         buildonly-randconfig-002-20240119   gcc  
i386         buildonly-randconfig-003-20240119   gcc  
i386         buildonly-randconfig-004-20240119   gcc  
i386         buildonly-randconfig-005-20240119   gcc  
i386         buildonly-randconfig-006-20240119   gcc  
i386                  randconfig-001-20240119   gcc  
i386                  randconfig-002-20240119   gcc  
i386                  randconfig-003-20240119   gcc  
i386                  randconfig-004-20240119   gcc  
i386                  randconfig-005-20240119   gcc  
i386                  randconfig-006-20240119   gcc  
i386                  randconfig-011-20240119   clang
i386                  randconfig-012-20240119   clang
i386                  randconfig-013-20240119   clang
i386                  randconfig-014-20240119   clang
i386                  randconfig-015-20240119   clang
i386                  randconfig-016-20240119   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240119   gcc  
loongarch             randconfig-002-20240119   gcc  
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
nios2                 randconfig-001-20240119   gcc  
nios2                 randconfig-002-20240119   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240119   gcc  
parisc                randconfig-002-20240119   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240119   gcc  
powerpc               randconfig-002-20240119   gcc  
powerpc               randconfig-003-20240119   gcc  
powerpc64             randconfig-001-20240119   gcc  
powerpc64             randconfig-002-20240119   gcc  
powerpc64             randconfig-003-20240119   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240119   gcc  
riscv                 randconfig-002-20240119   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240119   clang
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240119   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64       buildonly-randconfig-001-20240119   gcc  
x86_64       buildonly-randconfig-002-20240119   gcc  
x86_64       buildonly-randconfig-003-20240119   gcc  
x86_64       buildonly-randconfig-004-20240119   gcc  
x86_64       buildonly-randconfig-005-20240119   gcc  
x86_64       buildonly-randconfig-006-20240119   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240119   clang
x86_64                randconfig-002-20240119   clang
x86_64                randconfig-003-20240119   clang
x86_64                randconfig-004-20240119   clang
x86_64                randconfig-005-20240119   clang
x86_64                randconfig-006-20240119   clang
x86_64                randconfig-011-20240119   gcc  
x86_64                randconfig-012-20240119   gcc  
x86_64                randconfig-013-20240119   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

