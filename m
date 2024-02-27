Return-Path: <linux-kernel+bounces-83408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F70286989C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B21C211EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F045FBB3;
	Tue, 27 Feb 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPWcfp+0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DB41C60
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044956; cv=none; b=M9PcW2SqGdfJDxjt6j+V0Z4/ekHIt/lgOUgj2dAu4tfBUq92ViArp622EDujuq4/baojPU8pCcD6k3Ci+8pRtrzp2nsCN1Q8iFNjAHRNp0qRQXbIcKbk95m2dSqe8EDNSyPLDk75sJofZjeJ3hVxT4ZSGTIUPmyS26ox5PqiCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044956; c=relaxed/simple;
	bh=wXnlQ3jcts2J2aREDlyWJZlQNc/h9y1i8LYJmlWIUeU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OpPEN1X92FhzvNAXoosvjPL9jc4v5lixvVdTt+4M5wGTf70xqVgQEy+Tpf92Sim2A30tqEg4z/tx89uVXJ2mdGoU7Xn37KSrrNjEYA2ev3940TjGd93wQcmbzsjwkBestyQtL4P9n2zi8zbjqEiV/MrqgBdF3HqvMX2Cx1PYh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPWcfp+0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709044955; x=1740580955;
  h=date:from:to:cc:subject:message-id;
  bh=wXnlQ3jcts2J2aREDlyWJZlQNc/h9y1i8LYJmlWIUeU=;
  b=SPWcfp+0EkC6QbUHQhH7acXwhocWAm03zugRH8BPvWBj/PvFeZViQ7jJ
   F8yvFhYOmvJR2ehwaqZHBOmn1vHp3sVgIiZk/Qzam3g6gw0cyZ8+VxpDm
   RjAuIyysmbqf+7s3n1+p5BzPdGroLuYmXmDXKModu340RWZUKWqUf5iQl
   R70feZwmx3pBQLS8oBzKkh5VkwWUBOy4j3LBK81SY0SQePMYUGCmejn8x
   7OZGCV8H4aUSWNqz06sbSBVKSfbHd7jn5FJwmjHTK3lyZ0QX4FTEDVUJu
   TIvvTPMenlt95TYjJgjC4d7AHHlJlPdM9wWEn8ntXWbDyRWEmn0qFHE1u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25852460"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="25852460"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="6927173"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 27 Feb 2024 06:42:32 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reyeN-000BGx-2x;
	Tue, 27 Feb 2024 14:41:50 +0000
Date: Tue, 27 Feb 2024 22:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <202402272235.0JbVhSr4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d  x86: Increase brk randomness entropy for 64-bit systems

elapsed time: 903m

configs tested: 12
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240227   clang
x86_64       buildonly-randconfig-002-20240227   gcc  
x86_64       buildonly-randconfig-003-20240227   clang
x86_64       buildonly-randconfig-004-20240227   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

