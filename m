Return-Path: <linux-kernel+bounces-12298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4A81F27C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C304F1F2316C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3E49896;
	Wed, 27 Dec 2023 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avgTaL6L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590484988C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703716135; x=1735252135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLvKxjmPAQNCDQWSKf+PXALi8yQg+Zp/bXNKwKOpNE4=;
  b=avgTaL6LgrfYq76ybT8bFtorhTN0/LgbOpU00OEtCjAIh3vOztsYlnwj
   aF/xjRjtjbCjx+TSAimSxWVqHquMNVZ1Z96E0KBmsSf3jXIM/0bw11hi2
   dyf7uRfUKIqyvIcTX0Ahz1t0Ww56UOlu6bI4rvFnqI0+D8jPoxmx1E3ID
   fYfJuXUSDLyhjYik16O2yfSi+2Bq1fwC6e+BjRJuRiVB8fl/7JJZhcN7K
   Q43E1RET95ONx02UFOJZ1z+UOMpdLhuVyGUgJHasGElOuOqC9d9Ei9PTH
   jrcmxOQafdaElhjdHPmaEOrV0V+UoUKDB3u9cRm6Zt42tPrCd3goq62wr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3335458"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3335458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 14:28:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="778340767"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="778340767"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Dec 2023 14:28:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIcOO-000FnF-1P;
	Wed, 27 Dec 2023 22:28:48 +0000
Date: Thu, 28 Dec 2023 06:28:32 +0800
From: kernel test robot <lkp@intel.com>
To: andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: stop leaking stack trace handles
Message-ID: <202312280603.WqS3sWfa-lkp@intel.com>
References: <20231226225121.235865-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226225121.235865-1-andrey.konovalov@linux.dev>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[cannot apply to linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/andrey-konovalov-linux-dev/kasan-stop-leaking-stack-trace-handles/20231227-065314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231226225121.235865-1-andrey.konovalov%40linux.dev
patch subject: [PATCH mm] kasan: stop leaking stack trace handles
config: arm-randconfig-002-20231227 (https://download.01.org/0day-ci/archive/20231228/202312280603.WqS3sWfa-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312280603.WqS3sWfa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312280603.WqS3sWfa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/generic.c:506:6: warning: no previous prototype for function 'release_alloc_meta' [-Wmissing-prototypes]
     506 | void release_alloc_meta(struct kasan_alloc_meta *meta)
         |      ^
   mm/kasan/generic.c:506:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     506 | void release_alloc_meta(struct kasan_alloc_meta *meta)
         | ^
         | static 
>> mm/kasan/generic.c:517:6: warning: no previous prototype for function 'release_free_meta' [-Wmissing-prototypes]
     517 | void release_free_meta(const void *object, struct kasan_free_meta *meta)
         |      ^
   mm/kasan/generic.c:517:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     517 | void release_free_meta(const void *object, struct kasan_free_meta *meta)
         | ^
         | static 
   2 warnings generated.


vim +/release_alloc_meta +506 mm/kasan/generic.c

   505	
 > 506	void release_alloc_meta(struct kasan_alloc_meta *meta)
   507	{
   508		/* Evict the stack traces from stack depot. */
   509		stack_depot_put(meta->alloc_track.stack);
   510		stack_depot_put(meta->aux_stack[0]);
   511		stack_depot_put(meta->aux_stack[1]);
   512	
   513		/* Zero out alloc meta to mark it as invalid. */
   514		__memset(meta, 0, sizeof(*meta));
   515	}
   516	
 > 517	void release_free_meta(const void *object, struct kasan_free_meta *meta)
   518	{
   519		/* Check if free meta is valid. */
   520		if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
   521			return;
   522	
   523		/* Evict the stack trace from the stack depot. */
   524		stack_depot_put(meta->free_track.stack);
   525	
   526		/* Mark free meta as invalid. */
   527		*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
   528	}
   529	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

