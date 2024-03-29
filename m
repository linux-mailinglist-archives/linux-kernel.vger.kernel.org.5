Return-Path: <linux-kernel+bounces-125541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CD8927FB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7BD1C2105A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3613E401;
	Fri, 29 Mar 2024 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AU6sQMEN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED7196
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711756634; cv=none; b=oh/QYHGkiAr+BAyHVtOQoGNfW0w9GcVu1Vd1MI+8uwOBv476JmtPck0/h+6ddgBwhhZyNF1+hcy5V8Sawv3QuH8lWabZtXA+CHn42Dnbh1mIG3uWlq2C8Wwasx3HNjoTmsw9+bqVNlchCHr9V/VXk+0x88UsPtM1oudx3iV3G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711756634; c=relaxed/simple;
	bh=xYpTeCXdRfQzMGUz6r0Sa7H5KmPNUQhkrQ+PBGTpQNc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cnYaHNcHKv/3JNuLnBI5+UuxUk9SYc4f1jXYRdzx8QEBBuMvFMIgD4lRlb00MOSLxZ5bdwUO5goHCaqTx15wOo/28ZvoiKWTFX+L8JE62iiLIxIt4LucVr3pM3k1mfRCSK6LJVYaiHg5GtuOIdZSV0ipBxuKbw/Kace6/ceuxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AU6sQMEN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711756633; x=1743292633;
  h=date:from:to:cc:subject:message-id;
  bh=xYpTeCXdRfQzMGUz6r0Sa7H5KmPNUQhkrQ+PBGTpQNc=;
  b=AU6sQMENWA8QF2OQPSNPGf5TkjmByKyGwGuGOHvjMslUcWw+GiUU0h3s
   nswfBqKmdGD+ndFcOEAqEy4v7Oeys4S3VDyCcHlEq2PPhoJUc43fTdKYA
   X2IFYIy14KWbZXspA/Zirb5iG8Pa299jiymQNnWvBUfsq7Bbnbwq57R/E
   3epFcoac0w/O5NjMBRta6nWMFyhyVq0w+EWQaoy1L830PDIf6aA4hallY
   V1JnAHTVt9aPV4rtMnkm/wVmNKsWo6K9fXqahkPVnqYXOX9yhm1YeXv4n
   XhWoAKUigmGsWZ9ybCW3fvErzRTzp1Yrv4GUtUBOl/JfbbV4v2gUOUhfB
   g==;
X-CSE-ConnectionGUID: wEuWOcd5Rcu5ZAyUHupZHQ==
X-CSE-MsgGUID: gpOcXsUnRyWo7yPRxImWeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17580047"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="17580047"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 16:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="21627321"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Mar 2024 16:57:11 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqM5t-0003kq-04;
	Fri, 29 Mar 2024 23:57:09 +0000
Date: Sat, 30 Mar 2024 07:56:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240325-CBC] BUILD SUCCESS
 7fac48f39e0ed7942c8b3a16963a5409729a41b6
Message-ID: <202403300707.wEkGxEvB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240325-CBC
branch HEAD: 7fac48f39e0ed7942c8b3a16963a5409729a41b6  nfp: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1356m

configs tested: 139
configs skipped: 3

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
arc                   randconfig-001-20240329   gcc  
arc                   randconfig-002-20240329   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240329   gcc  
arm                   randconfig-002-20240329   clang
arm                   randconfig-003-20240329   clang
arm                   randconfig-004-20240329   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240329   gcc  
arm64                 randconfig-002-20240329   clang
arm64                 randconfig-003-20240329   clang
arm64                 randconfig-004-20240329   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240329   gcc  
csky                  randconfig-002-20240329   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240329   clang
hexagon               randconfig-002-20240329   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240330   clang
i386         buildonly-randconfig-002-20240330   clang
i386         buildonly-randconfig-003-20240330   clang
i386         buildonly-randconfig-004-20240330   clang
i386         buildonly-randconfig-005-20240330   clang
i386         buildonly-randconfig-006-20240330   clang
i386                                defconfig   clang
i386                  randconfig-001-20240330   clang
i386                  randconfig-002-20240330   clang
i386                  randconfig-003-20240330   clang
i386                  randconfig-004-20240330   clang
i386                  randconfig-005-20240330   clang
i386                  randconfig-006-20240330   gcc  
i386                  randconfig-011-20240330   clang
i386                  randconfig-012-20240330   gcc  
i386                  randconfig-013-20240330   gcc  
i386                  randconfig-014-20240330   clang
i386                  randconfig-015-20240330   gcc  
i386                  randconfig-016-20240330   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240329   gcc  
loongarch             randconfig-002-20240329   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240329   gcc  
nios2                 randconfig-002-20240329   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240329   gcc  
parisc                randconfig-002-20240329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240329   clang
powerpc               randconfig-002-20240329   gcc  
powerpc               randconfig-003-20240329   clang
powerpc64             randconfig-001-20240329   gcc  
powerpc64             randconfig-002-20240329   clang
powerpc64             randconfig-003-20240329   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240329   gcc  
riscv                 randconfig-002-20240329   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240329   clang
s390                  randconfig-002-20240329   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240329   gcc  
sh                    randconfig-002-20240329   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240329   gcc  
sparc64               randconfig-002-20240329   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240329   clang
um                    randconfig-002-20240329   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240329   gcc  
xtensa                randconfig-002-20240329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

