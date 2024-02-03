Return-Path: <linux-kernel+bounces-51040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C7848574
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3958AB24FEC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E35D902;
	Sat,  3 Feb 2024 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4dSvAv0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4C5D8F8
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706962138; cv=none; b=t1n4Yb4RUAJKA58vnIG8H05tJBN+xPrrx4KfBNikNbvnjLkzC4Wz4cl+Yod/XcQmbEXv+Nguifid1y+BA7Aj4/3sdcXPjiAPot4jWlbjAVT0U/64JDiQpdWcwJPubc+mWh1l51Wi/6a0DLxI+Fv0gM/rIJt17dQS1i/E/3gbQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706962138; c=relaxed/simple;
	bh=xMNpAhAsEry1vcYLjIuuEbsTzKSSIZ/3xxEaeYNs79o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i5Uv6wvDcFNhva0k0IuAA1mVh13VRRnpBlusSJYxnzMTFD7+0etWUz3GDvtedoxzKVN17AIMYym2giuBk0wVsnUjnQHhTtD/JWSdgN51D15wk1NDyeBrN6SBCRulCdvQ/iZBuODWmCIdpSaKxRUULyc60Hc5whGZ5MT4V+WylNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4dSvAv0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706962137; x=1738498137;
  h=date:from:to:cc:subject:message-id;
  bh=xMNpAhAsEry1vcYLjIuuEbsTzKSSIZ/3xxEaeYNs79o=;
  b=I4dSvAv0yaEbGB0tgYT3TI2WfvC+xfcdUSBPZm+vgxUEtgU+YeFsWD0H
   iVBpaV07HCtpg6pLpzPR++lPvpffccc6BDxe8U63uuxSmeecg0ej6R8Pu
   P23rRDjimzvjbWvdj8/MfZdGHjuxvZPXtjSKwuJhlWoQieQ1Vov+uTIyw
   AdIqMoQqho+ezXjYK+GNZKgdhAto7Sns5QNu+ZWgk/sQd51PSAPS2690U
   u4ZqAp7v8w4GzzWRbBdK7ZPkOMJY2l2e21eLqrgeppQiPmMqJXy+0lDG1
   347mBVMsE64GcqqADKSLMdiBPbP9sem/gWzFOoiAMYBjKPmYWVYqS0CLA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="220740"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="220740"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 04:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="4933851"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2024 04:08:55 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWEpI-00050m-2x;
	Sat, 03 Feb 2024 12:08:52 +0000
Date: Sat, 03 Feb 2024 20:08:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fred] BUILD SUCCESS
 e13841907b8fda0ae0ce1ec03684665f578416a8
Message-ID: <202402032048.pBxeHzOb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fred
branch HEAD: e13841907b8fda0ae0ce1ec03684665f578416a8  MAINTAINERS: Add a maintainer entry for FRED

elapsed time: 1451m

configs tested: 200
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
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-001-20240203   gcc  
arc                   randconfig-002-20240202   gcc  
arc                   randconfig-002-20240203   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240202   gcc  
arm                   randconfig-003-20240203   gcc  
arm                   randconfig-004-20240202   clang
arm                         socfpga_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-002-20240202   clang
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-003-20240203   gcc  
arm64                 randconfig-004-20240202   gcc  
arm64                 randconfig-004-20240203   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-001-20240203   gcc  
csky                  randconfig-002-20240202   gcc  
csky                  randconfig-002-20240203   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240202   clang
hexagon               randconfig-002-20240202   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240203   clang
i386         buildonly-randconfig-002-20240203   gcc  
i386         buildonly-randconfig-003-20240203   clang
i386         buildonly-randconfig-004-20240203   clang
i386         buildonly-randconfig-005-20240203   clang
i386         buildonly-randconfig-006-20240203   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240203   clang
i386                  randconfig-002-20240203   gcc  
i386                  randconfig-003-20240203   clang
i386                  randconfig-004-20240203   gcc  
i386                  randconfig-005-20240203   clang
i386                  randconfig-006-20240203   gcc  
i386                  randconfig-011-20240203   clang
i386                  randconfig-012-20240203   gcc  
i386                  randconfig-013-20240203   gcc  
i386                  randconfig-014-20240203   gcc  
i386                  randconfig-015-20240203   gcc  
i386                  randconfig-016-20240203   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-001-20240203   gcc  
loongarch             randconfig-002-20240202   gcc  
loongarch             randconfig-002-20240203   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-001-20240203   gcc  
nios2                 randconfig-002-20240202   gcc  
nios2                 randconfig-002-20240203   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-001-20240203   gcc  
parisc                randconfig-002-20240202   gcc  
parisc                randconfig-002-20240203   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                    mvme5100_defconfig   gcc  
powerpc               randconfig-001-20240202   clang
powerpc               randconfig-002-20240202   clang
powerpc               randconfig-003-20240202   clang
powerpc                  storcenter_defconfig   gcc  
powerpc64             randconfig-001-20240202   clang
powerpc64             randconfig-002-20240202   gcc  
powerpc64             randconfig-002-20240203   gcc  
powerpc64             randconfig-003-20240202   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240202   gcc  
riscv                 randconfig-002-20240202   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240202   clang
s390                  randconfig-001-20240203   gcc  
s390                  randconfig-002-20240202   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-001-20240203   gcc  
sh                    randconfig-002-20240202   gcc  
sh                    randconfig-002-20240203   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-001-20240203   gcc  
sparc64               randconfig-002-20240202   gcc  
sparc64               randconfig-002-20240203   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240202   clang
um                    randconfig-002-20240202   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240203   clang
x86_64                randconfig-013-20240203   clang
x86_64                randconfig-014-20240203   clang
x86_64                randconfig-015-20240203   clang
x86_64                randconfig-016-20240203   clang
x86_64                randconfig-071-20240203   clang
x86_64                randconfig-073-20240203   clang
x86_64                randconfig-074-20240203   clang
x86_64                randconfig-075-20240203   clang
x86_64                randconfig-076-20240203   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-001-20240203   gcc  
xtensa                randconfig-002-20240202   gcc  
xtensa                randconfig-002-20240203   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

