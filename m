Return-Path: <linux-kernel+bounces-84510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66586A7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262311C23BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED955208DE;
	Wed, 28 Feb 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFXB10cq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA764400
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095343; cv=none; b=RXLaFSdM9xh56VhmXMTBla3YxzMk8GmblxnOVBRvRsuGuO6/0ZkQrEnwG6Ml5kcs1Q3b30pmgFT+igjJ38bQZQTSNirLAdpaaUSg9s/+IyXOHV/r8DfjTXYQj9gu/ry/C/iloWynW/h3s92LG9d3UYfksqxiBKWjM4/z/qAVgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095343; c=relaxed/simple;
	bh=Eshn0O8+Esfo49mjEWfxA8aTovK8DEsD0WYwpKJ/5lY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WiPFkWzWc7dKpuvald/KkKZdw8rFqqgVXnbDZLhW32fiEmThJ+kcNPzoEteWrdeubN+PLeSVGctYM3EXZRZ7ghb3oi2VUnekUWZHGeArolvMgFFUQyTvY0L1G11hk8HxU+KcRN0xxrhmSl1z4RViCLg2sm/7f6c0QX9q3B/c51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFXB10cq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709095341; x=1740631341;
  h=date:from:to:cc:subject:message-id;
  bh=Eshn0O8+Esfo49mjEWfxA8aTovK8DEsD0WYwpKJ/5lY=;
  b=LFXB10cqC1QAo/9BAi+CC3RcLdmQxtjVHpx4Zy2HY+CpX5XOJwq0XDHf
   s0cvFumKHv1H7FRJVodBaGgkkwkU1m9+G5dopkdW1VtZU5w74P3lEwT2e
   FtXcTgtlpkQV8IyEzwNdQCzU1Z0uh9ytss+4IdEc3+XDStIqKQHyJgu5b
   vlSK4xVSyVvUzthW+Vs/fe6gAG473f5esAr01ZZpZ4CSMiL40gu2rJ9xv
   6Ur5D2ZKWvCcoKdjv20EZA59xZ7swUIafIA2xOUcfMUxa71HhZX13YYQ2
   H3YlNwgiQ77ez0FiwtJgxru1KYJGsNkM9M27SPwU92Y+WaFYXraFFaxM4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14897752"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14897752"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 20:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="38120875"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 27 Feb 2024 20:42:19 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfBln-000Bo4-36;
	Wed, 28 Feb 2024 04:42:15 +0000
Date: Wed, 28 Feb 2024 12:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 9b9c280b9af2aa851d83e7d0b79f36a3d869d745
Message-ID: <202402281200.OiXYIJs2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 9b9c280b9af2aa851d83e7d0b79f36a3d869d745  Merge branch 'x86/urgent' into x86/apic, to resolve conflicts

elapsed time: 1143m

configs tested: 145
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
arc                   randconfig-001-20240228   gcc  
arc                   randconfig-002-20240228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240228   clang
arm                   randconfig-002-20240228   clang
arm                   randconfig-003-20240228   clang
arm                   randconfig-004-20240228   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240228   clang
arm64                 randconfig-002-20240228   gcc  
arm64                 randconfig-003-20240228   gcc  
arm64                 randconfig-004-20240228   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240228   gcc  
csky                  randconfig-002-20240228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240228   clang
hexagon               randconfig-002-20240228   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240228   gcc  
loongarch             randconfig-002-20240228   gcc  
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
nios2                 randconfig-001-20240228   gcc  
nios2                 randconfig-002-20240228   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240228   gcc  
parisc                randconfig-002-20240228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240228   clang
powerpc               randconfig-002-20240228   clang
powerpc               randconfig-003-20240228   gcc  
powerpc64             randconfig-001-20240228   clang
powerpc64             randconfig-002-20240228   clang
powerpc64             randconfig-003-20240228   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240228   clang
riscv                 randconfig-002-20240228   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240228   clang
s390                  randconfig-002-20240228   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240228   gcc  
sh                    randconfig-002-20240228   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240228   gcc  
sparc64               randconfig-002-20240228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240228   clang
um                    randconfig-002-20240228   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240228   gcc  
x86_64       buildonly-randconfig-002-20240228   clang
x86_64       buildonly-randconfig-003-20240228   clang
x86_64       buildonly-randconfig-004-20240228   gcc  
x86_64       buildonly-randconfig-005-20240228   gcc  
x86_64       buildonly-randconfig-006-20240228   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240228   clang
x86_64                randconfig-002-20240228   gcc  
x86_64                randconfig-003-20240228   gcc  
x86_64                randconfig-004-20240228   gcc  
x86_64                randconfig-005-20240228   gcc  
x86_64                randconfig-006-20240228   clang
x86_64                randconfig-011-20240228   clang
x86_64                randconfig-012-20240228   clang
x86_64                randconfig-013-20240228   clang
x86_64                randconfig-014-20240228   gcc  
x86_64                randconfig-015-20240228   gcc  
x86_64                randconfig-016-20240228   gcc  
x86_64                randconfig-071-20240228   gcc  
x86_64                randconfig-072-20240228   clang
x86_64                randconfig-073-20240228   gcc  
x86_64                randconfig-074-20240228   gcc  
x86_64                randconfig-075-20240228   clang
x86_64                randconfig-076-20240228   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240228   gcc  
xtensa                randconfig-002-20240228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

