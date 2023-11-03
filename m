Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0447E08BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbjKCTFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:05:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFB518B;
        Fri,  3 Nov 2023 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699038307; x=1730574307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v4Q76Y0k4JvYfqZK2e7ceG8EVC8GXluxxTlYJRhsXzs=;
  b=Bt3bmhzo+S5uzL69v8AlIWHaygbFPoNyZkRn92ntqx5THSRXxIwKhMVc
   3IrBQYpLZRB5OTlpw4fgDlnXxX1XwF7XCx2Zt7T2PHYwbyX0ubgpflvy5
   zsiTP5SOVLYA1SEyGB5rBkM/yjheWwbrFPIY/ySxw9SSp8Afzh2/yAy0t
   Fb1A+/cN2wBwHxGwM1ZGGREFHEgk0HXy5Z8fALq6c0lCTmVvavYZEEUm9
   mZbV8iTD9pg93fUvbKVOiwc4avvZosima3WwZQ/yfByfQM304/88dckwE
   1TLpUA9j+nPkOTpILIK2v5iVFWv5Pe+IFFGtdNHVdMNlNCjo2Z6mC0U9+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="388829159"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="388829159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 12:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="9478546"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2023 12:05:04 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyzTZ-0002rE-1s;
        Fri, 03 Nov 2023 19:05:01 +0000
Date:   Sat, 4 Nov 2023 03:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 16/18] mm: use a folio in zap_pte_range()
Message-ID: <202311040217.GgQqqwfS-lkp@intel.com>
References: <20231103140119.2306578-17-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103140119.2306578-17-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-add-mm_counter_folio-and-mm_counter_file_folio/20231103-221846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231103140119.2306578-17-wangkefeng.wang%40huawei.com
patch subject: [PATCH 16/18] mm: use a folio in zap_pte_range()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231104/202311040217.GgQqqwfS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040217.GgQqqwfS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040217.GgQqqwfS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/memory.c:43:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/memory.c:43:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/memory.c:43:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> mm/memory.c:1497:22: warning: variable 'page' is uninitialized when used here [-Wuninitialized]
    1497 |                                 page_remove_rmap(page, vma, false);
         |                                                  ^~~~
   mm/memory.c:1427:20: note: initialize the variable 'page' to silence this warning
    1427 |                 struct page *page;
         |                                  ^
         |                                   = NULL
   13 warnings generated.


vim +/page +1497 mm/memory.c

999dad824c39ed Peter Xu              2022-05-12  1402  
51c6f666fceb31 Robin Holt            2005-11-13  1403  static unsigned long zap_pte_range(struct mmu_gather *tlb,
b5810039a54e5b Nicholas Piggin       2005-10-29  1404  				struct vm_area_struct *vma, pmd_t *pmd,
^1da177e4c3f41 Linus Torvalds        2005-04-16  1405  				unsigned long addr, unsigned long end,
97a894136f2980 Peter Zijlstra        2011-05-24  1406  				struct zap_details *details)
^1da177e4c3f41 Linus Torvalds        2005-04-16  1407  {
b5810039a54e5b Nicholas Piggin       2005-10-29  1408  	struct mm_struct *mm = tlb->mm;
d16dfc550f5326 Peter Zijlstra        2011-05-24  1409  	int force_flush = 0;
d559db086ff5be KAMEZAWA Hiroyuki     2010-03-05  1410  	int rss[NR_MM_COUNTERS];
97a894136f2980 Peter Zijlstra        2011-05-24  1411  	spinlock_t *ptl;
5f1a19070b16c2 Steven Rostedt        2011-06-15  1412  	pte_t *start_pte;
97a894136f2980 Peter Zijlstra        2011-05-24  1413  	pte_t *pte;
8a5f14a2317706 Kirill A. Shutemov    2015-02-10  1414  	swp_entry_t entry;
d559db086ff5be KAMEZAWA Hiroyuki     2010-03-05  1415  
ed6a79352cad00 Peter Zijlstra        2018-08-31  1416  	tlb_change_page_size(tlb, PAGE_SIZE);
e303297e6c3a7b Peter Zijlstra        2011-05-24  1417  	init_rss_vec(rss);
3db82b9374ca92 Hugh Dickins          2023-06-08  1418  	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
3db82b9374ca92 Hugh Dickins          2023-06-08  1419  	if (!pte)
3db82b9374ca92 Hugh Dickins          2023-06-08  1420  		return addr;
3db82b9374ca92 Hugh Dickins          2023-06-08  1421  
3ea277194daaea Mel Gorman            2017-08-02  1422  	flush_tlb_batched_pending(mm);
6606c3e0da5360 Zachary Amsden        2006-09-30  1423  	arch_enter_lazy_mmu_mode();
^1da177e4c3f41 Linus Torvalds        2005-04-16  1424  	do {
c33c794828f212 Ryan Roberts          2023-06-12  1425  		pte_t ptent = ptep_get(pte);
bdec140a4ef8da Kefeng Wang           2023-11-03  1426  		struct folio *folio = NULL;
8018db8525947c Peter Xu              2022-03-22  1427  		struct page *page;
8018db8525947c Peter Xu              2022-03-22  1428  
166f61b9435a1b Tobin C Harding       2017-02-24  1429  		if (pte_none(ptent))
^1da177e4c3f41 Linus Torvalds        2005-04-16  1430  			continue;
51c6f666fceb31 Robin Holt            2005-11-13  1431  
7b167b681013f5 Minchan Kim           2019-09-24  1432  		if (need_resched())
7b167b681013f5 Minchan Kim           2019-09-24  1433  			break;
7b167b681013f5 Minchan Kim           2019-09-24  1434  
6f5e6b9e69bf04 Hugh Dickins          2006-03-16  1435  		if (pte_present(ptent)) {
5df397dec7c4c0 Linus Torvalds        2022-11-09  1436  			unsigned int delay_rmap;
5df397dec7c4c0 Linus Torvalds        2022-11-09  1437  
25b2995a35b609 Christoph Hellwig     2019-06-13  1438  			page = vm_normal_page(vma, addr, ptent);
bdec140a4ef8da Kefeng Wang           2023-11-03  1439  			if (page)
bdec140a4ef8da Kefeng Wang           2023-11-03  1440  				folio = page_folio(page);
bdec140a4ef8da Kefeng Wang           2023-11-03  1441  
bdec140a4ef8da Kefeng Wang           2023-11-03  1442  			if (unlikely(!should_zap_page(details, folio)))
^1da177e4c3f41 Linus Torvalds        2005-04-16  1443  				continue;
b5810039a54e5b Nicholas Piggin       2005-10-29  1444  			ptent = ptep_get_and_clear_full(mm, addr, pte,
a600388d284193 Zachary Amsden        2005-09-03  1445  							tlb->fullmm);
e5136e876581ba Rick Edgecombe        2023-06-12  1446  			arch_check_zapped_pte(vma, ptent);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1447  			tlb_remove_tlb_entry(tlb, pte, addr);
999dad824c39ed Peter Xu              2022-05-12  1448  			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
999dad824c39ed Peter Xu              2022-05-12  1449  						      ptent);
e2942062e01df8 xu xin                2023-06-13  1450  			if (unlikely(!page)) {
6080d19f07043a xu xin                2023-06-13  1451  				ksm_might_unmap_zero_page(mm, ptent);
^1da177e4c3f41 Linus Torvalds        2005-04-16  1452  				continue;
e2942062e01df8 xu xin                2023-06-13  1453  			}
eca56ff906bdd0 Jerome Marchand       2016-01-14  1454  
5df397dec7c4c0 Linus Torvalds        2022-11-09  1455  			delay_rmap = 0;
bdec140a4ef8da Kefeng Wang           2023-11-03  1456  			if (!folio_test_anon(folio)) {
1cf35d47712dd5 Linus Torvalds        2014-04-25  1457  				if (pte_dirty(ptent)) {
bdec140a4ef8da Kefeng Wang           2023-11-03  1458  					folio_set_dirty(folio);
5df397dec7c4c0 Linus Torvalds        2022-11-09  1459  					if (tlb_delay_rmap(tlb)) {
5df397dec7c4c0 Linus Torvalds        2022-11-09  1460  						delay_rmap = 1;
5df397dec7c4c0 Linus Torvalds        2022-11-09  1461  						force_flush = 1;
5df397dec7c4c0 Linus Torvalds        2022-11-09  1462  					}
1cf35d47712dd5 Linus Torvalds        2014-04-25  1463  				}
8788f678148676 Yu Zhao               2022-12-30  1464  				if (pte_young(ptent) && likely(vma_has_recency(vma)))
bdec140a4ef8da Kefeng Wang           2023-11-03  1465  					folio_mark_accessed(folio);
6237bcd94851e9 Hugh Dickins          2005-10-29  1466  			}
bdec140a4ef8da Kefeng Wang           2023-11-03  1467  			rss[mm_counter_folio(folio)]--;
5df397dec7c4c0 Linus Torvalds        2022-11-09  1468  			if (!delay_rmap) {
cea86fe246b694 Hugh Dickins          2022-02-14  1469  				page_remove_rmap(page, vma, false);
3dc147414ccad8 Hugh Dickins          2009-01-06  1470  				if (unlikely(page_mapcount(page) < 0))
3dc147414ccad8 Hugh Dickins          2009-01-06  1471  					print_bad_pte(vma, addr, ptent, page);
5df397dec7c4c0 Linus Torvalds        2022-11-09  1472  			}
5df397dec7c4c0 Linus Torvalds        2022-11-09  1473  			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
1cf35d47712dd5 Linus Torvalds        2014-04-25  1474  				force_flush = 1;
ce9ec37bddb633 Will Deacon           2014-10-28  1475  				addr += PAGE_SIZE;
d16dfc550f5326 Peter Zijlstra        2011-05-24  1476  				break;
1cf35d47712dd5 Linus Torvalds        2014-04-25  1477  			}
^1da177e4c3f41 Linus Torvalds        2005-04-16  1478  			continue;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1479  		}
5042db43cc26f5 Jérôme Glisse         2017-09-08  1480  
5042db43cc26f5 Jérôme Glisse         2017-09-08  1481  		entry = pte_to_swp_entry(ptent);
b756a3b5e7ead8 Alistair Popple       2021-06-30  1482  		if (is_device_private_entry(entry) ||
b756a3b5e7ead8 Alistair Popple       2021-06-30  1483  		    is_device_exclusive_entry(entry)) {
bdec140a4ef8da Kefeng Wang           2023-11-03  1484  			folio = pfn_swap_entry_to_folio(entry);
bdec140a4ef8da Kefeng Wang           2023-11-03  1485  			if (unlikely(!should_zap_page(details, folio)))
5042db43cc26f5 Jérôme Glisse         2017-09-08  1486  				continue;
bdec140a4ef8da Kefeng Wang           2023-11-03  1487  
999dad824c39ed Peter Xu              2022-05-12  1488  			/*
999dad824c39ed Peter Xu              2022-05-12  1489  			 * Both device private/exclusive mappings should only
999dad824c39ed Peter Xu              2022-05-12  1490  			 * work with anonymous page so far, so we don't need to
999dad824c39ed Peter Xu              2022-05-12  1491  			 * consider uffd-wp bit when zap. For more information,
999dad824c39ed Peter Xu              2022-05-12  1492  			 * see zap_install_uffd_wp_if_needed().
999dad824c39ed Peter Xu              2022-05-12  1493  			 */
999dad824c39ed Peter Xu              2022-05-12  1494  			WARN_ON_ONCE(!vma_is_anonymous(vma));
bdec140a4ef8da Kefeng Wang           2023-11-03  1495  			rss[mm_counter_folio(folio)]--;
b756a3b5e7ead8 Alistair Popple       2021-06-30  1496  			if (is_device_private_entry(entry))
cea86fe246b694 Hugh Dickins          2022-02-14 @1497  				page_remove_rmap(page, vma, false);
bdec140a4ef8da Kefeng Wang           2023-11-03  1498  			folio_put(folio);
8018db8525947c Peter Xu              2022-03-22  1499  		} else if (!non_swap_entry(entry)) {
5abfd71d936a8a Peter Xu              2022-03-22  1500  			/* Genuine swap entry, hence a private anon page */
5abfd71d936a8a Peter Xu              2022-03-22  1501  			if (!should_zap_cows(details))
^1da177e4c3f41 Linus Torvalds        2005-04-16  1502  				continue;
b084d4353ff99d KAMEZAWA Hiroyuki     2010-03-05  1503  			rss[MM_SWAPENTS]--;
8018db8525947c Peter Xu              2022-03-22  1504  			if (unlikely(!free_swap_and_cache(entry)))
8018db8525947c Peter Xu              2022-03-22  1505  				print_bad_pte(vma, addr, ptent, NULL);
5abfd71d936a8a Peter Xu              2022-03-22  1506  		} else if (is_migration_entry(entry)) {
bdec140a4ef8da Kefeng Wang           2023-11-03  1507  			folio = pfn_swap_entry_to_folio(entry);
bdec140a4ef8da Kefeng Wang           2023-11-03  1508  			if (!should_zap_page(details, folio))
5abfd71d936a8a Peter Xu              2022-03-22  1509  				continue;
bdec140a4ef8da Kefeng Wang           2023-11-03  1510  			rss[mm_counter_folio(folio)]--;
999dad824c39ed Peter Xu              2022-05-12  1511  		} else if (pte_marker_entry_uffd_wp(entry)) {
2bad466cc9d9b4 Peter Xu              2023-03-09  1512  			/*
2bad466cc9d9b4 Peter Xu              2023-03-09  1513  			 * For anon: always drop the marker; for file: only
2bad466cc9d9b4 Peter Xu              2023-03-09  1514  			 * drop the marker if explicitly requested.
2bad466cc9d9b4 Peter Xu              2023-03-09  1515  			 */
2bad466cc9d9b4 Peter Xu              2023-03-09  1516  			if (!vma_is_anonymous(vma) &&
2bad466cc9d9b4 Peter Xu              2023-03-09  1517  			    !zap_drop_file_uffd_wp(details))
999dad824c39ed Peter Xu              2022-05-12  1518  				continue;
9f186f9e5fa9eb Miaohe Lin            2022-05-19  1519  		} else if (is_hwpoison_entry(entry) ||
af19487f00f34f Axel Rasmussen        2023-07-07  1520  			   is_poisoned_swp_entry(entry)) {
5abfd71d936a8a Peter Xu              2022-03-22  1521  			if (!should_zap_cows(details))
5abfd71d936a8a Peter Xu              2022-03-22  1522  				continue;
5abfd71d936a8a Peter Xu              2022-03-22  1523  		} else {
5abfd71d936a8a Peter Xu              2022-03-22  1524  			/* We should have covered all the swap entry types */
5abfd71d936a8a Peter Xu              2022-03-22  1525  			WARN_ON_ONCE(1);
9f9f1acd713d69 Konstantin Khlebnikov 2012-01-20  1526  		}
9888a1cae3f859 Zachary Amsden        2006-09-30  1527  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
999dad824c39ed Peter Xu              2022-05-12  1528  		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
97a894136f2980 Peter Zijlstra        2011-05-24  1529  	} while (pte++, addr += PAGE_SIZE, addr != end);
ae859762332f19 Hugh Dickins          2005-10-29  1530  
d559db086ff5be KAMEZAWA Hiroyuki     2010-03-05  1531  	add_mm_rss_vec(mm, rss);
6606c3e0da5360 Zachary Amsden        2006-09-30  1532  	arch_leave_lazy_mmu_mode();
51c6f666fceb31 Robin Holt            2005-11-13  1533  
1cf35d47712dd5 Linus Torvalds        2014-04-25  1534  	/* Do the actual TLB flush before dropping ptl */
5df397dec7c4c0 Linus Torvalds        2022-11-09  1535  	if (force_flush) {
1cf35d47712dd5 Linus Torvalds        2014-04-25  1536  		tlb_flush_mmu_tlbonly(tlb);
5df397dec7c4c0 Linus Torvalds        2022-11-09  1537  		tlb_flush_rmaps(tlb, vma);
5df397dec7c4c0 Linus Torvalds        2022-11-09  1538  	}
1cf35d47712dd5 Linus Torvalds        2014-04-25  1539  	pte_unmap_unlock(start_pte, ptl);
1cf35d47712dd5 Linus Torvalds        2014-04-25  1540  
1cf35d47712dd5 Linus Torvalds        2014-04-25  1541  	/*
1cf35d47712dd5 Linus Torvalds        2014-04-25  1542  	 * If we forced a TLB flush (either due to running out of
1cf35d47712dd5 Linus Torvalds        2014-04-25  1543  	 * batch buffers or because we needed to flush dirty TLB
1cf35d47712dd5 Linus Torvalds        2014-04-25  1544  	 * entries before releasing the ptl), free the batched
3db82b9374ca92 Hugh Dickins          2023-06-08  1545  	 * memory too. Come back again if we didn't do everything.
1cf35d47712dd5 Linus Torvalds        2014-04-25  1546  	 */
3db82b9374ca92 Hugh Dickins          2023-06-08  1547  	if (force_flush)
fa0aafb8acb684 Peter Zijlstra        2018-09-20  1548  		tlb_flush_mmu(tlb);
d16dfc550f5326 Peter Zijlstra        2011-05-24  1549  
51c6f666fceb31 Robin Holt            2005-11-13  1550  	return addr;
^1da177e4c3f41 Linus Torvalds        2005-04-16  1551  }
^1da177e4c3f41 Linus Torvalds        2005-04-16  1552  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
