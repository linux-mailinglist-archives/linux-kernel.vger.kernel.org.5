Return-Path: <linux-kernel+bounces-65371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EF854BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E3E1C216F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E55B21C;
	Wed, 14 Feb 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQ4xfWYm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B75BADF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922677; cv=none; b=cruggXhgnFdr2GA4goiFD4ALEc6/gXcueyUsaiwTw4/2HetgJkaRyoIeGvqCp5NcdJj0oiemibKVj9tWRNZxNI9KwvG5eTBAE0SCsbNOeI+vsHG9XDqGypp3a4PFTz3MG3ffNPrunGiffk615/UdSYVu2mIj8w60hXlMoMsajUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922677; c=relaxed/simple;
	bh=xafMFlByPvp0U6+/9B6C+QWjQzll0LufPATfwsGiFi0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gd3hcdXosua7/RNCroOqGXDsuLptpajXhPnYuY/yAg12tmf5dPixhEpK5cAd1YXfUy8WWBCmD1EOu403bbvKPQDwnxeQwI7Ni7+jGDOlCR1JSRlum+bQ9INJ3JL/SpkVDGBY76VmmOkBNLYGriazC1131GCjkT1V70m0u9lHReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQ4xfWYm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707922675; x=1739458675;
  h=date:from:to:cc:subject:message-id;
  bh=xafMFlByPvp0U6+/9B6C+QWjQzll0LufPATfwsGiFi0=;
  b=WQ4xfWYmcOql/18RZncNl0DM8wbgsoXuL2Uu+Jixb4Hl4igwvi8tsXBM
   8QgCoC/B0WvAi22rqxHnVIXiGIrcjjxkjfwCUeGMbhvdl07wdNIOZgLUD
   Ftxojt/TETeuppxkS7rVGvtMYfJH+/hbuX5VzMW+GisjzlzhRc3A2xvFX
   3Pbry/Ej7y7HqhUEceY2sbGgkV0J35pft/py2HQN7uzmDYjFr1zlJjk9M
   hTA2XUjzETChlFrt1Oh9v013o/vtRqptT5J6AKlGxDL0fiAqZH23iUpQg
   xZAAawo0LLZk2NN9GY/4/JBAvL0vGcDxEp3kkE6Jc+kqqwxYh3620agiA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1838254"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1838254"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 06:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3201125"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2024 06:57:54 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1raGhr-0008rY-0T;
	Wed, 14 Feb 2024 14:57:51 +0000
Date: Wed, 14 Feb 2024 22:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 7dd0a21ccb5a937ca9f798afad34de4ba030f8d4
Message-ID: <202402142220.0YrEX4fq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 7dd0a21ccb5a937ca9f798afad34de4ba030f8d4  Documentation/maintainer-tip: Add C++ tail comments exception

elapsed time: 1449m

configs tested: 182
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240214   gcc  
arc                   randconfig-002-20240214   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240214   clang
arm                   randconfig-002-20240214   gcc  
arm                   randconfig-003-20240214   clang
arm                   randconfig-004-20240214   clang
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240214   clang
arm64                 randconfig-002-20240214   clang
arm64                 randconfig-003-20240214   gcc  
arm64                 randconfig-004-20240214   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240214   gcc  
csky                  randconfig-002-20240214   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240214   clang
hexagon               randconfig-002-20240214   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240214   clang
i386         buildonly-randconfig-002-20240214   clang
i386         buildonly-randconfig-003-20240214   clang
i386         buildonly-randconfig-004-20240214   gcc  
i386         buildonly-randconfig-005-20240214   gcc  
i386         buildonly-randconfig-006-20240214   clang
i386                                defconfig   clang
i386                  randconfig-001-20240214   clang
i386                  randconfig-002-20240214   clang
i386                  randconfig-003-20240214   clang
i386                  randconfig-004-20240214   gcc  
i386                  randconfig-005-20240214   clang
i386                  randconfig-006-20240214   gcc  
i386                  randconfig-011-20240214   clang
i386                  randconfig-012-20240214   gcc  
i386                  randconfig-013-20240214   gcc  
i386                  randconfig-014-20240214   gcc  
i386                  randconfig-015-20240214   clang
i386                  randconfig-016-20240214   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240214   gcc  
loongarch             randconfig-002-20240214   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240214   gcc  
nios2                 randconfig-002-20240214   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240214   gcc  
parisc                randconfig-002-20240214   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        icon_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240214   clang
powerpc               randconfig-002-20240214   clang
powerpc               randconfig-003-20240214   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240214   clang
powerpc64             randconfig-002-20240214   clang
powerpc64             randconfig-003-20240214   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240214   clang
riscv                 randconfig-002-20240214   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240214   clang
s390                  randconfig-002-20240214   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240214   gcc  
sh                    randconfig-002-20240214   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240214   gcc  
sparc64               randconfig-002-20240214   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240214   clang
um                    randconfig-002-20240214   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240214   gcc  
x86_64       buildonly-randconfig-003-20240214   gcc  
x86_64       buildonly-randconfig-004-20240214   gcc  
x86_64       buildonly-randconfig-005-20240214   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240214   gcc  
x86_64                randconfig-004-20240214   gcc  
x86_64                randconfig-013-20240214   gcc  
x86_64                randconfig-014-20240214   gcc  
x86_64                randconfig-071-20240214   gcc  
x86_64                randconfig-073-20240214   gcc  
x86_64                randconfig-076-20240214   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240214   gcc  
xtensa                randconfig-002-20240214   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

