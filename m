Return-Path: <linux-kernel+bounces-105123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548587D961
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ACA1C20A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9F107A9;
	Sat, 16 Mar 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5W7Kdvl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A479D3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580004; cv=none; b=DL9lOlzvpd/YssalZ8YwEpnTzVITNFYmgvDND8gyUTch0xtV3U83JjyBh8HE2Eg+WIp2x+lvIlU5oZMXh/b+FbLBLEvLmU83BxF+Aq4TblMiUxtgp9IgdG0bGH9N7vJJdyo8pYM/jNFaP3+Nfz7frsLZRywmLAdnpYL3G9i8X9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580004; c=relaxed/simple;
	bh=vpuPBJj2Lr7A5NW/U+auYxk3wAzvy/Erx6vEt8eKn8A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=r50qjpS2Wv1ih0ydp7HMfgQow/2NcBDOasohBjJCMdj2h24zxXxuQjQBm9bFvvbOqQge11U8X/QbBpp8nZ9U7USiN1QnLFS/nnElsk19y7GVbGQiJOSBhBIVOmCGMMj9DzcnGocy0mLGptD4n3lgSwoWOnzkGn4hrdkyx0KHHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5W7Kdvl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710580003; x=1742116003;
  h=date:from:to:cc:subject:message-id;
  bh=vpuPBJj2Lr7A5NW/U+auYxk3wAzvy/Erx6vEt8eKn8A=;
  b=M5W7KdvlZWymD60rT0NpuSmPKO2k251Jowq0EaTHOnbUJKFG2BxfCcSi
   JvRB9ePoz2yWCPe8lydH3jBVn3SQQvv5K37suNP2XIM+dWNWyv9y2YnQo
   ltcD/Y3dPeIll10r2ThcYPLoEN/g/GkCTI6rz2TrV1dq5x2PoPjZaYaar
   9S3AfLsZ1Zow0K5QxgVjq5SR2OQ6bLt+yduPFR8gJxI2xJEaPqO47PI5i
   H617pZGJpAOBMBM6Qxi7hsviDJ2ffOR9p2RKip6k7O+IG4AsV9bWbl0te
   nBfzXXb1YqyC6aoYhhuf9Icqug/F0mdENFwFm9XnxkqMr1/FzmcI+CReG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5311153"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5311153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 02:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12999155"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Mar 2024 02:06:41 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlPzy-000FGF-2f;
	Sat, 16 Mar 2024 09:06:38 +0000
Date: Sat, 16 Mar 2024 17:06:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ca5b0b717b75d0f86f7f5dfe18369781bec742ad
Message-ID: <202403161723.XAZlvxpT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ca5b0b717b75d0f86f7f5dfe18369781bec742ad  irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32

elapsed time: 851m

configs tested: 161
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
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240316   gcc  
arc                   randconfig-002-20240316   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-001-20240316   gcc  
arm                   randconfig-002-20240316   gcc  
arm                   randconfig-003-20240316   gcc  
arm                   randconfig-004-20240316   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240316   gcc  
arm64                 randconfig-002-20240316   clang
arm64                 randconfig-003-20240316   clang
arm64                 randconfig-004-20240316   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240316   gcc  
csky                  randconfig-002-20240316   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240316   clang
hexagon               randconfig-002-20240316   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240316   clang
i386         buildonly-randconfig-002-20240316   gcc  
i386         buildonly-randconfig-003-20240316   gcc  
i386         buildonly-randconfig-004-20240316   gcc  
i386         buildonly-randconfig-005-20240316   gcc  
i386         buildonly-randconfig-006-20240316   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240316   gcc  
i386                  randconfig-002-20240316   gcc  
i386                  randconfig-003-20240316   gcc  
i386                  randconfig-004-20240316   gcc  
i386                  randconfig-005-20240316   clang
i386                  randconfig-006-20240316   gcc  
i386                  randconfig-011-20240316   clang
i386                  randconfig-012-20240316   clang
i386                  randconfig-013-20240316   clang
i386                  randconfig-014-20240316   clang
i386                  randconfig-015-20240316   clang
i386                  randconfig-016-20240316   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240316   gcc  
loongarch             randconfig-002-20240316   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240316   gcc  
nios2                 randconfig-002-20240316   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240316   gcc  
parisc                randconfig-002-20240316   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-001-20240316   clang
powerpc               randconfig-002-20240316   clang
powerpc               randconfig-003-20240316   gcc  
powerpc64             randconfig-001-20240316   gcc  
powerpc64             randconfig-002-20240316   gcc  
powerpc64             randconfig-003-20240316   clang
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240316   gcc  
riscv                 randconfig-002-20240316   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240316   clang
s390                  randconfig-002-20240316   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                    randconfig-001-20240316   gcc  
sh                    randconfig-002-20240316   gcc  
sh                           se7721_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240316   gcc  
sparc64               randconfig-002-20240316   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240316   clang
um                    randconfig-002-20240316   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240316   clang
x86_64       buildonly-randconfig-006-20240316   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240316   clang
x86_64                randconfig-003-20240316   clang
x86_64                randconfig-004-20240316   clang
x86_64                randconfig-005-20240316   clang
x86_64                randconfig-011-20240316   clang
x86_64                randconfig-014-20240316   clang
x86_64                randconfig-071-20240316   clang
x86_64                randconfig-075-20240316   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240316   gcc  
xtensa                randconfig-002-20240316   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

