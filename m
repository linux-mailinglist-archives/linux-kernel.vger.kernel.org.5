Return-Path: <linux-kernel+bounces-94985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB18747AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E1E286CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C21BC3F;
	Thu,  7 Mar 2024 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfTS1Ije"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98C1C6AE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789989; cv=none; b=hT6qhjYcz7tWnNVm8yS8L1AFWI/LNM4/TINMW26JGvOPPvMs94z4dvjcG9nYvjzFZ8B1+65wV+3k9kJFRDmJItS6SGVs04WAeIULxEucVmBhOU8kG9LEttA71qH7t95Uv2fPCNkPhmgT7Ocf4RftMN9EiX+nFasJhVij31/NLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789989; c=relaxed/simple;
	bh=z9HmzmIBJzf9JsqxEZqH2JF456gDySwYrC/lWkwz0Jo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=p5xj6TIJgLFQkO40iDSrvQGiGNf35Tpvmd+QpUOLCcbm3kMJhXi0kItoB7iw5qwE9ghsQPj+6ad376OWguS/fIZPMNO8REwbIoMLCUc3cDRgcHXnYy6++V20jXcXfo0/fH2meNak6oQXyKma5svjuszbF/y7L9h4ZiWTulvTwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfTS1Ije; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709789987; x=1741325987;
  h=date:from:to:cc:subject:message-id;
  bh=z9HmzmIBJzf9JsqxEZqH2JF456gDySwYrC/lWkwz0Jo=;
  b=DfTS1Ije7p7EhbRPTUH5NO2x3SiWZdoPxRNpFDN3NvnGN99y/6enkol9
   +OLtcBKkosZG/4/guTwVcnnkxWeV5c3uEMWPdlIThBv4HI3ZKo5pp7p4y
   618SprcDEH+iwAvJjqx7iSxWsDfV9WoHeVGM5OJ/OdX0izYUfv7mu2FAY
   KZlVwPlv/0kITPctsen5V21R388vmp2FllaxULONXqZcXcoFZvu2j60x3
   SodF/eIFYfHN94TfTDXpnWKF5ihJHxn6FV0ci13nckIh6wBBxCsXsjhst
   5ccfOPN6yq8YyZQhb2LMsVnXwGGsJX8hghAY6tHB2kvCj64rt557qqXm9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4311517"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="4311517"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 21:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="10083184"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2024 21:39:45 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ri6Tm-0004qP-22;
	Thu, 07 Mar 2024 05:39:42 +0000
Date: Thu, 07 Mar 2024 13:39:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 774a86f1c885460ade4334b901919fa1d8ae6ec6
Message-ID: <202403071335.wE2x5W3K-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 774a86f1c885460ade4334b901919fa1d8ae6ec6  x86/nmi: Drop unused declaration of proc_nmi_enabled()

elapsed time: 1215m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240307   clang
i386         buildonly-randconfig-002-20240307   gcc  
i386         buildonly-randconfig-003-20240307   clang
i386         buildonly-randconfig-004-20240307   gcc  
i386         buildonly-randconfig-005-20240307   gcc  
i386         buildonly-randconfig-006-20240307   clang
i386                                defconfig   clang
i386                  randconfig-001-20240307   gcc  
i386                  randconfig-002-20240307   gcc  
i386                  randconfig-003-20240307   clang
i386                  randconfig-004-20240307   gcc  
i386                  randconfig-005-20240307   gcc  
i386                  randconfig-006-20240307   clang
i386                  randconfig-011-20240307   clang
i386                  randconfig-012-20240307   gcc  
i386                  randconfig-013-20240307   clang
i386                  randconfig-014-20240307   clang
i386                  randconfig-015-20240307   clang
i386                  randconfig-016-20240307   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

