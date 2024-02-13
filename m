Return-Path: <linux-kernel+bounces-63486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55DD853044
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C37028B57C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30393A1CA;
	Tue, 13 Feb 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIm9LBJW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232B38DD5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826311; cv=none; b=c5d1rI8wCwfvHmDgCcLDbd+GG0FrUr8NCtRTFKMD+0f2QzhJzN8h4maSDTAn4ynmG87gjy2i6PkU2bxjMEs/eMeagHdic9sRG7VsMmJEayeZhVlnxOYw1Eca2v95NeiA1kXdMgA6pnzB796BIDe2OZ4vwKqMMB4kSGqRbIONoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826311; c=relaxed/simple;
	bh=mqfYVEOtzPRSOjdOlyf2gs5Ptx2vF6ZpkfNR6nPVv9E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PGDkIABRcr5wkPyEK/vUsGANIksIlVFxJC7CdJ10+haqTsXch9E0ioijWw44OXxqf0jAELn50b2Mp4iBM0S5Th55q28iiBah0PgY/xBv8ec28AsrvA/W02OMO87Glk7U1gwQDhJrzuwUSezqV9CZoTBt0H145bxfz6YH6nT7OQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIm9LBJW; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707826309; x=1739362309;
  h=date:from:to:cc:subject:message-id;
  bh=mqfYVEOtzPRSOjdOlyf2gs5Ptx2vF6ZpkfNR6nPVv9E=;
  b=IIm9LBJWzNMt8Cf6EVMo/JiQZbsE9+R+YPv54KMXgKmM2JXJin0FpgvD
   Zp9eXe5XpMKl5yhdxcm6OkvXQxyClFemU36nRQ9gzLVQj8UObqC1SjsPN
   zyoyVQXh0YlyxhOmsfH6V1ZlgTRUdQpacuBpc6ql5N25N/N5CreVdwead
   PHyfAo/RzQ9EFEXBioxwPR1aaS5Zbs455efNPhejhq2pLuM4C6+H04Xb6
   +8Yx5+V+ATDgouEvXeXfH3URYmLYQ4kbbZjKiRlPj7RrWvjZUMD4T/3XR
   Kv6yqr0RTArF8/rj2FJNXnyCUdyfB4DlzTTsECSbaw7QnQ5iiM2c14r2Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="396263008"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="396263008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2794582"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Feb 2024 04:11:48 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZrda-0007i4-0D;
	Tue, 13 Feb 2024 12:11:46 +0000
Date: Tue, 13 Feb 2024 20:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 d794734c9bbfe22f86686dc2909c25f5ffe1a572
Message-ID: <202402132050.oPIh5Z6Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: d794734c9bbfe22f86686dc2909c25f5ffe1a572  x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

elapsed time: 770m

configs tested: 131
configs skipped: 148

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240213   gcc  
arc                   randconfig-002-20240213   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                   randconfig-001-20240213   gcc  
arm                   randconfig-002-20240213   gcc  
arm                   randconfig-003-20240213   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240213   gcc  
arm64                 randconfig-002-20240213   gcc  
arm64                 randconfig-003-20240213   gcc  
arm64                 randconfig-004-20240213   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240213   gcc  
csky                  randconfig-002-20240213   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240213   clang
i386         buildonly-randconfig-002-20240213   gcc  
i386         buildonly-randconfig-003-20240213   gcc  
i386         buildonly-randconfig-004-20240213   clang
i386         buildonly-randconfig-005-20240213   gcc  
i386         buildonly-randconfig-006-20240213   clang
i386                                defconfig   clang
i386                  randconfig-001-20240213   clang
i386                  randconfig-002-20240213   gcc  
i386                  randconfig-003-20240213   gcc  
i386                  randconfig-004-20240213   clang
i386                  randconfig-005-20240213   gcc  
i386                  randconfig-006-20240213   gcc  
i386                  randconfig-011-20240213   clang
i386                  randconfig-012-20240213   gcc  
i386                  randconfig-013-20240213   gcc  
i386                  randconfig-014-20240213   gcc  
i386                  randconfig-015-20240213   gcc  
i386                  randconfig-016-20240213   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240213   gcc  
loongarch             randconfig-002-20240213   gcc  
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
nios2                 randconfig-001-20240213   gcc  
nios2                 randconfig-002-20240213   gcc  
openrisc                         allmodconfig   gcc  
parisc                randconfig-001-20240213   gcc  
parisc                randconfig-002-20240213   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-002-20240213   gcc  
powerpc               randconfig-003-20240213   gcc  
powerpc64             randconfig-001-20240213   gcc  
powerpc64             randconfig-002-20240213   gcc  
riscv                            allmodconfig   clang
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240213   gcc  
riscv                 randconfig-002-20240213   gcc  
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240213   gcc  
sh                    randconfig-001-20240213   gcc  
sh                    randconfig-002-20240213   gcc  
sparc                            allyesconfig   gcc  
sparc64               randconfig-001-20240213   gcc  
sparc64               randconfig-002-20240213   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   clang
um                    randconfig-002-20240213   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240213   clang
x86_64       buildonly-randconfig-002-20240213   gcc  
x86_64       buildonly-randconfig-003-20240213   clang
x86_64       buildonly-randconfig-004-20240213   gcc  
x86_64       buildonly-randconfig-005-20240213   gcc  
x86_64       buildonly-randconfig-006-20240213   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240213   gcc  
x86_64                randconfig-002-20240213   clang
x86_64                randconfig-003-20240213   clang
x86_64                randconfig-004-20240213   gcc  
x86_64                randconfig-005-20240213   clang
x86_64                randconfig-006-20240213   clang
x86_64                randconfig-011-20240213   clang
x86_64                randconfig-012-20240213   clang
x86_64                randconfig-013-20240213   clang
x86_64                randconfig-014-20240213   gcc  
x86_64                randconfig-015-20240213   clang
x86_64                randconfig-016-20240213   clang
x86_64                randconfig-071-20240213   gcc  
x86_64                randconfig-072-20240213   gcc  
x86_64                randconfig-073-20240213   clang
x86_64                randconfig-074-20240213   gcc  
x86_64                randconfig-075-20240213   gcc  
x86_64                randconfig-076-20240213   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240213   gcc  
xtensa                randconfig-002-20240213   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

