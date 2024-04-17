Return-Path: <linux-kernel+bounces-147950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9D8A7BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11206281BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69ED524BC;
	Wed, 17 Apr 2024 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTv80NJk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143767470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331047; cv=none; b=gFU35CFm0V6hwEEvQex8klGd3xxgm4K+zuMywYUEQsVwfKqvcdnGMcQyQoMNANyPLpjCnE41+c43gO91naAxJcct5wlXF5FkRo6GA4A4J87sp/dIiVnbrzj9L+RcA5HwbeUUmxvdhnZ0HocCfH6b315dzCtxig5onKH12+OlFFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331047; c=relaxed/simple;
	bh=xYzwvYT9a0huzISywKF6PJjrh0ZehvCe5g3dRT2oItw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=az/HVsfEJ2YZV61SSq6mTfGJq9YkqRbIAzpdSm6KNElCqvnamd0osxnZas9RASV4cDp7378muMQx7oIsCLym5XawcrcjqaXHoxZ9fwVEtINdhqB2/Cw43JkcjI0geWB2wbFhm1LXTvtPUuRZzIRwcB8fkU10EU+Bc6us+dW54bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTv80NJk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713331045; x=1744867045;
  h=date:from:to:cc:subject:message-id;
  bh=xYzwvYT9a0huzISywKF6PJjrh0ZehvCe5g3dRT2oItw=;
  b=RTv80NJkKv83Wp4i6NLjJum/iw/B3G/6l9iWfunyuEdOG8ff3k99MNCo
   mQRUdxfaKGfRCR8CLYdXl8GhvtjNBgoY2iNR4WMoi9aKax+JvF2QkUmJM
   gpdlMaNzmdyhTXb+PJs8FcQRPazeo2N5HMOTvjD7RXZcsDcMGtPmL4V87
   EImJ+YtR0fvWdrnh/KtyMew4S82UPFfI6ZVspajGheBVE56jE+xf2Q4OF
   f9xH9VDIV8ppuWf9r4AeVZ1wStCfGXGaqXcobegxoWjR3ffArl2GM5qxR
   nmTlNty8dHueHuSM2/ifcj7Wj43+3DZcau+l0ivbX1I8shdvoy2uQHU9y
   w==;
X-CSE-ConnectionGUID: 6kBDkEYlRz+rzM9PYF4WiA==
X-CSE-MsgGUID: CaxnCVVUSbilZJHRGSrFuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19951138"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="19951138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 22:17:24 -0700
X-CSE-ConnectionGUID: mwvDMzt8TJSAu5w0dEOM0g==
X-CSE-MsgGUID: kJDw8Sd1RaKoqY0FHjQyXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; 
   d="scan'208";a="22584429"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Apr 2024 22:17:23 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwxfd-00069Z-0W;
	Wed, 17 Apr 2024 05:17:21 +0000
Date: Wed, 17 Apr 2024 13:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 367dc2b68007e8ca00a0d8dc9afb69bff5451ae7
Message-ID: <202404171329.lmOmVDgH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 367dc2b68007e8ca00a0d8dc9afb69bff5451ae7  Merge branch into tip/master: 'sched/urgent'

elapsed time: 996m

configs tested: 83
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
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
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
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
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

