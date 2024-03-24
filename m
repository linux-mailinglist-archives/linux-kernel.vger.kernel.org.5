Return-Path: <linux-kernel+bounces-112728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82F887D84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F591C20A78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72E18EAF;
	Sun, 24 Mar 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggmQ9tI3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECCD18EB8
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296583; cv=none; b=pzpwuWcDyHzs0udFEqsIP5OZpXd5JHNW1UJ9QTR7aWJ6PejKlnt62bTVCVYKhjh+YhUsh0jn0dg5tOmcyS7dnqx8D6r/lkC15ct09r32dU+Y+deV3KvztgyQo+sTc6Lco9Sig3qUCZJatTEQeWBwUANqIs0mhkqnCYoduHweV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296583; c=relaxed/simple;
	bh=rhw/izULxk07ZBoJPyzycT7CsTwF3VltxEXjDgGzpHA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WHkz1V8EoJ64l3Z9v4PoXnE6ugKXs4gF00wcLcbc+aFVrfcX5eDU5yR2TdfikZr/2VYx++OEmeXZ5Ege9XVnQhNLr/QZD2HZ2cx3xo+f81Vz+ppGKOGhKzLnKgPVNdSfxMyJiRouf6SVW66I9ZV9zd48wuDWi+4q93ENlSr1uaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggmQ9tI3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711296581; x=1742832581;
  h=date:from:to:cc:subject:message-id;
  bh=rhw/izULxk07ZBoJPyzycT7CsTwF3VltxEXjDgGzpHA=;
  b=ggmQ9tI3S3D7e8WqNyyUSoSbA1DD2aOSSecjmtcrMN9k07D0P9P/X7Yt
   wi05Szm9G3M/vDK6Am9OubztQghVUKPAHnlgdSVGr1tCxcXPfJ8ybnbJH
   uQRrPnlF/XJ+lXoX/fSvVIe1uNS8vYvsau5zKuQQGl2pP+2t2IuZ8XxO0
   mShoDytihNAbYeBYavoUWUSI/q0TMezrKIdwYxCDdLHkQ1NZlBuN08EPx
   jyLmLoJeG7EW+1utBaLKJeGhQfmNb47+Mk4iUduGQ4e+uzoD1/WNLPpJz
   bJanAKxPORFjbX/q/Q45rMQp5YkRuIq4ZqUISAGpfOY4VAFqkbgEELSrq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17024928"
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="17024928"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 09:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,151,1708416000"; 
   d="scan'208";a="20053056"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Mar 2024 09:09:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1roQPg-000Ltk-1V;
	Sun, 24 Mar 2024 16:09:36 +0000
Date: Mon, 25 Mar 2024 00:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9843231c97267d72be38a0409f5097987bc2cfa4
Message-ID: <202403250000.13pBxH71-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9843231c97267d72be38a0409f5097987bc2cfa4  x86/boot/64: Move 5-level paging global variable assignments back

elapsed time: 720m

configs tested: 185
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
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240324   gcc  
arc                   randconfig-002-20240324   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-001-20240324   clang
arm                   randconfig-002-20240324   gcc  
arm                   randconfig-003-20240324   clang
arm                   randconfig-004-20240324   gcc  
arm                         vf610m4_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240324   gcc  
arm64                 randconfig-002-20240324   gcc  
arm64                 randconfig-003-20240324   gcc  
arm64                 randconfig-004-20240324   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240324   gcc  
csky                  randconfig-002-20240324   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240324   clang
hexagon               randconfig-002-20240324   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240324   gcc  
i386         buildonly-randconfig-002-20240324   clang
i386         buildonly-randconfig-003-20240324   gcc  
i386         buildonly-randconfig-004-20240324   gcc  
i386         buildonly-randconfig-005-20240324   gcc  
i386         buildonly-randconfig-006-20240324   clang
i386                                defconfig   clang
i386                  randconfig-001-20240324   clang
i386                  randconfig-002-20240324   gcc  
i386                  randconfig-003-20240324   gcc  
i386                  randconfig-004-20240324   gcc  
i386                  randconfig-005-20240324   clang
i386                  randconfig-006-20240324   gcc  
i386                  randconfig-011-20240324   clang
i386                  randconfig-012-20240324   clang
i386                  randconfig-013-20240324   clang
i386                  randconfig-014-20240324   clang
i386                  randconfig-015-20240324   clang
i386                  randconfig-016-20240324   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240324   gcc  
loongarch             randconfig-002-20240324   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240324   gcc  
nios2                 randconfig-002-20240324   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240324   gcc  
parisc                randconfig-002-20240324   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20240324   gcc  
powerpc               randconfig-002-20240324   gcc  
powerpc               randconfig-003-20240324   clang
powerpc                     redwood_defconfig   clang
powerpc                     tqm8541_defconfig   clang
powerpc64             randconfig-001-20240324   gcc  
powerpc64             randconfig-002-20240324   gcc  
powerpc64             randconfig-003-20240324   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240324   clang
riscv                 randconfig-002-20240324   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240324   clang
s390                  randconfig-002-20240324   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240324   gcc  
sh                    randconfig-002-20240324   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240324   gcc  
sparc64               randconfig-002-20240324   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240324   gcc  
um                    randconfig-002-20240324   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240324   gcc  
x86_64       buildonly-randconfig-002-20240324   gcc  
x86_64       buildonly-randconfig-003-20240324   clang
x86_64       buildonly-randconfig-004-20240324   clang
x86_64       buildonly-randconfig-005-20240324   gcc  
x86_64       buildonly-randconfig-006-20240324   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240324   clang
x86_64                randconfig-002-20240324   clang
x86_64                randconfig-003-20240324   clang
x86_64                randconfig-004-20240324   clang
x86_64                randconfig-005-20240324   clang
x86_64                randconfig-006-20240324   gcc  
x86_64                randconfig-011-20240324   clang
x86_64                randconfig-012-20240324   gcc  
x86_64                randconfig-013-20240324   gcc  
x86_64                randconfig-014-20240324   gcc  
x86_64                randconfig-015-20240324   gcc  
x86_64                randconfig-016-20240324   clang
x86_64                randconfig-071-20240324   clang
x86_64                randconfig-072-20240324   gcc  
x86_64                randconfig-073-20240324   clang
x86_64                randconfig-074-20240324   clang
x86_64                randconfig-075-20240324   clang
x86_64                randconfig-076-20240324   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240324   gcc  
xtensa                randconfig-002-20240324   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

