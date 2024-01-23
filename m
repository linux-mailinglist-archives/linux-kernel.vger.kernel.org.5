Return-Path: <linux-kernel+bounces-35225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CE838E17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A271F227DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071885D91A;
	Tue, 23 Jan 2024 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhjLmWkt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39935A114
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011339; cv=none; b=SygudQmG+cso7qJ58j1CpN3LM4h/S3fuUGpCF2iuUEMlpte7kgRr6xkV7mzhqXVluzCDENwscr6gBZQ4hYkfDNED0tFlID9TE10uYPlHn3ES3iDuEAFBQogZYVbvvChq8s2GhLcYygN/2Fs2OnMSZOdJnSSNB9FkXT0mZwMvwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011339; c=relaxed/simple;
	bh=eBxvL0FskliNF3MYbdd6J8yZYsyPwT24b+0yA980GW8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SUxCc8g9Z45riSrdcoZgJjuWxY5qPz0EhWtWjf4OrCfFgOacSpTD2qy4wKVfWmMicoPavGUZH8jM9p5e1KY+5fpY1gAm59smjCpCIX++fbeBKGGO5kEZgggFdyozaq+oX8tfmcFmcNbYiC2Nina/iYqZAME9g087hq8p8uUyAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhjLmWkt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706011338; x=1737547338;
  h=date:from:to:cc:subject:message-id;
  bh=eBxvL0FskliNF3MYbdd6J8yZYsyPwT24b+0yA980GW8=;
  b=fhjLmWktRZCfkWglRHSajP2tmJOiY84j/GhDmg6C3YX5ys2ngPahjFHI
   K5AFdzW0Dg2hc9sCSW6OQM/s2cUWAs05ZOZ8wVDX8f1s4ydNygGyjmznS
   s0Ao5HatfYLd4DSKsxfUBLrpeub/5YVyHWUM6Epaujj/zWBdgF0ro9nh5
   1Z/5NYc11tjL84OiMq3nqOv9ZPd6FsNbDJ1lPlr4FemTy+ZY1ed4PPXbL
   u0L2Y3W0ab5WA4pbU+5ncubvh9t6IpKkFV0waWsaf+jHLA4GVddmz3g3k
   0iaowO6tclxGhzMvVV8ZEn1cUIXnXBAwV8AwxTN3RJTizUNb88kRBimUy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8891260"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8891260"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 04:02:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1652113"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Jan 2024 04:02:16 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSFTq-0007Oz-0J;
	Tue, 23 Jan 2024 12:02:14 +0000
Date: Tue, 23 Jan 2024 20:02:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 df38347f1934b29d4b3075a53a6404b0d58dcb2f
Message-ID: <202401232002.4AOq0oYQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: df38347f1934b29d4b3075a53a6404b0d58dcb2f  x86/sev: Harden #VC instruction emulation somewhat

elapsed time: 1318m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240122   clang
i386         buildonly-randconfig-002-20240122   clang
i386         buildonly-randconfig-003-20240122   clang
i386         buildonly-randconfig-004-20240122   clang
i386         buildonly-randconfig-005-20240122   clang
i386         buildonly-randconfig-006-20240122   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240122   clang
i386                  randconfig-002-20240122   clang
i386                  randconfig-003-20240122   clang
i386                  randconfig-004-20240122   clang
i386                  randconfig-005-20240122   clang
i386                  randconfig-006-20240122   clang
i386                  randconfig-011-20240122   gcc  
i386                  randconfig-012-20240122   gcc  
i386                  randconfig-013-20240122   gcc  
i386                  randconfig-014-20240122   gcc  
i386                  randconfig-015-20240122   gcc  
i386                  randconfig-016-20240122   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

