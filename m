Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310F7BC643
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbjJGI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJGI53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:57:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F5BB;
        Sat,  7 Oct 2023 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696669047; x=1728205047;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=zZfpmpOa9xub7U4t7n92Ku/R19iFPsHPDUZaIQJfc8A=;
  b=VVbeo/C/c0ak1Dgv21AWQQkdFv1IG1SDu3fPrCD7eyHyrqJ4bx3TB3Lg
   NDbvHdPjvDH4g3yPaHIouyw2VmOGXxMvOfIbyfmxZ1If8bzjENDfcxwil
   v4VfIw1O0VLeu5xL4NMHbA6Fph0d0hUwAYsPfgTvu/+nVr8JfTYrxdoRc
   tu8nW8mY+c34LErCFER8CLxTP+0d5sW/hTUHUzWPEkpJ+nKvbbknwBn/G
   MZ8xxZKNq+p4aqsy85LgyzP24DZbT7W6K6JIkwN2n+F1yJQqeV1cRSz9h
   18uFERvpgtWiV83Aex/RIvJg4a3JU17Zra9ZGRXXoPQHDJN+AzmRSjlZI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470176975"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="470176975"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 01:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="746140872"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="746140872"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 01:57:23 -0700
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
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
        <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
Date:   Sat, 07 Oct 2023 16:55:19 +0800
In-Reply-To: <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com> (Vishal
        Verma's message of "Thu, 5 Oct 2023 12:31:39 -0600")
Message-ID: <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  mm/memory_hotplug.c | 162 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 99 insertions(+), 63 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f8d3e7427e32..77ec6f15f943 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,44 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>  	return arch_supports_memmap_on_memory(vmemmap_size);
>  }
>  
> +static int add_memory_create_devices(int nid, struct memory_group *group,
> +				     u64 start, u64 size, mhp_t mhp_flags)
> +{
> +	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	struct vmem_altmap mhp_altmap = {
> +		.base_pfn =  PHYS_PFN(start),
> +		.end_pfn  =  PHYS_PFN(start + size - 1),
> +	};
> +	int ret;
> +
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
> +		mhp_altmap.free = memory_block_memmap_on_memory_pages();
> +		params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
> +		if (!params.altmap)
> +			return -ENOMEM;
> +
> +		memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
> +	}
> +
> +	/* call arch's memory hotadd */
> +	ret = arch_add_memory(nid, start, size, &params);
> +	if (ret < 0)
> +		goto error;
> +
> +	/* create memory block devices after memory was added */
> +	ret = create_memory_block_devices(start, size, params.altmap, group);
> +	if (ret)
> +		goto err_bdev;
> +
> +	return 0;
> +
> +err_bdev:
> +	arch_remove_memory(start, size, NULL);
> +error:
> +	kfree(params.altmap);
> +	return ret;
> +}
> +
>  /*
>   * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>   * and online/offline operations (triggered e.g. by sysfs).
> @@ -1388,14 +1426,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>   */
>  int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  {
> -	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	unsigned long memblock_size = memory_block_size_bytes();
>  	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {
> -		.base_pfn =  PHYS_PFN(res->start),
> -		.end_pfn  =  PHYS_PFN(res->end),
> -	};
>  	struct memory_group *group = NULL;
> -	u64 start, size;
> +	u64 start, size, cur_start;
>  	bool new_node = false;
>  	int ret;
>  
> @@ -1436,28 +1470,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	/*
>  	 * Self hosted memmap array
>  	 */
> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (mhp_supports_memmap_on_memory(size)) {
> -			mhp_altmap.free = memory_block_memmap_on_memory_pages();
> -			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
> -			if (!params.altmap)
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memblock_size)) {
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			ret = add_memory_create_devices(nid, group, cur_start,
> +							memblock_size,
> +							mhp_flags);
> +			if (ret)
>  				goto error;
> -
> -			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
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
> +	} else {
> +		ret = add_memory_create_devices(nid, group, start, size,
> +						mhp_flags);
> +		if (ret)
> +			goto error;
>  	}
>  
>  	if (new_node) {
> @@ -1494,8 +1521,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  		walk_memory_blocks(start, size, NULL, online_memory_block);
>  
>  	return ret;
> -error_free:
> -	kfree(params.altmap);
>  error:
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
> @@ -2146,12 +2171,41 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> -static int __ref try_remove_memory(u64 start, u64 size)
> +static void __ref remove_memory_block_and_altmap(int nid, u64 start, u64 size)
>  {
> +	int rc = 0;
>  	struct memory_block *mem;
> -	int rc = 0, nid = NUMA_NO_NODE;
>  	struct vmem_altmap *altmap = NULL;
>  
> +	rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
> +	if (rc) {
> +		altmap = mem->altmap;
> +		/*
> +		 * Mark altmap NULL so that we can add a debug
> +		 * check on memblock free.
> +		 */
> +		mem->altmap = NULL;
> +	}
> +
> +	/*
> +	 * Memory block device removal under the device_hotplug_lock is
> +	 * a barrier against racing online attempts.
> +	 */
> +	remove_memory_block_devices(start, size);
> +
> +	arch_remove_memory(start, size, altmap);
> +
> +	/* Verify that all vmemmap pages have actually been freed. */
> +	if (altmap) {
> +		WARN(altmap->alloc, "Altmap not fully unmapped");
> +		kfree(altmap);
> +	}
> +}
> +
> +static int __ref try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
> +
>  	BUG_ON(check_hotplug_memory_range(start, size));
>  
>  	/*
> @@ -2167,47 +2221,28 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  	if (rc)
>  		return rc;
>  
> +	mem_hotplug_begin();
> +
>  	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap.
>  	 */
>  	if (mhp_memmap_on_memory()) {

IIUC, even if mhp_memmap_on_memory() returns true, it's still possible
that the memmap is put in DRAM after [2/2].  So that,
arch_remove_memory() are called for each memory block unnecessarily.  Can
we detect this (via altmap?) and call remove_memory_block_and_altmap()
for the whole range?

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
> +		unsigned long memblock_size = memory_block_size_bytes();
> +		u64 cur_start;
> +
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size)
> +			remove_memory_block_and_altmap(nid, cur_start,
> +						       memblock_size);
> +	} else {
> +		remove_memory_block_and_altmap(nid, start, size);
>  	}
>  
>  	/* remove memmap entry */
>  	firmware_map_remove(start, start + size, "System RAM");
>  
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
> -	/* Verify that all vmemmap pages have actually been freed. */
> -	if (altmap) {
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> -	}
> -
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>  		memblock_phys_free(start, size);
>  		memblock_remove(start, size);
> @@ -2219,6 +2254,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>  		try_offline_node(nid);
>  
>  	mem_hotplug_done();
> +
>  	return 0;
>  }

--
Best Regards,
Huang, Ying
