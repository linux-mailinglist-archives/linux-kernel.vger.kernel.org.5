Return-Path: <linux-kernel+bounces-31888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519868335F3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6230B21F04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A01172C;
	Sat, 20 Jan 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGQPCNRZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22710940
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705778815; cv=none; b=NJCjCut8ZtEFZkXCcfzMrSPF8I6FDEkVhZW7WkzTIomBHvI4fK0M08N8jYU3iLDXoEEXAbRtEotfVUJgG0j/x/dIsk7nRK+5nFAHWWInJyLBHkCqhxKtkFz2wxSPj35voSiB7jrQpNivTdmWYFzXolbkDYpr9awxq6bDkx6Ud0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705778815; c=relaxed/simple;
	bh=Mu/iABvyMCFK5VeHYHjoBnLdK7gWCkdv88Mi8DBd/BY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SgJT9VV/72KUIZHiFxvOkWHX6fITJPU0H3QbOCtJpIIgZakP1faSUJBF+cWUkYVjPFxVZYx+TLp3JWlk/8Y56T3wMGVFZlYo3+RJ0RYn9FtpUjIgwb5LOhLhItJ/V90B8s3CbQ8oMhQhfMRtzc0ROFEGlEPbnXQzDLrkQ6G2O7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGQPCNRZ; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705778814; x=1737314814;
  h=date:from:to:cc:subject:message-id;
  bh=Mu/iABvyMCFK5VeHYHjoBnLdK7gWCkdv88Mi8DBd/BY=;
  b=TGQPCNRZvV8QKcvEv3jjG8G98p/0jUX36bkf/ArQqBtAqFS16YCIunY8
   xeAsKl1bwW7ALBe8bwrF08AgLBaw/5h+Ng0cCddGT0NyQGK9740/fdeDg
   ykqvH4eYrRqL1BTBrIn09fEd8I+ZURNSgVLRRFUIs8pUHbTtC0ubWTpXV
   LwubJfcg/DTt8kDqy7kbWtgY2kbboQeo9wWb5jmVDW4NmcYeRygV7/vyO
   fPAKl/PsLoAjgP7Nm8deoNjJKMVx/kYbAT7MrZARPXitvQu4KuMDJP3h3
   dKOu6evIzS2mex+m51AFomq5uSKer4rWZr4Y5Xuxg/QepyWU+rIJOCJkO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="487108155"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="487108155"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 11:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="844727"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Jan 2024 11:26:51 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRGzQ-0005O8-36;
	Sat, 20 Jan 2024 19:26:48 +0000
Date: Sun, 21 Jan 2024 03:25:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
Message-ID: <202401210344.0q9eX1fw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09  tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

elapsed time: 1634m

configs tested: 97
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20240120   gcc  
arc                   randconfig-002-20240120   gcc  
arm                   randconfig-001-20240120   clang
arm                   randconfig-002-20240120   clang
arm                   randconfig-003-20240120   clang
arm                   randconfig-004-20240120   clang
arm64                 randconfig-001-20240120   clang
arm64                 randconfig-002-20240120   clang
arm64                 randconfig-003-20240120   clang
arm64                 randconfig-004-20240120   clang
csky                  randconfig-001-20240120   gcc  
csky                  randconfig-002-20240120   gcc  
hexagon               randconfig-001-20240120   clang
hexagon               randconfig-002-20240120   clang
i386         buildonly-randconfig-001-20240120   clang
i386         buildonly-randconfig-002-20240120   clang
i386         buildonly-randconfig-003-20240120   clang
i386         buildonly-randconfig-004-20240120   clang
i386         buildonly-randconfig-005-20240120   clang
i386         buildonly-randconfig-006-20240120   clang
i386                  randconfig-001-20240120   clang
i386                  randconfig-002-20240120   clang
i386                  randconfig-003-20240120   clang
i386                  randconfig-004-20240120   clang
i386                  randconfig-005-20240120   clang
i386                  randconfig-006-20240120   clang
i386                  randconfig-011-20240120   gcc  
i386                  randconfig-012-20240120   gcc  
i386                  randconfig-013-20240120   gcc  
i386                  randconfig-014-20240120   gcc  
i386                  randconfig-015-20240120   gcc  
i386                  randconfig-016-20240120   gcc  
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20240120   gcc  
loongarch             randconfig-002-20240120   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20240120   gcc  
nios2                 randconfig-002-20240120   gcc  
parisc                randconfig-001-20240120   gcc  
parisc                randconfig-002-20240120   gcc  
powerpc               randconfig-001-20240120   clang
powerpc               randconfig-002-20240120   clang
powerpc               randconfig-003-20240120   clang
powerpc64             randconfig-001-20240120   clang
powerpc64             randconfig-002-20240120   clang
powerpc64             randconfig-003-20240120   clang
riscv                 randconfig-001-20240120   clang
riscv                 randconfig-002-20240120   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240120   gcc  
s390                  randconfig-002-20240120   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20240120   gcc  
sh                    randconfig-002-20240120   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20240120   gcc  
sparc64               randconfig-002-20240120   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20240120   clang
um                    randconfig-002-20240120   clang
x86_64       buildonly-randconfig-001-20240120   clang
x86_64       buildonly-randconfig-002-20240120   clang
x86_64       buildonly-randconfig-003-20240120   clang
x86_64       buildonly-randconfig-004-20240120   clang
x86_64       buildonly-randconfig-005-20240120   clang
x86_64       buildonly-randconfig-006-20240120   clang
x86_64                randconfig-001-20240120   gcc  
x86_64                randconfig-002-20240120   gcc  
x86_64                randconfig-003-20240120   gcc  
x86_64                randconfig-004-20240120   gcc  
x86_64                randconfig-005-20240120   gcc  
x86_64                randconfig-006-20240120   gcc  
x86_64                randconfig-011-20240120   clang
x86_64                randconfig-012-20240120   clang
x86_64                randconfig-013-20240120   clang
x86_64                randconfig-014-20240120   clang
x86_64                randconfig-015-20240120   clang
x86_64                randconfig-016-20240120   clang
x86_64                randconfig-071-20240120   clang
x86_64                randconfig-072-20240120   clang
x86_64                randconfig-073-20240120   clang
x86_64                randconfig-074-20240120   clang
x86_64                randconfig-075-20240120   clang
x86_64                randconfig-076-20240120   clang
xtensa                randconfig-001-20240120   gcc  
xtensa                randconfig-002-20240120   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

