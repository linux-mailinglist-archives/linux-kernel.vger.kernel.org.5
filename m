Return-Path: <linux-kernel+bounces-111077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DE88679F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C322B227B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01274134A3;
	Fri, 22 Mar 2024 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG1F6PpO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969912E4E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093820; cv=none; b=mNd/8P+jcysGY0/jmEqEwTLKshu4CVdOiqjxj0UhqRJxVjzTorZysKbOFLuKC6XyPyxhpkqLr35vzpbbKNiuynYKnumyzX8As8EtLWT1hRLkMifyd43fEQfLgxuKHLb5d/LIrm9DsBxsowfxnRFfgYdiuP5bNSwIlEfyXa4Zhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093820; c=relaxed/simple;
	bh=/Zrg+H7+Mylnv/M/NtnaGIa3YoeEX73h1vuYwQv2mCo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fR4y1Cw+TTwOnx4OaOH7ZCbquocECII5sCCiBdPNhs3C0Wr53/rvXET2BmI20+qQTY28bh8mh1y+vHGZTMst33fSKKJyxUw/jeiVmBMhn74pHWchfPSyXf1gwT9J48wpJ8I+etWMh8E/pcyI5z5fOaBCX4KBSlNqF39u92Y/2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG1F6PpO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711093818; x=1742629818;
  h=date:from:to:cc:subject:message-id;
  bh=/Zrg+H7+Mylnv/M/NtnaGIa3YoeEX73h1vuYwQv2mCo=;
  b=WG1F6PpO4JkGCtLByZD/swOrwaRLmF9rhPICaNiCgdN6A0G03US0m6oZ
   P3BwY2IrCPyfWhkpfrH4y45hD2hmpizr4ff8WDTgPVqhOxG5GM2+xOoOr
   RsoJGYXuC1H+BvVulB5pHf87+bKLuEQpsPcZTZjsvCDcnU0pFGyAVZShk
   1oarExY5GX/S6bUSnCz9+jOGmyxr1XAPJLwYBQdGqafHYDP2s0ufYgL/C
   MQBHx5hoU7Nu7I0NKkSoNsPqtnbn1yQulGwX4WHqqrluwj79kpMQhIaq5
   WNv0EVeyKBu440CX5WZ5SuB44HiCU4bGk5DtQBZdxvhsrs5DNPrarWzB9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6313931"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6313931"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 00:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="14684636"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Mar 2024 00:50:17 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnZfK-000K8O-06;
	Fri, 22 Mar 2024 07:50:14 +0000
Date: Fri, 22 Mar 2024 15:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 b429eafe0d9f765d8626e53221ce3108b783da5e
Message-ID: <202403221529.zpFMz5Tz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: b429eafe0d9f765d8626e53221ce3108b783da5e  x86/percpu: Enable named address spaces for GCC 9.1+

elapsed time: 745m

configs tested: 129
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240322   gcc  
arc                   randconfig-002-20240322   gcc  
arm                         axm55xx_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-001-20240322   gcc  
arm                   randconfig-004-20240322   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240322   gcc  
arm64                 randconfig-003-20240322   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240322   gcc  
csky                  randconfig-002-20240322   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240322   gcc  
i386         buildonly-randconfig-002-20240322   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-005-20240322   gcc  
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-003-20240322   gcc  
i386                  randconfig-004-20240322   gcc  
i386                  randconfig-005-20240322   clang
i386                  randconfig-006-20240322   clang
i386                  randconfig-011-20240322   gcc  
i386                  randconfig-012-20240322   clang
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-015-20240322   gcc  
i386                  randconfig-016-20240322   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240322   gcc  
loongarch             randconfig-002-20240322   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                         rt305x_defconfig   clang
nios2                         10m50_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240322   gcc  
nios2                 randconfig-002-20240322   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240322   gcc  
parisc                randconfig-002-20240322   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc               randconfig-002-20240322   gcc  
powerpc64             randconfig-002-20240322   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240322   gcc  
riscv                 randconfig-002-20240322   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240322   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240322   gcc  
sh                    randconfig-002-20240322   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240322   gcc  
sparc64               randconfig-002-20240322   gcc  
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240322   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240322   gcc  
xtensa                randconfig-002-20240322   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

