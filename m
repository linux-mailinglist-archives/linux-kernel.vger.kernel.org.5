Return-Path: <linux-kernel+bounces-77323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C358603B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D831F27016
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F36E602;
	Thu, 22 Feb 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsrezVh9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAB10A05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634067; cv=none; b=ZvPYFgA0Zb0PSLYdsrCyBboVRFWa3RtmKLs0jALEMBj+Yr87fs6dP9G8h4Mmz8WPVVFKt93hDIvW5ih7eAaYMkenMxuFrGuqDQdrUaMXnPPkuBZfVIuKVaXSOdWL9VenOnUfiV1JA/lXtDI+Gyb1l/Zv2V8bDOz8yl5iZ8O6m3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634067; c=relaxed/simple;
	bh=XV3XtNmk1rLqA9pWexMVzg3cWtGVbvk/xP9jVQ60UBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A96cBTxWU3liLgR0xcaqP3ZjrwscvYu9b4rAIoxgejiUaJQtBe4qyBFb7Zm+4xVsSrG2feE1LKIuCIPyVWZxoxE9FlC23BwnNF3lB4AfulFFZvJ5QhhhNfvysCd0TztVUEvAtOdsxi4HCa+gK6SNsVOFLEbAe2M546kd1shQRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsrezVh9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708634066; x=1740170066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XV3XtNmk1rLqA9pWexMVzg3cWtGVbvk/xP9jVQ60UBw=;
  b=BsrezVh9Mzu2zVrRSABHuY1CCHxWbClqiFY7/SB87Nr8RY7RUkakfKQL
   RIh9+CW7NS1wEg4Xcn++ExbR9Xhw4yGGgZ1w+NI9G4lGvZJfdJUMb+RlZ
   2ia8QdgtM77ARczdEaXzgmIDUKpkL/hZnfD8DNC1ypfcuHt5krjMWYyTy
   R14qmAlpNXdBrvUzxOAU6E7rNqXFDa/nqhLHyu6+SWJvnCwj+mVeGdIzI
   dSqqLbgO+xHWhvmznSF3UNv2va30sauCjMQ7pKipn2BEGQz+oE5OVj//B
   YPglObh6nvM6erO3InZEOFy91O3zNixXXsDioaaE3IPd5K8PF4DaxRs97
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3036709"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3036709"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="36638986"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2024 12:34:23 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdFlt-0006h2-04;
	Thu, 22 Feb 2024 20:34:21 +0000
Date: Fri, 23 Feb 2024 04:33:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: include/linux/fortify-string.h:586:17: error: call to
 '__write_overflow' declared with attribute error: detected write beyond size
 of object (1st parameter)
Message-ID: <202402230419.nO2R7P95-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ronnie,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39133352cbed6626956d38ed72012f49b0421e7b
commit: 2f6f19c7aaad5005dc75298a413eb0243c5d312d cifs: fix regression in very old smb1 mounts
date:   1 year, 4 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240223/202402230419.nO2R7P95-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240223/202402230419.nO2R7P95-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402230419.nO2R7P95-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/mips/include/asm/processor.h:15,
                    from arch/mips/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/mips/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/cifs/connect.c:8:
   In function 'strcpy',
       inlined from 'CIFSTCon' at fs/cifs/connect.c:3949:3:
>> include/linux/fortify-string.h:586:17: error: call to '__write_overflow' declared with attribute error: detected write beyond size of object (1st parameter)
     586 |                 __write_overflow();
         |                 ^~~~~~~~~~~~~~~~~~


vim +/__write_overflow +586 include/linux/fortify-string.h

a28a6e860c6cf2 Francis Laniel 2021-02-25  569  
f68f2ff91512c1 Kees Cook      2021-04-20  570  /* Defined after fortified strlen to reuse it. */
92df138a8d663c Kees Cook      2022-02-08  571  __FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
281d0c962752fb Kees Cook      2022-02-08  572  char *strcpy(char * const POS p, const char * const POS q)
a28a6e860c6cf2 Francis Laniel 2021-02-25  573  {
9f7d69c5cd2390 Kees Cook      2022-09-19  574  	size_t p_size = __member_size(p);
9f7d69c5cd2390 Kees Cook      2022-09-19  575  	size_t q_size = __member_size(q);
a28a6e860c6cf2 Francis Laniel 2021-02-25  576  	size_t size;
a28a6e860c6cf2 Francis Laniel 2021-02-25  577  
f68f2ff91512c1 Kees Cook      2021-04-20  578  	/* If neither buffer size is known, immediately give up. */
fa35198f39571b Kees Cook      2022-09-19  579  	if (__builtin_constant_p(p_size) &&
fa35198f39571b Kees Cook      2022-09-19  580  	    __builtin_constant_p(q_size) &&
fa35198f39571b Kees Cook      2022-09-19  581  	    p_size == SIZE_MAX && q_size == SIZE_MAX)
a28a6e860c6cf2 Francis Laniel 2021-02-25  582  		return __underlying_strcpy(p, q);
a28a6e860c6cf2 Francis Laniel 2021-02-25  583  	size = strlen(q) + 1;
072af0c638dc8a Kees Cook      2021-08-02  584  	/* Compile-time check for const size overflow. */
fa35198f39571b Kees Cook      2022-09-19  585  	if (__compiletime_lessthan(p_size, size))
072af0c638dc8a Kees Cook      2021-08-02 @586  		__write_overflow();
072af0c638dc8a Kees Cook      2021-08-02  587  	/* Run-time check for dynamic size overflow. */
a28a6e860c6cf2 Francis Laniel 2021-02-25  588  	if (p_size < size)
a28a6e860c6cf2 Francis Laniel 2021-02-25  589  		fortify_panic(__func__);
f68f2ff91512c1 Kees Cook      2021-04-20  590  	__underlying_memcpy(p, q, size);
a28a6e860c6cf2 Francis Laniel 2021-02-25  591  	return p;
a28a6e860c6cf2 Francis Laniel 2021-02-25  592  }
a28a6e860c6cf2 Francis Laniel 2021-02-25  593  

:::::: The code at line 586 was first introduced by commit
:::::: 072af0c638dc8a5c7db2edc4dddbd6d44bee3bdb fortify: Fix dropped strcpy() compile-time write overflow check

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

