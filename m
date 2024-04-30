Return-Path: <linux-kernel+bounces-163818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9B8B7234
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C831C227B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3368412CDB6;
	Tue, 30 Apr 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBM8/a3o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695012C534
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475138; cv=none; b=sYIehIoCfAKZtUtkIHjD1HNWAnJvgj33SYV8dFCGqWB3MkUolf1GiFhSEqRaSDvX1KjcMi6DmzZs4IUWj3O0IfzIKLXqQvmUt52KBxDoAddycXXrh6h+W3BoK6NJcuueQcKfSANEFlSpBp9V/PQO5Vc7NYpR2UX1MAec/sI0G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475138; c=relaxed/simple;
	bh=a5r6bP7WGcxZGpi6CAoln4cFDKPComk+gXnA1XDhVTs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NEbBN5084E5gdUc0DsFILvErrjmQiQ0Nb96T2JN8zSynKpqOiHa4eaR/iz7PtbEt4gphtn6VYhMz+sKLr2BoZsG1YNBQOfvdcOXwkrh+neNXcVnYrcwmFEsuZ+t3fw+GQwHrg+k8wlXyWEgSB2A0IKXUHjkbWR2bVkASbT2OAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBM8/a3o; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714475136; x=1746011136;
  h=date:from:to:cc:subject:message-id;
  bh=a5r6bP7WGcxZGpi6CAoln4cFDKPComk+gXnA1XDhVTs=;
  b=ZBM8/a3oSk9iVW2mggjIhtqsG55o3w+hEukRyRDsRjPphvD35AI9kUye
   JOqpb73jVF3+okj+y8C+j/9xD6VOZS2O5WA89Chi/N/I6Nz45zFoNxSVZ
   /QJlpSe5kiaQkQrMtW4HuF9m0haEFfcD4Kmdg8eWKE0OBcJ8D5WbtaeIZ
   Bm9nIHIe47wM00Thcbjc3AaI6ISHd+M/Jzh0DAAy9WltV92D2yn9mIFrK
   uuRYkCyQe47doxizvUcQPRWgXbSOeFPWErktX/nFnTLvRYsn8aEmF13b8
   cgyIrUk0uO6bysKPlc2b6PRqGCp1Tulm3ZhRLSN7HR8d4OPbtev7/GtHn
   g==;
X-CSE-ConnectionGUID: E5SRWQCJSyi2DQmgQ+u1NQ==
X-CSE-MsgGUID: Kjpj3hOOSnC/n4C2vD+opg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10025658"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10025658"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:05:36 -0700
X-CSE-ConnectionGUID: l2Tb9ld1TnGuKLuM4ZYfjw==
X-CSE-MsgGUID: 0K5r+sIuQWO3Pc1RDHltJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26519596"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Apr 2024 04:05:35 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1lIi-000847-2K;
	Tue, 30 Apr 2024 11:05:32 +0000
Date: Tue, 30 Apr 2024 19:04:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/timers] BUILD SUCCESS
 455f9075f14484f358b3c1d6845b4a438de198a7
Message-ID: <202404301956.NoXv7HKj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/timers
branch HEAD: 455f9075f14484f358b3c1d6845b4a438de198a7  x86/tsc: Trust initial offset in architectural TSC-adjust MSRs

elapsed time: 803m

configs tested: 97
configs skipped: 135

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
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        neponset_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240430   gcc  
i386         buildonly-randconfig-002-20240430   clang
i386         buildonly-randconfig-003-20240430   gcc  
i386         buildonly-randconfig-004-20240430   clang
i386         buildonly-randconfig-005-20240430   clang
i386         buildonly-randconfig-006-20240430   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240430   clang
i386                  randconfig-002-20240430   gcc  
i386                  randconfig-003-20240430   gcc  
i386                  randconfig-004-20240430   gcc  
i386                  randconfig-005-20240430   gcc  
i386                  randconfig-006-20240430   gcc  
i386                  randconfig-011-20240430   gcc  
i386                  randconfig-012-20240430   clang
i386                  randconfig-013-20240430   clang
i386                  randconfig-014-20240430   gcc  
i386                  randconfig-015-20240430   gcc  
i386                  randconfig-016-20240430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc                      ppc64e_defconfig   gcc  
powerpc                     tqm5200_defconfig   gcc  
riscv                             allnoconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allyesconfig   gcc  
um                             i386_defconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240430   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-003-20240430   gcc  
x86_64                randconfig-004-20240430   gcc  
x86_64                randconfig-005-20240430   gcc  
x86_64                randconfig-013-20240430   gcc  
x86_64                randconfig-075-20240430   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

