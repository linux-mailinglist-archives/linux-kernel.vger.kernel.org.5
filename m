Return-Path: <linux-kernel+bounces-69954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733958590C1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97455B20FC7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632677CF13;
	Sat, 17 Feb 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktVnZdJv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511E7CF05
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185825; cv=none; b=HH9zrV2A/Wgw/Vu5EpLEjgm9TrXHV0BbNZ9PQCnx7jDGZPtCo6oi5h9kgi0NzpxAMASHRRR87lSWi7+zmtfgsqNCu/hyIlLBlmIXqskr9Dtd42PVun1qaezKk47ksokEPxTByJA2FyVwb2NhDqfwqI3H1Lck1+X+9yAS3i1oiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185825; c=relaxed/simple;
	bh=JrktosC0z+O+NTdP4U7Gl/dnXkCzrzE/UnsDYqY+Ta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkFS0XDY2KSZB1I/jc7PfgOyLYomj51WnetiABo201jxspCotqrgK5f9OxEXB1RR6HS3Fo1rlQ2dQF33iCcHguF6hWrrbwlB574T+1ORMfzbJIk+pIdVU/eKtexZG6nbEMPiE9kkenomrEn6jC4F4SaaIyhMBoLJXrQ3tizR6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktVnZdJv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708185823; x=1739721823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrktosC0z+O+NTdP4U7Gl/dnXkCzrzE/UnsDYqY+Ta0=;
  b=ktVnZdJvPsdhRyNIR42axtQaOwDfs8C4yXWhx74SqCYjkHG5QQwQFeYD
   buH8/3iYtCVWXnMN0KKU/8DdYBmriIeQboXfpbi7sZ541P8CNcqI+cv+f
   im8RimE5dgp8+5XbRkX3xUaBMU4HdhJDpCpuZu+oXzYQwX18zHNDr/JqG
   wuu11iD+Nm5L4h0tJt0mtFSDEFqTZb9K0kupqH0FHoV015n9XdqqdkOFK
   aHGYSKSM5dRhJma7I+pX7AUl5rysrXNY+iwZ9f9OIE6PdtJf5M5i5SCAq
   CB5TlSc3bBY7kIf1a9CmfE7obwwOrBDeP9FoOGO9iVFylx1GIKsdJDLpn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="24771675"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="24771675"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 08:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="4449928"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Feb 2024 08:03:40 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbNAA-0002Eq-1q;
	Sat, 17 Feb 2024 16:03:38 +0000
Date: Sun, 18 Feb 2024 00:02:47 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
Message-ID: <202402172345.crcmOhf2-lkp@intel.com>
References: <20240215145602.1371274-15-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145602.1371274-15-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240215]
[cannot apply to akpm-mm/mm-everything char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus powerpc/next powerpc/fixes linus/master v6.8-rc4 v6.8-rc3 v6.8-rc2 v6.8-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/drivers-add-missing-includes-on-linux-mm-h-and-others/20240215-225853
base:   next-20240215
patch link:    https://lore.kernel.org/r/20240215145602.1371274-15-max.kellermann%40ionos.com
patch subject: [PATCH v1 14/14] include: reduce dependencies on linux/mm.h
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20240217/202402172345.crcmOhf2-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402172345.crcmOhf2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402172345.crcmOhf2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   lib/scatterlist.c: In function 'sg_page_count':
>> lib/scatterlist.c:739:16: error: implicit declaration of function 'PAGE_ALIGN'; did you mean 'PTR_ALIGN'? [-Werror=implicit-function-declaration]
     739 |         return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
         |                ^~~~~~~~~~
         |                PTR_ALIGN
   lib/scatterlist.c: In function 'extract_user_to_sg':
>> lib/scatterlist.c:1153:17: error: implicit declaration of function 'unpin_user_page'; did you mean 'copy_user_page'? [-Werror=implicit-function-declaration]
    1153 |                 unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
         |                 ^~~~~~~~~~~~~~~
         |                 copy_user_page
   lib/scatterlist.c: In function 'extract_kvec_to_sg':
>> lib/scatterlist.c:1239:29: error: implicit declaration of function 'is_vmalloc_or_module_addr' [-Werror=implicit-function-declaration]
    1239 |                         if (is_vmalloc_or_module_addr((void *)kaddr))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/scatterlist.c:1240:40: error: implicit declaration of function 'vmalloc_to_page'; did you mean 'vmalloc_nr_pages'? [-Werror=implicit-function-declaration]
    1240 |                                 page = vmalloc_to_page((void *)kaddr);
         |                                        ^~~~~~~~~~~~~~~
         |                                        vmalloc_nr_pages
>> lib/scatterlist.c:1240:38: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1240 |                                 page = vmalloc_to_page((void *)kaddr);
         |                                      ^
   cc1: some warnings being treated as errors
--
   In file included from include/linux/mm_inline.h:6,
                    from mm/mmu_gather.c:6:
>> include/linux/huge_mm.h:12:19: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      12 |                   pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
         |                   ^~~~~
         |                   pgd_t
   include/linux/huge_mm.h:12:35: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      12 |                   pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
         |                                   ^~~~~
         |                                   pgd_t
>> include/linux/huge_mm.h:16:19: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
      16 |                   pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
         |                   ^~~~~
         |                   pgd_t
   include/linux/huge_mm.h:16:35: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
      16 |                   pud_t *dst_pud, pud_t *src_pud, unsigned long addr,
         |                                   ^~~~~
         |                                   pgd_t
   include/linux/huge_mm.h:22:64: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
      22 | static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
         |                                                                ^~~~~
         |                                                                pgd_t
   include/linux/huge_mm.h:29:28: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      29 |                            pmd_t *pmd, unsigned long addr, unsigned long next);
         |                            ^~~~~
         |                            pgd_t
   include/linux/huge_mm.h:30:70: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      30 | int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma, pmd_t *pmd,
         |                                                                      ^~~~~
         |                                                                      pgd_t
   include/linux/huge_mm.h:32:70: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
      32 | int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma, pud_t *pud,
         |                                                                      ^~~~~
         |                                                                      pgd_t
   include/linux/huge_mm.h:35:44: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      35 |                    unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd);
         |                                            ^~~~~
         |                                            pgd_t
   include/linux/huge_mm.h:35:60: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      35 |                    unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd);
         |                                                            ^~~~~
         |                                                            pgd_t
   include/linux/huge_mm.h:37:21: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
      37 |                     pmd_t *pmd, unsigned long addr, pgprot_t newprot,
         |                     ^~~~~
         |                     pgd_t
   include/linux/huge_mm.h:437:65: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     437 | static inline void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
         |                                                                 ^~~~~
         |                                                                 pgd_t
   include/linux/huge_mm.h:464:31: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     464 | static inline int is_swap_pmd(pmd_t pmd)
         |                               ^~~~~
         |                               pgd_t
   include/linux/huge_mm.h:468:47: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     468 | static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
         |                                               ^~~~~
         |                                               pgd_t
   include/linux/huge_mm.h:473:47: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     473 | static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
         |                                               ^~~~~
         |                                               pgd_t
   include/linux/huge_mm.h:489:37: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     489 | static inline bool is_huge_zero_pmd(pmd_t pmd)
         |                                     ^~~~~
         |                                     pgd_t
   include/linux/huge_mm.h:494:37: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     494 | static inline bool is_huge_zero_pud(pud_t pud)
         |                                     ^~~~~
         |                                     pgd_t
   include/linux/huge_mm.h:505:29: error: unknown type name 'pmd_t'; did you mean 'pgd_t'?
     505 |         unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
         |                             ^~~~~
         |                             pgd_t
   include/linux/huge_mm.h:511:29: error: unknown type name 'pud_t'; did you mean 'pgd_t'?
     511 |         unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
         |                             ^~~~~
         |                             pgd_t


vim +739 lib/scatterlist.c

a321e91b6d73ed Imre Deak 2013-02-27  736  
a321e91b6d73ed Imre Deak 2013-02-27  737  static int sg_page_count(struct scatterlist *sg)
a321e91b6d73ed Imre Deak 2013-02-27  738  {
a321e91b6d73ed Imre Deak 2013-02-27 @739  	return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
a321e91b6d73ed Imre Deak 2013-02-27  740  }
a321e91b6d73ed Imre Deak 2013-02-27  741  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

