Return-Path: <linux-kernel+bounces-15480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3452822C90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586601F223A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4841C284;
	Wed,  3 Jan 2024 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVQZfmuJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892301C2A1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704283048; x=1735819048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FOPeXbjJ77c/Z5hxK8G6Z5lgHiNNwr1dCdzU2FnUHQ=;
  b=aVQZfmuJHUkTECzRmM5brB3IouZiZHIPYYJXRK1hfnVQczkwXbSC4nER
   d3uvNvFERUc8CmmTsx0LV1sPJpNHQxOMN13yWzxW1twS0zvcTCGJ0wrv0
   WvCqYEHdoBZqUpbdPjOy0nurwijubz6k+G+coeE7GfHkQvEHKI/ddidwk
   GnZ0/xNW8e+mqfjg68ieVYhMlxHcSzOG9jUb+MQuHUOVUv8h9NuwPgKb/
   iq75936rWJsHn9Khcj23GWeWUMPrgF5OklPRwI5IicNaAx9+fq+aHF5Rr
   ia1klq8HQKCPR0euUdG2XNYNjl1xPwYpPCSDUoR2J/l8ctkpSvPnaUj5w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15640898"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="15640898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:57:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="756195431"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="756195431"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2024 03:57:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rKzs7-000M2m-2U;
	Wed, 03 Jan 2024 11:57:19 +0000
Date: Wed, 3 Jan 2024 19:56:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v2 9/9] mm/swap, shmem: use new swapin helper to skip
 readahead conditionally
Message-ID: <202401031953.WBMZtIe7-lkp@intel.com>
References: <20240102175338.62012-10-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102175338.62012-10-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20240103]
[cannot apply to linus/master v6.7-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swapfile-c-add-back-some-comment/20240103-015650
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240102175338.62012-10-ryncsn%40gmail.com
patch subject: [PATCH v2 9/9] mm/swap, shmem: use new swapin helper to skip readahead conditionally
config: arm-randconfig-004-20240103 (https://download.01.org/0day-ci/archive/20240103/202401031953.WBMZtIe7-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project baf8a39aaf8b61a38b5b2b5591deb765e42eb00b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240103/202401031953.WBMZtIe7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401031953.WBMZtIe7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/shmem.c:1864:8: error: incompatible pointer types assigning to 'struct folio *' from 'struct page *' [-Werror,-Wincompatible-pointer-types]
    1864 |         folio = swapin_entry_mpol(swap, gfp, mpol, ilx, &cache_result);
         |               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +1864 mm/shmem.c

  1826	
  1827	/*
  1828	 * Swap in the folio pointed to by *foliop.
  1829	 * Caller has to make sure that *foliop contains a valid swapped folio.
  1830	 * Returns 0 and the folio in foliop if success. On failure, returns the
  1831	 * error code and NULL in *foliop.
  1832	 */
  1833	static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
  1834				     struct folio **foliop, enum sgp_type sgp,
  1835				     gfp_t gfp, struct mm_struct *fault_mm,
  1836				     vm_fault_t *fault_type)
  1837	{
  1838		struct address_space *mapping = inode->i_mapping;
  1839		struct shmem_inode_info *info = SHMEM_I(inode);
  1840		enum swap_cache_result cache_result;
  1841		struct swap_info_struct *si;
  1842		struct folio *folio = NULL;
  1843		struct mempolicy *mpol;
  1844		swp_entry_t swap;
  1845		pgoff_t ilx;
  1846		int error;
  1847	
  1848		VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
  1849		swap = radix_to_swp_entry(*foliop);
  1850		*foliop = NULL;
  1851	
  1852		if (is_poisoned_swp_entry(swap))
  1853			return -EIO;
  1854	
  1855		si = get_swap_device(swap);
  1856		if (!si) {
  1857			if (!shmem_confirm_swap(mapping, index, swap))
  1858				return -EEXIST;
  1859			else
  1860				return -EINVAL;
  1861		}
  1862	
  1863		mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
> 1864		folio = swapin_entry_mpol(swap, gfp, mpol, ilx, &cache_result);
  1865		mpol_cond_put(mpol);
  1866	
  1867		if (!folio) {
  1868			error = -ENOMEM;
  1869			goto failed;
  1870		}
  1871		if (cache_result != SWAP_CACHE_HIT) {
  1872			if (fault_type) {
  1873				*fault_type |= VM_FAULT_MAJOR;
  1874				count_vm_event(PGMAJFAULT);
  1875				count_memcg_event_mm(fault_mm, PGMAJFAULT);
  1876			}
  1877		}
  1878	
  1879		/* We have to do this with folio locked to prevent races */
  1880		folio_lock(folio);
  1881		if (cache_result != SWAP_CACHE_BYPASS) {
  1882			/* With cache bypass, folio is new allocated, sync, and not in cache */
  1883			if (!folio_test_swapcache(folio) || folio->swap.val != swap.val) {
  1884				error = -EEXIST;
  1885				goto unlock;
  1886			}
  1887			if (!folio_test_uptodate(folio)) {
  1888				error = -EIO;
  1889				goto failed;
  1890			}
  1891			folio_wait_writeback(folio);
  1892		}
  1893		if (!shmem_confirm_swap(mapping, index, swap)) {
  1894			error = -EEXIST;
  1895			goto unlock;
  1896		}
  1897	
  1898		/*
  1899		 * Some architectures may have to restore extra metadata to the
  1900		 * folio after reading from swap.
  1901		 */
  1902		arch_swap_restore(swap, folio);
  1903	
  1904		/* With cache bypass, folio is new allocated and always respect gfp flags */
  1905		if (cache_result != SWAP_CACHE_BYPASS && shmem_should_replace_folio(folio, gfp)) {
  1906			error = shmem_replace_folio(&folio, gfp, info, index);
  1907			if (error)
  1908				goto failed;
  1909		}
  1910	
  1911		/*
  1912		 * The expected value checking below should be enough to ensure
  1913		 * only one up-to-date swapin success. swap_free() is called after
  1914		 * this, so the entry can't be reused. As long as the mapping still
  1915		 * has the old entry value, it's never swapped in or modified.
  1916		 */
  1917		error = shmem_add_to_page_cache(folio, mapping, index,
  1918						swp_to_radix_entry(swap), gfp);
  1919		if (error)
  1920			goto failed;
  1921	
  1922		shmem_recalc_inode(inode, 0, -1);
  1923	
  1924		if (sgp == SGP_WRITE)
  1925			folio_mark_accessed(folio);
  1926	
  1927		if (cache_result != SWAP_CACHE_BYPASS)
  1928			delete_from_swap_cache(folio);
  1929		folio_mark_dirty(folio);
  1930		swap_free(swap);
  1931		put_swap_device(si);
  1932	
  1933		*foliop = folio;
  1934		return 0;
  1935	failed:
  1936		if (!shmem_confirm_swap(mapping, index, swap))
  1937			error = -EEXIST;
  1938		if (error == -EIO)
  1939			shmem_set_folio_swapin_error(inode, index, folio, swap);
  1940	unlock:
  1941		if (folio) {
  1942			folio_unlock(folio);
  1943			folio_put(folio);
  1944		}
  1945		put_swap_device(si);
  1946	
  1947		return error;
  1948	}
  1949	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

