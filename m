Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F92E768686
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjG3Qtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjG3Qtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:49:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973961724
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690735783; x=1722271783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+Z5PaN3WNneZ2+RkNZ2/IsyXoEZ0Car3WVCEMRTPcE=;
  b=ZEKYRo64VDUK1DHNPuEqZAVEwThapchQeM3299OszDYk4EA+WY24u4XJ
   s6TstllKIQse7wF8jIraWte1iQ6Vl0h9FO+bLLUWnqvdFvFWa6VqO8irl
   99k781Zq8AvXf1SXuwTmguJyWGBAWiN7Om3/Vikt+KonfVgVTQTaG5Yby
   r1heiKoosQcjmIDThY29t2PKDEO5qVbF82uU5lfryQihvqd/wajZ3Nu8H
   tj1Ihi1gBkiKErBlomtCh3YpI9NSCC8kcw9iHCkmDZ2YI16JrvC+ZVHla
   Kr7qFcW0HqN5C5LbYpWawTo76ZbGnM7+lIWj/E2fZLopbagsxxY1+yQAO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="432670171"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="432670171"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 09:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="1058685688"
X-IronPort-AV: E=Sophos;i="6.01,242,1684825200"; 
   d="scan'208";a="1058685688"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2023 09:49:39 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQ9bv-0004gp-0T;
        Sun, 30 Jul 2023 16:49:39 +0000
Date:   Mon, 31 Jul 2023 00:49:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        simon.evans@bytedance.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [v2 5/6] mm: move allocation of gigantic hstates to the start of
 mm_core_init
Message-ID: <202307310053.hx4wsFnM-lkp@intel.com>
References: <20230730151606.2871391-6-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730151606.2871391-6-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Usama,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Usama-Arif/mm-hugetlb-Skip-prep-of-tail-pages-when-HVO-is-enabled/20230730-231750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230730151606.2871391-6-usama.arif%40bytedance.com
patch subject: [v2 5/6] mm: move allocation of gigantic hstates to the start of mm_core_init
config: csky-randconfig-r034-20230730 (https://download.01.org/0day-ci/archive/20230731/202307310053.hx4wsFnM-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310053.hx4wsFnM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310053.hx4wsFnM-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from mm/readahead.c:132:
>> mm/internal.h:1143:1: error: expected identifier or '(' before '{' token
    1143 | {
         | ^
>> mm/internal.h:1142:27: warning: 'hugetlb_hstate_alloc_gigantic_pages' declared 'static' but never defined [-Wunused-function]
    1142 | static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from mm/mm_init.c:30:
>> mm/internal.h:1143:1: error: expected identifier or '(' before '{' token
    1143 | {
         | ^
>> mm/internal.h:1142:27: warning: 'hugetlb_hstate_alloc_gigantic_pages' used but never defined
    1142 | static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from lib/vsprintf.c:49:
>> lib/../mm/internal.h:1143:1: error: expected identifier or '(' before '{' token
    1143 | {
         | ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
   lib/../mm/internal.h: At top level:
>> lib/../mm/internal.h:1142:27: warning: 'hugetlb_hstate_alloc_gigantic_pages' declared 'static' but never defined [-Wunused-function]
    1142 | static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1143 mm/internal.h

  1138	
  1139	#ifdef CONFIG_HUGETLBFS
  1140	void __init hugetlb_hstate_alloc_gigantic_pages(void);
  1141	#else
> 1142	static inline void __init hugetlb_hstate_alloc_gigantic_pages(void);
> 1143	{
  1144	}
  1145	#endif /* CONFIG_HUGETLBFS */
  1146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
