Return-Path: <linux-kernel+bounces-119956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1AE88CF67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD05B23BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75F7442F;
	Tue, 26 Mar 2024 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MdbZgVeC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BD1E884
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486205; cv=none; b=WY0ySAtriiDnwJAFr3tbJeLBiPFQ/4YvZ2KqFW9R5vojG8C13wJ/dox3el6pGu3BSorj3qV2tY6NS4jtXkC1S1hg87DVQOxqfEcx/OarD+vLkxscl7499qR4YCndu0PyjwE7jtUc7BZTDCcE1rnoNTuyhcSxW336EGglZogyQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486205; c=relaxed/simple;
	bh=s+P3o22drhZ7GDnlZ0NCg/4knCPx0uhAliY6uz/piso=;
	h=Date:From:To:Cc:Subject:Message-ID; b=POZ9NnXp3gOcC82oGM1Pvqew5illuml/oySCXKlZQh2n8x0zuSNHEdOD7RZFIzwMaBS0+vdcMRf8liOTiY4Ax8wW1b6QqlHIRzrVtICCqhLr1CfJV1sW2x4B9kwwm+w3ZNRyv1YJeYNKIG5iZfPIvUVXJ8rg+t8Ssi9RoFM2lUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MdbZgVeC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711486202; x=1743022202;
  h=date:from:to:cc:subject:message-id;
  bh=s+P3o22drhZ7GDnlZ0NCg/4knCPx0uhAliY6uz/piso=;
  b=MdbZgVeCiWvQVQc9w51rEHfhRYoDt9hD/Dnv6V9gdvzykgJqfBaRey8B
   yuR3tio4o7eqjAJLxGOp+KaEjx4U6ra5eM0TU/r8vh5vDAMHmfEYiAPtW
   DkgUD9m7qUqNkFvVD5s3BIvoFf6UWqFFX+BB2IljiCjo9Qqz/0qBfCpnp
   7DLVNwd2tZT8VSRjF98Q61H8WkqbEjFgzVRFoexLfpLuyeJrV5ItAqlB6
   lKRd/INNXLkaYiJBVx+eJXjWig78moofc4Pz5Tz9NnO5qzhOftSTGcCEi
   cGfBb3C4n9Ulvi2bOMpKFGZqQPmBL0tBUKFvGHhHSslsoTBw+uLok9eW0
   A==;
X-CSE-ConnectionGUID: 6wiiXithQ/+BtbKghzHE0A==
X-CSE-MsgGUID: n1QzFPFoSa6RfrE6Ok9ndw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24005357"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24005357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16106381"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Mar 2024 13:50:00 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpDk6-0000Oi-1V;
	Tue, 26 Mar 2024 20:49:58 +0000
Date: Wed, 27 Mar 2024 04:49:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff
Message-ID: <202403270426.VfqcpNTa-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff  perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and later

elapsed time: 749m

configs tested: 95
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                           spitz_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240326   gcc  
i386         buildonly-randconfig-002-20240326   clang
i386         buildonly-randconfig-003-20240326   clang
i386         buildonly-randconfig-004-20240326   gcc  
i386         buildonly-randconfig-005-20240326   gcc  
i386         buildonly-randconfig-006-20240326   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240326   gcc  
i386                  randconfig-002-20240326   gcc  
i386                  randconfig-003-20240326   gcc  
i386                  randconfig-004-20240326   clang
i386                  randconfig-005-20240326   gcc  
i386                  randconfig-006-20240326   clang
i386                  randconfig-011-20240326   clang
i386                  randconfig-012-20240326   gcc  
i386                  randconfig-013-20240326   clang
i386                  randconfig-014-20240326   clang
i386                  randconfig-015-20240326   clang
i386                  randconfig-016-20240326   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                          malta_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    klondike_defconfig   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240326   clang
x86_64       buildonly-randconfig-002-20240326   gcc  
x86_64       buildonly-randconfig-003-20240326   clang
x86_64       buildonly-randconfig-004-20240326   gcc  
x86_64       buildonly-randconfig-005-20240326   gcc  
x86_64       buildonly-randconfig-006-20240326   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240326   gcc  
x86_64                randconfig-002-20240326   gcc  
x86_64                randconfig-003-20240326   gcc  
x86_64                randconfig-004-20240326   clang
x86_64                randconfig-005-20240326   gcc  
x86_64                randconfig-006-20240326   clang
x86_64                randconfig-011-20240326   gcc  
x86_64                randconfig-012-20240326   clang
x86_64                randconfig-013-20240326   gcc  
x86_64                randconfig-014-20240326   gcc  
x86_64                randconfig-015-20240326   clang
x86_64                randconfig-016-20240326   clang
x86_64                randconfig-071-20240326   clang
x86_64                randconfig-072-20240326   gcc  
x86_64                randconfig-073-20240326   gcc  
x86_64                randconfig-074-20240326   gcc  
x86_64                randconfig-075-20240326   gcc  
x86_64                randconfig-076-20240326   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

