Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8097F1D99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKTTzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKTTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:55:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20DB92
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700510110; x=1732046110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIcnX1IfWE9lijtKlCzKbp0A86iGj84M8I59EZ2BXRk=;
  b=dpMi0qCVTYHI4z8vJIEyIHJHRpH9tBildPdWpjnnfY7IR5+X4GZ75Yew
   G14Z72BDy1JEtyDZA8jTFBmKjHSgtMnElMfWeiNMWkD8h6pV0L1qVQTzv
   5zRX9cdPXZ4efdSHEF6RZyAaJYnkcMIe0ZuOK6vrR4MDSywviiw4FRGUX
   DcxY907IzJsBU41a87vfU17TXP7Wh03J/ZQtXpUg3d7MLAiQaV39e6T/j
   l5YTpT3z8cbCsmUUi3Kta+CJzcpzARHcqwY1oGOy0Sn7D1XuRyoojwAH2
   rFJ910ImdrPlBlexpcnXcbVaRcvNkgCPqYtMbm+5ON8Kb0N5L2SGNiCzM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376730708"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="376730708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 11:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716305427"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="716305427"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2023 11:54:52 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5AM5-0006p2-24;
        Mon, 20 Nov 2023 19:54:49 +0000
Date:   Tue, 21 Nov 2023 03:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v6 4/4] mm,page_owner: Filter out stacks by a threshold
 counter
Message-ID: <202311210354.BwQoLzVO-lkp@intel.com>
References: <20231120084300.4368-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120084300.4368-5-osalvador@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Add-a-refcount-field-in-stack_record/20231120-164913
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231120084300.4368-5-osalvador%40suse.de
patch subject: [PATCH v6 4/4] mm,page_owner: Filter out stacks by a threshold counter
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231121/202311210354.BwQoLzVO-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210354.BwQoLzVO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210354.BwQoLzVO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/page_owner.c:819:5: warning: no previous prototype for 'page_owner_threshold_get' [-Wmissing-prototypes]
     819 | int page_owner_threshold_get(void *data, u64 *val)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page_owner.c:825:5: warning: no previous prototype for 'page_owner_threshold_set' [-Wmissing-prototypes]
     825 | int page_owner_threshold_set(void *data, u64 val)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/page_owner_threshold_get +819 mm/page_owner.c

   818	
 > 819	int page_owner_threshold_get(void *data, u64 *val)
   820	{
   821		*val = page_owner_stack_threshold;
   822		return 0;
   823	}
   824	
 > 825	int page_owner_threshold_set(void *data, u64 val)
   826	{
   827		page_owner_stack_threshold = val;
   828		return 0;
   829	}
   830	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
