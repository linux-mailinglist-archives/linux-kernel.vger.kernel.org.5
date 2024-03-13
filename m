Return-Path: <linux-kernel+bounces-102606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DD87B481
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2211C2146E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF85D732;
	Wed, 13 Mar 2024 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHdHjArz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B75D724
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369730; cv=none; b=PoMAf53I8L03gemYE+cviYpB6tetT+4W77dKbJljf6hJl/LEW6i8UUndeR/ubb5Vv2rWk776HVt5z8O6Cu+1sQ1ZtyjK9+lLyuTuHfkdKzsEQiWTRtVibqQXz9IHJDcq/jI3bJ8HnUFdSV9ggc4MfGL0JZwIYef3cDIVhX2eCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369730; c=relaxed/simple;
	bh=UljmcyWk8FL62RbD1WTsxgMjl7IRgNuGBvzCZcwJBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qvEehMUeTonsp7W20WOl14Mz2feG9GvUFxs1H8G5C7JjcpxIS9svtY2jDy4ZlNfo2qwwCyKxnxh0QXV+yU6JKsmSnyMf6C+O5FrpK0One84A2NJ+AVClQyzLdRdVatWIj9OZatqeAUxPt8y/nROVdhxEVUDj41IUU7sX0JGjT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHdHjArz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710369728; x=1741905728;
  h=date:from:to:cc:subject:message-id;
  bh=UljmcyWk8FL62RbD1WTsxgMjl7IRgNuGBvzCZcwJBrQ=;
  b=PHdHjArz92eVV71KXPpCF9wK3LHIUeViBZ6NX2Q7aOX4Drfj5Lm3rTQH
   /SIU6pRXEPwz+AWhd4iw2pk6M+Ss7ieItyb0oVwI5XJ4yMSdt4tAOuKzo
   eeikfETojPfmLuSBL5rYugJ9vUhfm6+eQ0bcJM9w+ggzCiAUQRsGoW3Hx
   XfVcrceRbdFNpp/zLTI8+lSUa9e1JylwQJUkTVtz10gEjcmaQpb61eyTS
   b2Lpc6sljKGbT2iRm33JWnlW9avR0qehT8oeXY6zTkN8ByDFQMy7XG0+5
   ptOk63z+QXOCVvZ3FWini96bojonXEqGIRs5o1HRIM4xH/hXUVSvcllyM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5774318"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="5774318"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 15:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="11971442"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Mar 2024 15:42:06 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkXIR-000Cpf-2h;
	Wed, 13 Mar 2024 22:42:03 +0000
Date: Thu, 14 Mar 2024 06:41:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 9b67ce2c121fbf11c0c7b6216c08200fda23c9af
Message-ID: <202403140636.CugYVHyM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 9b67ce2c121fbf11c0c7b6216c08200fda23c9af  x86/vmlinux.lds.S: Take __START_KERNEL out conditional definition

elapsed time: 721m

configs tested: 142
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
arc                     haps_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                       netwinder_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-001-20240314   clang
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-002-20240314   clang
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386         buildonly-randconfig-006-20240314   clang
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-002-20240314   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-004-20240314   clang
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-011-20240314   clang
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-013-20240314   clang
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-015-20240314   clang
i386                  randconfig-016-20240313   gcc  
i386                  randconfig-016-20240314   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
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
mips                         rt305x_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      bamboo_defconfig   clang
powerpc                     kilauea_defconfig   clang
powerpc                     ksi8560_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-004-20240314   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240314   gcc  
x86_64                randconfig-002-20240314   gcc  
x86_64                randconfig-012-20240314   gcc  
x86_64                randconfig-013-20240314   gcc  
x86_64                randconfig-014-20240314   gcc  
x86_64                randconfig-016-20240314   gcc  
x86_64                randconfig-071-20240314   gcc  
x86_64                randconfig-074-20240314   gcc  
x86_64                randconfig-075-20240314   gcc  
x86_64                randconfig-076-20240314   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

