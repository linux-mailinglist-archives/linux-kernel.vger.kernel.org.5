Return-Path: <linux-kernel+bounces-50974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8193D84847E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1B71F25BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F294F1F9;
	Sat,  3 Feb 2024 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3QotZqe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6D4EB5C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706948429; cv=none; b=SrtudDYZ2XnBD7beusehrQ7HMMuQ8n8yldzFIOndTwJIm0Bq6D5KKVf4FkovUF89FGVUQyal2Z6c5GrnH3wMeR2J9Em3/vPZpBs0pKrW8ZnceRq8VMpVdS+jP5ZelQpdjoDZdRrtVDrf6Bq2j5fYU02WIyEuvkU97JvG8ERciXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706948429; c=relaxed/simple;
	bh=VJTsZpqCDZpsu5T+MNLTD5MewmrnD3AsR3yU5nnD+1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uwVFNeG0ORXFGPxTe7uPEJACiGwb70bPXARHfJDInzo0quy4uLoKxmNSxRYG7ve5DaSoJYVXaCsO1BpOm38a26XKp5k2YefjsO9KUTQX2SvcG+udxvqV+LqyDr453kzh8Y6xINsWJPy5wOUM5WscBRxuMY9ZepxFumDc6uVLKJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3QotZqe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706948427; x=1738484427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VJTsZpqCDZpsu5T+MNLTD5MewmrnD3AsR3yU5nnD+1U=;
  b=c3QotZqetqvZYt56ILT0UQKaRs9FkIeVyHony44QCRlhFlSV8tX8rFxl
   2vpQUGYNRVKCxq4Dvb2WXKjrev3+q/XFNA9wYXVBGVuID0EIWhpnNt0AJ
   J3ZwZg7uHblBHaAisLYqFlq0iWqGevAJZIMteCgeAMuiy/xAdudq3JmPJ
   T1wz/zS54srxxv95vKFxhAuuJO2trxkEYwKfBMEHZMYn1xPJj5c0S47lP
   hLM4oqD0VvJNf184agmZFJwYSUW/y/7oMOrFIAWUkH0aUBiSTlvqf6ZPB
   TLMaTZgb+7ettSy5k+NJr1NXECQqY4prqsv5YF1WcPgkAqpefPzrSncQK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="206181"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="206181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 00:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="295609"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Feb 2024 00:20:25 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWBGA-0004mg-05;
	Sat, 03 Feb 2024 08:20:22 +0000
Date: Sat, 3 Feb 2024 16:20:14 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, Alex Shi <alexs@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: include/linux/compiler_types.h:346:38: error: call to
 '__compiletime_assert_412' declared with attribute error: FIELD_PREP: mask
 is not constant
Message-ID: <202402031636.ZMuj0En9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56897d51886fa7e9f034ff26128eb09f1b811594
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   1 year, 11 months ago
config: x86_64-buildonly-randconfig-002-20240203 (https://download.01.org/0day-ci/archive/20240203/202402031636.ZMuj0En9-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402031636.ZMuj0En9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402031636.ZMuj0En9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:0:0:
   drivers/gpu/drm/i915/gt/uc/intel_guc.c: In function 'intel_guc_send_mmio':
>> include/linux/compiler_types.h:346:38: error: call to '__compiletime_assert_412' declared with attribute error: FIELD_PREP: mask is not constant
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:327:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:346:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:62:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),  \
      ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:111:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/gt/uc/intel_guc.c:430:9: note: in expansion of macro 'FIELD_PREP'
            FIELD_PREP(GUC_HXG_MSG_0_ORIGIN,
            ^~~~~~~~~~


vim +/__compiletime_assert_412 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  

:::::: The code at line 346 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

