Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA057F0A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjKTBIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjKTBID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:08:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F298C107
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 17:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700442479; x=1731978479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Afwg7Fdj8Ft7cQDd8qfi6qWAHO+5mdbO4VPlEFQ6/MY=;
  b=MGBcOS/j1m3iuoGqO/0qS2SUNc5hAtwpngXJaaJctoSPi/yWv7paILIa
   ZtI85DmOa33PvMrHN35FPaxenScFxNQyL7K6VAbqG6r1bmHAenhADXtH1
   Xy1d9r0sGuG8u1VJPpX2VcMk0Jd0voK8SMgtMvgj0x0h4AeoIYo2cNTar
   6wKIhdIviiXfeL2oLIaOaQQBf9LPoFxPk9NFGTxzWXN8mF/oARMz5aDAF
   lTQ+Qk239MQkq+JxwGw2iKho38K9ofDG6+1WMDGEqzP7/nA87+/nZIvC8
   Ax6rofUymoULcmIO3LnqYLHIUpD3sfujIexjnibfcTarubpBtBFKUzhp1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="422627224"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="422627224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 17:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939646615"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939646615"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2023 17:07:55 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4slV-0005mJ-1C;
        Mon, 20 Nov 2023 01:07:53 +0000
Date:   Mon, 20 Nov 2023 09:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
Message-ID: <202311200850.FrQj7bMD-lkp@intel.com>
References: <20231119194740.94101-19-ryncsn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119194740.94101-19-ryncsn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.7-rc2 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-fix-a-potential-undefined-behavior-issue/20231120-035926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231119194740.94101-19-ryncsn%40gmail.com
patch subject: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
config: i386-buildonly-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231120/202311200850.FrQj7bMD-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200850.FrQj7bMD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200850.FrQj7bMD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/shmem.c:43:
   mm/swap.h:105:31: warning: declaration of 'enum swap_cache_result' will not be visible outside of this function [-Wvisibility]
                           struct vm_fault *vmf, enum swap_cache_result *result)
                                                      ^
   mm/swap.h:112:8: warning: declaration of 'enum swap_cache_result' will not be visible outside of this function [-Wvisibility]
                   enum swap_cache_result *result)
                        ^
>> mm/shmem.c:1841:25: error: variable has incomplete type 'enum swap_cache_result'
           enum swap_cache_result result;
                                  ^
   mm/shmem.c:1841:7: note: forward declaration of 'enum swap_cache_result'
           enum swap_cache_result result;
                ^
>> mm/shmem.c:1870:31: error: use of undeclared identifier 'SWAP_CACHE_HIT'
                   if (fault_type && result != SWAP_CACHE_HIT) {
                                               ^
>> mm/shmem.c:1879:17: error: use of undeclared identifier 'SWAP_CACHE_BYPASS'
           if ((result != SWAP_CACHE_BYPASS && !folio_test_swapcache(folio)) ||
                          ^
   2 warnings and 3 errors generated.


vim +1841 mm/shmem.c

  1827	
  1828	/*
  1829	 * Swap in the folio pointed to by *foliop.
  1830	 * Caller has to make sure that *foliop contains a valid swapped folio.
  1831	 * Returns 0 and the folio in foliop if success. On failure, returns the
  1832	 * error code and NULL in *foliop.
  1833	 */
  1834	static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  1835				     struct folio **foliop, enum sgp_type sgp,
  1836				     gfp_t gfp, struct mm_struct *fault_mm,
  1837				     vm_fault_t *fault_type)
  1838	{
  1839		struct address_space *mapping = inode->i_mapping;
  1840		struct shmem_inode_info *info = SHMEM_I(inode);
> 1841		enum swap_cache_result result;
  1842		struct folio *folio = NULL;
  1843		struct mempolicy *mpol;
  1844		struct page *page;
  1845		swp_entry_t swap;
  1846		pgoff_t ilx;
  1847		int error;
  1848	
  1849		VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
  1850		swap = radix_to_swp_entry(*foliop);
  1851		*foliop = NULL;
  1852	
  1853		if (is_poisoned_swp_entry(swap))
  1854			return -EIO;
  1855	
  1856		mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
  1857		page = swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, &result);
  1858		mpol_cond_put(mpol);
  1859	
  1860		if (PTR_ERR(page) == -EBUSY) {
  1861			if (!shmem_confirm_swap(mapping, index, swap))
  1862				return -EEXIST;
  1863			else
  1864				return -EINVAL;
  1865		} else if (!page) {
  1866			error = -ENOMEM;
  1867			goto failed;
  1868		} else {
  1869			folio = page_folio(page);
> 1870			if (fault_type && result != SWAP_CACHE_HIT) {
  1871				*fault_type |= VM_FAULT_MAJOR;
  1872				count_vm_event(PGMAJFAULT);
  1873				count_memcg_event_mm(fault_mm, PGMAJFAULT);
  1874			}
  1875		}
  1876	
  1877		/* We have to do this with folio locked to prevent races */
  1878		folio_lock(folio);
> 1879		if ((result != SWAP_CACHE_BYPASS && !folio_test_swapcache(folio)) ||
  1880		    folio->swap.val != swap.val ||
  1881		    !shmem_confirm_swap(mapping, index, swap)) {
  1882			error = -EEXIST;
  1883			goto unlock;
  1884		}
  1885		if (!folio_test_uptodate(folio)) {
  1886			error = -EIO;
  1887			goto failed;
  1888		}
  1889		folio_wait_writeback(folio);
  1890	
  1891		/*
  1892		 * Some architectures may have to restore extra metadata to the
  1893		 * folio after reading from swap.
  1894		 */
  1895		arch_swap_restore(swap, folio);
  1896	
  1897		if (shmem_should_replace_folio(folio, gfp)) {
  1898			error = shmem_replace_folio(&folio, gfp, info, index);
  1899			if (error)
  1900				goto failed;
  1901		}
  1902	
  1903		error = shmem_add_to_page_cache(folio, mapping, index,
  1904						swp_to_radix_entry(swap), gfp);
  1905		if (error)
  1906			goto failed;
  1907	
  1908		shmem_recalc_inode(inode, 0, -1);
  1909	
  1910		if (sgp == SGP_WRITE)
  1911			folio_mark_accessed(folio);
  1912	
  1913		delete_from_swap_cache(folio);
  1914		folio_mark_dirty(folio);
  1915		swap_free(swap);
  1916	
  1917		*foliop = folio;
  1918		return 0;
  1919	failed:
  1920		if (!shmem_confirm_swap(mapping, index, swap))
  1921			error = -EEXIST;
  1922		if (error == -EIO)
  1923			shmem_set_folio_swapin_error(inode, index, folio, swap);
  1924	unlock:
  1925		if (folio) {
  1926			folio_unlock(folio);
  1927			folio_put(folio);
  1928		}
  1929	
  1930		return error;
  1931	}
  1932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
