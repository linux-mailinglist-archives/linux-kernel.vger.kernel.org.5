Return-Path: <linux-kernel+bounces-124018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA2B89113F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C461C22325
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C413D62A;
	Fri, 29 Mar 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kk3VhLTB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE213BAD2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677334; cv=none; b=O7cIFRPTjjPqipzIG68lSGim7TVdCZScLPcCBBpLSssCsHieo4YHqR5HBuYUFx9wPsrOwySMAJm0f672em5pAue4gudai9czEFJF/094oXioiU+n2X2l1TkG8PZZfgm816mVvL6oawXMZk6d3yn35ard0mIZCK45m2dI4r2VVdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677334; c=relaxed/simple;
	bh=vA8wfvOhVLWtmzAPM8oCJqLJmA5rK/MNsa7fCxGOMEs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NpBZEiSISQ8YcIOZpdw3qehX72R5RqOsTWzfdQQkC8DfiPIa/oostNRUdzHgqZlDACgMmAwPrJt8MZS+g1NGALPS7wH+Ck4DEUKf12YAKIyaWF9FhKmMH7c4elQ1ql6+9esd8mMFNZOvCNPbm3dUpegDFo/YrvAF6reSrKc13uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kk3VhLTB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711677332; x=1743213332;
  h=date:from:to:cc:subject:message-id;
  bh=vA8wfvOhVLWtmzAPM8oCJqLJmA5rK/MNsa7fCxGOMEs=;
  b=Kk3VhLTBScf72csBnVYwxW9zTf9dRmRLXvQF7RfvPJZWKRn29xXyRFYR
   5a3IYzyq4svIqcdit/k9SE5ZRhzafzkpdh4IvH2k3H0u/gIym4NbmQZ+Z
   qNLCD52v+8BPrs5hkOZXhp6u/d5Aey6H8eylJ/uJkRUGq7xRfm1tlvDTm
   LkeCS1B0EEWwvnTW9AQqj/FePoFm27FssU0m88qyLm8uraSa20wZAbENZ
   b9LNogDiUK+O2qgDecc5r0FYY6RF7fxF8Um/KWLa0KWA5wl6XDe3h/O/I
   UOOMidkX6Gzs+g0T4Mi9ygBVAWJbuJDrH0XaISY/+5SWrwD27xeF4LYE2
   A==;
X-CSE-ConnectionGUID: QjOQdzy3SvGFOrMyrHkAqg==
X-CSE-MsgGUID: Ro/r1zSnQfuTky9SzZEsPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9820254"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="9820254"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16718213"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Mar 2024 18:55:30 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rq1Sq-0002jf-1q;
	Fri, 29 Mar 2024 01:55:28 +0000
Date: Fri, 29 Mar 2024 09:54:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9699768066a9b12db247d5ee9276cf298b67528d
Message-ID: <202403290928.P2bRSaVf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 9699768066a9b12db247d5ee9276cf298b67528d  Merge branch into tip/master: 'x86/shstk'

elapsed time: 829m

configs tested: 96
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
arc                   randconfig-001-20240329   gcc  
arc                   randconfig-002-20240329   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240329   gcc  
arm                   randconfig-002-20240329   clang
arm                   randconfig-003-20240329   clang
arm                   randconfig-004-20240329   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240329   gcc  
arm64                 randconfig-002-20240329   clang
arm64                 randconfig-003-20240329   clang
arm64                 randconfig-004-20240329   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240329   gcc  
csky                  randconfig-002-20240329   gcc  
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
loongarch             randconfig-001-20240329   gcc  
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

