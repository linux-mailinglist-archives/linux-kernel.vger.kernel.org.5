Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2943478F28D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347018AbjHaS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbjHaS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:27:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51249E64
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693506429; x=1725042429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OOYs8oyA2YtDKLHvdfa2ur/QKSwdb8VRAvcdJ5tslAQ=;
  b=VpbL2lucukbeBE7VNjA9Uce+vS1BqpLS8DpvlJ+BiePce8ZtrmvIrhtg
   HN60n1xy7DMtaX+cNPYv/0QImWW+KPqiVlFS6qFYLIwjvVJrOUQ/VhnVO
   Pjagv4mB7bFG8u27X5x1taLkRsReB/6r8X9+tIHi3tDU62XQJqEr0bVSt
   izdMt6NagVB10VIhgqw9Flpa4wUx9BIZdskRSmzvfd4bHSj+oyh86vbRa
   qNEeLYDp4cqENnRPLp7vfkhQED+oWK4GB9A53LPTYU+jF56vPvbEo2a2L
   btHCTV6iU/fi2WjMttuoN2Nob9TzhLDx9FuohLqVxtJnP3VRtQTaNQAIq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355526698"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="355526698"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913404814"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="913404814"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2023 11:27:02 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbmNf-0000Rb-2Q;
        Thu, 31 Aug 2023 18:26:59 +0000
Date:   Fri, 1 Sep 2023 02:26:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH v2 6/9] x86/clear_huge_page: multi-page clearing
Message-ID: <202309010241.u7o4IETu-lkp@intel.com>
References: <20230830184958.2333078-7-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830184958.2333078-7-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ankur,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on akpm-mm/mm-everything tip/x86/mm tip/sched/core tip/core/entry linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/mm-clear_huge_page-allow-arch-override-for-clear_huge_page/20230831-030156
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20230830184958.2333078-7-ankur.a.arora%40oracle.com
patch subject: [PATCH v2 6/9] x86/clear_huge_page: multi-page clearing
config: i386-buildonly-randconfig-006-20230831 (https://download.01.org/0day-ci/archive/20230901/202309010241.u7o4IETu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010241.u7o4IETu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010241.u7o4IETu-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/mm/hugetlbpage.c: In function 'clear_contig_region':
>> arch/x86/mm/hugetlbpage.c:155:9: error: implicit declaration of function 'clear_pages'; did you mean 'clear_page'? [-Werror=implicit-function-declaration]
     155 |         clear_pages(page_address(page), npages);
         |         ^~~~~~~~~~~
         |         clear_page
   cc1: some warnings being treated as errors


vim +155 arch/x86/mm/hugetlbpage.c

   151	
   152	#ifndef CONFIG_HIGHMEM
   153	static void clear_contig_region(struct page *page, unsigned int npages)
   154	{
 > 155		clear_pages(page_address(page), npages);
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
