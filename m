Return-Path: <linux-kernel+bounces-41130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B083EC49
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2CD2834AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8821E88C;
	Sat, 27 Jan 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBCf++jR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8FD1E873
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706347328; cv=none; b=Ejn9oqZOvgJZOJ5/+FrinB3FGrHH0+3VyreMw2NLxgFHVUeHHKqkAG4Q3EIsTZCwwWLVUkjDp2x5xubCeHlmPOGo5RsYSXQpM8bTjHQskYpueRVkr0xwOKGtw36XADKZVddBJaWoCcm2aYAYnPXF8u+zKZaEiAWbJ9cL35f3E1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706347328; c=relaxed/simple;
	bh=c9euRK7gCznEaWY16SqIVQptiGJBUAYW3sSGzu2AV9g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JbzQ41w6JhyLgFV3N2kJcOsmkC/Q+pxSAau3hWYgUq3T0jpKsAXD7OPoFAPJuO/o9ZHEFt5OCjLeqg/OAR5xZlTKqHMVSpv1+PL5n3rzJilA9D0SFXXlcOuLgrR/5epSMWM51H+J/HnYnFiTuIG46GufF2EkYCQAfKuxhNbYvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBCf++jR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706347327; x=1737883327;
  h=date:from:to:cc:subject:message-id;
  bh=c9euRK7gCznEaWY16SqIVQptiGJBUAYW3sSGzu2AV9g=;
  b=iBCf++jRX64FWDe73pPRXZP+xy9nQpJd9FYvwXV6YO3DSNxnRKdmpWVI
   qSJjN0lOzZzIx97C0IbRZSMmSik9iRF8VxLP8g+IzYCg95kDxps5jedID
   Il8iCABaqsXI1PdNjau1NjFj9gziRlvUlbj/3lXRyd9YydXXaiOturfc5
   zoWpXvyzZubx7gMGKYeHRVcruIWgjkQ8j9TZPnUVDNh4Uq11V1G8Jone4
   1yNUK6yhRoywUprHRDnKUGy/LiL20+SYOwKyjgyNagounL+8G/qKWqfsb
   TZiP31MJosqjOmsOJ1IksKOiyZ70RwiCAOZELgYkrnM/rOd7wi6tLDmj+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9778795"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9778795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 01:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35660290"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2024 01:22:05 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTet0-0001oD-0S;
	Sat, 27 Jan 2024 09:22:02 +0000
Date: Sat, 27 Jan 2024 17:21:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c
Message-ID: <202401271713.AZjYHnmX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c  rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks

elapsed time: 2326m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240127   gcc  
arc                   randconfig-002-20240127   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240127   gcc  
arm                   randconfig-002-20240127   gcc  
arm                   randconfig-003-20240127   gcc  
arm                   randconfig-004-20240127   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240127   gcc  
arm64                 randconfig-002-20240127   gcc  
arm64                 randconfig-003-20240127   gcc  
arm64                 randconfig-004-20240127   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240127   gcc  
csky                  randconfig-002-20240127   gcc  
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
i386                  randconfig-001-20240126   clang
i386                  randconfig-002-20240126   clang
i386                  randconfig-003-20240126   clang
i386                  randconfig-004-20240126   clang
i386                  randconfig-005-20240126   clang
i386                  randconfig-006-20240126   clang
i386                  randconfig-011-20240126   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240126   gcc  
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240126   gcc  
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240126   gcc  
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240126   gcc  
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240126   gcc  
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240127   gcc  
loongarch             randconfig-002-20240127   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240127   gcc  
nios2                 randconfig-002-20240127   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240127   gcc  
parisc                randconfig-002-20240127   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240127   gcc  
powerpc               randconfig-002-20240127   gcc  
powerpc               randconfig-003-20240127   gcc  
powerpc64             randconfig-001-20240127   gcc  
powerpc64             randconfig-002-20240127   gcc  
powerpc64             randconfig-003-20240127   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240127   gcc  
riscv                 randconfig-002-20240127   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240127   gcc  
sh                    randconfig-002-20240127   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240127   gcc  
sparc64               randconfig-002-20240127   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240127   gcc  
um                    randconfig-002-20240127   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240127   gcc  
xtensa                randconfig-002-20240127   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

