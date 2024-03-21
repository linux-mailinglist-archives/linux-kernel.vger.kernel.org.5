Return-Path: <linux-kernel+bounces-110764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733D88635A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09625283981
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22811C33;
	Thu, 21 Mar 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcNSjdLj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333915C3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711060745; cv=none; b=RZnEPR9HJ1bUnyZmrMagffaGDvPgQRMk5vynT18/thF8V381VB0+gAuTM17oylXXXKyvikQohgjksWlwSjOVjbfo+DNCuAh690tR6zR7us+Ubfqyoki3wU8/koU8SfFF9FAJ4ctrVuS208Vq8d1GJpXtyVbkw7Vw0AzNh3ocdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711060745; c=relaxed/simple;
	bh=bQhJC5BiPxqIq4829xFYpPsOucjoVI8fQzuGCfquybM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lM03JRNxHvWbpnfTJTJ+X0ufj0/Kg2eXNX1W0kyVYU/kyaehU4gFCfv0a2GgVpWCRmkgw2PRdOyW/q3XHGpGgAH9QR2N+Cocdl1/9bAIrr9jrSYssEzvRl2mluztv3XwnRGFTTUdNNwdvqbKbTnk5MWol7eDcczYZnw286vVG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcNSjdLj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711060745; x=1742596745;
  h=date:from:to:cc:subject:message-id;
  bh=bQhJC5BiPxqIq4829xFYpPsOucjoVI8fQzuGCfquybM=;
  b=dcNSjdLjB7xevurTGOdKHLPIkbwcswLS3tU/nuLhdUWKhXzTisSAb2So
   HhoSmM5ds4Po8X2U/tryorWJL4Wp3LJBsTgnxTPy7P2uvdTbUhdn3QvNQ
   Yri9fEbhwCejmHISZVl0DxN0DmG35o3uWXWI6ZTpVUbOfQxVzz5pFEr4C
   BOedmtOZ53NUulJOltJF+rcpwkZoxACFl7/2ww1JW2oGMqKDc6eRqP4Rn
   IFhlXbB8ODsK4W+ITkkIoMLMQRW5LJfAl0smfuswM6P9JgCqJ6OmZdlmB
   oULcRd78gv1tuGecigT4Pp+FAPdm1UB0ZgcvVTERAxo9bt2Izvm5oM/Ln
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6211819"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6211819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="19242133"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Mar 2024 15:39:02 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnR3s-000Jp9-0f;
	Thu, 21 Mar 2024 22:39:00 +0000
Date: Fri, 22 Mar 2024 06:38:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b0f269728ccd1d3cabcb6f3a5b610147d98a5dd6
Message-ID: <202403220619.Hmvc1Y7F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b0f269728ccd1d3cabcb6f3a5b610147d98a5dd6  x86/config: Fix warning for 'make ARCH=x86_64 tinyconfig'

elapsed time: 797m

configs tested: 124
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240322   gcc  
arc                   randconfig-002-20240322   gcc  
arm                   randconfig-001-20240322   gcc  
arm                   randconfig-004-20240322   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-002-20240322   gcc  
arm64                 randconfig-003-20240322   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240322   gcc  
csky                  randconfig-002-20240322   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-005-20240322   clang
i386                  randconfig-006-20240322   clang
i386                  randconfig-012-20240322   clang
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-016-20240322   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240322   gcc  
loongarch             randconfig-002-20240322   gcc  
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
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240322   gcc  
nios2                 randconfig-002-20240322   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240322   gcc  
parisc                randconfig-002-20240322   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc               randconfig-002-20240322   gcc  
powerpc64             randconfig-002-20240322   gcc  
riscv                             allnoconfig   gcc  
riscv                 randconfig-001-20240322   gcc  
riscv                 randconfig-002-20240322   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240322   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240322   gcc  
sh                    randconfig-002-20240322   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240322   gcc  
sparc64               randconfig-002-20240322   gcc  
um                               allmodconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240322   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240322   gcc  
x86_64       buildonly-randconfig-002-20240322   gcc  
x86_64       buildonly-randconfig-003-20240322   gcc  
x86_64       buildonly-randconfig-006-20240322   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-002-20240322   gcc  
x86_64                randconfig-004-20240322   gcc  
x86_64                randconfig-005-20240322   gcc  
x86_64                randconfig-006-20240322   gcc  
x86_64                randconfig-011-20240322   gcc  
x86_64                randconfig-014-20240322   gcc  
x86_64                randconfig-016-20240322   gcc  
x86_64                randconfig-071-20240322   gcc  
x86_64                randconfig-072-20240322   gcc  
x86_64                randconfig-073-20240322   gcc  
x86_64                randconfig-075-20240322   gcc  
x86_64                randconfig-076-20240322   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240322   gcc  
xtensa                randconfig-002-20240322   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

