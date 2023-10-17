Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28FE7CC721
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjJQPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbjJQPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502F52D62
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697554182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cgiUWmuX7npTry/TKlHFAgqdXewDmk3A8hEeG0P7Xxw=;
        b=X319JHposN8aA3qqNwkOWZwCWPG53+ErLcN5d/XgysTHyNcUSVaKxwyXj+/Lhx7OprtAOG
        dee96nb6TjT81XDyc7isjgEQog3ZXLYdk3P8P+orNlrpW+iyjfy4D0qKGViUXHOLv/q4sS
        /J8n1RtjUZZL+VhgUmMIIX3Irn5/dbk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-4_PUK9-1P9udYD0EmsuSlA-1; Tue, 17 Oct 2023 10:49:41 -0400
X-MC-Unique: 4_PUK9-1P9udYD0EmsuSlA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c50c873604so37711041fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554180; x=1698158980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgiUWmuX7npTry/TKlHFAgqdXewDmk3A8hEeG0P7Xxw=;
        b=TA7uttxOwCQi1l4k+OEInsnrstBRF2XlCwSsTVdZQSFele8sO9VzMRA1F2VMY7CXfU
         JD4M6Ac8iEzUy+vRzgruse9LHj88I/zwngE9+/JgCc1tD5MuJ8lMIzjl3TQyEHMOFazt
         WXhY4CGZpgbsMM1C+6r824AelObmDEl7VuGaYeryJ2VcQBkkBWnpe2wHGuJaX2lw1HQz
         p5NTuAsdLRWlYpnDZ95UFdn/N2sb5uEH3ZV7IFIylmJ0E3DwpLOhgxHqpHZO5ZEm6+pI
         G8XG4/KnUkFLT7lXjhIgIo95xYAs57/uXjBxVwMUONZuqBUdoCL09vYfBfSb3kwhzSB3
         8Kwg==
X-Gm-Message-State: AOJu0YyeaYQWo0xGufe/fu89NfyHG7omhp4Gbgaz46eqCCPPjPBRTvWk
        SBnLCdQGTC8Wam93RZh5+VGvVYiG17fRJrztavbhN3Nkdb7IRUDTIhb3G/Rm/nEbuXE5uOODXxb
        KbWfPAG1KvBFvzDcwrD6EeGas
X-Received: by 2002:a2e:bc1f:0:b0:2c5:2eaa:5397 with SMTP id b31-20020a2ebc1f000000b002c52eaa5397mr2165318ljf.11.1697554180074;
        Tue, 17 Oct 2023 07:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMQwcxOXYj6opxfFZwl3ey/MUOWi8jwJ5LHdy6KJAfhwqqv/b6uaCUPrLxmB3ZbVJyaPzQQw==
X-Received: by 2002:a2e:bc1f:0:b0:2c5:2eaa:5397 with SMTP id b31-20020a2ebc1f000000b002c52eaa5397mr2165288ljf.11.1697554179598;
        Tue, 17 Oct 2023 07:49:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5100:93b1:f654:ad11:cd81? (p200300cbc743510093b1f654ad11cd81.dip0.t-ipconnect.de. [2003:cb:c743:5100:93b1:f654:ad11:cd81])
        by smtp.gmail.com with ESMTPSA id fm19-20020a05600c0c1300b00405959bbf4fsm2087849wmb.19.2023.10.17.07.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:49:39 -0700 (PDT)
Message-ID: <f2720382-5374-4b8f-ad3c-f3f13e4a3767@redhat.com>
Date:   Tue, 17 Oct 2023 16:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com>
 <20231016-vv-kmem_memmap-v6-2-078f0d3c0371@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231016-vv-kmem_memmap-v6-2-078f0d3c0371@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.23 07:44, Vishal Verma wrote:
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
>   mm/memory_hotplug.c | 214 ++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 148 insertions(+), 66 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 6be7de9efa55..83e5ec377aad 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1380,6 +1380,43 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>   	return arch_supports_memmap_on_memory(vmemmap_size);
>   }
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
>   /*
>    * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>    * and online/offline operations (triggered e.g. by sysfs).
> @@ -1388,14 +1425,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>    */
>   int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   {
> -	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
> +	unsigned long memblock_size = memory_block_size_bytes();
>   	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
> -	struct vmem_altmap mhp_altmap = {
> -		.base_pfn =  PHYS_PFN(res->start),
> -		.end_pfn  =  PHYS_PFN(res->end),
> -	};
>   	struct memory_group *group = NULL;
> -	u64 start, size;
> +	u64 start, size, cur_start;
>   	bool new_node = false;
>   	int ret;
>   
> @@ -1436,28 +1469,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   	/*
>   	 * Self hosted memmap array
>   	 */
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

Just like on the removal part, that function doesn't make any sense to 
be called with altmap and a bigger range.

Maybe better also move that loop into a function called 
"create_altmap_and_memory_blocks()" , to be the opposite of 
"remove_memory_blocks_and_altmaps()".

Then you can keep the existing !altmap code here in the "else" case. 
Again, similar to the removal code below.

> +			if (ret)
>   				goto error;
>   		}
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
>   	}
>   
>   	if (new_node) {
> @@ -1494,8 +1520,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   		walk_memory_blocks(start, size, NULL, online_memory_block);
>   
>   	return ret;
> -error_free:
> -	kfree(params.altmap);
>   error:
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>   		memblock_remove(start, size);
> @@ -2076,6 +2100,23 @@ static int test_has_altmap_cb(struct memory_block *mem, void *arg)
>   	return 0;
>   }


[...]

> +
> +static int memblocks_have_altmaps(u64 start, u64 size)
> +{
> +	struct memory_range_altmap_info altmap_info = {
> +		.num_memblocks = 0,
> +		.num_altmaps = 0
> +	};

You can get the number of memblocks simply by "size / 
memory_block_size_bytes()". So you can avoid the "struct" and just pass 
an int.

> +
> +	if (!mhp_memmap_on_memory())
> +		return 0;
> +
> +	walk_memory_blocks(start, size, &altmap_info,
> +			   count_memory_range_altmaps_cb);
> +
> +	if (!altmap_info.num_altmaps)
> +		return 0;
> +
> +	if (altmap_info.num_memblocks != altmap_info.num_altmaps) {
> +		WARN_ONCE(1, "Not all memblocks in range have altmaps");
> +		return -EINVAL;
> +	}
> +
> +	return 1;
> +}
> +
> +static int __ref try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
>   
>   	BUG_ON(check_hotplug_memory_range(start, size));
>   
> @@ -2167,45 +2272,21 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   	if (rc)
>   		return rc;
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
>   	/* remove memmap entry */
>   	firmware_map_remove(start, start + size, "System RAM");
>   
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */

Maybe move that comment into the else branch and not into 
remove_memory_blocks_and_altmaps

> -	remove_memory_block_devices(start, size);
> -
>   	mem_hotplug_begin();
>   
> -	arch_remove_memory(start, size, altmap);
> -
> -	/* Verify that all vmemmap pages have actually been freed. */
> -	if (altmap) {
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> +	rc = memblocks_have_altmaps(start, size);

Don't use the term memblocks here, to not confuse it with the memblock 
allocator.

"memory blocks" or "memory block devices". it's complicated.

> +	if (rc < 0) {
> +		goto err;
> +	} else if (rc == 0) {
> +		/* no altmaps, do the removal directly */
> +		remove_memory_block_devices(start, size);
> +		arch_remove_memory(start, size, NULL);
> +	} else {
> +		/* all memblocks in the range have altmaps */
> +		remove_memory_blocks_and_altmaps(start, size);
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> @@ -2218,8 +2299,9 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   	if (nid != NUMA_NO_NODE)
>   		try_offline_node(nid);
>   
> +err:
>   	mem_hotplug_done();
> -	return 0;
> +	return (rc < 0 ? rc : 0);
>   }
>   
>   /**
> 

-- 
Cheers,

David / dhildenb

