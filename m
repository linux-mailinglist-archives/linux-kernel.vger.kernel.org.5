Return-Path: <linux-kernel+bounces-64746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D04854238
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E561C2238F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E610A24;
	Wed, 14 Feb 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYOQpnxI"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165FC10A01
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886816; cv=none; b=h9Ds/bQm4gLsh22VmxeGLTNNxLxhnZCIHpGipzN0hS4wV+WyTH6G4kM7MLjiodqBYIQZlu0KU0ev5z/quh+1vyxMEaTlTzuuiJEk+2m7N4wJwZb+yzHNo3m5SmosA9YOuTahKRTIANK/Toe1tvWtSLa7CG5GmPmST4s3C43CEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886816; c=relaxed/simple;
	bh=zNpj6ds/BGQIXRec684PPL+jtb+JOBpfcMzIWDOwtaE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n2n9Zogw9SBpYMLt6U5Cmc/CmOwl5nIR1IqxM3i/P40aQe+mMmsvHvBs0uffxeon6GcGVc5F2r9fmV/VfW/z6J14IiBQv/nbPllMVZKTbSXGj3tQ9s7XJwwgZCZdU9W8VpkPNE5FWsT2wcSX5Mt5iP6D55C6xnyD8FmWbu78KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYOQpnxI; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707886814; x=1739422814;
  h=date:from:to:cc:subject:message-id;
  bh=zNpj6ds/BGQIXRec684PPL+jtb+JOBpfcMzIWDOwtaE=;
  b=aYOQpnxIVCF0ZjCpMznP4WJ0NUyOt12d9/PswCPrrNdgFURMmNwhP2zg
   DwPKRiG9r5DpbhiLjct6lYsAuYkDw6Nab0kd3WQmWTzDxoDFUNyEkJLXt
   Rw/9ot6cQXm7ePg8WtVM1/Q2sdBK6V1GCWW+TP3RnRab4eRJIsz4nvz5B
   lspE2+zc5sg+DrsVrOOGjr33dGSgpOFEwx03x7+ekfkfiD5UMrwLZjoGY
   0mlOoXIOoUPRbe2+kxYaylhDMxbWkcZH3ZoLD2IoAKlFrBXODTZDDBDyM
   A2xEI4PLvbk+Pppys2+IvQNCClUCdKWMOUL1FwTckW2rP21QHon6N+4jH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396356054"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="396356054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 21:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3443755"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Feb 2024 21:00:12 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ra7NS-0008TF-0c;
	Wed, 14 Feb 2024 05:00:10 +0000
Date: Wed, 14 Feb 2024 12:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 cadb7de3170e22893b617276c297216039aad88d
Message-ID: <202402141253.CZeVAnfl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: cadb7de3170e22893b617276c297216039aad88d  x86/alternatives: Sort local vars in apply_alternatives()

elapsed time: 801m

configs tested: 120
configs skipped: 134

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
arc                   randconfig-001-20240214   gcc  
arc                   randconfig-002-20240214   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-002-20240214   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-003-20240214   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240214   gcc  
csky                  randconfig-002-20240214   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240214   clang
i386         buildonly-randconfig-002-20240214   clang
i386         buildonly-randconfig-003-20240214   clang
i386         buildonly-randconfig-004-20240214   gcc  
i386         buildonly-randconfig-005-20240214   gcc  
i386         buildonly-randconfig-006-20240214   clang
i386                                defconfig   clang
i386                  randconfig-001-20240214   clang
i386                  randconfig-002-20240214   clang
i386                  randconfig-003-20240214   clang
i386                  randconfig-004-20240214   gcc  
i386                  randconfig-005-20240214   clang
i386                  randconfig-006-20240214   gcc  
i386                  randconfig-011-20240214   clang
i386                  randconfig-012-20240214   gcc  
i386                  randconfig-013-20240214   gcc  
i386                  randconfig-014-20240214   gcc  
i386                  randconfig-015-20240214   clang
i386                  randconfig-016-20240214   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240214   gcc  
loongarch             randconfig-002-20240214   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240214   gcc  
nios2                 randconfig-002-20240214   gcc  
parisc                randconfig-001-20240214   gcc  
parisc                randconfig-002-20240214   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-002-20240214   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240214   gcc  
sh                    randconfig-002-20240214   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc64               randconfig-001-20240214   gcc  
sparc64               randconfig-002-20240214   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-002-20240214   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240214   gcc  
x86_64       buildonly-randconfig-002-20240214   clang
x86_64       buildonly-randconfig-003-20240214   gcc  
x86_64       buildonly-randconfig-004-20240214   gcc  
x86_64       buildonly-randconfig-005-20240214   gcc  
x86_64       buildonly-randconfig-006-20240214   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240214   clang
x86_64                randconfig-002-20240214   gcc  
x86_64                randconfig-003-20240214   clang
x86_64                randconfig-004-20240214   gcc  
x86_64                randconfig-005-20240214   clang
x86_64                randconfig-006-20240214   clang
x86_64                randconfig-011-20240214   clang
x86_64                randconfig-012-20240214   clang
x86_64                randconfig-013-20240214   gcc  
x86_64                randconfig-014-20240214   gcc  
x86_64                randconfig-015-20240214   clang
x86_64                randconfig-016-20240214   clang
x86_64                randconfig-071-20240214   gcc  
x86_64                randconfig-072-20240214   clang
x86_64                randconfig-073-20240214   gcc  
x86_64                randconfig-074-20240214   clang
x86_64                randconfig-075-20240214   clang
x86_64                randconfig-076-20240214   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20240214   gcc  
xtensa                randconfig-002-20240214   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

