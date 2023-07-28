Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67947767115
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjG1Pwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjG1Pwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F112681
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690559496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XHjZAePmFJB7+dA+KDoRXnwZZfqjqf+DFxLHYu/V8+Y=;
        b=HTMfHkGRpSSg9dn3XN3xiNdzaG985sYFhQC6VUd2AI1ceMdVDBExwW/L85twKjMGEgQ+Z+
        gVlNQZ8Kh3Pwjf85QgDDvDnEjAmX9y0v4xkgKH5SStZtb4whEryMtVQ39BD3TYwvkaahQI
        T2F9oNyGsdMnF9RAfyW7chbI3i347Lw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-go8QQOUsPUSoTnYceLmCEw-1; Fri, 28 Jul 2023 11:51:35 -0400
X-MC-Unique: go8QQOUsPUSoTnYceLmCEw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b961c3af8fso22581301fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559494; x=1691164294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHjZAePmFJB7+dA+KDoRXnwZZfqjqf+DFxLHYu/V8+Y=;
        b=KnZUwodyfcf8e5w6EX4PiZOUcq50MUnkjE2Fj0uA6xAq61o35oga0t4wZ4dRuAbjnt
         gJ8N437zOEoFAOQ+wZImcdJ3fEQ3xrTEmpnpltHUfzSjmm3jYwF3+3KkYuLHcVMPzyp3
         k9/IpgDIF3y83ZcpvOve+dMZYl0mbi/NBjNAkNqYYO81gFfpetpx0VVGKb4nx6skHUHm
         wNfhP3F4okA0b7ZVNeGf8pgtIRzQ1CUgYWysy0BwT0bqva9ZRLClXGPU3D9V7baniJRA
         8QYorToT0kkSk4d3sxMVPnoWSeypMHjhr/QWJBHbho1ywJrrctGkGL9haghjCs9nKyYf
         0GJQ==
X-Gm-Message-State: ABy/qLZonmc+JfBzqcsc7qhlj2Hzxu8AhERQB0Cfx7j8WcBmLXUlh37H
        DirSe+tK6BsgbmU7FDow/99tD+10Rla+dTbwWF+RtYUDAYQirTRs4d8Wnd3e88OXXTuEBnhCLNX
        QWBPgdivqupBbtCXqaIIsyXc=
X-Received: by 2002:a2e:7a05:0:b0:2b6:a763:5d13 with SMTP id v5-20020a2e7a05000000b002b6a7635d13mr2237735ljc.27.1690559494245;
        Fri, 28 Jul 2023 08:51:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1IH2y/C0/aauMFoLZ54Y6JUdd8x5e1dPvQVv6ncL6riabbGzqpGWrIy+c0v8Fm8IDAtP2FQ==
X-Received: by 2002:a2e:7a05:0:b0:2b6:a763:5d13 with SMTP id v5-20020a2e7a05000000b002b6a7635d13mr2237717ljc.27.1690559493884;
        Fri, 28 Jul 2023 08:51:33 -0700 (PDT)
Received: from [192.168.1.86] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id x12-20020a2e7c0c000000b002b6de6deb5asm1010431ljc.2.2023.07.28.08.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 08:51:33 -0700 (PDT)
Message-ID: <2ed29e83-3aab-712c-5290-a20faabccc0a@redhat.com>
Date:   Fri, 28 Jul 2023 18:51:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [External] Re: [v1 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT
 flag
Content-Language: en-US
To:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com, rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-5-usama.arif@bytedance.com>
 <55750855-0029-b10f-3317-e6ae4d89d492@redhat.com>
 <a684b0e8-4412-79c8-2926-7822b1163c15@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <a684b0e8-4412-79c8-2926-7822b1163c15@bytedance.com>
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


On 7/28/23 16:47, Usama Arif wrote:
>
>
> On 28/07/2023 05:30, Mika Penttilä wrote:
>> Hi,
>>
>> On 7/27/23 23:46, Usama Arif wrote:
>>
>>> For reserved memory regions marked with this flag,
>>> reserve_bootmem_region is not called during memmap_init_reserved_pages.
>>> This can be used to avoid struct page initialization for
>>> regions which won't need them, for e.g. hugepages with
>>> HVO enabled.
>>>
>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>> ---
>>>   include/linux/memblock.h |  7 +++++++
>>>   mm/memblock.c            | 32 ++++++++++++++++++++++++++------
>>>   2 files changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> index f71ff9f0ec81..7f9d06c08592 100644
>>> --- a/include/linux/memblock.h
>>> +++ b/include/linux/memblock.h
>>> @@ -47,6 +47,7 @@ enum memblock_flags {
>>>       MEMBLOCK_MIRROR        = 0x2,    /* mirrored region */
>>>       MEMBLOCK_NOMAP        = 0x4,    /* don't add to kernel direct 
>>> mapping */
>>>       MEMBLOCK_DRIVER_MANAGED = 0x8,    /* always detected via a 
>>> driver */
>>> +    MEMBLOCK_RSRV_NOINIT    = 0x10,    /* don't call 
>>> reserve_bootmem_region for this region */
>>>   };
>>>   /**
>>> @@ -125,6 +126,7 @@ int memblock_clear_hotplug(phys_addr_t base, 
>>> phys_addr_t size);
>>>   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>>>   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>>>   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>>> +int memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size);
>>>   void memblock_free_all(void);
>>>   void memblock_free(void *ptr, size_t size);
>>> @@ -259,6 +261,11 @@ static inline bool memblock_is_nomap(struct 
>>> memblock_region *m)
>>>       return m->flags & MEMBLOCK_NOMAP;
>>>   }
>>> +static inline bool memblock_is_noinit(struct memblock_region *m)
>>> +{
>>> +    return m->flags & MEMBLOCK_RSRV_NOINIT;
>>> +}
>>> +
>>>   static inline bool memblock_is_driver_managed(struct 
>>> memblock_region *m)
>>>   {
>>>       return m->flags & MEMBLOCK_DRIVER_MANAGED;
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 4fd431d16ef2..3a15708af3b6 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -997,6 +997,22 @@ int __init_memblock 
>>> memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>>>       return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
>>>   }
>>> +/**
>>> + * memblock_rsrv_mark_noinit - Mark a reserved memory region with 
>>> flag MEMBLOCK_RSRV_NOINIT.
>>> + * @base: the base phys addr of the region
>>> + * @size: the size of the region
>>> + *
>>> + * For memory regions marked with %MEMBLOCK_RSRV_NOINIT, 
>>> reserve_bootmem_region
>>> + * is not called during memmap_init_reserved_pages, hence struct 
>>> pages are not
>>> + * initialized for this region.
>>> + *
>>> + * Return: 0 on success, -errno on failure.
>>> + */
>>> +int __init_memblock memblock_rsrv_mark_noinit(phys_addr_t base, 
>>> phys_addr_t size)
>>> +{
>>> +    return memblock_setclr_flag(base, size, 1, 
>>> MEMBLOCK_RSRV_NOINIT, 1);
>>> +}
>>> +
>>>   static bool should_skip_region(struct memblock_type *type,
>>>                      struct memblock_region *m,
>>>                      int nid, int flags)
>>> @@ -2113,13 +2129,17 @@ static void __init 
>>> memmap_init_reserved_pages(void)
>>>           memblock_set_node(start, end, &memblock.reserved, nid);
>>>       }
>>> -    /* initialize struct pages for the reserved regions */
>>> +    /*
>>> +     * initialize struct pages for reserved regions that don't have
>>> +     * the MEMBLOCK_RSRV_NOINIT flag set
>>> +     */
>>>       for_each_reserved_mem_region(region) {
>>> -        nid = memblock_get_region_node(region);
>>> -        start = region->base;
>>> -        end = start + region->size;
>>> -
>>> -        reserve_bootmem_region(start, end, nid);
>>> +        if (!memblock_is_noinit(region)) {
>>> +            nid = memblock_get_region_node(region);
>>> +            start = region->base;
>>> +            end = start + region->size;
>>> +            reserve_bootmem_region(start, end, nid);
>>> +        }
>>>       }
>>>   }
>>
>> There's code like:
>>
>> static inline void free_vmemmap_page(struct page *page)
>> {
>>          if (PageReserved(page))
>>                  free_bootmem_page(page);
>>          else
>>                  __free_page(page);
>> }
>>
>> which depends on the PageReserved being in vmempages pages, so I 
>> think you can't skip that part?
>>
>
> free_vmemmap_page_list (free_vmemmap_page) is called on struct pages 
> (refer to as [1]) that point to memory *which contains* the struct 
> pages (refer to as [2]) for the hugepage. The above if 
> (!memblock_is_noinit(region)) to not reserve_bootmem_region is called 
> for the struct pages [2] for the hugepage. struct pages [1] are not 
> changed with my patch.
>
> As an experiment if I run the diff at the bottom with and without 
> these patches I get the same log "HugeTLB: reserved pages 4096, normal 
> pages 0", which means those struct pages are treated the same without 
> and without these patches. (Its 4096 as 262144 struct pages [2] per 
> hugepage * 64 bytes per struct page / PAGE_SIZE = 4096 struct pages [1] )
>
> Also should have mentioned in cover letter, I used cat /proc/meminfo 
> to make sure it was working as expected. Reserving 500 1G hugepages 
> with and without these patches when hugetlb_free_vmemmap=on
> MemTotal:       536207112 kB (511.4G)
>
> when hugetlb_free_vmemmap=off
> MemTotal:       528015112 kB (503G)
>
>
> The expectation is that for 500 1G hugepages, when using HVO we have a 
> saving of 16380K*500=~8GB which is what we see with and without those 
> patches (511.4G - 503G). These patches didnt affect these numbers.
>
>
You are right, thanks for the explanation!


--Mika




>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index b5b7834e0f42..bc0ec90552b7 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -208,6 +208,8 @@ static int vmemmap_remap_range(unsigned long 
> start, unsigned long end,
>         return 0;
>  }
>
> +static int i = 0, j = 0;
> +
>  /*
>   * Free a vmemmap page. A vmemmap page can be allocated from the 
> memblock
>   * allocator or buddy allocator. If the PG_reserved flag is set, it 
> means
> @@ -216,10 +218,14 @@ static int vmemmap_remap_range(unsigned long 
> start, unsigned long end,
>   */
>  static inline void free_vmemmap_page(struct page *page)
>  {
> -       if (PageReserved(page))
> +       if (PageReserved(page)) {
> +               i++;
>                 free_bootmem_page(page);
> -       else
> +       }
> +       else {
> +               j++;
>                 __free_page(page);
> +       }
>  }
>
>  /* Free a list of the vmemmap pages */
> @@ -380,6 +386,7 @@ static int vmemmap_remap_free(unsigned long start, 
> unsigned long end,
>
>         free_vmemmap_page_list(&vmemmap_pages);
>
> +       pr_err("reserved pages %u, normal pages %u", i, j);
>         return ret;
>  }
>
>
>
>
>
>> --Mika
>>
>>
>

