Return-Path: <linux-kernel+bounces-122370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F359F88F5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88C2293E77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B062D052;
	Thu, 28 Mar 2024 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNiOILfV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312C28E6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711595814; cv=none; b=jeiWSjOJOPmHS0aI5JokYvNK1NaLO1bTxrGgIedY3tN5yPdsp1xBLmhFMZG6i0myaGBei7jbXNW2abJ3tOElI0zfe5tZgnEReeizU23ipvxc9sR2KCsIoRFFq3d7NreU0SB8gMamdQdNH2LRaO7YBPhw+bmA3VGRHfsfI/NM1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711595814; c=relaxed/simple;
	bh=pOvo4TdvixIAdX+6AgnyShKdhFJJx5UYHDZBOVI3Yp0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=T/GHW2olP6TDP8BpgJtBpu2dVTWIuDgzOGKSuhvIRICMgOxxQKgKpe0vG5IUNoVUudrUgOTnU/pxOH/ahcB96fw7jZ46c3fdMiR88HRRG4C4rytUtAFkPEGnw7jTiL/0pjQVUDx4pLYgUyfV75qWySXOCDja2Yet06QixSimJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNiOILfV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711595812; x=1743131812;
  h=date:from:to:cc:subject:message-id;
  bh=pOvo4TdvixIAdX+6AgnyShKdhFJJx5UYHDZBOVI3Yp0=;
  b=RNiOILfVKbtf8IL+xXm92Coh56hNJKNj8rE4PQV+ViZ7qZYo1gn+eAll
   QTdgME50BW/c/VGE9BYI0c0fn2mAnvelUzC5kUImxgF9Rx9C5Kq/r5Ngv
   j/scpe92PyskoZmDn5QIeLsPjNs6N1cFNm0ov18tAwH2B3Ie7y+G6Ly6R
   bCDTImRaA4drIIjH+TBrUNtO5i1glibOKZIr1jJdfFmHBkTXss7CXAXk0
   OQ9mj+B9YNyDiaUIAvx+5RI5rST1BAz1ErDSDxPU8hQ5hh6gOy/EGhozj
   cGbljrQF2xcJeHcnF42ji/Dai4rCuDT4OiE2AEvVejD/4o9XUX/SAtiRk
   Q==;
X-CSE-ConnectionGUID: xAkMuogMQK+bWjXEJIcK/Q==
X-CSE-MsgGUID: tFLDHOtBSF6u+qP4FMPpaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6922907"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6922907"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 20:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16508293"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2024 20:16:51 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpgG0-0001kM-2d;
	Thu, 28 Mar 2024 03:16:48 +0000
Date: Thu, 28 Mar 2024 11:16:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 f9f62a877da1e6f6e9d58bd779c1c77052eb04ab
Message-ID: <202403281159.j5xFU6yk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: f9f62a877da1e6f6e9d58bd779c1c77052eb04ab  x86/dumpstack: Use uniform "Oops: " prefix for die() messages

elapsed time: 1152m

configs tested: 119
configs skipped: 136

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240328   gcc  
arc                   randconfig-002-20240328   gcc  
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240328   gcc  
arm                   randconfig-002-20240328   gcc  
arm                   randconfig-003-20240328   gcc  
arm                   randconfig-004-20240328   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240328   gcc  
arm64                 randconfig-002-20240328   gcc  
arm64                 randconfig-003-20240328   gcc  
arm64                 randconfig-004-20240328   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240328   gcc  
csky                  randconfig-002-20240328   gcc  
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
openrisc                    or1ksim_defconfig   gcc  
parisc                randconfig-001-20240328   gcc  
parisc                randconfig-002-20240328   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc64             randconfig-002-20240328   gcc  
powerpc64             randconfig-003-20240328   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240328   gcc  
riscv                 randconfig-002-20240328   gcc  
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240328   gcc  
sh                    randconfig-002-20240328   gcc  
sh                          rsk7203_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240328   gcc  
sparc64               randconfig-002-20240328   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
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
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240328   gcc  
xtensa                randconfig-002-20240328   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

