Return-Path: <linux-kernel+bounces-60519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83448505FD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AC01C23E70
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993845F48D;
	Sat, 10 Feb 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrhZ/cAQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFB55C8FB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707590259; cv=none; b=f2nGhDOg477cJgRzZB+KcqBI6KU1DiqRPk3KY4VQPf7rwvi9Tv+0zNsCf2l7GnnBjt8tlpMsW0b74y6Sx3cmrgPwhu/xWNmpqFoOW2TG3RoF8cTSsLFJQeoCFJ8/7RJB0B9/bFDGze9vc0m0gKSDcwNxSl7ZlQW0iiMMZSjtBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707590259; c=relaxed/simple;
	bh=TyCBIa00afGI1o/LIPkFLksms0eOVo25rxY0WLRZmnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J/dM/22jkbhEAe7edjHRmjZsaIY7mPbpJowcsdbEFwuxDkKgeOWIq4Lav3iwABdyrUNb3N+UnFS2YYjp9m7l54YbQZ0+s5gitGDhELSrLqFFZHgH2au4k0SkGBOCTEoMYlPMZRJ0xCBmWKT1na7CS2mk7vdouXHuF6OZgqTXPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrhZ/cAQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707590258; x=1739126258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TyCBIa00afGI1o/LIPkFLksms0eOVo25rxY0WLRZmnQ=;
  b=mrhZ/cAQAOSzT/qKZIKU1u8kafZ0RFd0PBFeonwUog79El+f+ku2v3fm
   Dm/JaxCuLE/nnZTVtFKOWmbXXNJRgZgn4HiLWvdCHuePdn0M1VWmeYS6n
   UrhxkXE+neH/0ytdQlb0LpUydqAbhHXB1zdDD6OurIMP2xWkYKMbQ/W+s
   7v8nBA8/4rVUe637dbIQEK9DTX4U6AETDBOd0yjMs761FC3UdZGGXEWQb
   vspyHdpm6KKLypBufo1+3vOn0aCp9095WJzrJmPdl1tY7teZnneoT8UHm
   RW7PVoXfzY5iG3oLJ8k2/XZPrNJqVfoyQv4CZKBhuIQmzq672/Q5atjY+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1721562"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1721562"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 10:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="33290544"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Feb 2024 10:37:36 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYsEH-0005yw-08;
	Sat, 10 Feb 2024 18:37:33 +0000
Date: Sun, 11 Feb 2024 02:36:37 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/include/asm/hugetlb.h:15:42: error: static declaration of
 'arch_hugetlb_migration_supported' follows non-static declaration
Message-ID: <202402110258.CV51JlEI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a5b6244cf87c50358f5562b8f07f7ac35fc7f6b0
commit: ce68c035457bdd025a9961e0ba2157323090c581 riscv: Fix arch_hugetlb_migration_supported() for NAPOT
date:   3 days ago
config: riscv-buildonly-randconfig-r005-20220804 (https://download.01.org/0day-ci/archive/20240211/202402110258.CV51JlEI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402110258.CV51JlEI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402110258.CV51JlEI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/hugetlb.h:851,
                    from kernel/fork.c:52:
>> arch/riscv/include/asm/hugetlb.h:15:42: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hugetlb.h:916:20: note: in expansion of macro 'arch_hugetlb_migration_supported'
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration of 'arch_hugetlb_migration_supported' with type 'bool(struct hstate *)' {aka '_Bool(struct hstate *)'}
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/hugetlb.h:851,
                    from arch/riscv/mm/hugetlbpage.c:2:
>> arch/riscv/include/asm/hugetlb.h:15:42: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hugetlb.h:916:20: note: in expansion of macro 'arch_hugetlb_migration_supported'
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration of 'arch_hugetlb_migration_supported' with type 'bool(struct hstate *)' {aka '_Bool(struct hstate *)'}
      14 | bool arch_hugetlb_migration_supported(struct hstate *h);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/hugetlb.h:15:42: error: redefinition of 'arch_hugetlb_migration_supported'
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/mm/hugetlbpage.c:429:6: note: in expansion of macro 'arch_hugetlb_migration_supported'
     429 | bool arch_hugetlb_migration_supported(struct hstate *h)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/hugetlb.h:15:42: note: previous definition of 'arch_hugetlb_migration_supported' with type 'bool(struct hstate *)' {aka '_Bool(struct hstate *)'}
      15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hugetlb.h:916:20: note: in expansion of macro 'arch_hugetlb_migration_supported'
     916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/arch_hugetlb_migration_supported +15 arch/riscv/include/asm/hugetlb.h

    13	
    14	bool arch_hugetlb_migration_supported(struct hstate *h);
  > 15	#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

