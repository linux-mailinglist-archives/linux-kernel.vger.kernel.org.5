Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8673478C791
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjH2Obn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjH2ObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:31:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6BE1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693319482; x=1724855482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yw62dOklpzeSWoXfbi5MAtuQ2UE1D/akr1KXO4x2oJE=;
  b=kAYWqSkk7MftAKoXwDNREVcHBDQvxrP+xibN+lVgM+cYX/Jbr8pmhw5q
   P0e8jApE0zkoP5mjJfBQPS6FJ0ZtItMxVRsBfAUWv2doIVTo8Kfi0cLT/
   BJYHUcWgpcniPRG5d9OZFxLe//STOS9jSIQ/YB/B9GnmVa5CTvKJ03Z45
   blI/Pdmj2rSXRUimS2C9Y/dHMprKPnEwyz7AEE1nb8n61mmykaqxU4TKt
   X6E0TZYNQuVsbNEMJNSidxTcbK9cRYs7cdhOGc0c2qPQIDOdcVojXCLmp
   4FsNEYYBZ097aRny2EgVhg3vQ0extTACrMPNSx5eUhpoEscD8faN3pg1k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374274086"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="374274086"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="808691186"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="808691186"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2023 07:31:10 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qazk5-0008oB-2V;
        Tue, 29 Aug 2023 14:30:58 +0000
Date:   Tue, 29 Aug 2023 22:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <202308292228.RRrGUYyB-lkp@intel.com>
References: <20230829081142.3619-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-5-urezki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uladzislau,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/mm-vmalloc-Add-va_alloc-helper/20230829-161248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230829081142.3619-5-urezki%40gmail.com
patch subject: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
config: csky-randconfig-r024-20230829 (https://download.01.org/0day-ci/archive/20230829/202308292228.RRrGUYyB-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230829/202308292228.RRrGUYyB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308292228.RRrGUYyB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/vmalloc.c: In function 'vmap_init_free_space':
>> mm/vmalloc.c:4506:45: warning: ordered comparison of pointer with integer zero [-Wextra]
    4506 |                 if (busy->addr - vmap_start > 0) {
         |                                             ^


vim +4506 mm/vmalloc.c

  4491	
  4492	static void vmap_init_free_space(void)
  4493	{
  4494		unsigned long vmap_start = 1;
  4495		const unsigned long vmap_end = ULONG_MAX;
  4496		struct vmap_area *free;
  4497		struct vm_struct *busy;
  4498	
  4499		/*
  4500		 *     B     F     B     B     B     F
  4501		 * -|-----|.....|-----|-----|-----|.....|-
  4502		 *  |           The KVA space           |
  4503		 *  |<--------------------------------->|
  4504		 */
  4505		for (busy = vmlist; busy; busy = busy->next) {
> 4506			if (busy->addr - vmap_start > 0) {
  4507				free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
  4508				if (!WARN_ON_ONCE(!free)) {
  4509					free->va_start = vmap_start;
  4510					free->va_end = (unsigned long) busy->addr;
  4511	
  4512					insert_vmap_area_augment(free, NULL,
  4513						&free_vmap_area_root,
  4514							&free_vmap_area_list);
  4515				}
  4516			}
  4517	
  4518			vmap_start = (unsigned long) busy->addr + busy->size;
  4519		}
  4520	
  4521		if (vmap_end - vmap_start > 0) {
  4522			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
  4523			if (!WARN_ON_ONCE(!free)) {
  4524				free->va_start = vmap_start;
  4525				free->va_end = vmap_end;
  4526	
  4527				insert_vmap_area_augment(free, NULL,
  4528					&free_vmap_area_root,
  4529						&free_vmap_area_list);
  4530			}
  4531		}
  4532	}
  4533	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
