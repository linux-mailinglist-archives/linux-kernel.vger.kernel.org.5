Return-Path: <linux-kernel+bounces-36282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695EE839E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000D7289FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD015AB;
	Wed, 24 Jan 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqMUvpFE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D021841
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060569; cv=none; b=j8F3tmLLC4ZoLpHLNqZV1VOJEXMZ6uF/kqz3Xk28uRhBc5CelKnMA1bY8/YTq9Vuag4MpI2Ltq5ygT1kp4WuhtyRAfDcq5o7/E4Jrm36eFUJUgS8xIMAK1AGlCg7gp+jRexCRbCSnhEDZ1p/s2zGFiuONeU1dnUw8e82EdqmOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060569; c=relaxed/simple;
	bh=Wi0dBOunA4YSez/cdE83nXy8S01fE4+/kRqg1Lt2dZM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KR3fD/xia7vMxBY68BeuZyae3x3YuqmiTIwL88DKdtsACMSOGtBP9Bqizo/AZcs3Xs58RUxgkRgNfoHNUF9dJS92VMtjTQH50CGyKRo+1cUQdmh8GciJ7jeYCMMUPCjjToAbgl9OOAX/eOVaj10aj8MODPuzzaqfcZijZ78k0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqMUvpFE; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706060567; x=1737596567;
  h=date:from:to:cc:subject:message-id;
  bh=Wi0dBOunA4YSez/cdE83nXy8S01fE4+/kRqg1Lt2dZM=;
  b=XqMUvpFEN/RvyEjZMz2tQS+oHmjJUcZlgxo+ibOHbJzXJj347Fj9Q9h9
   Qks/w9QsYqtb7xVIodDaCr/IYwx+l0uFEfcejxpgnZGzvhX9EEr4tmNHE
   KYA5EaWZRE43vuLCI9U0z853LGqQd66xZ633ZwEgu9cpzSsnQ4Dx68u5/
   6JLWXbNV5UZbWdBV8LzymafSkZmsXtYycRCdKXjkIYK5OXrHyBO0ItyVZ
   ULMmVDmMknypzPrbkCSA2iFoNZhMsl+7goszetarsMofX71sTO6aRVDmn
   xL4CECCrUf/wEUDtpoCsPyUM1YPDdqraZgAFSWZDVGIDzkiVeBX4jUy+C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15225447"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="15225447"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:42:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856521308"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="856521308"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jan 2024 17:42:45 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSSHr-0007m7-24;
	Wed, 24 Jan 2024 01:42:43 +0000
Date: Wed, 24 Jan 2024 09:42:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 090e3bec01763e415bccae445f5bfe3d0c61b629
Message-ID: <202401240901.JYDQz2oB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 090e3bec01763e415bccae445f5bfe3d0c61b629  x86/cpu: Add model number for Intel Clearwater Forest processor

elapsed time: 905m

configs tested: 26
configs skipped: 135

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

