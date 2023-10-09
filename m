Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B063F7BEE45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378907AbjJIW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378880AbjJIW2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:28:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F769D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696890514; x=1728426514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcdMrCDUe3iaka9lM/WN33sOnz9XetzlVI9bNrAOSSU=;
  b=NOWQsJGAG3QXfWzwpjrg5i1wdvFAJZt3KwFumxkyOJrY2NiW7quXpWKB
   fWDV0C22s21IGdXJBxU9oX+XRJtH6i/qr2Qa2/HC6u/8kvLoq6ksJI5GJ
   fTLeZoANkzqrdYVaD/IZv/E2rblC6cBoqIz94dV8nx17fSc9WWj66cXAI
   RzliZaOLpQl4rkuPzWL+BOzjIY/sCVGvZiFy9ZCeD0FLdcY4d7UeFeozK
   8yb4adUa3kKl21cFUj5SD8tUEoIIe7uBvb8+JZrIiP2Ojozj2Cwu22MU2
   6aO8fHch7Nq/lnpmcKR1xHvCsbcO/0S/kaU3m05qUydmIsFxc4q0Wh8kx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470520019"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="470520019"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 15:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="926897957"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="926897957"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2023 15:26:19 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpyhc-0000lg-3B;
        Mon, 09 Oct 2023 22:26:16 +0000
Date:   Tue, 10 Oct 2023 06:25:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
Message-ID: <202310100603.qsn3ruBx-lkp@intel.com>
References: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6-rc5 next-20231009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-mas_prealloc_calc/20231010-041859
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231009201639.920512-2-sidhartha.kumar%40oracle.com
patch subject: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231010/202310100603.qsn3ruBx-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100603.qsn3ruBx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310100603.qsn3ruBx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:5428:5: warning: no previous prototype for 'mas_prealloc_calc' [-Wmissing-prototypes]
    5428 | int mas_prealloc_calc(struct ma_wr_state *wr_mas)
         |     ^~~~~~~~~~~~~~~~~


vim +/mas_prealloc_calc +5428 lib/maple_tree.c

  5420	
  5421	/**
  5422	 * mas_prealloc_calc() - Calculate number of nodes needed for a
  5423	 * store operation.
  5424	 * @wr_mas: The maple write state
  5425	 *
  5426	 * Return: Number of nodes required for preallocation.
  5427	 */
> 5428	int mas_prealloc_calc(struct ma_wr_state *wr_mas)
  5429	{
  5430		struct ma_state *mas = wr_mas->mas;
  5431		unsigned char node_size;
  5432	
  5433		if (unlikely(!mas->index && mas->last == ULONG_MAX))
  5434			return 1;
  5435	
  5436		/* Root expand */
  5437		if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
  5438			return 1;
  5439	
  5440		if (unlikely(!mas_wr_walk(wr_mas))) {
  5441			/* Spanning store, use worst case for now */
  5442			return 1 + mas_mt_height(mas) * 3;
  5443		}
  5444	
  5445		/* At this point, we are at the leaf node that needs to be altered. */
  5446		/* Exact fit, no nodes needed. */
  5447		if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last)
  5448			return 0;
  5449	
  5450		mas_wr_end_piv(wr_mas);
  5451		node_size = mas_wr_new_end(wr_mas);
  5452		if (node_size >= mt_slots[wr_mas->type]) {
  5453			/* Split, worst case for now. */
  5454			return 1 + mas_mt_height(mas) * 2;
  5455		}
  5456	
  5457		/* New root needs a singe node */
  5458		if (unlikely(mte_is_root(mas->node)))
  5459			return 1;
  5460	
  5461		/* Potential spanning rebalance collapsing a node, use worst-case */
  5462		if (node_size  - 1 <= mt_min_slots[wr_mas->type])
  5463			return mas_mt_height(mas) * 2 - 1;
  5464	
  5465		/* node store, slot store needs one node */
  5466		return 1;
  5467	}
  5468	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
