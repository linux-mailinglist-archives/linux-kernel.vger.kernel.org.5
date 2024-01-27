Return-Path: <linux-kernel+bounces-41160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626C83ECC0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01851F22B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D461F614;
	Sat, 27 Jan 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRmIY+bn"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF851D6B6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706352643; cv=none; b=Lw1kPMcV91uwKuNOwF0rMbKy+uyAerC94t7VfxqmaB197qPFjQ2A7PJwBYUlGdzFKNQY8OSkOFY2e37AcZHrOCXopPDzbXv5xZod4J6DYCkht4z+6aNGPMPfdveghnpM5UF+vMMI1aR0WrymrqZA0KUcVJZ1e7shQwb3XKBm3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706352643; c=relaxed/simple;
	bh=PSSCxl/vGCadQUHaYhuq+bofa1hqjkrY1AooqvO8Dkg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q7jEEt/ejWDBdlrCcTBJbGcaJySuLRdDRHYvzhSkJbgWJodeW9PhxFUOXukMYQX1Fv4Rfqs4wcfRVGwha8m7qQtUyuXljGFOHMbEEo8ZBZKjt/WWbeGN2HFACcb2rauAV70MY6Ai651LX7RJ3/2F9JFSAfYa8JoC4i5rE6acLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRmIY+bn; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706352641; x=1737888641;
  h=date:from:to:cc:subject:message-id;
  bh=PSSCxl/vGCadQUHaYhuq+bofa1hqjkrY1AooqvO8Dkg=;
  b=CRmIY+bnJois0fFmnzKxJtz64ldRTRwz+irPB0Yebk3Tl3r957oy3jxq
   xXCoTq8B9kz6FBOvygjNgRqiIS+vXBg3l+NOutxbu7X15+dpvSWaeQccJ
   +43OnPnKCj5gEnV5JcfG3W9o8VjRdZIhYTijm5ob/1ZkKg5F0oY8JF1UJ
   Hq4ZvdjAQTGrkh+uukTAxqyG/pfHK0wDIYqBnqjQozsMJ8YBUyUcXyYoC
   Sz34QHvq5Eu+TCFphy84U9BTBUaSBcrxgEYkkj0268Hls90mQE/87mvVV
   +uq4r5iLtWABnU6iPvcLZWNWYMlLc9hurJi6mN/dFYHqrmV9SL8q86qKW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401532560"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="401532560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 02:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="877625433"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="877625433"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2024 02:50:39 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTgGj-0002Co-0B;
	Sat, 27 Jan 2024 10:50:37 +0000
Date: Sat, 27 Jan 2024 18:49:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.01.25a] BUILD SUCCESS
 81622751ca402d42e7c1bd4b8e95a8dbbd3645a0
Message-ID: <202401271856.NOxkrrmc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.01.25a
branch HEAD: 81622751ca402d42e7c1bd4b8e95a8dbbd3645a0  squash! hrtimer: Report offline hrtimer enqueue

elapsed time: 2415m

configs tested: 78
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240127   gcc  
arc                   randconfig-002-20240127   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240127   gcc  
arm                   randconfig-002-20240127   gcc  
arm                   randconfig-003-20240127   gcc  
arm                   randconfig-004-20240127   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240126   clang
i386         buildonly-randconfig-002-20240126   clang
i386         buildonly-randconfig-003-20240126   clang
i386         buildonly-randconfig-004-20240126   clang
i386         buildonly-randconfig-005-20240126   clang
i386         buildonly-randconfig-006-20240126   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240126   clang
i386                  randconfig-002-20240126   clang
i386                  randconfig-003-20240126   clang
i386                  randconfig-004-20240126   clang
i386                  randconfig-005-20240126   clang
i386                  randconfig-006-20240126   clang
i386                  randconfig-011-20240126   gcc  
i386                  randconfig-012-20240126   gcc  
i386                  randconfig-013-20240126   gcc  
i386                  randconfig-014-20240126   gcc  
i386                  randconfig-015-20240126   gcc  
i386                  randconfig-016-20240126   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
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
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

