Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFD78949E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHZICT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjHZICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:02:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE4910EF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693036923; x=1724572923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVpGnSBGvSJPKPCdKmhHM2u3QgUVXmp2aXiWFiOxQUA=;
  b=UyFYm6cFipwbGGwjL29JI0HfgSEdwwkVtX7YPSoLbIggVPcEUn0tsRAq
   IyhD7D1FmOHjbQRvItxlkrTW2LMwdD6OJUu8P4IrleupTqBWZOAaYVj/c
   xZ/sVbQqqSonhm5uQcCP1zRIwWwseOkQt1EqXJdSTgDk16cfCzi1Vr+GG
   WbY9lFUflOpodDL2rSY3yjlliggoCyQn/FAWYsfocxZVre5gX5TbBQbT/
   yWe2sEbsajuzFNnYv2baXYS0kWbm/P1BqDVmrgzi+/JTP9MySC4jZo/GL
   cGaNpIiPPvb6eASNBEJ48JMb37xGFevrNxstKBf9ltENn2PYUPR0UWIzz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="372260801"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="372260801"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 01:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="827815883"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="827815883"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2023 01:01:58 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZoF4-0004U3-0E;
        Sat, 26 Aug 2023 08:01:58 +0000
Date:   Sat, 26 Aug 2023 16:01:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 12/12] hugetlb: batch TLB flushes when restoring vmemmap
Message-ID: <202308261516.F6FBNktd-lkp@intel.com>
References: <20230825190436.55045-13-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190436.55045-13-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230825]
[cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
base:   next-20230825
patch link:    https://lore.kernel.org/r/20230825190436.55045-13-mike.kravetz%40oracle.com
patch subject: [PATCH 12/12] hugetlb: batch TLB flushes when restoring vmemmap
config: s390-randconfig-001-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261516.F6FBNktd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261516.F6FBNktd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261516.F6FBNktd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/hugetlb_vmemmap.c:516:5: warning: no previous prototype for function '__hugetlb_vmemmap_restore' [-Wmissing-prototypes]
     516 | int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, bool bulk)
         |     ^
   mm/hugetlb_vmemmap.c:516:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     516 | int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, bool bulk)
         | ^
         | static 
   mm/hugetlb_vmemmap.c:567:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
     567 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
         |                                   ^
   mm/hugetlb_vmemmap.c:673:6: warning: no previous prototype for function 'hugetlb_vmemmap_optimize_bulk' [-Wmissing-prototypes]
     673 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         |      ^
   mm/hugetlb_vmemmap.c:673:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     673 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         | ^
         | static 
   mm/hugetlb_vmemmap.c:679:6: warning: no previous prototype for function 'hugetlb_vmemmap_split' [-Wmissing-prototypes]
     679 | void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
         |      ^
   mm/hugetlb_vmemmap.c:679:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     679 | void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
         | ^
         | static 
   mm/hugetlb_vmemmap.c:710:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
     710 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
         |                                   ^
   mm/hugetlb_vmemmap.c:715:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
     715 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
         |                                   ^
   3 warnings and 3 errors generated.


vim +/__hugetlb_vmemmap_restore +516 mm/hugetlb_vmemmap.c

   515	
 > 516	int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, bool bulk)
   517	{
   518		int ret;
   519		unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
   520		unsigned long vmemmap_reuse;
   521	
   522		if (!HPageVmemmapOptimized(head))
   523			return 0;
   524	
   525		vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
   526		vmemmap_reuse	= vmemmap_start;
   527		vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
   528	
   529		/*
   530		 * The pages which the vmemmap virtual address range [@vmemmap_start,
   531		 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
   532		 * the range is mapped to the page which @vmemmap_reuse is mapped to.
   533		 * When a HugeTLB page is freed to the buddy allocator, previously
   534		 * discarded vmemmap pages must be allocated and remapping.
   535		 */
   536		ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk);
   537		if (!ret) {
   538			ClearHPageVmemmapOptimized(head);
   539			static_branch_dec(&hugetlb_optimize_vmemmap_key);
   540		}
   541	
   542		return ret;
   543	}
   544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
