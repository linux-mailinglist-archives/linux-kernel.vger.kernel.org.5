Return-Path: <linux-kernel+bounces-125950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3111892E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840411F217D2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4D4C79;
	Sun, 31 Mar 2024 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azWMr8SU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4064411
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711858038; cv=none; b=NfezCpkTgvdZ9HeYGERchf5w9MwCAarNk1Ln5BPQeKP/8mn1/AdYuNsEzRT1c/MGMa+fMt7j9bWsOWgY6TGo9F3BHXOr5qq2kDGtXqgdXz9X5BwrmSW8bC9p+vuVVDtpr3sMGE2vbyo9YW7R5rI8HHIpQsNP1rofL5OK2MMgyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711858038; c=relaxed/simple;
	bh=mPz+Os2RFHaXbk+Azdj9FubTfNcrMG0pymC5+OcMrx8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P7Q6xjxqM5yR0L5gV3FPFK7h6bsI+QtRGAV9+iAgNQl49eS9A5XDGO9U/7GN01xmlba366PWVsgvlmuVa8WcOSRwrnEpPrWoFygz0SqgppaRnHts/IFpz8kH9UMqkDI5VSuqbc04lZs42QiY69aqQFWteT9DjIbdvTgm7MUFfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azWMr8SU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711858036; x=1743394036;
  h=date:from:to:cc:subject:message-id;
  bh=mPz+Os2RFHaXbk+Azdj9FubTfNcrMG0pymC5+OcMrx8=;
  b=azWMr8SUwwCj42GZLpVvcnYyyLdLMSK7BbWNqiiE26C+pA8Ko37Nqzw2
   JehV1k94mTvi4hPXduEuaXHoonuFkH7aXRdtym1l95WaJS5ay9AyMHfN/
   TK/7lZ0rP46RgCh7hA3o3OO2lhHd8QEv0qvrYT5XGNXAvdlLoS6T1y+r3
   +g3mCkvw9Bpx+je/wncZKi54BRssIpYfAAoffiSMV+UqL5wz6HswZcVNO
   ydHnBrnNJCW35Yg4f94o/TnUjreBU+4p9Y+kTdA0hhZMxClKF31zZ665m
   AjjRlgUjoil1rIfIFPb4tsnSnCSmmzsXP/PJSs46GCpBmTaj92k/xEvNY
   w==;
X-CSE-ConnectionGUID: XgT4h9fASPSDcMfVcdEf0w==
X-CSE-MsgGUID: 7jLN28ZYST+v1+lPRH+4Gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="10821187"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="10821187"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 21:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="21808663"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Mar 2024 21:07:14 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqmTQ-0000mE-18;
	Sun, 31 Mar 2024 04:07:12 +0000
Date: Sun, 31 Mar 2024 12:06:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2
Message-ID: <202403311221.07LB0q0D-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 3f1a9bc5d878004ed4bc3904e5cb9b7fb317fbe2  x86/build: Use obj-y to descend into arch/x86/virt/

elapsed time: 1089m

configs tested: 26
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240331   clang
i386         buildonly-randconfig-002-20240331   clang
i386         buildonly-randconfig-003-20240331   clang
i386         buildonly-randconfig-004-20240331   gcc  
i386         buildonly-randconfig-005-20240331   gcc  
i386         buildonly-randconfig-006-20240331   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240331   gcc  
i386                  randconfig-002-20240331   gcc  
i386                  randconfig-003-20240331   clang
i386                  randconfig-004-20240331   gcc  
i386                  randconfig-005-20240331   gcc  
i386                  randconfig-006-20240331   gcc  
i386                  randconfig-011-20240331   clang
i386                  randconfig-012-20240331   gcc  
i386                  randconfig-013-20240331   gcc  
i386                  randconfig-014-20240331   gcc  
i386                  randconfig-015-20240331   clang
i386                  randconfig-016-20240331   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

