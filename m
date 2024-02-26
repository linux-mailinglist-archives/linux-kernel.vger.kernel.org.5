Return-Path: <linux-kernel+bounces-80685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C5866B30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED91F22F68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC921BDED;
	Mon, 26 Feb 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fepX1oxk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46752199DC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933306; cv=none; b=Z0UqW1QGfQkwMkmM7GyxcvNX3k7bSIwK0MqiBkT/K6guNuVjbub4HW7PalRWBLqm4GgoNEVLWaVbVLloBgPO4jh9tDpi/NGP5oddNMntR+1IdKsw75JRUde/xHk0Cnahz+G+V3udx1hW5VLl3Izlk4RmuJVfqRdkopvoHBAtwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933306; c=relaxed/simple;
	bh=rEkBbasZykz1qiqmE7jbJBxvdqSBl4ZZQqCBXt/5MHw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vC81contfa0BrmJBvV9kWLxz7VpglwS2K0jYcI6n+BKsGdmgVFmWsIjB1fw7PuY9RcmDGwa9j3f2B4jJWfV5ytj5mkhzCr1OZxq1Olqa8M9sotRWcPv4wlNgYzx0eIc86FLm8mzu1utJzTflldVaaO7RcB8hCFHk8nGcQBLNF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fepX1oxk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708933304; x=1740469304;
  h=date:from:to:cc:subject:message-id;
  bh=rEkBbasZykz1qiqmE7jbJBxvdqSBl4ZZQqCBXt/5MHw=;
  b=fepX1oxkqqf213JMIvXQoqCHFOEYxnXfvyN31U3hhItA6LtKfqdkGnbY
   eGx8P66bbn2W/xhy5I0cmt2XcOIMd7LZN46uhHoQTyJ4iImaanc9FN+R5
   YQ6FNWFh9x1Tpqo9kNt0+AekDoJBnf7GlCbMpP9f+fk0QF2vaxA2W1X3L
   gngTvZk74a+s/RXCk/OGqN4Z/Yq3CwEp2rcpV7wQO7dDzAIht2VuBR5P6
   1ah+I/8eVRhPifUkav9oA1tHXKGIYSMiGwSdKkeaCgXZvSZkz38hwWWDQ
   hwrAh1sIKYgzWCCUH3xWrdxPcfXkpEajRiGcNkKzzs/Bw11zm0cGUGOCW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3043898"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3043898"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:41:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11261652"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Feb 2024 23:41:41 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reVcI-000AA1-0G;
	Mon, 26 Feb 2024 07:41:38 +0000
Date: Mon, 26 Feb 2024 15:41:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 c147e1ef59d4751a60687074e4268ecc0ef31b5c
Message-ID: <202402261511.VWGUn2KV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: c147e1ef59d4751a60687074e4268ecc0ef31b5c  x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for HPET/IO-APIC domain search

elapsed time: 820m

configs tested: 191
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240226   gcc  
arc                   randconfig-002-20240226   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                   randconfig-001-20240226   clang
arm                   randconfig-002-20240226   clang
arm                   randconfig-003-20240226   clang
arm                   randconfig-004-20240226   gcc  
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240226   gcc  
arm64                 randconfig-002-20240226   gcc  
arm64                 randconfig-003-20240226   gcc  
arm64                 randconfig-004-20240226   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240226   gcc  
csky                  randconfig-002-20240226   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240226   clang
hexagon               randconfig-002-20240226   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240226   clang
i386         buildonly-randconfig-002-20240226   gcc  
i386         buildonly-randconfig-003-20240226   clang
i386         buildonly-randconfig-004-20240226   clang
i386         buildonly-randconfig-005-20240226   clang
i386         buildonly-randconfig-006-20240226   clang
i386                                defconfig   clang
i386                  randconfig-001-20240226   clang
i386                  randconfig-002-20240226   gcc  
i386                  randconfig-003-20240226   clang
i386                  randconfig-004-20240226   gcc  
i386                  randconfig-005-20240226   clang
i386                  randconfig-006-20240226   clang
i386                  randconfig-011-20240226   gcc  
i386                  randconfig-012-20240226   gcc  
i386                  randconfig-013-20240226   gcc  
i386                  randconfig-014-20240226   gcc  
i386                  randconfig-015-20240226   gcc  
i386                  randconfig-016-20240226   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240226   gcc  
loongarch             randconfig-002-20240226   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240226   gcc  
nios2                 randconfig-002-20240226   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240226   gcc  
parisc                randconfig-002-20240226   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240226   clang
powerpc               randconfig-002-20240226   gcc  
powerpc               randconfig-003-20240226   clang
powerpc64             randconfig-001-20240226   clang
powerpc64             randconfig-002-20240226   gcc  
powerpc64             randconfig-003-20240226   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240226   clang
riscv                 randconfig-002-20240226   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240226   clang
s390                  randconfig-002-20240226   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240226   gcc  
sh                    randconfig-002-20240226   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240226   gcc  
sparc64               randconfig-002-20240226   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240226   clang
um                    randconfig-002-20240226   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240226   clang
x86_64       buildonly-randconfig-002-20240226   gcc  
x86_64       buildonly-randconfig-003-20240226   gcc  
x86_64       buildonly-randconfig-004-20240226   clang
x86_64       buildonly-randconfig-005-20240226   gcc  
x86_64       buildonly-randconfig-006-20240226   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240226   gcc  
x86_64                randconfig-002-20240226   gcc  
x86_64                randconfig-003-20240226   clang
x86_64                randconfig-004-20240226   clang
x86_64                randconfig-005-20240226   clang
x86_64                randconfig-006-20240226   gcc  
x86_64                randconfig-011-20240226   clang
x86_64                randconfig-012-20240226   clang
x86_64                randconfig-013-20240226   clang
x86_64                randconfig-014-20240226   clang
x86_64                randconfig-015-20240226   clang
x86_64                randconfig-016-20240226   clang
x86_64                randconfig-071-20240226   clang
x86_64                randconfig-072-20240226   gcc  
x86_64                randconfig-073-20240226   gcc  
x86_64                randconfig-074-20240226   clang
x86_64                randconfig-075-20240226   gcc  
x86_64                randconfig-076-20240226   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240226   gcc  
xtensa                randconfig-002-20240226   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

