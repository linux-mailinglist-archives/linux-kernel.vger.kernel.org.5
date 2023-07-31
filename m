Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE876A32E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGaVpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGaVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:44:56 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B81704
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839895; x=1722375895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9zFns7zZQESZ7pDAZt3AXPRmGcqxla5AiTsmJC26Zg=;
  b=BSpLa2AelDM/I04uvuFEJruN8hTqUtJ4d0pZ9TH2z65wx6xssOUKLNKo
   0u0FBjM2rmqGBNnOCAabRM0mQNEg7oKIFP3FVZObFyQ7R6xxtTJNkb7xb
   BbZp5f0zXsX79ovzfj8vKc10HW6AsL8shT17hgmkvlWpRq62Kz4f7cxwg
   u0FbI3zHdZj01e3ijCYwOOlilNFjOYXSVYYW1NeikC/neS05y3gOHjM/2
   JvB7U+reAdYGvNPHbx36UNRWH2VKdNYIcUP4CrCghorMm1n39HxmSS0wl
   DoKzE9HebVSwx884JDUK6ia6e80oZYuVBwYagC6/na+mAe8mE3C5o3bQF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359170552"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="359170552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="722240566"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="722240566"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Jul 2023 14:44:50 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQah4-0005O5-0W;
        Mon, 31 Jul 2023 21:44:47 +0000
Date:   Tue, 1 Aug 2023 05:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/4] mm: mremap: use flush_pmd_tlb_range() in
 move_normal_pmd()
Message-ID: <202308010553.KxefZFdO-lkp@intel.com>
References: <20230731074829.79309-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074829.79309-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm-perf/for-next/perf linus/master v6.5-rc4]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-hugetlb-use-flush_hugetlb_tlb_range-in-move_hugetlb_page_tables/20230731-154016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230731074829.79309-3-wangkefeng.wang%40huawei.com
patch subject: [PATCH 2/4] mm: mremap: use flush_pmd_tlb_range() in move_normal_pmd()
config: x86_64-randconfig-x003-20230731 (https://download.01.org/0day-ci/archive/20230801/202308010553.KxefZFdO-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230801/202308010553.KxefZFdO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308010553.KxefZFdO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: call to __compiletime_assert_860 marked "dontcall-error": BUILD_BUG failed

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
