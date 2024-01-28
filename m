Return-Path: <linux-kernel+bounces-41593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430683F518
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84ED1F21D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF4D1EB36;
	Sun, 28 Jan 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bzRbNshE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AC48BF2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706440528; cv=none; b=S0z/punttRtSiD5eV8VJR3yqIb4Y314s2MZLugEG0ExbQZt+QAWqEM9D07ULOzVTyRpO8FHQjyHjlR20HQ9hTP8AJXn6XsxP8gknrsE18NJ03pSdQvnu3e9EUz1GuTx4201iASYqxbQj6vQ7zUhqgq0kSV3Tw86dCcDTfVIg8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706440528; c=relaxed/simple;
	bh=biZmWtYTViPNVLzrL6UI/a0pto5hAlDbTSSS38A35is=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XPXGbfcBhuOEn58Z3rlfJwel45VxcwMZaz8dViT+U0VTLvCWAy8WMJUnJfgMizJJGPk4Pw8Cg/YNdYF9wml9p6htveJZOrnPEj/9izAS9Wv7LdSCv1M9XXzG5+JibR3Xhxcsc/Uup6Dfdu59ImuDHteGAQbvYQEcqZeK9JeEyd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bzRbNshE; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706440527; x=1737976527;
  h=date:from:to:cc:subject:message-id;
  bh=biZmWtYTViPNVLzrL6UI/a0pto5hAlDbTSSS38A35is=;
  b=bzRbNshEsj+2F3kBm6RwH3NUPlKSFj4w4AIy+7vDZFwW87qWiztgVf2m
   Y739JKBpXhz9MpJAM2X/Qbp9p/vEXyCbEo84XIAdR4slBn++c9YoyS0sV
   10VY3W3hXDvcftBXbNVDsXL826z1Pc9mzUdGuoqEpPcjlT8NLbMiiWxMp
   y2K/lP+948GH/Wh+QWzICn+InAlmW15yJHPl1MMLYnN3vNrjnh+4e5+L9
   ZHYnOF/SYzVbdy2gPoMI/wDlyW4YwvsCEpSxw/ZX9ftZeMbm15hqnvbnU
   vpIYbpislTQ7w4sL/lf6NoAaxU2dcXpm4GxN+guKS/0IM8wPlXpbAc1hO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="399916984"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="399916984"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 03:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3119350"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Jan 2024 03:15:25 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rU38F-0003L8-0L;
	Sun, 28 Jan 2024 11:15:23 +0000
Date: Sun, 28 Jan 2024 19:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 fa26ddf600d2b1ed0803fc09bb3d07beca1b84c5
Message-ID: <202401281904.8M8KovD6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: fa26ddf600d2b1ed0803fc09bb3d07beca1b84c5  Merge branch into tip/master: 'irq/core'

elapsed time: 2656m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240128   clang
arm                   randconfig-002-20240128   clang
arm                   randconfig-003-20240128   clang
arm                   randconfig-004-20240128   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240128   clang
arm64                 randconfig-002-20240128   clang
arm64                 randconfig-003-20240128   clang
arm64                 randconfig-004-20240128   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240128   clang
hexagon               randconfig-002-20240128   clang
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240128   gcc  
loongarch             randconfig-002-20240128   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240128   gcc  
nios2                 randconfig-002-20240128   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240128   gcc  
parisc                randconfig-002-20240128   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240128   clang
powerpc               randconfig-002-20240128   clang
powerpc               randconfig-003-20240128   clang
powerpc64             randconfig-001-20240128   clang
powerpc64             randconfig-002-20240128   clang
powerpc64             randconfig-003-20240128   clang
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240128   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
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
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

