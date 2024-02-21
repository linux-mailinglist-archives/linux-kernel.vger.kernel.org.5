Return-Path: <linux-kernel+bounces-74040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE385CF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409501C22CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2538DCC;
	Wed, 21 Feb 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSoSp0Tk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444939867
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487661; cv=none; b=Z9OxZo35sbDK5bzaRx1gG7goqFlkaMy8hL0JYbm3QOYESIXuGhOGIKOk+VIDJlZCcnQgJJ7bZXe+/b1bfunVveKk/BasW4tHPxjadAev8BJtRzV9BqUW2jyhrVazT07RZDXfPkNmLSKrIsU1ZRVKii+0jPJuVZpsz5WWoJKQAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487661; c=relaxed/simple;
	bh=TFAvA1/yz76l+ryudayP2LNvIDPNPKxdKoM54HtDt/Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D4mZ0PRX0uig1JfSuyyy/PWFnYpa1ZV567xYiHrFQHFE0vmIiMAophY/dldvvnNGClWtM2nUguNLtiPCUbyZi8LcVBgmZ6lSGHkw4GeSoSM9ZZh6GBg5yHVXBgjdyq5IHfcRZwUUA/tTvmhYAOgWwTx4zu/Oq1sC3DvAKjAW8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSoSp0Tk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708487659; x=1740023659;
  h=date:from:to:cc:subject:message-id;
  bh=TFAvA1/yz76l+ryudayP2LNvIDPNPKxdKoM54HtDt/Q=;
  b=OSoSp0TkSurdJ19QrezQuzX8lHVwtSBcJl5uAm3tLpZ4D7Ct+CQSZOuq
   pap3X/lG5js8j630OX+rC0lvxAPUpXjjhoVEbtnfRiy3vj1ZOFsrr8nTb
   X6P4XT/CNCF8FplWTrq3O2izyUc3pnyMUtOepPDHLlK5WYkz7GDCBdHib
   3Otp89ejt8beySVXieXnPpK7inFQ8N2Yjz1TOTSA7nJwUdfb2dQhe1qOr
   qWsTiDjq8EC3hPaK2AD2bOtd7JoqFDu57L07bMPppSZcC1EHNJx3smk03
   gBuW5/h8VuVjYEsUOw7WZq6UpkLnCz70XxttdaKsAMO16sxGq9qpf5Hin
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6446168"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="6446168"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5311392"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 19:54:19 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcdg6-0004zK-22;
	Wed, 21 Feb 2024 03:54:00 +0000
Date: Wed, 21 Feb 2024 11:50:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mtrr] BUILD SUCCESS
 ffc92cf3db62443c626469ef160f9276f296f6c6
Message-ID: <202402211153.Ei0vXAGU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mtrr
branch HEAD: ffc92cf3db62443c626469ef160f9276f296f6c6  x86/pat: Simplify the PAT programming protocol

elapsed time: 829m

configs tested: 108
configs skipped: 135

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
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-002-20240221   clang
i386                                defconfig   clang
i386                  randconfig-002-20240221   clang
i386                  randconfig-003-20240221   clang
i386                  randconfig-006-20240221   clang
i386                  randconfig-012-20240221   clang
i386                  randconfig-014-20240221   clang
i386                  randconfig-016-20240221   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       alldefconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                randconfig-005-20240221   gcc  
x86_64                randconfig-006-20240221   gcc  
x86_64                randconfig-012-20240221   gcc  
x86_64                randconfig-014-20240221   gcc  
x86_64                randconfig-015-20240221   gcc  
x86_64                randconfig-016-20240221   gcc  
x86_64                randconfig-071-20240221   gcc  
x86_64                randconfig-072-20240221   gcc  
x86_64                randconfig-073-20240221   gcc  
x86_64                randconfig-074-20240221   gcc  
x86_64                randconfig-076-20240221   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

