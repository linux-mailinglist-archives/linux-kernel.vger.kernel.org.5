Return-Path: <linux-kernel+bounces-40381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1E83DF45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972712842A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCA1E88C;
	Fri, 26 Jan 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUjsvaFn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41991E874
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288045; cv=none; b=ZyTDTkAGyI/srFGvP1Svi+BwkXdG4QXPy2ylEVdGzo8O4h0YS7/Q7ISsOIWfqTuay8Te6dqYSqze6d1nSSKSug+ewyPjJ/4hVo52o5WTvmbiOjWZOh/qkRhSwRpAsLPoI25Cqok59mli84JUMnZ8fNFH2Cht4vpOAN8J/vSlyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288045; c=relaxed/simple;
	bh=g5qSH8G9BfIp7QqEiLQfdpjtQElqkTBtBKYk462rOf4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=inI8E0PWP/22GWHzqYrvQ95DYZx2ORzbVTZgESd7kKBy74dTKoLLNah00uLQpN6k5X19QU4O9zhqFDOS0fhfYeUI1d2yrSZ4ZgdWp1GSP99+NMJq9A655s7r63P2YFWQjpcmX3cXEyfpaY9wrx0/mTbzuvGxybRX7AusOehjhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUjsvaFn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706288042; x=1737824042;
  h=date:from:to:cc:subject:message-id;
  bh=g5qSH8G9BfIp7QqEiLQfdpjtQElqkTBtBKYk462rOf4=;
  b=WUjsvaFnhqPlTlLyDUIsvBEUvQta7luQeiAO/qq14H15uSnKPtEllwHT
   OtyLRHSqXvZum5kFgzJIhIm5RvxKZvugbx1+A6DaRC/2Du7AtX8MmiGWb
   BPr0SRq7alGn91IPYHC1397MfjLIcOo/TjKs8+IFW6T1EYVMrajRMmydY
   a6OT0WsudIWpMONn5F5nE6yjvg4mGfitxCfP8UEu2mQTVdYpGNyxOC9cn
   pif2+9G89WI2YdzstpXbDelOXsRlhA4kTlb/hjAxk+8TyG4isPrD8bI5o
   2fCPMjXhysojHwm+FNX14rvcY+cD3UbcWTvCEQsph5xNJkPZguhn223YQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9272776"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9272776"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 08:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35486049"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jan 2024 08:54:00 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTPSn-0001DG-2v;
	Fri, 26 Jan 2024 16:53:57 +0000
Date: Sat, 27 Jan 2024 00:53:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 9a574ea9069be30b835a3da772c039993c43369b
Message-ID: <202401270032.6mql1b4o-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 9a574ea9069be30b835a3da772c039993c43369b  tick/sched: Preserve number of idle sleeps across CPU hotplug events

elapsed time: 1918m

configs tested: 95
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-002-20240127   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
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
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
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

