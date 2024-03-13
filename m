Return-Path: <linux-kernel+bounces-101082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A987A1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B251F23D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070E10799;
	Wed, 13 Mar 2024 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYJaRHH2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665810953
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710301967; cv=none; b=KYl2qXZ4U+9qTZwiJRMXLv10R+WuhJJeB53PEH4P7FUWQTFHuqaaFmWaLm6usnU59+D6Pc91+6tnlspAcnEFd4eboe/5UMhS9yubrCBksU6xsDjBWTWW5pkh22qT48BuaOH3zK2GMJLnwyA+QZ+Yi+yl+iShNMLtxh5n779mpq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710301967; c=relaxed/simple;
	bh=gZvPcW6n/yfAtfyfMh5E4nKXmKqa1CFn/bt2mZcJ5zI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LQ2YEJtHKzBMUbpg+2aFrpg9iqwY/ZW/mgiZSPt8E+EqBpAmNOC87CO7gKZtPe29Tkt1WDC1eBj5wYLsR09kEYCkDyX/l3/gAR6LKGgh2XJETzyVXf9zJCoVy3ftXQpkm06IROV8kMBBsarYF+IVHimdxKdHPrp7G+7OfaMsqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYJaRHH2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710301966; x=1741837966;
  h=date:from:to:cc:subject:message-id;
  bh=gZvPcW6n/yfAtfyfMh5E4nKXmKqa1CFn/bt2mZcJ5zI=;
  b=DYJaRHH2kBewVDEA/E8Fl1WATNcj9rg+9aUKz7FkiOA/E6Yw5hXTyZdR
   iuuxGUvLTLOI4h8suczs4U1KIkWjsjiYf/ModfdbwlifxjBuzvMwJd31p
   7x3OD/zsMnGmQK98XiY+IAB0Fy5loHH21m2uC35cn9scynh93d25bj96w
   QxJtunbKUVnnpcGuW8Y4o51Gg1PEo2C7JZ0ABEFpRZTow1/dASIIHwqkl
   66ggO5xc9wzYEuuFMhJ3Mej4CajBa9aOFbBaz9B1sgnUUH5dnGRyfW7lo
   TgmQ/bed6gxBFsswN/I1Bx0ciFfzV5pliu7RLGeRxul0FhddUm9t3Afnw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="30482767"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30482767"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49206223"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Mar 2024 20:52:33 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkFfK-000ByX-13;
	Wed, 13 Mar 2024 03:52:30 +0000
Date: Wed, 13 Mar 2024 11:51:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 532a0c57d7ff75e8f07d4e25cba4184989e2a241
Message-ID: <202403131148.RBgNnaD4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 532a0c57d7ff75e8f07d4e25cba4184989e2a241  Revert "x86/bugs: Use fixed addressing for VERW operand"

elapsed time: 727m

configs tested: 26
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-016-20240313   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

