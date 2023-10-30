Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629217DB7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjJ3KY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJ3KY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D72688
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698661226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5LK3NrzkfOof1kZmFIFKBX84P630qta/Emok9ahJO90=;
        b=YgIVxBYgQmqTy355E7S4mbLHObXkjCTVbDAxVIKpBHcOXzY3zClYYoSeHp2yx1Rh1c4ycw
        hfDk6eOMZUyHsvOYHsSf0SeWcIqpZIj99ORLng35nEKs0CWQjBNAHp0PvHKTdB0UXXAu1d
        ZOCvb1tbgjM+Ipu60tx+p2MrqFHOtfc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-66H6pjoLN5GAUF-ikUDe7Q-1; Mon, 30 Oct 2023 06:20:24 -0400
X-MC-Unique: 66H6pjoLN5GAUF-ikUDe7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40837aa4a58so29218605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661223; x=1699266023;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LK3NrzkfOof1kZmFIFKBX84P630qta/Emok9ahJO90=;
        b=OJVi8HtAMRhNDtcvSS4fvAqWnI/2wrJ8/I/DHxIWoDysTWzrHxXQY2erRGa0q4itkL
         bhY1QMUdNtaasus5lYt/XZjJNyYt8BPzqN2FAMQXe5meHbcYMRaaIJITepjgqM5x+/Uw
         5SoMvKUlYmYTqBVbz76tCyOKgsNVwVu5akh6Ga3W9FpEg7bkfphWyZtddgW/6aUXE6lF
         818A+sCT/W3sBnCgc+SJLaGUe1cbz0NqNFDg6tMabFQMRUzwuPg+FWHDWZkvvjvKcewN
         rNIaeUsSfCCvHoJQRs9F/gIFLWjK1A8okIIIYWkkKS2xJzzAoOWW4KwRYQn1wpEtGzPA
         d5QQ==
X-Gm-Message-State: AOJu0YzPE4dfBie0JmzdIh5eZiSMdf2TPPEe8UR7JPhGJQAjrhd5BbR5
        3cxtwtkMFQJzTgSMFNlss6CMlpjez4QevAJ4CnxGpJ0x3LKJtJgXBIO9H+3CxMbovehmGW7AO8e
        1jFW6FeJhY1GyAOeZnIHdrlNU
X-Received: by 2002:a05:600c:3201:b0:407:73fc:6818 with SMTP id r1-20020a05600c320100b0040773fc6818mr15618889wmp.2.1698661223492;
        Mon, 30 Oct 2023 03:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQuzuAxZtRJHs1EdjAPlMBrRwxFa4HpNj1UBuVapo4QQIwVdPIJf70fLx+5hRrBgxnofop+A==
X-Received: by 2002:a05:600c:3201:b0:407:73fc:6818 with SMTP id r1-20020a05600c320100b0040773fc6818mr15618860wmp.2.1698661223050;
        Mon, 30 Oct 2023 03:20:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:f800:7df6:a2c9:652e:c799? (p200300cbc73cf8007df6a2c9652ec799.dip0.t-ipconnect.de. [2003:cb:c73c:f800:7df6:a2c9:652e:c799])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0040651505684sm8840526wmq.29.2023.10.30.03.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 03:20:22 -0700 (PDT)
Message-ID: <4df63333-de57-4a58-a110-77b4fdfa6a9e@redhat.com>
Date:   Mon, 30 Oct 2023 11:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] mm/memory_hotplug: split memmap_on_memory requests
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
References: <20231025-vv-kmem_memmap-v7-0-4a76d7652df5@intel.com>
 <20231025-vv-kmem_memmap-v7-2-4a76d7652df5@intel.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231025-vv-kmem_memmap-v7-2-4a76d7652df5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.23 00:44, Vishal Verma wrote:
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


Almost there, I think :)

>   
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

Best to cleanup here instead of handling it in the caller [as noted by 
Vishal, we might not be doing that yet]. Using 
remove_memory_blocks_and_altmaps() on the fully processed range sounds 
reasonable.

maybe something like

ret = arch_add_memory(nid, cur_start, memblock_size, &params);
if (ret) {
	kfree(params.altmap);
	goto out;
}

ret = create_memory_block_devices(cur_start, memblock_size,
				   params.altmap, group);
if (ret) {
	arch_remove_memory(cur_start, memblock_size, NULL);
	kfree(params.altmap);
	goto out;
}

if (ret && cur_start != start)
	remove_memory_blocks_and_altmaps(start, cur_start - start);
return ret;

> +
> +		/* call arch's memory hotadd */
> +		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
> +		if (ret < 0) {
> +			kfree(params.altmap);
> +			return ret;
> +		}
> +
> +		/* create memory block devices after memory was added */
> +		ret = create_memory_block_devices(cur_start, memblock_size,
> +						  params.altmap, group);
> +		if (ret) {
> +			arch_remove_memory(cur_start, memblock_size, NULL);
> +			kfree(params.altmap);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

[...]

>   static int check_cpu_on_node(int nid)
>   {
>   	int cpu;
> @@ -2146,11 +2186,69 @@ void try_offline_node(int nid)
>   }
>   EXPORT_SYMBOL(try_offline_node);
>   
> -static int __ref try_remove_memory(u64 start, u64 size)
> +static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
>   {
> -	struct memory_block *mem;
> -	int rc = 0, nid = NUMA_NO_NODE;
> +	unsigned long memblock_size = memory_block_size_bytes();
>   	struct vmem_altmap *altmap = NULL;
> +	struct memory_block *mem;
> +	u64 cur_start;
> +	int rc;
> +
> +	/*
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap.
> +	 */

/*
  * altmaps where added on a per-memblock basis; we have to process
  * each individual memory block.
  */

> +	for (cur_start = start; cur_start < start + size;
> +	     cur_start += memblock_size) {
> +		rc = walk_memory_blocks(cur_start, memblock_size, &mem,
> +					test_has_altmap_cb);
> +		if (rc) {
> +			altmap = mem->altmap;
> +			/*
> +			 * Mark altmap NULL so that we can add a debug
> +			 * check on memblock free.
> +			 */
> +			mem->altmap = NULL;
> +		}

Simpler (especially, we know that there must be an altmap):

mem = find_memory_block(pfn_to_section_nr(cur_start));
altmap = mem->altmap;
mem->altmap = NULL;

I think we might be able to remove test_has_altmap_cb() then.

> +
> +		remove_memory_block_devices(cur_start, memblock_size);
> +
> +		arch_remove_memory(cur_start, memblock_size, altmap);
> +
> +		/* Verify that all vmemmap pages have actually been freed. */
> +		if (altmap) {

There must be an altmap, so this can be done unconditionally.

> +			WARN(altmap->alloc, "Altmap not fully unmapped");
> +			kfree(altmap);
> +		}
> +	}
> +}


-- 
Cheers,

David / dhildenb

