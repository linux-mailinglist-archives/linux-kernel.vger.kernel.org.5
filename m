Return-Path: <linux-kernel+bounces-31794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2883342C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374C9283400
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A2DEAC2;
	Sat, 20 Jan 2024 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvIfawKS"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37E23D5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705754143; cv=none; b=D3YTjKMKc9hNvNnw7dZA9V8qv+IqBLo/Lw3FRdr2fon5tOft0CiahonN+XDJow4YbDRMZVRi6Oz+7i2eicmzTNdkXTuvNYmiNmv7GZtRrT+Famsl9dHFuYLLoC4jrjyaqNNAJzhilTY5rKGt1+eV74ZNW9wdWxIHEeyWmPQVhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705754143; c=relaxed/simple;
	bh=/V3FV0JKqzS/vDNMkqEO81ltZthP15aB2cGXynFFcwY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ni/qOKvcGap3j+mFJMYjYc/j0TXRk63o5rlMh/VONd5dZV6SvcG5da1nmDcNWFmeKMyl+GlvPHFhuCYsB3/JiBxbGtngqOiHHFXbCGVw4mnY5Sj5vgnX/4n4AGy7cOsN9CsXPr2prynzosgXRplWWeXZX2lb29UelPHHV8YOEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvIfawKS; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705754141; x=1737290141;
  h=date:from:to:cc:subject:message-id;
  bh=/V3FV0JKqzS/vDNMkqEO81ltZthP15aB2cGXynFFcwY=;
  b=XvIfawKSkuSey8bNWjD/gjDXlNdeVcxWwjD3x9coHSyNXyuqJyZ01b+J
   phUu0vpKhGja72sRaabB1uuNav36We2GMaddExd/zl0T4LfKroO32HoQn
   INgK9q/zYqDzkSijACWZ8UvomMWgnjAptl/9BQSKfMYlgvPDJ1JOaPMjC
   IM3llfc0zmEowNnqQWCe9DVCxMqyrIZUsZPujpq+UWCLRj1OUG39Nqyh9
   3bzRdcpTOQISqlb5bI//3htDaBW8EJ5iwCd+9fOLulCW4qpjJdZGc9EBt
   lebasA5vTyjZ2pcYCxjjSGBEViQ/V15Lm3yvGqJSRKr0PFBwqsOg/SyPp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="432110985"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="432110985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 04:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="928612730"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="928612730"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2024 04:35:39 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRAZU-00055c-2I;
	Sat, 20 Jan 2024 12:35:36 +0000
Date: Sat, 20 Jan 2024 20:35:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 e626cb02ee8399fd42c415e542d031d185783903
Message-ID: <202401202005.2uELU9Sf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: e626cb02ee8399fd42c415e542d031d185783903  futex: Prevent the reuse of stale pi_state

elapsed time: 1459m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240120   gcc  
arc                   randconfig-002-20240120   gcc  
arm                               allnoconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240120   gcc  
csky                  randconfig-002-20240120   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                  randconfig-011-20240120   gcc  
i386                  randconfig-012-20240120   gcc  
i386                  randconfig-013-20240120   gcc  
i386                  randconfig-014-20240120   gcc  
i386                  randconfig-015-20240120   gcc  
i386                  randconfig-016-20240120   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240120   gcc  
loongarch             randconfig-002-20240120   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240120   gcc  
nios2                 randconfig-002-20240120   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240120   gcc  
parisc                randconfig-002-20240120   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240120   gcc  
s390                  randconfig-002-20240120   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240120   gcc  
sh                    randconfig-002-20240120   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240120   gcc  
sparc64               randconfig-002-20240120   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240120   clang
x86_64       buildonly-randconfig-002-20240120   clang
x86_64       buildonly-randconfig-003-20240120   clang
x86_64       buildonly-randconfig-004-20240120   clang
x86_64       buildonly-randconfig-005-20240120   clang
x86_64       buildonly-randconfig-006-20240120   clang
x86_64                                  kexec   gcc  
x86_64                randconfig-011-20240120   clang
x86_64                randconfig-012-20240120   clang
x86_64                randconfig-013-20240120   clang
x86_64                randconfig-014-20240120   clang
x86_64                randconfig-015-20240120   clang
x86_64                randconfig-016-20240120   clang
x86_64                randconfig-071-20240120   clang
x86_64                randconfig-072-20240120   clang
x86_64                randconfig-073-20240120   clang
x86_64                randconfig-074-20240120   clang
x86_64                randconfig-075-20240120   clang
x86_64                randconfig-076-20240120   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240120   gcc  
xtensa                randconfig-002-20240120   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

