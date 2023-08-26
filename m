Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD05F789420
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjHZG74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHZG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:59:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147A19AE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693033168; x=1724569168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yH9MujJ0iAGJ7g5COtkEwBRTd66O2dnJOAEBtemTLYQ=;
  b=MKqlKhpLmUQXujQDLyDDSDwWQTHeRevsZPztlasl8V6Si33McMWehPyi
   H3pkvXa76CYuiOg4nEekYMXXyWJ90OHSe9/ZIwKmfXAN0PrK+CD7XpYQR
   fCF4XU3b/7RbsmWC+q+IfCkrX07PS1zIt1pz9HfDzIo92TEvTt7zQo+LL
   vBosF0vdr7m1sC3SlPNigZo1kh1sgyaB1v7GKCjm6VuoVo+hs6lYjG3JS
   EBJOMqtBKwFnM/JC/YI+0ToSjLVRSTYT9NblnyjsS5L8/oTTIrYz2TlzC
   BjDaIkUyLuMPuqJRjZJlWLXXBuB/cRW196cwHrfIPI0oQ7F3M5pnePAw4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359847784"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="359847784"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 23:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807758131"
X-IronPort-AV: E=Sophos;i="6.02,203,1688454000"; 
   d="scan'208";a="807758131"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2023 23:59:23 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZnGU-0004RP-1B;
        Sat, 26 Aug 2023 06:59:22 +0000
Date:   Sat, 26 Aug 2023 14:58:48 +0800
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
Subject: Re: [PATCH 07/12] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <202308261407.9M957lhF-lkp@intel.com>
References: <20230825190436.55045-8-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190436.55045-8-mike.kravetz@oracle.com>
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
patch link:    https://lore.kernel.org/r/20230825190436.55045-8-mike.kravetz%40oracle.com
patch subject: [PATCH 07/12] hugetlb: perform vmemmap restoration on a list of pages
config: arm64-randconfig-r011-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261407.9M957lhF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261407.9M957lhF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261407.9M957lhF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/hugetlb.c:49:
>> mm/hugetlb_vmemmap.h:50:2: error: void function 'hugetlb_vmemmap_restore_folios' should not return a value [-Wreturn-type]
      50 |         return 0;
         |         ^      ~
   1 error generated.


vim +/hugetlb_vmemmap_restore_folios +50 mm/hugetlb_vmemmap.h

    47	
    48	static inline void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *folio_list)
    49	{
  > 50		return 0;
    51	}
    52	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
