Return-Path: <linux-kernel+bounces-95090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97D874922
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4EF1C210FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAAD63126;
	Thu,  7 Mar 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQOOayik"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C296311E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798092; cv=none; b=K0AuJUKQLtuwb4VyJ1k5s2KQWcOdWSo4M4ljBpTDH22qJjcyjzsTp7RHLMKUumjeiW5f0exSHEYj1OJFqktgG3K7C9pE9bDYOhDV/MJPIfhJkekXdwMFct0uQYzMsM5HNHICHORQaCKqf/RJoQiqXk5APGJt3Aq0DJVvJcl7HGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798092; c=relaxed/simple;
	bh=CqwOWoWNw0ieGVOXwJr8cB5tbHogPlpIwoBhb7KAolM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=obsGZWkiV9cacNGNitS/GYjoeNlBgbHF+4AwrNmNuuGihE+wKpEug3KOXbrKECvZ45lNOwHbHVkm/0uzKoYxbhJFOpIagmLqrKQRcicn75uWmdgCyQ/Fninun//XmZq3i6IqV063RbQ8tKtH3kqOCRJCupEer9aIYgZolCKz6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQOOayik; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709798091; x=1741334091;
  h=date:from:to:cc:subject:message-id;
  bh=CqwOWoWNw0ieGVOXwJr8cB5tbHogPlpIwoBhb7KAolM=;
  b=KQOOayikGwbQJWEZuUe/JymHVGGR7wOV1j41nvqyEqM+Z/mvwjPIiQO9
   cJNJ+DzpioSlXr6GiJJyogRvfU/UP6eYu6U5h7IEn/DMDtM86KelNsDji
   DhoKQ2o8uGo0pB5MjsPldtfsNQhSvGjHSMMBZ8KpKQFFY0ACi/L1oeMvg
   X0cShYlwmJbKx/nCIaHeWIwAQDYuFwRjcKDYLKJdaM4KmhV1cTz5Hf4S3
   bvcmr/mNaq19pQwUT911519J/OkRnTlVUI18e+n0KMW+64/t+vmzDa1Lp
   HrudRGP4KzfcpYj3HSr3y3sUTN8IqNieHg6Frt7or45e/+dvmuV1lraOi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8212081"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="8212081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:54:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="9934725"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2024 23:54:48 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ri8aU-0004xf-1t;
	Thu, 07 Mar 2024 07:54:46 +0000
Date: Thu, 07 Mar 2024 15:54:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 f0551af021308a2a1163dc63d1f1bba3594208bd
Message-ID: <202403071504.9KMPrJIW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: f0551af021308a2a1163dc63d1f1bba3594208bd  x86/topology: Ignore non-present APIC IDs in a present package

elapsed time: 1090m

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

