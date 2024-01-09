Return-Path: <linux-kernel+bounces-21549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A48829101
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D52F71C25175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E423E485;
	Tue,  9 Jan 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW6Xn49V"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAC364B5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704844040; x=1736380040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bewDhbzp09Q75N7YhFCyWSzSy1l1fniXCPCgpAHNkBE=;
  b=KW6Xn49Vp8oMSxY4LGQpY8VtAp3uPfWlAds6OTnjJrLn4WuT/6SQ+qe1
   sCRgKzvm4Ik8E7KC3PYr15mLnEBZtW8bOpNuhgjAiAyOeVrUs0Dbm16Fp
   HOo9jt/0lWwAKUsGhEvpUy4CqpV4Ya84rvsD0Hg5XnIDcgsqRJriM5c+h
   VtOfqqTcTIZ4aIv2n94nWCbvzIg3/Lucrcgnhzg8j5JaCkc0CTZzo6IQm
   kyPJECs9tO2iGr4GD73mL8+xwilQ2EnyNGpEIZxu40H0Kvf8SnOuj1s7L
   FEy4SKmzDojs/jS5iC3IPbTyR5+H5z6+8VBseasXYYzMsKAoWjyvYxJsz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="462643278"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="462643278"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905323749"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905323749"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2024 15:47:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNLoQ-0006Ne-2k;
	Tue, 09 Jan 2024 23:47:14 +0000
Date: Wed, 10 Jan 2024 07:47:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Miao <jun.miao@intel.com>, kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, jun.miao@intel.com, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Optimize try_accept_memory() to reduce 1GB page
 accepted failed times
Message-ID: <202401100747.8LTktRbX-lkp@intel.com>
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
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240110/202401100747.8LTktRbX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100747.8LTktRbX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100747.8LTktRbX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/coco/tdx/tdx-shared.c: In function 'tdx_accept_memory':
>> arch/x86/coco/tdx/tdx-shared.c:62:17: warning: "/*" within comment [-Wcomment]
      62 |                 /* The 4KB page case or accept 2MB page failed case. */
         |                  


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
    63			if (!accept_size)
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

