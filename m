Return-Path: <linux-kernel+bounces-21521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E68290B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D600C1C24CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68D3E495;
	Tue,  9 Jan 2024 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVxJ6tAp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AEF3E48F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704841604; x=1736377604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qB6rllY9Y9lF/uM8R45vNgHXRFEg+zZ+eoCghnpCI60=;
  b=jVxJ6tApQ6k/f84mK8Lonb2Fp0pwhJcxrq95PRCT5diRMkMuKFLwiAaF
   ap2VoTBIRebHhIXFcSCodqUtc/a4nYYjLKr4iBH3APiUXN8GsT8AmHHZC
   Q8eSjEeuQZcS3zUiUp01z37J1x2lfmZVupELOWxKmX4OcXmEr2KnoXNhz
   KVSg9hhCOMG01vL0Jjg0lGvOMbf3kBr3QRRsd+zSfh9rENpOmaTXyg4V0
   4391sCrziteppLkQfW88uUmEB2oaqu33E1+GmEAE4VkjdU9jCiiTer8yo
   II4lWXIf9JnpdzITansYeKTk/8ymweaWnEuZxbwrv3U9sL9oS26PcwYJe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5122170"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5122170"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785405104"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785405104"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2024 15:05:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNLAR-0006LG-0v;
	Tue, 09 Jan 2024 23:05:55 +0000
Date: Wed, 10 Jan 2024 07:05:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Miao <jun.miao@intel.com>, kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jun.miao@intel.com,
	x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Optimize try_accept_memory() to reduce 1GB page
 accepted failed times
Message-ID: <202401100620.TjY1Uq2O-lkp@intel.com>
References: <20240109054824.9023-1-jun.miao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109054824.9023-1-jun.miao@intel.com>

Hi Jun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/tdx]
[also build test WARNING on next-20240109]
[cannot apply to linus/master v6.7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Miao/x86-tdx-Optimize-try_accept_memory-to-reduce-1GB-page-accepted-failed-times/20240109-134908
base:   tip/x86/tdx
patch link:    https://lore.kernel.org/r/20240109054824.9023-1-jun.miao%40intel.com
patch subject: [PATCH] x86/tdx: Optimize try_accept_memory() to reduce 1GB page accepted failed times
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20240110/202401100620.TjY1Uq2O-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100620.TjY1Uq2O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100620.TjY1Uq2O-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/coco/tdx/tdx-shared.c:62:3: warning: '/*' within block comment [-Wcomment]
      62 |                 /* The 4KB page case or accept 2MB page failed case. */
         |                 ^
>> arch/x86/coco/tdx/tdx-shared.c:63:8: warning: variable 'accept_size' is uninitialized when used here [-Wuninitialized]
      63 |                 if (!accept_size)
         |                      ^~~~~~~~~~~
   arch/x86/coco/tdx/tdx-shared.c:49:28: note: initialize the variable 'accept_size' to silence this warning
      49 |                 unsigned long accept_size;
         |                                          ^
         |                                           = 0
   2 warnings generated.


vim +62 arch/x86/coco/tdx/tdx-shared.c

    40	
    41	bool tdx_accept_memory(phys_addr_t start, phys_addr_t end)
    42	{
    43		/*
    44		 * For shared->private conversion, accept the page using
    45		 * TDG_MEM_PAGE_ACCEPT TDX module call.
    46		 */
    47		while (start < end) {
    48			unsigned long len = end - start;
    49			unsigned long accept_size;
    50	
    51			/*
    52			 * Try larger accepts first. It gives chance to VMM to keep
    53			 * 1G/2M Secure EPT entries where possible and speeds up
    54			 * process by cutting number of hypercalls (if successful).
    55			 * Since per current TDX spec, only support for adding 4KB or
    56			 * 2MB page dynamically.
    57			 * /
    58	
    59			if (IS_ALIGNED(start, PMD_SIZE) && len >= PMD_SIZE)
    60				accept_size = try_accept_one(start, len, PG_LEVEL_2M);
    61	
  > 62			/* The 4KB page case or accept 2MB page failed case. */
  > 63			if (!accept_size)
    64				accept_size = try_accept_one(start, len, PG_LEVEL_4K);
    65			if (!accept_size)
    66				return false;
    67			start += accept_size;
    68		}
    69	
    70		return true;
    71	}
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

