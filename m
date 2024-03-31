Return-Path: <linux-kernel+bounces-126373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F818935E9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2475282336
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC4148306;
	Sun, 31 Mar 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1xzsrO8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9F1474CB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711919444; cv=none; b=mtzRupplKBXHC5Rxc6/KNzt0wy/7DDMPbgXRuwG6Kly0L/7tpgkLKp/SAw9j5xrnH9e9jUJBQvBZPE2PewcSCsgpZJkKwIzCFEFtrBln5vK5dLW+8Oe84Zl7pRCQeJhTqFsS37oEiR4tGnQ6wtKUBPeMFgU3FNK4eYVeztgEXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711919444; c=relaxed/simple;
	bh=Wzj9g1xyFpQ3g1A4yQ1g2JCcncSNQVnv7CLAXzaFkFs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WAUvbW0imtPPp3He9FkxlqF8j+GifA5WT0p3V9hb+EQR/7VF5Za/Wduqiovn1Qg8yzlggCF2ny/RogUDfCbup0NmfyFqNYRcKLtwiZyHI/VYNnazKVDbjORQvykWo3cfmMB7SFDfwiflzOFrSQsCXw6gk4f903pErBP4SZNTjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1xzsrO8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711919442; x=1743455442;
  h=date:from:to:cc:subject:message-id;
  bh=Wzj9g1xyFpQ3g1A4yQ1g2JCcncSNQVnv7CLAXzaFkFs=;
  b=K1xzsrO8cE0gn0wiyaC0cH2Shi5Ft89G9Kyy5QLsU5I2o84LXsjyDhBb
   jngWOexS3avGQ5EJXzNtGClTw9PYQcKVuQYxOg29biwJ1J3+hYcJq0GAp
   9+1w2X0EcZ8FTTDdKuF7LObVE2Dc2504JySJ68QMRqv0Ms96m3PanqeKc
   GcWF3XGcyY0nwDl0MBhGjGmwaJbs/NIwdpHvXZqYDpjyFdpF03GQAISV/
   gXvBrGwYUhpWzsLb11WGNc5OwPP5QVNGDeWhLAC2k/cbjBKWVqOy30Ajt
   aTQLdK7c6NiDyK2x1Xdv9FRkCtqMEqXwrramnFG/ypMAf9z0d4N+65uFe
   Q==;
X-CSE-ConnectionGUID: y4lUQPc0QLWUCcedKUzXCQ==
X-CSE-MsgGUID: eGDnp7vPQgmJRqaQe2FZtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="29521590"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="29521590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 14:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="17913700"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 31 Mar 2024 14:10:39 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rr2Rp-0001Pl-1R;
	Sun, 31 Mar 2024 21:10:37 +0000
Date: Mon, 01 Apr 2024 05:10:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 31d40ceb1bc4008ab741e2881cdb3e42d8763db5
Message-ID: <202404010502.E6F5Rocu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 31d40ceb1bc4008ab741e2881cdb3e42d8763db5  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1423m

configs tested: 180
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
arc                   randconfig-001-20240331   gcc  
arc                   randconfig-002-20240331   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       imx_v6_v7_defconfig   clang
arm                         nhk8815_defconfig   clang
arm                           omap1_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20240331   gcc  
arm                   randconfig-002-20240331   gcc  
arm                   randconfig-003-20240331   clang
arm                   randconfig-004-20240331   clang
arm                        realview_defconfig   clang
arm                          sp7021_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240331   gcc  
arm64                 randconfig-002-20240331   gcc  
arm64                 randconfig-003-20240331   gcc  
arm64                 randconfig-004-20240331   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240331   gcc  
csky                  randconfig-002-20240331   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240331   clang
hexagon               randconfig-002-20240331   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240331   clang
i386         buildonly-randconfig-002-20240331   clang
i386         buildonly-randconfig-003-20240331   clang
i386         buildonly-randconfig-004-20240331   gcc  
i386         buildonly-randconfig-005-20240331   gcc  
i386         buildonly-randconfig-006-20240331   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240331   gcc  
i386                  randconfig-002-20240331   gcc  
i386                  randconfig-003-20240331   clang
i386                  randconfig-004-20240331   gcc  
i386                  randconfig-005-20240331   gcc  
i386                  randconfig-006-20240331   gcc  
i386                  randconfig-011-20240331   clang
i386                  randconfig-012-20240331   gcc  
i386                  randconfig-013-20240331   gcc  
i386                  randconfig-014-20240331   gcc  
i386                  randconfig-015-20240331   clang
i386                  randconfig-016-20240331   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240331   gcc  
loongarch             randconfig-002-20240331   gcc  
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
mips                           mtx1_defconfig   clang
mips                         rt305x_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240331   gcc  
nios2                 randconfig-002-20240331   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240331   gcc  
parisc                randconfig-002-20240331   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc834x_itx_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240331   clang
powerpc               randconfig-002-20240331   gcc  
powerpc               randconfig-003-20240331   clang
powerpc64             randconfig-001-20240331   clang
powerpc64             randconfig-002-20240331   gcc  
powerpc64             randconfig-003-20240331   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240331   gcc  
riscv                 randconfig-002-20240331   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240331   clang
s390                  randconfig-002-20240331   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240331   gcc  
sh                    randconfig-002-20240331   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240331   gcc  
sparc64               randconfig-002-20240331   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240331   clang
um                    randconfig-002-20240331   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240331   gcc  
x86_64       buildonly-randconfig-002-20240331   clang
x86_64       buildonly-randconfig-003-20240331   clang
x86_64       buildonly-randconfig-004-20240331   clang
x86_64       buildonly-randconfig-005-20240331   clang
x86_64       buildonly-randconfig-006-20240331   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240331   gcc  
x86_64                randconfig-002-20240331   gcc  
x86_64                randconfig-003-20240331   gcc  
x86_64                randconfig-004-20240331   clang
x86_64                randconfig-005-20240331   gcc  
x86_64                randconfig-006-20240331   clang
x86_64                randconfig-011-20240331   gcc  
x86_64                randconfig-012-20240331   clang
x86_64                randconfig-013-20240331   gcc  
x86_64                randconfig-014-20240331   gcc  
x86_64                randconfig-015-20240331   gcc  
x86_64                randconfig-016-20240331   gcc  
x86_64                randconfig-071-20240331   gcc  
x86_64                randconfig-072-20240331   gcc  
x86_64                randconfig-073-20240331   gcc  
x86_64                randconfig-074-20240331   clang
x86_64                randconfig-075-20240331   gcc  
x86_64                randconfig-076-20240331   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240331   gcc  
xtensa                randconfig-002-20240331   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

