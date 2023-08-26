Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A615B7893FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjHZF7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 01:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjHZF7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 01:59:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6926A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 22:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693029548; x=1724565548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JAf9bJ52chH87/HILStlWSZpikaAPYbuILpRJipkCrA=;
  b=eM34MtLO/wVh3P+0ut/osr6y0JqojfqFbSET+dfCEXQ8Bbwr5+4qS/rt
   FOEdp6dsZeRSy0sTiVFp8m+GYRNY9McvXDkpEPsuBcfyb0oYHWeT4uYID
   DgCNjEglrMhr+5gLeW9Of0K8ka/dD1jjulgSrw4X25fvqUgNMR6JfwUES
   8PpexgIuxlfw1JrsUjMJpN+9OertbneqtIDCGU2ThosTbWdrPr3CmrMGF
   OB+Cg+/gsgm18ALPUz42K/IBXDKIb/8SsOMA6y9bjN/3VLnfJ53SEnHwg
   i3SNFOxwcIhRTIiQm8Cu3A9sG1s71lkKXFEBAv/J6OUiH70x+Y7efly2U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="374824720"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="374824720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 22:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="731267495"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="731267495"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2023 22:59:01 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZmIR-0004Ot-09;
        Sat, 26 Aug 2023 05:58:03 +0000
Date:   Sat, 26 Aug 2023 13:56:22 +0800
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
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Message-ID: <202308261325.ipTttZHZ-lkp@intel.com>
References: <20230825190436.55045-11-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190436.55045-11-mike.kravetz@oracle.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230825]
[cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
base:   next-20230825
patch link:    https://lore.kernel.org/r/20230825190436.55045-11-mike.kravetz%40oracle.com
patch subject: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
config: s390-randconfig-001-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261325.ipTttZHZ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   mm/hugetlb_vmemmap.c:661:6: warning: no previous prototype for function 'hugetlb_vmemmap_optimize_bulk' [-Wmissing-prototypes]
     661 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         |      ^
   mm/hugetlb_vmemmap.c:661:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     661 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         | ^
         | static 
>> mm/hugetlb_vmemmap.c:667:6: warning: no previous prototype for function 'hugetlb_vmemmap_split' [-Wmissing-prototypes]
     667 | void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
         |      ^
   mm/hugetlb_vmemmap.c:667:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     667 | void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
         | ^
         | static 
>> mm/hugetlb_vmemmap.c:698:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
     698 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
         |                                   ^
   2 warnings and 1 error generated.


vim +/TLB_FLUSH_ALL +698 mm/hugetlb_vmemmap.c

   666	
 > 667	void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
   668	{
   669		unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
   670		unsigned long vmemmap_reuse;
   671	
   672		if (!vmemmap_should_optimize(h, head))
   673			return;
   674	
   675		static_branch_inc(&hugetlb_optimize_vmemmap_key);
   676	
   677		vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
   678		vmemmap_reuse   = vmemmap_start;
   679		vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
   680	
   681		/*
   682		 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
   683		 * to the page which @vmemmap_reuse is mapped to, then free the pages
   684		 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
   685		 */
   686		if (vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse))
   687			static_branch_dec(&hugetlb_optimize_vmemmap_key);
   688	}
   689	
   690	void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
   691	{
   692		struct folio *folio;
   693		LIST_HEAD(vmemmap_pages);
   694	
   695		list_for_each_entry(folio, folio_list, lru)
   696			hugetlb_vmemmap_split(h, &folio->page);
   697	
 > 698		flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
   699	
   700		list_for_each_entry(folio, folio_list, lru)
   701			hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
   702	
   703		free_vmemmap_page_list(&vmemmap_pages);
   704	}
   705	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
