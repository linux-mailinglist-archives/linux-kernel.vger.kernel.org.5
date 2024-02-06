Return-Path: <linux-kernel+bounces-54666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7084B238
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13C8288573
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BED12E1E4;
	Tue,  6 Feb 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw9D4G1E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C012E1C5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214441; cv=none; b=MWthegNAm7BnvMSIEU2IyvuErgB0jnrvD/sJwpSHWwhcjB5yS3vOEI3yo4ejTl3nukroXX8gCmoRdnI5mrktlPUUC/JoVeypTb2sOgrik0Me0FiP7Zw2338ATW4saftGv30JSIb9haj6gbXeztvqX68JwdQLaHHP733wucHttdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214441; c=relaxed/simple;
	bh=4zHHtU7mr31Kj0U84+lElQMYzYRNGlsndQ9KPaCwG6U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qHjSDHcZSmLsFHX5Rh0EF0mOZhLAGxWW8bq8gGB9qhQ5cDVxrp9/UV5UcgxUPJfY4uOQwkIkrFjCpGjnNwhrMB5ZCQYbeM2qvtCC0u4bcIcf0yF1FGUki65NKSYRoRcN+YRFbbhcqVh5SjxdOtgJIUOEIf4TfdI6afBjYJAMYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw9D4G1E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707214440; x=1738750440;
  h=date:from:to:cc:subject:message-id;
  bh=4zHHtU7mr31Kj0U84+lElQMYzYRNGlsndQ9KPaCwG6U=;
  b=Iw9D4G1E1/yObfDXpWiaVusXTtmyEykTO+t+s80777ZAMmtJzSyTdFgS
   +f+qcViXjTshSBmPsXIEZQOT+JKgaHhKH1WrEaJZ09TeEoPa6cN4T6Diq
   0YJtEvnxMGVUuyNRoUKWF8r/vOIdt/AdSwE5A4phX2b4cPdTwVOVccjQb
   N7kjj70OER+ZgAhiEqV9j+kSOXCKkuJyzB52Xa0jTj+EOz677Wr8heVA+
   o6i1YTXKLR+XQKY1Ac1JeoHRyAm+j998hrYv3FQzJN1APzpyWu6fyl0O4
   iKmUkux1E5TN/hx+llXwqohfWMDPtwtZVUKON7SJJOiinrpvo913Oba+c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11361660"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11361660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 02:13:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="32045395"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 06 Feb 2024 02:13:58 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXISh-0001G4-2j;
	Tue, 06 Feb 2024 10:13:55 +0000
Date: Tue, 06 Feb 2024 18:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f2cc79d02044bf5759edf5e4196d9cfd66bdb4a1
Message-ID: <202402061811.z6AJETaG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f2cc79d02044bf5759edf5e4196d9cfd66bdb4a1  Merge branch into tip/master: 'x86/sev'

elapsed time: 1459m

configs tested: 178
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240205   gcc  
arc                   randconfig-002-20240205   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   clang
arm                         axm55xx_defconfig   clang
arm                                 defconfig   clang
arm                            mmp2_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                   randconfig-001-20240205   clang
arm                   randconfig-002-20240205   gcc  
arm                   randconfig-003-20240205   clang
arm                   randconfig-004-20240205   clang
arm                             rpc_defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240205   gcc  
arm64                 randconfig-002-20240205   gcc  
arm64                 randconfig-003-20240205   gcc  
arm64                 randconfig-004-20240205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240205   gcc  
csky                  randconfig-002-20240205   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240205   clang
hexagon               randconfig-002-20240205   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240205   clang
i386         buildonly-randconfig-002-20240205   clang
i386         buildonly-randconfig-003-20240205   clang
i386         buildonly-randconfig-004-20240205   clang
i386         buildonly-randconfig-005-20240205   clang
i386         buildonly-randconfig-006-20240205   clang
i386                                defconfig   clang
i386                  randconfig-001-20240205   clang
i386                  randconfig-002-20240205   clang
i386                  randconfig-003-20240205   clang
i386                  randconfig-004-20240205   gcc  
i386                  randconfig-005-20240205   clang
i386                  randconfig-006-20240205   gcc  
i386                  randconfig-011-20240205   gcc  
i386                  randconfig-012-20240205   clang
i386                  randconfig-013-20240205   gcc  
i386                  randconfig-014-20240205   gcc  
i386                  randconfig-015-20240205   clang
i386                  randconfig-016-20240205   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240205   gcc  
loongarch             randconfig-002-20240205   gcc  
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
mips                      loongson3_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240205   gcc  
nios2                 randconfig-002-20240205   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240205   gcc  
parisc                randconfig-002-20240205   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                   microwatt_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240205   clang
powerpc               randconfig-002-20240205   clang
powerpc               randconfig-003-20240205   gcc  
powerpc                     sequoia_defconfig   clang
powerpc64             randconfig-001-20240205   clang
powerpc64             randconfig-002-20240205   clang
powerpc64             randconfig-003-20240205   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240205   clang
riscv                 randconfig-002-20240205   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240205   clang
s390                  randconfig-002-20240205   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20240205   gcc  
sh                    randconfig-002-20240205   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240205   gcc  
sparc64               randconfig-002-20240205   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240205   clang
um                    randconfig-002-20240205   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240205   clang
x86_64       buildonly-randconfig-002-20240205   clang
x86_64       buildonly-randconfig-003-20240205   gcc  
x86_64       buildonly-randconfig-004-20240205   gcc  
x86_64       buildonly-randconfig-005-20240205   gcc  
x86_64       buildonly-randconfig-006-20240205   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240205   gcc  
x86_64                randconfig-002-20240205   gcc  
x86_64                randconfig-003-20240205   clang
x86_64                randconfig-004-20240205   gcc  
x86_64                randconfig-005-20240205   gcc  
x86_64                randconfig-006-20240205   gcc  
x86_64                randconfig-011-20240205   gcc  
x86_64                randconfig-012-20240205   gcc  
x86_64                randconfig-013-20240205   clang
x86_64                randconfig-014-20240205   clang
x86_64                randconfig-015-20240205   gcc  
x86_64                randconfig-016-20240205   clang
x86_64                randconfig-071-20240205   clang
x86_64                randconfig-072-20240205   gcc  
x86_64                randconfig-073-20240205   clang
x86_64                randconfig-074-20240205   clang
x86_64                randconfig-075-20240205   gcc  
x86_64                randconfig-076-20240205   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240205   gcc  
xtensa                randconfig-002-20240205   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

