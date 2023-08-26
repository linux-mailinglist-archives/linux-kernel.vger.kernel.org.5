Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54437898A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHZSPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHZSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:15:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29155E0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693073724; x=1724609724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sow/NUD0MSkiIp8x5GRqQtIOQTiTt/joLibtDQWus5o=;
  b=H+VBWrnfRBXOS53nT4pGsY141OfFk6DVW0M4OFl/CGY3X31LsNNJE57+
   LSDk7nsA+pyNTKzI4XCIsfsZYzI1B5A8oPi7S1It29MsxWWjOKtni2PuN
   PJ3ySLolbp3WtjIwLHrOFAGpBCIes2kOh6uL+PafxHE5ixMhCW3QMQD/m
   1/+gqXwqKUDG/0ABcEIIX1t5U4/DzAKe3Nlizt65kFn+dVMMfx8O1xd8T
   +oIe8HIuOrQkPZKOnc49SMsL95l2u8LmmaPVPOa+X48N0wkvJhPEUaEQz
   1M0S6/S6yo8yVrY3E29UAHOyE4Eh5b5gtM7MEACmpCq8vH2PcypXcuyBh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="378673437"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="378673437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2023 11:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881491461"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2023 11:15:24 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZxoc-0004yF-2W;
        Sat, 26 Aug 2023 18:15:18 +0000
Date:   Sun, 27 Aug 2023 02:14:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202308270248.eJT8UDG3-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230825]
[cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 linus/master v6.5-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
base:   next-20230825
patch link:    https://lore.kernel.org/r/20230825190436.55045-11-mike.kravetz%40oracle.com
patch subject: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
config: x86_64-randconfig-r031-20230826 (https://download.01.org/0day-ci/archive/20230827/202308270248.eJT8UDG3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308270248.eJT8UDG3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308270248.eJT8UDG3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/hugetlb_vmemmap.c:40: warning: Function parameter or member 'flags' not described in 'vmemmap_remap_walk'


vim +40 mm/hugetlb_vmemmap.c

f41f2ed43ca525 Muchun Song  2021-06-30  19  
998a2997885f73 Muchun Song  2022-06-28  20  /**
998a2997885f73 Muchun Song  2022-06-28  21   * struct vmemmap_remap_walk - walk vmemmap page table
998a2997885f73 Muchun Song  2022-06-28  22   *
998a2997885f73 Muchun Song  2022-06-28  23   * @remap_pte:		called for each lowest-level entry (PTE).
998a2997885f73 Muchun Song  2022-06-28  24   * @nr_walked:		the number of walked pte.
998a2997885f73 Muchun Song  2022-06-28  25   * @reuse_page:		the page which is reused for the tail vmemmap pages.
998a2997885f73 Muchun Song  2022-06-28  26   * @reuse_addr:		the virtual address of the @reuse_page page.
998a2997885f73 Muchun Song  2022-06-28  27   * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
998a2997885f73 Muchun Song  2022-06-28  28   *			or is mapped from.
506a27a4627ab7 Joao Martins 2023-08-25  29   * @flags		used to modify behavior in bulk operations
998a2997885f73 Muchun Song  2022-06-28  30   */
998a2997885f73 Muchun Song  2022-06-28  31  struct vmemmap_remap_walk {
998a2997885f73 Muchun Song  2022-06-28  32  	void			(*remap_pte)(pte_t *pte, unsigned long addr,
998a2997885f73 Muchun Song  2022-06-28  33  					     struct vmemmap_remap_walk *walk);
998a2997885f73 Muchun Song  2022-06-28  34  	unsigned long		nr_walked;
998a2997885f73 Muchun Song  2022-06-28  35  	struct page		*reuse_page;
998a2997885f73 Muchun Song  2022-06-28  36  	unsigned long		reuse_addr;
998a2997885f73 Muchun Song  2022-06-28  37  	struct list_head	*vmemmap_pages;
506a27a4627ab7 Joao Martins 2023-08-25  38  #define VMEMMAP_REMAP_ONLY_SPLIT	BIT(0)
506a27a4627ab7 Joao Martins 2023-08-25  39  	unsigned long		flags;
998a2997885f73 Muchun Song  2022-06-28 @40  };
998a2997885f73 Muchun Song  2022-06-28  41  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
