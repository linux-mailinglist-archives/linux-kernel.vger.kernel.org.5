Return-Path: <linux-kernel+bounces-133882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412F689AA42
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566471C20D77
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5724B2A;
	Sat,  6 Apr 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/1uvI6i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455D17C8B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712397692; cv=none; b=TWL0lOKqL1d0bN49QhNI2l146HriQ1lUSwlqNp38HY7m0yIpGzvyNTRUPADXrQtYS2wc2BSTXNTyuqbS95QdzkrOhH3YJY7k10OR8KNeo+22y3onR5iz4Hh/YgP58ZRJXZRwYJmMLXBCB2m/h1Vpb9WzvQgtcrfrBqaR9ww0IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712397692; c=relaxed/simple;
	bh=JNR98MU4ex8ouov/T3rDTZ7mDFnO887kpnadXzUKk48=;
	h=Date:From:To:Cc:Subject:Message-ID; b=chht7X3+jr+SedrFNS/qwHyl1eDwtyutdhrCnJz/SodnNj7geGLXBostsFy1xhxs49TU4USVvnBh7hI27NZIue3d+HOeFr6IzDpnFkW4vXQpBBr+cfBb8ssYvsvo+a2xqIaEzVoiqxKP99NDtIHn5P2tS+WwlQixsMJWpAbRQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/1uvI6i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712397691; x=1743933691;
  h=date:from:to:cc:subject:message-id;
  bh=JNR98MU4ex8ouov/T3rDTZ7mDFnO887kpnadXzUKk48=;
  b=f/1uvI6i0kf+k81wIVN3HKc31pv9FBh46boF6KY4DQasol+4dBlAwm2E
   H292Dtarahf7kvuhqlmDAhVCqRond1jiL0Y/1+hgjEe66POyF2pb935Z4
   7dARoiqOFdFRUrKEPw6poBMspyC/feM2IAt6Sq5wmqIKrN2BlTSpjK81E
   4tsw4PKZu0RcSFkOaDFG3YQsGaaFdyrjB0J0iipQTTOZbBNAF5XcCSwyT
   Ms7aJWZ4JuJbjueW7ul62kHs1Lh1AEAH5fK3FWeDUal6x3eMvLV+UcSQb
   Lyy4MU+cYYAaa30VJstRUGNVVhr6kiTC+x9fjekgoR3OCooRxqFgACW2u
   A==;
X-CSE-ConnectionGUID: g8ztsUWlTKGGBjahng91Ew==
X-CSE-MsgGUID: KXYVtWoQRQ2okmbX8X9kCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18298822"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18298822"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 03:01:30 -0700
X-CSE-ConnectionGUID: 0GcRJKJvSCy4hpi/7phshg==
X-CSE-MsgGUID: LQ7wGsA4QgOyepALlWu0Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23884795"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Apr 2024 03:01:29 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rt2rX-0003MO-0E;
	Sat, 06 Apr 2024 10:01:27 +0000
Date: Sat, 06 Apr 2024 18:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 3287c22957b401903e4933a81eea9191788da33b
Message-ID: <202404061821.4a9O4Cq5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 3287c22957b401903e4933a81eea9191788da33b  x86/microcode/AMD: Remove unused PATCH_MAX_SIZE macro

elapsed time: 733m

configs tested: 71
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arm                          gemini_defconfig   clang
arm64                            allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240406   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240406   gcc  
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240406   gcc  
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240406   gcc  
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240406   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                           mtx1_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
um                               alldefconfig   clang
um                               allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240406   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-003-20240406   clang
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64       buildonly-randconfig-006-20240406   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-002-20240406   clang
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-004-20240406   clang
x86_64                randconfig-005-20240406   clang
x86_64                randconfig-006-20240406   clang
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-012-20240406   clang
x86_64                randconfig-013-20240406   clang
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-016-20240406   clang
x86_64                randconfig-071-20240406   clang
x86_64                randconfig-072-20240406   clang
x86_64                randconfig-073-20240406   clang
x86_64                randconfig-074-20240406   clang
x86_64                randconfig-075-20240406   clang
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

