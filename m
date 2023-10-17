Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5587CBB65
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjJQGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjJQGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:36:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1053BF2;
        Mon, 16 Oct 2023 23:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697524564; x=1729060564;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8wDI3J0rMeUZRH2E/5/X0qCBYLFQh17ccQMYB6fq62g=;
  b=lUmtzHtBr0zH7yXRfqRXJi/h1EYDgYe2N+3wNjBkp9h/AWWW+2xlDnWk
   K3W4eRem4BVpSi8HJTRlGTF9Hy6IgeW1aopG3BdVIRTiFEBMbuVY/IuvQ
   yCkw9mPGf6pXn/Ofg1UM6inKgaxmIupnQOfxKevlLv1NEyH3tD6tVUGMD
   OHhuEGw6Rx5gEu8gO9OChplYKd23zq3WA+7+FuC+gGfAAMN6j8tfg5ZPT
   sboZ9WKExadWTAASnU4VzsEadj7DNf63hsBBMbwpC4aTvnbczPyImYeLH
   LCpkdUOibwsKsPFpNizLpLCVWfbohxmo32nM61Dtbc9eM4wzF3QFUhzwg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471929452"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="471929452"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 23:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="846703508"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="846703508"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 23:35:57 -0700
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
Subject: Re: [PATCH v6 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
In-Reply-To: <20231016-vv-kmem_memmap-v6-2-078f0d3c0371@intel.com> (Vishal
        Verma's message of "Mon, 16 Oct 2023 23:44:56 -0600")
References: <20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com>
        <20231016-vv-kmem_memmap-v6-2-078f0d3c0371@intel.com>
Date:   Tue, 17 Oct 2023 14:33:57 +0800
Message-ID: <87zg0h7o6i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
>  mm/memory_hotplug.c | 214 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 148 insertions(+), 66 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6be7de9efa55..83e5ec377aad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,43 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
> +		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
> +					GFP_KERNEL);
> +		if (!params.altmap)
> +			return -ENOMEM;
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
> @@ -1388,14 +1425,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
> @@ -1436,28 +1469,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
> +	    mhp_supports_memmap_on_memory(memblock_size)) {
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size) {
> +			ret = add_memory_create_devices(nid, group, cur_start,
> +							memblock_size,
> +							mhp_flags);
> +			if (ret)
>  				goto error;
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

IIUC, if (mhp_flags & MHP_MEMMAP_ON_MEMORY) == true and
mhp_supports_memmap_on_memory(memblock_size) == false, we will go here
and allocate params.altmap in add_memory_create_devices().  If so, it
seems better to pass whether to create altmap instead of mhp_flags to
add_memory_create_devices().

--
Best Regards,
Huang, Ying

> +		if (ret)
> +			goto error;
>  	}
>  
>  	if (new_node) {

[snip]
