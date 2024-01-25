Return-Path: <linux-kernel+bounces-39414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548383D0C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CFB23219
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A6134AE;
	Thu, 25 Jan 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfyUzzF7"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B3134A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706225788; cv=none; b=iWzngGzASZO73Bc3qaJfq+XmJtSBx4wMOXiBiyl5GD3hjWQZ0s8GYZYXrNEw6T+I0Sf/nVwJ2QLNQc4U1b999Y4UhTQ2RTvVqDnLUiUeIfDVFlPlmH0T/JFGmdxgMfiyt144jLcvD2d8AAv9yK06Sy3n8Oty/UvCh9t3k7rUz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706225788; c=relaxed/simple;
	bh=q4W321ySrb+jOS4SfKoVM1MQ1cDlBcfDRaE1iqTCqzc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EkKoi8UIMVy3qoMJO9lDU0piivGW5ip+4qFQlyf6L5bt1uMThAMID8Yk34DZF/lmoIhmGW0hrGwM6vwtq1ChfIlbeGqyz9uRXQO84gehhZY+Dv7kqvA4JNf5CyOmRY44Ho6GNYwW8O7kUhAR0zIWFTvhV+vqWH1ySH4aTI7reiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfyUzzF7; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706225786; x=1737761786;
  h=date:from:to:cc:subject:message-id;
  bh=q4W321ySrb+jOS4SfKoVM1MQ1cDlBcfDRaE1iqTCqzc=;
  b=XfyUzzF7kdJYNgVWaQVf2lQV4tJZQNl1Kl+FiMnZubpJ6wQBNhj78Ba6
   jB513IbEDmX0H7wHP+d6o7Kad3MYMolcCLW4dLKcpPg1UABsuW567XIug
   czO+Hz81yfIp0giO6obTbi10DXznISGij6wWnesLCLrewRIqhkA4h7oro
   Gv1dYtGrMDOEn/jN9Wo0enlKDWILWYtY4IJ+Df4v+6pysFmCYf0ED7zzz
   IYmNc4DanhOQI4uBb7fhbA+u+u1HimGdL3g6ZHn/rCpDnVS5xbrg09YCL
   Y3oPAHdSRWPi8jdeF8RWArCJ6EaOvtbbLKcq//lrBSSoXicqpHRW1H+MF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401182237"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401182237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28642578"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Jan 2024 15:36:25 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT9Gg-0000Uw-0S;
	Thu, 25 Jan 2024 23:36:22 +0000
Date: Fri, 26 Jan 2024 07:35:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 22653244a9fed06f2f864b44808a85bf5c4e3ef2
Message-ID: <202401260748.6jSialA0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 22653244a9fed06f2f864b44808a85bf5c4e3ef2  genirq: Deduplicate interrupt descriptor initialization

elapsed time: 1747m

configs tested: 89
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240126   gcc  
arc                   randconfig-002-20240126   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240126   clang
arm                   randconfig-002-20240126   clang
arm                   randconfig-003-20240126   clang
arm                   randconfig-004-20240126   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240126   clang
arm64                 randconfig-002-20240126   clang
arm64                 randconfig-003-20240126   clang
arm64                 randconfig-004-20240126   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240126   gcc  
csky                  randconfig-002-20240126   gcc  
hexagon               randconfig-001-20240126   clang
hexagon               randconfig-002-20240126   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240125   gcc  
i386         buildonly-randconfig-002-20240125   gcc  
i386         buildonly-randconfig-003-20240125   gcc  
i386         buildonly-randconfig-004-20240125   gcc  
i386         buildonly-randconfig-005-20240125   gcc  
i386         buildonly-randconfig-006-20240125   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240125   gcc  
i386                  randconfig-002-20240125   gcc  
i386                  randconfig-003-20240125   gcc  
i386                  randconfig-004-20240125   gcc  
i386                  randconfig-005-20240125   gcc  
i386                  randconfig-006-20240125   gcc  
i386                  randconfig-011-20240125   clang
i386                  randconfig-012-20240125   clang
i386                  randconfig-013-20240125   clang
i386                  randconfig-014-20240125   clang
i386                  randconfig-015-20240125   clang
i386                  randconfig-016-20240125   clang
loongarch             randconfig-001-20240126   gcc  
loongarch             randconfig-002-20240126   gcc  
nios2                 randconfig-001-20240126   gcc  
nios2                 randconfig-002-20240126   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240126   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240126   clang
x86_64       buildonly-randconfig-002-20240126   clang
x86_64       buildonly-randconfig-003-20240126   clang
x86_64       buildonly-randconfig-004-20240126   clang
x86_64       buildonly-randconfig-005-20240126   clang
x86_64       buildonly-randconfig-006-20240126   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240126   gcc  
x86_64                randconfig-002-20240126   gcc  
x86_64                randconfig-003-20240126   gcc  
x86_64                randconfig-004-20240126   gcc  
x86_64                randconfig-005-20240126   gcc  
x86_64                randconfig-006-20240126   gcc  
x86_64                randconfig-011-20240126   clang
x86_64                randconfig-012-20240126   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

