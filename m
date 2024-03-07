Return-Path: <linux-kernel+bounces-96067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598408756B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B12E1C21699
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C6136658;
	Thu,  7 Mar 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNTZ04HX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951E12F598;
	Thu,  7 Mar 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838381; cv=none; b=Igp2Xigl2UlpSkwiyqQ9ceHJCiuLTRrUg0tfYr2PA5Vy2GZlHpKOp9MrCvz2ay190vzafSmAD5c2m7FounxEwxBvKvl69D/h9OfdCp2n7QDeaehgrLvmna8I/5xplRmWnPlBlMxP+42AHMmfDr13MjEpqmw2ZQuB0i9t+J5Sq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838381; c=relaxed/simple;
	bh=5vnN3HzvbNmZuZXAM0Si1YlHaOVxj30ihRTND0eJ1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/MVPy+0mHor9gDU+bxEkyaSAEIiEkGs33Faqa6sF2LCf1Rf6hef5EiFx9Nc/lzK3L/MK4VbgxUZsA8sBdq6ni5yWtp6k+JzQAgg4EAAwoqV2SfeL3dA5F3OG97NjT4C83RkVcGXIXWb+58jgoJbBZIWbLX5TySX5dG3aooMza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNTZ04HX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709838379; x=1741374379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vnN3HzvbNmZuZXAM0Si1YlHaOVxj30ihRTND0eJ1G4=;
  b=LNTZ04HXkbDIhCKXOEVqtjNx6Ziy4TCQOYCPecriT/73SA+m8zavQuM6
   deq8a7cewykhP0hm4YnhlviQ783WpmS0W9681mqUM9l1dB2EMRZrizRCj
   fxlWiJrYTBoSKsz/OeNKvzYz3BKPJOnBdPDS6FKRh1qH8oXUyvF82jKzs
   w/sHKDcgRscNkl1KDKOqmoaCICDHsjGuL49y4GGMqfIkqg7XDHeyN/Xya
   f9XEay3ruBbYJkyZKSYnwOXrZE1PrceKOjbFo9QyoXNNSBMZLbRpLHgn3
   BgA5Yz7e5DkfCn28kxVICzh6fJICX1wLuXmC73BfKGuelFjKWBdWXDAVI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27000447"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="27000447"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:06:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="47686842"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Mar 2024 11:06:14 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riJ4F-0005WT-1M;
	Thu, 07 Mar 2024 19:06:11 +0000
Date: Fri, 8 Mar 2024 03:05:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Linton <jeremy.linton@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	keescook@chromium.org, Jason@zx2c4.com, gustavoars@kernel.org,
	mark.rutland@arm.com, rostedt@goodmis.org, arnd@arndb.de,
	broonie@kernel.org, guohui@uniontech.com, Manoj.Iyer@arm.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>,
	James Yang <james.yang@arm.com>,
	Shiyou Huang <shiyou.huang@arm.com>
Subject: Re: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
Message-ID: <202403080244.U8fiY8Dy-lkp@intel.com>
References: <20240305221824.3300322-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305221824.3300322-2-jeremy.linton@arm.com>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.8-rc7 next-20240307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-syscall-Direct-PRNG-kstack-randomization/20240306-061930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240305221824.3300322-2-jeremy.linton%40arm.com
patch subject: [PATCH 1/1] arm64: syscall: Direct PRNG kstack randomization
config: arm64-randconfig-r063-20240307 (https://download.01.org/0day-ci/archive/20240308/202403080244.U8fiY8Dy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403080244.U8fiY8Dy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403080244.U8fiY8Dy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/syscall.c:74:12: warning: 'kstack_rng' defined but not used [-Wunused-function]
      74 | static u16 kstack_rng(void) { return 0; }
         |            ^~~~~~~~~~


vim +/kstack_rng +74 arch/arm64/kernel/syscall.c

    71	
    72	arch_initcall(kstack_init);
    73	#else
  > 74	static u16 kstack_rng(void) { return 0; }
    75	#endif /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

