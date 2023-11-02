Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BE67DEE4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjKBInl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjKBIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:43:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FF12C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698914611; x=1730450611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V3Cm6h7VdHgF3XxSuX4x3w+XYtWclBCOi+HQjc3YwZI=;
  b=dcBAt+/cUAZIB8FoTDokKsI1XuvIYM8h00/qKzdxpH3tP2Yz2eOcYJKN
   XYJlbStdVzZMH+7r0ysaEUhS0O8Ad/boffI9pS26U1V3LcLi3984+dNaO
   LYGIcRCcl3ZExOGJuUL3sgxAubooZbDD7UXJQTHJDxyTvDmxQlO1xKlAe
   T+lYPiYfPORiUHwS1bkIuxY3rQob+mRbEEeUZbrECW3y+rtP5y1SOMG8B
   ZCv07NcsQHjBb/r/5qs6d4CVRd7OhoS4hFT+PaCcaFzcykW8iDHqHpoBo
   BwHjrr3Y2JtIWX0CaeYbpJ0s7aeI3uO8zJp7fhZD+qf9dCCyd+c0ec3Zd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="388483978"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="388483978"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711071714"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="711071714"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Nov 2023 01:43:28 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyTIU-0001HX-1a;
        Thu, 02 Nov 2023 08:43:26 +0000
Date:   Thu, 2 Nov 2023 16:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 08/12] maple_tree: Separate ma_state node from status.
Message-ID: <202311021622.6KoUHJP7-lkp@intel.com>
References: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6 next-20231102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/maple_tree-Remove-unnecessary-default-labels-from-switch-statements/20231102-033618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231101171629.3612299-9-Liam.Howlett%40oracle.com
patch subject: [PATCH 08/12] maple_tree: Separate ma_state node from status.
config: arc-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021622.6KoUHJP7-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021622.6KoUHJP7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021622.6KoUHJP7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
   drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                       ^~~~~~~~~~~
   drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                                    ^~~~~~~~~~
>> drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                       ^~~~~~~~~~~
>> drivers/base/regmap/regcache-maple.c:114:36: warning: 'upper_last' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                                    ^~~~~~~~~~


vim +/upper_index +114 drivers/base/regmap/regcache-maple.c

f033c26de5a5734 Mark Brown    2023-03-30  106  
f033c26de5a5734 Mark Brown    2023-03-30  107  static int regcache_maple_drop(struct regmap *map, unsigned int min,
f033c26de5a5734 Mark Brown    2023-03-30  108  			       unsigned int max)
f033c26de5a5734 Mark Brown    2023-03-30  109  {
f033c26de5a5734 Mark Brown    2023-03-30  110  	struct maple_tree *mt = map->cache;
f033c26de5a5734 Mark Brown    2023-03-30  111  	MA_STATE(mas, mt, min, max);
f033c26de5a5734 Mark Brown    2023-03-30  112  	unsigned long *entry, *lower, *upper;
f033c26de5a5734 Mark Brown    2023-03-30  113  	unsigned long lower_index, lower_last;
f033c26de5a5734 Mark Brown    2023-03-30 @114  	unsigned long upper_index, upper_last;
f033c26de5a5734 Mark Brown    2023-03-30  115  	int ret;
f033c26de5a5734 Mark Brown    2023-03-30  116  
f033c26de5a5734 Mark Brown    2023-03-30  117  	lower = NULL;
f033c26de5a5734 Mark Brown    2023-03-30  118  	upper = NULL;
f033c26de5a5734 Mark Brown    2023-03-30  119  
f033c26de5a5734 Mark Brown    2023-03-30  120  	mas_lock(&mas);
f033c26de5a5734 Mark Brown    2023-03-30  121  
f033c26de5a5734 Mark Brown    2023-03-30  122  	mas_for_each(&mas, entry, max) {
f033c26de5a5734 Mark Brown    2023-03-30  123  		/*
f033c26de5a5734 Mark Brown    2023-03-30  124  		 * This is safe because the regmap lock means the
f033c26de5a5734 Mark Brown    2023-03-30  125  		 * Maple lock is redundant, but we need to take it due
f033c26de5a5734 Mark Brown    2023-03-30  126  		 * to lockdep asserts in the maple tree code.
f033c26de5a5734 Mark Brown    2023-03-30  127  		 */
f033c26de5a5734 Mark Brown    2023-03-30  128  		mas_unlock(&mas);
f033c26de5a5734 Mark Brown    2023-03-30  129  
f033c26de5a5734 Mark Brown    2023-03-30  130  		/* Do we need to save any of this entry? */
f033c26de5a5734 Mark Brown    2023-03-30  131  		if (mas.index < min) {
f033c26de5a5734 Mark Brown    2023-03-30  132  			lower_index = mas.index;
f033c26de5a5734 Mark Brown    2023-03-30  133  			lower_last = min -1;
f033c26de5a5734 Mark Brown    2023-03-30  134  
f033c26de5a5734 Mark Brown    2023-03-30  135  			lower = kmemdup(entry, ((min - mas.index) *
f033c26de5a5734 Mark Brown    2023-03-30  136  						sizeof(unsigned long)),
b0393e1fe40e962 Guenter Roeck 2023-07-20  137  					map->alloc_flags);
f033c26de5a5734 Mark Brown    2023-03-30  138  			if (!lower) {
f033c26de5a5734 Mark Brown    2023-03-30  139  				ret = -ENOMEM;
451941ac1ee2be1 Mark Brown    2023-04-03  140  				goto out_unlocked;
f033c26de5a5734 Mark Brown    2023-03-30  141  			}
f033c26de5a5734 Mark Brown    2023-03-30  142  		}
f033c26de5a5734 Mark Brown    2023-03-30  143  
f033c26de5a5734 Mark Brown    2023-03-30  144  		if (mas.last > max) {
f033c26de5a5734 Mark Brown    2023-03-30  145  			upper_index = max + 1;
f033c26de5a5734 Mark Brown    2023-03-30  146  			upper_last = mas.last;
f033c26de5a5734 Mark Brown    2023-03-30  147  
f033c26de5a5734 Mark Brown    2023-03-30  148  			upper = kmemdup(&entry[max + 1],
f033c26de5a5734 Mark Brown    2023-03-30  149  					((mas.last - max) *
f033c26de5a5734 Mark Brown    2023-03-30  150  					 sizeof(unsigned long)),
b0393e1fe40e962 Guenter Roeck 2023-07-20  151  					map->alloc_flags);
f033c26de5a5734 Mark Brown    2023-03-30  152  			if (!upper) {
f033c26de5a5734 Mark Brown    2023-03-30  153  				ret = -ENOMEM;
451941ac1ee2be1 Mark Brown    2023-04-03  154  				goto out_unlocked;
f033c26de5a5734 Mark Brown    2023-03-30  155  			}
f033c26de5a5734 Mark Brown    2023-03-30  156  		}
f033c26de5a5734 Mark Brown    2023-03-30  157  
f033c26de5a5734 Mark Brown    2023-03-30  158  		kfree(entry);
f033c26de5a5734 Mark Brown    2023-03-30  159  		mas_lock(&mas);
f033c26de5a5734 Mark Brown    2023-03-30  160  		mas_erase(&mas);
f033c26de5a5734 Mark Brown    2023-03-30  161  
f033c26de5a5734 Mark Brown    2023-03-30  162  		/* Insert new nodes with the saved data */
f033c26de5a5734 Mark Brown    2023-03-30  163  		if (lower) {
f033c26de5a5734 Mark Brown    2023-03-30  164  			mas_set_range(&mas, lower_index, lower_last);
b0393e1fe40e962 Guenter Roeck 2023-07-20  165  			ret = mas_store_gfp(&mas, lower, map->alloc_flags);
f033c26de5a5734 Mark Brown    2023-03-30  166  			if (ret != 0)
f033c26de5a5734 Mark Brown    2023-03-30  167  				goto out;
f033c26de5a5734 Mark Brown    2023-03-30  168  			lower = NULL;
f033c26de5a5734 Mark Brown    2023-03-30  169  		}
f033c26de5a5734 Mark Brown    2023-03-30  170  
f033c26de5a5734 Mark Brown    2023-03-30  171  		if (upper) {
f033c26de5a5734 Mark Brown    2023-03-30  172  			mas_set_range(&mas, upper_index, upper_last);
b0393e1fe40e962 Guenter Roeck 2023-07-20  173  			ret = mas_store_gfp(&mas, upper, map->alloc_flags);
f033c26de5a5734 Mark Brown    2023-03-30  174  			if (ret != 0)
f033c26de5a5734 Mark Brown    2023-03-30  175  				goto out;
f033c26de5a5734 Mark Brown    2023-03-30  176  			upper = NULL;
f033c26de5a5734 Mark Brown    2023-03-30  177  		}
f033c26de5a5734 Mark Brown    2023-03-30  178  	}
f033c26de5a5734 Mark Brown    2023-03-30  179  
f033c26de5a5734 Mark Brown    2023-03-30  180  out:
f033c26de5a5734 Mark Brown    2023-03-30  181  	mas_unlock(&mas);
451941ac1ee2be1 Mark Brown    2023-04-03  182  out_unlocked:
f033c26de5a5734 Mark Brown    2023-03-30  183  	kfree(lower);
f033c26de5a5734 Mark Brown    2023-03-30  184  	kfree(upper);
f033c26de5a5734 Mark Brown    2023-03-30  185  
f033c26de5a5734 Mark Brown    2023-03-30  186  	return ret;
f033c26de5a5734 Mark Brown    2023-03-30  187  }
f033c26de5a5734 Mark Brown    2023-03-30  188  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
