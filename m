Return-Path: <linux-kernel+bounces-109546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B2881AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3815B21C34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A51C3D;
	Thu, 21 Mar 2024 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxBYBIA4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5751877
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985715; cv=none; b=kdNu/4so01PTNxAhphLcXgRmHIObrlg0vvoycaWW+6lSxWc9M1/c/de52hUSYlNZQeyHEmkm5EYlWRn3duER13G2Ps6cvqXOB1ikz+7PX5uzOrV9sGdcxHgW4q6HyNqmUNugqY17DhqSBE0+NfFCz88m0enazeIBb0Lu11S67Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985715; c=relaxed/simple;
	bh=DcyNrqQlxp84rS92zBbKgoBcsYMd9U6UzFA0FjUo4V0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J671vLzXCoW0dbI6LkbN31EK+E2t1MaNdLIb0K5AoTdR8Zi6EPK8yoXJxywGbktVkn8bC4xPhH23t1gfh4VKjaHk6H6fOhewGDsk7cmuEkKwlaLrIfyNlHlo0h/DNC25McpAKnJZDo8+Y2N9I4bickCdcbGy6dw1Fj6ldc69hWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxBYBIA4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710985713; x=1742521713;
  h=date:from:to:cc:subject:message-id;
  bh=DcyNrqQlxp84rS92zBbKgoBcsYMd9U6UzFA0FjUo4V0=;
  b=SxBYBIA4908+l604RMgQb2sFNSoSDjlY4VNr5HF9xusPh7iXLpUZ5Qel
   /C90yCRwGmXFdBdZ5KomfDpSnN3a7Li+PEbl3B9uTLCKB0lS72kYRdETd
   UkA1IfSfAcQ8qBrxK1PMFDVS/rRSz/9VmHCO3mtt0YEYsYv09pCWfgOIB
   d8rmAeY7Lr2atsG7tk3r2r/j8+rOEjWha7UW+27R9GIDIz0VRLosw89nS
   RIV00KTPY5lyttQqn4jZNlnBpFclUdYoyye5u8KSYTYALskurYv9OAGxh
   NgVeS0RemraEq3fiw2rBMvE5nxp5e9ZnDfdml1NkrJ1/VB8w5h2aCriqa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16684064"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="16684064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 18:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="51789108"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2024 18:48:30 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn7Xf-000J4p-1p;
	Thu, 21 Mar 2024 01:48:27 +0000
Date: Thu, 21 Mar 2024 09:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 f61f02d1ff788ae5ad485ef8edd88d9c93557994
Message-ID: <202403210907.iby3wQJN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: f61f02d1ff788ae5ad485ef8edd88d9c93557994  x86/percpu: Re-enable named address spaces with KASAN for GCC 13.3+

elapsed time: 734m

configs tested: 136
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240321   gcc  
arc                   randconfig-002-20240321   gcc  
arm                   randconfig-002-20240321   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240321   gcc  
csky                  randconfig-002-20240321   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240321   gcc  
i386         buildonly-randconfig-002-20240321   gcc  
i386         buildonly-randconfig-003-20240321   clang
i386         buildonly-randconfig-004-20240321   clang
i386         buildonly-randconfig-005-20240321   gcc  
i386         buildonly-randconfig-006-20240321   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240321   clang
i386                  randconfig-002-20240321   gcc  
i386                  randconfig-003-20240321   gcc  
i386                  randconfig-004-20240321   clang
i386                  randconfig-005-20240321   clang
i386                  randconfig-006-20240321   gcc  
i386                  randconfig-011-20240321   clang
i386                  randconfig-012-20240321   gcc  
i386                  randconfig-013-20240321   gcc  
i386                  randconfig-014-20240321   gcc  
i386                  randconfig-015-20240321   gcc  
i386                  randconfig-016-20240321   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240321   gcc  
loongarch             randconfig-002-20240321   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240321   gcc  
nios2                 randconfig-002-20240321   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240321   gcc  
parisc                randconfig-002-20240321   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          g5_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-002-20240321   gcc  
powerpc64             randconfig-003-20240321   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
s390                             allyesconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240321   gcc  
sh                    randconfig-002-20240321   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240321   gcc  
sparc64               randconfig-002-20240321   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240321   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240321   gcc  
x86_64       buildonly-randconfig-002-20240321   clang
x86_64       buildonly-randconfig-003-20240321   clang
x86_64       buildonly-randconfig-004-20240321   clang
x86_64       buildonly-randconfig-005-20240321   clang
x86_64       buildonly-randconfig-006-20240321   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240321   gcc  
x86_64                randconfig-002-20240321   clang
x86_64                randconfig-003-20240321   gcc  
x86_64                randconfig-004-20240321   gcc  
x86_64                randconfig-005-20240321   gcc  
x86_64                randconfig-006-20240321   gcc  
x86_64                randconfig-011-20240321   clang
x86_64                randconfig-012-20240321   gcc  
x86_64                randconfig-013-20240321   clang
x86_64                randconfig-014-20240321   gcc  
x86_64                randconfig-015-20240321   gcc  
x86_64                randconfig-016-20240321   gcc  
x86_64                randconfig-071-20240321   clang
x86_64                randconfig-072-20240321   gcc  
x86_64                randconfig-073-20240321   gcc  
x86_64                randconfig-074-20240321   clang
x86_64                randconfig-075-20240321   clang
x86_64                randconfig-076-20240321   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240321   gcc  
xtensa                randconfig-002-20240321   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

