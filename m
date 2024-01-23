Return-Path: <linux-kernel+bounces-35449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D047D839159
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF9B1C25B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215A45FB8E;
	Tue, 23 Jan 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnKQvc9I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914695EE99
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020105; cv=none; b=Ew+UuKVSQR1RvRVjnCz1vLxNiiJV3v+6zJ7yRY2fgImtvTE+1mYIe+JTREugwLcyrGaXFdC1K/IoQImupVkJ7mqYVdt4PSjHLQZtOZZvk1W38u46qgohGBp9LVheLqGJctuWifyUxDyXJmHTEVNmygGo0BsU/LbLEodRksf9Njs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020105; c=relaxed/simple;
	bh=ytb3qR6YCTIxcqaqSBdY8XQn9ej5gMKGduXzks3Aua8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XEKG70aRLzx3rg3gdecV9v255VNjsiVIcn3r9hSupT3IZdGhnvtCfsXNzRDmXnTT/h10amMqcC4MnrqoOb44/C+82ml38W595syRqmXYd7s+0Yyt14Ad9IaRSJLF6V3m6Xrzfbje05Te8G8BIYpNAR8S7Npapo8LEQUoA7tXCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnKQvc9I; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706020102; x=1737556102;
  h=date:from:to:cc:subject:message-id;
  bh=ytb3qR6YCTIxcqaqSBdY8XQn9ej5gMKGduXzks3Aua8=;
  b=JnKQvc9Il4/XBs/wThaEjt3lh/XHCPd3+NzMTpy74uKTWCWzkG8lngT/
   TU8td08Sib+jEcYv9P+H7Ew0ybzNBOGsgrUceeWg/3NPdDax/x03ZJIG4
   VtW2aRY2uL9jyzI0bcsVkoiGB7DmrXFqN7ltsGpjIFzLot0Ofdc+fDFtF
   lGpWQdaQfBnPeN2OlTGvrqGXePg+5Tax3p+64o5TPnEXfpmPJ1V80lbMH
   gfKoMGN9AQrEMg7aaDVMuhBaBkHNFpE4Ca+0RcIFsZcwsW97F0GjzNWP/
   JxOhvb4kjzkqI58Oc7ID3QidiLJvODLWwkD6zqrDK66kwO6OTHxBaKYOs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8902997"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8902997"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 06:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1613771"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jan 2024 06:28:20 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSHlC-0007Tm-21;
	Tue, 23 Jan 2024 14:28:18 +0000
Date: Tue, 23 Jan 2024 22:28:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 1b908debf53ff3cf0e43e0fa51e7319a23518e6c
Message-ID: <202401232209.1Nd4epS2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 1b908debf53ff3cf0e43e0fa51e7319a23518e6c  x86/resctrl: Fix unused variable warning in cache_alloc_hsw_probe()

elapsed time: 1164m

configs tested: 26
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240123   gcc  
i386         buildonly-randconfig-002-20240123   gcc  
i386         buildonly-randconfig-003-20240123   gcc  
i386         buildonly-randconfig-004-20240123   gcc  
i386         buildonly-randconfig-005-20240123   gcc  
i386         buildonly-randconfig-006-20240123   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240123   gcc  
i386                  randconfig-002-20240123   gcc  
i386                  randconfig-003-20240123   gcc  
i386                  randconfig-004-20240123   gcc  
i386                  randconfig-005-20240123   gcc  
i386                  randconfig-006-20240123   gcc  
i386                  randconfig-011-20240123   clang
i386                  randconfig-012-20240123   clang
i386                  randconfig-013-20240123   clang
i386                  randconfig-014-20240123   clang
i386                  randconfig-015-20240123   clang
i386                  randconfig-016-20240123   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

