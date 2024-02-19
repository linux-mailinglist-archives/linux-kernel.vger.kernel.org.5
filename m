Return-Path: <linux-kernel+bounces-71749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB9E85A9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E261C1C22D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAF44C94;
	Mon, 19 Feb 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl8EcDGD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6E644C81
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363516; cv=none; b=VZW4ZLNO/4eM0b51YSzwzD53vyCVSTWBaxe57/T5gibFyfLpk+m8EjjomneXp/K7ZqChqcHPO0nDEdrLaL2nmyPstI0Ed077xuDW1ARR7wrlcaK05P3cTKF6G7wtWZp60MUThee3wBBHCop5q8I5rB0HUx7ipEGQQ8eMpxMvvz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363516; c=relaxed/simple;
	bh=JouKHxr8deRAPFM8vXWIDYfAq3bD13VtFp79mfwIMUE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=btr/Plr9+Cfw8bhBYA1LXysFoQ0W9UfTSGIn4SHAPoBbM00Jlqu1CLEf/zlqNh6mkOs9eKC8gFf2r1GpNwNRtrjFcfkyUzVZDoxJaZCZXyD00OtvFZMIfUAziUYgCD1uVHejnSlqT5vOFQ++27O6DNtlFOdbrxEgCHrmVxOjpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl8EcDGD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708363514; x=1739899514;
  h=date:from:to:cc:subject:message-id;
  bh=JouKHxr8deRAPFM8vXWIDYfAq3bD13VtFp79mfwIMUE=;
  b=Pl8EcDGD359md45Rp6r2I+K/TBCnZ0CXMxqSxEHW8oSK/d/Frb8Pbo2x
   0YnRQh4XnRM4sCmnNooqb6R2KhmqiyAhGQj3t7aZT9igLV+jT86lg7P5m
   tQOzXFmfatAUUnbDw/Z/HCFL8c2yiyG9v7MrB/J5jlTlBzuEg/AQG3rBp
   q0qQ/xqG/0++L/teh+/rC1ZGLi6XYKZMiswETdO3fJUYpQs87a0HAuP0U
   TG1IS/UOZn6bGnt004DGbZYBRtrf7at3sNNPNEEzuURKDnBenIMi3if+5
   2g86k+LTj4xd3t7mAulK+wqhEz3XcoOwMekiFTi/2vYdEgdFtdTsUM4ZG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13848217"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13848217"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4789835"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2024 09:24:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rc7Ni-0003xs-0C;
	Mon, 19 Feb 2024 17:24:44 +0000
Date: Tue, 20 Feb 2024 01:23:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 b4c7a9cd36e1d1eb1ce43b4329e359a00d75a355
Message-ID: <202402200113.jfZYXEgO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: b4c7a9cd36e1d1eb1ce43b4329e359a00d75a355  rcutorture: Enable RCU priority boosting for TREE09

elapsed time: 1446m

configs tested: 179
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
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240219   gcc  
arc                   randconfig-002-20240219   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                   randconfig-001-20240219   gcc  
arm                   randconfig-002-20240219   gcc  
arm                   randconfig-003-20240219   gcc  
arm                   randconfig-004-20240219   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240219   gcc  
arm64                 randconfig-002-20240219   gcc  
arm64                 randconfig-003-20240219   clang
arm64                 randconfig-004-20240219   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240219   gcc  
csky                  randconfig-002-20240219   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240219   clang
hexagon               randconfig-002-20240219   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240219   gcc  
i386         buildonly-randconfig-002-20240219   gcc  
i386         buildonly-randconfig-003-20240219   clang
i386         buildonly-randconfig-004-20240219   gcc  
i386         buildonly-randconfig-005-20240219   clang
i386         buildonly-randconfig-006-20240219   clang
i386                                defconfig   clang
i386                  randconfig-001-20240219   clang
i386                  randconfig-002-20240219   clang
i386                  randconfig-003-20240219   clang
i386                  randconfig-004-20240219   gcc  
i386                  randconfig-005-20240219   clang
i386                  randconfig-006-20240219   gcc  
i386                  randconfig-011-20240219   gcc  
i386                  randconfig-012-20240219   clang
i386                  randconfig-013-20240219   gcc  
i386                  randconfig-014-20240219   clang
i386                  randconfig-015-20240219   gcc  
i386                  randconfig-016-20240219   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240219   gcc  
loongarch             randconfig-002-20240219   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     loongson2k_defconfig   gcc  
mips                          malta_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240219   gcc  
nios2                 randconfig-002-20240219   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240219   gcc  
parisc                randconfig-002-20240219   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   microwatt_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc                       ppc64_defconfig   clang
powerpc               randconfig-001-20240219   gcc  
powerpc               randconfig-002-20240219   clang
powerpc               randconfig-003-20240219   clang
powerpc64             randconfig-001-20240219   clang
powerpc64             randconfig-002-20240219   gcc  
powerpc64             randconfig-003-20240219   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240219   gcc  
riscv                 randconfig-002-20240219   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240219   gcc  
s390                  randconfig-002-20240219   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20240219   gcc  
sh                    randconfig-002-20240219   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7724_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240219   gcc  
sparc64               randconfig-002-20240219   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240219   clang
um                    randconfig-002-20240219   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240219   clang
x86_64       buildonly-randconfig-002-20240219   clang
x86_64       buildonly-randconfig-003-20240219   gcc  
x86_64       buildonly-randconfig-004-20240219   clang
x86_64       buildonly-randconfig-005-20240219   clang
x86_64       buildonly-randconfig-006-20240219   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240219   clang
x86_64                randconfig-002-20240219   clang
x86_64                randconfig-003-20240219   gcc  
x86_64                randconfig-004-20240219   gcc  
x86_64                randconfig-005-20240219   clang
x86_64                randconfig-006-20240219   clang
x86_64                randconfig-011-20240219   clang
x86_64                randconfig-012-20240219   gcc  
x86_64                randconfig-013-20240219   clang
x86_64                randconfig-014-20240219   gcc  
x86_64                randconfig-015-20240219   clang
x86_64                randconfig-016-20240219   gcc  
x86_64                randconfig-071-20240219   gcc  
x86_64                randconfig-072-20240219   clang
x86_64                randconfig-073-20240219   gcc  
x86_64                randconfig-074-20240219   gcc  
x86_64                randconfig-075-20240219   clang
x86_64                randconfig-076-20240219   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240219   gcc  
xtensa                randconfig-002-20240219   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

