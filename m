Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F171475EB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGXF4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGXF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:56:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537A81AB;
        Sun, 23 Jul 2023 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690178164; x=1721714164;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yCJ1BXzutgoy0IBd25HUHJtrVt+SpnQcvmmJECP+rAk=;
  b=e61ojt3bq6NiX5+ZyC6w9HtOiKWIwl4YU/3j+H1blJrzC6wcfaC28q96
   UiLLEqCkLjkEJUd8UFedeYjfDSHN40WMOzfeL+Z7CiVl41fyIMhjJ03jS
   TSda0H1WJmSUKXpzkU+VMr4j9246vUywqVBp8mS4MD+/aOq198LBLTH7s
   /0QbtmYHQ4klSEk32GqewwlGH6cv96rjJDZtsUjd5AbjfGHErITL9Q+RH
   2r1zCvg8IK9tFmA3/qjc2YrlHJkG1N3XbQqB0RnExfE2rz/aCvET6vZTA
   0ga8auMSFhGWOTFppra3BfOVEHV5Kd6zSPCuZVqPOxNh3O8zJusSAs/jb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="357354450"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="357354450"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 22:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="899393120"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899393120"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 22:56:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
In-Reply-To: <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com> (Vishal
        Verma's message of "Thu, 20 Jul 2023 01:14:23 -0600")
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
        <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date:   Mon, 24 Jul 2023 13:54:23 +0800
Message-ID: <87wmyp26sw.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is currently
> restricted to 'memblock_size' chunks of memory being added. Adding a
> larger span of memory precludes memmap_on_memory semantics.
>
> For users of hotplug such as kmem, large amounts of memory might get
> added from the CXL subsystem. In some cases, this amount may exceed the
> available 'main memory' to store the memmap for the memory being added.
> In this case, it is useful to have a way to place the memmap on the
> memory being added, even if it means splitting the addition into
> memblock-sized chunks.
>
> Change add_memory_resource() to loop over memblock-sized chunks of
> memory if caller requested memmap_on_memory, and if other conditions for
> it are met,. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 154 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 91 insertions(+), 63 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9bcacbcbae2..20456f0d28e6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1286,6 +1286,35 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>  }
>  EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>  
> +static int add_memory_create_devices(int nid, struct memory_group *group,
> +				     u64 start, u64 size, mhp_t mhp_flags)
> +{
> +	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	struct vmem_altmap mhp_altmap = {};
> +	int ret;
> +
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
> +		mhp_altmap.free = PHYS_PFN(size);
> +		mhp_altmap.base_pfn = PHYS_PFN(start);
> +		params.altmap = &mhp_altmap;
> +	}
> +
> +	/* call arch's memory hotadd */
> +	ret = arch_add_memory(nid, start, size, &params);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* create memory block devices after memory was added */
> +	ret = create_memory_block_devices(start, size, mhp_altmap.alloc,
> +					  group);
> +	if (ret) {
> +		arch_remove_memory(start, size, NULL);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1294,11 +1323,10 @@ EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
>   */
>  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
> -	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	unsigned long memblock_size = memory_block_size_bytes();
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {};
>  	struct memory_group *group = NULL;
> -	u64 start, size;
> +	u64 start, size, cur_start;
>  	bool new_node = false;
>  	int ret;
>  
> @@ -1339,27 +1367,20 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	/*
>  	 * Self hosted memmap array
>  	 */
> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (!mhp_supports_memmap_on_memory(size)) {
> -			ret = -EINVAL;
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memblock_size)) {
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			ret = add_memory_create_devices(nid, group, cur_start,
> +							memblock_size,
> +							mhp_flags);
> +			if (ret)
> +				goto error;
> +		}
> +	} else {
> +		ret = add_memory_create_devices(nid, group, start, size, mhp_flags);
> +		if (ret)
>  			goto error;

Another choice to organize code is to use different step (memblock_size
vs. size) in "for" loop.

It's not necessary in this patchset.  It appears that we cannot create
1GB mapping if we put memmap on memory now, right?  If so, is it doable
to support that via separating creating memory mapping from
arch_add_memory()?

> -		}
> -		mhp_altmap.free = PHYS_PFN(size);
> -		mhp_altmap.base_pfn = PHYS_PFN(start);
> -		params.altmap = &mhp_altmap;
> -	}
> -
> -	/* call arch's memory hotadd */
> -	ret = arch_add_memory(nid, start, size, &params);
> -	if (ret < 0)
> -		goto error;
> -
> -	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size, mhp_altmap.alloc,
> -					  group);
> -	if (ret) {
> -		arch_remove_memory(start, size, NULL);
> -		goto error;
>  	}
>  
>  	if (new_node) {
> @@ -2035,12 +2056,38 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> -static int __ref try_remove_memory(u64 start, u64 size)
> +static void __ref __try_remove_memory(int nid, u64 start, u64 size,
> +				     struct vmem_altmap *altmap)
>  {
> -	struct vmem_altmap mhp_altmap = {};
> -	struct vmem_altmap *altmap = NULL;
> -	unsigned long nr_vmemmap_pages;
> -	int rc = 0, nid = NUMA_NO_NODE;
> +	/* remove memmap entry */
> +	firmware_map_remove(start, start + size, "System RAM");

If mhp_supports_memmap_on_memory(), we will call
firmware_map_add_hotplug() for whole range.  But here we may call
firmware_map_remove() for part of range.  Is it OK?

--
Best Regards,
Huang, Ying

> +
> +	/*
> +	 * Memory block device removal under the device_hotplug_lock is
> +	 * a barrier against racing online attempts.
> +	 */
> +	remove_memory_block_devices(start, size);
> +
> +	mem_hotplug_begin();
> +
> +	arch_remove_memory(start, size, altmap);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> +		memblock_phys_free(start, size);
> +		memblock_remove(start, size);
> +	}
> +
> +	release_mem_region_adjustable(start, size);
> +
> +	if (nid != NUMA_NO_NODE)
> +		try_offline_node(nid);
> +
> +	mem_hotplug_done();
> +}
> +
> +static int try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -2058,20 +2105,21 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  		return rc;
>  
>  	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap
>  	 */
>  	if (mhp_memmap_on_memory()) {
> -		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
> -						      get_nr_vmemmap_pages_cb);
> -		if (nr_vmemmap_pages) {
> -			if (size != memory_block_size_bytes()) {
> -				pr_warn("Refuse to remove %#llx - %#llx,"
> -					"wrong granularity\n",
> -					start, start + size);
> -				return -EINVAL;
> -			}
> +		unsigned long memblock_size = memory_block_size_bytes();
> +		struct vmem_altmap mhp_altmap = {};
> +		struct vmem_altmap *altmap;
> +		u64 cur_start;
>  
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			unsigned long nr_vmemmap_pages =
> +				walk_memory_blocks(start, memblock_size, NULL,
> +						   get_nr_vmemmap_pages_cb);
>  			/*
>  			 * Let remove_pmd_table->free_hugepage_table do the
>  			 * right thing if we used vmem_altmap when hot-adding
> @@ -2079,33 +2127,13 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  			 */
>  			mhp_altmap.alloc = nr_vmemmap_pages;
>  			altmap = &mhp_altmap;
> +			__try_remove_memory(nid, cur_start, memblock_size,
> +						 altmap);
>  		}
> +	} else {
> +		__try_remove_memory(nid, start, size, NULL);
>  	}
>  
> -	/* remove memmap entry */
> -	firmware_map_remove(start, start + size, "System RAM");
> -
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */
> -	remove_memory_block_devices(start, size);
> -
> -	mem_hotplug_begin();
> -
> -	arch_remove_memory(start, size, altmap);
> -
> -	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> -		memblock_phys_free(start, size);
> -		memblock_remove(start, size);
> -	}
> -
> -	release_mem_region_adjustable(start, size);
> -
> -	if (nid != NUMA_NO_NODE)
> -		try_offline_node(nid);
> -
> -	mem_hotplug_done();
>  	return 0;
>  }
