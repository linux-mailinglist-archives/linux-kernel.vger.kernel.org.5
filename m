Return-Path: <linux-kernel+bounces-15539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823A822D87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C406283AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9511945E;
	Wed,  3 Jan 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q45D+nEF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD321944F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704286263; x=1735822263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYziqKdQfSgXfcOt7uAj0Nx4BYS3Yqk3BF3UVFmBCH0=;
  b=Q45D+nEFce4BiKgKbUsNgGSJH2BxCds6UzHGGkGbioLKYRizb/maF+Ln
   2YF6CE8TZgKwYHtDTBcXAa3ImcmDnn8WqtZSIB+BDjap7Yi6q4GjSjOTX
   unB1XQVEJJm+I+vryfp8P+oOsRwdTnm0Yjns/h86DIHtZjti7pMEjsVll
   ZvHSxsNIcUWtIkcf7wUE5QplMCphky/8op37TrvTtkwqeFgiEqTcxvswK
   /nVVEQOVUbVog9tsThD+6++8Llr/Qx8ZZD9ZkCEqr6vUz8BPZ8sGPqT3R
   GwQxuEqi2dfbqd3F5vjPz6KJNGoyLzh3aF1b+sOWQEiWVOyqF9AeKq+ml
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="10606488"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="10606488"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 04:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="850430030"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="850430030"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2024 04:50:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL0i0-000M5f-0w;
	Wed, 03 Jan 2024 12:50:56 +0000
Date: Wed, 3 Jan 2024 20:50:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v2 7/9] mm/swap: avoid a duplicated swap cache lookup for
 SWP_SYNCHRONOUS_IO
Message-ID: <202401032010.yrIDf885-lkp@intel.com>
References: <20240102175338.62012-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102175338.62012-8-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20240103]
[cannot apply to linus/master v6.7-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swapfile-c-add-back-some-comment/20240103-015650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240102175338.62012-8-ryncsn%40gmail.com
patch subject: [PATCH v2 7/9] mm/swap: avoid a duplicated swap cache lookup for SWP_SYNCHRONOUS_IO
config: arc-vdk_hs38_smp_defconfig (https://download.01.org/0day-ci/archive/20240103/202401032010.yrIDf885-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401032010.yrIDf885-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401032010.yrIDf885-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/swap_state.c:884: warning: Function parameter or member 'shadow' not described in 'swapin_direct'


vim +884 mm/swap_state.c

d9bfcfdc41e8e5 Huang Ying  2017-09-06  872  
b16a5db0ccd159 Kairui Song 2024-01-03  873  /**
b16a5db0ccd159 Kairui Song 2024-01-03  874   * swapin_direct - swap in folios skipping swap cache and readahead
b16a5db0ccd159 Kairui Song 2024-01-03  875   * @entry: swap entry of this memory
b16a5db0ccd159 Kairui Song 2024-01-03  876   * @gfp_mask: memory allocation flags
b16a5db0ccd159 Kairui Song 2024-01-03  877   * @vmf: fault information
b16a5db0ccd159 Kairui Song 2024-01-03  878   *
b16a5db0ccd159 Kairui Song 2024-01-03  879   * Returns the struct folio for entry and addr after the swap entry is read
b16a5db0ccd159 Kairui Song 2024-01-03  880   * in.
b16a5db0ccd159 Kairui Song 2024-01-03  881   */
983c0b807f7eda Kairui Song 2024-01-03  882  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
cd81b9fd3de376 Kairui Song 2024-01-03  883  				  struct vm_fault *vmf, void *shadow)
b16a5db0ccd159 Kairui Song 2024-01-03 @884  {
b16a5db0ccd159 Kairui Song 2024-01-03  885  	struct vm_area_struct *vma = vmf->vma;
b16a5db0ccd159 Kairui Song 2024-01-03  886  	struct folio *folio;
b16a5db0ccd159 Kairui Song 2024-01-03  887  
b16a5db0ccd159 Kairui Song 2024-01-03  888  	/* skip swapcache */
b16a5db0ccd159 Kairui Song 2024-01-03  889  	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
b16a5db0ccd159 Kairui Song 2024-01-03  890  				vma, vmf->address, false);
b16a5db0ccd159 Kairui Song 2024-01-03  891  	if (folio) {
9e22e4254bdb8c Kairui Song 2024-01-03  892  		if (mem_cgroup_swapin_charge_folio(folio, NULL,
64ae20cbed3891 Kairui Song 2024-01-03  893  						   GFP_KERNEL, entry)) {
b16a5db0ccd159 Kairui Song 2024-01-03  894  			folio_put(folio);
b16a5db0ccd159 Kairui Song 2024-01-03  895  			return NULL;
b16a5db0ccd159 Kairui Song 2024-01-03  896  		}
64ae20cbed3891 Kairui Song 2024-01-03  897  
64ae20cbed3891 Kairui Song 2024-01-03  898  		__folio_set_locked(folio);
64ae20cbed3891 Kairui Song 2024-01-03  899  		__folio_set_swapbacked(folio);
64ae20cbed3891 Kairui Song 2024-01-03  900  
b16a5db0ccd159 Kairui Song 2024-01-03  901  		mem_cgroup_swapin_uncharge_swap(entry);
b16a5db0ccd159 Kairui Song 2024-01-03  902  
b16a5db0ccd159 Kairui Song 2024-01-03  903  		if (shadow)
b16a5db0ccd159 Kairui Song 2024-01-03  904  			workingset_refault(folio, shadow);
b16a5db0ccd159 Kairui Song 2024-01-03  905  
b16a5db0ccd159 Kairui Song 2024-01-03  906  		folio_add_lru(folio);
b16a5db0ccd159 Kairui Song 2024-01-03  907  
b16a5db0ccd159 Kairui Song 2024-01-03  908  		/* To provide entry to swap_read_folio() */
b16a5db0ccd159 Kairui Song 2024-01-03  909  		folio->swap = entry;
b16a5db0ccd159 Kairui Song 2024-01-03  910  		swap_read_folio(folio, true, NULL);
b16a5db0ccd159 Kairui Song 2024-01-03  911  		folio->private = NULL;
b16a5db0ccd159 Kairui Song 2024-01-03  912  	}
b16a5db0ccd159 Kairui Song 2024-01-03  913  
b16a5db0ccd159 Kairui Song 2024-01-03  914  	return folio;
b16a5db0ccd159 Kairui Song 2024-01-03  915  }
b16a5db0ccd159 Kairui Song 2024-01-03  916  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

