Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6396B7671E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjG1QfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjG1Qez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:34:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB86449E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690562087; x=1722098087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vq0+8lK1LOBofmSZdxT7FLCHIA8ARl33ApAwAmmruzQ=;
  b=nuEyBzvn5FK+LBWq6YXvoOUdIrz8Puc/GHwSdoKPuL37dPddmygQi6ii
   NJ4In+p8A4EOtob7PnFuEQzcP8yfYU8G5GQhH6EiogssFruWQocG6IP8c
   HcWhfrrfOxg8ppCZlVHwllv65H0IpDHh1urfUZEjMJZoh5Tnx4UztULeF
   KkD8DAnPURckn5bx8bLR3kJScheRQD9bElqH0ILJxHC62CtqygqVz5J6m
   5jsGTgpdOXLprgHZOzxPM9jtEH4I/skrqMZHGnmZhiLgaTiTcKc7oDEmx
   +pnA3toJTy86j901F/BLz2Wke6qz01UJz+pU5rldP+eouen95Xu1o+RJ7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371333600"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="371333600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792985287"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="792985287"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 09:34:29 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPQPj-0003Nr-2a;
        Fri, 28 Jul 2023 16:34:09 +0000
Date:   Sat, 29 Jul 2023 00:33:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        simon.evans@bytedance.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [v1 6/6] mm: hugetlb: Skip initialization of struct pages freed
 later by HVO
Message-ID: <202307290029.Kr5EEBeY-lkp@intel.com>
References: <20230727204624.1942372-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-7-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-hugetlb-Skip-prep-of-tail-pages-when-HVO-is-enabled/20230728-044839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230727204624.1942372-7-usama.arif%40bytedance.com
patch subject: [v1 6/6] mm: hugetlb: Skip initialization of struct pages freed later by HVO
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20230729/202307290029.Kr5EEBeY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290029.Kr5EEBeY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290029.Kr5EEBeY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/hugetlb.c:49:
   mm/hugetlb_vmemmap.h:56:6: warning: no previous prototype for 'vmemmap_should_optimize' [-Wmissing-prototypes]
      56 | bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   mm/hugetlb.c: In function '__alloc_bootmem_huge_page':
   mm/hugetlb.c:3198:17: error: 'HUGETLB_VMEMMAP_RESERVE_SIZE' undeclared (first use in this function)
    3198 |                 HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/hugetlb.c:3198:17: note: each undeclared identifier is reported only once for each function it appears in
>> mm/hugetlb.c:3210:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    3210 |                                 (void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
         |                                          ^
>> mm/hugetlb.c:3210:33: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3210 |                                 (void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
         |                                 ^
   mm/hugetlb.c:3233:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    3233 |                                 (void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
         |                                          ^
   mm/hugetlb.c:3233:33: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3233 |                                 (void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
         |                                 ^


vim +3210 mm/hugetlb.c

  3190	
  3191	int alloc_bootmem_huge_page(struct hstate *h, int nid)
  3192		__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
  3193	int __alloc_bootmem_huge_page(struct hstate *h, int nid)
  3194	{
  3195		struct huge_bootmem_page *m = NULL; /* initialize for clang */
  3196		int nr_nodes, node;
  3197		phys_addr_t hugetlb_vmemmap_reserve_size =
  3198			HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
  3199		phys_addr_t noinit_base;
  3200	
  3201		/* do node specific alloc */
  3202		if (nid != NUMA_NO_NODE) {
  3203			m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
  3204					0, MEMBLOCK_ALLOC_ACCESSIBLE, nid);
  3205			if (!m)
  3206				return 0;
  3207	
  3208			if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
  3209				noinit_base = virt_to_phys(
> 3210					(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
  3211				memblock_rsrv_mark_noinit(
  3212					noinit_base,
  3213					huge_page_size(h) - hugetlb_vmemmap_reserve_size);
  3214			}
  3215	
  3216			goto found;
  3217		}
  3218		/* allocate from next node when distributing huge pages */
  3219		for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
  3220			m = memblock_alloc_try_nid_raw(
  3221					huge_page_size(h), huge_page_size(h),
  3222					0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
  3223			/*
  3224			 * Use the beginning of the huge page to store the
  3225			 * huge_bootmem_page struct (until gather_bootmem
  3226			 * puts them into the mem_map).
  3227			 */
  3228			if (!m)
  3229				return 0;
  3230	
  3231			if (vmemmap_optimize_enabled && hugetlb_vmemmap_optimizable(h)) {
  3232				noinit_base = virt_to_phys(
  3233					(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
  3234				memblock_rsrv_mark_noinit(
  3235					noinit_base,
  3236					huge_page_size(h) - hugetlb_vmemmap_reserve_size);
  3237			}
  3238	
  3239			goto found;
  3240		}
  3241	
  3242	found:
  3243		/* Put them into a private list first because mem_map is not up yet */
  3244		INIT_LIST_HEAD(&m->list);
  3245		list_add(&m->list, &huge_boot_pages);
  3246		m->hstate = h;
  3247		return 1;
  3248	}
  3249	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
