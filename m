Return-Path: <linux-kernel+bounces-112086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38238875A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CC11C22E30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5082D67;
	Fri, 22 Mar 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+wQwGRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A527FBB1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149232; cv=none; b=IeuKIMJC55CD8dlphVUqmIAZhB6FuOeHuHsDlL7AJkEAgon/5OAx1MS0jIhPH+c5Wzx3sTrSfVHWh1BLsZAlRrcrFWGjROgIEuBV2Ab6FxcFO4TYiYKTj5fRGuQ09I59wjeJrAFx4+G2ggyvL8JciWOk60H7jLWtvfFZMZFSOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149232; c=relaxed/simple;
	bh=1uE2zdvbEe+AZwRFPYtL6/o3B5OUz0T2sF7SzAGB37U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aeiGqIDbsoH146p3Kv50n0wwkKnDfEFHyL28dMA7uUkG+zZ66tAEjcLYhVJ9iMXhnsosNjsSfCDOo08rtWmSlgdZ/pmgeCN2MC64dGJrcSloXddI+Q9eYAcDLttHa5XeUOV7P4/i721nTRiyNnoqZipe8jEGo3btnyNYUJHsaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+wQwGRz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711149231; x=1742685231;
  h=date:from:to:cc:subject:message-id;
  bh=1uE2zdvbEe+AZwRFPYtL6/o3B5OUz0T2sF7SzAGB37U=;
  b=a+wQwGRzS7oIcBLoKoV5+guHBBfA+TJ1NHGxCv4HdPTem4QQ+3OxfBLU
   bCQJGCQvU58LRuRVQ8y7kmNJmb46rE7YFHsMnvHbAN2Ohu2jzLC7E0mxw
   c/dVLkoz++pMBfZTuMfNVSblqbIUgJg/YHFvCzOWA09N/VKrKCvXE/2VW
   QfMPeSrQ2V7qBBWCPmsOD7lPKtqxRpD3K491iFnoyHqW4X0+fCtBwyVYe
   XZ5coJn8jC109OBTznrrM3wtchvzocgZlG97vvXGf96om0CebXgQDmlUT
   24bOMjVa+OcZPUnwz6uTROapaPB6Rc4hLEQjTzrHmIhSxzYLs9nmtQqpn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6425893"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6425893"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="19793621"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 Mar 2024 16:13:41 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rno4w-000Kgc-2z;
	Fri, 22 Mar 2024 23:13:38 +0000
Date: Sat, 23 Mar 2024 07:13:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/shstk] BUILD SUCCESS
 2883f01ec37dd8668e7222dfdb5980c86fdfe277
Message-ID: <202403230707.BQRAmgSo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/shstk
branch HEAD: 2883f01ec37dd8668e7222dfdb5980c86fdfe277  x86/shstk: Enable shadow stacks for x32

elapsed time: 733m

configs tested: 114
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240322   gcc  
i386         buildonly-randconfig-001-20240323   gcc  
i386         buildonly-randconfig-002-20240322   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-004-20240323   gcc  
i386         buildonly-randconfig-005-20240322   gcc  
i386         buildonly-randconfig-005-20240323   gcc  
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-003-20240322   gcc  
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240322   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240322   clang
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240322   clang
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240322   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240322   clang
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-014-20240323   gcc  
i386                  randconfig-015-20240322   gcc  
i386                  randconfig-015-20240323   gcc  
i386                  randconfig-016-20240322   clang
i386                  randconfig-016-20240323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   gcc  
riscv                             allnoconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240323   clang
x86_64       buildonly-randconfig-002-20240323   clang
x86_64       buildonly-randconfig-003-20240323   clang
x86_64       buildonly-randconfig-005-20240323   clang
x86_64       buildonly-randconfig-006-20240323   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240323   clang
x86_64                randconfig-003-20240323   clang
x86_64                randconfig-004-20240323   clang
x86_64                randconfig-011-20240323   clang
x86_64                randconfig-013-20240323   clang
x86_64                randconfig-014-20240323   clang
x86_64                randconfig-015-20240323   clang
x86_64                randconfig-016-20240323   clang
x86_64                randconfig-071-20240323   clang
x86_64                randconfig-072-20240323   clang
x86_64                randconfig-073-20240323   clang
x86_64                randconfig-074-20240323   clang
x86_64                randconfig-076-20240323   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

