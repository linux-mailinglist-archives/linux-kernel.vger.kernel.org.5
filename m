Return-Path: <linux-kernel+bounces-109506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F8881A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC5F2847D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E06186A;
	Thu, 21 Mar 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geYk4rpz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8B63C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979472; cv=none; b=qV58GxZYrdWl9unJFPeZItgC326xzWqlTjhbjX+EylSn08nGd0d9XK5qWpbvdq0R+yUtSpgsuPxz0DWPLZohrd0Mfc8EBHQa8OU9iaXX/im8phhYjFBuLmfflYppAAqz53p26pulD1kiwo4uoJ3hj+dA8anEF0wLpU5k9vddaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979472; c=relaxed/simple;
	bh=oPPoL6qvu/QNZh+Lm2zK+szt2qc+mfl+EDHv8n3fBgA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hQOU5CzKZLBgl0NsAdQOkZG3g8e+obtplUvrSBv1IC3OS4qnVLCY+BEBuLEA2WqVIQ31RMlRhv20Qbvp8QFIMQSk3N85aFicfAX/ymJo6NkjtWUbQx8Js4smNIqzh/YZ5oeC3KAzW6jbpijB1dbtm1t56/tcuYsuv0H/v0GZWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geYk4rpz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710979470; x=1742515470;
  h=date:from:to:cc:subject:message-id;
  bh=oPPoL6qvu/QNZh+Lm2zK+szt2qc+mfl+EDHv8n3fBgA=;
  b=geYk4rpz3FTBLLHeNhGKkJERfp4i3XUoTXszUsSwzoCb1QmiYqN8FJAn
   Ii0EjZQ5BeLpRpqtVyNeDWsN45X3pRUjo8aFS1dpsfMIdFh0s0UzX1B+W
   mWbeZ9PZX8aIHZE8aZyfNfwnJ1Kr4+0CUHG7Q9jf+PVsBZ6Nndmc9i0rm
   slOnYeQUPU/hyoIupkKfqiZsDBLx+37YvtPQu5Gis57Qv3hX26IxSP5wk
   U0ZHS+CBzmZNM28Z7c1E8v+9vaxajU8SbAzcwEEfCTboEOhKicAlQ25T4
   pEsatpYzdQMkhPg3m11dqMDQqZHSEukRCUlTqvn66qV3UE54TKholWjwu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6074144"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="6074144"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 17:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="45422520"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Mar 2024 17:04:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn5uz-000J15-18;
	Thu, 21 Mar 2024 00:04:25 +0000
Date: Thu, 21 Mar 2024 08:03:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 648337147d3550c1ca3d1b500e66dbda12e2d836
Message-ID: <202403210848.VAcp5zDK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: 648337147d3550c1ca3d1b500e66dbda12e2d836  x86/asm: Use "m" operand constraint in WRUSSQ asm template

elapsed time: 740m

configs tested: 155
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240321   gcc  
arc                   randconfig-002-20240321   gcc  
arm                   randconfig-002-20240321   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240321   gcc  
csky                  randconfig-002-20240321   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240320   clang
i386         buildonly-randconfig-002-20240320   gcc  
i386         buildonly-randconfig-003-20240320   gcc  
i386         buildonly-randconfig-003-20240321   clang
i386         buildonly-randconfig-004-20240320   clang
i386         buildonly-randconfig-004-20240321   clang
i386         buildonly-randconfig-005-20240320   gcc  
i386         buildonly-randconfig-006-20240320   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240320   clang
i386                  randconfig-001-20240321   clang
i386                  randconfig-002-20240320   clang
i386                  randconfig-003-20240320   clang
i386                  randconfig-004-20240320   clang
i386                  randconfig-004-20240321   clang
i386                  randconfig-005-20240320   clang
i386                  randconfig-005-20240321   clang
i386                  randconfig-006-20240320   gcc  
i386                  randconfig-011-20240320   clang
i386                  randconfig-011-20240321   clang
i386                  randconfig-012-20240320   clang
i386                  randconfig-013-20240320   clang
i386                  randconfig-014-20240320   clang
i386                  randconfig-015-20240320   gcc  
i386                  randconfig-016-20240320   clang
i386                  randconfig-016-20240321   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240321   gcc  
loongarch             randconfig-002-20240321   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240321   gcc  
nios2                 randconfig-002-20240321   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240321   gcc  
parisc                randconfig-002-20240321   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-002-20240321   gcc  
powerpc64             randconfig-003-20240321   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240321   gcc  
sh                    randconfig-002-20240321   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240321   gcc  
sparc64               randconfig-002-20240321   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240321   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240320   gcc  
x86_64       buildonly-randconfig-002-20240320   clang
x86_64       buildonly-randconfig-002-20240321   clang
x86_64       buildonly-randconfig-003-20240320   clang
x86_64       buildonly-randconfig-003-20240321   clang
x86_64       buildonly-randconfig-004-20240320   clang
x86_64       buildonly-randconfig-004-20240321   clang
x86_64       buildonly-randconfig-005-20240320   gcc  
x86_64       buildonly-randconfig-005-20240321   clang
x86_64       buildonly-randconfig-006-20240320   clang
x86_64       buildonly-randconfig-006-20240321   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240320   clang
x86_64                randconfig-002-20240320   clang
x86_64                randconfig-002-20240321   clang
x86_64                randconfig-003-20240320   gcc  
x86_64                randconfig-004-20240320   clang
x86_64                randconfig-005-20240320   clang
x86_64                randconfig-006-20240320   clang
x86_64                randconfig-011-20240320   gcc  
x86_64                randconfig-011-20240321   clang
x86_64                randconfig-012-20240320   gcc  
x86_64                randconfig-013-20240320   gcc  
x86_64                randconfig-013-20240321   clang
x86_64                randconfig-014-20240320   gcc  
x86_64                randconfig-015-20240320   clang
x86_64                randconfig-016-20240320   gcc  
x86_64                randconfig-071-20240320   clang
x86_64                randconfig-071-20240321   clang
x86_64                randconfig-072-20240320   gcc  
x86_64                randconfig-073-20240320   clang
x86_64                randconfig-074-20240320   gcc  
x86_64                randconfig-074-20240321   clang
x86_64                randconfig-075-20240320   gcc  
x86_64                randconfig-075-20240321   clang
x86_64                randconfig-076-20240320   clang
x86_64                randconfig-076-20240321   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240321   gcc  
xtensa                randconfig-002-20240321   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

