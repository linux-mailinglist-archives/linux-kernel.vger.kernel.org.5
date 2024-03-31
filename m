Return-Path: <linux-kernel+bounces-126050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22689316A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056271F23204
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A21442E1;
	Sun, 31 Mar 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUCqE9X+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1C290A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711883068; cv=none; b=ZSf1491j9Qrn38HLnnX78oH+ns5Uw+GTXj8rJRS3LTLksPdZqY3lXGcBME/p9Y/9MUzP9zWrQv8t3SAEozt5k2JP4wZ+//KYP5RO8JOz4JovW3ya1k9f1C9OZWe5BqvoqmaaDu6l+bBdtj81dbwiKvO+BTtW7eQo8OoibK1bN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711883068; c=relaxed/simple;
	bh=07txOQqwbOV+4S93p2Xf4W7Ni8NXdp9uvUc25NcJ0fg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EiZU2Z3WRBV7iLxWyhDZnpiGVDUT5BhFn1A9ZIZj3hYEKFEjkiVWLtgH+IzW0gjIAn3hkfdOVkgOArnjeAy1vdfimJxR7WzT6BIOV7xk+Thw2eeMVLKLz6g8GorK6D855bAjJtVACPW1ZMbor/aOUi7/spX2r3sRH44YGU9Nh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUCqE9X+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711883066; x=1743419066;
  h=date:from:to:cc:subject:message-id;
  bh=07txOQqwbOV+4S93p2Xf4W7Ni8NXdp9uvUc25NcJ0fg=;
  b=PUCqE9X+751GqZQRyAVX28aG/fNDrbYAog3sj+paCLwFztNgrW8zyxH2
   KSqKDvsCS3m2/NutSzadTMZ+WCBHzc98SMAjYDDNnnIs0jQipPktQt6gL
   SmVjnfkSAo1U/evJ7m/Am4G9hO84DOCEBm3bDNeNpXFNROgPikA6EyuP3
   CSQjv6mdv3y3M2ix22kq4aoOu7hxlOczXo1v9+e+l+WoksDnpgggRr3si
   YT7X7pnkQi30MDlYXYPgeojb2KxB+9NZmaqdDNHQPmurvDrE2UuqE5FE/
   E7CyO/VDMQO/c/fXjvv1STqcG3dLZdhHOJkSpLsufLjAPzkEJEkFeDQ1B
   w==;
X-CSE-ConnectionGUID: zn75uKo7T2yuxOeGk8dUYw==
X-CSE-MsgGUID: Bq0fzN4aRsyzJs7M96Mysw==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="18389798"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18389798"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="48639671"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Mar 2024 04:04:24 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqsz8-00013C-0f;
	Sun, 31 Mar 2024 11:04:22 +0000
Date: Sun, 31 Mar 2024 19:04:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 ac5e80e94f5c67d7053f50fc3faddab931707f0f
Message-ID: <202403311906.nvQq14bN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: ac5e80e94f5c67d7053f50fc3faddab931707f0f  x86/mce: Clean up TP_printk() output line of the 'mce_record' tracepoint

elapsed time: 1447m

configs tested: 177
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
arc                   randconfig-001-20240331   gcc  
arc                   randconfig-002-20240331   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                   randconfig-001-20240331   gcc  
arm                   randconfig-002-20240331   gcc  
arm                   randconfig-003-20240331   clang
arm                   randconfig-004-20240331   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240331   gcc  
arm64                 randconfig-002-20240331   gcc  
arm64                 randconfig-003-20240331   gcc  
arm64                 randconfig-004-20240331   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240331   gcc  
csky                  randconfig-002-20240331   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240331   clang
hexagon               randconfig-002-20240331   clang
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20240331   clang
i386         buildonly-randconfig-002-20240331   clang
i386         buildonly-randconfig-003-20240331   clang
i386         buildonly-randconfig-004-20240331   gcc  
i386         buildonly-randconfig-005-20240331   gcc  
i386         buildonly-randconfig-006-20240331   gcc  
i386                  randconfig-001-20240331   gcc  
i386                  randconfig-002-20240331   gcc  
i386                  randconfig-003-20240331   clang
i386                  randconfig-004-20240331   gcc  
i386                  randconfig-005-20240331   gcc  
i386                  randconfig-006-20240331   gcc  
i386                  randconfig-011-20240331   clang
i386                  randconfig-012-20240331   gcc  
i386                  randconfig-013-20240331   gcc  
i386                  randconfig-014-20240331   gcc  
i386                  randconfig-015-20240331   clang
i386                  randconfig-016-20240331   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240331   gcc  
loongarch             randconfig-002-20240331   gcc  
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
mips                     decstation_defconfig   gcc  
mips                          rb532_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240331   gcc  
nios2                 randconfig-002-20240331   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240331   gcc  
parisc                randconfig-002-20240331   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc               randconfig-001-20240331   clang
powerpc               randconfig-002-20240331   gcc  
powerpc               randconfig-003-20240331   clang
powerpc64             randconfig-001-20240331   clang
powerpc64             randconfig-002-20240331   gcc  
powerpc64             randconfig-003-20240331   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240331   gcc  
riscv                 randconfig-002-20240331   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240331   clang
s390                  randconfig-002-20240331   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240331   gcc  
sh                    randconfig-002-20240331   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240331   gcc  
sparc64               randconfig-002-20240331   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240331   clang
um                    randconfig-002-20240331   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64       buildonly-randconfig-001-20240331   gcc  
x86_64       buildonly-randconfig-002-20240331   clang
x86_64       buildonly-randconfig-003-20240331   clang
x86_64       buildonly-randconfig-004-20240331   clang
x86_64       buildonly-randconfig-005-20240331   clang
x86_64       buildonly-randconfig-006-20240331   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240331   gcc  
x86_64                randconfig-002-20240331   gcc  
x86_64                randconfig-003-20240331   gcc  
x86_64                randconfig-004-20240331   clang
x86_64                randconfig-005-20240331   gcc  
x86_64                randconfig-006-20240331   clang
x86_64                randconfig-011-20240331   gcc  
x86_64                randconfig-012-20240331   clang
x86_64                randconfig-013-20240331   gcc  
x86_64                randconfig-014-20240331   gcc  
x86_64                randconfig-015-20240331   gcc  
x86_64                randconfig-016-20240331   gcc  
x86_64                randconfig-071-20240331   gcc  
x86_64                randconfig-072-20240331   gcc  
x86_64                randconfig-073-20240331   gcc  
x86_64                randconfig-074-20240331   clang
x86_64                randconfig-075-20240331   gcc  
x86_64                randconfig-076-20240331   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240331   gcc  
xtensa                randconfig-002-20240331   gcc  
xtensa                         virt_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

