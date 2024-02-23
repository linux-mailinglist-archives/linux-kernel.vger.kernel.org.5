Return-Path: <linux-kernel+bounces-78182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FD860FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36AD1C23447
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1867C72;
	Fri, 23 Feb 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMKU1D4j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A3651BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685775; cv=none; b=EgpUe2bULZetWn8jg4mjjqL5OskB8LLYCKTBr555n+FcU8iLHLsluBiM3W8wH/49z+bj5eSw/tzNFbmvik08oB6uidkmgpjW5ZsQ3BnJRAvak4PgSo82LxMThozyF2yqtuFEP0Ym2n1YVqb0czosFKS/E3gJDHGUFqKJaartkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685775; c=relaxed/simple;
	bh=ASBnEtuxM7v8cWe5erp7heOATXHcSpQbtw0uFrPM9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VFj9WJce9IoiSJ2/i/YqRTYPkhvtlVoi/ZvPqwih3zlLA87hS81GJLZxn8tUPw8zf8ec8F3aWlQDx/gEzIThxkdtVRVd9JPNsNwKGXOZk0uCfb31yk+w0E1SVhBKh/RnjsnpUt0wiKvq9aPx2Xr41tj2NA4WYGYHTVI6jZMKkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMKU1D4j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708685774; x=1740221774;
  h=date:from:to:cc:subject:message-id;
  bh=ASBnEtuxM7v8cWe5erp7heOATXHcSpQbtw0uFrPM9Pw=;
  b=DMKU1D4jhWwe+emAe8EJ5XKsdt9FogQ4LiTQYEAlc3g3RX5jj1GQ6g78
   bl2MO+i4IS4Z0HYobvrt+CzqLOSycW3TkebkvJ+FX+p1L58kpv+Jwbzms
   hteR1Ko5h+ifGcSU6NVO+28jLphrCe21UhgnUl/mkd3AQamlQzQG7c++k
   F2As34ca/PqSIcvuihAz3HpKpQ0Csc+2BXx3LXoTTlCGjmgnjMaDlHRaM
   gp3Sq6beqOJC8IXK2aYO2A4R+gUbP9Mjp132na0ZXgRJQPkzTvCyR3lk2
   ma96/hvZ91GBajUMGjWuuitZr3ty6wQFzezrv4zGocbVAuu4yJASu8UJF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13558203"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13558203"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6350281"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 23 Feb 2024 02:56:12 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdTDt-0007R9-1J;
	Fri, 23 Feb 2024 10:56:09 +0000
Date: Fri, 23 Feb 2024 18:55:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 95f0b570750f6ca025cb9f09499cfe3dfb03891b
Message-ID: <202402231855.Asvv1rh4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: 95f0b570750f6ca025cb9f09499cfe3dfb03891b  Merge branch 'x86/build' into x86/merge, to resolve conflict and to ease integration testing

elapsed time: 1472m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240223   gcc  
arc                   randconfig-002-20240223   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240223   gcc  
arm                   randconfig-002-20240223   clang
arm                   randconfig-003-20240223   clang
arm                   randconfig-004-20240223   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240223   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240223   gcc  
i386         buildonly-randconfig-002-20240223   gcc  
i386         buildonly-randconfig-003-20240223   gcc  
i386         buildonly-randconfig-004-20240223   gcc  
i386         buildonly-randconfig-005-20240223   gcc  
i386         buildonly-randconfig-006-20240223   clang
i386                                defconfig   clang
i386                  randconfig-001-20240223   clang
i386                  randconfig-002-20240223   gcc  
i386                  randconfig-003-20240223   gcc  
i386                  randconfig-004-20240223   gcc  
i386                  randconfig-005-20240223   gcc  
i386                  randconfig-006-20240223   clang
i386                  randconfig-011-20240223   gcc  
i386                  randconfig-012-20240223   gcc  
i386                  randconfig-013-20240223   clang
i386                  randconfig-014-20240223   clang
i386                  randconfig-015-20240223   clang
i386                  randconfig-016-20240223   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240223   gcc  
x86_64       buildonly-randconfig-002-20240223   gcc  
x86_64       buildonly-randconfig-003-20240223   clang
x86_64       buildonly-randconfig-004-20240223   clang
x86_64       buildonly-randconfig-005-20240223   gcc  
x86_64       buildonly-randconfig-006-20240223   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240223   gcc  
x86_64                randconfig-002-20240223   clang
x86_64                randconfig-003-20240223   gcc  
x86_64                randconfig-004-20240223   gcc  
x86_64                randconfig-005-20240223   clang
x86_64                randconfig-006-20240223   gcc  
x86_64                randconfig-011-20240223   gcc  
x86_64                randconfig-012-20240223   gcc  
x86_64                randconfig-013-20240223   clang
x86_64                randconfig-014-20240223   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

