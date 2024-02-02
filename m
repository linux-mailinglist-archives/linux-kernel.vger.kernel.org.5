Return-Path: <linux-kernel+bounces-49574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCA4846BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064EBB307D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C277F09;
	Fri,  2 Feb 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d49CZ5ls"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0C717999
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865964; cv=none; b=Jxtn7kNL2J+mz+7qvrZ5NxwVCgDur1SGWOA0hpfCdUrIipiRegMjkeqyAh1r2SEhrATiKgQ6big57IU++dyVh6WWLjvsA1OppBWO6clyqBFG8hZuQ7NYAxmTvVLPD3bNZwyhBHzgDs/FWL2lYUwMKmHkGZXgZ8ooirxxZgNUPU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865964; c=relaxed/simple;
	bh=dKsg47viHz6qAaOy95EPVVTrYpY1u1quP+5ho4UfXJ4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ugrahlb4yBNfP3vzHIOvuFA6PahnEClRJus5BMjqAkZeP7078CONfHJtwLPQi5nXI8PPldEDV8rbR5s+1nKNxNgFLasEH9uNgklTu8L4ZPncun85s917owzPA882/9L/ItTaO+KgVho0A+ULEjjINDCWvN2KvFH6Yw/7OcQWsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d49CZ5ls; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865963; x=1738401963;
  h=date:from:to:cc:subject:message-id;
  bh=dKsg47viHz6qAaOy95EPVVTrYpY1u1quP+5ho4UfXJ4=;
  b=d49CZ5ls9PXzTewaeASK4lM3iGQYI95/rDQsTODFAkzFBpBLGbOcteHR
   1mYVWLN0uyp+DG2LAkl595dq/+X9qxoC2fIekY6XkJ1fp1rhxCMM5NpjC
   hOEOAz5limroVm6dR9f4OBfhWhEOgp3Js1ciSWVQBC4CvHxQPMnXX9ir9
   TsHgm/QPMH1SvhhG8crNFasVGtCNZKjMWhKnJXnKgJFcRVkuXANQMZbTC
   dgWelsVGwvPVMB+RC+tXw/39Candb8nATtvJDmbGQgVnzhJ4PSYBmjKwP
   lR7uJDqH+QM8YkLAsnAJ/VgP5OF3TsrOt/Jz0OkqimqWNQVAlkxEjAcRP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10729246"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10729246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4614937"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 02 Feb 2024 01:26:01 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVpo6-0003jd-24;
	Fri, 02 Feb 2024 09:25:58 +0000
Date: Fri, 02 Feb 2024 17:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 fc471a60797b758dfe29f02476dc2573f0c2f219
Message-ID: <202402021758.6pT7abCJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: fc471a60797b758dfe29f02476dc2573f0c2f219  Merge branch 'x86/fred' into x86/merge, to ease integration testing

elapsed time: 1455m

configs tested: 179
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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-002-20240202   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240202   gcc  
arm                   randconfig-004-20240202   clang
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-002-20240202   clang
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-004-20240202   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-002-20240202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240202   clang
hexagon               randconfig-002-20240202   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240202   gcc  
i386         buildonly-randconfig-002-20240202   clang
i386         buildonly-randconfig-003-20240202   gcc  
i386         buildonly-randconfig-004-20240202   clang
i386         buildonly-randconfig-005-20240202   clang
i386         buildonly-randconfig-006-20240202   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240202   gcc  
i386                  randconfig-002-20240202   gcc  
i386                  randconfig-003-20240202   clang
i386                  randconfig-004-20240202   gcc  
i386                  randconfig-005-20240202   gcc  
i386                  randconfig-006-20240202   gcc  
i386                  randconfig-011-20240202   gcc  
i386                  randconfig-012-20240202   gcc  
i386                  randconfig-013-20240202   gcc  
i386                  randconfig-014-20240202   clang
i386                  randconfig-015-20240202   gcc  
i386                  randconfig-016-20240202   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-002-20240202   gcc  
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
mips                      malta_kvm_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-002-20240202   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-002-20240202   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240202   clang
powerpc               randconfig-002-20240202   clang
powerpc               randconfig-003-20240202   clang
powerpc64             randconfig-001-20240202   clang
powerpc64             randconfig-002-20240202   gcc  
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
s390                                defconfig   clang
s390                  randconfig-001-20240202   clang
s390                  randconfig-002-20240202   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-002-20240202   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-002-20240202   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240202   clang
um                    randconfig-002-20240202   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240202   clang
x86_64       buildonly-randconfig-002-20240202   clang
x86_64       buildonly-randconfig-003-20240202   clang
x86_64       buildonly-randconfig-004-20240202   clang
x86_64       buildonly-randconfig-005-20240202   gcc  
x86_64       buildonly-randconfig-006-20240202   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240202   clang
x86_64                randconfig-002-20240202   clang
x86_64                randconfig-003-20240202   gcc  
x86_64                randconfig-004-20240202   gcc  
x86_64                randconfig-005-20240202   gcc  
x86_64                randconfig-006-20240202   gcc  
x86_64                randconfig-011-20240202   clang
x86_64                randconfig-012-20240202   clang
x86_64                randconfig-013-20240202   gcc  
x86_64                randconfig-014-20240202   clang
x86_64                randconfig-015-20240202   clang
x86_64                randconfig-016-20240202   clang
x86_64                randconfig-071-20240202   gcc  
x86_64                randconfig-072-20240202   clang
x86_64                randconfig-073-20240202   gcc  
x86_64                randconfig-074-20240202   clang
x86_64                randconfig-075-20240202   gcc  
x86_64                randconfig-076-20240202   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-002-20240202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

