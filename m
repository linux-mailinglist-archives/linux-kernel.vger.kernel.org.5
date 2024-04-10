Return-Path: <linux-kernel+bounces-139513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931B8A03DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA79DB2165D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8201DFC6;
	Wed, 10 Apr 2024 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThWRElSG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD8138E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790354; cv=none; b=kLyiMBmBt5/weH4L+H2/8ICMMfvO295YkrQJnhNKD9+kGntQhwbDvQet2qMUCmWq7QuUNlyBhsm0NtEsZvgEVbWn1yVct7BlsyXyGQuCCTxaKknkJX/G3YjaOqD//HepJ2BeyGTnnk3Qj+MnwQmdyKeqGh7zTLBtvYl4U6N47bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790354; c=relaxed/simple;
	bh=2bu610YQYpTjByau9vg7/MQ9WKXVxxQoLxE3fc0Zqro=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PJ7ZUf2/5m+PqNKj3NmJE7w90iENKuETeoAyDxz6s5PjSEznXExC2PJEVtYMyIPs1slC9jirXHoj9onas8V75GMdlsODf0wsK1etq24l39T1CnfzrOM/etMlpHWcpckb3fAcNe1IvbiMoHPKfzpG1EeQUC3YLatdBbghY0gVhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThWRElSG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712790353; x=1744326353;
  h=date:from:to:cc:subject:message-id;
  bh=2bu610YQYpTjByau9vg7/MQ9WKXVxxQoLxE3fc0Zqro=;
  b=ThWRElSGgbpIuLGupnpHjGXiWhtvGUrCL2La/ImjcZs39+TrmzFhhl1I
   1DjxfV2TfRHEPQHx29qFPcDLLauHMHR2lsN731vs/cjouWWqbJ+oK6VD8
   Qwe2PxvNWQGMUzP8YMG53SJ1rAoXLr0IJLjQVL1sFTpv5R4rgKihgmUjn
   6Bd0sDr75Dny8JwrM9xEw2oGBzMnSzZfoFn1lIIdnjdk25G57L+yGj1AF
   okibzppwt7+06SdZDpb9+XZtY6RAHmlrCn9rbWxtB4dtL/IlZJ1QMPmvW
   cHVQ+m/rmaA3+mlErCTjTEkyOtH/qyxHIIYYxyguWQAiNeEdTnfCMRStM
   w==;
X-CSE-ConnectionGUID: l3rfpPVqQpCIq4Nvlj48fQ==
X-CSE-MsgGUID: fXWF+CF4TOKyO5WRPluVCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11145080"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="11145080"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:05:52 -0700
X-CSE-ConnectionGUID: dheaDrHhTUid4TR1Czsazw==
X-CSE-MsgGUID: fy3J6MkRREixUEsGjTx6DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="51685511"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Apr 2024 16:05:52 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruh0m-0007vO-2s;
	Wed, 10 Apr 2024 23:05:48 +0000
Date: Thu, 11 Apr 2024 07:05:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 f72ec8989cd1591b1c567b336e0bb4a78536ce39
Message-ID: <202404110718.b64GzeMx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: f72ec8989cd1591b1c567b336e0bb4a78536ce39  Merge branch 'x86/cleanups' into x86/merge, to resolve conflict

elapsed time: 1127m

configs tested: 101
configs skipped: 138

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
arc                     nsimosci_hs_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        keystone_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240410   gcc  
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240410   gcc  
i386                  randconfig-016-20240411   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc                    mvme5100_defconfig   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
riscv                             allnoconfig   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

