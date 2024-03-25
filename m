Return-Path: <linux-kernel+bounces-116604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC3788A100
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC5F1C2CCED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308715F3E2;
	Mon, 25 Mar 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTGLW1rV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB16D308
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349077; cv=none; b=njR1GEQ7KFoR5C0m/hcAfoU1oti72it1IxqeQYhlcT4B7vk1HYKBiaaRuVzx4cGI44QKZLnnZu4XuvUUZLQ3XodIsgLp8mrGQNVxKYhNhOjWz8pRQt/vxbKQ+UbBvX1t8apOICNzk3ALIHwfMw79CAPKO3suE+AgHBKbP1yQook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349077; c=relaxed/simple;
	bh=sEw4cNDwNZptxslVRdHYGcKnVkPUOZH2CIT6O6ywfos=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GbbMQLG2S0ZWGlhBJH0h/xoDh7zMEol6xpjJLB6Ji5qLr2NbPuDKOcrAXSte2ywz/XVS9or3hxZI4VoX/BOJXRP7PqXgkREQfKPhro7wew3da2jXvvI+XRQUZWp6akmT/Tc7FgZJ2DeexK387aigiJkjnYUa3Qbd+CO8DWY2zUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTGLW1rV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711349076; x=1742885076;
  h=date:from:to:cc:subject:message-id;
  bh=sEw4cNDwNZptxslVRdHYGcKnVkPUOZH2CIT6O6ywfos=;
  b=fTGLW1rVFRhoYB6Fyu6nTWQ1/rBswODkcgcQxn8/otOuxY9BVsUg9wsq
   vpdyEtlgVpfevRarQg3VXybSVSceBJXpeUAmpCCQoSUMuVCh1bFwL3oku
   hSxi/ATahyQgjmtRGnKb7G1YdHTFNIWQ6Tvgin2RUp43PDtYx0tGgWVQn
   ujdMQzn8pYEyRr1Sw6L00Hr+Nd+6acYQmGN3UZ7AcbqZ10a5pwFSjlBSd
   FOU3cZw8aulth7jE/mmaxCqR03yiiRRgiHY+6DhVKk64gT4TULveeW6Yg
   2CamksXwQ+XsBWeyBXvL14/kELIl3WUdoVVsCF04wZJapiAoYcKaAdJSJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10104254"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10104254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16179383"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Mar 2024 23:44:33 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1roe4M-000MIG-1s;
	Mon, 25 Mar 2024 06:44:30 +0000
Date: Mon, 25 Mar 2024 14:43:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 02ad32afaf75848d3b1d1c20485432c633ce23c6
Message-ID: <202403251437.hbwmtkB9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 02ad32afaf75848d3b1d1c20485432c633ce23c6  Merge branch into tip/master: 'x86/shstk'

elapsed time: 724m

configs tested: 178
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
arc                   randconfig-001-20240325   gcc  
arc                   randconfig-002-20240325   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   gcc  
arm                           imxrt_defconfig   clang
arm                          pxa3xx_defconfig   clang
arm                   randconfig-001-20240325   clang
arm                   randconfig-002-20240325   gcc  
arm                   randconfig-003-20240325   clang
arm                   randconfig-004-20240325   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240325   clang
arm64                 randconfig-002-20240325   clang
arm64                 randconfig-003-20240325   clang
arm64                 randconfig-004-20240325   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240325   gcc  
csky                  randconfig-002-20240325   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240325   clang
hexagon               randconfig-002-20240325   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240325   clang
i386         buildonly-randconfig-002-20240325   gcc  
i386         buildonly-randconfig-003-20240325   gcc  
i386         buildonly-randconfig-004-20240325   gcc  
i386         buildonly-randconfig-005-20240325   clang
i386         buildonly-randconfig-006-20240325   clang
i386                                defconfig   clang
i386                  randconfig-001-20240325   gcc  
i386                  randconfig-002-20240325   gcc  
i386                  randconfig-003-20240325   clang
i386                  randconfig-004-20240325   gcc  
i386                  randconfig-005-20240325   gcc  
i386                  randconfig-006-20240325   clang
i386                  randconfig-011-20240325   gcc  
i386                  randconfig-012-20240325   clang
i386                  randconfig-013-20240325   clang
i386                  randconfig-014-20240325   clang
i386                  randconfig-015-20240325   gcc  
i386                  randconfig-016-20240325   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240325   gcc  
loongarch             randconfig-002-20240325   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240325   gcc  
nios2                 randconfig-002-20240325   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           alldefconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240325   gcc  
parisc                randconfig-002-20240325   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240325   clang
powerpc               randconfig-002-20240325   clang
powerpc               randconfig-003-20240325   clang
powerpc                     tqm8560_defconfig   gcc  
powerpc                      tqm8xx_defconfig   clang
powerpc64             randconfig-001-20240325   clang
powerpc64             randconfig-002-20240325   clang
powerpc64             randconfig-003-20240325   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240325   clang
riscv                 randconfig-002-20240325   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240325   gcc  
s390                  randconfig-002-20240325   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240325   gcc  
sh                    randconfig-002-20240325   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240325   gcc  
sparc64               randconfig-002-20240325   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240325   gcc  
um                    randconfig-002-20240325   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240325   clang
x86_64       buildonly-randconfig-002-20240325   clang
x86_64       buildonly-randconfig-003-20240325   clang
x86_64       buildonly-randconfig-004-20240325   gcc  
x86_64       buildonly-randconfig-005-20240325   clang
x86_64       buildonly-randconfig-006-20240325   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240325   clang
x86_64                randconfig-002-20240325   gcc  
x86_64                randconfig-003-20240325   gcc  
x86_64                randconfig-004-20240325   gcc  
x86_64                randconfig-005-20240325   gcc  
x86_64                randconfig-006-20240325   clang
x86_64                randconfig-011-20240325   clang
x86_64                randconfig-012-20240325   clang
x86_64                randconfig-013-20240325   gcc  
x86_64                randconfig-014-20240325   gcc  
x86_64                randconfig-015-20240325   clang
x86_64                randconfig-016-20240325   gcc  
x86_64                randconfig-071-20240325   clang
x86_64                randconfig-072-20240325   clang
x86_64                randconfig-073-20240325   gcc  
x86_64                randconfig-074-20240325   clang
x86_64                randconfig-075-20240325   clang
x86_64                randconfig-076-20240325   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240325   gcc  
xtensa                randconfig-002-20240325   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

