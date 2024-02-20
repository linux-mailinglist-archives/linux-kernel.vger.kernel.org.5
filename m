Return-Path: <linux-kernel+bounces-73470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A949785C303
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84656B2307A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCC77637;
	Tue, 20 Feb 2024 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glEe3nad"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3872156757
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451599; cv=none; b=OrC4HHyyoAYbvZYrn8x491B1n5eqvTPzzKKZsKry8z9vTz/SalXQcNK9TPR5L4OAHPkcGpIBshF50GWgA6A9fwokbpz6vnsTomPHkWw7usPDHv9TncDVgnsfZzUoEwbNAXWsBr5bjSE532wBWNkvMwWBdt4+yKPN6V+0f4JPTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451599; c=relaxed/simple;
	bh=Wy0xa+VzQbqGX/7A0evsUR1h3N2ntZXUWWQToYn0Tpo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ECpAKZgJpJIhNttcVgFOkfm7sdGv+jm2fq2ep5jrDtWLfP+TrXETmm5pV8xvLrhlqtxWvQdsNi31qORsODlxYnXlBNhFxZc25EWd/eMZQZTMAowU7s7lGTaDGXDDL+WWnXjkmt+mbKjKImH751BA1T8Tj7dKaPRDNrUiLiK8vpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glEe3nad; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708451597; x=1739987597;
  h=date:from:to:cc:subject:message-id;
  bh=Wy0xa+VzQbqGX/7A0evsUR1h3N2ntZXUWWQToYn0Tpo=;
  b=glEe3nad3Prz0xs9/zYY7syNZTS3F1pdldlL1dXfSa4ft1AEYss9tDLN
   KGXexAH97fT0suVHcxHGvjNx41Z03R2Xe9RJL8vIkidAk2dc8J3wQuYaB
   LyqBEg3NRJ/xKrxDLCLj1L/5fg8+bI3qfEav0Iy+dVmJvKSrgtIUtQrvp
   nw4N00HEa8Cq68YN/hR2iwsO9WoSnP57HYCOYqwdFhPQkTQg4dS9jh2O1
   HJ12QeBXtWsuqydjzT2NXqDgvbZquiQJwJwYQZ59u4vHwe/Yq9sHigXwo
   KU2zcSRJu0GNABDASXzVNby70Ze47uj0tRpS0fcO44brhzILwF+godq2x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13276515"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13276515"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5207097"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Feb 2024 09:53:15 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcUIq-0004kU-1C;
	Tue, 20 Feb 2024 17:53:12 +0000
Date: Wed, 21 Feb 2024 01:52:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD REGRESSION
 b57b4126dd3bb69db876ae7b271307ab7e0458b9
Message-ID: <202402210139.9TkJTOw3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: b57b4126dd3bb69db876ae7b271307ab7e0458b9  smp: Make __smp_processor_id() 0-argument macro

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402201650.PKfPkpwx-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

kernel/cpu.c:3110:9: error: expected identifier or '(' before '=' token

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- parisc-allmodconfig
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-allnoconfig
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-allyesconfig
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-defconfig
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-randconfig-001-20240220
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-randconfig-002-20240220
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
|-- parisc-randconfig-r064-20240220
|   `-- kernel-cpu.c:error:expected-identifier-or-(-before-token
`-- parisc64-defconfig
    `-- kernel-cpu.c:error:expected-identifier-or-(-before-token

elapsed time: 1463m

configs tested: 163
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240220   gcc  
arc                   randconfig-002-20240220   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-002-20240220   gcc  
arm                   randconfig-003-20240220   gcc  
arm                   randconfig-004-20240220   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240220   gcc  
csky                  randconfig-002-20240220   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240220   clang
i386         buildonly-randconfig-004-20240220   clang
i386                                defconfig   clang
i386                  randconfig-003-20240220   clang
i386                  randconfig-004-20240220   clang
i386                  randconfig-006-20240220   clang
i386                  randconfig-011-20240220   clang
i386                  randconfig-014-20240220   clang
i386                  randconfig-015-20240220   clang
i386                  randconfig-016-20240220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240220   gcc  
loongarch             randconfig-002-20240220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240220   gcc  
nios2                 randconfig-002-20240220   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240220   gcc  
parisc                randconfig-002-20240220   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240220   gcc  
powerpc64             randconfig-001-20240220   gcc  
powerpc64             randconfig-002-20240220   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240220   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240220   gcc  
sh                    randconfig-002-20240220   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240220   gcc  
sparc64               randconfig-002-20240220   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240220   gcc  
um                    randconfig-002-20240220   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240220   clang
x86_64       buildonly-randconfig-002-20240220   clang
x86_64       buildonly-randconfig-004-20240220   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240220   clang
x86_64                randconfig-005-20240220   clang
x86_64                randconfig-012-20240220   clang
x86_64                randconfig-013-20240220   clang
x86_64                randconfig-015-20240220   clang
x86_64                randconfig-071-20240220   clang
x86_64                randconfig-072-20240220   clang
x86_64                randconfig-073-20240220   clang
x86_64                randconfig-074-20240220   clang
x86_64                randconfig-075-20240220   clang
x86_64                randconfig-076-20240220   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240220   gcc  
xtensa                randconfig-002-20240220   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

