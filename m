Return-Path: <linux-kernel+bounces-127506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC56894CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4B51C21E30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFD3B193;
	Tue,  2 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeUpZUFF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C93A8D8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043141; cv=none; b=BU1sdyNma6pu0SbEjnYLrf+8aJCwvxjbPrqj8YEcRS+6qszzEoLtcAfcttbvZXg38NXvOUWUkHTxRRQwjtCOTnsvqJ3+vUdIDdt9fJmIJ1ERsX5l740rvH5gBbVq613QYB0hGm/HQEjr/BztI3d4Cbaa953D2McaRtxX+BSh+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043141; c=relaxed/simple;
	bh=Mdz5dYBM1nB5Ny0a9teqWS/osDeL5sq6juCKXVs/3kA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H6XlUNVoC5BAID9/xps6PF4i9sotmJsno71JCUJvmC5dp1XRXhQLEIrpSBG0hp+D8xbYaKOaLm1bYwtCuk2ofGW92hKXPIrgtQq17KU749MoQaZOhii6WY+ATGIUcd89R7OGwDbWOkZmDAuBtPHL/KXw1fZwlqd8cJ1xCbFZNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeUpZUFF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712043140; x=1743579140;
  h=date:from:to:cc:subject:message-id;
  bh=Mdz5dYBM1nB5Ny0a9teqWS/osDeL5sq6juCKXVs/3kA=;
  b=VeUpZUFFfopsGhCnBvItPVnkTMoc/X5MxyhcL1+9ciuS+ewTHehaDWIs
   OgBAjrO0sJWCy+bUfFh6i3iYUCMMqtXn+iDUs21Ox6CzRsmgyPDAELd0P
   C5hxH4BBqaqYLmV13P4AuFf3egiIJlpY4zRksimFRpd6nngLP3SQgDU4p
   isk3wc+rPnz5ZjTCbDyDCZJOLPoLkBXx0UlrIDSIOaHCv+1vG+0IR/m/P
   2FeV0k9qc0jOppneT8lWLQxrlPcY3bN1MKAkOVCAuURlpleetlwQoGFsI
   2G5L2DpiOtJUTZEBLmxgoMkFj9AVlOA1nM4LpGlU8QfWsZc6MYdiUuLCt
   g==;
X-CSE-ConnectionGUID: +TYCkeiWTeGJ6eV3N9xnnw==
X-CSE-MsgGUID: IaQ23Ib9TRiR6IBU9z+rMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18646214"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18646214"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 00:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17882208"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Apr 2024 00:32:17 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrYcx-00010K-0t;
	Tue, 02 Apr 2024 07:32:15 +0000
Date: Tue, 02 Apr 2024 15:31:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240325-CBC] BUILD SUCCESS
 ee6b4406897d77863ee3eacc9474c98ad68a8238
Message-ID: <202404021542.hkzIZGg5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240325-CBC
branch HEAD: ee6b4406897d77863ee3eacc9474c98ad68a8238  integrity: Avoid -Wflex-array-member-not-at-end warnings

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-161-20240402
    `-- drivers-rpmsg-qcom_glink_native.c-qcom_glink_send_open_req()-error:strcpy()-channel-name-too-large-for-req-data-(-vs-)

elapsed time: 723m

configs tested: 145
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
arc                   randconfig-001-20240402   gcc  
arc                   randconfig-002-20240402   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240402   gcc  
arm                   randconfig-002-20240402   clang
arm                   randconfig-003-20240402   clang
arm                   randconfig-004-20240402   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240402   clang
arm64                 randconfig-002-20240402   clang
arm64                 randconfig-003-20240402   clang
arm64                 randconfig-004-20240402   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240402   gcc  
csky                  randconfig-002-20240402   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240402   clang
hexagon               randconfig-002-20240402   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240402   gcc  
i386         buildonly-randconfig-002-20240402   gcc  
i386         buildonly-randconfig-003-20240402   clang
i386         buildonly-randconfig-004-20240402   clang
i386         buildonly-randconfig-005-20240402   clang
i386         buildonly-randconfig-006-20240402   clang
i386                                defconfig   clang
i386                  randconfig-001-20240402   gcc  
i386                  randconfig-002-20240402   clang
i386                  randconfig-003-20240402   clang
i386                  randconfig-004-20240402   clang
i386                  randconfig-005-20240402   clang
i386                  randconfig-006-20240402   clang
i386                  randconfig-011-20240402   gcc  
i386                  randconfig-012-20240402   clang
i386                  randconfig-013-20240402   clang
i386                  randconfig-014-20240402   clang
i386                  randconfig-015-20240402   gcc  
i386                  randconfig-016-20240402   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240402   gcc  
loongarch             randconfig-002-20240402   gcc  
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
nios2                 randconfig-001-20240402   gcc  
nios2                 randconfig-002-20240402   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240402   gcc  
parisc                randconfig-002-20240402   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240402   clang
powerpc               randconfig-002-20240402   gcc  
powerpc               randconfig-003-20240402   clang
powerpc64             randconfig-001-20240402   gcc  
powerpc64             randconfig-002-20240402   gcc  
powerpc64             randconfig-003-20240402   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240402   clang
riscv                 randconfig-002-20240402   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240402   gcc  
s390                  randconfig-002-20240402   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240402   gcc  
sh                    randconfig-002-20240402   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240402   gcc  
sparc64               randconfig-002-20240402   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240402   gcc  
um                    randconfig-002-20240402   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240402   clang
x86_64       buildonly-randconfig-002-20240402   clang
x86_64       buildonly-randconfig-003-20240402   clang
x86_64       buildonly-randconfig-004-20240402   clang
x86_64       buildonly-randconfig-005-20240402   clang
x86_64       buildonly-randconfig-006-20240402   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240402   gcc  
xtensa                randconfig-002-20240402   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

