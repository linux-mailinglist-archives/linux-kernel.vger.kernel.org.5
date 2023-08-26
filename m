Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65057893BE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjHZEBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHZEAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:00:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A71269E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693022450; x=1724558450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MNvxJ0fIPiMV1mHGPYuXep1V0yN9jcwBzpsGb/WSqzs=;
  b=KCJUp4mrG02AAt9bpPeOquBHdAQQSr3W9IhWh5MZ3R8ZdEiU/uRLj+DA
   GcTtLVoxh0Sl8ApBLp5fWb0GayJA76tsUXOC/7TziIS14u/3PpqAWL5hS
   sFUV/LOuYVtfB0iu1lrjR7bRxBoYpjCfVcQKmUxg1xtmkx8hCh1SxrGKQ
   XTX0GKLyz/1vnjxYXz1ArigY5xVzjS6AWb9JagxZRESJ8E1I54fF9aEKR
   c5Z5NkUO8JAV+6wGRW0bSNFltYaQmH1O8kcHSVKoC1BUXPAjBnZ5CXzuV
   HPKSu9qiinsWr/+y5ms5DdCKhE0fIecMejA4/uYs3YsY5sIeXrZViTHDo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461209341"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="461209341"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 21:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772699503"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="772699503"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 21:00:44 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZkTb-0004Jr-3A;
        Sat, 26 Aug 2023 04:00:43 +0000
Date:   Sat, 26 Aug 2023 12:00:39 +0800
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
Subject: Re: [PATCH 08/12] hugetlb: batch freeing of vmemmap pages
Message-ID: <202308261129.hdlNvI3X-lkp@intel.com>
References: <20230825190436.55045-9-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190436.55045-9-mike.kravetz@oracle.com>
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
patch link:    https://lore.kernel.org/r/20230825190436.55045-9-mike.kravetz%40oracle.com
patch subject: [PATCH 08/12] hugetlb: batch freeing of vmemmap pages
config: s390-randconfig-001-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261129.hdlNvI3X-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261129.hdlNvI3X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261129.hdlNvI3X-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/hugetlb_vmemmap.c:601:6: warning: no previous prototype for function 'hugetlb_vmemmap_optimize_bulk' [-Wmissing-prototypes]
     601 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         |      ^
   mm/hugetlb_vmemmap.c:601:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     601 | void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
         | ^
         | static 
   1 warning generated.


vim +/hugetlb_vmemmap_optimize_bulk +601 mm/hugetlb_vmemmap.c

   600	
 > 601	void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
   602				struct list_head *bulk_pages)
   603	{
   604		__hugetlb_vmemmap_optimize(h, head, bulk_pages);
   605	}
   606	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
