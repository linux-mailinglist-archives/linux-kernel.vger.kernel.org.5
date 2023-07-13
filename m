Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5247526BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjGMPYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGMPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8201FDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689261829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OrXHr74RvDod+ik6zQtn6PYHtQ5NhgYHW9MDtbsLAkQ=;
        b=HrxRu/cFcXVUk6oIuUzsGftPXbQW/j/XASNMFuqGK4RqRFE2x2GrJ8cirKDo0vCXcyWg+f
        40iv4pphyZ9dO3jFcLQs7gHq4pC3kWC7Z0GQcOQBlzR/0JiGPMGczlNUYZEtWqV5+jG+wI
        YJUFfSuwN0GQZrtyU9/9cO4YfU2IC7U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-CmeYjiglPqCTuAHL7baDqQ-1; Thu, 13 Jul 2023 11:23:48 -0400
X-MC-Unique: CmeYjiglPqCTuAHL7baDqQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc07d4c2f4so3626875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261827; x=1691853827;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrXHr74RvDod+ik6zQtn6PYHtQ5NhgYHW9MDtbsLAkQ=;
        b=Jpds/Gw/nCsSt1ty5L047TuRiiXtZgV+JqbRmBLXl89J2pN/1QzuWOlTi7A46RomtU
         4e2rxeUMjLS9FydxjPPvOjHXbIrjB1l3ryVOEmDTi7+6UGQapmsmtAllrfImZOrm87gZ
         VMZYYlTT1ln6L3gvLZnSLGYt7T91ThTeU6TGAcDBU12oitNGZkUPfGz765kYgAFrWbkO
         NCUYUwyJ7GX45dD7Irfc7krp/9UbTvRuU1Tjj0bQjJT3gZLIPPfohjxoEygqLQGqzBkk
         F/JlqtfV9Id2mqWGdJgxvYpu+oFUfIZULw9shQ6j1yuSwwNRbuFnZeJDgpdeFKzAyp+E
         hJVw==
X-Gm-Message-State: ABy/qLZZQA1d3c1BBmn1z5bveeLhbLHyldAa1xJbWMPbKYgn8WVJv3z1
        AUY1xkTz0hGf0VIL0G8HaRXD6GWZhnB7OYBGp3ZdDQpQOgr7wADocIyIhT4z/m81ynux4qpTTyJ
        9AKCe3hpaWHO0Z4bmFHEfLuXK
X-Received: by 2002:a05:600c:ad4:b0:3fb:415a:d07 with SMTP id c20-20020a05600c0ad400b003fb415a0d07mr2045780wmr.36.1689261826884;
        Thu, 13 Jul 2023 08:23:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVzG98bxoOW8OpwQX5TWHQDRqEPJSfAHvfo4PmjrcMBkfrXZyRmE2NOPG7xqFsB9gxJ6DcwA==
X-Received: by 2002:a05:600c:ad4:b0:3fb:415a:d07 with SMTP id c20-20020a05600c0ad400b003fb415a0d07mr2045757wmr.36.1689261826425;
        Thu, 13 Jul 2023 08:23:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fc07e1908csm8045051wmc.43.2023.07.13.08.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:23:46 -0700 (PDT)
Message-ID: <80c8654e-21fb-b187-3475-9a1410a53a4e@redhat.com>
Date:   Thu, 13 Jul 2023 17:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Content-Language: en-US
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
 <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
 <87edleplkn.fsf@linux.ibm.com>
 <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
 <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
 <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
 <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 17:15, Verma, Vishal L wrote:
> On Thu, 2023-07-13 at 09:23 +0200, David Hildenbrand wrote:
>> On 13.07.23 08:45, Verma, Vishal L wrote:
>>>
>>> I'm taking a shot at implementing the splitting internally in
>>> memory_hotplug.c. The caller (kmem) side does become trivial with this
>>> approach, but there's a slight complication if I don't have the module
>>> param override (patch 1 of this series).
>>>
>>> The kmem diff now looks like:
>>>
>>>      diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>      index 898ca9505754..8be932f63f90 100644
>>>      --- a/drivers/dax/kmem.c
>>>      +++ b/drivers/dax/kmem.c
>>>      @@ -105,6 +105,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>              data->mgid = rc;
>>>       
>>>              for (i = 0; i < dev_dax->nr_range; i++) {
>>>      +               mhp_t mhp_flags = MHP_NID_IS_MGID | MHP_MEMMAP_ON_MEMORY |
>>>      +                                 MHP_SPLIT_MEMBLOCKS;
>>>                      struct resource *res;
>>>                      struct range range;
>>>       
>>>      @@ -141,7 +143,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>                       * this as RAM automatically.
>>>                       */
>>>                      rc = add_memory_driver_managed(data->mgid, range.start,
>>>      -                               range_len(&range), kmem_name, MHP_NID_IS_MGID);
>>>      +                               range_len(&range), kmem_name, mhp_flags);
>>>       
>>>                      if (rc) {
>>>                              dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
>>>      
>>>
>>
>> Why do we need the MHP_SPLIT_MEMBLOCKS?
> 
> I thought we still wanted either an opt-in or opt-out for the kmem
> driver to be able to do memmap_on_memory, in case there were
> performance implications or the lack of 1GiB PUDs. I haven't
> implemented that yet, but I was thinking along the lines of a sysfs
> knob exposed by kmem, that controls setting of this new
> MHP_SPLIT_MEMBLOCKS flag.

Why is MHP_MEMMAP_ON_MEMORY not sufficient for that?

> 
>>
>> In add_memory_driver_managed(), if memmap_on_memory = 1 AND is effective for a
>> single memory block, you can simply split up internally, no?
>>
>> Essentially in add_memory_resource() something like
>>
>> if (mhp_flags & MHP_MEMMAP_ON_MEMORY &&
>>       mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
>>          for (cur_start = start, cur_start < start + size;
>>               cur_start += memory_block_size_bytes()) {
>>                  mhp_altmap.free = PHYS_PFN(memory_block_size_bytes());
>>                  mhp_altmap.base_pfn = PHYS_PFN(start);
>>                  params.altmap = &mhp_altmap;
>>
>>                  ret = arch_add_memory(nid, start,
>>                                        memory_block_size_bytes(), &params);
>>                  if (ret < 0) ...
>>
>>                  ret = create_memory_block_devices(start, memory_block_size_bytes(),
>>                                                    mhp_altmap.alloc, group);
>>                  if (ret) ...
>>                  
>>          }
>> } else {
>>          /* old boring stuff */
>> }
>>
>> Of course, doing it a bit cleaner, factoring out adding of mem+creating devices into
>> a helper so we can use it on the other path, avoiding repeating memory_block_size_bytes()
>> ...
> 
> My current approach was looping a level higher, on the call to
> add_memory_resource, but this looks reasonable too, and I can switch to
> this. In fact it is better as in my case I had to loop twice, once for
> the regular add_memory() path and once for the _driver_managed() path.
> Yours should avoid that.

As we only care about the altmap here, handling it for arch_add_memory() 
+ create_memory_block_devices() should be sufficient.

-- 
Cheers,

David / dhildenb

