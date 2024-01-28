Return-Path: <linux-kernel+bounces-41541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5AF83F410
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6C55B2111F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01F79F2;
	Sun, 28 Jan 2024 05:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsmTzdlz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507B6FAF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706420059; cv=none; b=p3ULvZmnoepI9S/6IlYpOs+8X+cyzEHVjqERWdKjh9QQcWfsfe1Vm1sx1nwfrdWJf0D7duj6zBMZ2nCtGwtIKQ8Hqa6iEOTaa2D2xD2A7CTcMbXA11xMtX4g9MPY4KNUrfK8s/JfhP425Eb+ZWX9ANmsz5OxUNtslk4jME/0L84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706420059; c=relaxed/simple;
	bh=Qnmvl794rnRdeyOqNCVu16iJKI56LuGWzYCa73H9AWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l3l4WLcDUUZkrOhFGKn+uAUUwzVMsW2Dny2ZSYoCjeIB/sddtzh9JxD9+0HLMr+X/ptUbv/tGQ6jyOOBeHqC6Dh0lTwYJdFWkxTDn2pBHYtuKARNVEfzhMgH3PKfzhv0Jj9Udw6jnuj5er5JxOGXKI+FVJC6DCjS08LRpI9vW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsmTzdlz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706420057; x=1737956057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qnmvl794rnRdeyOqNCVu16iJKI56LuGWzYCa73H9AWM=;
  b=hsmTzdlzlWHl4RoxQQXLLiADRNUszxxCAmQINU4u/uh48LJd+Q7Hc0SK
   lqPLwl+3f7rcHMXGB9b2A4auTtUgbUNLW76OKWc7AVSaRuU3Qr6ZqcqU3
   9DBUPHuo32H/aN6tZLHK4ctfB/maUeIvi8E+e3Xmqt6Y/LqO+u8b2Q2Vo
   99NlPqZYVJmMclH4l8ZxlqY7ncLel+8l/OZpyVTD9/AZMZXddKVaET8KB
   1Esuwly7XnJlrpDLaBjuYzbl00Z7+tp0c0xSQyXNMKt/+nnFPYKey6mDp
   XyrQSlSmzDGVtWS1fMneNctKCpNnPQ6ra0t1b9gpWlEz5aJB8HH6S65Ec
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24212931"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24212931"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 21:34:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3067959"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jan 2024 21:34:14 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTxo4-000374-26;
	Sun, 28 Jan 2024 05:34:12 +0000
Date: Sun, 28 Jan 2024 13:34:02 +0800
From: kernel test robot <lkp@intel.com>
To: Patricia Alfonso <trishalfonso@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	David Gow <davidgow@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works
 in KASAN generic outline mode!
Message-ID: <202401281301.YwKiPtas-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a696a29c6905594e4abf78eaafcb62165ac61f1
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   1 year, 6 months ago
config: um-randconfig-001-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281301.YwKiPtas-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281301.YwKiPtas-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281301.YwKiPtas-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/kasan/generic.c:34:
>> mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~


vim +485 mm/kasan/kasan.h

e2db1a9aa38149 Andrey Konovalov 2021-02-25  481  
af3751f3c2b628 Daniel Axtens    2021-06-28  482  #ifndef kasan_arch_is_ready
af3751f3c2b628 Daniel Axtens    2021-06-28  483  static inline bool kasan_arch_is_ready(void)	{ return true; }
af3751f3c2b628 Daniel Axtens    2021-06-28  484  #elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
af3751f3c2b628 Daniel Axtens    2021-06-28 @485  #error kasan_arch_is_ready only works in KASAN generic outline mode!
af3751f3c2b628 Daniel Axtens    2021-06-28  486  #endif
af3751f3c2b628 Daniel Axtens    2021-06-28  487  

:::::: The code at line 485 was first introduced by commit
:::::: af3751f3c2b6282bebcb56c35bbe4c8b671f80aa kasan: allow architectures to provide an outline readiness check

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

