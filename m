Return-Path: <linux-kernel+bounces-105556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB587E023
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F31C20F76
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19605208A3;
	Sun, 17 Mar 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiywsojv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817B1F61C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709242; cv=none; b=dosQVjuLTop2JGfM4K23r/C5rk8e4W6MBB7GV4oG9GLuoPu0XEpnkvWVGPQsZL6G/F8S0uuYjaGlAJKIP/vnXx02SC2FXr2hQpoW9kWC7HDYkHi/Vc751C4OBMcmkw9xNISILKxm0g64gu+Xt4VZcYRfO+7xusHx7MtmnuNv96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709242; c=relaxed/simple;
	bh=dfy5U7w0fD5RevOyoSb1zyZM9hlxawAxs24sk/IPgRE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eKRGRX7jTgNWLm9GFc/5dmcVmFtW5sMXXHDNAKNn5i5TPcuZT/L8nDKJk6dkAgcBwndgCWqjauDPKTnzsCaQILky6cdQk1o9S3pzZgDRgdECnVOIi80SQ8NNUqhzYlLmI30E1mq8wE6eTX7Uu4weMoD9k38ztddgTp4yQiBvksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiywsojv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710709240; x=1742245240;
  h=date:from:to:cc:subject:message-id;
  bh=dfy5U7w0fD5RevOyoSb1zyZM9hlxawAxs24sk/IPgRE=;
  b=fiywsojv5YfasGZIL518EYL5RaDgD+Nd9s/uTh5XJiDtIT0GzZdg9ajm
   F8UWHVS5LizjStrUP9S3NRFP7Xbs1IB5klZmfpNOkAevJvnPXEVBffTtq
   5qmZflcp8lDmEfSDLJ3hFI98l3KceVMKRrUAxsLCQ5btAgClEjtdh49UX
   GrhMrMXk9bEKJfv0CNYOlsisGxYCSkQ9/SPWKOxiX5ZALCR8YVDa4JqFx
   ZOpGg8vYf+mCRfG3SAE6mIF7FQNCD4fGXlld++vKM4g1eNCoSdjdGagtn
   Lhv6T0v4E4UYFUag37izqFks2ixylJGWTCC+WDlXjpnyxpiWSyNUQaX9e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="6116397"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="6116397"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 14:00:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13906015"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Mar 2024 14:00:36 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlxcP-000GT9-2q;
	Sun, 17 Mar 2024 21:00:33 +0000
Date: Mon, 18 Mar 2024 05:00:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7e19a79344df2ed5e106091c29338962261b0290
Message-ID: <202403180512.vcCJpDpg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7e19a79344df2ed5e106091c29338962261b0290  Merge branch into tip/master: 'x86/build'

elapsed time: 726m

configs tested: 180
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
arc                   randconfig-001-20240317   gcc  
arc                   randconfig-002-20240317   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   clang
arm                          collie_defconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240317   clang
arm                   randconfig-002-20240317   clang
arm                   randconfig-003-20240317   gcc  
arm                   randconfig-004-20240317   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240317   clang
arm64                 randconfig-002-20240317   gcc  
arm64                 randconfig-003-20240317   gcc  
arm64                 randconfig-004-20240317   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240317   gcc  
csky                  randconfig-002-20240317   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240317   clang
hexagon               randconfig-002-20240317   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240317   gcc  
i386         buildonly-randconfig-002-20240317   clang
i386         buildonly-randconfig-003-20240317   gcc  
i386         buildonly-randconfig-004-20240317   clang
i386         buildonly-randconfig-005-20240317   clang
i386         buildonly-randconfig-006-20240317   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240317   clang
i386                  randconfig-002-20240317   clang
i386                  randconfig-003-20240317   clang
i386                  randconfig-004-20240317   clang
i386                  randconfig-005-20240317   gcc  
i386                  randconfig-006-20240317   gcc  
i386                  randconfig-011-20240317   clang
i386                  randconfig-012-20240317   clang
i386                  randconfig-013-20240317   clang
i386                  randconfig-014-20240317   gcc  
i386                  randconfig-015-20240317   gcc  
i386                  randconfig-016-20240317   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240317   gcc  
loongarch             randconfig-002-20240317   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                            q40_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   clang
mips                     loongson1c_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240317   gcc  
nios2                 randconfig-002-20240317   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240317   gcc  
parisc                randconfig-002-20240317   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240317   clang
powerpc               randconfig-002-20240317   gcc  
powerpc               randconfig-003-20240317   clang
powerpc                     tqm5200_defconfig   gcc  
powerpc                     tqm8560_defconfig   gcc  
powerpc64             randconfig-001-20240317   gcc  
powerpc64             randconfig-002-20240317   clang
powerpc64             randconfig-003-20240317   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240317   clang
riscv                 randconfig-002-20240317   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240317   clang
s390                  randconfig-002-20240317   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240317   gcc  
sh                    randconfig-002-20240317   gcc  
sh                           se7724_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240317   gcc  
sparc64               randconfig-002-20240317   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240317   gcc  
um                    randconfig-002-20240317   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240317   gcc  
x86_64       buildonly-randconfig-002-20240317   gcc  
x86_64       buildonly-randconfig-003-20240317   gcc  
x86_64       buildonly-randconfig-004-20240317   clang
x86_64       buildonly-randconfig-005-20240317   gcc  
x86_64       buildonly-randconfig-006-20240317   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240317   gcc  
x86_64                randconfig-002-20240317   gcc  
x86_64                randconfig-003-20240317   gcc  
x86_64                randconfig-004-20240317   gcc  
x86_64                randconfig-005-20240317   gcc  
x86_64                randconfig-006-20240317   clang
x86_64                randconfig-011-20240317   clang
x86_64                randconfig-012-20240317   gcc  
x86_64                randconfig-013-20240317   clang
x86_64                randconfig-014-20240317   clang
x86_64                randconfig-015-20240317   gcc  
x86_64                randconfig-016-20240317   clang
x86_64                randconfig-071-20240317   gcc  
x86_64                randconfig-072-20240317   clang
x86_64                randconfig-073-20240317   clang
x86_64                randconfig-074-20240317   gcc  
x86_64                randconfig-075-20240317   gcc  
x86_64                randconfig-076-20240317   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240317   gcc  
xtensa                randconfig-002-20240317   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

