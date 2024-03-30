Return-Path: <linux-kernel+bounces-125734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7C892B64
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7C21F21E07
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60062554B;
	Sat, 30 Mar 2024 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nviT3tE0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB2125DB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711805571; cv=none; b=e9D+qVuGURy+Zvcyik0EAFaHNW8ZSiq8P/ptqyDSnwYmT8fCk3YHO8hUE92xM9cDb4oaaJAPKuFDKzDNaHvziaM/61wMZA/I37cIuLXVweGavtcwa+EQru9o3FhjPA2JFf4TYszOPuz39hB/N43qK9VHmAp6Via2U22/b03q4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711805571; c=relaxed/simple;
	bh=6nRZ28teIZoK/CsuLAsj8nxOgJ/+ZRmeJPPyiIo4peU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SvDTkdnbONPPiHqwj7rvwUH9meCx+lapa/ZpuKY/CC46l7qtjU3NszsY7EJPKs6UcuvDr22k76iLl2fe5MkJGCbBrJ4S+1Bf09pxq7IzqcF9xkwM3kXk+V5tt9UgG/nnwMby0mk6+3RJWFubEUJR7ANoJ9OJ0lJQqqSCMZ1Rv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nviT3tE0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711805570; x=1743341570;
  h=date:from:to:cc:subject:message-id;
  bh=6nRZ28teIZoK/CsuLAsj8nxOgJ/+ZRmeJPPyiIo4peU=;
  b=nviT3tE0HfsQIhXgbWSk9PBsGYSKS0LhKICL4c1NLjX7sXRJxGhVPNlF
   woVpnKAyT1a55zTtrgyQ9euXGDKMBH2dIPR/PaYZJGnjz4u3N410iFISw
   KuDuGNAobiMz2lhVA3p2WTwvoAh0eS94w3vPWEeRp2NkYHZ2CdSSbLhwR
   PU8py2/TGuk4COEm67Tkt8eXltXybQMISuvvRkG1hgMSmT2L8og31h8kC
   KNLH3NOYoPc1Lx9EpvVtElFHHYV8sv2hv5bObYfkYrf2a6szT8xjVNUun
   1OaxQUX2CWPLxYRfq2Juu8MnimnUofYOLUBpBjTQ5vm1ARVm/XLHY7DTb
   w==;
X-CSE-ConnectionGUID: KuaQveIRTWCUr5lV+uMsuQ==
X-CSE-MsgGUID: agjio9LBSTS8y/2GWoVHOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17699615"
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="17699615"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 06:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,168,1708416000"; 
   d="scan'208";a="48425133"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2024 06:32:48 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqYpC-00003k-0I;
	Sat, 30 Mar 2024 13:32:46 +0000
Date: Sat, 30 Mar 2024 21:32:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 5ca28d24aecd0809d93da2ea73a4f6e4b2ccfa78
Message-ID: <202403302106.p1Oe7u9Z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/fpu
branch HEAD: 5ca28d24aecd0809d93da2ea73a4f6e4b2ccfa78  x86/vm86: Make sure the free_vm86(task) definition uses its parameter even in the !CONFIG_VM86 case

elapsed time: 1434m

configs tested: 50
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
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
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240330   gcc  
x86_64       buildonly-randconfig-002-20240330   gcc  
x86_64       buildonly-randconfig-003-20240330   clang
x86_64       buildonly-randconfig-004-20240330   clang
x86_64       buildonly-randconfig-005-20240330   gcc  
x86_64       buildonly-randconfig-006-20240330   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240330   gcc  
x86_64                randconfig-002-20240330   clang
x86_64                randconfig-003-20240330   clang
x86_64                randconfig-004-20240330   gcc  
x86_64                randconfig-005-20240330   gcc  
x86_64                randconfig-006-20240330   gcc  
x86_64                randconfig-011-20240330   clang
x86_64                randconfig-012-20240330   clang
x86_64                randconfig-013-20240330   clang
x86_64                randconfig-014-20240330   gcc  
x86_64                randconfig-015-20240330   gcc  
x86_64                randconfig-016-20240330   gcc  
x86_64                randconfig-071-20240330   clang
x86_64                randconfig-072-20240330   clang
x86_64                randconfig-073-20240330   gcc  
x86_64                randconfig-074-20240330   clang
x86_64                randconfig-075-20240330   clang
x86_64                randconfig-076-20240330   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

