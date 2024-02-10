Return-Path: <linux-kernel+bounces-60275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4F850280
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892471F25021
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A05684;
	Sat, 10 Feb 2024 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxJDS6MN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635F20E4
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707538146; cv=none; b=jDT+aBtAuwMD5I++UEUpEQU2SYMs6zvA25CtwyP6EqNatEM8AEbbiRSSESboswEpu8WDSK1PZng9I0WTOG2juYUEiAuewafOKKYLHZu4GY4V/qmdP17ErK0bsvM794Jc4wMUdWtssXJlawiPCMJc98+hpQ4MKo7oIoTOqDv8WIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707538146; c=relaxed/simple;
	bh=APM0cgnaH/J0EqBdfKSjXSAi1Fj4kv2b2n11+OqFbZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q5zpN6CWfEZ0lHIoILdUvgUj0yfMOMf87mH9aSv/uK1HPLHmBasnhA9Xg95sQVGvf3YMvuFQo0JZb7rAYsk/J255ogObAUyhCuwGEsqk5+8DSTKx+tkjguuFkVpUf4qhvsWrIuCyZLPDxhbzg+TPt+CnnktumqHd5koE1AoqXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxJDS6MN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707538145; x=1739074145;
  h=date:from:to:cc:subject:message-id;
  bh=APM0cgnaH/J0EqBdfKSjXSAi1Fj4kv2b2n11+OqFbZI=;
  b=SxJDS6MNvrWLgtRBCzVDN4Zd9m6Hu1SAdghp9ZOh7vKAExMZZfboOKPX
   k2PU3TyQSv1sb9vNrehbuVuvzRFiq+Vk1MEsie8lHwmkU2mIgQ6CN/Ao8
   o9Nqo5rMrkUaiIhMjA9Th5YyOJ/HiXz9UkEPwVlGtEZyez2IzUQtFFMUg
   urxWctd8BTOfv9MqnmqDO6Tjf/vrZE8PngCDkPyrWfn+KbWP1vx12V7IO
   9YGvAUNMgvU293NjvjHkcso5DPmSnXNbKW9uewM1FzHkCOYC8h9UUNBDS
   Nmv+7YuDgcaVqSI+7IqVVPCbR469argTMgotqZxu0wyAChvKbbP/+P3GB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5387508"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="5387508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2412794"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2024 20:09:03 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYefk-0005Km-1O;
	Sat, 10 Feb 2024 04:09:00 +0000
Date: Sat, 10 Feb 2024 12:08:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f6a1892585cd19e63c4ef2334e26cd536d5b678d
Message-ID: <202402101207.UCDnG2X1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: f6a1892585cd19e63c4ef2334e26cd536d5b678d  x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

elapsed time: 731m

configs tested: 92
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
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                      jornada720_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                             mxs_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240210   clang
i386         buildonly-randconfig-002-20240210   gcc  
i386         buildonly-randconfig-003-20240210   clang
i386         buildonly-randconfig-004-20240210   clang
i386         buildonly-randconfig-005-20240210   clang
i386         buildonly-randconfig-006-20240210   clang
i386                                defconfig   clang
i386                  randconfig-001-20240210   gcc  
i386                  randconfig-002-20240210   gcc  
i386                  randconfig-003-20240210   clang
i386                  randconfig-004-20240210   clang
i386                  randconfig-005-20240210   gcc  
i386                  randconfig-006-20240210   gcc  
i386                  randconfig-011-20240210   clang
i386                  randconfig-012-20240210   clang
i386                  randconfig-013-20240210   clang
i386                  randconfig-014-20240210   gcc  
i386                  randconfig-015-20240210   gcc  
i386                  randconfig-016-20240210   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                           xway_defconfig   clang
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
powerpc                      bamboo_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      obs600_defconfig   clang
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240210   gcc  
x86_64       buildonly-randconfig-002-20240210   gcc  
x86_64       buildonly-randconfig-003-20240210   gcc  
x86_64       buildonly-randconfig-004-20240210   clang
x86_64       buildonly-randconfig-005-20240210   clang
x86_64       buildonly-randconfig-006-20240210   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240210   clang
x86_64                randconfig-002-20240210   clang
x86_64                randconfig-003-20240210   gcc  
x86_64                randconfig-004-20240210   clang
x86_64                randconfig-005-20240210   clang
x86_64                randconfig-006-20240210   gcc  
x86_64                randconfig-011-20240210   gcc  
x86_64                randconfig-012-20240210   clang
x86_64                randconfig-013-20240210   clang
x86_64                randconfig-014-20240210   clang
x86_64                randconfig-015-20240210   gcc  
x86_64                randconfig-016-20240210   clang
x86_64                randconfig-071-20240210   gcc  
x86_64                randconfig-072-20240210   gcc  
x86_64                randconfig-073-20240210   clang
x86_64                randconfig-074-20240210   gcc  
x86_64                randconfig-075-20240210   clang
x86_64                randconfig-076-20240210   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

