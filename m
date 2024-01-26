Return-Path: <linux-kernel+bounces-39761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C27883D5D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00AD1F2678A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5C91AAAE;
	Fri, 26 Jan 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzZz63hZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E81170D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257665; cv=none; b=ggFUnCk6Ra7+bQHhk8h0iD71Ltr0llu8/fYBY57LouN61EcRGmdZ8UeeZunZCOrDN3A3PUsdaOMYSgvM9GtTD5x7S+BkiULlDKPIBV0F+yS4T2dOVq023jzeLH4Vp6+9nDacEQB0UV4PvHetAhlEspguCTZ/AaxWXztbthLGmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257665; c=relaxed/simple;
	bh=Pz8EVbI/8pQ+4EK9cCQHwOzHuPCmC+oILjc6nVraQV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fQJtCU+QAZ3fYj3GPDXr2Of5T4ZF98jcgmm4k9CzkJB9MP6XxvrUPQ1Jurwr6sSMAVwSM2F4FqE0W9VvUKyhcDUnqRr/N3fscW8uke7bs38P2mITMtKhKXf4VEBPOHCBOEt75trY9xGe3WxT/tAeycq11psvd4RznaFcUzKFFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzZz63hZ; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706257663; x=1737793663;
  h=date:from:to:cc:subject:message-id;
  bh=Pz8EVbI/8pQ+4EK9cCQHwOzHuPCmC+oILjc6nVraQV4=;
  b=ZzZz63hZU6E2TnJdXQD34ByTy3WVLSha4Dia4c+xEvFaak1HiD8V8VG6
   9zDueZuKpLWjZNM1k4VJ4kiaR1aWZ092Cia5oitC8sjKvSGnoU3qRmgSc
   gj6ZTyfgd52vpvYThszoDVxh3rj9BriMya3NNcMX+Rd1GQLmtv4c7cv8J
   u7ZDuMHgmcTDMfettfBNNh4bWQAoTK4hRYh1EFxMT9u0E0JlhoVEPn7gv
   87kV5aF4Mg0yVgz6Nb0bJ8/goWpBAtvW8P7LkXAHmCMkpOwkgHzbvtxbp
   rygQN8kOu81N8k2oR8NYCdYM+aZMa6IJz1iMy0jItkU+yYnzecwN7mRyO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401268812"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401268812"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 00:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910270100"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910270100"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2024 00:27:39 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTHYm-0000qM-0e;
	Fri, 26 Jan 2024 08:27:36 +0000
Date: Fri, 26 Jan 2024 16:27:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 fc747eebef734563cf68a512f57937c8f231834a
Message-ID: <202401261616.wuWH8Oo1-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: fc747eebef734563cf68a512f57937c8f231834a  x86/resctrl: Remove redundant variable in mbm_config_write_domain()

elapsed time: 1953m

configs tested: 27
configs skipped: 134

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
x86_64       buildonly-randconfig-003-20240126   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

