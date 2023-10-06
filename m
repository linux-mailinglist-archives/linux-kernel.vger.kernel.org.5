Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75BD7BB7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjJFMe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjJFMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42521CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696595616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kp2picVzpjCiZ5thzoNnS4NIffKCsvdoirWsfiXrjmU=;
        b=Dsy1O4s4pjitIvwNMlEbQcVUUJngbjIVMAT4kpJD/P0KhmAy1ElxGpekoc4rAVAhLgVeGa
        62gJO22noiYvqAfNgZWO0HUem1Su+SHhxlUo4etIGgeM5ZwxaemxM31dK1Yw+XvhGwuU/I
        X/qzCwz/jPL0W2KrTekBCGeRq+QyRq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-p4-yOYXoNoupVgZLPvhCmw-1; Fri, 06 Oct 2023 08:33:30 -0400
X-MC-Unique: p4-yOYXoNoupVgZLPvhCmw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-406710d9a4aso15180565e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595609; x=1697200409;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp2picVzpjCiZ5thzoNnS4NIffKCsvdoirWsfiXrjmU=;
        b=wtgYrw4Yp2zb0AMRaFfxeYA3RrWYLmF+NXuyqHlWMOmnQMl7TrNFxL5PSfTXrumS3Q
         2w4pzZtvR2iyEdrlSE+m2tZXO4VCe7z9hKcDn5OQyMMbKCWD0AfLu9YjuOircPaypXFH
         hw2itOiHIXnnclYkoHJpXRhvxVIDv2F6RcQK9cF6PLNfdkR/XgSScgRtGdPLvLwYYZHi
         18r4TVWrpRJfwVfLXGZE1PslPItVIfzj1Yz062pZN+LkakqtkZhs/UtJ8YhXiQzrJBDr
         XdGHwwQDp4glw3z3xcaZGHHE9sfT4ty8zJHybl97MapneSghfQb6BePb17rzr7AHG41r
         XsbQ==
X-Gm-Message-State: AOJu0YxSJjRDm71Xk/F3Po87yb1+AvIHYBWEyJAR9vW4eJTH8q2IwLDv
        8msqJJy+vX5jREoG5yZk+Z8uj85mj7hsLMZpXW67H39Fw/eHUe7Xg4flkygfYLxrnln9ELAkOKw
        VpsnpeSYZ3biF8QSFpQ+jEuNV
X-Received: by 2002:a7b:c84d:0:b0:3fa:934c:8356 with SMTP id c13-20020a7bc84d000000b003fa934c8356mr7567189wml.10.1696595609214;
        Fri, 06 Oct 2023 05:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+qbujoqL35rM+01e93eyEax/eUnX6DN6O6MIW9k5Yq00U138jBSP0b8qR2JxHr3nONKt2Og==
X-Received: by 2002:a7b:c84d:0:b0:3fa:934c:8356 with SMTP id c13-20020a7bc84d000000b003fa934c8356mr7567153wml.10.1696595608689;
        Fri, 06 Oct 2023 05:33:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b0040472ad9a3dsm3666144wmq.14.2023.10.06.05.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:33:28 -0700 (PDT)
Message-ID: <1d606139-9fff-a00e-c09b-587a8b6736f2@redhat.com>
Date:   Fri, 6 Oct 2023 14:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
 <20230928-vv-kmem_memmap-v4-1-6ff73fec519a@intel.com>
 <efe2acfd-f22f-f856-cd2a-32374af2053a@redhat.com>
 <7893b6a37a429e2f06f2b65009f044208f904b32.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7893b6a37a429e2f06f2b65009f044208f904b32.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.10.23 22:03, Verma, Vishal L wrote:
> On Mon, 2023-10-02 at 11:28 +0200, David Hildenbrand wrote:
>>
>>> +
>>> +static int __ref try_remove_memory(u64 start, u64 size)
>>> +{
>>> +       int rc, nid = NUMA_NO_NODE;
>>> +
>>> +       BUG_ON(check_hotplug_memory_range(start, size));
>>> +
>>> +       /*
>>> +        * All memory blocks must be offlined before removing memory.  Check
>>> +        * whether all memory blocks in question are offline and return error
>>> +        * if this is not the case.
>>> +        *
>>> +        * While at it, determine the nid. Note that if we'd have mixed nodes,
>>> +        * we'd only try to offline the last determined one -- which is good
>>> +        * enough for the cases we care about.
>>> +        */
>>> +       rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
>>> +       if (rc)
>>> +               return rc;
>>> +
>>> +       /*
>>> +        * For memmap_on_memory, the altmaps could have been added on
>>> +        * a per-memblock basis. Loop through the entire range if so,
>>> +        * and remove each memblock and its altmap.
>>> +        */
>>> +       if (mhp_memmap_on_memory()) {
>>> +               unsigned long memblock_size = memory_block_size_bytes();
>>> +               u64 cur_start;
>>> +
>>> +               for (cur_start = start; cur_start < start + size;
>>> +                    cur_start += memblock_size)
>>> +                       __try_remove_memory(nid, cur_start, memblock_size);
>>> +       } else {
>>> +               __try_remove_memory(nid, start, size);
>>> +       }
>>> +
>>>          return 0;
>>>    }
>>
>> Why is the firmware, memblock and nid handling not kept in this outer
>> function?
>>
>> We really shouldn't be doing per memory block what needs to be done per
>> memblock: remove_memory_block_devices() and arch_remove_memory().
> 
> 
> Ah yes makes sense since we only do create_memory_block_devices() and
> arch_add_memory() in the per memory block inner loop during addition.
> 
> How should the locking work in this case though?

Sorry, I had to process a family NMI the last couple of days.

> 
> The original code holds the mem_hotplug_begin() lock over
> arch_remove_memory() and all of the nid and memblock stuff. Should I
> just hold the lock and release it in the inner loop for each memory
> block, and then also acquire and release it separately for the memblock
> and nid stuff in the outer function?

I think we have to hold it over the whole operation.

I saw that you sent a v5, I'll comment there.


-- 
Cheers,

David / dhildenb

