Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C577BE3D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376350AbjJIPEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIPEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84879BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696863851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FIJV5lO3rRaNMrdiwXXrWFJSKEt+B99N6civGkJgdJ8=;
        b=Df3LLIf6mNC1yFW097zVdrUde4vDPud7SRpTRzT5rHEwP3nH/6TIAh2JI4L36QjD0XmshN
        pYjptmt2WOYsz8FkQXkg/+Mytu381xbz0VlPhXLxnYgrcMHj+JLNWaI71Q9IrJswExvXJw
        XXqKb4l0kXoEbhqqhfmnkrKJxrCMcro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-2_TVpK2gPL6g5TljF_bf2g-1; Mon, 09 Oct 2023 11:04:10 -0400
X-MC-Unique: 2_TVpK2gPL6g5TljF_bf2g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4067f186039so35256715e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863849; x=1697468649;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FIJV5lO3rRaNMrdiwXXrWFJSKEt+B99N6civGkJgdJ8=;
        b=qivzOmx7+owKdq6QfUj/URZkAImy5bS0Nmk5CFCQn0Fck3CNxIJz98tIGYsXMYkJOL
         V8vdG5KOmauvsKBNA2egVQG4D/pWI8h55K3WcT8SWSUI7Srjp0lqLF9wLd8alV8z91mS
         hKjHWOqTSh//22CEapMkR5dtm1XSArvWPtSOYpcjop/I1CQhRJOhO/b5qSkZmTKBBmFJ
         EnI4gJEprqrBlbUkaxbaMCHh3jQWy5qAkuEQgaNUQysbg6EG6P6zgX/vYXx23+7Jzms/
         eZAFtMiCGLaevjx1xpEorcojcBFBqvpIcSR9Xngex+nx9mXS7dq4h0Vbsp/y0k0ZZrZj
         CDtA==
X-Gm-Message-State: AOJu0Yy5vSX5j4TMtF4QMW8NVHNduLKCjIBeMnX/N4zOVlfhrXRIjW9z
        yrC2iwL9Bixp9ORi5+/eyNTy3zuoa+8InkPefybyrGuS1a0OUUFX/iLkiV+AqUF/MPZUGd7Uji+
        a/euMWR/uyELhZ6oewnngASyh
X-Received: by 2002:a05:600c:294a:b0:3f5:fff8:d4f3 with SMTP id n10-20020a05600c294a00b003f5fff8d4f3mr14342647wmd.7.1696863849011;
        Mon, 09 Oct 2023 08:04:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd9RipDWly03hWGjd4laSZlSBJMZLRx2QoWpiR6apw7eWoyMbijKUMNiw8aOtn3O0GrZjGoQ==
X-Received: by 2002:a05:600c:294a:b0:3f5:fff8:d4f3 with SMTP id n10-20020a05600c294a00b003f5fff8d4f3mr14342561wmd.7.1696863847471;
        Mon, 09 Oct 2023 08:04:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b004068de50c64sm11449371wmq.46.2023.10.09.08.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 08:04:06 -0700 (PDT)
Message-ID: <831b9b12-08fe-f5dc-f21d-83284b0aee8a@redhat.com>
Date:   Mon, 9 Oct 2023 17:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
 <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <87jzrylslk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.23 10:55, Huang, Ying wrote:
> Vishal Verma <vishal.l.verma@intel.com> writes:
> 
>> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
>> 'memblock_size' chunks of memory being added. Adding a larger span of
>> memory precludes memmap_on_memory semantics.
>>
>> For users of hotplug such as kmem, large amounts of memory might get
>> added from the CXL subsystem. In some cases, this amount may exceed the
>> available 'main memory' to store the memmap for the memory being added.
>> In this case, it is useful to have a way to place the memmap on the
>> memory being added, even if it means splitting the addition into
>> memblock-sized chunks.
>>
>> Change add_memory_resource() to loop over memblock-sized chunks of
>> memory if caller requested memmap_on_memory, and if other conditions for
>> it are met. Teach try_remove_memory() to also expect that a memory
>> range being removed might have been split up into memblock sized chunks,
>> and to loop through those as needed.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
>> ---
>>   mm/memory_hotplug.c | 162 ++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 99 insertions(+), 63 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index f8d3e7427e32..77ec6f15f943 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1380,6 +1380,44 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>>   	return arch_supports_memmap_on_memory(vmemmap_size);
>>   }
>>   
>> +static int add_memory_create_devices(int nid, struct memory_group *group,
>> +				     u64 start, u64 size, mhp_t mhp_flags)
>> +{
>> +	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
>> +	struct vmem_altmap mhp_altmap = {
>> +		.base_pfn =  PHYS_PFN(start),
>> +		.end_pfn  =  PHYS_PFN(start + size - 1),
>> +	};
>> +	int ret;
>> +
>> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
>> +		mhp_altmap.free = memory_block_memmap_on_memory_pages();
>> +		params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
>> +		if (!params.altmap)
>> +			return -ENOMEM;
>> +
>> +		memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
>> +	}
>> +
>> +	/* call arch's memory hotadd */
>> +	ret = arch_add_memory(nid, start, size, &params);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	/* create memory block devices after memory was added */
>> +	ret = create_memory_block_devices(start, size, params.altmap, group);
>> +	if (ret)
>> +		goto err_bdev;
>> +
>> +	return 0;
>> +
>> +err_bdev:
>> +	arch_remove_memory(start, size, NULL);
>> +error:
>> +	kfree(params.altmap);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
>>    * and online/offline operations (triggered e.g. by sysfs).
>> @@ -1388,14 +1426,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
>>    */
>>   int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>   {
>> -	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
>> +	unsigned long memblock_size = memory_block_size_bytes();
>>   	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
>> -	struct vmem_altmap mhp_altmap = {
>> -		.base_pfn =  PHYS_PFN(res->start),
>> -		.end_pfn  =  PHYS_PFN(res->end),
>> -	};
>>   	struct memory_group *group = NULL;
>> -	u64 start, size;
>> +	u64 start, size, cur_start;
>>   	bool new_node = false;
>>   	int ret;
>>   
>> @@ -1436,28 +1470,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>   	/*
>>   	 * Self hosted memmap array
>>   	 */
>> -	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
>> -		if (mhp_supports_memmap_on_memory(size)) {
>> -			mhp_altmap.free = memory_block_memmap_on_memory_pages();
>> -			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
>> -			if (!params.altmap)
>> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
>> +	    mhp_supports_memmap_on_memory(memblock_size)) {
>> +		for (cur_start = start; cur_start < start + size;
>> +		     cur_start += memblock_size) {
>> +			ret = add_memory_create_devices(nid, group, cur_start,
>> +							memblock_size,
>> +							mhp_flags);
>> +			if (ret)
>>   				goto error;
>> -
>> -			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
>>   		}
>> -		/* fallback to not using altmap  */
>> -	}
>> -
>> -	/* call arch's memory hotadd */
>> -	ret = arch_add_memory(nid, start, size, &params);
>> -	if (ret < 0)
>> -		goto error_free;
>> -
>> -	/* create memory block devices after memory was added */
>> -	ret = create_memory_block_devices(start, size, params.altmap, group);
>> -	if (ret) {
>> -		arch_remove_memory(start, size, NULL);
>> -		goto error_free;
>> +	} else {
>> +		ret = add_memory_create_devices(nid, group, start, size,
>> +						mhp_flags);
>> +		if (ret)
>> +			goto error;
>>   	}
>>   
>>   	if (new_node) {
>> @@ -1494,8 +1521,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>>   		walk_memory_blocks(start, size, NULL, online_memory_block);
>>   
>>   	return ret;
>> -error_free:
>> -	kfree(params.altmap);
>>   error:
>>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>>   		memblock_remove(start, size);
>> @@ -2146,12 +2171,41 @@ void try_offline_node(int nid)
>>   }
>>   EXPORT_SYMBOL(try_offline_node);
>>   
>> -static int __ref try_remove_memory(u64 start, u64 size)
>> +static void __ref remove_memory_block_and_altmap(int nid, u64 start, u64 size)
>>   {
>> +	int rc = 0;
>>   	struct memory_block *mem;
>> -	int rc = 0, nid = NUMA_NO_NODE;
>>   	struct vmem_altmap *altmap = NULL;
>>   
>> +	rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
>> +	if (rc) {
>> +		altmap = mem->altmap;
>> +		/*
>> +		 * Mark altmap NULL so that we can add a debug
>> +		 * check on memblock free.
>> +		 */
>> +		mem->altmap = NULL;
>> +	}
>> +
>> +	/*
>> +	 * Memory block device removal under the device_hotplug_lock is
>> +	 * a barrier against racing online attempts.
>> +	 */
>> +	remove_memory_block_devices(start, size);
>> +
>> +	arch_remove_memory(start, size, altmap);
>> +
>> +	/* Verify that all vmemmap pages have actually been freed. */
>> +	if (altmap) {
>> +		WARN(altmap->alloc, "Altmap not fully unmapped");
>> +		kfree(altmap);
>> +	}
>> +}
>> +
>> +static int __ref try_remove_memory(u64 start, u64 size)
>> +{
>> +	int rc, nid = NUMA_NO_NODE;
>> +
>>   	BUG_ON(check_hotplug_memory_range(start, size));
>>   
>>   	/*
>> @@ -2167,47 +2221,28 @@ static int __ref try_remove_memory(u64 start, u64 size)
>>   	if (rc)
>>   		return rc;
>>   
>> +	mem_hotplug_begin();
>> +
>>   	/*
>> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
>> -	 * the same granularity it was added - a single memory block.
>> +	 * For memmap_on_memory, the altmaps could have been added on
>> +	 * a per-memblock basis. Loop through the entire range if so,
>> +	 * and remove each memblock and its altmap.
>>   	 */
>>   	if (mhp_memmap_on_memory()) {
> 
> IIUC, even if mhp_memmap_on_memory() returns true, it's still possible
> that the memmap is put in DRAM after [2/2].  So that,
> arch_remove_memory() are called for each memory block unnecessarily.  Can
> we detect this (via altmap?) and call remove_memory_block_and_altmap()
> for the whole range?

Good point. We should handle memblock-per-memblock onny if we have to 
handle the altmap. Otherwise, just call a separate function that doesn't 
care about -- e.g., called remove_memory_blocks_no_altmap().

We could simply walk all memory blocks and make sure either all have an 
altmap or none has an altmap. If there is a mix, we should bail out with 
WARN_ON_ONCE().

-- 
Cheers,

David / dhildenb

