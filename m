Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24D476733D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjG1RZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjG1RZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:25:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A6E72
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690565130; x=1722101130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3OMEL78n+IiszhIQ/pV+083zZcBq7zO+EddRxlkRz3Q=;
  b=YJc5deb5gCJfdsyyPCWOePghaWsyurSrjz4PTnddsF2kbdX2XVmBtsn3
   KTtEACD0vuDF2M1Tv/S43ucVEkmQg0sy5TQtWJVMD31wkCtaEjykS0cus
   +HZaAv7b3glAco2byp3cQ/QNHq4gZinQpnRbovWACwk3YxmuH2TWUdqtS
   8VaS5MvszfIvGhhBNvKf0AGyq6g5I2N+MQyjOJtu/A6k+Fo0oZ5wFoHJf
   nzLZoF7br8xNQbGByI5kgrlZ+uCrOGnKyMns8cTN2auvFOTIJNDWrQ0AO
   9U3uhVj9z2nqjpjlwVtwm5fS1FcPWc/VgSTpkHQWCTzZjiPebB698R0Sz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="434930887"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="434930887"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727556235"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="727556235"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 10:25:26 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPRDG-0003QR-1z;
        Fri, 28 Jul 2023 17:25:16 +0000
Date:   Sat, 29 Jul 2023 01:25:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: Re: [v1 6/6] mm: hugetlb: Skip initialization of struct pages freed
 later by HVO
Message-ID: <202307290124.suQ4U8Y4-lkp@intel.com>
References: <20230727204624.1942372-7-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-7-usama.arif@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-hugetlb-Skip-prep-of-tail-pages-when-HVO-is-enabled/20230728-044839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230727204624.1942372-7-usama.arif%40bytedance.com
patch subject: [v1 6/6] mm: hugetlb: Skip initialization of struct pages freed later by HVO
config: arm64-randconfig-r032-20230727 (https://download.01.org/0day-ci/archive/20230729/202307290124.suQ4U8Y4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290124.suQ4U8Y4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290124.suQ4U8Y4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/hugetlb.c:49:
   mm/hugetlb_vmemmap.h:56:6: warning: no previous prototype for function 'vmemmap_should_optimize' [-Wmissing-prototypes]
      56 | bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
         |      ^
   mm/hugetlb_vmemmap.h:56:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      56 | bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
         | ^
         | static 
>> mm/hugetlb.c:3198:3: error: use of undeclared identifier 'HUGETLB_VMEMMAP_RESERVE_SIZE'
    3198 |                 HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
         |                 ^
   1 warning and 1 error generated.


vim +/HUGETLB_VMEMMAP_RESERVE_SIZE +3198 mm/hugetlb.c

  3190	
  3191	int alloc_bootmem_huge_page(struct hstate *h, int nid)
  3192		__attribute__ ((weak, alias("__alloc_bootmem_huge_page")));
  3193	int __alloc_bootmem_huge_page(struct hstate *h, int nid)
  3194	{
  3195		struct huge_bootmem_page *m = NULL; /* initialize for clang */
  3196		int nr_nodes, node;
  3197		phys_addr_t hugetlb_vmemmap_reserve_size =
> 3198			HUGETLB_VMEMMAP_RESERVE_SIZE * sizeof(struct page);
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
  3210					(void *)((phys_addr_t) m + hugetlb_vmemmap_reserve_size));
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
