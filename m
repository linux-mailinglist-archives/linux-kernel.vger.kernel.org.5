Return-Path: <linux-kernel+bounces-39474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CF83D1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871551C234DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10A64C;
	Fri, 26 Jan 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dipvlT0t"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562F4683
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230409; cv=none; b=WiUgOel2Cg65wdxu4lzH7hLJPO4LXWPb7e501x1+CjihKqvTBKWydmsGR/K2dp4l1eu3Q5uA6TY1pR10rA0aPc2ieloN4EmquToTyuEd98E2WTcqvdnrKe1PtdjjKtd/ZFxo3xhUyUCL+XcvXDOQofMqoj8rvfk6fVjsmx7reW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230409; c=relaxed/simple;
	bh=4Q2OyuqhqVfd1/vLfYpv2M3lR42Vhr16p82c5QuxgDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cz+9tYSMuDQVf20AsucjizSvRU5OdcVZx0SKs5unbSJRN39FGQY5UsT6/roU5H2VZMrDh2DLIajIOSxDG9zlcSSyUn2wHmdkqAQnz6+YI5N8Hh2AYxug+ydZhVpXJX+jH6qIzvEnLSa8LCE6rotZkhjg06iB+l62++ZGEuBztO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dipvlT0t; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706230407; x=1737766407;
  h=date:from:to:cc:subject:message-id;
  bh=4Q2OyuqhqVfd1/vLfYpv2M3lR42Vhr16p82c5QuxgDY=;
  b=dipvlT0t1HACn5947EhvkekQFdz9txoZ7MCDSmLbPCm4qAS80Z44WDpm
   YMf/lP7CPGu9JIeUIWoSY2VNqrAvmW7LqAtT/VOENf1hujrxLqkeXKyC3
   A8M8PmbrSXYOcn6ftrlN1IzihRcpzjoZLWVrPlm4JB/W6WMENUN51L71c
   VetQznPvTagvwwHKFFpgKNmX+nik6oOkXxiLEeV8Jhhqyqd3a6P8KEKhL
   h4tUSK/5lqlcd190Ixc743cUU/NlncKdxGPf/IW2ukwzoD45snAMq0RHi
   aE40deh04JG2vtteAHfQuptftZ/U8md9/Od8hQOvHCwMGDkHOIfpxzYxj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433505229"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433505229"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2525077"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 16:53:26 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTATE-0000Xa-0W;
	Fri, 26 Jan 2024 00:53:24 +0000
Date: Fri, 26 Jan 2024 08:53:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 bb998361999e79bc87dae1ebe0f5bf317f632585
Message-ID: <202401260802.Pvmrh0xe-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: bb998361999e79bc87dae1ebe0f5bf317f632585  x86/entry: Avoid redundant CR3 write on paranoid returns

elapsed time: 1799m

configs tested: 33
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
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
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

