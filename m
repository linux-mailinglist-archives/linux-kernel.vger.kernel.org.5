Return-Path: <linux-kernel+bounces-39690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748DA83D504
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209011F29E17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B224B31;
	Fri, 26 Jan 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiKC20if"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5B24B29
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252859; cv=none; b=W6MId53wip7/2fbb3cYdB7qgCjNeWxbk1xX0Ncekn/mqFst/8WJD4eifM9gwIfGpJxX9gJd9zGco2/+FIiD+g0+4LselPRMImOJeYd1Kgx1u2CismBZk2xO4fLOPUs9bFHHmNL9LnDcbTWLy7/fZeOx5tFZUDHvscdymPeoUbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252859; c=relaxed/simple;
	bh=cqjiIKc6GABIWXQti+QbN24u0+OCA63fAqDut4utTgU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CgoC6bQw7txXuFIsrvYs8N+HQB1zm0cCBeBg62xMWqZtydRUIsGtSUKuQM36Kw3q06iq3BNp3QC7zxitq+XA8LL65wPHjyzMSrcz+/je5I3oKsNKRm8WNa5qKdikfxMzd09hcXl3CmFh62vxxxvnw1+JdZVTRA4lM3sNYXM0gSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiKC20if; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706252858; x=1737788858;
  h=date:from:to:cc:subject:message-id;
  bh=cqjiIKc6GABIWXQti+QbN24u0+OCA63fAqDut4utTgU=;
  b=IiKC20if9IvymbWra7ahMKteCqVj1sZ9EiOGDx/QOUVBbb/Q5HGNh35N
   BCAJxRt+2see0ohl7A4GZDM0uFcFo2K2CVBg+7UfXfHpfpp2Kez4qiiAa
   4O0AVoYkt/aIw9yViKOEmvSwsMNRRR5INb+BstU+wsxMT+1YSQsbzqqZ6
   92HjqyVx6tQGnaw+aqpijsQ2k1i/JNEquO5cX3aq7iHuTlJJl4OKZ+R5m
   9CuOR01CrRMJoG9gfsdGOwRXGbpy8eRKm5CJtkZ8JtzbFbnKEj+uLGKel
   UGVDtmqftfuQvTEsKQuE69rsDypn/9Aggn8bbbRXNIL/vXnCu5S3FrFuc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9086879"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9086879"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 23:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118188614"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118188614"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2024 23:07:36 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTGJK-0000nQ-1I;
	Fri, 26 Jan 2024 07:07:34 +0000
Date: Fri, 26 Jan 2024 15:06:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 0410516aaef4bf08030845547fb94f4ff989fac0
Message-ID: <202401261551.PJyMYkL3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 0410516aaef4bf08030845547fb94f4ff989fac0  x86/mm: Fix memory encryption features advertisement

elapsed time: 1993m

configs tested: 37
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
x86_64                randconfig-002-20240126   gcc  
x86_64                randconfig-003-20240126   gcc  
x86_64                randconfig-004-20240126   gcc  
x86_64                randconfig-011-20240126   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

