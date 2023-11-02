Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A237DE9F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348191AbjKBBSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347896AbjKBBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879BFD;
        Wed,  1 Nov 2023 18:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698887921; x=1730423921;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=w5QvYhQUm/Yol4oko8AhL7voOb2RQaezwjaupPx38bg=;
  b=Z80D6ox1i5ipKkheGzDQY5aAXazL6m/wa8pbU3lqUts581G/6o7taEKg
   n+tUi8V1157+rMgx0hnGBkioFyGOmrmeWZZGI1nIX0/Q9DUcSpkMFTGOu
   PmESi9AOKbjZmDkeTxx0Tha9Yp9q6Lu/uG/o6rfa4e/oE7UbpzMU64R3G
   XR3h+Kvof12XwRQvsYI1NievzM3ZaKYwKr7WM/LqcwgmtT84H8bj0YhCa
   9SCe1orplQhW3EK8++RPUoUqpdYo38epoAPLV51pCmfWaULcp5XhnASSt
   t/B06oMzD0SzWAYhb6iJ6XSd9J80fbmbK8jY6otCr+Y3iUEwTyoRAw9ge
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1531622"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="1531622"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 18:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="826949234"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="826949234"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 18:18:33 -0700
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
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v8 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
In-Reply-To: <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com> (Vishal
        Verma's message of "Wed, 1 Nov 2023 16:51:52 -0600")
References: <20231101-vv-kmem_memmap-v8-0-5e4a83331388@intel.com>
        <20231101-vv-kmem_memmap-v8-2-5e4a83331388@intel.com>
Date:   Thu, 02 Nov 2023 09:16:32 +0800
Message-ID: <87edh93qfj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
> 'memblock_size' chunks of memory being added. Adding a larger span of
> memory precludes memmap_on_memory semantics.
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
> it are met. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
>
> This does preclude being able to use PUD mappings in the direct map; a
> proposal to how this could be optimized in the future is laid out
> here[1].
>
> [1]: https://lore.kernel.org/linux-mm/b6753402-2de9-25b2-36e9-eacd49752b19@redhat.com/
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 213 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 138 insertions(+), 75 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6be7de9efa55..d242e49d7f7b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,84 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>  	return arch_supports_memmap_on_memory(vmemmap_size);
>  }
>  
> +static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
> +{
> +	unsigned long memblock_size = memory_block_size_bytes();
> +	u64 cur_start;
> +
> +	/*
> +	 * For memmap_on_memory, the altmaps were added on a per-memblock
> +	 * basis; we have to process each individual memory block.
> +	 */
> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		struct vmem_altmap *altmap = NULL;
> +		struct memory_block *mem;
> +
> +		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		WARN_ON_ONCE(!mem);
> +		if (!mem)
> +			continue;
> +
> +		altmap = mem->altmap;
> +		mem->altmap = NULL;
> +
> +		remove_memory_block_devices(cur_start, memblock_size);
> +
> +		arch_remove_memory(cur_start, memblock_size, altmap);
> +
> +		/* Verify that all vmemmap pages have actually been freed. */
> +		WARN(altmap->alloc, "Altmap not fully unmapped");
> +		kfree(altmap);
> +	}
> +}
> +
> +static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
> +					    u64 start, u64 size)
> +{
> +	unsigned long memblock_size = memory_block_size_bytes();
> +	u64 cur_start;
> +	int ret;
> +
> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		struct mhp_params params = { .pgprot =
> +						     pgprot_mhp(PAGE_KERNEL) };
> +		struct vmem_altmap mhp_altmap = {
> +			.base_pfn = PHYS_PFN(cur_start),
> +			.end_pfn = PHYS_PFN(cur_start + memblock_size - 1),
> +		};
> +
> +		mhp_altmap.free = memory_block_memmap_on_memory_pages();
> +		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
> +					GFP_KERNEL);
> +		if (!params.altmap)
> +			return -ENOMEM;

Use "goto out" here too?

> +
> +		/* call arch's memory hotadd */
> +		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
> +		if (ret < 0) {
> +			kfree(params.altmap);
> +			goto out;
> +		}
> +
> +		/* create memory block devices after memory was added */
> +		ret = create_memory_block_devices(cur_start, memblock_size,
> +						  params.altmap, group);
> +		if (ret) {
> +			arch_remove_memory(cur_start, memblock_size, NULL);
> +			kfree(params.altmap);

How about move arch_remove_memory() and kree() to error path and use
different label?

--
Best Regards,
Huang, Ying

> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	if (ret && (cur_start != start))
> +		remove_memory_blocks_and_altmaps(start, cur_start - start);
> +	return ret;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1390,10 +1468,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
>  	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {
> -		.base_pfn =  PHYS_PFN(res->start),
> -		.end_pfn  =  PHYS_PFN(res->end),
> -	};
>  	struct memory_group *group = NULL;
>  	u64 start, size;
>  	bool new_node = false;
> @@ -1436,28 +1510,22 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	/*
>  	 * Self hosted memmap array
>  	 */
> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (mhp_supports_memmap_on_memory(size)) {
> -			mhp_altmap.free = memory_block_memmap_on_memory_pages();
> -			params.altmap = kmemdup(&mhp_altmap,
> -						sizeof(struct vmem_altmap),
> -						GFP_KERNEL);
> -			if (!params.altmap)
> -				goto error;
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
> +		ret = create_altmaps_and_memory_blocks(nid, group, start, size);
> +		if (ret)
> +			goto error;
> +	} else {
> +		ret = arch_add_memory(nid, start, size, &params);
> +		if (ret < 0)
> +			goto error;
> +
> +		/* create memory block devices after memory was added */
> +		ret = create_memory_block_devices(start, size, NULL, group);
> +		if (ret) {
> +			arch_remove_memory(start, size, NULL);
> +			goto error;
>  		}
> -		/* fallback to not using altmap  */
> -	}
> -
> -	/* call arch's memory hotadd */
> -	ret = arch_add_memory(nid, start, size, &params);
> -	if (ret < 0)
> -		goto error_free;
> -
> -	/* create memory block devices after memory was added */
> -	ret = create_memory_block_devices(start, size, params.altmap, group);
> -	if (ret) {
> -		arch_remove_memory(start, size, NULL);
> -		goto error_free;
>  	}
>  
>  	if (new_node) {
> @@ -1494,8 +1562,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
> -error_free:
> -	kfree(params.altmap);
>  error:
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
> @@ -2062,17 +2128,13 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  	return 0;
>  }
>  
> -static int test_has_altmap_cb(struct memory_block *mem, void *arg)
> +static int count_memory_range_altmaps_cb(struct memory_block *mem, void *arg)
>  {
> -	struct memory_block **mem_ptr = (struct memory_block **)arg;
> -	/*
> -	 * return the memblock if we have altmap
> -	 * and break callback.
> -	 */
> -	if (mem->altmap) {
> -		*mem_ptr = mem;
> -		return 1;
> -	}
> +	u64 *num_altmaps = (u64 *)arg;
> +
> +	if (mem->altmap)
> +		*num_altmaps += 1;
> +
>  	return 0;
>  }
>  
> @@ -2146,11 +2208,31 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> +static int memory_blocks_have_altmaps(u64 start, u64 size)
> +{
> +	u64 num_memblocks = size / memory_block_size_bytes();
> +	u64 num_altmaps = 0;
> +
> +	if (!mhp_memmap_on_memory())
> +		return 0;
> +
> +	walk_memory_blocks(start, size, &num_altmaps,
> +			   count_memory_range_altmaps_cb);
> +
> +	if (num_altmaps == 0)
> +		return 0;
> +
> +	if (num_memblocks != num_altmaps) {
> +		WARN_ONCE(1, "Not all memblocks in range have altmaps");
> +		return -EINVAL;
> +	}
> +
> +	return 1;
> +}
> +
>  static int __ref try_remove_memory(u64 start, u64 size)
>  {
> -	struct memory_block *mem;
> -	int rc = 0, nid = NUMA_NO_NODE;
> -	struct vmem_altmap *altmap = NULL;
> +	int rc, nid = NUMA_NO_NODE;
>  
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
> @@ -2167,45 +2249,25 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> -	 */
> -	if (mhp_memmap_on_memory()) {
> -		rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
> -		if (rc) {
> -			if (size != memory_block_size_bytes()) {
> -				pr_warn("Refuse to remove %#llx - %#llx,"
> -					"wrong granularity\n",
> -					start, start + size);
> -				return -EINVAL;
> -			}
> -			altmap = mem->altmap;
> -			/*
> -			 * Mark altmap NULL so that we can add a debug
> -			 * check on memblock free.
> -			 */
> -			mem->altmap = NULL;
> -		}
> -	}
> -
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
>  
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */
> -	remove_memory_block_devices(start, size);
> -
>  	mem_hotplug_begin();
>  
> -	arch_remove_memory(start, size, altmap);
> -
> -	/* Verify that all vmemmap pages have actually been freed. */
> -	if (altmap) {
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> +	rc = memory_blocks_have_altmaps(start, size);
> +	if (rc < 0) {
> +		goto err;
> +	} else if (rc == 0) {
> +		/*
> +		 * Memory block device removal under the device_hotplug_lock is
> +		 * a barrier against racing online attempts.
> +		 * No altmaps present, do the removal directly
> +		 */
> +		remove_memory_block_devices(start, size);
> +		arch_remove_memory(start, size, NULL);
> +	} else {
> +		/* all memblocks in the range have altmaps */
> +		remove_memory_blocks_and_altmaps(start, size);
>  	}
>  
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> @@ -2218,8 +2280,9 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	if (nid != NUMA_NO_NODE)
>  		try_offline_node(nid);
>  
> +err:
>  	mem_hotplug_done();
> -	return 0;
> +	return (rc < 0 ? rc : 0);
>  }
>  
>  /**
