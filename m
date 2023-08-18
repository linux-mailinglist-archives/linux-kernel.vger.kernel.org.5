Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9CC780477
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357587AbjHRD1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357576AbjHRD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:26:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E53411F;
        Thu, 17 Aug 2023 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692329207; x=1723865207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSvyYHyBsQjQjFEAokdXGLM2cr2C11Os/mSxxP1ozWY=;
  b=YF3ww90h6Vx5vCHcFS4rOvIYO6cY6WpGWP3dWu4bpc5QO//CvQwbVUqx
   nxiZt3ZyvIBXjYeI1CplWaNVmbSHCsFfj/CrZ4wpmcKQVabqCli8LfW/U
   jEA0mVSWdfBPw8bMsJUxDv7Q8+OGsR6A+C2VQ8KY1BYumEfTFTjZTOmSc
   cQ7/QaCffLda3aUxICSBsAV9BRFX32xT+7nLsjDzj3I0kgsFFsJRPkU0x
   iG1PCrw3zK0A78kH/JHn5QzAzmy7iVY3eb5WPpBSUYojohHXbwa47kdF8
   cBWGla6WZQcei44dVA2Fk8mX5L8YUkUF7ht6uh4BvSyGpm6plGnx4C/rY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="459354589"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="459354589"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 20:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="804979507"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="804979507"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 20:26:44 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWq8J-00023s-30;
        Fri, 18 Aug 2023 03:26:43 +0000
Date:   Fri, 18 Aug 2023 11:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, hannes@cmpxchg.org,
        kernel-team@meta.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        yosryahmed@google.com
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <202308181116.FsJVPmJZ-lkp@intel.com>
References: <20230817190126.3155299-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817190126.3155299-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nhat-Pham/workingset-ensure-memcg-is-valid-for-recency-check/20230818-030311
base:   linus/master
patch link:    https://lore.kernel.org/r/20230817190126.3155299-1-nphamcs%40gmail.com
patch subject: [PATCH v2] workingset: ensure memcg is valid for recency check
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20230818/202308181116.FsJVPmJZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308181116.FsJVPmJZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308181116.FsJVPmJZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/workingset.c: In function 'unpack_shadow':
>> mm/workingset.c:245:22: error: implicit declaration of function 'css_tryget'; did you mean 'wb_tryget'? [-Werror=implicit-function-declaration]
     245 |         if (memcg && css_tryget(&memcg->css))
         |                      ^~~~~~~~~~
         |                      wb_tryget
   mm/workingset.c:245:39: error: invalid use of undefined type 'struct mem_cgroup'
     245 |         if (memcg && css_tryget(&memcg->css))
         |                                       ^~
   cc1: some warnings being treated as errors


vim +245 mm/workingset.c

   208	
   209	/*
   210	 * Unpacks the stored fields of a shadow entry into the given pointers.
   211	 *
   212	 * The memcg pointer is only populated if the memcg recorded in the shadow
   213	 * entry is valid. In this case, a reference to the memcg will be acquired,
   214	 * and a corresponding mem_cgroup_put() will be needed when we no longer
   215	 * need the memcg.
   216	 */
   217	static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
   218				pg_data_t **pgdat, unsigned long *evictionp, bool *workingsetp)
   219	{
   220		unsigned long entry = xa_to_value(shadow);
   221		struct mem_cgroup *memcg;
   222		int memcgid, nid;
   223		bool workingset;
   224	
   225		workingset = entry & ((1UL << WORKINGSET_SHIFT) - 1);
   226		entry >>= WORKINGSET_SHIFT;
   227		nid = entry & ((1UL << NODES_SHIFT) - 1);
   228		entry >>= NODES_SHIFT;
   229		memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
   230		entry >>= MEM_CGROUP_ID_SHIFT;
   231	
   232		/*
   233		 * Look up the memcg associated with the stored ID. It might
   234		 * have been deleted since the folio's eviction.
   235		 *
   236		 * Note that in rare events the ID could have been recycled
   237		 * for a new cgroup that refaults a shared folio. This is
   238		 * impossible to tell from the available data. However, this
   239		 * should be a rare and limited disturbance, and activations
   240		 * are always speculative anyway. Ultimately, it's the aging
   241		 * algorithm's job to shake out the minimum access frequency
   242		 * for the active cache.
   243		 */
   244		memcg = mem_cgroup_from_id(memcgid);
 > 245		if (memcg && css_tryget(&memcg->css))
   246			*memcgp = memcg;
   247		else
   248			*memcgp = NULL;
   249	
   250		*pgdat = NODE_DATA(nid);
   251		*evictionp = entry;
   252		*workingsetp = workingset;
   253	}
   254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
