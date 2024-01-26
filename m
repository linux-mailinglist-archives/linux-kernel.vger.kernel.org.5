Return-Path: <linux-kernel+bounces-40610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270ED83E326
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB51B288C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E022EF3;
	Fri, 26 Jan 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rukv6fKu"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A0422EE6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300002; cv=none; b=h7vkWPDPjpJ52Mnr+Eks+GeiHSy0Rxvjkrn4kUYsE/Y6vYGa5DNdt/mS1kBYPoh4pYO7ceq53qm0s6fPcL6/1siMK5XXWswl9ewa9sr7WoZnhxRj0+7AIE/s6wzJ6bqYS1u5QQncDAmM7I6prNRh+TRxfGHyWQX2m1cmP7MfckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300002; c=relaxed/simple;
	bh=VlbRKFCy06N8CchNwOnGxXEat0dwBL6sS2PhAqH3k5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KQNcki0u9pauZxK1YCDSYjFa9342s3JAQ7vDoSlYiXIfLXMuow3+d3ggaUoqsOrmkRGeAHYzU82m1vdtisj1wsNuHYWAzSiSGxbw8Gbh6Y1jcjewObIYcih3jqHA6XTdPpjzKhcoJ9EzM221QfqUdpOI8aPAJD1G502PWDrl5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rukv6fKu; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706300000; x=1737836000;
  h=date:from:to:cc:subject:message-id;
  bh=VlbRKFCy06N8CchNwOnGxXEat0dwBL6sS2PhAqH3k5c=;
  b=Rukv6fKu1f79YSZpZKF5yzS6Y4DPAHh75McLY7cgHb3gnqRi9Yz7LLSX
   C6ZnN8HNSGtOVfkzOAe2JtKjJMyJALXJJy6JRTUkc1SY2HAgyO/vxlXt3
   S5ubQHjXHWDndX6ibVfIIVwuL3NKwleXpnvuIzXSyrtYu2IL2oM4h3zWJ
   WxpWT3h0r/VHT8J4NNM0Yhj0cq9DlJgUV0dVg1VZ9kDHZqxIg1gigN4XD
   f+GqyoWv4Kl+JVgkdXnm3pL4Z+cp71ZTdblUDteKPVAHBsxfPwknePGcq
   VXFLKCHn2pxmnFs0baS8Cbmu1nHjjflMCjI5CR9bC1SZLJNRGHbiMfpjZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="402215810"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="402215810"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:13:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118352287"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118352287"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2024 12:13:19 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTSZg-0001Ji-2n;
	Fri, 26 Jan 2024 20:13:16 +0000
Date: Sat, 27 Jan 2024 04:12:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b9328fd636bd50da89e792e135b234ba8e6fe59f
Message-ID: <202401270417.l3Viw3x6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b9328fd636bd50da89e792e135b234ba8e6fe59f  x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5

elapsed time: 1907m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240126   clang
i386         buildonly-randconfig-002-20240126   clang
i386         buildonly-randconfig-003-20240126   clang
i386         buildonly-randconfig-004-20240126   clang
i386         buildonly-randconfig-005-20240126   clang
i386         buildonly-randconfig-006-20240126   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240126   clang
i386                  randconfig-002-20240126   clang
i386                  randconfig-003-20240126   clang
i386                  randconfig-004-20240126   clang
i386                  randconfig-005-20240126   clang
i386                  randconfig-006-20240126   clang
i386                  randconfig-011-20240126   gcc  
i386                  randconfig-012-20240126   gcc  
i386                  randconfig-013-20240126   gcc  
i386                  randconfig-014-20240126   gcc  
i386                  randconfig-015-20240126   gcc  
i386                  randconfig-016-20240126   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

