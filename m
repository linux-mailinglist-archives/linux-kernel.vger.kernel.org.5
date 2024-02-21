Return-Path: <linux-kernel+bounces-74531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2A85D58E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6B01C20F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388D120DC5;
	Wed, 21 Feb 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qw+2i6G2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3835673
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511452; cv=none; b=Rd4fxCfqXT2nrXZ/0Si/4S5Jzq1DPs9Q/DwvbsHzQrZeM4lVsTcXnNOUywZUi1u+UP4gIJ/ijiEDmx/Oyr9W2INxPFUsFxNiaTu+ur2K9n4ESTTO4GOJSB4q5GpDmrk0F7H9+SixbtOGcHUr8g15QNL7ebqLkRYbV/whYCSdAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511452; c=relaxed/simple;
	bh=UAcYQa7rtDkEnuF0LmGGptvGL5HTvQg89AumlPNrO7g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=j1UJKdfxhgMVEbh8g0XnuHAGBa4G6sRJJTHxe9Aw8ZFszur3KIw6MPcPJVnP8j7g/98657Yp3aDmFulp8e3xs7zqeXBLcAHaWJZoGe7QDHGr84fpV1+WlZEJ2ffa0C1PvKn86riOOgIDiLX+SpDsany3yn22UNelxdpTKqjKDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qw+2i6G2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708511450; x=1740047450;
  h=date:from:to:cc:subject:message-id;
  bh=UAcYQa7rtDkEnuF0LmGGptvGL5HTvQg89AumlPNrO7g=;
  b=Qw+2i6G2rZFwdD+rLTNzir392YfBcC0yC9bHYgqf+L3m4ZuwStc712TZ
   mU/mhqkspxOomwnJDMVkKPWiiTQwQ+P0AsA3gVhTARFkTx5rtyVJKMA1F
   ln6TcQEsdBQGh/kEUlD8ze+4OURYUWiLr7Utq9yG96pE4CTYobDQbvl0U
   5g5Np/vEFuJZVwUfzImQ5ibXBuRjRjBdXKjGEbRSl2dW1nSF610n/ArjD
   7lZGNMd/pOYJqiliVPxXim3nOR7og+yat6s8T+gNf3c32tDAF1P8eR//K
   p6YcLhWz10cZnEXcnoqBOBejjfb/X6NsLIeazkcg6zLLOIT2KVhOzJNyl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5618266"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5618266"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 02:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9731671"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 Feb 2024 02:30:49 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcjrY-0005FS-1V;
	Wed, 21 Feb 2024 10:30:18 +0000
Date: Wed, 21 Feb 2024 18:28:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 5aa3c0cf5bba6437c9e63a56f684f61de8b503d6
Message-ID: <202402211801.3N6bwrFk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 5aa3c0cf5bba6437c9e63a56f684f61de8b503d6  genirq/irqdomain: Don't call ops->select for DOMAIN_BUS_ANY tokens

elapsed time: 1075m

configs tested: 111
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
i386         buildonly-randconfig-001-20240221   gcc  
i386         buildonly-randconfig-002-20240221   clang
i386         buildonly-randconfig-003-20240221   gcc  
i386         buildonly-randconfig-004-20240221   gcc  
i386         buildonly-randconfig-005-20240221   gcc  
i386         buildonly-randconfig-006-20240221   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240221   gcc  
i386                  randconfig-002-20240221   clang
i386                  randconfig-003-20240221   clang
i386                  randconfig-004-20240221   gcc  
i386                  randconfig-005-20240221   gcc  
i386                  randconfig-006-20240221   clang
i386                  randconfig-011-20240221   gcc  
i386                  randconfig-012-20240221   clang
i386                  randconfig-013-20240221   gcc  
i386                  randconfig-014-20240221   clang
i386                  randconfig-015-20240221   gcc  
i386                  randconfig-016-20240221   clang
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
x86_64       buildonly-randconfig-001-20240221   clang
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64       buildonly-randconfig-004-20240221   clang
x86_64       buildonly-randconfig-005-20240221   clang
x86_64       buildonly-randconfig-006-20240221   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

