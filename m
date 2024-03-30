Return-Path: <linux-kernel+bounces-125649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D3892A15
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CA3B226AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56DF125BF;
	Sat, 30 Mar 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njYLFCP7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B464F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791930; cv=none; b=J/ZDBKxSgdKRJHZnkyPHGg0VsFfgVQHzNs4NJYc7Afm/cQoJjGcNZZHeKi4xSMexo0O6lFGYQpmkmprkSZc0G3c3ajr3Mr6rXF8YzhqtUbqrSuiP4QN1P7n9cr5Bmhu1Zz42AX37pLtvLzFvLUXG2YnWgUBxkTe7EAgZA3q/YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791930; c=relaxed/simple;
	bh=y3HgmTtMzb77xWdNMKTc/Uv8mXbFBxZV9qZKWMHhcg8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dcFMYxmvxLu5cL6Xmj6YQn4KhTfbriXVGqMyCkd8x+7GCmS0wmBw38PaywrICvVA4tQnHGC1llMX5v+02HnHlrENK+JvCQAODYlLyuwVkHfApoi9EvNxpPHl5JvC32Vaa5JYTZtwKVdvoBZwYQ+rHnUq0PRyW+R9aHREilGRK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njYLFCP7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711791928; x=1743327928;
  h=date:from:to:cc:subject:message-id;
  bh=y3HgmTtMzb77xWdNMKTc/Uv8mXbFBxZV9qZKWMHhcg8=;
  b=njYLFCP7uA8c4smsj0mnpqrV/eRVI0o8AlcJV+/Zc5/xKnwceRXzZq7t
   ksP2njyMTnPDtMVfw2FtAp6GpjnSSe9yilbbPPpv401K+51sfpy24xQ+K
   eE+PleNMo9fW5Pugi6d2jR/uAkFBKTPAuJKo0me4ccGAt+sb3hYfyv6zS
   Hg60fd2eKf59Qi/XValcKKFDzMRZkRjo3NgpDJ5aVdg2MLRMdhJSaQuQ1
   EIm51DStilp4lwnSq9w/NnTAQpd80WzxzkVOD+1vrFh7BcAuFQu2eKoky
   nMJROr2OI4E/6ITmdILyJF0UJz2UcLlAVbLFZ1ft8q6OsPvN4ho4yGH5m
   A==;
X-CSE-ConnectionGUID: /E4x4Z31QjeZM5oBKPFF8g==
X-CSE-MsgGUID: l+CJ20S+RwCDwE30gCF3Jg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7158960"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="7158960"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 02:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="21864343"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Mar 2024 02:45:27 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqVHA-000484-0f;
	Sat, 30 Mar 2024 09:45:24 +0000
Date: Sat, 30 Mar 2024 17:44:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 10756f13250261e4c88173a48cb26b7795e12be4
Message-ID: <202403301743.VJ9a8RvO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 10756f13250261e4c88173a48cb26b7795e12be4  Merge branch into tip/master: 'x86/shstk'

elapsed time: 1206m

configs tested: 125
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
arc                   randconfig-001-20240330   gcc  
arc                   randconfig-002-20240330   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240330   clang
arm                   randconfig-002-20240330   clang
arm                   randconfig-003-20240330   gcc  
arm                   randconfig-004-20240330   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240330   clang
arm64                 randconfig-002-20240330   clang
arm64                 randconfig-003-20240330   clang
arm64                 randconfig-004-20240330   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240330   gcc  
csky                  randconfig-002-20240330   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240330   clang
hexagon               randconfig-002-20240330   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240330   clang
i386         buildonly-randconfig-002-20240330   clang
i386         buildonly-randconfig-003-20240330   clang
i386         buildonly-randconfig-004-20240330   clang
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240330   gcc  
loongarch             randconfig-002-20240330   gcc  
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
nios2                 randconfig-001-20240330   gcc  
nios2                 randconfig-002-20240330   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240330   gcc  
parisc                randconfig-002-20240330   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240330   gcc  
powerpc               randconfig-002-20240330   clang
powerpc               randconfig-003-20240330   clang
powerpc64             randconfig-001-20240330   gcc  
powerpc64             randconfig-002-20240330   gcc  
powerpc64             randconfig-003-20240330   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240330   gcc  
riscv                 randconfig-002-20240330   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240330   clang
s390                  randconfig-002-20240330   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240330   gcc  
sh                    randconfig-002-20240330   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240330   gcc  
sparc64               randconfig-002-20240330   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240330   clang
um                    randconfig-002-20240330   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240330   gcc  
xtensa                randconfig-002-20240330   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

