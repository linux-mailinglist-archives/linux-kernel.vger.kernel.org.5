Return-Path: <linux-kernel+bounces-12193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D381F125
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A432823DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614B4655B;
	Wed, 27 Dec 2023 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kzmp1tkS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AD46540
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703701246; x=1735237246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z6KIPUid8LL6rdifBkQEA5dR2LPPINDVODWsTdZki7w=;
  b=Kzmp1tkS50qnh1n/eU8fmDmkEY7pZ3o+mKetOELXJXuhbnhQYt6wXKbS
   lRPj4Mnob06KrO8Aovp8Gfb03gUZmbAddHPjjGGK7fUd9QZwZN9z6gwPv
   AlNaOg+JIBZwgz+ohX2cxSM1kjU3Ptq8ZqQMokwzl+i7R95s2njznOTA+
   Lzcd6U3rxesBiME6ZnvZl57pI/Yyt9RY8efxRE8Vv6uI5QPGtb3fHo0+D
   RhjIUvfZTk94PLb+CNYPcYOQn4s/JjmOx/FGPm4QkDBOtHaPYEbgsRU8C
   pOjr3CgTsqtCYC4mKb6/aIUqORgC00Ajwndk6NpMlys97Jl8xflzBW3dG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="15140590"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="15140590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 10:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="848740859"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="848740859"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2023 10:20:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIYVv-000Fez-2M;
	Wed, 27 Dec 2023 18:20:19 +0000
Date: Thu, 28 Dec 2023 02:19:51 +0800
From: kernel test robot <lkp@intel.com>
To: andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] kasan: stop leaking stack trace handles
Message-ID: <202312280213.6j147JJb-lkp@intel.com>
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
config: x86_64-randconfig-123-20231227 (https://download.01.org/0day-ci/archive/20231228/202312280213.6j147JJb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312280213.6j147JJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312280213.6j147JJb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/generic.c:506:6: warning: no previous prototype for 'release_alloc_meta' [-Wmissing-prototypes]
     506 | void release_alloc_meta(struct kasan_alloc_meta *meta)
         |      ^~~~~~~~~~~~~~~~~~
>> mm/kasan/generic.c:517:6: warning: no previous prototype for 'release_free_meta' [-Wmissing-prototypes]
     517 | void release_free_meta(const void *object, struct kasan_free_meta *meta)
         |      ^~~~~~~~~~~~~~~~~


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

