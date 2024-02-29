Return-Path: <linux-kernel+bounces-86028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282E86BEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA542B243CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546B364D2;
	Thu, 29 Feb 2024 02:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Irf3Cpqk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AF1EB42
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172416; cv=none; b=t4Uyk5+DSVVv9Jk5m9PJn4hqW1UAk86du65yR9q9xLHgI+Hd5XSeUpbFzZ5QANrP2wHjGzvLVzMAj/KafAdSAdI+7Vd4BPKO/ix2KRDhg+YYUTLGlnCKt7uJJbBa9WiGRZ42UsIH+Z77TB+pWweV2lBIgvs05tlduuLJGQyuIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172416; c=relaxed/simple;
	bh=BuSkLRb4QPldzejb8HpzIiarRIskIn0qMKWYCYBJYHw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Br/T94qENMZqLaMbnJnBVT05YhkZj7JzVWAdqh+KI+WgFKW60HlNikpGT0BV5DFLzI1mOiyP5y3QilSt4+p0nJCoDKsUy6CqmUqeNqDoIFEK5X3UDTrPzbTueIWZbwvApQxAjKIhFMcCkaoco8ZmFCgAN5IdkOI/yjJE815HnwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Irf3Cpqk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709172415; x=1740708415;
  h=date:from:to:cc:subject:message-id;
  bh=BuSkLRb4QPldzejb8HpzIiarRIskIn0qMKWYCYBJYHw=;
  b=Irf3CpqkI/mJHIvc9ZJ+wAZdi2z9cW3wi1w/6cX0NnYPAEJEWPo51Ig/
   8oKudNmcabhzsfHdldzEqgaIyve/TjT3vtCtgWFJlnyNxBgxH3d4kzW5/
   HmEfGz274+mmZHCTHx5AfiZeKzx8wDK79CTVlmTLMRyG999vD7ZAVOEkn
   EWx0pvzIS8ZwDUF8twcMx3TZKSNotjQSfEscGo4hsF7UUP/+HYmWcmSjT
   P/mcNIcwXPISvpq2xY2BSvE1A9zY8o5uFByWVs2GypsYQ6dXYA+I2wtEQ
   3jc5ATogNier6jf9mZOiUvTskbOYOxPrs1k9e1MNrpfXiNdEYy/YWeTsf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3783746"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3783746"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 18:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7691647"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Feb 2024 18:06:52 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfVow-000CZb-0r;
	Thu, 29 Feb 2024 02:06:50 +0000
Date: Thu, 29 Feb 2024 10:03:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 891f8890a4a3663da7056542757022870b499bc1
Message-ID: <202402291030.m7XuvDeH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 891f8890a4a3663da7056542757022870b499bc1  efi/x86: Set the PE/COFF header's NX compat flag unconditionally

elapsed time: 726m

configs tested: 50
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240228   clang
i386         buildonly-randconfig-002-20240228   clang
i386         buildonly-randconfig-003-20240228   clang
i386         buildonly-randconfig-004-20240228   clang
i386         buildonly-randconfig-005-20240228   gcc  
i386         buildonly-randconfig-006-20240228   clang
i386                                defconfig   clang
i386                  randconfig-001-20240228   clang
i386                  randconfig-002-20240228   clang
i386                  randconfig-003-20240228   gcc  
i386                  randconfig-004-20240228   clang
i386                  randconfig-005-20240228   clang
i386                  randconfig-006-20240228   gcc  
i386                  randconfig-011-20240228   clang
i386                  randconfig-012-20240228   clang
i386                  randconfig-013-20240228   gcc  
i386                  randconfig-014-20240228   gcc  
i386                  randconfig-015-20240228   gcc  
i386                  randconfig-016-20240228   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240229   gcc  
x86_64       buildonly-randconfig-002-20240229   clang
x86_64       buildonly-randconfig-003-20240229   gcc  
x86_64       buildonly-randconfig-004-20240229   gcc  
x86_64       buildonly-randconfig-005-20240229   gcc  
x86_64       buildonly-randconfig-006-20240229   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240229   clang
x86_64                randconfig-002-20240229   clang
x86_64                randconfig-003-20240229   clang
x86_64                randconfig-004-20240229   clang
x86_64                randconfig-005-20240229   clang
x86_64                randconfig-006-20240229   clang
x86_64                randconfig-011-20240229   gcc  
x86_64                randconfig-012-20240229   gcc  
x86_64                randconfig-013-20240229   gcc  
x86_64                randconfig-014-20240229   gcc  
x86_64                randconfig-015-20240229   gcc  
x86_64                randconfig-016-20240229   gcc  
x86_64                randconfig-071-20240229   clang
x86_64                randconfig-072-20240229   clang
x86_64                randconfig-073-20240229   clang
x86_64                randconfig-074-20240229   clang
x86_64                randconfig-075-20240229   gcc  
x86_64                randconfig-076-20240229   clang
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

