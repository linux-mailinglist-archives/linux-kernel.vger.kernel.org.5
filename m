Return-Path: <linux-kernel+bounces-56577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B984CBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373ED1C24DD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A278695;
	Wed,  7 Feb 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBt2VtOE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D77C096
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313380; cv=none; b=gltuuiJpDMnVq5uI/Hu6SsB+nZz+CXUTC8ltksr0f0b3BWdoQggvPzUN4ZNVrPZ6dWjDEJL3i8N/ANRN/gbA2f4bH1SWw46FZtw566SD0DbY3+h8+9MzXNxYR6q3tQ3iOERHXbFFxhAp0uRf+2Pcqf3jdSbaOxXW4d7dHjy4O/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313380; c=relaxed/simple;
	bh=DyoQGsEkYVIpsB0lXxfOD8WwsDkxbIrnmw068ChGyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ubEVYfz+CFo58pUYS/Eruk4i09xUyKxtiz6EYQ+AoC+VL6j7L2h1/5OtRk/2OEUmseku9BZy29ThImLPQfVitWoS1zJaIN3TyZUfmWsa9RuNvgNYu75mK8rQlMkphP54fQo2RbyvVZrOq/W1szm+CPQgUMfE1s1jfMjnFbuQKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBt2VtOE; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707313379; x=1738849379;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DyoQGsEkYVIpsB0lXxfOD8WwsDkxbIrnmw068ChGyfk=;
  b=FBt2VtOEK2dXwMNvcCpIv1O+kKay+8xYXFS3lZeFXjm+IWTEh+sgJlG9
   pAtBTTggWf7Xm4VFUrKI4eNkXJpo7qHewdFRRpM/njOTlVwlutCOZrMen
   c2DJB2LLwCF+yjfdQxI2wtGRwJurvJXciSORBsImTU8g/lWyeNfKHBGZr
   9lpJ20fDTs6jXvOSHALeERaBUZdV3ddJDRKSxeX7YsAkwec4z+HnQ8Ozy
   d7uIzLcTDzCpvqk/Pe1ytWBCmKMmcxSuwKWzaA55VBepvsRNXimhvIasU
   R7mMqxDG2XbstYFkFecEpAYPxvSlD5Ls+ulEUq/lw/BSjMsYzQGUSVXsP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="395406769"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="395406769"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1631772"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Feb 2024 05:42:56 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXiCU-0002gS-2C;
	Wed, 07 Feb 2024 13:42:54 +0000
Date: Wed, 7 Feb 2024 21:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: lib/vsprintf.c:1528:9: warning: function 'va_format' might be a
 candidate for 'gnu_printf' format attribute
Message-ID: <202402072101.yrr6DK1t-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Petr,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d280f4d760e3bcb4a8df302afebf085b65ec982
commit: 45c3e93d751ea50861c796da3cbfc848fa6ddf55 vsprintf: Factor out %pV handler as va_format()
date:   4 years, 9 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20240207/202402072101.yrr6DK1t-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402072101.yrr6DK1t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402072101.yrr6DK1t-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/vsprintf.c:625:7: warning: no previous prototype for 'pointer_string' [-Wmissing-prototypes]
     625 | char *pointer_string(char *buf, char *end, const void *ptr,
         |       ^~~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
>> lib/vsprintf.c:1528:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1528 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +1528 lib/vsprintf.c

  1522	
  1523	static char *va_format(char *buf, char *end, struct va_format *va_fmt)
  1524	{
  1525		va_list va;
  1526	
  1527		va_copy(va, *va_fmt->va);
> 1528		buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
  1529		va_end(va);
  1530	
  1531		return buf;
  1532	}
  1533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

