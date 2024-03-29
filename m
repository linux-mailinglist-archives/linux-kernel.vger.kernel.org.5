Return-Path: <linux-kernel+bounces-125111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DF892043
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247E71C294F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B3513BAC3;
	Fri, 29 Mar 2024 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeIcbJIO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB7139D05
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724938; cv=none; b=u0dyG0erazayhCpyvkQcLmn+qodN18c3I6vPwriD8MzFYX52+IwM/xMb8MHlZFJAyMCDB+7tsb3EOW/i9qdMa+fhbgGcc59qMnDQA6HFvXNzRC04Bji2/pOEK58u5NkhDbnszNWfHBXV3ypEtidYZbIzTLd6WZTxnoTVmBKpuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724938; c=relaxed/simple;
	bh=0J3n6pYeqhn3dlkv7mFRBMq4jSRv8lQ8WOAx73hTNZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BBvCHw0rM7yz2mfIVSgRzVp2NQVPV/v/jMf9RGReQ/Z+XRJoil081iDLfAuSLpojuaj11yVcuEfJwp+v/a7WskSeYjRXK9G7nm69BEBUOPXi4IEvI9Vspx4VnKFrpfobbrdj32pH0rPBcj/3rphlp294YqaHL7UBqxzSY8puZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeIcbJIO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711724936; x=1743260936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0J3n6pYeqhn3dlkv7mFRBMq4jSRv8lQ8WOAx73hTNZY=;
  b=jeIcbJIOlorGoN1ncka0hja1sh1v0J2j5sxS+0QzMWR/fQ6JfxbG06S7
   fMmLmUPB/h6KfmDD7B52eP3wVJ7K8SH7XoZ1nlGYOJiY2d9Bt7xZdcv0m
   UotbarXdmp4ntPmUVZdXVHXfSEYI2aZReRk9x9c5yt8dwu1xeB9Z1L+i6
   M0JNYXGoifLLDGMXNAZICcruUP1lPUK/h2WmZcyAIWaCkLImVyWwn7HcL
   N3EADROy5v0eaZsm1R6NmzJiLY4WNeKxBmaYCdiD+AOwdYzRopjr7wTcU
   /qb90i8LUYBHdSiWOj++SYzOLrIxaAUawzSM6Hti3vfGI4CeHkFBO96Eb
   Q==;
X-CSE-ConnectionGUID: Jxz37GvMQ02fShyFnf1qvA==
X-CSE-MsgGUID: 0AFaMIFURfemNSieNQTbmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17542365"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17542365"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21462485"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 08:08:54 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqDqd-0003J6-2B;
	Fri, 29 Mar 2024 15:08:51 +0000
Date: Fri, 29 Mar 2024 23:08:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.03.27b 64/69]
 arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of
 function 'cmpxchg_emu_u8'
Message-ID: <202403292321.T55etywH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.03.27b
head:   786fab3085d764055a78edb54023420920344333
commit: b3b1a154281fc97efc4c1d5818a83c29c228dbd5 [64/69] xtensa: Emulate one-byte and two-byte cmpxchg
config: xtensa-allnoconfig (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292321.T55etywH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403292321.T55etywH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/xtensa/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/xtensa/include/asm/bitops.h:192,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
   arch/xtensa/include/asm/cmpxchg.h: In function '__cmpxchg':
>> arch/xtensa/include/asm/cmpxchg.h:77:25: error: implicit declaration of function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
      77 |         case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
         |                         ^~~~~~~~~~~~~~
>> arch/xtensa/include/asm/cmpxchg.h:78:25: error: implicit declaration of function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
      78 |         case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
         |                         ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1197: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/cmpxchg_emu_u8 +77 arch/xtensa/include/asm/cmpxchg.h

    72	
    73	static __inline__ unsigned long
    74	__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
    75	{
    76		switch (size) {
  > 77		case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
  > 78		case 2:  return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
    79		case 4:  return __cmpxchg_u32(ptr, old, new);
    80		default: __cmpxchg_called_with_bad_pointer();
    81			 return old;
    82		}
    83	}
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

