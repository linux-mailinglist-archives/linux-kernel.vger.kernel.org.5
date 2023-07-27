Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC6764565
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjG0FUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjG0FUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:20:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1D826AE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690435243; x=1721971243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y2vW8GgXkL/CfVHFfwWdZgF6RlO0q7K5B4na+6BWOks=;
  b=fJ5xxnbuL8+dCwICz1oes2K67lCgOhhauQWXfIRUhr5Wqy4UHlc2FajL
   /1smY3ybVN0QIdryMOAgdtcdqV1AXKm5bDT2ZPp2RBeog7NVG322XFWBq
   Hfn3GUYPUMbxCCxRzhWbgttDTyVLfex1aFXqzeiHg3Ix3GOs0k6PLdj0E
   Hq/jPNWhQtz7ErGYBOm2LTZNKazJxUAXtP/Vykc/F747fnqmx3KW9mGPY
   GbmvITkKWYaKNXf4HhwRztRW8+9zM2GOetqAbHVU7bGA3Nno/7+VAYjp7
   bOG1FNvYsmfpnOshEz3imM5wdKvwTnUU/45IV1EW4V7IJNGeyDW030Mpv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368224776"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="368224776"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="730123139"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="730123139"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jul 2023 22:20:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOtQV-0001xk-15;
        Thu, 27 Jul 2023 05:20:39 +0000
Date:   Thu, 27 Jul 2023 13:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Message-ID: <202307271340.F1VOMz4L-lkp@intel.com>
References: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master crng-random/master v6.5-rc3 next-20230726]
[cannot apply to next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Allow-min-max-clamp-if-the-arguments-have-the-same-signedness/20230725-204940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/48c2cd0407f14859919d4fcbe526234a%40AcuMS.aculab.com
patch subject: [PATCH next resend 5/5] minmax: Relax check to allow comparison between int and small unsigned constants.
config: x86_64-randconfig-r071-20230725 (https://download.01.org/0day-ci/archive/20230727/202307271340.F1VOMz4L-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271340.F1VOMz4L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271340.F1VOMz4L-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (>=):
>> mm/percpu.c:3102:24: sparse:    void *ptr
>> mm/percpu.c:3102:24: sparse:    int
>> mm/percpu.c:3102:24: sparse: sparse: bad constant expression type
>> mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (>=):
>> mm/percpu.c:3102:24: sparse:    void *[assigned] ptr
>> mm/percpu.c:3102:24: sparse:    int
>> mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (>=):
>> mm/percpu.c:3102:24: sparse:    void *base
>> mm/percpu.c:3102:24: sparse:    int
>> mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (>=):
>> mm/percpu.c:3102:24: sparse:    void *[assigned] ptr
>> mm/percpu.c:3102:24: sparse:    int
>> mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (>=):
>> mm/percpu.c:3102:24: sparse:    void *base
>> mm/percpu.c:3102:24: sparse:    int
   mm/percpu.c:3102:24: sparse: sparse: incompatible types for operation (<):
   mm/percpu.c:3102:24: sparse:    bad type __UNIQUE_ID___x458
   mm/percpu.c:3102:24: sparse:    bad type __UNIQUE_ID___y459
--
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (>=):
>> fs/ntfs3/lznt.c:157:16: sparse:    unsigned char [usertype] *
>> fs/ntfs3/lznt.c:157:16: sparse:    int
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: bad constant expression type
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (>=):
>> fs/ntfs3/lznt.c:157:16: sparse:    unsigned char [usertype] *
>> fs/ntfs3/lznt.c:157:16: sparse:    int
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (>=):
>> fs/ntfs3/lznt.c:157:16: sparse:    unsigned char [usertype] *cmpr_end
>> fs/ntfs3/lznt.c:157:16: sparse:    int
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (>=):
>> fs/ntfs3/lznt.c:157:16: sparse:    unsigned char [usertype] *
>> fs/ntfs3/lznt.c:157:16: sparse:    int
>> fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (>=):
>> fs/ntfs3/lznt.c:157:16: sparse:    unsigned char [usertype] *cmpr_end
>> fs/ntfs3/lznt.c:157:16: sparse:    int
   fs/ntfs3/lznt.c:157:16: sparse: sparse: incompatible types for operation (<):
   fs/ntfs3/lznt.c:157:16: sparse:    bad type __UNIQUE_ID___x333
   fs/ntfs3/lznt.c:157:16: sparse:    bad type __UNIQUE_ID___y334

vim +3102 mm/percpu.c

3c9a024fde58b0 Tejun Heo       2010-09-09  3022  
3c9a024fde58b0 Tejun Heo       2010-09-09  3023  #if defined(BUILD_EMBED_FIRST_CHUNK)
66c3a75772247c Tejun Heo       2009-03-10  3024  /**
66c3a75772247c Tejun Heo       2009-03-10  3025   * pcpu_embed_first_chunk - embed the first percpu chunk into bootmem
66c3a75772247c Tejun Heo       2009-03-10  3026   * @reserved_size: the size of reserved percpu area in bytes
4ba6ce250e406b Tejun Heo       2010-06-27  3027   * @dyn_size: minimum free size for dynamic allocation in bytes
c8826dd538602d Tejun Heo       2009-08-14  3028   * @atom_size: allocation atom size
c8826dd538602d Tejun Heo       2009-08-14  3029   * @cpu_distance_fn: callback to determine distance between cpus, optional
1ca3fb3abd2b61 Kefeng Wang     2022-01-19  3030   * @cpu_to_nd_fn: callback to convert cpu to it's node, optional
66c3a75772247c Tejun Heo       2009-03-10  3031   *
66c3a75772247c Tejun Heo       2009-03-10  3032   * This is a helper to ease setting up embedded first percpu chunk and
66c3a75772247c Tejun Heo       2009-03-10  3033   * can be called where pcpu_setup_first_chunk() is expected.
66c3a75772247c Tejun Heo       2009-03-10  3034   *
66c3a75772247c Tejun Heo       2009-03-10  3035   * If this function is used to setup the first chunk, it is allocated
23f917169ef157 Kefeng Wang     2022-01-19  3036   * by calling pcpu_fc_alloc and used as-is without being mapped into
c8826dd538602d Tejun Heo       2009-08-14  3037   * vmalloc area.  Allocations are always whole multiples of @atom_size
c8826dd538602d Tejun Heo       2009-08-14  3038   * aligned to @atom_size.
c8826dd538602d Tejun Heo       2009-08-14  3039   *
c8826dd538602d Tejun Heo       2009-08-14  3040   * This enables the first chunk to piggy back on the linear physical
c8826dd538602d Tejun Heo       2009-08-14  3041   * mapping which often uses larger page size.  Please note that this
c8826dd538602d Tejun Heo       2009-08-14  3042   * can result in very sparse cpu->unit mapping on NUMA machines thus
c8826dd538602d Tejun Heo       2009-08-14  3043   * requiring large vmalloc address space.  Don't use this allocator if
c8826dd538602d Tejun Heo       2009-08-14  3044   * vmalloc space is not orders of magnitude larger than distances
c8826dd538602d Tejun Heo       2009-08-14  3045   * between node memory addresses (ie. 32bit NUMA machines).
66c3a75772247c Tejun Heo       2009-03-10  3046   *
4ba6ce250e406b Tejun Heo       2010-06-27  3047   * @dyn_size specifies the minimum dynamic area size.
66c3a75772247c Tejun Heo       2009-03-10  3048   *
66c3a75772247c Tejun Heo       2009-03-10  3049   * If the needed size is smaller than the minimum or specified unit
23f917169ef157 Kefeng Wang     2022-01-19  3050   * size, the leftover is returned using pcpu_fc_free.
66c3a75772247c Tejun Heo       2009-03-10  3051   *
66c3a75772247c Tejun Heo       2009-03-10  3052   * RETURNS:
fb435d5233f8b6 Tejun Heo       2009-08-14  3053   * 0 on success, -errno on failure.
66c3a75772247c Tejun Heo       2009-03-10  3054   */
4ba6ce250e406b Tejun Heo       2010-06-27  3055  int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
c8826dd538602d Tejun Heo       2009-08-14  3056  				  size_t atom_size,
c8826dd538602d Tejun Heo       2009-08-14  3057  				  pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
23f917169ef157 Kefeng Wang     2022-01-19  3058  				  pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
66c3a75772247c Tejun Heo       2009-03-10  3059  {
c8826dd538602d Tejun Heo       2009-08-14  3060  	void *base = (void *)ULONG_MAX;
c8826dd538602d Tejun Heo       2009-08-14  3061  	void **areas = NULL;
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3062  	struct pcpu_alloc_info *ai;
93c76b6b2faaad zijun_hu        2016-10-05  3063  	size_t size_sum, areas_size;
93c76b6b2faaad zijun_hu        2016-10-05  3064  	unsigned long max_distance;
163fa23435cc9c Kefeng Wang     2019-07-03  3065  	int group, i, highest_group, rc = 0;
66c3a75772247c Tejun Heo       2009-03-10  3066  
c8826dd538602d Tejun Heo       2009-08-14  3067  	ai = pcpu_build_alloc_info(reserved_size, dyn_size, atom_size,
c8826dd538602d Tejun Heo       2009-08-14  3068  				   cpu_distance_fn);
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3069  	if (IS_ERR(ai))
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3070  		return PTR_ERR(ai);
66c3a75772247c Tejun Heo       2009-03-10  3071  
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3072  	size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
c8826dd538602d Tejun Heo       2009-08-14  3073  	areas_size = PFN_ALIGN(ai->nr_groups * sizeof(void *));
fa8a7094ba1679 Tejun Heo       2009-06-22  3074  
26fb3dae0a1ec7 Mike Rapoport   2019-03-11  3075  	areas = memblock_alloc(areas_size, SMP_CACHE_BYTES);
c8826dd538602d Tejun Heo       2009-08-14  3076  	if (!areas) {
fb435d5233f8b6 Tejun Heo       2009-08-14  3077  		rc = -ENOMEM;
c8826dd538602d Tejun Heo       2009-08-14  3078  		goto out_free;
fa8a7094ba1679 Tejun Heo       2009-06-22  3079  	}
66c3a75772247c Tejun Heo       2009-03-10  3080  
9b7396624a7b50 zijun_hu        2016-10-05  3081  	/* allocate, copy and determine base address & max_distance */
9b7396624a7b50 zijun_hu        2016-10-05  3082  	highest_group = 0;
c8826dd538602d Tejun Heo       2009-08-14  3083  	for (group = 0; group < ai->nr_groups; group++) {
c8826dd538602d Tejun Heo       2009-08-14  3084  		struct pcpu_group_info *gi = &ai->groups[group];
c8826dd538602d Tejun Heo       2009-08-14  3085  		unsigned int cpu = NR_CPUS;
c8826dd538602d Tejun Heo       2009-08-14  3086  		void *ptr;
c8826dd538602d Tejun Heo       2009-08-14  3087  
c8826dd538602d Tejun Heo       2009-08-14  3088  		for (i = 0; i < gi->nr_units && cpu == NR_CPUS; i++)
c8826dd538602d Tejun Heo       2009-08-14  3089  			cpu = gi->cpu_map[i];
c8826dd538602d Tejun Heo       2009-08-14  3090  		BUG_ON(cpu == NR_CPUS);
c8826dd538602d Tejun Heo       2009-08-14  3091  
c8826dd538602d Tejun Heo       2009-08-14  3092  		/* allocate space for the whole group */
23f917169ef157 Kefeng Wang     2022-01-19  3093  		ptr = pcpu_fc_alloc(cpu, gi->nr_units * ai->unit_size, atom_size, cpu_to_nd_fn);
c8826dd538602d Tejun Heo       2009-08-14  3094  		if (!ptr) {
c8826dd538602d Tejun Heo       2009-08-14  3095  			rc = -ENOMEM;
c8826dd538602d Tejun Heo       2009-08-14  3096  			goto out_free_areas;
c8826dd538602d Tejun Heo       2009-08-14  3097  		}
f528f0b8e53d73 Catalin Marinas 2011-09-26  3098  		/* kmemleak tracks the percpu allocations separately */
a317ebccaa3609 Patrick Wang    2022-07-05  3099  		kmemleak_ignore_phys(__pa(ptr));
c8826dd538602d Tejun Heo       2009-08-14  3100  		areas[group] = ptr;
c8826dd538602d Tejun Heo       2009-08-14  3101  
c8826dd538602d Tejun Heo       2009-08-14 @3102  		base = min(ptr, base);
9b7396624a7b50 zijun_hu        2016-10-05  3103  		if (ptr > areas[highest_group])
9b7396624a7b50 zijun_hu        2016-10-05  3104  			highest_group = group;
9b7396624a7b50 zijun_hu        2016-10-05  3105  	}
9b7396624a7b50 zijun_hu        2016-10-05  3106  	max_distance = areas[highest_group] - base;
9b7396624a7b50 zijun_hu        2016-10-05  3107  	max_distance += ai->unit_size * ai->groups[highest_group].nr_units;
9b7396624a7b50 zijun_hu        2016-10-05  3108  
9b7396624a7b50 zijun_hu        2016-10-05  3109  	/* warn if maximum distance is further than 75% of vmalloc space */
9b7396624a7b50 zijun_hu        2016-10-05  3110  	if (max_distance > VMALLOC_TOTAL * 3 / 4) {
9b7396624a7b50 zijun_hu        2016-10-05  3111  		pr_warn("max_distance=0x%lx too large for vmalloc space 0x%lx\n",
9b7396624a7b50 zijun_hu        2016-10-05  3112  				max_distance, VMALLOC_TOTAL);
9b7396624a7b50 zijun_hu        2016-10-05  3113  #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
9b7396624a7b50 zijun_hu        2016-10-05  3114  		/* and fail if we have fallback */
9b7396624a7b50 zijun_hu        2016-10-05  3115  		rc = -EINVAL;
9b7396624a7b50 zijun_hu        2016-10-05  3116  		goto out_free_areas;
9b7396624a7b50 zijun_hu        2016-10-05  3117  #endif
42b64281453249 Tejun Heo       2012-04-27  3118  	}
42b64281453249 Tejun Heo       2012-04-27  3119  
42b64281453249 Tejun Heo       2012-04-27  3120  	/*
42b64281453249 Tejun Heo       2012-04-27  3121  	 * Copy data and free unused parts.  This should happen after all
42b64281453249 Tejun Heo       2012-04-27  3122  	 * allocations are complete; otherwise, we may end up with
42b64281453249 Tejun Heo       2012-04-27  3123  	 * overlapping groups.
42b64281453249 Tejun Heo       2012-04-27  3124  	 */
42b64281453249 Tejun Heo       2012-04-27  3125  	for (group = 0; group < ai->nr_groups; group++) {
42b64281453249 Tejun Heo       2012-04-27  3126  		struct pcpu_group_info *gi = &ai->groups[group];
42b64281453249 Tejun Heo       2012-04-27  3127  		void *ptr = areas[group];
66c3a75772247c Tejun Heo       2009-03-10  3128  
c8826dd538602d Tejun Heo       2009-08-14  3129  		for (i = 0; i < gi->nr_units; i++, ptr += ai->unit_size) {
c8826dd538602d Tejun Heo       2009-08-14  3130  			if (gi->cpu_map[i] == NR_CPUS) {
c8826dd538602d Tejun Heo       2009-08-14  3131  				/* unused unit, free whole */
23f917169ef157 Kefeng Wang     2022-01-19  3132  				pcpu_fc_free(ptr, ai->unit_size);
c8826dd538602d Tejun Heo       2009-08-14  3133  				continue;
c8826dd538602d Tejun Heo       2009-08-14  3134  			}
c8826dd538602d Tejun Heo       2009-08-14  3135  			/* copy and return the unused part */
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3136  			memcpy(ptr, __per_cpu_load, ai->static_size);
23f917169ef157 Kefeng Wang     2022-01-19  3137  			pcpu_fc_free(ptr + size_sum, ai->unit_size - size_sum);
c8826dd538602d Tejun Heo       2009-08-14  3138  		}
66c3a75772247c Tejun Heo       2009-03-10  3139  	}
66c3a75772247c Tejun Heo       2009-03-10  3140  
c8826dd538602d Tejun Heo       2009-08-14  3141  	/* base address is now known, determine group base offsets */
6ea529a2037ce6 Tejun Heo       2009-09-24  3142  	for (group = 0; group < ai->nr_groups; group++) {
c8826dd538602d Tejun Heo       2009-08-14  3143  		ai->groups[group].base_offset = areas[group] - base;
6ea529a2037ce6 Tejun Heo       2009-09-24  3144  	}
c8826dd538602d Tejun Heo       2009-08-14  3145  
00206a69ee32f0 Matteo Croce    2019-03-18  3146  	pr_info("Embedded %zu pages/cpu s%zu r%zu d%zu u%zu\n",
00206a69ee32f0 Matteo Croce    2019-03-18  3147  		PFN_DOWN(size_sum), ai->static_size, ai->reserved_size,
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3148  		ai->dyn_size, ai->unit_size);
66c3a75772247c Tejun Heo       2009-03-10  3149  
163fa23435cc9c Kefeng Wang     2019-07-03  3150  	pcpu_setup_first_chunk(ai, base);
c8826dd538602d Tejun Heo       2009-08-14  3151  	goto out_free;
c8826dd538602d Tejun Heo       2009-08-14  3152  
c8826dd538602d Tejun Heo       2009-08-14  3153  out_free_areas:
c8826dd538602d Tejun Heo       2009-08-14  3154  	for (group = 0; group < ai->nr_groups; group++)
f851c8d8583891 Michael Holzheu 2013-09-17  3155  		if (areas[group])
23f917169ef157 Kefeng Wang     2022-01-19  3156  			pcpu_fc_free(areas[group],
c8826dd538602d Tejun Heo       2009-08-14  3157  				ai->groups[group].nr_units * ai->unit_size);
c8826dd538602d Tejun Heo       2009-08-14  3158  out_free:
fd1e8a1fe2b54d Tejun Heo       2009-08-14  3159  	pcpu_free_alloc_info(ai);
c8826dd538602d Tejun Heo       2009-08-14  3160  	if (areas)
4421cca0a3e483 Mike Rapoport   2021-11-05  3161  		memblock_free(areas, areas_size);
fb435d5233f8b6 Tejun Heo       2009-08-14  3162  	return rc;
fa8a7094ba1679 Tejun Heo       2009-06-22  3163  }
3c9a024fde58b0 Tejun Heo       2010-09-09  3164  #endif /* BUILD_EMBED_FIRST_CHUNK */
d4b95f80399471 Tejun Heo       2009-07-04  3165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
