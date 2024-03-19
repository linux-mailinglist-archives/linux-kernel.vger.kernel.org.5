Return-Path: <linux-kernel+bounces-107256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E687FA07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B03D1F21FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360A54BF6;
	Tue, 19 Mar 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gW3vlYHR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5429C22339
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837391; cv=none; b=MCoSjeVU8ExSuq/eFJNMv9FnPpBCBBjDQitqKqb/Ni31meT3A22vERqVDRa7Z0WVQI/a/aXbB7WSzyXAtJMzauxWbSOVIQJI/Gv5fZ6LPfgoBudjPZLUhrTjs/hHEcFzcMizA47HrGAayUF/sQFhu6eul5WkXvqS9Spk/v0GfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837391; c=relaxed/simple;
	bh=2JYVmijcx8HXIsIY0AGWArV/tySLDGbRHomkYzLAdf8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uSnooF4tU1ABRUPv3LHlfZpQ+kMPsAC/MK1Pr53gxQgLSopA57ey+NY852nUNqvb9Xc2K488Kitnzx+wLGc6WQzY24JXc2DjcyitpyAC9T1uh1DCf7kD66Qi9NIYU90B2thziBTy2qU6C1MNSX21jHwbzRDbQ8Q+2Q4uWkW7+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gW3vlYHR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710837391; x=1742373391;
  h=date:from:to:cc:subject:message-id;
  bh=2JYVmijcx8HXIsIY0AGWArV/tySLDGbRHomkYzLAdf8=;
  b=gW3vlYHRFj4edHImTiZGk0GXtTDxlfZX+JYL3uIehjeMSJQYIcFK21GU
   IiXDKgR6tn8nKhYHdT9fKKu3QHuoL8GTwKXtqXhcgeENCBEpsfV6FuPMd
   uYWOLxH/QDqUgQnIfPiSShc9jRNIMDFJsWQ3L2/qm3AEYceLjdqx5tA1k
   pc84N8AUFQQT3ov6eAGR73djyDup59tqvNEU1t2P58tFeYuEhk3hYsX8J
   HeSm9/SDFeUGNE9Mt8P98tcJoJvkb69cCyJevuP4EGJmKWMIuKpxwlIev
   NWLWCA9EMfwEyNQmwPoSszFvQEolYn7lSeWuTd2HogwPWpI32ebB2FJED
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5814756"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5814756"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:36:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="14124225"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2024 01:36:29 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmUxO-000Hb9-0N;
	Tue, 19 Mar 2024 08:36:26 +0000
Date: Tue, 19 Mar 2024 16:36:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 dce0919c83c325ac9dec5bc8838d5de6d32c01b1
Message-ID: <202403191621.oES1oB5M-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: dce0919c83c325ac9dec5bc8838d5de6d32c01b1  irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time

elapsed time: 745m

configs tested: 178
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
arc                   randconfig-001-20240319   gcc  
arc                   randconfig-002-20240319   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240319   clang
arm                   randconfig-002-20240319   gcc  
arm                   randconfig-003-20240319   clang
arm                   randconfig-004-20240319   clang
arm                       spear13xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240319   gcc  
arm64                 randconfig-002-20240319   clang
arm64                 randconfig-003-20240319   clang
arm64                 randconfig-004-20240319   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240319   gcc  
csky                  randconfig-002-20240319   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240319   clang
hexagon               randconfig-002-20240319   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240319   clang
i386         buildonly-randconfig-002-20240319   clang
i386         buildonly-randconfig-003-20240319   clang
i386         buildonly-randconfig-004-20240319   clang
i386         buildonly-randconfig-005-20240319   gcc  
i386         buildonly-randconfig-006-20240319   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240319   clang
i386                  randconfig-002-20240319   clang
i386                  randconfig-003-20240319   clang
i386                  randconfig-004-20240319   clang
i386                  randconfig-005-20240319   clang
i386                  randconfig-006-20240319   gcc  
i386                  randconfig-011-20240319   gcc  
i386                  randconfig-013-20240319   gcc  
i386                  randconfig-014-20240319   clang
i386                  randconfig-016-20240319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240319   gcc  
loongarch             randconfig-002-20240319   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                         db1xxx_defconfig   clang
mips                           ip22_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240319   gcc  
nios2                 randconfig-002-20240319   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240319   gcc  
parisc                randconfig-002-20240319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                     asp8347_defconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   clang
powerpc                     mpc83xx_defconfig   clang
powerpc                      ppc44x_defconfig   clang
powerpc               randconfig-001-20240319   gcc  
powerpc               randconfig-002-20240319   clang
powerpc               randconfig-003-20240319   clang
powerpc64             randconfig-001-20240319   gcc  
powerpc64             randconfig-002-20240319   clang
powerpc64             randconfig-003-20240319   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240319   gcc  
riscv                 randconfig-002-20240319   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240319   gcc  
s390                  randconfig-002-20240319   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20240319   gcc  
sh                    randconfig-002-20240319   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240319   gcc  
sparc64               randconfig-002-20240319   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240319   gcc  
um                    randconfig-002-20240319   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240319   clang
x86_64       buildonly-randconfig-002-20240319   clang
x86_64       buildonly-randconfig-003-20240319   clang
x86_64       buildonly-randconfig-004-20240319   clang
x86_64       buildonly-randconfig-005-20240319   clang
x86_64       buildonly-randconfig-006-20240319   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240319   clang
x86_64                randconfig-002-20240319   clang
x86_64                randconfig-003-20240319   clang
x86_64                randconfig-004-20240319   gcc  
x86_64                randconfig-005-20240319   gcc  
x86_64                randconfig-006-20240319   gcc  
x86_64                randconfig-011-20240319   clang
x86_64                randconfig-012-20240319   clang
x86_64                randconfig-013-20240319   gcc  
x86_64                randconfig-014-20240319   gcc  
x86_64                randconfig-015-20240319   clang
x86_64                randconfig-016-20240319   clang
x86_64                randconfig-071-20240319   gcc  
x86_64                randconfig-072-20240319   clang
x86_64                randconfig-073-20240319   gcc  
x86_64                randconfig-074-20240319   clang
x86_64                randconfig-075-20240319   clang
x86_64                randconfig-076-20240319   clang
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240319   gcc  
xtensa                randconfig-002-20240319   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

