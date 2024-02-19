Return-Path: <linux-kernel+bounces-70627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F707859A39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1001F1C20A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6B1652;
	Mon, 19 Feb 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwRRv/Tk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D783163
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708303029; cv=none; b=QK6s5nlyycswVmZKYYm78vcOmIINJGJ6lTRDcXk1vD+ODfjOtHFE79/v2LzPu4APBX7WGHKNWpVfoVGNAfCvyr+Z+Z6GM1Xg2dJDKVthr59Z5AYmDEIxuRHpVz3vfSUJ3SYckfDljsVvPCuinZPbkdvZzu4XBwD72J/d6E6Xoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708303029; c=relaxed/simple;
	bh=OqVAF6K8hh+2d2FiTbNoOFfzwaN3i9pwfxEnfO0YRu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U0S+xPSfo3r1fr5/eK+tmo/clgm0eXT3FqWGYSpCV0C20kDV2TuV1WsIyGtR5j1IaL2CIahXyjRei5gnsdJ/+rGeukU9nDblevPUsAwP/57nvd0xBE25hUQg0MyLZtuEx1V5rcX5Qqz+TDe9yBQbbFcn83pYoE5scOaYi86/OSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwRRv/Tk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708303027; x=1739839027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OqVAF6K8hh+2d2FiTbNoOFfzwaN3i9pwfxEnfO0YRu4=;
  b=SwRRv/Tkhxv7N+8LRNoWv21LQUU1+2QKo3JxKu7Jr5UPQ1SIOSqu8gK1
   ItnbQkgwsauEAcbWZFL0+XO4enh26BICy20jbHjeuvtLFg2Uw7ucsewJH
   fw6n+8vR4pgzngwM/PMrQnTSX9p+EgBFYZiHFTiZWAaPkVxJUofTEzuyu
   ytU0gCl3vnRay8xwHB5KbmgJb/nRtB4sxgaguRj7hGI+6hqhPLj2BVJOa
   Razv6v+psiPsO65s3jXUDOVuJUAvT6WjIpyedIJ0dcZrMP3vg9MxfM/yl
   jKGV6SdcsOMTSo/rbAkaAbmAcuGvAoEfa0UozxhUIPZXPtw0Jue4x51Zk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2804248"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2804248"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 16:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="4735275"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Feb 2024 16:37:05 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbreZ-0003Og-0M;
	Mon, 19 Feb 2024 00:37:03 +0000
Date: Mon, 19 Feb 2024 08:36:53 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:358:45: error: call to
 '__compiletime_assert_947' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(struct ieee80211_rx_status) > sizeof(skb->cb)
Message-ID: <202402190801.9ZnFahvB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b401b621758e46812da61fa58a67c3fd8d91de0d
commit: f66c48af7a110c0d694c4ac4a1257affb272a2ea mac80211: support minimal EHT rate reporting on RX
date:   1 year, 1 month ago
config: arm-randconfig-003-20240218 (https://download.01.org/0day-ci/archive/20240219/202402190801.9ZnFahvB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402190801.9ZnFahvB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402190801.9ZnFahvB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/mac80211/rx.c: In function 'ieee80211_rx_irqsafe':
>> include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_947' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ieee80211_rx_status) > sizeof(skb->cb)
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:339:25: note: in definition of macro '__compiletime_assert'
     339 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:358:9: note: in expansion of macro '_compiletime_assert'
     358 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   net/mac80211/rx.c:5283:9: note: in expansion of macro 'BUILD_BUG_ON'
    5283 |         BUILD_BUG_ON(sizeof(struct ieee80211_rx_status) > sizeof(skb->cb));
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_947 +358 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  356   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  357  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @358  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  359  

:::::: The code at line 358 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

