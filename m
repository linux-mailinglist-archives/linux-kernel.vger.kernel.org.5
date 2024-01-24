Return-Path: <linux-kernel+bounces-36526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4583A261
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CB1284D05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD532134CD;
	Wed, 24 Jan 2024 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQ9CswgU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43EEFC11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079360; cv=none; b=iKieDXkV5ZwMDxhDw+6ay5l7lwMFQorog7gzth8//G7Z7/da+ADdrTVJenhqTZMEYwmLdK5UxVC4zas4XlHOTIFG9BApqW4cGW/guKTK7ycJ25+8uH70/ly2ttvZjc48gYe9mWkrTbbxgPaVoDk6ztiFWFw05UJpWOk2G6tqjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079360; c=relaxed/simple;
	bh=NwOzLDgAJptAHdn7w5sYCEauXgST9BfIHdOQJ1YURcg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sWCv4ZlIu/vhIGoIKaRuKIDp83Ob7IwP1JRGTHBBrlRbe1u0JXzOVL118r9+OG8JrNQvnfIxmfLpuHWjFpRb9ZXxYrW4VRpWtdcQcorvxPncTOF/qM1mlcMLNMExxozk3kG+9p0ORS1+wlSm3VSgiMN9/q6lsrFiGi1DXMtt9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQ9CswgU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706079359; x=1737615359;
  h=date:from:to:cc:subject:message-id;
  bh=NwOzLDgAJptAHdn7w5sYCEauXgST9BfIHdOQJ1YURcg=;
  b=OQ9CswgUgPqNaSUP9qWPPQUeiMiMrDdYCzaBmqUDlKWgi1sJvApDLGSN
   lauq7ZYxO7hvyXAARJs3A8FVMW6Kv9N8EoXrGnGGvESTebjtAcvl178Cf
   PGFcS1ei8GppZ25zx/rsyUIBlCazNwVJLUjXi/LX3p4fkPBUq48wwxoXo
   4mxBQAlRnPfGo+p0U/LOClMXCfIaa7JkAYXqFbzYNzV7Qn+Yku48+rKRE
   BrDUAKMigEgWrsvx/ttbQz4QWAm2WYyjCCIf6lgKPgCTEhfV46h9LbMrK
   0TcDz3WjT+kdDbHg1KxU5Q6BrWKOkyxx0Kw8NMaWC/WLUHZ7DJgoDU7yC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1603327"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1603327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 22:55:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1835225"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Jan 2024 22:55:55 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSXAv-0007x5-2G;
	Wed, 24 Jan 2024 06:55:53 +0000
Date: Wed, 24 Jan 2024 14:55:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 54e35eb8611cce5550d3d7689679b1a91c864f28
Message-ID: <202401241457.eXKnF2WU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: 54e35eb8611cce5550d3d7689679b1a91c864f28  x86/resctrl: Read supported bandwidth sources from CPUID

elapsed time: 917m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240124   clang
i386         buildonly-randconfig-002-20240124   clang
i386         buildonly-randconfig-003-20240124   clang
i386         buildonly-randconfig-004-20240124   clang
i386         buildonly-randconfig-005-20240124   clang
i386         buildonly-randconfig-006-20240124   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240124   clang
i386                  randconfig-002-20240124   clang
i386                  randconfig-003-20240124   clang
i386                  randconfig-004-20240124   clang
i386                  randconfig-005-20240124   clang
i386                  randconfig-006-20240124   clang
i386                  randconfig-011-20240124   gcc  
i386                  randconfig-012-20240124   gcc  
i386                  randconfig-013-20240124   gcc  
i386                  randconfig-014-20240124   gcc  
i386                  randconfig-015-20240124   gcc  
i386                  randconfig-016-20240124   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

