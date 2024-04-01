Return-Path: <linux-kernel+bounces-127057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFE89464A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EEC1C21BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501954746;
	Mon,  1 Apr 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSeDIVC1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21B54744
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004651; cv=none; b=b0FrVBFHOmvsdV4F4X1KhQQQGP7bkqucDJuvabtvxwJgzOc9dnm2eS0Wc5DG6aRs9soyMslyVuOyxTPZ3wBZYa42wtEwWJyEI01H8n96hDy9lKOexB81ym5q5EE23ZtbYm8wLKiDvyJRXUjbdCZF7DyMHaXceaDhlqPVxgIPfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004651; c=relaxed/simple;
	bh=F99MiyM02030MSXjpQHwQ5bk4Mp4F+HWwQafwTPcEw0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wy12W93NuQQ+5uSHIDBYjoTz1eKClEY1kTb4nQ0dwjo0CTVQ26K+CnbsZJqb/EYHrgQC2/ojZaX6VLcVO5rkKlHeUWgWkEuQIT/m/sd+SZm9KZfl6z6MChzb3+yE9/I7P6O8iFNMvwXxak0Z1SbiIWeHXOX3OnwyybxdLsZKcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSeDIVC1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712004649; x=1743540649;
  h=date:from:to:cc:subject:message-id;
  bh=F99MiyM02030MSXjpQHwQ5bk4Mp4F+HWwQafwTPcEw0=;
  b=RSeDIVC1ilIMVeI0DLetxqtKOyAPYbUO6VbrJ0vPB1mQh/PCIXOcUjf3
   A3D6OCmjz0MX3ffKM1SWVqH1jHdhXLENpqLZuiSZpfUc19JQly/zfnrFk
   h3CvfeF6CNL6DnmrZByRAdHIrkzX6J4Y+N8dQhszIjLBCH8RH2ehWHl9l
   LBkionxAx4B4b0p4eAmsPd8rMB/D7KVRT1xO/BZ3jA/B6eii8ZXtlRfQx
   stK2c/zRVcaIdGHB9tGGhvlVUs0j90qTDIODW0Z8R9G/EWdaszyXY+uTb
   SVorqFeNehODtE7b6tT8SIh27N9+k3NB690fH7xxA38RsnLHjouZp5Ocb
   A==;
X-CSE-ConnectionGUID: +RxPT6uXTFuxYoE7glclCw==
X-CSE-MsgGUID: B3D36bMgRX2aGFhm68mVuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18597507"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18597507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="40983914"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Apr 2024 13:50:46 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrOc8-0000c1-1N;
	Mon, 01 Apr 2024 20:50:44 +0000
Date: Tue, 02 Apr 2024 04:49:57 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 65d1240b6728b38e4d2068d6738a17e4ee4351f5
Message-ID: <202404020455.G3jJlnGw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 65d1240b6728b38e4d2068d6738a17e4ee4351f5  Merge branch into tip/master: 'x86/shstk'

elapsed time: 723m

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
arc                   randconfig-001-20240401   gcc  
arc                   randconfig-002-20240401   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                             mxs_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240401   clang
arm                   randconfig-002-20240401   clang
arm                   randconfig-003-20240401   gcc  
arm                   randconfig-004-20240401   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240401   gcc  
arm64                 randconfig-002-20240401   gcc  
arm64                 randconfig-003-20240401   gcc  
arm64                 randconfig-004-20240401   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240401   gcc  
csky                  randconfig-002-20240401   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240401   clang
hexagon               randconfig-002-20240401   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240401   gcc  
i386         buildonly-randconfig-002-20240401   clang
i386         buildonly-randconfig-003-20240401   clang
i386         buildonly-randconfig-004-20240401   gcc  
i386         buildonly-randconfig-005-20240401   gcc  
i386         buildonly-randconfig-006-20240401   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240401   gcc  
i386                  randconfig-002-20240401   gcc  
i386                  randconfig-003-20240401   clang
i386                  randconfig-004-20240401   clang
i386                  randconfig-005-20240401   gcc  
i386                  randconfig-006-20240401   gcc  
i386                  randconfig-011-20240401   clang
i386                  randconfig-012-20240401   clang
i386                  randconfig-013-20240401   gcc  
i386                  randconfig-014-20240401   gcc  
i386                  randconfig-015-20240401   gcc  
i386                  randconfig-016-20240401   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240401   gcc  
loongarch             randconfig-002-20240401   gcc  
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
mips                        bcm47xx_defconfig   clang
mips                     cu1000-neo_defconfig   gcc  
mips                           jazz_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240401   gcc  
nios2                 randconfig-002-20240401   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240401   gcc  
parisc                randconfig-002-20240401   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                      obs600_defconfig   clang
powerpc               randconfig-001-20240401   gcc  
powerpc               randconfig-002-20240401   gcc  
powerpc               randconfig-003-20240401   gcc  
powerpc64                        alldefconfig   clang
powerpc64             randconfig-001-20240401   gcc  
powerpc64             randconfig-002-20240401   clang
powerpc64             randconfig-003-20240401   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240401   clang
riscv                 randconfig-002-20240401   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240401   gcc  
s390                  randconfig-002-20240401   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                    randconfig-001-20240401   gcc  
sh                    randconfig-002-20240401   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240401   gcc  
sparc64               randconfig-002-20240401   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240401   gcc  
um                    randconfig-002-20240401   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240401   clang
x86_64       buildonly-randconfig-002-20240401   clang
x86_64       buildonly-randconfig-003-20240401   gcc  
x86_64       buildonly-randconfig-004-20240401   gcc  
x86_64       buildonly-randconfig-005-20240401   gcc  
x86_64       buildonly-randconfig-006-20240401   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240401   gcc  
x86_64                randconfig-002-20240401   clang
x86_64                randconfig-003-20240401   clang
x86_64                randconfig-004-20240401   gcc  
x86_64                randconfig-005-20240401   gcc  
x86_64                randconfig-006-20240401   clang
x86_64                randconfig-011-20240401   clang
x86_64                randconfig-012-20240401   gcc  
x86_64                randconfig-013-20240401   gcc  
x86_64                randconfig-014-20240401   gcc  
x86_64                randconfig-015-20240401   gcc  
x86_64                randconfig-016-20240401   gcc  
x86_64                randconfig-071-20240401   gcc  
x86_64                randconfig-072-20240401   gcc  
x86_64                randconfig-073-20240401   clang
x86_64                randconfig-074-20240401   gcc  
x86_64                randconfig-075-20240401   gcc  
x86_64                randconfig-076-20240401   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240401   gcc  
xtensa                randconfig-002-20240401   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

