Return-Path: <linux-kernel+bounces-45724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24E8434AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5D0B22197
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C417C75;
	Wed, 31 Jan 2024 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LICvRP6L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C317BD1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672969; cv=none; b=VtPDLlpVCE48d0EuXIqjAjkD3y94009ZzlKPDI/AIyd7Ug7ieECvJlsDGwi+Q6WuEDCJ+Pqm2UUa5aw/aO6JqRP5ETDa4K6C2hg9kViAnfx2lTatkz9T2QpasmibCnj1PKRz2VXfiNIZEIsZKNG5R+r629zeBtH2dATET3/B1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672969; c=relaxed/simple;
	bh=cSvh5F5W13On7g6yq77oobkRpSPvfPQR6irFt6R7mvk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Yjm8ubPY7b04u6Rb1yG//JDBRGGFgzS0qRg8LMdIYe2/dTQZXKidUls8g89egRZX/zYHCXvD5pmVUSM6D/9wfVghpnhNk2t/EYt+0CYo0MfMGtD5WzuNuzCO02DbzLTvhHCj9fDYTUIEOlbmK0PWkKITmuSnkDTfNyxkPs3Nx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LICvRP6L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706672968; x=1738208968;
  h=date:from:to:cc:subject:message-id;
  bh=cSvh5F5W13On7g6yq77oobkRpSPvfPQR6irFt6R7mvk=;
  b=LICvRP6LbdLR6z1TT1O8BGd1qQsF+hdpzaQFLMk2k092nrfC9qqOwRLK
   nOEpnV2bh9FhKlO6f3s3ooappMRHqVXGzktw4DcVd04Ldy4vKkL3Gazx1
   0GsOBANwUdfIVAT8idydm1LgPIsPHZO3/hw1Uw3B8y8cD0KpauGVrJJdd
   thLPJxzReZzrF//QiCx2VK5XACtFnEy0rRYJKdp9C/dcPGi3D7NwGL2n6
   ul2U6Oyv5tzuIWjcd4SS1xrTgde1loTh4b+5oT7E+Md/czwabiDt4vdtH
   Fj1ZO5jRRnPs1eR48o121bv83lB/Y8LItjRo3m4fD8cFy8imoXTHDGQL0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10228595"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10228595"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 19:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="737967180"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="737967180"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2024 19:49:25 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rV1bH-000175-1r;
	Wed, 31 Jan 2024 03:49:23 +0000
Date: Wed, 31 Jan 2024 11:48:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d877550eaf2dc9090d782864c96939397a3c6835
Message-ID: <202401311151.0scrazw0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d877550eaf2dc9090d782864c96939397a3c6835  x86/fpu: Stop relying on userspace for info to fault in xsave buffer

elapsed time: 730m

configs tested: 150
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240131   gcc  
arc                   randconfig-002-20240131   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                            mmp2_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                       netwinder_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240131   gcc  
csky                  randconfig-002-20240131   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240131   clang
i386         buildonly-randconfig-002-20240131   clang
i386         buildonly-randconfig-003-20240131   clang
i386         buildonly-randconfig-004-20240131   clang
i386         buildonly-randconfig-005-20240131   clang
i386         buildonly-randconfig-006-20240131   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240131   clang
i386                  randconfig-002-20240131   clang
i386                  randconfig-003-20240131   clang
i386                  randconfig-004-20240131   clang
i386                  randconfig-005-20240131   clang
i386                  randconfig-006-20240131   clang
i386                  randconfig-011-20240131   gcc  
i386                  randconfig-012-20240131   gcc  
i386                  randconfig-013-20240131   gcc  
i386                  randconfig-014-20240131   gcc  
i386                  randconfig-015-20240131   gcc  
i386                  randconfig-016-20240131   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240131   gcc  
loongarch             randconfig-002-20240131   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240131   gcc  
nios2                 randconfig-002-20240131   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240131   gcc  
parisc                randconfig-002-20240131   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                     kmeter1_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      ppc44x_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240131   gcc  
s390                  randconfig-002-20240131   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240131   gcc  
sh                    randconfig-002-20240131   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240131   gcc  
sparc64               randconfig-002-20240131   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240131   clang
x86_64       buildonly-randconfig-002-20240131   clang
x86_64       buildonly-randconfig-003-20240131   clang
x86_64       buildonly-randconfig-004-20240131   clang
x86_64       buildonly-randconfig-005-20240131   clang
x86_64       buildonly-randconfig-006-20240131   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20240131   gcc  
x86_64                randconfig-002-20240131   gcc  
x86_64                randconfig-003-20240131   gcc  
x86_64                randconfig-004-20240131   gcc  
x86_64                randconfig-005-20240131   gcc  
x86_64                randconfig-006-20240131   gcc  
x86_64                randconfig-011-20240131   clang
x86_64                randconfig-012-20240131   clang
x86_64                randconfig-013-20240131   clang
x86_64                randconfig-014-20240131   clang
x86_64                randconfig-015-20240131   clang
x86_64                randconfig-016-20240131   clang
x86_64                randconfig-071-20240131   clang
x86_64                randconfig-072-20240131   clang
x86_64                randconfig-073-20240131   clang
x86_64                randconfig-074-20240131   clang
x86_64                randconfig-075-20240131   clang
x86_64                randconfig-076-20240131   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240131   gcc  
xtensa                randconfig-002-20240131   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

