Return-Path: <linux-kernel+bounces-85297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492886B3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B26289C85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4515D5C9;
	Wed, 28 Feb 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifc99CVO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4915D5AB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135341; cv=none; b=doba32NDx9XC2qmjMaTQ3/z2ZITP3CRX6cVAP0lgUxunAoiKGUg7H3Hmfp7WhIZgfTTdWct5AVeeGjh+sgpX/nbe71erEWsq75Zz/ZzgXYiWkY/fqPdDNoMHUwrFAjzSHeAvcpe5CWI1F2jSKQyvtOI3/SyaldWJVrcPVfyU0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135341; c=relaxed/simple;
	bh=8hMJO7MF9qiQtx2ZVy+p4iRGbcW+mf/pXZ8jZo+js4I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NcIvMfDDpgkrdoB/V8eER6HrlXiVDbt4fqJTnX88++4gPCuaSOI8OPqh7BQOh75eLukKIfOj5ZMrIPtqEwp61gdG+5Rg+h0kVh7lC0gIqDsiRm2m4LO+nlkTK6SSLd7boSo7RTsU6KnVkSTSNbmzd4R39kccjxnk9FAsJWpgkrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifc99CVO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709135340; x=1740671340;
  h=date:from:to:cc:subject:message-id;
  bh=8hMJO7MF9qiQtx2ZVy+p4iRGbcW+mf/pXZ8jZo+js4I=;
  b=ifc99CVOKpgqehkXi1uzUtZiNhGXcGW1z1G3VDG/2hYN4qII+ybePcOO
   12qKGZKTYbG5atJ9VNQYoEz+iJzfFotgAtmmAP34xMfEwfLRTfKSETcZr
   9OYhhCVRvcLmYbSUSIlX/NmkXCONoR6w5sTBTj9oxA2hQFoyj+w0J9dRd
   cWlwcOhiQgOmQOb+mu96BKFONPBlR+KaK4Vw+yfI77JHdo3CJm6JIK1Rh
   +0OISroad0fSHzKW3Q6s/1WTEBl08y2jOwJ07vPnY9cpLKO/ItuHYVang
   2hdeeM+J4N8UdvfkCD6NiW78OHbwWer9WqApSrbeESiZ/SXWgMrUYyFYg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3703933"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3703933"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 07:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7520108"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 07:48:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfMAx-000CBU-2r;
	Wed, 28 Feb 2024 15:48:55 +0000
Date: Wed, 28 Feb 2024 23:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 47403a4b49767f1d533e4dc5f5cf5cc957f22a5e
Message-ID: <202402282318.hVsqkeaw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 47403a4b49767f1d533e4dc5f5cf5cc957f22a5e  x86/nmi: Remove an unnecessary IS_ENABLED(CONFIG_SMP)

elapsed time: 1105m

configs tested: 135
configs skipped: 132

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
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240228   gcc  
arc                   randconfig-002-20240228   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-004-20240228   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240228   gcc  
arm64                 randconfig-003-20240228   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240228   gcc  
csky                  randconfig-002-20240228   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240228   clang
i386         buildonly-randconfig-002-20240228   clang
i386         buildonly-randconfig-003-20240228   clang
i386         buildonly-randconfig-004-20240228   clang
i386         buildonly-randconfig-006-20240228   clang
i386                                defconfig   clang
i386                  randconfig-001-20240228   clang
i386                  randconfig-002-20240228   clang
i386                  randconfig-004-20240228   clang
i386                  randconfig-005-20240228   clang
i386                  randconfig-011-20240228   clang
i386                  randconfig-012-20240228   clang
i386                  randconfig-016-20240228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240228   gcc  
loongarch             randconfig-002-20240228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240228   gcc  
nios2                 randconfig-002-20240228   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                  or1klitex_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240228   gcc  
parisc                randconfig-002-20240228   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc               randconfig-003-20240228   gcc  
powerpc                    socrates_defconfig   gcc  
powerpc64             randconfig-003-20240228   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
s390                  randconfig-002-20240228   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240228   gcc  
sh                    randconfig-002-20240228   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240228   gcc  
sparc64               randconfig-002-20240228   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240228   clang
x86_64       buildonly-randconfig-003-20240228   clang
x86_64       buildonly-randconfig-006-20240228   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240228   clang
x86_64                randconfig-006-20240228   clang
x86_64                randconfig-011-20240228   clang
x86_64                randconfig-012-20240228   clang
x86_64                randconfig-013-20240228   clang
x86_64                randconfig-072-20240228   clang
x86_64                randconfig-075-20240228   clang
x86_64                randconfig-076-20240228   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240228   gcc  
xtensa                randconfig-002-20240228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

