Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC47BF92F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjJJLHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJJLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:07:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEDA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696936028; x=1728472028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FJub4UcvGgu+oorE62JwYE9DpYTagtbsI1/NwkqTak=;
  b=RpnNaMk5ODKLFuJZwexYEPJ+h/FyP7ngcxoVT+WpDJVz7N7ma+98V4Hn
   FxtbUS/dOqPSU6TxQ9q8bMkuHFaodNJ3zKYeg8KMWtwKV/6qbfm4c5qoj
   iMIAxzxH80vCufcG6AXY7NWPws3EifOSc8KjS6YY7ape/hBt+2y7GO70K
   I4eg7ZWUTXQUZkb6QmH5enm+eVsPYG6kYV8026veHStYm0eBG/K1sIiHj
   uUg57jm3m+eggufke0KgKPGbnzSWabFTy78yXUwu/2/Q9ansztDjgA5S/
   Fkt/gZI53IrSAoNTb5lE6jIEiai9lianEU+8xGQlJ84dIqXk/LFOG0k0s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387203891"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="387203891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="757074653"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="757074653"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2023 04:06:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqAZQ-0000IG-1y;
        Tue, 10 Oct 2023 11:06:36 +0000
Date:   Tue, 10 Oct 2023 19:06:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
Message-ID: <202310101854.kMSUyzOr-lkp@intel.com>
References: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009201639.920512-2-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/maple_tree-introduce-mas_prealloc_calc/20231010-041859
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231009201639.920512-2-sidhartha.kumar%40oracle.com
patch subject: [PATCH 1/3] maple_tree: introduce mas_prealloc_calc()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310101854.kMSUyzOr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101854.kMSUyzOr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101854.kMSUyzOr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/maple_tree.c:5428:5: warning: no previous prototype for function 'mas_prealloc_calc' [-Wmissing-prototypes]
    5428 | int mas_prealloc_calc(struct ma_wr_state *wr_mas)
         |     ^
   lib/maple_tree.c:5428:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    5428 | int mas_prealloc_calc(struct ma_wr_state *wr_mas)
         | ^
         | static 
   lib/maple_tree.c:348:21: warning: unused function 'mte_set_full' [-Wunused-function]
     348 | static inline void *mte_set_full(const struct maple_enode *node)
         |                     ^
   lib/maple_tree.c:353:21: warning: unused function 'mte_clear_full' [-Wunused-function]
     353 | static inline void *mte_clear_full(const struct maple_enode *node)
         |                     ^
   lib/maple_tree.c:358:20: warning: unused function 'mte_has_null' [-Wunused-function]
     358 | static inline bool mte_has_null(const struct maple_enode *node)
         |                    ^
   lib/maple_tree.c:689:29: warning: unused function 'mas_pivot' [-Wunused-function]
     689 | static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
         |                             ^
   lib/maple_tree.c:4201:20: warning: stack frame size (1032) exceeds limit (1024) in 'mas_wr_modify' [-Wframe-larger-than]
    4201 | static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
         |                    ^
   6 warnings generated.


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
