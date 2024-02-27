Return-Path: <linux-kernel+bounces-83031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A57868D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480E0B26957
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBCC13849B;
	Tue, 27 Feb 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDyFxiEv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F6137C34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029647; cv=none; b=gEbWx6zH/H+yl6GdAPEY8T7+r2T6O670mxJJdkVTlofAIMg0RhcquQQxnxkl72TBk8XR2Ck0QHelPf93zOS7MwtWPCBTRW7DcXot7lplsAXhRn8D1b0GsIue5SBzIL2YqTeuH/0EnOlJU393wiQKhsYptFhnrrzaFtEzixZK7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029647; c=relaxed/simple;
	bh=G4iqX+oyoPN+omrb02F98TLbPkjsf8+9ji0b/QArkGo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pJYIEz3Ci1p1k9VXz8eo/viMQKMJr7AjrcuK67b6bzoutqqqtFps+QOIN4zVxMeA7Nf0lTJL3sPO4Pxcs/NZfILJEMtKWCjpCEJ9VByPCSGlUq31fu252IE8haLTGhkF32i9FfNfqGsqQCTBVJYKkyc4xhHQ9JE+27jx/u/m0bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDyFxiEv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709029645; x=1740565645;
  h=date:from:to:cc:subject:message-id;
  bh=G4iqX+oyoPN+omrb02F98TLbPkjsf8+9ji0b/QArkGo=;
  b=EDyFxiEvsU/yOSY65kks+25jiFtHK7VeeWNCdGA3BmCpv2giznlXy+aV
   GupL1G/SHwCH0AK/TxPcTGnn8fjIPSOul0djF5e2vp450p6mpn5qySlEO
   bhhDaEVVFLAofunbM0xWxjqXtTfzN6/qglbrPv2yV3TgCZ45JXkkY2vN/
   5XCZyZTdD1GvCEDLABNOeo299KkKiS0AAzO8SSL+y/fD9o3NysoU1yjCK
   x9WPDwk/7jiKe9EHxkZ5PU66LDNLfKdcMtKN3KWCpz7lBr4psVhtSbgSb
   kcR6iZsbASn7Ziy5wEHgOGKioA0rsbkttTBhGqRYVWHCs3faNeKyQhOn7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3489175"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3489175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7141111"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Feb 2024 02:27:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reugC-000B8t-1y;
	Tue, 27 Feb 2024 10:27:20 +0000
Date: Tue, 27 Feb 2024 18:27:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 e4e535036173addff38d6b295a231a553d1e0d3a
Message-ID: <202402271809.NaWBDsF2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: e4e535036173addff38d6b295a231a553d1e0d3a  irqchip: Add StarFive external interrupt controller

elapsed time: 1193m

configs tested: 163
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
arc                   randconfig-001-20240227   gcc  
arc                   randconfig-002-20240227   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240227   gcc  
arm                   randconfig-002-20240227   gcc  
arm                   randconfig-003-20240227   gcc  
arm                   randconfig-004-20240227   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240227   clang
arm64                 randconfig-002-20240227   gcc  
arm64                 randconfig-003-20240227   gcc  
arm64                 randconfig-004-20240227   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240227   gcc  
csky                  randconfig-002-20240227   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240227   clang
hexagon               randconfig-002-20240227   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240227   gcc  
i386         buildonly-randconfig-002-20240227   gcc  
i386         buildonly-randconfig-003-20240227   clang
i386         buildonly-randconfig-004-20240227   gcc  
i386         buildonly-randconfig-005-20240227   gcc  
i386         buildonly-randconfig-006-20240227   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240227   gcc  
i386                  randconfig-002-20240227   gcc  
i386                  randconfig-003-20240227   clang
i386                  randconfig-004-20240227   clang
i386                  randconfig-005-20240227   clang
i386                  randconfig-006-20240227   gcc  
i386                  randconfig-011-20240227   clang
i386                  randconfig-012-20240227   clang
i386                  randconfig-013-20240227   clang
i386                  randconfig-014-20240227   clang
i386                  randconfig-015-20240227   clang
i386                  randconfig-016-20240227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240227   gcc  
loongarch             randconfig-002-20240227   gcc  
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
nios2                 randconfig-001-20240227   gcc  
nios2                 randconfig-002-20240227   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240227   gcc  
parisc                randconfig-002-20240227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240227   clang
powerpc               randconfig-002-20240227   gcc  
powerpc               randconfig-003-20240227   clang
powerpc64             randconfig-001-20240227   clang
powerpc64             randconfig-002-20240227   gcc  
powerpc64             randconfig-003-20240227   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240227   gcc  
riscv                 randconfig-002-20240227   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240227   gcc  
s390                  randconfig-002-20240227   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240227   gcc  
sh                    randconfig-002-20240227   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240227   gcc  
sparc64               randconfig-002-20240227   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240227   clang
um                    randconfig-002-20240227   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240227   clang
x86_64       buildonly-randconfig-002-20240227   gcc  
x86_64       buildonly-randconfig-003-20240227   clang
x86_64       buildonly-randconfig-004-20240227   clang
x86_64       buildonly-randconfig-005-20240227   clang
x86_64       buildonly-randconfig-006-20240227   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240227   clang
x86_64                randconfig-002-20240227   clang
x86_64                randconfig-003-20240227   gcc  
x86_64                randconfig-004-20240227   gcc  
x86_64                randconfig-005-20240227   gcc  
x86_64                randconfig-006-20240227   gcc  
x86_64                randconfig-011-20240227   gcc  
x86_64                randconfig-012-20240227   gcc  
x86_64                randconfig-013-20240227   clang
x86_64                randconfig-014-20240227   gcc  
x86_64                randconfig-015-20240227   gcc  
x86_64                randconfig-016-20240227   gcc  
x86_64                randconfig-071-20240227   gcc  
x86_64                randconfig-072-20240227   clang
x86_64                randconfig-073-20240227   gcc  
x86_64                randconfig-074-20240227   clang
x86_64                randconfig-075-20240227   clang
x86_64                randconfig-076-20240227   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240227   gcc  
xtensa                randconfig-002-20240227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

