Return-Path: <linux-kernel+bounces-122458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A817F88F7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E228FEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572F4EB46;
	Thu, 28 Mar 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5oulbXR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AA32C89
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606739; cv=none; b=pbuN7v8Tla5MTCHs3DnP5WzcZUwS2zj1oiXubcPHEYWTCOaqkG2lO7pjgd2JcnDcAj9J9npt1kQEPlxH9qbOlmcNl08yyq/S2OxjSary7ZXD/o37XcUi8fGnfQFcO2JnN21/UCNxUVx5cynquELdmilbSxKlWp+GMYL5qloy5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606739; c=relaxed/simple;
	bh=kYfP5qTQK0j1IhpcU1GXcq/Ql/dmz/DnS37GEALQ0KA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QT6rSM6tYMY7FeB1wfRFO+18hPyUX3d/3ic3bcV7SWXmD3Be34J7kUzu4jSaZPN35MbMInQiL8KJa5HDZMl+a6baCrxvp0juXoVcq7TTQ+tWERQk5xVXKfDiDhbJuO78URBDOtsRkBvmxd8CN51eSyS7lPpJylznoWImgdzUmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5oulbXR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711606737; x=1743142737;
  h=date:from:to:cc:subject:message-id;
  bh=kYfP5qTQK0j1IhpcU1GXcq/Ql/dmz/DnS37GEALQ0KA=;
  b=f5oulbXRp1I5fqlGuZqZB3PygN+vWN/cPE3pDL6UkSw/iVQ1N2WidoQu
   CeoOWQoz5nnqT04J1aptBMR4ogmMHPJYjsjYRIJ7awS4kUdVO+L3yn5qD
   SiC+dR9/hbx+H6Cbcfcf5YPU5E+dqV83YtwHMPB5zbrqENhbzYMy+/418
   Qe9Qtok0av1VoiB9yjbaTrU9O+HE+cR1q1erfm8gPxvfI0L1wbHw9NScF
   3773DxUjC4jy5dtG3UOJlsxivc04woGbSQOubQnrDFMmK09c3XdP4BOFR
   Ay5VxqxX6qp5cddX/Yv8bSdaPbiyrdl/iOcPNIK/5SaKHWVmKqygOeb7J
   Q==;
X-CSE-ConnectionGUID: phauJFnETAaGeSc2nhq+mg==
X-CSE-MsgGUID: VYuVoW72TxW4t5YUT79OIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6855774"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6855774"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 23:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21194937"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Mar 2024 23:18:56 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpj6D-0001rK-0d;
	Thu, 28 Mar 2024 06:18:53 +0000
Date: Thu, 28 Mar 2024 14:18:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065
Message-ID: <202403281414.vwK6UpUf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065  MAINTAINERS: Add co-maintainers for time[rs]

elapsed time: 973m

configs tested: 151
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
arc                                 defconfig   gcc  
arc                   randconfig-001-20240328   gcc  
arc                   randconfig-002-20240328   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240328   gcc  
arm                   randconfig-002-20240328   gcc  
arm                   randconfig-003-20240328   gcc  
arm                   randconfig-004-20240328   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240328   gcc  
arm64                 randconfig-002-20240328   gcc  
arm64                 randconfig-003-20240328   gcc  
arm64                 randconfig-004-20240328   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240328   gcc  
csky                  randconfig-002-20240328   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240328   clang
i386                                defconfig   clang
i386                  randconfig-001-20240328   clang
i386                  randconfig-002-20240328   clang
i386                  randconfig-003-20240328   clang
i386                  randconfig-004-20240328   clang
i386                  randconfig-011-20240328   clang
i386                  randconfig-012-20240328   clang
i386                  randconfig-013-20240328   clang
i386                  randconfig-014-20240328   clang
i386                  randconfig-015-20240328   clang
i386                  randconfig-016-20240328   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240328   gcc  
loongarch             randconfig-002-20240328   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240328   gcc  
nios2                 randconfig-002-20240328   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240328   gcc  
parisc                randconfig-002-20240328   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc64             randconfig-002-20240328   gcc  
powerpc64             randconfig-003-20240328   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240328   gcc  
riscv                 randconfig-002-20240328   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240328   gcc  
sh                    randconfig-002-20240328   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240328   gcc  
sparc64               randconfig-002-20240328   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240328   gcc  
um                    randconfig-002-20240328   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240328   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240328   clang
x86_64                randconfig-003-20240328   clang
x86_64                randconfig-005-20240328   clang
x86_64                randconfig-006-20240328   clang
x86_64                randconfig-011-20240328   clang
x86_64                randconfig-012-20240328   clang
x86_64                randconfig-015-20240328   clang
x86_64                randconfig-016-20240328   clang
x86_64                randconfig-072-20240328   clang
x86_64                randconfig-076-20240328   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240328   gcc  
xtensa                randconfig-002-20240328   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

