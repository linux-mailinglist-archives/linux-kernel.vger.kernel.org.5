Return-Path: <linux-kernel+bounces-95839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCE18753BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A166F1F22E1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AB12F591;
	Thu,  7 Mar 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GejtSiM1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FA12F385
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826967; cv=none; b=fr+73D1CnPgDzSvregIqn79PpxnVRrzF40LstLyy1U44SGnuP3zy0m4JsMeDfO0tfDPxgPdWUWDV00SaGLqMyTKHfpBUEbmAtx+nJRHkelk716wl7FRT3MWX+QSkS2I3Z9YP70pzymKPbRR2T2n/Hy0pEVHnS9hWtxcrrBsPwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826967; c=relaxed/simple;
	bh=C97P1YtElo3JLtKjB9OGWqTuuFxMbHJ54++v1vIY3Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAdOFO4XkZO+vvdn/n9B5kGeemvPnHALH6RZn1KIHK76jNdx3H3CrYe9btCkGMve/DzHV1mmtXeIS6ng6FI+6r9gNUtwdp5HLb0+qWlXcxylo1fUWcQjGOkaIk1M6MJYYcJ3Gs7ybD1FHzG1E18jBf7coYP+K7XUOD97jCjqAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GejtSiM1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826965; x=1741362965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C97P1YtElo3JLtKjB9OGWqTuuFxMbHJ54++v1vIY3Tg=;
  b=GejtSiM1TA9/oGn1/yuFTu2tUdnwuRXMHKaaoj0y39blTMGYyV+eHF1M
   r0RAGfc8aVkKPtTBT3Ieu9aLOHlzDfWQBj9n9uB2aiX72Vx9ab2t14nE5
   hiE25EiJsLeVbIKtEmX11WJfnsmj9PmVU/B/se0XYACNg0XRa+rlNVKrE
   hmfWRBtF1HgkQlpHxBRa89X3X2U4HJ3+3LwpDI3Gk6snfcnW0CHnkJLQw
   fgd+mtX+r5gIEvEWpIwL2jpMmzQ2ZR6epRJqrdXIrRTV/CuKwztM/hzU8
   QVGFC0YYkSudhrQPlVLCqR0U9WFwbjf326tdPXhEPx56RJVpdHOMqP+He
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15148084"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15148084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="41049480"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Mar 2024 07:56:02 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riG6B-0005JO-38;
	Thu, 07 Mar 2024 15:55:59 +0000
Date: Thu, 7 Mar 2024 23:55:09 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org,
	sfr@canb.auug.org.au, Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v3 06/14] linux/mm.h: move folio_size(), ... to
 mm/folio_size.h
Message-ID: <202403072311.1a9jXzWI-lkp@intel.com>
References: <20240305085919.1601395-7-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305085919.1601395-7-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240305]
[cannot apply to akpm-mm/mm-everything char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus joro-iommu/next broonie-spi/for-next powerpc/next powerpc/fixes linus/master v6.8-rc7 v6.8-rc6 v6.8-rc5 v6.8-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/drivers-add-missing-includes-on-linux-mm-h-and-others/20240305-170312
base:   next-20240305
patch link:    https://lore.kernel.org/r/20240305085919.1601395-7-max.kellermann%40ionos.com
patch subject: [PATCH v3 06/14] linux/mm.h: move folio_size(), ... to mm/folio_size.h
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240307/202403072311.1a9jXzWI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240307/202403072311.1a9jXzWI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403072311.1a9jXzWI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm/folio_size.h:8,
                    from include/linux/mm.h:5,
                    from arch/loongarch/include/asm/vdso.h:10,
                    from arch/loongarch/vdso/vgetcpu.c:6:
>> include/linux/page-flags.h:202:1: warning: data definition has no type or storage class
     202 | DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/page-flags.h:202:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
>> include/linux/page-flags.h:202:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/mm/folio_size.h:8,
                    from include/linux/mm.h:5,
                    from arch/loongarch/include/asm/vdso.h:10,
                    from arch/loongarch/include/asm/vdso/vdso.h:11,
                    from arch/loongarch/include/asm/vdso/gettimeofday.h:13,
                    from include/vdso/datapage.h:151,
                    from lib/vdso/gettimeofday.c:5,
                    from <command-line>:
>> include/linux/page-flags.h:202:1: warning: data definition has no type or storage class
     202 | DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/page-flags.h:202:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
>> include/linux/page-flags.h:202:1: warning: parameter names (without types) in function declaration
   include/linux/page-flags.h: In function 'page_fixed_fake_head':
>> include/linux/page-flags.h:210:14: error: implicit declaration of function 'static_branch_unlikely' [-Werror=implicit-function-declaration]
     210 |         if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
         |              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/page-flags.h: In function 'page_fixed_fake_head':
>> include/linux/page-flags.h:210:14: error: implicit declaration of function 'static_branch_unlikely' [-Werror=implicit-function-declaration]
     210 |         if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
         |              ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/page-flags.h:210:38: error: 'hugetlb_optimize_vmemmap_key' undeclared (first use in this function)
     210 |         if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:210:38: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/page-flags.h:210:38: error: 'hugetlb_optimize_vmemmap_key' undeclared (first use in this function)
     210 |         if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/page-flags.h:210:38: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:244: arch/loongarch/vdso/vgetcpu.o] Error 1
   make[3]: *** [scripts/Makefile.build:244: arch/loongarch/vdso/vgettimeofday.o] Error 1
   make[3]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[2]: *** [arch/loongarch/Makefile:163: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +202 include/linux/page-flags.h

9223b4190fa129 Christoph Lameter 2008-04-28  200  
47010c040dec8a Muchun Song       2022-04-28  201  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
cf5472e5611338 Muchun Song       2022-06-28 @202  DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
a6b40850c442bf Muchun Song       2022-03-22  203  
e7d324850bfcb3 Muchun Song       2022-03-22  204  /*
838691a1c0ec44 Muchun Song       2022-06-28  205   * Return the real head page struct iff the @page is a fake head page, otherwise
838691a1c0ec44 Muchun Song       2022-06-28  206   * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
e7d324850bfcb3 Muchun Song       2022-03-22  207   */
e7d324850bfcb3 Muchun Song       2022-03-22  208  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
e7d324850bfcb3 Muchun Song       2022-03-22  209  {
cf5472e5611338 Muchun Song       2022-06-28 @210  	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
e7d324850bfcb3 Muchun Song       2022-03-22  211  		return page;
e7d324850bfcb3 Muchun Song       2022-03-22  212  
e7d324850bfcb3 Muchun Song       2022-03-22  213  	/*
e7d324850bfcb3 Muchun Song       2022-03-22  214  	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
e7d324850bfcb3 Muchun Song       2022-03-22  215  	 * struct page. The alignment check aims to avoid access the fields (
e7d324850bfcb3 Muchun Song       2022-03-22  216  	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
e7d324850bfcb3 Muchun Song       2022-03-22  217  	 * cold cacheline in some cases.
e7d324850bfcb3 Muchun Song       2022-03-22  218  	 */
e7d324850bfcb3 Muchun Song       2022-03-22  219  	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
e7d324850bfcb3 Muchun Song       2022-03-22  220  	    test_bit(PG_head, &page->flags)) {
e7d324850bfcb3 Muchun Song       2022-03-22  221  		/*
e7d324850bfcb3 Muchun Song       2022-03-22  222  		 * We can safely access the field of the @page[1] with PG_head
e7d324850bfcb3 Muchun Song       2022-03-22  223  		 * because the @page is a compound page composed with at least
e7d324850bfcb3 Muchun Song       2022-03-22  224  		 * two contiguous pages.
e7d324850bfcb3 Muchun Song       2022-03-22  225  		 */
e7d324850bfcb3 Muchun Song       2022-03-22  226  		unsigned long head = READ_ONCE(page[1].compound_head);
e7d324850bfcb3 Muchun Song       2022-03-22  227  
e7d324850bfcb3 Muchun Song       2022-03-22  228  		if (likely(head & 1))
e7d324850bfcb3 Muchun Song       2022-03-22  229  			return (const struct page *)(head - 1);
e7d324850bfcb3 Muchun Song       2022-03-22  230  	}
e7d324850bfcb3 Muchun Song       2022-03-22  231  	return page;
e7d324850bfcb3 Muchun Song       2022-03-22  232  }
e7d324850bfcb3 Muchun Song       2022-03-22  233  #else
e7d324850bfcb3 Muchun Song       2022-03-22  234  static inline const struct page *page_fixed_fake_head(const struct page *page)
e7d324850bfcb3 Muchun Song       2022-03-22  235  {
e7d324850bfcb3 Muchun Song       2022-03-22  236  	return page;
e7d324850bfcb3 Muchun Song       2022-03-22  237  }
e7d324850bfcb3 Muchun Song       2022-03-22  238  #endif
e7d324850bfcb3 Muchun Song       2022-03-22  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

