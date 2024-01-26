Return-Path: <linux-kernel+bounces-39497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E582183D216
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641F01F25F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9D10F5;
	Fri, 26 Jan 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dW1FZ0n6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B964F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232812; cv=none; b=X05lzy9PD2rH81oSNfI3cb2eDW+97ty6TdcCmft8EXg8yThoA8ONoiSaynpgVVpV/QxwtBwLjCVYyYkbF+jE+b76hFlrJ/TZw3hPsKTHhbYPuaDlrbPglJ7dOoXyWia/rxomz9x9/2n5PnCjkL6Ij7a+5LMgQlZqjSAzX9KwtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232812; c=relaxed/simple;
	bh=DzBdPdyH6czwGKNdw1EV7Q5IicCEinJ7Qv0ZDPQZzbA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ph4a/GR/u/eNo1/3TDds8ymNFvORRpeypOwZIx/ku4kPL3gZGObkaTk/gUGiTkhHGA3cO5zBnx8zGdHyzB9/h9xW4bCIr80LOM5+zfxMXW0AhdSGmV9bAPQ2fQMDlsqsKbTlRhfOIZL2ao9xyKuFMm5oIqtpZtH4LbaG4Z7nR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dW1FZ0n6; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706232809; x=1737768809;
  h=date:from:to:cc:subject:message-id;
  bh=DzBdPdyH6czwGKNdw1EV7Q5IicCEinJ7Qv0ZDPQZzbA=;
  b=dW1FZ0n6wPPRZ8XM5/6G5NP9gc++indlhUAwr7hhkxOHzRey/oRw2Ufp
   R1DCLal40LFmsgNQptRrLrjx4MU7jeQ37+KJ/IAsXHYuFNTwGZXyRVdQQ
   53IYCWOcP2Let1RVh6KVY2ds2ngpG97UakS7GtPB/R1sBH7BW1C+MX7O2
   L5pE1eFStyVL9ob2Rel6Hgvdh6C1ilAXC+O5lxC4xjkWeX2cNhMF+ECk7
   avbTwUB5ZK+dFClF1HepuabK6+/lUhPgYrIjBau91mlTa5Dv/noiHS+oq
   iS6+D1W0zBITOfuRgg8CBGaWsnm8ElJcuUvONqNKCfsJqt6+pbkzkxfUZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399523736"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399523736"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2618655"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Jan 2024 17:33:28 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTB5x-0000ZF-0x;
	Fri, 26 Jan 2024 01:33:25 +0000
Date: Fri, 26 Jan 2024 09:32:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 b184c8c2889ceef0a137c7d0567ef9fe3d92276e
Message-ID: <202401260946.Y8GxfBhs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: b184c8c2889ceef0a137c7d0567ef9fe3d92276e  genirq: Initialize resend_node hlist for all interrupt descriptors

elapsed time: 1864m

configs tested: 89
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm64                             allnoconfig   gcc  
csky                             allmodconfig   gcc  
csky                             allyesconfig   gcc  
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
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
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
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240126   clang
x86_64       buildonly-randconfig-002-20240126   clang
x86_64       buildonly-randconfig-003-20240126   clang
x86_64       buildonly-randconfig-004-20240126   clang
x86_64       buildonly-randconfig-005-20240126   clang
x86_64       buildonly-randconfig-006-20240126   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240126   gcc  
x86_64                randconfig-002-20240126   gcc  
x86_64                randconfig-003-20240126   gcc  
x86_64                randconfig-004-20240126   gcc  
x86_64                randconfig-005-20240126   gcc  
x86_64                randconfig-006-20240126   gcc  
x86_64                randconfig-011-20240126   clang
x86_64                randconfig-012-20240126   clang
x86_64                randconfig-013-20240126   clang
x86_64                randconfig-014-20240126   clang
x86_64                randconfig-016-20240126   clang
x86_64                randconfig-071-20240126   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

