Return-Path: <linux-kernel+bounces-112130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1273887604
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1166E1C213C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0E039B;
	Sat, 23 Mar 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwppHq8n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD67F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153186; cv=none; b=eypRLBwo3c5JDSA51joqm7Mz9Vv37iNtE+vf38WBsWBHb0FwtWif2xaYAbOYyHmE6U8P5RIcbwCp+8nMGghcWAF2lrhZJ2S5aC5RC1Bqtmg+FIKzINfjeFVeeLsxNOePpuzK5qrsJcKwuSANVEGRL/4DT0o4nooKpFXtP0iqPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153186; c=relaxed/simple;
	bh=yoLc6PORou0xZ9BMA6yv+YYy8V048eT+ARQQUwVnKhw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B5mYkWG72NJriJLr2CAhJTRCOApB8SiyB9O1QQTNWBhFCXPPkq3iJeDE6aBWp4yA5UDFox4cHQ0arrYlvSqD8nIGYVQucsr2fNX79VRzNjEBHBCAr2R7rVYiBtyxviP0UOZK5dhIeEQ7ALaO86n685tlh4WNaqJSDuTxS3Qfn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwppHq8n; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711153184; x=1742689184;
  h=date:from:to:cc:subject:message-id;
  bh=yoLc6PORou0xZ9BMA6yv+YYy8V048eT+ARQQUwVnKhw=;
  b=mwppHq8ntonSaVX4Qh27fv6J/FpTsRVtoFNgwzvb2NHrxDvT2jDFB65z
   vjRW/9C9oh7bm+45yOYIz3yGkkIh7qzwGTUDgF2YcOMs00INEHFO+mRBy
   UVef+Taz/wxUjdhdN13rIJpao4zGQV0PmIpCZebOST1BCAynv+wAIJCUH
   Hiw/pDXZUponaonznu6hjjwR4VW9fiN4IkP3r5M9YXAXj7XJCxTBWZTGU
   A9J8DRWGprTsSGhG7aBCwy0nT8K8r6ndMYEUFCjilFbDGS9pJoKNeAzl4
   7+twbf5h/rnZ4t3y3DIEBelnUZSqT+ZTDx42p6WxoDPEqLZbgquV5YNhi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6333296"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="6333296"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 17:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="15051042"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 22 Mar 2024 17:19:42 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnp6q-000Kj5-0H;
	Sat, 23 Mar 2024 00:19:40 +0000
Date: Sat, 23 Mar 2024 08:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 4e51653d5d871f40f1bd5cf95cc7f2d8b33d063b
Message-ID: <202403230842.ZOjffdfa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 4e51653d5d871f40f1bd5cf95cc7f2d8b33d063b  kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

elapsed time: 798m

configs tested: 139
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240323   gcc  
arc                   randconfig-002-20240323   gcc  
arm                          ixp4xx_defconfig   gcc  
arm                   randconfig-004-20240323   gcc  
arm                         socfpga_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240323   gcc  
arm64                 randconfig-002-20240323   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240323   gcc  
csky                  randconfig-002-20240323   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240322   gcc  
i386         buildonly-randconfig-001-20240323   gcc  
i386         buildonly-randconfig-002-20240322   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-004-20240323   gcc  
i386         buildonly-randconfig-005-20240322   gcc  
i386         buildonly-randconfig-005-20240323   gcc  
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-003-20240322   gcc  
i386                  randconfig-003-20240323   gcc  
i386                  randconfig-004-20240322   gcc  
i386                  randconfig-004-20240323   gcc  
i386                  randconfig-005-20240322   clang
i386                  randconfig-005-20240323   gcc  
i386                  randconfig-006-20240322   clang
i386                  randconfig-006-20240323   gcc  
i386                  randconfig-011-20240322   gcc  
i386                  randconfig-011-20240323   gcc  
i386                  randconfig-012-20240322   clang
i386                  randconfig-012-20240323   gcc  
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-014-20240323   gcc  
i386                  randconfig-015-20240322   gcc  
i386                  randconfig-015-20240323   gcc  
i386                  randconfig-016-20240322   clang
i386                  randconfig-016-20240323   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240323   gcc  
loongarch             randconfig-002-20240323   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240323   gcc  
nios2                 randconfig-002-20240323   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240323   gcc  
parisc                randconfig-002-20240323   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc               randconfig-001-20240323   gcc  
powerpc               randconfig-002-20240323   gcc  
powerpc64             randconfig-003-20240323   gcc  
riscv                             allnoconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-002-20240323   gcc  
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240323   gcc  
sh                    randconfig-002-20240323   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240323   gcc  
sparc64               randconfig-002-20240323   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240323   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240323   clang
x86_64       buildonly-randconfig-002-20240323   clang
x86_64       buildonly-randconfig-003-20240323   clang
x86_64       buildonly-randconfig-005-20240323   clang
x86_64       buildonly-randconfig-006-20240323   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240323   clang
x86_64                randconfig-003-20240323   clang
x86_64                randconfig-004-20240323   clang
x86_64                randconfig-011-20240323   clang
x86_64                randconfig-013-20240323   clang
x86_64                randconfig-014-20240323   clang
x86_64                randconfig-015-20240323   clang
x86_64                randconfig-016-20240323   clang
x86_64                randconfig-071-20240323   clang
x86_64                randconfig-072-20240323   clang
x86_64                randconfig-073-20240323   clang
x86_64                randconfig-074-20240323   clang
x86_64                randconfig-076-20240323   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240323   gcc  
xtensa                randconfig-002-20240323   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

