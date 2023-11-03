Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F047DFD9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjKCAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCAjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:39:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA28E;
        Thu,  2 Nov 2023 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698971938; x=1730507938;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/CeBh+tzmlQiByMF568iqGIaXM5KKPi8o5Pv8aTveOI=;
  b=NUM+klhqeCNDhPSsPIfD+MSG5alfvm7Hpa8bkyg7elqvjg3yi5GJ9du1
   i43nmnuFzYnKqrawkcA4LqpVBy9b03ttLjbNlNipQto0Kp9f3JxpgRuVz
   AHsbQLtxa541owC+2CgUGIWO3gIF1wSZBz7O6/6PRZgrsLpkPXS2qt/YF
   /x8enDF99Ny+Lg0aEEkg+QZTRW8NCL5Avyie/ONvg/GdVfxELh/ePHNeE
   OP6KmI7q7fH9I+YorcWItwFn9ZbSFTLpSHM7zYkL2MkaFxv+r2le1kbGT
   69EaC5PdCoejpW8uBV9pNVynigGzOv58K8p2bmyK2cHR+t1J7QXh6z/Sf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419957275"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419957275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9193955"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:38:55 -0700
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
Subject: Re: [PATCH v9 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
In-Reply-To: <20231102-vv-kmem_memmap-v9-2-973d6b3a8f1a@intel.com> (Vishal
        Verma's message of "Thu, 2 Nov 2023 12:27:14 -0600")
References: <20231102-vv-kmem_memmap-v9-0-973d6b3a8f1a@intel.com>
        <20231102-vv-kmem_memmap-v9-2-973d6b3a8f1a@intel.com>
Date:   Fri, 03 Nov 2023 08:36:52 +0800
Message-ID: <87wmuzzn8b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/memory_hotplug.c | 210 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 136 insertions(+), 74 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6be7de9efa55..b380675ab932 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,85 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
> +		if (WARN_ON_ONCE(!mem))
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
> +		if (!params.altmap) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
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
> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	if (ret && cur_start != start)
> +		remove_memory_blocks_and_altmaps(start, cur_start - start);
> +	return ret;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1390,10 +1469,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
> @@ -1436,28 +1511,22 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
> @@ -1494,8 +1563,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
> -error_free:
> -	kfree(params.altmap);
>  error:
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
> @@ -2062,17 +2129,13 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
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
> @@ -2146,11 +2209,29 @@ void try_offline_node(int nid)
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
> +	if (WARN_ON_ONCE(num_memblocks != num_altmaps))
> +		return -EINVAL;
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
> @@ -2167,45 +2248,26 @@ static int __ref try_remove_memory(u64 start, u64 size)
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
> +		mem_hotplug_done();
> +		return rc;
> +	} else if (!rc) {
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
